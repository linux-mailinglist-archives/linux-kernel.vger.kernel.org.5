Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8823075CC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjGUPhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjGUPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:36:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625ED3C0F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f122ff663eso3271464e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689953789; x=1690558589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THWAX3w743THTEhVYC5N88ez3dLwO2Lk8YrPTbQ2uWQ=;
        b=Zc2pDHMnn+104eUpBLq+IK/vl5PgS4HF7L9+eNw2EtkAJcuH8mb9D7G/BuWx0gcFvu
         06uV3Id7PyGHg/C/ZDo7AnVSBj+w2NMPvzZRSCh49MShJQ17hgRrRpV9FHGZd6kAZoOW
         4dsrtaeQupndBerbg8lRZ+NmIEUgN5/1HJGLHD337h9neNPms1bRaZrUW9HNKxxPuG1n
         msWDEuhsrAPu67IyYMdsYgCLANkqzLZS+o7iXhgXamtXqrySAbaYa7KlFgcPG5+JuGkJ
         QLi9jy4o9EMOXL65mRewfPQW56Z+WbE93NUTmQ+Uc1dfDE0XA1p9JxmEXNziaUSqBgC3
         igXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953789; x=1690558589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THWAX3w743THTEhVYC5N88ez3dLwO2Lk8YrPTbQ2uWQ=;
        b=YJs7DhUXK+UZbChxk4n3Xto33fnU4dOCz0Utdk0aS76zRwF2r1/sYmqzEgkSkam8S9
         NzXWcGvEG5X4pkNhkcehRVY9CKB6l3SaAvVGr1hj1zxMaHPkGxjvg3cg2ki2W8/1Xm2M
         yYwFHgzzIQmxE2vxkFSRf+ct1+uQGIQfZhd74owR6R5vlN0MPKe9SQN60vqV1+YR74ZB
         /OYQQApneOwFJrlhhRXqav/jg7Kd5VTUuAF0hBsupG93oVC96PCbYiECEm8MCucKcF7H
         wamv3noncl70VtoiCmq8ua77ETRF5dVWK0HMc3jqABjsdkEBQSLXyK3K0CMx5wuF/R/s
         eQsg==
X-Gm-Message-State: ABy/qLaXan/sE7aRRjeKCIBJzfK36hDdUaFYzhrh+AanzNazE7w8HB7u
        F0yGYe18FSN8QXm5ujdpErOk5A==
X-Google-Smtp-Source: APBJJlE8tpqE68Oa+XHHjtZnlNpYARNe7ZorUHlBo3TbY1Bh9Wv1LCKQTVObw/kEzFp/FWmN5Cq0aw==
X-Received: by 2002:a05:6512:702:b0:4f9:556b:93c5 with SMTP id b2-20020a056512070200b004f9556b93c5mr1625835lfs.40.1689953789515;
        Fri, 21 Jul 2023 08:36:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004fba1278e6dsm782535lfc.107.2023.07.21.08.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:36:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 17:36:14 +0200
Subject: [PATCH 11/11] arm64: dts: qcom: msm8996: Remove PNoC clock from
 MSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v1-11-cf6cd5c621d5@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689953767; l=1234;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xqAfmjv9xDFyldEQr9RhjbH5IIr8X8QxVfvrmazKooA=;
 b=3lyZ2+1Q8TRZMiUiZuvJKYOES//5KM1Ad8U/fm+UjV9QIYWZex0N+CGh9q2FjP3VxOyVP4X9x
 SNYkK+emC8NCHZ7e5boM8NG4dOLFGKHU+EMOdAT7h56v4f3Yy/xClW+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PNoC clock is a clock for the entire PNoC bus, managed from
within the interconnect driver. Attaching it to MSS was a total hack.
Get rid of it and take the liberty to make the clock-names entries
more readable.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index ea383cf178e5..3526a88bfa5f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2479,10 +2479,15 @@ mss_pil: remoteproc@2080000 {
 				 <&gcc GCC_MSS_GPLL0_DIV_CLK>,
 				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
 				 <&gcc GCC_MSS_MNOC_BIMC_AXI_CLK>,
-				 <&rpmcc RPM_SMD_PCNOC_CLK>,
 				 <&rpmcc RPM_SMD_QDSS_CLK>;
-			clock-names = "iface", "bus", "mem", "xo", "gpll0_mss",
-				      "snoc_axi", "mnoc_axi", "pnoc", "qdss";
+			clock-names = "iface",
+				      "bus",
+				      "mem",
+				      "xo",
+				      "gpll0_mss",
+				      "snoc_axi",
+				      "mnoc_axi",
+				      "qdss";
 
 			resets = <&gcc GCC_MSS_RESTART>;
 			reset-names = "mss_restart";

-- 
2.41.0

