Return-Path: <linux-kernel+bounces-149149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392118A8C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F54B248CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8A6A00F;
	Wed, 17 Apr 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="HC2IFy++"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7B482DB;
	Wed, 17 Apr 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384101; cv=none; b=A71a+G25qf7g+DVR3kiTXF32LXSqgkXgRQxRbzcwjl+xkNc0sL1XnmXHUiqi+VTXCF5FMiDQd3YbUbIHGvQpbmCw0irABMU/cpAUpF3M+CS3jg6vS57yyVmfuoAo4eJ6G/FJ0oHJ7zGxOYpXF+sD0eikjtpsW12j14DXBzJBiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384101; c=relaxed/simple;
	bh=C7UOGz4cfMuUlgzQCx0ka8A1vycTIcJZk/BYF5U5pwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOasRSqXIJ0ZjfRwVHdrVsbO1XFqUCGpUoHBUFKPr+geCozGfR1RRskfexbOKYJ3awEFz0dccCDu4HXeHoOzug7Bw/601c17TW7oA6y2ucaPoUFhHiGAuo0+sIpTRhMJPeBHfiHfVYFEe4UBe0Q5nGNDyMfmZDg3TvWwh1YQyIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=HC2IFy++; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C7UOGz4cfMuUlgzQCx0ka8A1vycTIcJZk/BYF5U5pwA=; b=HC2IFy++2Z/KFfCvOBBSgz0+YU
	Qh6O1lghVKnLxii3U72e6jpyeMAPzt1C4cih21Ms9FAz+oAZrzva931eMyUdIifIe48V5UhCczHGi
	LDNuDcOOk5DvF9Doj7KCkE3gGcreOYjuS2xoUo4hVLh1Csy4PxvS2fCJJSZ05SLFdlVac331ZLVH8
	EvQejIVV5iNYw6SVppD9wz/vtMerqeIJFbDZR6X9TZUP/N0Pec6v8E1ykfPk+W/dakPk+h7h6Jm0n
	d5M6+/7/dVthAWw6eS0EvfXAw/kOR8XOZvK3k3Np2F2PHyKNStU1kvBmpBkFzWmsYkGtfL6s/sfBE
	KDch3bAQ==;
Received: from [2001:9e8:9e8:6e01:6f0:21ff:fe91:394] (port=58278 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rxB5o-001R6W-V3;
	Wed, 17 Apr 2024 21:37:17 +0200
Date: Wed, 17 Apr 2024 21:37:08 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] kbuild: buildtar: add comments about inconsistent
 package generation
Message-ID: <ZiAk5Ikh-UFZ2554@bergen.fjasle.eu>
References: <20240414174139.3001175-1-masahiroy@kernel.org>
 <CAK7LNATqLwewFaMNEy6yDguv5mNoGZJus9p4kbyMOGV9T+yopQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9IC+ahEzzWfG8TN+"
Content-Disposition: inline
In-Reply-To: <CAK7LNATqLwewFaMNEy6yDguv5mNoGZJus9p4kbyMOGV9T+yopQ@mail.gmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--9IC+ahEzzWfG8TN+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 16 Apr 2024 11:07:48 GMT, Masahiro Yamada wrote:
> On Mon, Apr 15, 2024 at 2:42=E2=80=AFAM Masahiro Yamada=20
> <masahiroy@kernel.org> wrote:
> >
> > scripts/package/buildtar checks some kernel packages, and copies the
> > first image found. This may potentially produce an inconsistent (and
> > possibly wrong) package.
> >
> > For instance, the for-loop for arm64 checks Image.{bz2,gz,lz4,lzma,lzo},
> > and vmlinuz.efi, then copies the first image found, which might be a
> > stale image.
> >
> > When CONFIG_EFI_ZBOOT is enabled in the pristine source tree,
> > 'make ARCH=3Darm64 tar-pkg' will build and copy vmlinuz.efi. This is the
> > expected behavior.
> >
> > If you build the kernel with CONFIG_EFI_ZBOOT, Image.gz will be created,
>=20
>=20
> The correct sentence is
>=20
> If you build the kernel with CONFIG_EFI_ZBOOT disabled, ...

Thanks, I appreciate the detailed descriptions and comments.=20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Kind regards,
Nicolas


--9IC+ahEzzWfG8TN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmYgJN4ACgkQB1IKcBYm
Emm0+Q/5AaKrBHVyleIlKiQPc4+aVIWSJxINp1Rz8+XO54115MSL2/9lnUvVKzO9
/cDZfsC/lFwPRtICfXww9fqPgNWKeDpKRlIKH/KcfUpS8igt5gFSx+PbOO8lfKib
67FFL/WTN3reNzMt/aRTWIoSmtz8euPWFBV2534sHwtigniZGULmfwCzAMgFIMZe
glW8iGGOddQCo4veXdLLiOspuEis1NAeNLD0ziAcREud4LF7z3XBOfMRzng7vQwk
RavQoqTJWCdVo3ROuCYkeS+T56RyzibuVZB2CNhCLZ9pjfgr2ghf7hgE3grGfakv
BnPsrKaY5HDjOKgee1kR3CNSFZF0/7hgaOkqGzLjndwEWcxcKYhXVxrs3gpIkojX
2uvEJ5o23chY3odVNNKGJ+sM0MbuRHN50ewj9rZY0zFFpEnEyXMW63/GbV0zyH13
QWjwG0taC2ur6q7CqVIFUGszTlhfoEBw6i0dBhL1URvzkvpBHezOzMWQPpU8zMgd
nKp5V1EhvYUNcFSumykYwaFUZfW37WQrQoAV4YDmXiEOBZSDrWftnOHFzZ1nPUbB
Jf7QfvTFX/Y06w+nk7JMK/3zPZ4W0Hema5YzJI31rwAnDZ3tsoPLN8DdrT782QwM
UVwML0pd5QAuHCcj8Y/98nHKWxMxS8b2dLR8gZmi7Cn3bI3Jkrs=
=bEWj
-----END PGP SIGNATURE-----

--9IC+ahEzzWfG8TN+--

