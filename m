Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8611579F02B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjIMRQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjIMRQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:16:35 -0400
Received: from out-212.mta0.migadu.com (out-212.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB409B;
        Wed, 13 Sep 2023 10:16:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694625390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7MW2tmPsMPWsEPrNQ/SepXgoJLxl3hENl0P4TjZeAI=;
        b=Eo7GK7lq/gTTAwl8Iy1o6l/u1wMdmmidG3pp1PYNMzKEUtD+WJr9xocXAp9ZMJZSwY5uhA
        qKi1EQ+yRFZou1//6N1q5p+JacFDiV0LjBsntUl1g2ZhyNYir1b+IPuyokqE4z1qsQETOz
        Lb/6JJomyGI2HGW0AmFvoixKxa6o5eUMZNMIvrxr7N/NezCHvHYu3lMCBJdc9VHTxWrt3w
        ysEMyzsFcwILr8JB/zSDpBbwyoR1kKQJhVp7AbMNuJo3POkswmSpkrNjgOFU8oXJIu09lz
        E5KlceLKLs4DYHNycBjvgf8ntchf6F8h5bO+z2PhTGej7RrrdIY4B0Je+jJW1g==
From:   John Watts <contact@jookia.org>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen property
Date:   Thu, 14 Sep 2023 03:15:52 +1000
Message-ID: <20230913171552.92252-4-contact@jookia.org>
In-Reply-To: <20230913171552.92252-1-contact@jookia.org>
References: <20230913171552.92252-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WM8782 can safely support rates higher than 48kHz by changing the
value of the FSAMPEN pin.

Allow specifying the FSAMPEN pin value in the device tree.

Signed-off-by: John Watts <contact@jookia.org>
---
 Documentation/devicetree/bindings/sound/wm8782.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wm8782.txt b/Documentation/devicetree/bindings/sound/wm8782.txt
index 256cdec6ec4d..d217a616e103 100644
--- a/Documentation/devicetree/bindings/sound/wm8782.txt
+++ b/Documentation/devicetree/bindings/sound/wm8782.txt
@@ -8,10 +8,15 @@ Required properties:
  - Vdda-supply : phandle to a regulator for the analog power supply (2.7V - 5.5V)
  - Vdd-supply  : phandle to a regulator for the digital power supply (2.7V - 3.6V)
 
+Optional properties:
+
+ - wlf,fsampen : FSAMPEN pin value, 0 for low, 1 for high, 2 for disconnected
+
 Example:
 
 wm8782: stereo-adc {
 	compatible = "wlf,wm8782";
 	Vdda-supply = <&vdda_supply>;
 	Vdd-supply = <&vdd_supply>;
+	wlf,fsampen = <2>; /* 192KHz */
 };
-- 
2.42.0

