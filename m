Return-Path: <linux-kernel+bounces-151634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4488D8AB160
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01263284CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB54D12FF83;
	Fri, 19 Apr 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="Yb0iQ9uT"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8837E11E;
	Fri, 19 Apr 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539386; cv=none; b=T5VXk18x46cxEfnDyvar0ZyXZ0yP5gvfwunP23OOLzWXhHbk9Wpbtv6h3t1grfzdjB6FxOYOWI5jisBWL77V91kGOzPRBFPbfsjvYQ9F36s2JkV8zNjDKS8Iz3/mcbTnSDLAAa/9165j30To8fZ+dzugIhZfVnNJuHz4Bqb2RbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539386; c=relaxed/simple;
	bh=GkmOldRrmFVHxIp770IbU5zteXyXCmHeafYSEoFWihw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOzwY8qwyYnY92oQZwC/AyqX/KAp/Hv7M3+a2i5A4es9Z4blwzipA4vnwat3LKMwHb2hhiANUXB4zzJxQktv5QE4+w37eW50s04YESxX6w/Nv0/GbzuusDFQKCZC64Ila7queQnAZeSzEnZLVqHcdkRtU/P9JmjZO3JHXEGVPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=Yb0iQ9uT; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZnmSAWWYJEOgk0x27XufixVUQkAvIneONThu0c2jpJs=; b=Yb0iQ9uTHXIc8LY8Nf5v/laeV6
	LyuUmZhC6EZRJ9tHNPfdP8Bi+YXy8BpvCmiq4Rr48/QEio29nf5ohBiRQUE7cj/OYP8KVdDHFex8a
	owULukRTJW5fUgObp/KiB1m27RR5JX4WZHWtVDPTno/RYX8jbX6Q3teDKLHAF4gVTLXCPYX/G7erI
	QKp7eQopshHfVISsEKhRAhTwXuqoBvaD3v+1fbnalUe8fP/18ehigcGr5HzEupLcyHxTF720e+CgH
	HlWEtt/VYty4wUMtOBxV5Zw1UFdMAOg4xxtfZOq+Yr/sJBXrczCCzud5wODNtH8NqiYjUgb7Q73uH
	X9iVkdjQ==;
Received: from [2001:9e8:9f5:cc01:6f0:21ff:fe91:394] (port=35496 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rxprn-004Ad7-PX;
	Fri, 19 Apr 2024 17:09:31 +0200
Date: Fri, 19 Apr 2024 17:09:28 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] kbuild: use $(obj)/ instead of $(src)/ for pattern
 rules for %.[cS]
Message-ID: <ZiKJKFiJ1rtJyHjM@bergen.fjasle.eu>
References: <20240416121838.95427-1-masahiroy@kernel.org>
 <20240416121838.95427-4-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y9/E1gHvgvc4kx9j"
Content-Disposition: inline
In-Reply-To: <20240416121838.95427-4-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--Y9/E1gHvgvc4kx9j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 16 Apr 2024 21:18:37 GMT, Masahiro Yamada wrote:
> Kbuild conventionally uses $(obj)/ for generated files, and $(src)/ for
> checked-in source files. It is merely a convention without any functional
> difference. In fact, $(obj) and $(src) are exactly the same, as defined
> in scripts/Makefile.build:
>=20
>   src :=3D $(obj)
>=20
> Before changing the semantics of $(src) in the next commit, this commit
> replaces $(obj)/ with $(src)/ in pattern rules where the prerequisite
> might be a generated file.

thanks.  That's a good idea to split both steps.

> C and assembly files are sometimes generated by tools, so they could
> be either generated files or real sources. The $(obj)/ prefix works
> for both cases with the help of VPATH.
>=20
> As mentioned above, $(obj) and $(src) are the same at this point, hence
> this commit has no functional change.
>=20
> I did not modify scripts/Makefile.userprogs because there is no use
> case where userspace C files are generated.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--Y9/E1gHvgvc4kx9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmYiiScACgkQB1IKcBYm
EmlXpg//YUp1X17oIcSK4w0lHCy6zwMhBi/wizM1BFDARed1bhLj2beqVnEstfN+
VgFCPujQYP7hxyQ5UuRXMr3ddxdUPk4nGva7+oUWO4AGfosA08QvD8BwJMlwzoH7
8tEB7WVEeQM1romvXV9mQgceL4I69mmPmO830zAaETXsy+Lqvq/GUTQm8h07lGIZ
NTYyhk0KXWFtmJ+MVDzMnGxe3GJ8mcTUIcZbu/MPJsaf3jbrDp1QHmF7kdae7APP
BTYwheqUMnO+yNxm5iEOJ6ykh/gXPhQp974mgOF4LhQMFUik55g1CO9T1WYwYybG
H5d05QCbdsxprMSiZu5fxGpO84WEwjCFbYIBGvN1P/NaUTe97YAz9paJc/eUnR4p
On4ixHn0LwH2vuN9mf0jadcLO6drBXnOD7UZOTVmdrkHSeIPgYQpdhkvKGEtvTac
JmdBer1+2VLnXONiTK85Q49F9DpQ1y9vk8dioYbKQ2eu0RJZU8XKWX3mccxNLhb8
Bc3ei3nkqY/adWea9DDjNFy9CrwppDNUUQVsp9B8eSwnDwUMhBx9qvuginSv3juz
PDIQK65OpZZS1Ux3vN0p30n8rNJ0AtFE7tmDs4fXZPD/SgpJCc+YmTwqVn16rZ+V
dCTs2a7rmtGTXJfVMdPjAozUP5dL08XjSxAnNPu/ZP5AmrjCXDo=
=fQnb
-----END PGP SIGNATURE-----

--Y9/E1gHvgvc4kx9j--

