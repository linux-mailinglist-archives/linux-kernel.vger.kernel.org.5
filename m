Return-Path: <linux-kernel+bounces-12710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6113481F934
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648B91C21A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748B2CA7A;
	Thu, 28 Dec 2023 14:47:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14646C8C2;
	Thu, 28 Dec 2023 14:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CA2C433C7;
	Thu, 28 Dec 2023 14:47:00 +0000 (UTC)
Date: Thu, 28 Dec 2023 09:46:57 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] counter: linux/counter.h: fix Excess kernel-doc
 description warning
Message-ID: <ZY2KYemBCrl7YwrP@ishi>
References: <20231223050511.13849-1-rdunlap@infradead.org>
 <ZYw2SkkEzSW2C2gN@ubuntu-server-vm-macos>
 <d752d157-659b-4d05-90a9-ebbf19c07068@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cv3hjeTS7H5THrLU"
Content-Disposition: inline
In-Reply-To: <d752d157-659b-4d05-90a9-ebbf19c07068@infradead.org>


--Cv3hjeTS7H5THrLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 01:40:01PM -0800, Randy Dunlap wrote:
>=20
>=20
> On 12/27/23 06:35, William Breathitt Gray wrote:
> > On Fri, Dec 22, 2023 at 09:05:11PM -0800, Randy Dunlap wrote:
> >> Remove the @priv: line to prevent the kernel-doc warning:
> >>
> >> include/linux/counter.h:400: warning: Excess struct member 'priv' desc=
ription in 'counter_device'
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: William Breathitt Gray <william.gray@linaro.org>
> >> Cc: linux-iio@vger.kernel.org
> >> ---
> >>  include/linux/counter.h |    1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff -- a/include/linux/counter.h b/include/linux/counter.h
> >> --- a/include/linux/counter.h
> >> +++ b/include/linux/counter.h
> >> @@ -359,7 +359,6 @@ struct counter_ops {
> >>   * @num_counts:		number of Counts specified in @counts
> >>   * @ext:		optional array of Counter device extensions
> >>   * @num_ext:		number of Counter device extensions specified in @ext
> >> - * @priv:		optional private data supplied by driver
> >>   * @dev:		internal device structure
> >>   * @chrdev:		internal character device structure
> >>   * @events_list:	list of current watching Counter events
> >=20
> > Hi Randy,
> >=20
> > Would you provide a Fixes tag for the commit that removed the 'priv'
> > member so we can track when this warning appeared? You can respond with
> > it to this thread and I'll add it in when I merge your patch.
>=20
> Fixes: f2ee4759fb70 ("counter: remove old and now unused registration API=
")
>=20
> Thank you.
>=20
> --=20
> #Randy

Applied, thanks!

[1/1] counter: linux/counter.h: fix Excess kernel-doc description warning
      commit: 49ca40f8d6ceb76bff83713f79215d8e6252f045

William Breathitt Gray

--Cv3hjeTS7H5THrLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZY2KYQAKCRC1SFbKvhIj
K8I3AP4mGbr+wtyRDo1GphV/Mqi26l7KwWRm5pnhhSCdo19tTQEAtJ8TKXYmZ4a8
erikOulmMaHyp3q5WHk9hw9MJmKWlQ0=
=kQuO
-----END PGP SIGNATURE-----

--Cv3hjeTS7H5THrLU--

