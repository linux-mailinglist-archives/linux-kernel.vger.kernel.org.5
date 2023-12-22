Return-Path: <linux-kernel+bounces-9728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7081CA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5121F22DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2418644;
	Fri, 22 Dec 2023 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="wFebiXkN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A301A58A;
	Fri, 22 Dec 2023 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 22 Dec 2023 13:52:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1703249536; bh=YIMXG/DxHkwVA+7xM1G0QeOvCKff0MazCGRcIMJGpXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wFebiXkNwgDr3z9Pc/XI7+lvYRKHb6G/jPqqhFTX/zDQrKqE1fXtKYkbLF6MbU1D/
	 wdXYnvcossQriALIZEgA8nKogjXhUILQV9UgLSVOC0GFBFObUrQMFFd0/FniLen6ag
	 dKXBGDovQa1oeKe6F5UfHdIWWfgnFDA6xEEtdUaw=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 51BE080530;
	Fri, 22 Dec 2023 13:52:16 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 44827180D04; Fri, 22 Dec 2023 13:52:16 +0100 (CET)
Date: Fri, 22 Dec 2023 13:52:13 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: deb-pkg: split debian/copyright
Message-ID: <ZYWGgOgGpMwqqes9@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231219154049.1095323-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AV4v1089STg1Gpva"
Content-Disposition: inline
In-Reply-To: <20231219154049.1095323-1-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1703249536-E955C5FF-6427EEE6/0/0
X-purgate-type: clean
X-purgate-size: 4656
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean


--AV4v1089STg1Gpva
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Dec 2023 13:52:13 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: deb-pkg: split debian/copyright

On Wed, Dec 20, 2023 at 12:40:49AM +0900, Masahiro Yamada wrote:
> Copy debian/copyright instead of generating it by the 'cat' command.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

> Subject: Re: [PATCH] kbuild: deb-pkg: split debian/copyright

With 'split' in the patch summary I had expected something different;
but cp instead of cat seems quite reasonable.

Reviewed-by: Nicolas Schier <n.schier@avm.de>


>=20
>  scripts/package/debian/copyright | 16 ++++++++++++++++
>  scripts/package/mkdebian         | 21 +--------------------
>  2 files changed, 17 insertions(+), 20 deletions(-)
>  create mode 100644 scripts/package/debian/copyright
>=20
> diff --git a/scripts/package/debian/copyright b/scripts/package/debian/co=
pyright
> new file mode 100644
> index 000000000000..388a204b0b2b
> --- /dev/null
> +++ b/scripts/package/debian/copyright
> @@ -0,0 +1,16 @@
> +This is a packaged upstream version of the Linux kernel.
> +
> +The sources may be found at most Linux archive sites, including:
> +https://www.kernel.org/pub/linux/kernel
> +
> +Copyright: 1991 - 2018 Linus Torvalds and others.
> +
> +The git repository for mainline kernel development is at:
> +git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; version 2 dated June, 1991.
> +
> +On Debian GNU/Linux systems, the complete text of the GNU General Public
> +License version 2 can be found in `/usr/share/common-licenses/GPL-2'.
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index c1a36da85e84..91f0e09600b1 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -188,26 +188,6 @@ $sourcename ($packageversion) $distribution; urgency=
=3Dlow
>   -- $maintainer  $(date -R)
>  EOF
> =20
> -# Generate copyright file
> -cat <<EOF > debian/copyright
> -This is a packaged upstream version of the Linux kernel.
> -
> -The sources may be found at most Linux archive sites, including:
> -https://www.kernel.org/pub/linux/kernel
> -
> -Copyright: 1991 - 2018 Linus Torvalds and others.
> -
> -The git repository for mainline kernel development is at:
> -git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> -
> -    This program is free software; you can redistribute it and/or modify
> -    it under the terms of the GNU General Public License as published by
> -    the Free Software Foundation; version 2 dated June, 1991.
> -
> -On Debian GNU/Linux systems, the complete text of the GNU General Public
> -License version 2 can be found in \`/usr/share/common-licenses/GPL-2'.
> -EOF
> -
>  # Generate a control file
>  cat <<EOF > debian/control
>  Source: $sourcename
> @@ -268,6 +248,7 @@ ARCH :=3D ${ARCH}
>  KERNELRELEASE :=3D ${KERNELRELEASE}
>  EOF
> =20
> +cp "${srctree}/scripts/package/debian/copyright" debian/
>  cp "${srctree}/scripts/package/debian/rules" debian/
> =20
>  exit 0
> --=20
> 2.40.1
>=20

--AV4v1089STg1Gpva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmWFhn0ACgkQiMa8nIia
bbgvrxAAlvytjl9RiaAEPfgwtdCr6X+6cs7sZeyUySjG4gdoiUHedh/gcoQftGqH
Rwkr/V1CXCetpgwgzYLWdfE+IHTLjiI9MBIOf7KqZX+M8RTYj2D13bhb5ncV75yd
ruvwlMg9emWAk8n7BDosdVrppBETw77QQ264GuEDYex1txaJq02t7ZuHHH5Hg+L8
y9OiukBmiOBmY5ZvOITq9AXtq/aRuQ3KZhdyYoivuj1TqngeRtvkVhMzZl/ww+5t
QW5imJkEQb4XXQn05JRUNLcSS682V/rtLkx2Pvas2mNgNyiFq01LCSHInQuT+Zk4
ptkRL9JE1FgtX9Ew8ZaE/65FySa7dDlW/zZJNl6WFKbrMXOJCa1SJ0ciGkGghWjv
fBRGbarWn7pVVEDIU1jNttTOdSbKInwp0uX0tm+N1BSkPHEGRbcfb/MgZeTGVs80
gSZiPv6E1Nd2ZfaNHs/syMbe9lhBLL6PSWwgCPFVYqTLuNRsT14rcYtfVk4N2BqU
iXoDd2sYOmqsZn3h8ssQyHNYykCf+l5kkz/cdmxt3+WyQWhbZ3dYEbQLBdLcVfT+
d7dZDKCg6thGu7N/1iC9J9EipDEHIute6VC2wFFLO91zjqgJYdryY6L54ufg7WvD
Q4Dfk2iDpvYYnfgQPsnZ5pbaSa12MIfw4o8eUynBh8G2ndf7UcE=
=77rk
-----END PGP SIGNATURE-----

--AV4v1089STg1Gpva--

