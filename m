Return-Path: <linux-kernel+bounces-11878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F581ECD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A90281DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44953BF;
	Wed, 27 Dec 2023 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Eg5FFWge"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5425396;
	Wed, 27 Dec 2023 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 9294E28B50B;
	Wed, 27 Dec 2023 07:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703661097;
	bh=0+1mR3SJFAT7hYMdntnUn/RRP/aSEJx1NBjfSwTY9dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eg5FFWge373TwabCTwBl5+Qs+Q2pACHq8/pyIyngXkEmhqBLLmBBJp8Zr+lJjza48
	 5UZ3dnZGQBsvRa/zykcJfXXpJfwSjWVHQ+0UPC4mV7Rmc64s/0rmzvzCOKox24QIgq
	 WUpK6v9ax6TfxkKWCVu89mZx1A7nm4eB6nxoK7Ho=
Date: Wed, 27 Dec 2023 09:11:35 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 01/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml fix
Message-ID: <ZYvOJ9tlO1fp_QBT@sunspire>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-2-petre.rodan@subdimension.ro>
 <20231226162839.5ceddc9e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gXDyfpoylppolFU2"
Content-Disposition: inline
In-Reply-To: <20231226162839.5ceddc9e@jic23-huawei>


--gXDyfpoylppolFU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Cameron,

On Tue, Dec 26, 2023 at 04:28:39PM +0000, Jonathan Cameron wrote:
> On Sun, 24 Dec 2023 16:34:46 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > Define enum inside the honeywell,transfer-function property block.
> >=20
> > Set the correct irq edge in the example block.
> > Based on the datasheet, in table 13 on page 11:
> > "End-of-conversion indicator: This pin is set high when a measurement
> > and calculation have been completed and the data is ready to be
> > clocked out"
> >=20
> > Add description on End-of-conversion interrupt.
> >=20
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> What's the relationship between Andreas and this patch?
>=20
> Petre seems to have sent it so either Andreas should have a Co-authored-b=
y or
> should be the author... Or not there at all

Andreas has written this driver as it is in the mainline tree right now and=
 he
is marked as a maintainer for it.
A month back I told him about the enum off-by-one problem and also about my=
 plan
of adding more features to the driver.
He was happy to accept my code and once I sent v1 of this patch to the list=
 has
asked to work together for the v2 you see here. This has helped with cleani=
ng up
the code. He requested the additional 'Signed-off-by' tag, but if you have =
a more
explicit one I will happily use it. 'Co-developed-by' it is.

He also owns an i2c version of the sensor so he was able to make sure that =
the
original half of the driver still works after my refactor, hence the 'Teste=
d-by'
tag in the last patch.

please tell me how do the 'fixes'/feature/improvement tags/keywords look li=
ke?
are these to be added on the subject line, or should they reside near my
'Signed-off-by' inside the email body? I probably missed the documentation =
where
these are covered :)

also, should I add a 'Reviewed-by:' you for 09/10 and 10/10 (the last two p=
atches)?

best regards,
peter

--gXDyfpoylppolFU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWLzh8ACgkQzyaZmYRO
fzBpxg//ekA/5x6UzTA8o9Ujo78/i0MRMxc5zWYkHfpJLuVweN6FNqIOSN9Ang3e
qRkZT39HmeLL8FzxchjHr/tgUTaejMM6iltdsnKvukPxGzdkkSKfEqEka0KgbljO
2CPy6UJEzUx5XSEONeL7no6nLHvTsjCPXE1W4UBPTIoIr5oNA5wuokW0VD3+lg+u
DOXh2RFK/+oIp1HXnYpO+8q23dVBMFRZtuiJLqy83uUTlz7aeuCUG/7MYWPqOhSO
cIH2CtYpX7MjUxGvqdbRDAY17wid4qJ3yOOD1+MDxe362Ldp93piwNT752ORuh/x
UGNZ8B87v6iIdUimEtEcLWfsg+AP6xEJvXD+7gsG0lhazz90/36RHmSZcn/asgSD
f1bBY6P8Iry0vgnqPQej0K/7OBDb0TuesHxuZ9oXDFAtAjuV+Xwcoq4swouPpO4Z
cbxGPpyyTfkKtYJVwIo13pHY1g5JtxOfsWm2pBpatCxr0RDk2+zAkufUiZ6pbYTQ
tsotCSfGt4+qvpBb87SMPEAsg6+MxoOV2r4DWCy3VgiNXaUGim0o2bLA2lNQX/q5
RsA09oToLJ5fUdX+Lrc9oBqK4kHZL4A06jYwWMXhJTfp7NkwFjJ1S6MwVqfO202o
JgiXoUibcQpLTYh1AV7GeXAW69zZKjdxy/CfG3ZzitSPbhwLXSM=
=Otfh
-----END PGP SIGNATURE-----

--gXDyfpoylppolFU2--

