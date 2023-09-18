Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFAA7A4BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbjIRPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbjIRPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:22:07 -0400
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [IPv6:2001:41d0:203:375::dc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F51BCA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:19:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695042967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4JO3nPtbJqM3dkylLDmImTDJGUU/OSMwJOj0UlM/Ak=;
        b=TfnB1KhlXidh22YPceMlN18+XrH4ujdCm5j8lJg6uxN9ms0aAHROG1HXUcT4YkltlOJYLO
        2w/YjChRnnByz+GDdIo2GwmjAWlDJQ9o/B9oH4KB4OfdZmieUCqQmQ1HEbS5cPDi7LtbCJ
        HBuCUmHtOmgGynv7u0KrBIZa0MiGkRbf17IqPjTyywqjqk2q7nE5Gwsb2av5HPRDzgCGWW
        3MBUHEsF441/67YtaMlH+THdpg/Fl/c6W5oWMLtmrokAbdoKqH/8rEDl6aoHn3ObzKrVRU
        KME44FGXd8fiFy9DDfRf4mF4sFeU0OTXzGEz3Eqz4FLX99d2CViK9O2/bAW7zg==
From:   John Watts <contact@jookia.org>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        John Watts <contact@jookia.org>, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen property
Date:   Mon, 18 Sep 2023 23:15:32 +1000
Message-ID: <20230918131532.2257615-4-contact@jookia.org>
In-Reply-To: <20230918131532.2257615-1-contact@jookia.org>
References: <20230918131532.2257615-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WM8782 can safely support rates higher than 48kHz by changing the
value of the FSAMPEN pin.

Allow specifying the FSAMPEN pin value in the device tree.

Signed-off-by: John Watts <contact@jookia.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/wm8782.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wm8782.txt b/Documentation/devicetree/bindings/sound/wm8782.txt
index 256cdec6ec4d..1a28f3280972 100644
--- a/Documentation/devicetree/bindings/sound/wm8782.txt
+++ b/Documentation/devicetree/bindings/sound/wm8782.txt
@@ -8,10 +8,17 @@ Required properties:
  - Vdda-supply : phandle to a regulator for the analog power supply (2.7V - 5.5V)
  - Vdd-supply  : phandle to a regulator for the digital power supply (2.7V - 3.6V)
 
+Optional properties:
+
+ - wlf,fsampen:
+   FSAMPEN pin value, 0 for low, 1 for high, 2 for disconnected.
+   Defaults to 0 if left unspecified.
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

