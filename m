Return-Path: <linux-kernel+bounces-135709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38CC89CA11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325C4B22921
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F0D143860;
	Mon,  8 Apr 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Mbjhu4jU"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BE1428F7;
	Mon,  8 Apr 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595001; cv=none; b=amN41hCq9QE1549vGhjMYUjrZFam/j7nD+YN/0T8/9ck9t+ouIvAkfMZscsEkpFeFTKcA02PvYjZDL83EiX50//6/dR3VMNiNJzTirNluBheEE0oyNvu5aBdC6CHrWYRb7SxwP2bCSPncU4vmoRXwEICDKSA+QLaZZC5AD6pCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595001; c=relaxed/simple;
	bh=33ya6iAIdhOO+qGkv/GeYEfF192TQ7WZCShCQ0XLBNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7Q96WkUhICVga2E3pigWA1j63+RUvLkjoglR+f4VyxOA0C7/Lk83QHy3YDwv5aBQPWYXPkbrh0YzcW7DPhOSJND0kwEdNPJJ9sBNyWR2k2tDVivna8g0IYqgJM4vS04RAZgHlalFN9rO6Tl2Rn+SH9eKVwd+lmr2qx0q0XQbcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Mbjhu4jU; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AD415120027;
	Mon,  8 Apr 2024 19:49:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AD415120027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712594996;
	bh=HZCeDqOWZRFrRmmJb31Zwudz+k5V9qwLfzuWrQFrCr0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Mbjhu4jURZzp+med9MOYEhZqXIgEyuvptRXXUaggCCEGe0qvFQqtxIECPMCb09o4e
	 9U+RLqL4qYCNn5WhVgap/l44esWXeH78j+mYbOz68RQ/ty1a9IVMOSnflfPJhuiMUH
	 USz3kmZn5u++K7n//jZRMP27/O+bEQHRQI56/FB86sk6gOmkichtCluqUd89Xsy59p
	 OwQJIP/K5BoU4biD4gdHOxLYzSvewd+E5QbMu+3M+cxoHVZg1q3AR3FCh5izEt4dss
	 mplv84t39KGU4/ZQIK1PKZFy9sA2b0iRa2Wp9eHlMcJfD3VsesvN70pEe5X3O5yQyt
	 odkf53me/OI+A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 19:49:56 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Apr 2024 19:49:56 +0300
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
Subject: [PATCH v1 2/2] ASoC: meson: implement link-name optional property in meson card utils
Date: Mon, 8 Apr 2024 19:49:40 +0300
Message-ID: <20240408164947.30717-3-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/08 12:02:00 #24709100
X-KSMG-AntiVirus-Status: Clean, skipped

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
2.43.0


