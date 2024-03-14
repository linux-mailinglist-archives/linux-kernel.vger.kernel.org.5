Return-Path: <linux-kernel+bounces-103886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8804187C646
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10761B2285C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D95245008;
	Thu, 14 Mar 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="u+Oz0ttF"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3022630;
	Thu, 14 Mar 2024 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458596; cv=none; b=lcRWYQ504Vy5E4XK02PAw/HIhI7QeOEYwIJw8XgpsV2SxEh4j58X1kvokkyrbKWR5/xE236S1LwrZv3+H8qyw+356QaExETeGl2GfcDUOPQfZk9aTP9vQyenRwxUgH12InDIk3h+n18fq0d4O1uHWy01mA5j09wGaMYwU0bmRH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458596; c=relaxed/simple;
	bh=PPaufu1U2yk2CH6X5UKjVc/X+cp8pDKq6JGff4Q4Ako=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmZQXeK8+BUPGCjDQUw/zPUbNeKFGk02sRcf6U4CNuKIR8U2uXTk2T1Kdo9vJ8anchhxNrY1B/1R4+Ncm+DFhb7J0u8SOBrgOOTDooKlxNZxgk8mrwUZQIj47RD8ZXL7iyIP8hFkNNJGZ4GX/rzFa7BGOfUNrG9AMJLa5bmYlms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=u+Oz0ttF; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4C680120017;
	Fri, 15 Mar 2024 02:23:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4C680120017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458589;
	bh=oHTYiFMvsDA2ptkBIAd/4iyJxp1yij69f1A6GAHpv/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=u+Oz0ttF+z42jfxCb8bDWrwT8gKjMcS+SPtHlohHa5dn60NXyF1irW3it6wF6OGl4
	 i4Lp0AkUL/bTG2KtJUzaKkRzm+usunGeByzIycDnIB3gHjsclUTwfnriUShwE3Tqdd
	 s4fpCnU88rJGOOmf8WkIv0vToE9okHv7OeXnjdmxpFCP/fXTE49PyuIDtFFp68vu6l
	 vJ4NH5Yy81j+hSvdNX8V3QSFnl+ze2CNuB1YP4ux6mD2k1/B3EKbyP5POZKbQ2W9Rr
	 WbM8sLazBDjDKPqYrnjlaCVcJxSRZ8+ou2TMxGi99HKcW8zU08YrjHnkApKzgqyR6V
	 DCSFLLW73a/ew==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:09 +0300 (MSK)
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
Subject: [PATCH 23/25] ASoC: meson: implement link-name optional property in meson card utils
Date: Fri, 15 Mar 2024 02:21:59 +0300
Message-ID: <20240314232201.2102178-24-jan.dakinevich@salutedevices.com>
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

The 'link-name' property presents an optional DT feature that empowers
users to customize the name associated with the DAI link and PCM stream.
This functionality reflects the approach often employed in Qualcomm
audio cards, providing enhanced flexibility in DAI naming conventions
for improved system integration and userspace experience.

It allows userspace program to easy determine PCM stream purpose, e.g.:
    ~ # cat /proc/asound/pcm
    00-00: speaker (*) :  : playback 1
    00-01: mics (*) :  : capture 1
    00-02: loopback (*) :  : capture 1

The previous naming approach using auto-generated fe or be strings
continues to be utilized as a fallback.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 sound/soc/meson/meson-card-utils.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index ed6c7e2f609c..7bae72905a9b 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -94,10 +94,14 @@ static int meson_card_set_link_name(struct snd_soc_card *card,
 				    struct device_node *node,
 				    const char *prefix)
 {
-	char *name = devm_kasprintf(card->dev, GFP_KERNEL, "%s.%s",
-				    prefix, node->full_name);
-	if (!name)
-		return -ENOMEM;
+	const char *name;
+
+	if (of_property_read_string(node, "link-name", &name)) {
+		name = devm_kasprintf(card->dev, GFP_KERNEL, "%s.%s",
+				      prefix, node->full_name);
+		if (!name)
+			return -ENOMEM;
+	}
 
 	link->name = name;
 	link->stream_name = name;
-- 
2.34.1


