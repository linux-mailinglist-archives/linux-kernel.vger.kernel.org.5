Return-Path: <linux-kernel+bounces-29290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81697830C32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9460284371
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8789F22EEC;
	Wed, 17 Jan 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="A0YokYBu"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF1225DE;
	Wed, 17 Jan 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705513393; cv=none; b=nTsAMXpTGlvTO2wQ5TFsvL7tuniMbKrXoI7COSQWN9U8EwijvigSGNAPWirb/lKgyARTZAoEL9CetuaMc17hMORgHT3aZR5GfOvqh1mEqB0myhAx76owyPSrvCOZ7NVsGuD5kECENXoxJ3C98IU3W/ovkUg7gVxZly/39WDUW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705513393; c=relaxed/simple;
	bh=f6I4pFBn++drw1Q2ezqkh1AqMCsZ2H2H4yM4gd4p58w=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:From:To:Cc:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=JBhGu/Ks9we5w/OUSNKkDAnQFdonsbhBFO9B79RmpnPhXoGLs2+e0Dutk/pwXmm0yCDBsZqtCIy1w6QqSZNwuLqgqYDjjZt71FfJ/Fee2T2P2ZQ5gLA9LwupRC/XLLJ4I45ahtRa0b1xwq3bt3lrrAM2IguB0IU6Uy2HX7UQ9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=A0YokYBu; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705513378; x=1706118178; i=markus.elfring@web.de;
	bh=f6I4pFBn++drw1Q2ezqkh1AqMCsZ2H2H4yM4gd4p58w=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=A0YokYBu98xu8huJjJ+zxxJUHL3hL+dnWJHMSkWCP6voo69bWzijUh/J31vmy7c3
	 tejAVjUEcEt7JI9CRNGzX5H3FGD0WxKP5W91tX3izfON4Mn9hE39fVEPAnwXmK31I
	 I7SyyeJZv5XgGOM4orZSJzcd6P50r9pU8QzRIxaiA0Hdp8EpW24RpwDzs/p9upKwZ
	 IlUYAFtIdi68W7R+aDVhwlCQmFYRna6KPDaH6778oj8hEW4HspT9/BuY+HLV64EHS
	 5pSuK1975H+QN/0+IEPFqS+LxMP96KCg0ebtP49kQ2gNU3YttKgsL2KIEgCHYOGCi
	 ra+atHlqkteErpg/WA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSFY-1rf6Jw0uN4-00Wf5C; Wed, 17
 Jan 2024 18:42:58 +0100
Message-ID: <22084283-6854-41f9-b45a-4b27ce207f76@web.de>
Date: Wed, 17 Jan 2024 18:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] clk: versatile: clk-icst: Use common error handling code
 in icst_clk_setup()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
References: <061aef8b-a41f-4346-af6e-560c7594b27b@web.de>
In-Reply-To: <061aef8b-a41f-4346-af6e-560c7594b27b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rip5RFA4nXZcm5gpQQi9JPsjHk1zDHBzC8eEQi7J72jEZipkAfz
 DzVpUfkR4ZqAsD6rUWRMyM1WO53ZDGl7hgEUiQrSYKaAmpqZpBST4E1tn+/U+B2PVijfBkp
 1qgBmsSeyMinqTiysU2UuU1uFo6gXTYP4i2DIsEUGbuh2YJEuEXbJxX+Vs9HVlA4LDrj9mU
 LP5Fy3Jzu3YYKaVZ28v6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fAHvs1aGqkk=;rN+3696c0VFb7jWKXBuvwLNtspy
 qxckwuivcuutKifP9gz+fzwRBOCors4B9h0HWryqR/DaeU0WMicW7cK9UT2rI4peXkzBILUyq
 Hw+UR2S4CqiF8i58TLYOO8jVh5z5mrpknoIeNHNMWSb1aOTbTfz8U2aqZKnt9qcZP9+Sx7hsx
 KZ1K+qk9PiRHptCPm5GK483R6qmVlR1XcNJqMfBlx47Ca+Gz30xhgY5YNTWg69z5l45fOK7Fz
 0RtMtycOgro1TgkRLaLBvOjIhlVmwk/T+1LZBRgw5aNAll/3/VH5oKhSkchi+EBvT/ku3m2ht
 TBccrI0wW6qSRopiEl52aF4N+lIWbiY7Wi7K17dwAyLIxPD/KhdCfdM7jFXnSEwY9/v1MsLqt
 h6/lFJ6+V1Gkzd2r095xWsS+w2YvUZNSIomjsZ8qKQSGziLPzFY1SPXXlg8c8clkYRhyqtjEn
 3mMJmLSx41VIOwiOuNRrtcX/tdDuX8f4AHikdtSrzsfzeLkTN1R3xq9V/ANguPDU6jLDY4d5h
 caVtVgkBhO/urfiuQlW2MIHac2gJc2qc3rCt+Wc/eXZTlZq6dkqQx6nKyy3Jy8VrZvJ14AXBN
 32rzbYzHmmBYZvWMupAe2kYGWjnfuHztwTMC1yG5B12PKnGGIjgdikNdVNibr3zRvoedZc12G
 OOJ0umK2OP6vnVpOLZQzh07Y87bs7JYlGkDxqZbYDq7tVbHKyeAX3F+FB70jctqT+osJQkBdG
 PCtMQjS+Hf9HlmHJZCPIVW901dCEe1zW2RU/sjlCw4SwqWXdlTLYNXZWeNCl5nr7MJ46XOkf/
 q1SYJXenSRc7EM12Htz98QfG7qGdUjsZbJ2jJCRVcPjQYwWoLFBYyZ+73LVYXu9AjM6o4O+cM
 HgDMKgdvS2F/qBoIAph1SPGq3xaUmL7RfEW1i+wLk/Hs/Rx7eH3pqFwuMWKCOQEal1JowcuEC
 huKtOQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 17 Jan 2024 18:18:25 +0100

Add a jump target so that a bit of exception handling can be better reused
in an if branch of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/versatile/clk-icst.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-=
icst.c
index c4cf50a48972..9957dc9b8941 100644
=2D-- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -351,8 +351,8 @@ struct clk *icst_clk_setup(struct device *dev,

 	pclone =3D kmemdup(desc->params, sizeof(*pclone), GFP_KERNEL);
 	if (!pclone) {
-		kfree(icst);
-		return ERR_PTR(-ENOMEM);
+		clk =3D ERR_PTR(-ENOMEM);
+		goto free_icst;
 	}

 	init.name =3D name;
@@ -370,6 +370,7 @@ struct clk *icst_clk_setup(struct device *dev,
 	clk =3D clk_register(dev, &icst->hw);
 	if (IS_ERR(clk)) {
 		kfree(pclone);
+free_icst:
 		kfree(icst);
 	}

=2D-
2.43.0


