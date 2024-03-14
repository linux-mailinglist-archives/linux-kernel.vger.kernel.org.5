Return-Path: <linux-kernel+bounces-103880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DEF87C62C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F92B2292C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD3E288CF;
	Thu, 14 Mar 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="MSeGExEH"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63218036;
	Thu, 14 Mar 2024 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458592; cv=none; b=BYfw9fF+j1YTrVNjO6aK3TNQxC2bkdvpsdo0SbRplqxwMEwwqm0jdSJWz2tS7bTRSnvnU2N1mtElJBhDulJN1LW6U/99FfQZzYVXh+SCbb153B4fsQ9wKMT0+ZaEEL4hkj/DTctqE8yzXcFIBIKrI2Ya7LaLNl9KKqWUl8eKLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458592; c=relaxed/simple;
	bh=aAlIuyHWwzq+0OGEFJZRBJ6X6QK1RptT+GyChjBmTsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKlK5OVxU5Qa8VQgY58N7gGMcLN/cVUWqQtYOu3L9I6shmxXJ+kUPgfiDo/T/2dSTeo0wE2qmmLojt5SsMvSaGaHX+wrOc881CoIU6K6IXvyez0IOf36q3Y2k78Px7JuwF+tv+3kyAKPmfM2KfvAQGZfc6TawcRAXiVrM9a/nmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=MSeGExEH; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4170E10001A;
	Fri, 15 Mar 2024 02:23:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4170E10001A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458587;
	bh=0bVC1Iflcx/84RT20lc/9qwd1tBRnDCCeramIv4oQPM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=MSeGExEHvqf/fh/PAEHhIyndDp7ReLBlRDix5xPvD5f9IFgvtJpKN9fcLtBgJc+QQ
	 UFrWCQnoOqwyGTeicReINzNPnhbbvPcsMXgxO0mRGz9lmSLQi72rAL2MxoDZA33Bsp
	 +k+463xS41TUqWf2ekUoBGuM4H8Nd2jql/cW/HanbakAMlf7UQiVsChHhVPQPQT8ix
	 wXWfaMhaIrHAtITSfQ0Oin4RkHDAPwvIWMR3yzEEONc2yM2TJgCkIsA4Z4Pi5ieNNM
	 kD3MFjROyRJ258oeBfsHAPqeDGbyOjjrORpN47qL2RmvlXtaCRNLe66Xzu/w8HMrSD
	 YIjJ0MZKzd9hQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:07 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 02:23:06 +0300
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
Subject: [PATCH 18/25] ASoC: dt-bindings: meson: axg-pdm: claim support of A1 SoC family
Date: Fri, 15 Mar 2024 02:21:54 +0300
Message-ID: <20240314232201.2102178-19-jan.dakinevich@salutedevices.com>
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

Add "amlogic,a1-pdm" compatible string alias to "amlogic,axg-pdm".

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
index d2f23a59a6b6..b129b8053352 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - amlogic,g12a-pdm
               - amlogic,sm1-pdm
+              - amlogic,a1-pdm
           - const: amlogic,axg-pdm
       - const: amlogic,axg-pdm
 
-- 
2.34.1


