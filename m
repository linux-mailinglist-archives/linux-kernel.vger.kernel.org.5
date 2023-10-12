Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E37C694A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjJLJRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjJLJRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:17:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF9C4;
        Thu, 12 Oct 2023 02:17:38 -0700 (PDT)
Date:   Thu, 12 Oct 2023 11:17:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697102257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=WrpWweFctaGuqGTjzQmqJPAe/tzvOWQyUllY4p36/sU=;
        b=N6xO3EvIpHA7v2pMnc1xZ2MwWpT+J1hkZqjiu6u6jDDy4w/ba+h2IOG58SkcgyVHY42ZqF
        Si/11M+Owjl5DMiUFIoS3VLk5/0uWbcZ/LOD2Qma+8tHll/rtCO6LZ/Lt0bUG0TsXMndh+
        B+DFNuFI92Ew08DjzQx6YKiTcgZ1jbkLIfYTl+7AhGdWhs1wuk2KWW7uNnlekFQYS0ckC3
        Y/CCXBdd2CC2kab8s+GjFA794Mj1V/Uf/h/fN0QgssbRnHlknNR7yLxF1Hx3plSVU3/QM9
        sa8IUXcIM0URaned6yS74g7zcAd7yAUvUFR1ZHh5fDFiVxVl16TFEZdyROzljQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697102257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=WrpWweFctaGuqGTjzQmqJPAe/tzvOWQyUllY4p36/sU=;
        b=PeyuHQZhK5rfrboNA5NQ+J47gFzCvP+U5By4znwRCkm7RlCsYM5y9TLYwa4VWUXIfRcKpt
        p488rxrcanFZt2Aw==
From:   Nam Cao <namcao@linutronix.de>
To:     kernel@esmil.dk, conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        william.qiu@starfivetech.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: dts: starfive: visionfive 2: correct spi's ss pin
Message-ID: <20231012091729.3fzfDD1I@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ss pin of spi0 is the same as sck pin. According to the
visionfive 2 documentation, it should be pin 49 instead of 48.

Fixes: 74fb20c8f05d ("riscv: dts: starfive: Add spi node and pins configuration")
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2: resend due to email problem

 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 12ebe9792356..2c02358abd71 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -431,7 +431,7 @@ GPOEN_ENABLE,
 		};
 
 		ss-pins {
-			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_FSS,
+			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
 					      GPOEN_ENABLE,
 					      GPI_SYS_SPI0_FSS)>;
 			bias-disable;
-- 
2.39.2

