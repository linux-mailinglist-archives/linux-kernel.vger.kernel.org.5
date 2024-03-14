Return-Path: <linux-kernel+bounces-103887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0A887C647
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D85B22ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4058C45023;
	Thu, 14 Mar 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="u3ppaOV9"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641624B26;
	Thu, 14 Mar 2024 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458596; cv=none; b=ZqxHtplSucyW5EM2YHvRqZRiLy7XyF+bApkNEZL0meZDoBZ/Ym/2/2FlwAGHEQhCKPyvEW1d6SBCKt4pGid3J8BSvz6+F8A+o+/7KqVrfjFI4YWdsLqvHGScP3jv1p7AV5Tjp8GOWsw58LG1zUbtXdMF7o5NkEgfM1i4pCtmR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458596; c=relaxed/simple;
	bh=5RGNRcPvAAVkRokZsvg1iwyrdPkWT2legrHDAQcnHnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KL2WngYunARhK/TW2FOTOXxs0TQATcqdAqpOzaDhhxUmU9BhSs+NiR3Vr/DCBshwjybsK3zZJ9N68oecx5KFGxDQ2Aw8J5SpSN9J5ZmPhJWgbDghf9L6oRLYcMFiPjxJqc7caCXkCpH8ecCJBUIYgemwyYuKq8m7czY4eIPl86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=u3ppaOV9; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E428D10001C;
	Fri, 15 Mar 2024 02:23:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E428D10001C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458588;
	bh=yH+gGyMvZK0BAxIe8YuYpYuVmpvd18qq6ktq5J8ADek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=u3ppaOV90MwGvXwlrtUUM/UAPNKCL0K49kOFQzOish+rKpWQRvVFUDNeGpGlQWoGU
	 mH08DvrMpgypj3jvEAhbDctAmcV4Sh7QuN5bUh8raOv7P/b2LPks1jNLjVb5+xA+Hr
	 4+M0wMv5ttptX648DGIPUEpMNGxQCVzrKF3zzxOlpAqibKnFmALQy2NO7ptN2+vHzZ
	 DGfwU90ax/df1BT3VT7mB01ue8lML3by0Yq9bHtwPPxcQPyfpkmfxRY4BRX0zt0GfU
	 0+XJims5lcpzWD1Gi1kvs3/EPDYcXF+DxueyNb3FAsOXxbkl8atVQs5jMyr5MzVgVa
	 2HSFpe3ema2mg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:08 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 02:23:08 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
CC: Dmitry Rokosov <ddrokosov@salutedevices.com>, <kernel@salutedevices.com>
Subject: [PATCH 22/25] ASoC: dt-bindings: meson: introduce link-name optional property
Date: Fri, 15 Mar 2024 02:21:58 +0300
Message-ID: <20240314232201.2102178-23-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

From: Dmitry Rokosov <ddrokosov@salutedevices.com>

The 'link-name' property is an optional DT property that allows for the
customization of the name associated with the DAI link and PCM stream.
This functionality mirrors the approach commonly utilized in Qualcomm
audio cards, providing flexibility in DAI naming conventions for
improved system integration and userspace experience.

It allows userspace program to easy determine PCM stream purpose, e.g.:
    ~ # cat /proc/asound/pcm
    00-00: speaker (*) :  : playback 1
    00-01: mics (*) :  : capture 1
    00-02: loopback (*) :  : capture 1

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../devicetree/bindings/sound/amlogic,axg-sound-card.yaml   | 6 ++++++
 .../devicetree/bindings/sound/amlogic,gx-sound-card.yaml    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
index 492b41cc8ccd..46774a3e4b1d 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
@@ -66,6 +66,11 @@ patternProperties:
         maxItems: 1
         description: phandle of the CPU DAI
 
+      link-name:
+        description: Indicates dai-link name and PCM stream name.
+        $ref: /schemas/types.yaml#/definitions/string
+        maxItems: 1
+
     patternProperties:
       "^dai-tdm-slot-(t|r)x-mask-[0-3]$":
         $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -137,6 +142,7 @@ examples:
 
         dai-link-0 {
             sound-dai = <&frddr_a>;
+            link-name = "speaker";
         };
 
         dai-link-1 {
diff --git a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
index d4277d342e69..975c148f9712 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
@@ -52,6 +52,11 @@ patternProperties:
         maxItems: 1
         description: phandle of the CPU DAI
 
+      link-name:
+        description: Indicates dai-link name and PCM stream name.
+        $ref: /schemas/types.yaml#/definitions/string
+        maxItems: 1
+
     patternProperties:
       "^codec(-[0-9]+)?$":
         type: object
@@ -89,6 +94,7 @@ examples:
 
         dai-link-0 {
                sound-dai = <&i2s_fifo>;
+               link-name = "speaker";
         };
 
         dai-link-1 {
-- 
2.34.1


