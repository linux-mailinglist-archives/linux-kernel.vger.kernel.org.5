Return-Path: <linux-kernel+bounces-11998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 085DB81EEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3441F22E82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE5446CA;
	Wed, 27 Dec 2023 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="poj/qxU7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BD446AB;
	Wed, 27 Dec 2023 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703677852; x=1704282652; i=markus.elfring@web.de;
	bh=/Cj1QNl5NB+eMaP0OCGwd5CQPitw8BtjolyhftxjSoQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=poj/qxU7lKy2V5VOfd/iOjzwemtIUc6lMQkG7cxdd8TR5HDw8jS+uRxdc6u1BwSk
	 uLuqTQJlRKtFbRAQ1eHzxunBa5U4OJKVOFjCoz5T5aKF0s1C0740bFmHz8tjFm1BT
	 rvXPZUROLFMYCEleq2zfz0qFRQ0SNg4BojJh2o/ASAUwNTqn6JGUocQUYydig2Ueh
	 lykxq8HKrfKp6fCZO44g6ZBp927NEVhuQDPK9lMZrG4wm3/l6Ek1apGrClPUnW3hK
	 SaZzVIc2Rvf47Y4EI8podxSJtbtujAjPTngUbA8VUWsC42DfJ3PVGhaPOC5cOQIK5
	 ScNznhHkUy39K89CUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1rMsHM16bA-004rUu; Wed, 27
 Dec 2023 12:50:52 +0100
Message-ID: <2aa6bd31-f3d8-41ac-abf1-9ec7cf7e064b@web.de>
Date: Wed, 27 Dec 2023 12:50:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Yang Yingliang <yangyingliang@huawei.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mmc: mmc_spi: Adjust error handling in mmc_spi_probe()
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pbZP15ZayWiTe57ZMmiJyPG5siAZDUFivZl7Yc9Hcm6ffgH4sSi
 LzmIkWD3lD33goLIHpB665CkPrARlm42eRACDqs8N2PJEZrbepcu90O4eXAndjg1LkN6MVM
 6tGIcAuKBVpe5Vcij3eoHScl3N/fR2htBRlnwIw9miS8sw9fctUvMK4WihBFQ4JcVZu7m6M
 xwejJlh9gqcLdsKEk3ezw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DtX1kDKmJww=;gYjek4ZqSnhlJtks+e1Rgqp1BJQ
 tr5MT6zvEkGs7wpAwfW3i/+PJ3c0yNlR1SNLyo1M06sPHDQu+wCHJyVWOXDxbw2IT1jNgg5BX
 DkFG42fQxy+oTbKZ7wwtTmezBbXPE/c1t9xp+/G/Llrb8L9umgnyyje2RDKZf+s3jUIHLcfH6
 tLpr3Wq/IJNVKuPdFehRzkhZxsRoBJAvH4d5JoBbrfx2KyplMkf1IbUxZgG7Ok18G7IYLl5ub
 KCPd4QbeuGhHUsJfk4EXIvXjQ2Tm+cMatfkKM5s/Wlo2rHZt4GnDJaV3g0e5MRkY8q6z8kAYC
 GEbmTjq2l9l5DMRqgr91ap1QFdEyhfSCdgaRbGqYQAIpNlVfzHzih+rSA6Qx1qqkF4ZrVtyAf
 h0ste/FuXKFwZX2whkH+i4KypH2JNKKrEetx1+IeYcSVyvi4PcLxZ+3W+LaF+UGdKIG9rzxU2
 j5Sy9VnjzwUFGJWyJOwskP42q/dcELf2V6YyAVaLcceBHyxrP9l0z9cICNfI134P1R0Q/EQwx
 GHp+T9R2i45wWOGQvI15n7TrbanbyPv788SAvGpXO/4eG6YLujnqXJy+NErvpbLmX8uw+PXAv
 fb/A6G4kw3xNlKs923+N6fbtQutrRsL4ZSByqW77+iP5BzRxGbe1TeJ5VHEW34/tNqXWdwH33
 lZBI2XG3bE2jY5ww38aGeA83CyBBVIVF3VklvhWETjBS5L3fdArYvQqV7ApH6/GUCkY/KRPfr
 nkSISBfTWMA6RjOvCVz0SfvPOsWlQdqu/zAn+CLeDa2x7kWB1O+wVLPdt9cPKG1N9hjhLqppa
 TynzatMFJBfxempMysBb4I4TnqCwb8I6dHv8X7Z/XD/FweRhsqTp6uHqYnB1Ldvo63CogGFq8
 qYo2xdbzKjOBixQJKu+u7wOrxmDOjkkKqlWtxh+0ZibueZKX0RF+xvx6691Y3NDIby1sEP0Ej
 XALPWw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 12:23:20 +0100

The kfree() function was called in one case by
the mmc_spi_probe() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a call of the function =E2=80=9Ckmalloc=E2=80=
=9D failed
  at the beginning.

* Move an error code assignment into an if branch.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mmc/host/mmc_spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index b0cccef4cfbf..6e7d8e1e6f38 100644
=2D-- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1349,15 +1349,17 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 * NOTE if many systems use more than one MMC-over-SPI connector
 	 * it'd save some memory to share this.  That's evidently rare.
 	 */
-	status =3D -ENOMEM;
 	ones =3D kmalloc(MMC_SPI_BLOCKSIZE, GFP_KERNEL);
 	if (!ones)
-		goto nomem;
+		return -ENOMEM;
+
 	memset(ones, 0xff, MMC_SPI_BLOCKSIZE);

 	mmc =3D mmc_alloc_host(sizeof(*host), &spi->dev);
-	if (!mmc)
+	if (!mmc) {
+		status =3D -ENOMEM;
 		goto nomem;
+	}

 	mmc->ops =3D &mmc_spi_ops;
 	mmc->max_blk_size =3D MMC_SPI_BLOCKSIZE;
=2D-
2.43.0


