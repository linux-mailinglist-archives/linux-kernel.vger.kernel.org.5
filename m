Return-Path: <linux-kernel+bounces-135710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555AA89CA12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13B11F24AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F4F14389F;
	Mon,  8 Apr 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="P/X2l2Dg"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C71428F0;
	Mon,  8 Apr 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595002; cv=none; b=UVK5YMGX3Zd0IRnqO/KWLe1fxLSIYYKihiTvWm7zqXT8khyg73p4u2yg73Hjuv++UrpiIoNtCQM4/M6Vsh0rmwcTcZDpCPBGsanntdgYw53hZXb8IBOE0dQc8vlcfKIHdk2kVLJwOgOnUFZUoNQiq41+DXDmWcAKkpK1xr6tsIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595002; c=relaxed/simple;
	bh=QKH1ON0bxcHkXbRpGU4bmgzSL8gJjDeEiyMA1QKf7Xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7+Uf6UjZ6jgsjjS2pZldDFOxa0ZkT0cfqaLKCrna+Hg0/wSMwC2hXih3fQuA1O4d1RxF6H4pxADsOeSt0ssGMt36CbAG+s5+KKjbx8RAqpVJ66MMp1g83ibBcxLyF7C94MYkPo3k8KjFBY9jvVmWJqnVY9LK8fPJtkRp5/epzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=P/X2l2Dg; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CD7DD100027;
	Mon,  8 Apr 2024 19:49:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CD7DD100027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712594995;
	bh=/k8oBX6LrTtamgxdFTlC/Khi9/j8G6LrxK0Q4+GixUc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=P/X2l2DgSy/l5PSnTMgr3YxQ9Tj6HBn4l9rx9Znme8zTvTEfZ/fQRmancWaSoR9Cj
	 QAFWB6KaAnLnc38YYGAnzYskuXTZTQb+J7fJccRbXXv5XbJ21LH25sVVAtMm97YAq1
	 6tdMirSaZfS0NNNexJQOvjo9TSe6qAEaFp7gXDa6P//C7jkNmqDgm42/sqnbUZB9ND
	 44YM2FUOjFsPFRLdRiGvfPCKWaIcnXdw1+Qm9CvYAUSFOhDu9xlQXgyq4uKB6JBQNR
	 umkfUdHffw8tHagODAgM8B+zYh/Vq0VH0L3vwGZG2qttcyIt+gxPBc4/aDtWNCDcCq
	 in1K4+BLhB+Yg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 19:49:55 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Apr 2024 19:49:55 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <lgirdwood@gmail.com>,
	<jbrunet@baylibre.com>, <broonie@kernel.org>, <conor+dt@kernel.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 1/2] ASoC: dt-bindings: meson: introduce link-name optional property
Date: Mon, 8 Apr 2024 19:49:39 +0300
Message-ID: <20240408164947.30717-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408164947.30717-1-ddrokosov@salutedevices.com>
References: <20240408164947.30717-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184624 [Apr 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/08 12:02:00 #24709100
X-KSMG-AntiVirus-Status: Clean, skipped

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
2.43.0


