Return-Path: <linux-kernel+bounces-103877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8270887C627
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371882827C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53D250F4;
	Thu, 14 Mar 2024 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="jJzF+8WI"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0FF17C70;
	Thu, 14 Mar 2024 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458591; cv=none; b=VtP/H8taVRVX/MeEOiQODOv+r5X1h2H9PCaP8R6vgCuAW4Z9bWrl4UTir61yzfa8A/SCu2tD1h3ODLJWyvMP1kmsAyZ62XWvlUJv6yVwW4oWjKPfT0fi+yhxb7Vz1/3Z9Dle4UCpkOTb+xY0nUp4y3mFniL5xyjGKV/avYzG7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458591; c=relaxed/simple;
	bh=QW+JjbrJl3n7JQhXFVm0AxUJp+xUWsijUysxd7owbZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5Pqv8Hx/MTqQWzxWvf0946ccq2vpBGmGkOr69E5bRaZofvZYflWSzvY6igw1OKdJwoAOipjY7S+6Q/lyyYnp3y6w26nXlfmvWJQIe1mPQBlxVSnSPkkVr1SSq8RIROAYrIgggTgLixyDTb8AzALiNM1KZhjoggrTgtR4uHg8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=jJzF+8WI; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9E315100016;
	Fri, 15 Mar 2024 02:23:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9E315100016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458585;
	bh=V+vdRcALSbTUGDcgP2YFpiUK4bL8vNQx31BjTGtvoQs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jJzF+8WIvZ6FNhovzxBDvIydD2hZBQ81dr6xTs0quRU/a8qXKLjYh6mUHjPhQ7pv5
	 F8kURAHZ7RS6f3EJA6Z0sJ/lpAPuXEiGYpjsgH7njsvZbpJSfR+9xUN7B3H28d/aH3
	 OYC3M35dtS+dpV+tAEl7RjJUgPkMeSYiA+vzJ2TCa2mD/OJnT0ZmxnXGgDKwPt+V31
	 N0uSSPDdVn5dfzwpXMiACnFwKUDtYc3xl+tJPDXCWpNfOgQuwdiHXDTitW35bYEZ8l
	 409gv/tCzlVoLd7A/0hoW7m6B8aIwKWUizIzKyaK+LzSpS0FxvbRjHceKd3gE1r5ID
	 ROjOQ7+k/SSKA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:05 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 02:23:05 +0300
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
CC: <kernel@salutedevices.com>
Subject: [PATCH 14/25] ASoC: meson: axg-pdm: introduce 'sysrate' property
Date: Fri, 15 Mar 2024 02:21:50 +0300
Message-ID: <20240314232201.2102178-15-jan.dakinevich@salutedevices.com>
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

This driver unconditionally set the rate of DSP system clock to 250MHz,
that on A1 SoC family causes reconfiguring of 'hifi_pll' clock to some
rate, that is multiple to 250MHz.

Further, when playback is activating 'hifi_pll' would be reconfigured
to another rate to produce audio clock like 12288000Hz. Both these rates
can't coexist on same parent.

To avoid the fight for 'hifi_pll' clock allow PDM controller to
configure its maximum sysrate through device tree. It will allow to
inherit 'sysclk' from another clock (i.e. 'fclk_div2') and isolate
'hifi_pll' from PDM influence.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 sound/soc/meson/axg-pdm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-pdm.c b/sound/soc/meson/axg-pdm.c
index d59050914d3c..a132444a51fb 100644
--- a/sound/soc/meson/axg-pdm.c
+++ b/sound/soc/meson/axg-pdm.c
@@ -94,6 +94,7 @@ struct axg_pdm {
 	struct clk *dclk;
 	struct clk *sysclk;
 	struct clk *pclk;
+	u32 sys_rate;
 };
 
 static void axg_pdm_enable(struct regmap *map)
@@ -172,10 +173,10 @@ static int axg_pdm_set_sysclk(struct axg_pdm *priv, unsigned int os,
 	 * the requested sample rate. In this case, the sample pointer
 	 * counter could overflow so set a lower system clock rate
 	 */
-	if (sys_rate < priv->cfg->sys_rate)
+	if (sys_rate < priv->sys_rate)
 		return clk_set_rate(priv->sysclk, sys_rate);
 
-	return clk_set_rate(priv->sysclk, priv->cfg->sys_rate);
+	return clk_set_rate(priv->sysclk, priv->sys_rate);
 }
 
 static int axg_pdm_set_sample_pointer(struct axg_pdm *priv)
@@ -386,7 +387,7 @@ static int axg_pdm_dai_probe(struct snd_soc_dai *dai)
 	 * sysclk must be set and enabled as well to access the pdm registers
 	 * Accessing the register w/o it will give a bus error.
 	 */
-	ret = clk_set_rate(priv->sysclk, priv->cfg->sys_rate);
+	ret = clk_set_rate(priv->sysclk, priv->sys_rate);
 	if (ret) {
 		dev_err(dai->dev, "setting sysclk failed\n");
 		goto err_pclk;
@@ -623,6 +624,9 @@ static int axg_pdm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->sysclk))
 		return dev_err_probe(dev, PTR_ERR(priv->sysclk), "failed to get dclk\n");
 
+	if (device_property_read_u32(dev, "sysrate", &priv->sys_rate))
+		priv->sys_rate = priv->cfg->sys_rate;
+
 	return devm_snd_soc_register_component(dev, &axg_pdm_component_drv,
 					       &axg_pdm_dai_drv, 1);
 }
-- 
2.34.1


