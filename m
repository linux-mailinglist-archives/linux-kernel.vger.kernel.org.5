Return-Path: <linux-kernel+bounces-90359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316DC86FE12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04B1B21F3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7812208A;
	Mon,  4 Mar 2024 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oo/ttSbX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2BF219E2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546034; cv=none; b=g3t+tTJzBeYUoJUvllWTKcQXglFNrGxsr4gztqgaqAG1WElqIKp4VHrzJqXWIrxpIFq7/r7fgPAQoBjejxqqwf0cCewa1uj+sl1Py7Bs/VsmSQ9S18NPW/xXarXsPV3i/ARSkq2mzkXEOHCeCNb9zZr1tMniUtrfXDIEBQr3mFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546034; c=relaxed/simple;
	bh=AdFn9XLJWQqe0dLUDaSJYnhDPaicR7vWmLQPaoGeX3w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDsLEOYJgNZBhUzXTBr1qk2zv5323hNC4jKVvQq0PcrAnq+OrVjHgGA+m1O8Xms+q7wkaNFG4zS1FlP6K2S7QW/+zFooryUSg4Msg6QLoWM7wG2fiI1c1Xc1lDnk5hte7X4nCLCqM14a64+o67g1n0dwQ7UPJWq3BY+gFKtV+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oo/ttSbX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709546031; x=1741082031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AdFn9XLJWQqe0dLUDaSJYnhDPaicR7vWmLQPaoGeX3w=;
  b=oo/ttSbXns+04twPj1JGh0zfGrDwRUfAUspFBXOJcBj+ZzwShHRRJ0GZ
   DIdPRSgEHMvDET9EYXqxvaiQOmw4O5oe4C167uN/Ld4JKzWBA35fvBzmz
   ayOfPZFLkeVYhnBfLMglWIED9Jyh37G4q4M7GVRMXfNBtQGxbHCbRzNDX
   npDwY4pf4A6w7co6fz+HI+t823kxoJNei87vZ536Vzpuz2SFMn5KdwijH
   z8oGovpyKdOfE++RzyHTNZCHZnehTtZXVJxF70iZlvKbzq1FFkdgcqJw5
   Gh8LhCp38+cDcaoZeq46uD6wptIoDVgSoG9KvBP6ALGJfOW4hmKcscCAf
   w==;
X-CSE-ConnectionGUID: ZJsDVXyFTta/H+MNZycEbA==
X-CSE-MsgGUID: 0T2mkppsRHm+zl/8ZK18Og==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="asc'?scan'208";a="17149560"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 02:53:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 02:53:37 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 4 Mar 2024 02:53:36 -0700
Date: Mon, 4 Mar 2024 09:52:52 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Dawei Li <dawei.li@shingroup.cn>
CC: <daire.mcnamara@microchip.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] firmware: microchip: Fix over-requested allocation size
Message-ID: <20240304-dislike-enchanted-bab883cdd609@wendy>
References: <20240304092532.125751-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QfI9bt87W6Fw+2hP"
Content-Disposition: inline
In-Reply-To: <20240304092532.125751-1-dawei.li@shingroup.cn>

--QfI9bt87W6Fw+2hP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Mar 04, 2024 at 05:25:32PM +0800, Dawei Li wrote:
> cocci warnings: (new ones prefixed by >>)
> >> drivers/firmware/microchip/mpfs-auto-update.c:387:72-78:
>    ERROR: application of sizeof to pointer
>    drivers/firmware/microchip/mpfs-auto-update.c:170:72-78:
>    ERROR: application of sizeof to pointer
>=20
> response_msg is a pointer to u32, so the size of element it points to is
> supposed to be a multiple of sizeof(u32), rather than sizeof(u32 *).
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403040516.CYxoWTXw-lkp@i=
ntel.com/
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/firmware/microchip/mpfs-auto-update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firm=
ware/microchip/mpfs-auto-update.c
> index 682e417be5a3..7ea3cdb917bc 100644
> --- a/drivers/firmware/microchip/mpfs-auto-update.c
> +++ b/drivers/firmware/microchip/mpfs-auto-update.c
> @@ -384,7 +384,7 @@ static int mpfs_auto_update_available(struct mpfs_aut=
o_update_priv *priv)
>  	u32 *response_msg;
>  	int ret;
> =20
> -	response_msg =3D devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE =
* sizeof(response_msg),
> +	response_msg =3D devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE =
* sizeof(u32),

Why not use `sizeof(*response_msg)`?

Cheers,
Conor.

>  				    GFP_KERNEL);
>  	if (!response_msg)
>  		return -ENOMEM;
> --=20
> 2.27.0
>=20

--QfI9bt87W6Fw+2hP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeWZ8wAKCRB4tDGHoIJi
0gNkAQDrYx1n8zCrpLlvIsxyn7lq+cHSOFFk09yS527hkWOx1QD/XtVUb9uF9ym5
eciZRxHMosB+KXsKQLAG2/26fBdUXQQ=
=uSlh
-----END PGP SIGNATURE-----

--QfI9bt87W6Fw+2hP--

