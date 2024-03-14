Return-Path: <linux-kernel+bounces-103878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169FD87C62A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC25AB22575
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5B25565;
	Thu, 14 Mar 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="a+wSfL0H"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243C1802A;
	Thu, 14 Mar 2024 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458592; cv=none; b=lg31h/9fFCVq1l6xT5JJWEQF7l3t04DC9MTgES9N8Ib/JD9GCU7VsIJprVb1ZSfAm7Xjijc/XYHwd+FwIsDpeOo5pzaJcqU3eJYzZRYffgWiVVll7D43smh8S2w0tXYjBwgxHZdw9ddi9RAOwXofsM7R/5D45fXOHTD1xGK6leA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458592; c=relaxed/simple;
	bh=ULTZgz7wemJg/2kZYe2i3hPuq8ZAwSs1+YjpciWGnDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNwAKHcZhBwXp2C1D58VVGo6C2kRdgV6MH0wAZXm0+N5LSEuRORTaPzPcLKkCelVIs/i71b13Hws/0NUwIM6Kg9xiVoKlJOegzyML7WvxoSF4xKceZjFCdDRWm8nOZx0oEDcOeQvGlPx3tdbmr5Y+K8NDcQMrbfWHXvPCLhndJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=a+wSfL0H; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 726F7100018;
	Fri, 15 Mar 2024 02:23:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 726F7100018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458586;
	bh=Pr8V4mkPI24+3PnszozIdpHRsk1mgCHgXbW1+J/O23s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=a+wSfL0HD9f9w9gX2BSNJKN1ZDzuhbSZymkpnkGK8a7juHZpfsOV7ELJUkTufLXcB
	 vnIsstkqyjBdcR2vJiGJfexqHsDM5MsMnZXfdvxG9fmG2U2TQYwl+fs6h83UFZ8DdZ
	 V0/BLUKdDoCeS3qVy0kgGMZbDEymVCL2a4cEgTm1Loo6wO1dNCOvu4HnOo9Y2JxxQD
	 WHWpWsFkRAjZnNrnMxUVfEFmIFYIP93e74qrD8ppRLTinXL2hNeqYnBTfhxx6VCa3s
	 N7v7K3n4UkAf9D19sJJob+6m9QP6KWMGDDs3sTh4yM2sGUfHBZgS8BU9L66VtbZssp
	 eCIg56PeOQNZw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:06 +0300 (MSK)
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
Subject: [PATCH 16/25] ASoC: dt-bindings: meson: meson-axg-audio-arb: claim support of A1 SoC family
Date: Fri, 15 Mar 2024 02:21:52 +0300
Message-ID: <20240314232201.2102178-17-jan.dakinevich@salutedevices.com>
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

Add "amlogic,meson-a1-audio-arb" compatible string alias to
"amlogic,meson-sm1-audio-arb".

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../bindings/reset/amlogic,meson-axg-audio-arb.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
index bc1d284785e1..57e977db029f 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
@@ -15,9 +15,13 @@ description: The Amlogic Audio ARB is a simple device which enables or disables
 
 properties:
   compatible:
-    enum:
-      - amlogic,meson-axg-audio-arb
-      - amlogic,meson-sm1-audio-arb
+    oneOf:
+      - enum:
+          - amlogic,meson-axg-audio-arb
+          - amlogic,meson-sm1-audio-arb
+      - items:
+          - const: amlogic,meson-a1-audio-arb
+          - const: amlogic,meson-sm1-audio-arb
 
   reg:
     maxItems: 1
-- 
2.34.1


