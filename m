Return-Path: <linux-kernel+bounces-163929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2408B7608
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F861F21585
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331417109D;
	Tue, 30 Apr 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbRiJ3s8"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297913F43D;
	Tue, 30 Apr 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481102; cv=none; b=Cn4ER+HYIKUihI4qRZimWwdRmBSJaprKdrPTCMGNfN12G/5CyMt+rvz5g6HBJMq6npUHmV+WtqSV3b4bEjaCSX6epDQtYAEfdr1wCUci3EQVK2ofS4dkroB4wkaOXgvCoz12MkrrWi+eBH6Tkacy84UzP5F3K3xyhThLF6bE0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481102; c=relaxed/simple;
	bh=KIcNRVtmmQrdXcBKcIpo7M4EDNJemAxWuf3q7+mhCzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geDMiR8zFAhcUkacgdiMNu3M6rMJGBZ/h7qY3wZ/QshObJKhaT8JGh+tVeix5g6/TXjCsLE1TakUQlqxhQWq01iv8lnIhxBSEA/HAZ4KRK5SipDmfMFgX1uVZz4nQGD7/WNzMLbd+A7bTS5qS68I8Ot2R2K/bUfOKJEQSBsSrII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbRiJ3s8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51967f75729so6694020e87.0;
        Tue, 30 Apr 2024 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481099; x=1715085899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZfLTpIjJmVaTYS7lbwGBbdoLSbg7AHbUY1X0ThbnTM=;
        b=cbRiJ3s8fMekHfdWzc2oq5JAmPWtKu1LUfyouCIskto8bwHpnnIm1MMweZ41M137Fc
         ulncvLZhunlSOQZ36dyPyqEm31qe4ATZeIWdxuJxUYhmaWgGd8PirJZGZyUyI770KqL5
         syd3vWizAgLj2m8so31bfe7wqBp+zCnT52kVj0gdmCXqjWR7+OybILLwzWAxOwqBUBm2
         rIdgGg5gJr65NCGbG3p96IGt4LyKCC2xflEQHQ+ea/IJYLInxyAmBLflI+1am7HidZ1i
         fehUoz7A2FmmG9pMG1PD4GLdJTXl1U7+J73j52OXBAWyRwIFLdWDdIr0Kze7YxZbiBn4
         PLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481099; x=1715085899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZfLTpIjJmVaTYS7lbwGBbdoLSbg7AHbUY1X0ThbnTM=;
        b=Cnp23Z9W5F7tBaWd3IxSi5gp+6oftPZr/EraufPzghN2NyvYLvwHgQJJscw6XUGg3U
         yPI7SrLXwQ/rmWvlzrqcnBxwDXSGuBXvX64lEFYcQ1clMQtf2QFWRqGHNi6WMHUX37Op
         Xd0VMolAaA6M+bGwIKrCTPMsLSiJYB1/Ycq3po0AICsDI3IuWFJEPAfjcwDh/3SX0+fg
         CR5ySqEyLQh1juAYpQjZditGY+k1VN1GbLYB+xjRs1nmR3nPXUB3nnnn3XxxOzFAWBOP
         MRvEtGIxYLY7/iwEO6IgyxH9zztGfkCeyAYRlAlGCoYifFDBqKbO3t2Qe30smK0jOJ70
         dnAg==
X-Forwarded-Encrypted: i=1; AJvYcCWF7TLPicGRz1BrRJPSiIuUy81h5euI1H0rctU29eLZq9SurKgaF5Ci4tLOwIapZJm4v9zdzzaJ/jvzIvg1oeSSmZOLQ3/0opZqq+YYhhDLgU9NpDyq5pV4qWkY4ggUyyxWoROQdXnE
X-Gm-Message-State: AOJu0YyBuL5TeTvktuYeBaeU0uF8XLJWCS1jfqTyJ1nUfdJDeAhaah+c
	ehVHIfBaSL1vIv1yDciBzRruIkTDwsDDWuj8swMSUiGUhxtqSk4Y+4OEWg==
X-Google-Smtp-Source: AGHT+IH75htWU9/5SwbMUu5MZuUwDRxz7PZdTtsvnZ4wkdMYhx9Bonhb+TgSenMUtfeYhdGqRsXd6A==
X-Received: by 2002:ac2:5f6b:0:b0:51b:aa42:67c5 with SMTP id c11-20020ac25f6b000000b0051baa4267c5mr1515541lfc.60.1714481099066;
        Tue, 30 Apr 2024 05:44:59 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y23-20020a196417000000b0051c3aea9c3csm2055536lfb.211.2024.04.30.05.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:44:57 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:44:53 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH v2 1/2] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Message-ID: <d501ade8c1f7b202d34c6404eda423489cab1df5.1714480171.git.mazziesaccount@gmail.com>
References: <cover.1714480171.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E2t63QxdjNRo5mou"
Content-Disposition: inline
In-Reply-To: <cover.1714480171.git.mazziesaccount@gmail.com>


--E2t63QxdjNRo5mou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Chenyuan Yang <chenyuan0y@gmail.com>

The sorting in iio_gts_build_avail_time_table is not working as intended.
It could result in an out-of-bounds access when the time is zero.

Here are more details:

1. When the gts->itime_table[i].time_us is zero, e.g., the time
sequence is `3, 0, 1`, the inner for-loop will not terminate and do
out-of-bound writes. This is because once `times[j] > new`, the value
`new` will be added in the current position and the `times[j]` will be
moved to `j+1` position, which makes the if-condition always hold.
Meanwhile, idx will be added one, making the loop keep running without
termination and out-of-bound write.
2. If none of the gts->itime_table[i].time_us is zero, the elements
will just be copied without being sorted as described in the comment
"Sort times from all tables to one and remove duplicates".

For more details, please refer to
https://lore.kernel.org/all/6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com.

Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Co-developed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - Fix the sender and From: tag
 - Drop the Co-developed-by tag from original author

Original commit (by Chenyuan Yang) was amended by me to remove duplicates
so that the user-space callers do not get multiple instances of same time
as was discussed here:
https://lore.kernel.org/all/a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com/
---
 drivers/iio/industrialio-gts-helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index b51eb6cb766f..59d7615c0f56 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -362,17 +362,20 @@ static int iio_gts_build_avail_time_table(struct iio_=
gts *gts)
 	for (i =3D gts->num_itime - 1; i >=3D 0; i--) {
 		int new =3D gts->itime_table[i].time_us;
=20
-		if (times[idx] < new) {
+		if (idx =3D=3D 0 || times[idx - 1] < new) {
 			times[idx++] =3D new;
 			continue;
 		}
=20
-		for (j =3D 0; j <=3D idx; j++) {
+		for (j =3D 0; j < idx; j++) {
+			if (times[j] =3D=3D new)
+				break;
 			if (times[j] > new) {
 				memmove(&times[j + 1], &times[j],
 					(idx - j) * sizeof(int));
 				times[j] =3D new;
 				idx++;
+				break;
 			}
 		}
 	}
--=20
2.44.0


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

--E2t63QxdjNRo5mou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYw58UACgkQeFA3/03a
ocUbfgf8CymJGtBydXuTd8iEdYjOISBsHEBN19bV566o5F/1UbymyKE4nfsky3nE
zfDlZuM5tgLgC3c+Ij4BW0CZqEuKnBwm2VA5thYzSsWPQW3RZ/bSqbpZ7H1TB8Qe
5uCT7VfLkr7XogXae4IG93Os4cwR9lDVjjAon3MRrRTjbZL9k0/rbvl/UETcuN9C
imwZeiAmRLcP6dkw9PqrjaHa/7Q5IPfc7cD+xBIcjiGwUXnHWnJek9w2itGdnVE7
0OObD2bnGvrmTrFiYnNElXpU9vxdIibL2CG69WJBWUcNv+yYhpZO21FZKVKgVLdr
+alkvXCsLgmUU5QvkKYy+BOPuHFdpQ==
=yPoG
-----END PGP SIGNATURE-----

--E2t63QxdjNRo5mou--

