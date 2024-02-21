Return-Path: <linux-kernel+bounces-74976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2285E0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C311C23062
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1A781211;
	Wed, 21 Feb 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="PJi/yWQg"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF77BB10;
	Wed, 21 Feb 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528334; cv=none; b=SdLVVxoPiK4GfiGjr2E0nnngYtYC8kfqOohggXxlG67a4sNliWfvBDWPvPIoPqYc9Ch+cGzkvR02J+2HC0CcufAxmApvT5KDPDDeejjD5K4A36P6esZYwYG5uAB5sZYItz9nNEnxddSiccsp48WCtu5LJ/EZIniO6gWhGjVDSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528334; c=relaxed/simple;
	bh=6Fh7lpaC6pNfSFrltqbIXgLkWxOT6eywJS4r6URXbGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jkw1xHlthSXzE72BX8R1EOunExrD5osDh3S/uoZBaXaGoNwl8/td9aRYMFm8BK+ssZrPLJYuoaM9aaqOFDSqklyOp+DteyPOYtiE95f1jOPjN6rpuhAYJPG1vobJ9JSBYkbOtei92Xc2+1Wb81amjF0we7yxLe8913djXwivvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=PJi/yWQg; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8OXzSw7Lbz7R+v639wcrlzlha3nK0uEfq5ZdlSY7S9w=; b=PJi/yWQgTvd+YJLdjTOYDlleCn
	Tkt73178X7GXBrOZhTs5oH9nhqyMA0fbkmqCEZuODGkGqoBJI685o+LYz4g2xBkiUR1vncRg47tjW
	Xdojrno4ZK4enOxERxn2j0oQzgOQMEn+vSmrbFXvS4BfHNTA1xeR/lbW2gkSNQStCVOiFTTTBSe7j
	gXdmw1Om8QUBZg2T5ZxPjlA93+3A+GEJOt3gs5SRAUXztAyJcGIUU2e4KERFZpmx6D2FOEdXZ8DUZ
	WhxbhiZgdgurwfUtpPIpuHw7u2RFIhXM5c8t7OMQ0WUjnT2Myb0sIev2CsZc53bk27rAaLI7wK7tG
	fMzESG7A==;
Received: from dynamic-176-000-161-131.176.0.pool.telefonica.de ([176.0.161.131]:27360 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rcoGS-00DO5M-8M;
	Wed, 21 Feb 2024 16:12:04 +0100
Date: Wed, 21 Feb 2024 16:12:00 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kbuild: change DTC_FLAGS_<basetarget>.o to take the
 path relative to $(obj)
Message-ID: <ZdYSwGUlOpGdAFVU@bergen.fjasle.eu>
References: <20240217055504.2059803-1-masahiroy@kernel.org>
 <20240217055504.2059803-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="na7oD77FSrV7Zoi7"
Content-Disposition: inline
In-Reply-To: <20240217055504.2059803-2-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--na7oD77FSrV7Zoi7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 17 Feb 2024 14:55:04 GMT, Masahiro Yamada wrote:
> For the same rationale as commit 54b8ae66ae1a ("kbuild: change
> *FLAGS_<basetarget>.o to take the path relative to $(obj)").
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 328c0d77ed48..56f7fe2b476d 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -368,7 +368,7 @@ DTC_FLAGS +=3D -Wnode_name_chars_strict \
>  	-Wunique_unit_address
>  endif
> =20
> -DTC_FLAGS +=3D $(DTC_FLAGS_$(basetarget))
> +DTC_FLAGS +=3D $(DTC_FLAGS_$(target-stem))
> =20
>  # Set -@ if the target is a base DTB that overlay is applied onto
>  DTC_FLAGS +=3D $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), =
-@)
> --=20
> 2.40.1
>=20
>=20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--na7oD77FSrV7Zoi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXWEsAACgkQB1IKcBYm
Emm7Zw//bbaXDl+Kl5/Xx+uGvpJQJSvBMGDA8izA45IOGNeSK8/0HPitNQiVWDEh
McJc9oVxm64BAl0ilHeHJGCgatlaaR3Mp4ysquu6fLUltPOp74DeVNCBV4l8BgFW
SGCs46fIx1sF/v6u9YxYVKmDJPuJzPLNy8PgtE3xy4UcALAaesle4pN4rd7vu4HZ
vS4cEALbP8Hdp/vLdVK5Fd6QYmeAbO8s8vqzC+Q8TZsPtCMzxbN8/kLXXUrPpoog
j8o8cYzZg/bH/zJioNk8dQeP44zh/q3LMiM4w1Zpv0JNsxj9uvjPryMxhxqgH1RF
FazT/u7HRHmiPcbkJsMewhwU7cUoaELPIqtRxQ0wfWReOxRSyoZqDXmtgtaEx10S
6C0uZSg7USJjF+DRHKzm2Nk8NnKiZFP9ddpskzC4/+GbBDJJihfssodFfKHT+Uie
ptt0Za4jfeRz/pCrLhNDyJUGogqtcGSICxighMiIy1eZ17ySVMD6h18W4mE7VJbQ
M0kZC4/VLeLN7dQ0bMZdcvd9C9JQzzWic7DFoYCAbB3E6GKPMg2Iua1a3tqlo2TP
pa8g0iFJmQqAUyqCV7mEBGf1sG7AlNGX/LYruAX9bkNoAfIOxu48CmMx2N9UO8PQ
497DiBpodajTKbb//t1arP4Y2CHNn1kPbk5M4OJZl1pePJzycUI=
=9nFd
-----END PGP SIGNATURE-----

--na7oD77FSrV7Zoi7--

