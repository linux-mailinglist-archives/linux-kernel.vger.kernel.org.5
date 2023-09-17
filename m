Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBBA7A373D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 21:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjIQTJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbjIQTIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:08:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DCA10D;
        Sun, 17 Sep 2023 12:08:49 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 58B14660721F;
        Sun, 17 Sep 2023 20:08:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694977727;
        bh=MhUT4ZgnWZIvqh1JKIu10f1szECnNwOZIDOW8HonKBc=;
        h=From:To:Cc:Subject:Date:From;
        b=TrqPdfKzJqDG9xMsqEC1xY+ba/jCjD+czKGJ8mpI4Tuih83nSieN+5ih0xl7IfRb+
         lU8AcYyQcCWgYdt72h3n4G3j31hdzoePHA9L+KvmNHyItfm1J6Ch4XEi9pchXRf8Sj
         iDdU7q0Atl57/VTJpE0lmu5V7goPnuP3kAiLTWWXos7DOT8CxapxLnf9413aSw+ysU
         CdVtmShMhfyPRQxakJJ/wiyx03k47P3jYCbDtCDR1Zt3HI/Mq4/GiICx3q58AOqCYy
         azpIE9dT2aGOlK/Ov2ay0H367G+IJ8CDZsDvb6L9Qq/iWQIHNogxiPYLeX+nfL8mB9
         yhCe4a0X1C8ug==
Received: by mercury (Postfix, from userid 1000)
        id 394D710604B6; Sun, 17 Sep 2023 21:01:31 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] dt-bindings: power: supply: Drop deprecated ab8500-battery
Date:   Sun, 17 Sep 2023 21:01:24 +0200
Message-Id: <20230917190124.1012316-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij modified AB8500 to use the generic simple-battery
and samsung,battery bindings. This is an unused leftover that
can be removed.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../supply/stericsson,ab8500-battery.txt      | 34 -------------------
 1 file changed, 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt
deleted file mode 100644
index ee125cb0e46d..000000000000
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-AB85000 PMIC contains a node, which contains shared
-information about the battery connected to the PMIC.
-The node has no compatible property.
-
-Properties of this node are:
-
-thermistor-on-batctrl:
-	A boolean value indicating thermistor interface	to battery
-
-	Note:
-	'btemp' and 'batctrl' are the pins interfaced for battery temperature
-	measurement, 'btemp' signal is used when NTC(negative temperature
-	coefficient) resister is interfaced external to battery whereas
-	'batctrl' pin is used when NTC resister is internal to battery.
-
-	Example:
-	ab8500_battery: ab8500_battery {
-		thermistor-on-batctrl;
-	};
-	indicates: NTC resister is internal to battery, 'batctrl' is used
-		for thermal measurement.
-
-	The absence of property 'thermal-on-batctrl' indicates
-	NTC resister is external to battery and  'btemp' signal is used
-	for thermal measurement.
-
-battery-type:
-	This shall be the battery manufacturing technology type,
-	allowed types are:
-		"UNKNOWN" "NiMH" "LION" "LIPO" "LiFe" "NiCd" "LiMn"
-	Example:
-	ab8500_battery: ab8500_battery {
-		stericsson,battery-type = "LIPO";
-	}
-- 
2.40.1

