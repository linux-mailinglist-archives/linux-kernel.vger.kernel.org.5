Return-Path: <linux-kernel+bounces-11678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6821C81E9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC9FB2148E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15564C80;
	Tue, 26 Dec 2023 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oAnD7QSq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270F23A8;
	Tue, 26 Dec 2023 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703621295; x=1704226095; i=markus.elfring@web.de;
	bh=Qxkpdv8Qkq7jvs02pZx5pg9wtvajRnmTTkS9S609hRY=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=oAnD7QSqNbRJ4I8z3LJyvZ6S0Oj9GiR6kiseN5OKvZiLGdVlKFg8weWgeZpFBu5Y
	 8KidLKMKxKJtsu8v5vE7olre7V+pdOIDdyvx6GbiqHwuglLMlCM5OjPzoVZtLOqtM
	 25TGKBdi+lnXBZeYFhuoGx6lCRcbFj0fjQZI5n9t3LzL6AYaOqkjAckyiyrugJCzR
	 wxGl3QZYWDl3up9uG6mFuegfs3IqOw8jB1nB7B7pVY/jxFy3FmbnabTR6XIDyh2T6
	 iBcto0SecHQ2kdMiI4VeblOVo4XaEg0tpVLvH+EvNyXy15kg3g4duHndpMWe/OvyY
	 4ZvD61lLPMIcYPE2gQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXRF-1rl7fE0BHr-00Z51x; Tue, 26
 Dec 2023 21:08:15 +0100
Message-ID: <9365c845-baa1-44d1-add9-ec8ca4d365eb@web.de>
Date: Tue, 26 Dec 2023 21:08:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 ye xingchen <ye.xingchen@zte.com.cn>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] Input: usbtouchscreen - Return directly after a failed
 kmalloc() in nexio_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pT5nFzusZbp8RV1rQhzaJrru2NdpxfZ9+vejlMSgbSCpEsu87nx
 IRRVzt3RH6KQhyJ1kJ/nPPRlHlFTT2Ta++KXEYWIy9T9uRBtERBq0zA++AEWbFrsgMKqMXY
 EiipTmC4elOyjytjgmsBRJaQyc1sNI4N41uplGtQ9hN65xP1k2qJ2+YVfMXlGF8SKXGPmFH
 BQqHmoA1bxqY8NmZptKQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:REcKCG5gRbU=;3355Tq7aOrddSDMIBKH/phTHWM8
 w2HnWo9jfx+qPr0x1aeUuxKt3vBE4nuyjFhTm7DGFMSYYDTVCcC/5EotGZxQAW9GR1CAc1IZH
 MDbcAckohOjpcdbJqbbWa+Zkj7tryNEmm601cH7n7VVYlt2NbNVJRF8Lhg5uua+NPD3sbAZkS
 2Srar7F0E08sfQbgz2nMrd3tiBlDbO49yLqMA74tBKGGP8LGuAVfIstqD7dKJp3F0WdT+GNKi
 B+wLOh8z6MhRNULBepKEk3a7R8Z0YrZ1aaC20IHqBxcqDJhWXm2178gqMKImDikUFPJGsfZSe
 VC1pyJ8H/CcF5iR796GX4ipoCoRoPq30it8TcAury72diFN7abWqBPYqbTwZL8A+GcyrcLOvj
 +GoE4YBCbcARZ3PIXH1VleuFpgSmnGFeqW4Vf6795eedOvBaKz6aF8A6p6NRedxslCO8//Q/p
 iPi83I+2BrqxvOa9SWkZ0XBlTVqJGh/duc7u6LLy+CAmCns6/LAFmeVUPWPa70saxsMTTqFW3
 /VYEM8WgclxSYnfK4jqlDhgty1iNPmZUTPG+AhhrAODN3LZMLUNy6L7jDk5HNZPnqKxN0d4ri
 a1VGZKgTG3CMVgbUCaed1j3GuNflKq6mco5Mayg2agV2h3w8y9rMs9W0kGjMRI4TyTwheEai6
 8is+EAtrGuNkthwaVhI9Gl3VnIeW0NE1DmwhYQamHz+92JQxGMzk+/+VxetE+JgVc0lDx0FjP
 3VF+D4TMhGxdomHHreaa+U4d5gM7qyeQxIsUlzshxFJp/dowsWVjglPSlUfHCewmie1qvPWeC
 hS/1nZd190r2oawVw/WpCgsGyuePuPOuVo3xlQXxQA17C7+YepouHQKgR4OQ2Fl9MMev4YJdb
 l6rAxovFhlpAxsV7ftU+tvwL9zbyn3RYZGj4tRiMvvZRbldkb3jVpvie/8YKiBGmCuz8oUcGY
 gkPO0Q==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 21:00:25 +0100

The kfree() function was called in one case by
the nexio_init() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckmalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/input/touchscreen/usbtouchscreen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/to=
uchscreen/usbtouchscreen.c
index 60354ebc7242..1873c7918a78 100644
=2D-- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -977,7 +977,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)

 	buf =3D kmalloc(NEXIO_BUFSIZE, GFP_NOIO);
 	if (!buf)
-		goto out_buf;
+		return ret;

 	/* two empty reads */
 	for (i =3D 0; i < 2; i++) {
=2D-
2.43.0


