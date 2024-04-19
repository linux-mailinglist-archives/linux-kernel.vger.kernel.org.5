Return-Path: <linux-kernel+bounces-151635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BDB8AB162
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC67B2246E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B077C130A7E;
	Fri, 19 Apr 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="c3GiTWQw"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83076130A49;
	Fri, 19 Apr 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539392; cv=none; b=pXcj3O7IxUK1QDizI122sosY16fraWQNZf8Vcr09VEZIoceWxwE7nqnskvu3Th+UONx+RTx/s+etJioOCYL4y4189LCCB1dU5v++iGNMagnPvwyvTyKtR5/z4wEMZW5ckrMzY2Lx9wusAJnaoRzifD9pARViUtzbP8kwlg76Z3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539392; c=relaxed/simple;
	bh=h+fwpAsM9F/f7Szlj6S/NNeA4wZQuFUyN28t89RHvCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eub8vaauP/SN7nr/cCPnhyUqIywHvx4oCmTotWd384z4UhjVQjpETUyYstjTzn7fHJqhnOGe5PYDk9DfWWtmT+ebGyVYoWRL/4CRaFYym0xq1GnwYWTRrmvEsSK9D0U4tMvNZqgNS8KSxqwB3NCNxnYGWdyTaGC1AMxUtseqsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=c3GiTWQw; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aOF3WD8/Ne6KGP9471zOOzhLuh/9R5L/lErCrkAZ57g=; b=c3GiTWQwv/dRbkIcM12O0M43SL
	4rZgofrWXACS11eeAhfY9VVFMHN/NxRH4qWKBaTpkUMl0XSv9hdtukpHWC7lRpAfenQrr599rJw5z
	Dlp+2UGCPrRhBOvCexpQAfcTn6mwbvSL9x27cqZeYgi5NGYkgEsZuiL+u60/5z5k2BE7diGDbnuQK
	+49yXltgio6KHNgSyFHcrqnghhX1iW9enyq8EZ4J3/msCarmHcSl/qu3h+wc7e6g6f9vZlJANV/AZ
	Bh18NnF/H8jlDmG+ce0bTCHOi+2ua1ztokEHHK5AIuwpjfhdhj5rie9L6C6Uc1RaQrnOsQsAiiDcF
	KNCdIctA==;
Received: from [2001:9e8:9f5:cc01:6f0:21ff:fe91:394] (port=46890 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rxps1-004AhA-EU;
	Fri, 19 Apr 2024 17:09:45 +0200
Date: Fri, 19 Apr 2024 17:09:42 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] kbuild: use $(src) instead of $(srctree)/$(src) for
 source directory
Message-ID: <ZiKJNrei7zUVaLkb@bergen.fjasle.eu>
References: <20240416121838.95427-1-masahiroy@kernel.org>
 <20240416121838.95427-5-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i0u71n+gDxHrlL+f"
Content-Disposition: inline
In-Reply-To: <20240416121838.95427-5-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--i0u71n+gDxHrlL+f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 16 Apr 2024 21:18:38 GMT, Masahiro Yamada wrote:
> Kbuild conventionally uses $(obj)/ for generated files, and $(src)/ for
> checked-in source files. It is merely a convention without any functional
> difference. In fact, $(obj) and $(src) are exactly the same, as defined
> in scripts/Makefile.build:
>=20
>     src :=3D $(obj)
>=20
> When the kernel is built in a separate output directory, $(src) does
> not match the directory in the source tree. It still works because the
> top Makefile sets VPATH to $(srctree). However, VPATH does not cover
> all cases. There are many places where the exact path to the source
> directory is needed. For example, when adding a header search path for
> local headers, it is typical to pass -I$(srctree)/$(src) to the compiler.
>=20
> However, it introduces inconsistency between upstream Makefiles and
> downstream Makefiles; when the source directory path is needed,
> $(srctree)/$(src) is used in the upstream kernel, while $(src) is used
> in external modules.
>=20
> To resolve the distortion, this commit changes the semantics of $(src)
> so that it always points to the directory in the source tree.
>=20
> Going forward, the variables used in Makefiles will work as follows:
>=20
>   $(obj)     - directory in the object tree
>   $(src)     - directory in the source tree  (changed by this commit!)
>   $(objtree) - the top of the kernel object tree
>   $(srctree) - the top of the kernel source tree
>=20
> This is a tweewide Makefile conversion for replacing $(srctree)/$(src)
> with $(src).

tweewide -> treewide

[...]
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 3bf5cab4b451..fe9ceb0d2288 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -6,11 +6,6 @@
>  # Rewritten to use lists instead of if-statements.
>  #
> =20
> -# Some driver Makefiles miss $(srctree)/ for include directive.
> -ifdef building_out_of_srctree
> -MAKEFLAGS +=3D --include-dir=3D$(srctree)
> -endif
> -

Ah, it's nice to get rid of this.

>  obj-y				+=3D cache/
>  obj-y				+=3D irqchip/
>  obj-y				+=3D bus/
[...]
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 3179747cbd2c..c53d2f168801 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -209,13 +209,13 @@ _c_flags +=3D $(if $(patsubst n%,, \
>  	-D__KCSAN_INSTRUMENT_BARRIERS__)
>  endif
> =20
> -# $(srctree)/$(src) for including checkin headers from generated source =
files
> -# $(objtree)/$(obj) for including generated headers from checkin source =
files
> +# $(src) for including checkin headers from generated source files
> +# $(obj) for including generated headers from checkin source files

this is a funny criss-cross of words; but might the following be more=20
accurate?

# $(src) for including headers from checked-in source files
# $(obj) for including generated headers




Anyway, thanks for the patch.  I think it is quite a good way forward!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--i0u71n+gDxHrlL+f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmYiiTUACgkQB1IKcBYm
Emmj6Q//cIvEL5iZu7UNYQC1sjxZ7oCAdl9f00PUES61cSQj1fcrXxz2cEdStnOw
ZKYwn8tiprhRkLmfdX+udQUlVKXKCBXIAozpdH24w706YMfBiAbw7eOqfgIP302b
BNjhMc24saIePZPYNj2EVB1IrQYNrY+R7tfF8gOtON80TgGEMYoUp54NOlzZVGAp
E9zTI1LcU1jdNg2TXh5+cWw0INy5sIIy0McSG8jPwgV04HG722MrhH/NhoFZqOi3
ajLGhaNJLfa7Yb2WPHjEVS07z2hugQd7WYU1+Fx3uUO6N6ZoCDcwEDYTibDtotUb
nFtiUQGuHDLtUZo6QI/ZB/wH7dHKp36vQqo3X19CtZwf5relCASs2KtMp4chUoZM
0Ve/JKth7JfjMGKZAsF2yluujSNiieHrxQLROgEJxd79Sk25Ks6SDcL+Nb83TqOl
QwQ9qq2qwRat8rBjSHbNiDESAhvXybbbvl2aL4+k+HluyAs1m9zBxrHpjzM9xav0
bksXUfHxgNJrk6cpVg5Lk3w/EC01nSb6W/mPnWfGgMAa72Hzk21SDw8h4/fnGdxG
wHBq7WEsWRnLwZSXf0HLz+KJAPC6At2PLldq+d1w+HUEJwM4vOxwP8x9sUBaUycm
QmmZ0Rty83AkkZLb9ncIoBRdXYagH7SZXHzEOcztIyznp8zG/Mk=
=Txrt
-----END PGP SIGNATURE-----

--i0u71n+gDxHrlL+f--

