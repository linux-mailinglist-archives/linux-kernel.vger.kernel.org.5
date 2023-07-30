Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF227686E3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjG3RuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjG3RuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:50:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5481721
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:49:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9923833737eso549244366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690739397; x=1691344197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87/hc2oBNjx7AA5ml7v6DGG7KmXPNmXMrKuNLd+Cam8=;
        b=KoV2A2S2VXihDWH28FFjmqkUNx/7SLTAOrGQ9wnBcM/91bkK7BGhEUgOU3A4YRpAHu
         dJHmJ+Y2wCvhqHn/GFCq7xOaRBaQdqwBh1FV9dn2tpiCptiSA23cENGKBHI50c7j42c8
         zHDoYmWAkI6fvZBhdFAWZAeT9MB1s63jqNcp1YCX0fPeHJ1mZz06G6JVrVgAn8LylstE
         kGitWH3MJv6EO+FgkC2GiJJpfsAP2jMvCMLrSHYJMXnGeO84O4A67jJquVk7Mj5xc2Yg
         MpWuz0Tzd/qdZIsNHAWWVvdaMvc0xwoKF6vBjW6ijQ3P3rQ5caw9gZQ9JKV6E3jr1HdK
         cSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690739397; x=1691344197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87/hc2oBNjx7AA5ml7v6DGG7KmXPNmXMrKuNLd+Cam8=;
        b=BFUchv/kRVO8aLr7S6yeHpzrfbdMSJ9gauFVSsj9NN5Cc0PdZenhjk4sqWJyPpP/mE
         c6qeDXJYoaO3A2sXqRWBuT0seFG/qRMgWk9bstDCe3z2PVl0JHrPnRGSlnWA4QODuaqb
         oCm67HFyBZTU84rFNWpiZgmMyVpwnyjJQ0yFMKLduPl9eXxO/y9gQ+CudXh15ixp3vKZ
         4rwVCt3pSKd+9DCnG6CcJ9Veaj/t38BGr6cs+KjxQSiLN/hjEEnKvZfRd8sB4+nSCSUG
         F6BA6qEtsuAzmtNeCUPWv6Br83qr7F0EfbPso0tDyV+pgT5M3Yu0t5sfS96U3I75j7gb
         chDg==
X-Gm-Message-State: ABy/qLagw+a7/JDmm29Zx9H1n0whmGE8cGEGetNv2xxU1eriKyRv6wFJ
        NNwcnl4y6/V33PCY0RAFsGQYog==
X-Google-Smtp-Source: APBJJlG9GR8kO2Ji9RE+Ttxw2a12BgviIbh3tv8s6bTvtxdn1bX+lNclOz8m8RLw+QWanNdxGK79MA==
X-Received: by 2002:a17:906:7791:b0:994:34a2:8727 with SMTP id s17-20020a170906779100b0099434a28727mr5204356ejm.41.1690739397336;
        Sun, 30 Jul 2023 10:49:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906495300b00992c4103cb5sm4913537ejt.129.2023.07.30.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 10:49:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] ARM: dts: st: stm32mp157c-emstamp: drop incorrect vref_ddr property
Date:   Sun, 30 Jul 2023 19:49:51 +0200
Message-Id: <20230730174954.5293-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STPMIC1 PMIC vref_ddr regulator does not support over-current
protection, according to bindings and Linux driver:

  stm32mp157c-emsbc-argon.dtb: stpmic@33: regulators:vref_ddr: 'regulator-over-current-protection' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. None
---
 arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
index fd89542c69c9..f8e9980ed3d4 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
@@ -310,7 +310,6 @@ vdda: ldo6 {
 			vref_ddr: vref_ddr {
 				regulator-name = "vref_ddr";
 				regulator-always-on;
-				regulator-over-current-protection;
 			};
 
 			bst_out: boost {
-- 
2.34.1

