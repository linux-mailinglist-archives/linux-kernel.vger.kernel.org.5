Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2017B65EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbjJCJ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbjJCJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:58:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E8BB;
        Tue,  3 Oct 2023 02:57:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso849270e87.1;
        Tue, 03 Oct 2023 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696327077; x=1696931877; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itn+jp9DqMJguXGxeI/EyyIrxZjnVISE01BS8qN3dyg=;
        b=HWEHy5W0JGmUi2jdakt+ia773lejEEEq1G5f5AojpRkhbWaGapHZs18Dfg5yxOZGuq
         f8qWxhhVbkeN0Or44NfLrt+wujR6MDsukW2/T9OuhCA9bkbNgDnBkS6ueEsnSfUzWhr+
         dOQDkMlkpg2Pb/QyCeIpsimF54/PlcBPtbMbyTmmhNONV8Ia3MSvE0j5aH74qtH5iHYZ
         g/zWAY+J7hwc9AdatDVLVoVgM/sZgaAGliNNkkZqtGhobOr75lIV3MKSfqy7uZdriqSv
         WW7m6GfYfMNCtBbtnwkY/FKQx4G5iRqVzTGo8v/PVa39HpEPbYnbKNL2cznuAeExLgrH
         sI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696327077; x=1696931877;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itn+jp9DqMJguXGxeI/EyyIrxZjnVISE01BS8qN3dyg=;
        b=D+cAGrj67+lrxklQ3e1VftJZCr5O4ELXqI9EtcSXw+B5W+6cFYUS3GtFvPnfq76tT8
         QuHTcQiII3U2cX2DwFE4qhUQVUJNDOrnbsGTT3+FcmN8iiHfMg6liUFpdEYSinLgRvsO
         V9DVRmBaJa0QHKPc1gmT3my9aAHouoEKZI6/Oemv2iH9+2u2/G8ZqUTo2XNfk2nNyaVa
         jdRAkQ9IRmYhsgkteV+NHLr4zt9Bg50IrKpg8M9/DGMvYeEzozVmNvZrJfC7/aGb2bEX
         LqipksDKNWVInGoipifWB1MRCoEbdXdQbDxLsjjSo1fcOlfeYXcvI9jEFDxWV06fte2x
         K/Jg==
X-Gm-Message-State: AOJu0YyDBHjSofhS86xCQOfgicKblymXmjFNdDN4tLmT105jJij5Dwqo
        6Ye43JjmIQCxKFQxafm2kXA=
X-Google-Smtp-Source: AGHT+IFdijcQl/2mpTmHsUb2wvWwGJhb4kCp3u9fmLvo3Rh8+5MRyVRQrMwl8/qM5UlckIlYrfDaFw==
X-Received: by 2002:a05:6512:4819:b0:505:6ede:20b0 with SMTP id eo25-20020a056512481900b005056ede20b0mr8846121lfb.58.1696327076936;
        Tue, 03 Oct 2023 02:57:56 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id l19-20020a19c213000000b005042ae2baf8sm132270lfc.258.2023.10.03.02.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:57:55 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:57:47 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] tools: iio: iio_generic_buffer ensure alignment
Message-ID: <ZRvlm4ktNLu+qmlf@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X2pRPnCTlVZaKbsj"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X2pRPnCTlVZaKbsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_generic_buffer can return garbage values when the total size of
scan data is not a multiple of the largest element in the scan. This can be
demonstrated by reading a scan, consisting, for example of one 4-byte and
one 2-byte element, where the 4-byte element is first in the buffer.

The IIO generic buffer code does not take into account the last two
padding bytes that are needed to ensure that the 4-byte data for next
scan is correctly aligned.

Add the padding bytes required to align the next sample with the scan size.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e58537ccce73 ("staging: iio: update example application.")

---
Revision history
v5 =3D> v6:
 - fix typo pointed by Andy (wan't =3D> want).
v4 =3D> v5:
 - drop unnecessary comment.
 - drop all other patches as those were already applied.
 - add Fixes-tag.
v3 =3D> v4:
 - drop extra print and TODO coment
 - add comment clarifying alignment sizes
---
 tools/iio/iio_generic_buffer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 44bbf80f0cfd..0d0a7a19d6f9 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -54,9 +54,12 @@ enum autochan {
 static unsigned int size_from_channelarray(struct iio_channel_info *channe=
ls, int num_channels)
 {
 	unsigned int bytes =3D 0;
-	int i =3D 0;
+	int i =3D 0, max =3D 0;
+	unsigned int misalignment;
=20
 	while (i < num_channels) {
+		if (channels[i].bytes > max)
+			max =3D channels[i].bytes;
 		if (bytes % channels[i].bytes =3D=3D 0)
 			channels[i].location =3D bytes;
 		else
@@ -66,6 +69,14 @@ static unsigned int size_from_channelarray(struct iio_ch=
annel_info *channels, in
 		bytes =3D channels[i].location + channels[i].bytes;
 		i++;
 	}
+	/*
+	 * We want the data in next sample to also be properly aligned so
+	 * we'll add padding at the end if needed. Adding padding only
+	 * works for channel data which size is 2^n bytes.
+	 */
+	misalignment =3D bytes % max;
+	if (misalignment)
+		bytes +=3D max - misalignment;
=20
 	return bytes;
 }

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
--=20
2.41.0


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--X2pRPnCTlVZaKbsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUb5ZsACgkQeFA3/03a
ocW5wggAlOggIxqFVoJD+8TnfOgo9flg0eq3Cj9dq8lTa1fKH3emYtXpdHkoRS3S
pd8ZuCSFOmQ9r4ijAd4B2488fdtjf+XJPnStVO8eRDKAwgih4o+ri0p05HJzC56l
Ih4fujrRzl1oDtdIJOaGISYTELPF52uvkd7Yw6O6IubgWloZYQ9jzXEQ8ZCFsvMR
Q/SwRomSBroNAUtJwSWthAAteXPZ8lPFxcFUjg84sMKIqR6G9xyx0QioijnCDDwM
eRDzEbKTDGFojVpFYz7ReSl5/YyICM+gHCo5ldueGi2jX86ngrh5rfYEW85qxLG6
w/nqWWm3dmqbRV4313ZfqE16iFkfiA==
=EdzQ
-----END PGP SIGNATURE-----

--X2pRPnCTlVZaKbsj--
