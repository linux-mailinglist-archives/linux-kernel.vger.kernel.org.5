Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77274792598
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbjIEQIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354658AbjIENTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:19:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725C019B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:19:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so23504545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693919975; x=1694524775; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt9tVAiTcer6vSiY1dS+0tybBONJfccdepDVV223CNg=;
        b=QTrmII+0OSJjlDe1G+CHY5lyJm5NPfzS+v7D1DP4hPP3ck3iQo8lzE6Nte0/XYUXW8
         M2l2VMM72UZDfymLIBx1ZSgoLBz2bRrrhgQdj7NgJ0bjH3XcABt7pDsqoAO3jAR8Y4Db
         JZ/UjNUsGFERJY6MtOdwkCB8K3epqwVQ2AjO+enlmZEwl8nm5KAEnY7lQbI5ZIYlbwfK
         8Vytve4VsyyHEn38asPI1I25PnsNy+wG7PQcrGpvn1w3GrqPbNGcwdcH2KLSOODY4cuE
         /RYLgcwsm4ykcvtOGb1JMOhglmKc2EgrW/RT0nauytS3xibhgOMKO1Io0SQziyOqfeFg
         Dekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693919975; x=1694524775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt9tVAiTcer6vSiY1dS+0tybBONJfccdepDVV223CNg=;
        b=O42rilS698625skNjJhMUva4tZhIb61n2XitTpfflmqJMp3sz8zcuP+VSXgeaFxlId
         psKOmqnDYCUUJABZZjt+dnxD6EYyiLLcfDQRCdJLWirFOY3ZEWul70QhrAiYVbLIg2PK
         rVPGyxqJH/R7r+bhYwzYPQiCwtEsLiqIp/wPSXdG5Co4W51BTCWDXSENhi+bvEJzyQI2
         4Ay8Q32/04G8+AF2y07PsZLgnEHIequrivAih1Wss+BD/rD32lDcjZPyuADbIoFpAI3j
         BjiAQePzW+8NMJzP4J1WKRYT3aZfaMnG5pJU/+Z8Z9fyBh4ixncLtzNsd+dUuJ3xO9Xa
         56gQ==
X-Gm-Message-State: AOJu0YyUybz3N8pOFOKJAoGVitDP93j5VVhwnvljvwpNezyTBNW1NOp9
        wJOqt57fz003+Vu3LkoVuUj6yyYJmP3mUjvOYunNQQ==
X-Google-Smtp-Source: AGHT+IEw84e/ZYiVm0yej0VHpRTmpeibIbqcBXHzgr5HdFPnqtbWU6wP6UgihDgJm52YPOZACQFtaQ==
X-Received: by 2002:a05:600c:ac1:b0:3fe:22a9:900 with SMTP id c1-20020a05600c0ac100b003fe22a90900mr9875136wmr.3.1693919974136;
        Tue, 05 Sep 2023 06:19:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003fe61c33df5sm20131063wmj.3.2023.09.05.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 06:19:33 -0700 (PDT)
From:   neil.armstrong@linaro.org
Date:   Tue, 05 Sep 2023 15:19:26 +0200
Subject: [PATCH v4 2/2] arm64: dts: qcom: sm8150: extend the size of the
 PDC resource
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-topic-sm8x50-upstream-pdc-ver-v4-2-fc633c7df84b@linaro.org>
References: <20230905-topic-sm8x50-upstream-pdc-ver-v4-0-fc633c7df84b@linaro.org>
In-Reply-To: <20230905-topic-sm8x50-upstream-pdc-ver-v4-0-fc633c7df84b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mTDtod7kdTiTlPh4vpsoYzFiWJiMaLInaOQmnpmP2t4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk9yrhTS/wtdDRxFj1pV2mDZUXfUDQL2gRYQLTRlxJ
 /WaC+t2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZPcq4QAKCRB33NvayMhJ0Z3xEA
 Crs9MZvaPi48o5PIWr69LaRkximCEqFSbP5wKUt3kPtXFGR0Lpf3aLld64DSwfUmWjrybUra1lGpo5
 MGnbcz/E93cvyPEKuRZE7X2BSoERNVicvnNNvsK/5lqOBnMqYNXjda/szDEyWWZupyBBI0dA0VYoHH
 pi6ZnwCCWDcxHtAu5OpUEPOEeYRJL5ARV9i9U5zzpeVRtLhPEhELUOF5jAnXRc00Uihz7bYhp0Dkri
 gg3Q0QdFp2DT/+QF6qcIieEwLvjcLw7+BlDMs6heWThi7e4/m0wYrsyYdOw1ybIc7oET7dnhU2nHEM
 Fw9CZ8K7ZXDji3/7CNzYRLEtnbAGNANPWLjrkra4hw26sIpa6VBVM0CMc/GqBYSzCqzpwad1uiJHM9
 DzOTqcvuQ0EispUfNPV+XdtBqAv6Ux9e70aXtqcVB32ZGmJ0Wpw7mE8HLabAJ3PjhH8vMOnV5obCBx
 sukQHRtL0Bof8mRIXb3Yek9Jpd3iFbvc6HPaUHAczjsVlQamfJa2/vj3b3Qf1A8rqqBfNaiUCPSU3j
 GvNIFasaz902soLBggvV5hMnLJ1uBBB3TtKw3zQUWudQB37hIMLQnMegAnYPq2qOYy4525GVbL27h+
 lEOEzr6tgzj1Quv94TLoc3ZeVdPo+wFLAKTWxConVeDaoHHfqFNvF/95FEKQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Follow the example of other platforms and extend the PDC resource region
to 0x30000, so that the PDC driver can read the PDC_VERSION register.

Fixes: 397ad94668c1 ("arm64: dts: qcom: sm8150: Add pdc interrupt controller node")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a7c3020a5de4..06c53000bb74 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3958,7 +3958,7 @@ dispcc: clock-controller@af00000 {
 
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8150-pdc", "qcom,pdc";
-			reg = <0 0x0b220000 0 0x400>;
+			reg = <0 0x0b220000 0 0x30000>;
 			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
 					  <125 63 1>;
 			#interrupt-cells = <2>;

-- 
2.34.1

