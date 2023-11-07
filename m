Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000327E4DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjKGX5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKGX5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:57:32 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F6810CB;
        Tue,  7 Nov 2023 15:57:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso5224020b3a.2;
        Tue, 07 Nov 2023 15:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699401450; x=1700006250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2KudK+PVMmmjq0H50mDCqvHMKAjy6NjrP5mENlT6IeI=;
        b=Issc4m10xbvGuyhqHqTlnFbviQGvIXXWDpSNzuuBLb7w5zJWSvNyO+TL9fEVCL8BP2
         204t/haBG/XvRpA/pDWuq19iSjK6xQ23F/P/JcDLhnDRM/JzDchtQNCvgw5O1eEgplfp
         ArGPNjdyWhB0gHUgMvwRCVG6Lx9ahcSFigVJxqc+kqzgg+vRbG1FOv0Hgr9djDChrKEp
         qm5C/wVGBuYex0+pAciePuOMIJ7H2be/pSbsYRctgDEUwrys6ZVndrPA3FyPiQt4xgzc
         VC1qfjDod7GGmkqXt5DJdJleC0D3i4iwkprZt5Q7xgxOC4CoJeREws0SaIgbKO52Nj6F
         IZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699401450; x=1700006250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KudK+PVMmmjq0H50mDCqvHMKAjy6NjrP5mENlT6IeI=;
        b=lA/5iKzKPOviPNB3Dao/doxaF2MhNQEeTOYZ+OOIoQ4R8asJwnj3ECq0byv5aGUYwf
         hLh8v/VPYDQcOpr9BuX8xxjyJxEzm/g9LDYyctPdLjSIqBDZdEdfgswQEVU0DiKJrWMn
         kqz/7Ox+SFotrPbPzkhuQb+U1WiZQjxJ2xniaAg8TRomK6+4aV7wkOvj93wHnp8curD5
         Jr+QlIBHSrTVKwPB+gGx6LikTU5d2BJ7VW9bKVTaZJRgIu9GmFRv+qyjfSWr9BRKq8V9
         FRQQ5POhyN49umccZrhPDYYOeJhrvdYNVt0pWWPDjSCYHMbeJcXky2T8yowWboNLY/yy
         FPPw==
X-Gm-Message-State: AOJu0YzKT95ppRTVJn4SzO0NYAaRDQ7ANLmYmNXLcK0vLMtl0YaW/h00
        mu4Tf2FkG9vGQB4U8ebau0U=
X-Google-Smtp-Source: AGHT+IHGNAErG58V9Xptsi9rhCr540MMtqj5pUEVIhkp8UyJJWdw2+ugBMjHDeueIBYjz3yn6Bm33Q==
X-Received: by 2002:a05:6a00:1401:b0:68f:ece2:ac2a with SMTP id l1-20020a056a00140100b0068fece2ac2amr196394pfu.27.1699401450307;
        Tue, 07 Nov 2023 15:57:30 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q22-20020a63d616000000b0059d34fb9ccasm1856065pgg.2.2023.11.07.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 15:57:29 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2117D819DE58; Wed,  8 Nov 2023 06:57:25 +0700 (WIB)
Date:   Wed, 8 Nov 2023 06:57:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hunter Chasens <hunter.chasens18@ncf.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>, daniel@ffwll.ch,
        airlied@gmail.com, Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>
Subject: Re: [PATCH v3] drm: amd: Resolve Sphinx unexpected indentation
 warning
Message-ID: <ZUrO5aRPUux_QchV@debian.me>
References: <20231107162830.36856-1-hunter.chasens18@ncf.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kv+cup+JVOlwZ+Z6"
Content-Disposition: inline
In-Reply-To: <20231107162830.36856-1-hunter.chasens18@ncf.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kv+cup+JVOlwZ+Z6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:28:30AM -0500, Hunter Chasens wrote:
> Resolves Sphinx unexpected indentation warning when compiling
> documentation (e.g. `make htmldocs`). Replaces tabs with spaces and adds
> a literal block to keep vertical formatting of the
> example power state list.
>=20
> Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>

Nit: Whenever a reviewer has offered a Reviewed-by: or Acked-by: trailer,
you should include it in the next reroll unless there is substantial changes
in the reroll.

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 517b9fb4624c..576202bf64f3 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -989,12 +989,13 @@ static ssize_t amdgpu_get_pp_features(struct device=
 *dev,
>   * Reading back the files will show you the available power levels within
>   * the power state and the clock information for those levels. If deep s=
leep is
>   * applied to a clock, the level will be denoted by a special level 'S:'
> - * E.g.,
> - *	S: 19Mhz *
> - *	0: 615Mhz
> - *	1: 800Mhz
> - *	2: 888Mhz
> - *	3: 1000Mhz
> + * E.g., ::
> + *
> + *  S: 19Mhz *
> + *  0: 615Mhz
> + *  1: 800Mhz
> + *  2: 888Mhz
> + *  3: 1000Mhz
>   *
>   *
>   * To manually adjust these states, first select manual using

Anyway, LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--kv+cup+JVOlwZ+Z6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUrO3wAKCRD2uYlJVVFO
o9PfAQCQoOysBPfyyDkpbc/cw6GEYb9qbjfdqZzmsgFQRMiMNgEAswr/n/nO5KLA
SIGTnW07DyMIEw/LEG799c6gZANsJwc=
=he+5
-----END PGP SIGNATURE-----

--kv+cup+JVOlwZ+Z6--
