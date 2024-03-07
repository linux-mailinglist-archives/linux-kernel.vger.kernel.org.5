Return-Path: <linux-kernel+bounces-95437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C4F874DA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4F41C20C96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1DB12AAD4;
	Thu,  7 Mar 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PmShF53T"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C4126F39;
	Thu,  7 Mar 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811459; cv=none; b=Sscq3cOsue7I1w38+S1ZbfUXTMbh+WU1h4KO8am0cH7ueaJ6UsSYckiMZBADlY+nVTtFpfF0iXr2YdIArsFGjngYKRY+ES+wAjauNfqrsdWqx8yKMO2wwMequmbs7WMxHwsD3BR2xhfGq3Yys/boetmb24qV+dl5+YniJncU9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811459; c=relaxed/simple;
	bh=bzo9Wfyr1Xgx6msDtriXR11PddtGvGUYjz6kRXVoZDM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNbVp3eBTLuGejWoqluNCYI43HnZgYUOl1YXQTbkuK9ImDQFyyxzzYjDCLBzcnKdANHn6TPWO2UGVWZuGZiq+l3qDuVLGht8eNJ5RY8dY37McMnf5IFaOT47FNK6ytMoFjGO+w3E0WxKo1cI2WGUOWVfG11Pk2GW3f2Uav5K+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PmShF53T; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709811457; x=1741347457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bzo9Wfyr1Xgx6msDtriXR11PddtGvGUYjz6kRXVoZDM=;
  b=PmShF53TzEnTKURp0YrmEXQjzMYTWOiKykI0gZ+jO/9nN9Mqv1mpQkbB
   pBWwxVhJfk84vMxShCTKMBtBPDSI/DykKU8VIIOpdmnbgk6r6fee4rY2f
   CwwYkn8fXAh2MAAlzUR8anAuGqbbeAl6j736s5Ji0u3k8CSuVPdLYmkJN
   71P1x4plIfz8e7bGpQmaqt9mDYP//3xg4k9GlrKlMyOZwa1RqPMMiS/oC
   FZ+3CZq5LRucBvTJvxvmrf1GrU7/0CkeiVYZrwNBlr8jgHx5LjBHa2LqP
   CSv8Gk8F7wqlKyR7eLiZQUtueoazIPbfButUoMtsCATo7uE23q/QVOJkv
   w==;
X-CSE-ConnectionGUID: vGKddyPVT5y+FgobIIh7Vw==
X-CSE-MsgGUID: kumRBleARg+kz1/1CMIDRA==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="asc'?scan'208";a="17329607"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 04:37:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 04:36:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Mar 2024 04:36:22 -0700
Date: Thu, 7 Mar 2024 11:35:37 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Stefan Berger <stefanb@linux.ibm.com>
CC: <mpe@ellerman.id.au>, <linux-integrity@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<jarkko@kernel.org>, <rnsastry@linux.ibm.com>, <peterhuewe@gmx.de>,
	<viparash@in.ibm.com>
Subject: Re: [PATCH 2/2] tpm: of: If available Use linux,sml-log to get the
 log and its size
Message-ID: <20240307-chill-roundup-44a73c50aebc@wendy>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-3-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pGsz+08ahPIBPDcV"
Content-Disposition: inline
In-Reply-To: <20240306155511.974517-3-stefanb@linux.ibm.com>

--pGsz+08ahPIBPDcV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 10:55:11AM -0500, Stefan Berger wrote:
> If linux,sml-log is available use it to get the TPM log rather than the
> pointer found in linux,sml-base. This resolves an issue on PowerVM and KVM
> on Power where after a kexec the memory pointed to by linux,sml-base may
> have been corrupted. Also, linux,sml-log has replaced linux,sml-base and
> linux,sml-size on these two platforms.

Those two properties are documented, but linux,sml-log is not, nor can I
find patches on the list documenting it.
There should be a patch adding this to tmp-common.yaml.

Cheers,
Conor.

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/of.c | 36 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/o=
f.c
> index 930fe43d5daf..e37196e64ef1 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -54,8 +54,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	const u32 *sizep;
>  	const u64 *basep;
>  	struct tpm_bios_log *log;
> +	const void *logp;
>  	u32 size;
> -	u64 base;
> =20
>  	log =3D &chip->log;
>  	if (chip->dev.parent && chip->dev.parent->of_node)
> @@ -66,37 +66,23 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	if (of_property_read_bool(np, "powered-while-suspended"))
>  		chip->flags |=3D TPM_CHIP_FLAG_ALWAYS_POWERED;
> =20
> -	sizep =3D of_get_property(np, "linux,sml-size", NULL);
> -	basep =3D of_get_property(np, "linux,sml-base", NULL);
> -	if (sizep =3D=3D NULL && basep =3D=3D NULL)
> -		return tpm_read_log_memory_region(chip);
> -	if (sizep =3D=3D NULL || basep =3D=3D NULL)
> -		return -EIO;
> -
> -	/*
> -	 * For both vtpm/tpm, firmware has log addr and log size in big
> -	 * endian format. But in case of vtpm, there is a method called
> -	 * sml-handover which is run during kernel init even before
> -	 * device tree is setup. This sml-handover function takes care
> -	 * of endianness and writes to sml-base and sml-size in little
> -	 * endian format. For this reason, vtpm doesn't need conversion
> -	 * but physical tpm needs the conversion.
> -	 */
> -	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> -	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> +	logp =3D of_get_property(np, "linux,sml-log", &size);
> +	if (logp =3D=3D NULL) {
> +		sizep =3D of_get_property(np, "linux,sml-size", NULL);
> +		basep =3D of_get_property(np, "linux,sml-base", NULL);
> +		if (sizep =3D=3D NULL && basep =3D=3D NULL)
> +			return tpm_read_log_memory_region(chip);
> +		if (sizep =3D=3D NULL || basep =3D=3D NULL)
> +			return -EIO;
> +		logp =3D __va(be64_to_cpup((__force __be64 *)basep));
>  		size =3D be32_to_cpup((__force __be32 *)sizep);
> -		base =3D be64_to_cpup((__force __be64 *)basep);
> -	} else {
> -		size =3D *sizep;
> -		base =3D *basep;
>  	}
> -
>  	if (size =3D=3D 0) {
>  		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
>  		return -EIO;
>  	}
> =20
> -	log->bios_event_log =3D devm_kmemdup(&chip->dev, __va(base), size, GFP_=
KERNEL);
> +	log->bios_event_log =3D devm_kmemdup(&chip->dev, logp, size, GFP_KERNEL=
);
>  	if (!log->bios_event_log)
>  		return -ENOMEM;
> =20
> --=20
> 2.43.0
>=20

--pGsz+08ahPIBPDcV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZemmegAKCRB4tDGHoIJi
0geZAQDRqcSLRqXvICr64TJ1WsNpahDiNbtCA9bLKrnnkQKChwEAqoh88ZpfefYJ
7KQ6U0WmddS80c0+qFeqxjEqa1WH5gM=
=oHvc
-----END PGP SIGNATURE-----

--pGsz+08ahPIBPDcV--

