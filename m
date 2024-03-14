Return-Path: <linux-kernel+bounces-103882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 488CA87C643
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BDEB22E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA653FB32;
	Thu, 14 Mar 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="pmWgkXaJ"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74E182A3;
	Thu, 14 Mar 2024 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458593; cv=none; b=dF2p+wZ5YcycQtw2yvHFD2ewmrYu3HwKjIIdgbMJV2VPngZUePB1ajqubFJK6tDE3LfTiLwco3V3CyxmjIeCdIfKkxnhcz77HTkGrRYqSUJZSCP/7i6VwniLrz+Cxb48YE4cyirbGZwpMNIQ7mJ3+dMTZ67VtGK+upkHBX9AUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458593; c=relaxed/simple;
	bh=ybkbzx+DIvWdFpyy8EDoKSIvtWeGkBDccrQr3+eS2DI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwnQL878ePVJpcEO9mN9JYgGjSLaPwm5DaZb4n9oUQsgKZCgsXsihzRB15AEcCfcc2fxNEs5dH23G7/4mKRNXgMqJKMVuhYpRcSspvnwFZRxcdsjB5gzmkSAApPydLbz2CunRLV21rnaOSPZhilzAkOr+rPea05mkyEnoAfzB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=pmWgkXaJ; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C2A15120012;
	Fri, 15 Mar 2024 02:23:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C2A15120012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458586;
	bh=9SRIX/FvqDap0SMfdebaXOrywr2NEUWz33l2V3WObDM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=pmWgkXaJSxRnY2mr5czzY/iGGINaK0+pU7azMlmYipUFsMcwF9rY+yRy3nkG4tXhI
	 h2emBkJj73eur4HHgzAvK2iDeQHORBbLT/QWiW7uzbkaIitQSQItPYflNW+VEYDcC6
	 A1sdhRNU4DeQNrK/nbK9uBZKi3zcbleBIlZMg5Agrqd9GPCTR5FxoeibVlSu1gWReA
	 U2RLXn7gdbNpy8fyHwxgfX1+y/ACrMsZ5Z8JMgVh/8cwK/OVYZvuYb5D/zT/5a+/i5
	 rFFP+gp6rfElFV+4AgcN3FfjOGBGU1qaSo2zmQ8v5W5YTJBL8xcbMkVNffkNWsJeUb
	 S+K2xl1zKyVEQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:06 +0300 (MSK)
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
Subject: [PATCH 17/25] ASoC: dt-bindings: meson: axg-fifo: claim support of A1 SoC family
Date: Fri, 15 Mar 2024 02:21:53 +0300
Message-ID: <20240314232201.2102178-18-jan.dakinevich@salutedevices.com>
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

Add "amlogic,a1-toddr" and "amlogic,a1-frddr" compatible string aliases
to "amlogic,sm1-toddr" and "amlogic,sm1-frddr" respectevely.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../devicetree/bindings/sound/amlogic,axg-fifo.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
index b1b48d683101..1e809c7c2179 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
@@ -25,6 +25,14 @@ properties:
               - amlogic,g12a-frddr
               - amlogic,sm1-frddr
           - const: amlogic,axg-frddr
+      - items:
+          - const: amlogic,a1-toddr
+          - const: amlogic,sm1-toddr
+          - const: amlogic,axg-toddr
+      - items:
+          - const: amlogic,a1-frddr
+          - const: amlogic,sm1-frddr
+          - const: amlogic,axg-frddr
 
   reg:
     maxItems: 1
-- 
2.34.1


