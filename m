Return-Path: <linux-kernel+bounces-12182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C381F0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D94283BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E046546;
	Wed, 27 Dec 2023 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="jP1qtOMD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB146531;
	Wed, 27 Dec 2023 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 86E8B28B50B;
	Wed, 27 Dec 2023 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703698769;
	bh=Q3Jhggu2Cf9vToIuIzPhWolS9rBddXPT5f8JHgrhLgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jP1qtOMDXLABR0+FYgdQaI4wUueTQlUR5+ue3IhBGRXXB8p3TXk/HL4f67TMzk+Se
	 k7n/ipheB/dNC5gtyjeScIV5z7zqHqqjc6LsJhlEaqD0kWFwTV07sWRxyrmB7c1iLO
	 ZnC0BKcbRgJJEk1jL99wRpJEORHUAXNtb9sK7r2Q=
Date: Wed, 27 Dec 2023 19:39:28 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 07/10] iio: pressure: mprls0025pa.c whitespace cleanup
Message-ID: <ZYxhUJlAb63wRJE-@sunspire>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-8-petre.rodan@subdimension.ro>
 <ZYxSERlEAfwWpqWP@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9UdEwOF5KbXOTqo7"
Content-Disposition: inline
In-Reply-To: <ZYxSERlEAfwWpqWP@smile.fi.intel.com>


--9UdEwOF5KbXOTqo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 06:34:25PM +0200, Andy Shevchenko wrote:
> On Sun, Dec 24, 2023 at 04:34:52PM +0200, Petre Rodan wrote:
> > Fix indentation and whitespace in code that will not get refactored.
> >=20
> > Make URL inside comment copy-paste friendly.
>=20
> >  			return dev_err_probe(dev, ret,
> > -				"honeywell,pmin-pascal could not be read\n");
> > +				   "honeywell,pmin-pascal could not be read\n");
>=20
> As done elsewhere, here and in other similar places fix the indentation
> by making first character on the latter line to be in the same column as
> the first character after the opening parenthesis.

I triple-checked that I am following the max 80 column rule, the parenthesis
rule and the 'do not split printk messages' rules in all my code in these 1=
0 patches.
precisely so I don't get feedback like this one.
if the parenthesis rule makes the line longer then 80 chars I right-align to
column 80 as seen above.
that is what I understand from the latest coding style document and that is=
 what
I will follow.

in this particular case if I were to ignore the 80 column rule we would end=
 up on
column 90 if I were to follow your feedback (open parenthesis is at column =
45
and the error takes 45 chars more).

peter


--9UdEwOF5KbXOTqo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWMYUwACgkQzyaZmYRO
fzDlsw/6AxQVmVvwyqrKyaMsIwfXxZtjIVhHGrQgzvXJJ5DAEJCtRCnFNCx95Igx
DXGqt0uyLZbhCtl7zi6oPrRKx8mtZPetQCNMJRn3fuYOwQd+yjJ35tMo7ZjAzWj+
b+z1nPSvlGOW+TbyNy5xW3tGnR5t2BatKn/WaZlbf1CAhdwAYvXzKNkg2DLxCHBR
P1hPWa3zaSr5c9vXewjpC56tgRx2CVbxxMusXZSm3Ertu45guHWGMP93rMhZPwUR
GHRJUc39GdKQrIRl6RxVVq8r3Bprvgt7pIQ7oij4+xpXlfd4dVriCu270rHq6Poj
cJ64F1TwkWA/P4SF/dnRsgRRxFatVDa9fQv462TCUjChe8/vla+1/4VKvoBiLgnC
QHsHzbS7x2FWXonjZHHQlCbkSfzYlIpHv0vNg1wJ3ZqVFGz+T3fP/WQwDQo5TL+Z
safXwZSWo/Vtet1000ADWr2r/gau3TS2eZKSXZ0NQMNgs2Q1ayst6id/f24qpTYy
vyvAWLZCmqByLagz4l67fKky8VqnOoN/w7f6TH0u/FB2Vg/HTjfRr4qVvn6YQmtZ
5fqOzbabVaAWdFBd0Aq7Yy1mDisDbxxPML190547u0f0dyDXj7FONewG6Zl9YhRN
Mjc0uCxiJYZH+yQMeuUB8l3nuhRxSzsbifdsql5muS6ThjK6pto=
=p8mw
-----END PGP SIGNATURE-----

--9UdEwOF5KbXOTqo7--

