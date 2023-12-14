Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405CD8139A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573096AbjLNSOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444246AbjLNSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:14:00 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E31135
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:14:01 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50c05ea5805so9957463e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577640; x=1703182440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jeq677NEMB1IsnQAjs4/+yBvpQgDXfs4klZEe8r6nwY=;
        b=rypMenmuMdO1QbcrihnIVf2JXPhpJGZC0ibYEr6hPjfqhNVsru9owGy6iOLu+yWQZL
         6YzMN7WOwW1eoSfh/nzVhcIHwvdVc+LzkGmE9/+PtO6s8Tet+9a7HJ8DOH9Wt89Vco6R
         x2vXDNlr2A6pinNEripZvIn2kBch+KxLIqTlxBuDKMqiAmfKtoaBoa/0LK1eu+wpa1/5
         fwpYE1DeQ4yc4jrGiaDL4ppnA2wxA7ikfnNZU5Fi+SzyTf8UU5ZoJZbYRUm20l8s384y
         r0MKAW+DxWsUi+BfQM+O/mH4y73+XHEscyElcWqMo5IM8VyhoEfCRb+plNMIKHvBvclt
         Js4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577640; x=1703182440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jeq677NEMB1IsnQAjs4/+yBvpQgDXfs4klZEe8r6nwY=;
        b=Yf+smTlYvLIBmEvMod7Cus2JAU5OodUFdAPq/fHAbLXmdyIcwwuOoHwBx/oxq8jrRn
         ViHcRZZPi/OESE+7WN7m5zRi4a3uccMkuB9Pv8eqAm1t6C/fJW3lEl2xgZHFHiQhF4Nf
         BF69Gv4QubTd7KarQ8Xy6NiESW1jfRnt7fYTVGN3dWN2tMOOFl0fNJXsrDw2gW9jHOP4
         XpwsL8jkZakkVYx+H+mSAH2qjX78KS/39WLUGK2Ro13qRRE9tqYoa4TyrIkk6IIZHV/e
         G8t5eXRqK+CJ/iJjzB6je6CH33xyKvhtprzt5gl87PGHiK7B6TxrCQi5CQNNrdFgMTYL
         bwkg==
X-Gm-Message-State: AOJu0YwaqgkRtS5R9voyHBYcwpUs1zP0su4Ryv0c7bIqWaOLkRu4wBPX
        3/+78Cb4jkV4UpQcv+8e00HgKkN4Hbptq/fs5evjEVZh
X-Google-Smtp-Source: AGHT+IH+63IBJ9rieYmdKRPNhHxIM+WiKLHtfWsJ9OIE/+7mq19A5B8k4ZmO4Euqa6cdaiIKAp6nLg==
X-Received: by 2002:a19:e043:0:b0:50e:17df:a992 with SMTP id g3-20020a19e043000000b0050e17dfa992mr815321lfj.33.1702577640041;
        Thu, 14 Dec 2023 10:14:00 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n11-20020a0565120acb00b0050be6038170sm1928838lfu.48.2023.12.14.10.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:13:59 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 14 Dec 2023 19:13:43 +0100
Subject: [PATCH 6/6] arm64: dts: qcom: sc8180x-primus: Allow UFS regulators
 load/mode setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-sc8180_fixes-v1-6-421904863006@linaro.org>
References: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
In-Reply-To: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Gustave Monce <gustave.monce@outlook.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS driver expects to be able to set load (and by extension, mode)
on the supplied regulators. Add the necessary properties to make that
possible.

Fixes: 2ce38cc1e8fe ("arm64: dts: qcom: sc8180x: Introduce Primus")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index adddf360c7fc..bfee60c93ccc 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -386,12 +386,18 @@ vreg_l7e_1p8: ldo7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
 		};
 
 		vreg_l10e_2p9: ldo10 {
 			regulator-min-microvolt = <2904000>;
 			regulator-max-microvolt = <2904000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
 		};
 
 		vreg_l12e: ldo12 {

-- 
2.40.1

