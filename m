Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B06A7FF30B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346178AbjK3O6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346145AbjK3O6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:58:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A49D46
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:58:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bc743c7f7so1451232e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701356309; x=1701961109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xng1xwZB9cDO1oxrLqlkI81HPzaBItT+WlRJtOG/UQY=;
        b=gSQCn9/Kj+Q2++oa+g2hXO8D6AOqX0cO28IQru+PXP+64EkkbKw9SUWP0AVi8Sgk1Q
         cCKkJ15RAHUUTamtLIYBL7NqmrkAoWPYIK12sz7/ooPEvrDxutJFgB0Tec11jm5rgowX
         2in1k2ja0TxzaOmN7BUth4TiYqwPX+zCm/NeBmXodfEN/nDcgZdjZcy7hNkjA3x/fXSs
         PCKqxZ6qLjkzNzCiVX152Vg3yr79C7//vpOfYoq5O+q0pYwcycrsK9TjbufhBu8UMrot
         U0PF/BQHJiUkrHXUvZ4o8DRq4NLNcj1u6sPZ17nm7BHoYf62gRHsDrPotsX6CNJ4JKee
         k2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356309; x=1701961109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xng1xwZB9cDO1oxrLqlkI81HPzaBItT+WlRJtOG/UQY=;
        b=wJZqgP6cjXWGyTS5ISsdYRyv83PibvRcxp0y3CttAnH+QXKquCuzBajc+r8tyGBYVk
         vMg4BjJ4NlQ19aGqLhaivdwTmjJM1mwmPw0RtW7jL6VR3QzG6zl6QWFq5m0/KXHrzSC7
         jVetPLmzrHDl5izghJ1J4kn+YRrnvFO5xQYm3VZot2A7L49XRVIHZxPbPdM1jehHsiUy
         hQmwerknVpIs8RsUJpY0hpgrHP+LHhvENTaTKObhprbc4eu991jPvRmCrCduGYEnoLDi
         Jctai9GQLdc4NnfNSQT4qoy3fY7I4OHuym9jkZgVPmGchE4zRdMvRMoyZz19t3DKKrAx
         tZpw==
X-Gm-Message-State: AOJu0Yx37piFWdARd+rAvbovazHffqeH09ygz43RUGfobdhdpq1gAP0d
        DgkGQpfz3qIqewWRQhHUKIpmRQ==
X-Google-Smtp-Source: AGHT+IE+x0e6fM2Sld54pRVkxjJM0Ov342/SGbgVbHrX1CbFqfvVdau9Bl5nKdVgEzg5dvCwFQjQng==
X-Received: by 2002:a19:5510:0:b0:50b:d48a:4485 with SMTP id n16-20020a195510000000b0050bd48a4485mr463550lfe.57.1701356309027;
        Thu, 30 Nov 2023 06:58:29 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090640c500b009e50ea0a05asm756753ejk.99.2023.11.30.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:58:28 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 30 Nov 2023 15:58:23 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add QMP handle to RPMh
 stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-topic-ddr_sleep_stats-v1-3-5981c2e764b6@linaro.org>
References: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
In-Reply-To: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701356302; l=709;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AdWzrO0qrOnMAL7Fi5VjoxkzGyXFuWjhYPFtxK0xg6A=;
 b=AOeNm9HNFQg94wdn21vQ88b2ZtoR2PkMw/FDhSytFW6ofC/cn5rDkJdLl57t9V3DoU8/byEyl
 jSL7fXlgnhsAnj/L1fYzA5SSjThWYVloBRvdBQCScrgz3mZk215xgC9
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a handle to QMP is accessible, we can query even more internal
power management stats. Add it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index cad59af7ccef..38cc823c9c87 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4030,6 +4030,7 @@ aoss_qmp: power-management@c300000 {
 		sram@c3f0000 {
 			compatible = "qcom,rpmh-stats";
 			reg = <0 0x0c3f0000 0 0x400>;
+			qcom,qmp = <&aoss_qmp>;
 		};
 
 		spmi_bus: spmi@c440000 {

-- 
2.43.0

