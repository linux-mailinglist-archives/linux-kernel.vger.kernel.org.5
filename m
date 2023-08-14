Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE05277BA04
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHNN3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjHNN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:28:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6750ED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:28:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-99bf3f59905so576830066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1692019730; x=1692624530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi+e70M73VVW2/UtI8fzsCmgrtCHD4hmR1usrA9vrWg=;
        b=hRjTej0q1SmXQ7RxhrPKq8YxYbEMwHfR0pOBtW0MqlX96YJDiK3xC8512YI5hhW9YH
         G+I4elnqAjpQG7Sf/wlM+p8Mh3ySSN7OoT8aXmXFSy0fZ32DsfVBgrTPesgabKvqxqT0
         5v6z9pIF4LORwWFmKVpX4kX+Uh4n9Ejgs5Hdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019730; x=1692624530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi+e70M73VVW2/UtI8fzsCmgrtCHD4hmR1usrA9vrWg=;
        b=iP3nNDRlmqjYLznF4G7fE+Rbrnc/+Y4jSStgdZAR3svBVAn112HCXEMf9EmAz+YPWB
         TWxxNVCyRo9uyD47U5zx6IayVb0UrNFsX7QAZgqMYPExBfh1Kt2x9ccGXE/nbmb8Rp92
         iMP/vcZMSPFvqoJlf3Hkuo9Z+ufdx++TtlnA2rIyAoGYgNul+vrtlNcHeGP0Lak36KYX
         CdW+nRmTsFjbKLLEt6SvQytXwYEd6HVVQCbxdctRyDZIjmeq8ZiQ6F0NC0wHveYJhkPV
         RqXNHBM74VMdGWVMc9c6LJ664AgaUow8D6xnrsVauPy4hfsLTnHc1qKb19X0zJgKs3p8
         S9Bw==
X-Gm-Message-State: AOJu0YzfhzAXulawYLae2ERvgTcZnIyPXnBZuir6hkoaFpWVOQMeHC9A
        3JcuebfzXJVTLhNVtPCUi+CTJ8d8pzgTVqUxtwIJ/cdk
X-Google-Smtp-Source: AGHT+IHrCP+Ek6oNlG/yQRyJ8LYtU5jUKojVKzaEqEERLy+EkTSqFiav5MqrYVecHq8cJE7AIwBDng==
X-Received: by 2002:a17:907:2c47:b0:99c:980:d551 with SMTP id hf7-20020a1709072c4700b0099c0980d551mr7499548ejc.50.1692019729998;
        Mon, 14 Aug 2023 06:28:49 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-204.pool80180.interbusiness.it. [80.180.23.204])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906248300b0099d02ca4327sm5662066ejb.54.2023.08.14.06.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:28:49 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v8 1/4] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Date:   Mon, 14 Aug 2023 15:28:41 +0200
Message-Id: <20230814132844.113312-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814132844.113312-1-dario.binacchi@amarulasolutions.com>
References: <20230814132844.113312-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LTDC (Lcd-tft Display Controller) support.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

---

(no changes since v7)

Changes in v7:
- Add 'Reviewed-by' tag I forgot in v6.
  https://lore.kernel.org/linux-arm-kernel/20230629083726.84910-1-dario.binacchi@amarulasolutions.com/T/

 arch/arm/boot/dts/st/stm32f746.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
index d1802efd067c..36eda1562e83 100644
--- a/arch/arm/boot/dts/st/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -507,6 +507,16 @@ pwm {
 			};
 		};
 
+		ltdc: display-controller@40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+			status = "disabled";
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
-- 
2.34.1

