Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6387D2E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjJWJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjJWJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:36:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6572A19AB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:35:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ca82f015e4so17646855ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698053738; x=1698658538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yABT5FFnh4X/Y/LyB66g3fqLvBOZpaIzrRY5ABFGnkQ=;
        b=j+eXgZxYAP7laieZnLKF8FNToDcttyDrG8sYWkawZH6DR5Ad5PKCqi1OJ2ioiVu6Uk
         AyenSwHFs2GepAhnxOZMio6cc1a1JKO+9oopm3zxBnrHA26ztL9A9ymrwoWjWoRXMvjp
         1LUNTJY1XZSghYKBPLU238U1HlSxl8Eyzf31Q+ex+rYTa6nlp9s/NA3W1aSxn9uMEjXZ
         qxjRY72mWgwbFUlEUw1VgrKUCq7SSUxiokMbdz6UJx0KMNx4DirHa6RMeYECHPGqtJfc
         3YdhsCC0Ty6FNTzhDQR0pGv+rq7gfbmpS4s+fZ8DlQNFg64ozuLn1eNpn3zWVtQdYt3q
         ExBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698053738; x=1698658538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yABT5FFnh4X/Y/LyB66g3fqLvBOZpaIzrRY5ABFGnkQ=;
        b=uSIkh7T8nUMh6i/NJVZG5uIaRb/JTsodhy4ub4quWnC91WtIq7JVMnfpQtDaSSeRGH
         MrLSnxmpPl6FujCioOBPdFsqYOxvy7grxRLlIDFTX9CyCRKT1+p4GEVvlCuixmmBryl/
         dXotnJpqrygKxwW0MXGwtZPRD4WY5S7iG5FYtW7xfP3dY6855UgmbqOJOf/PPvXc43HD
         MgUetywKy3LxTwJ1YPYnQrg/nmZF3+LJ/cPAfzArALVhXlShA5pwwu35I93SvRDX4JoU
         hmxB5hFa1jKW9c5hSs/pa7R/ALao4q7f1Y784JV/axYrMVHtw6tSREysVoAJQGUEmWKJ
         nVoQ==
X-Gm-Message-State: AOJu0Yw47NC7+5ffsvYiMZ6YuP0fcP9zvz6R1/xZIK9jG6+LL0+Aexzf
        VnpcmgQsEauwA6YV4cKLmX8=
X-Google-Smtp-Source: AGHT+IFvSiOA6htTOo8olw+VPfJ4yMRiqsMDCFp7e9OCUIXpHMLjxUv5QtpdSinJRP1SkxsAjJkSFQ==
X-Received: by 2002:a17:903:110d:b0:1c9:ea6e:5a63 with SMTP id n13-20020a170903110d00b001c9ea6e5a63mr7679602plh.32.1698053737624;
        Mon, 23 Oct 2023 02:35:37 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jc1-20020a17090325c100b001c5fe217fb9sm5568258plb.267.2023.10.23.02.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:35:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2F7CF812660D; Mon, 23 Oct 2023 16:35:34 +0700 (WIB)
Date:   Mon, 23 Oct 2023 16:35:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Emma Anholt <emma@anholt.net>, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/vc4: fix typo
Message-ID: <ZTY-ZqWxW5V-T680@debian.me>
References: <20231023085929.1445594-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HhZAxpuppBM8l8d1"
Content-Disposition: inline
In-Reply-To: <20231023085929.1445594-1-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HhZAxpuppBM8l8d1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 10:59:20AM +0200, Dario Binacchi wrote:
> Replace 'pack' with 'back'.
>=20
> Fixes: c8b75bca92cb ("drm/vc4: Add KMS support for Raspberry Pi.")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>=20
>  drivers/gpu/drm/vc4/vc4_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_reg=
s.h
> index f3763bd600f6..8ac9515554f8 100644
> --- a/drivers/gpu/drm/vc4/vc4_regs.h
> +++ b/drivers/gpu/drm/vc4/vc4_regs.h
> @@ -588,7 +588,7 @@ enum {
>  # define VC4_HDMI_HORZA_HAP_MASK		VC4_MASK(12, 0)
>  # define VC4_HDMI_HORZA_HAP_SHIFT		0
> =20
> -/* Horizontal pack porch (htotal - hsync_end). */
> +/* Horizontal back porch (htotal - hsync_end). */
>  # define VC4_HDMI_HORZB_HBP_MASK		VC4_MASK(29, 20)
>  # define VC4_HDMI_HORZB_HBP_SHIFT		20
>  /* Horizontal sync pulse (hsync_end - hsync_start). */

The patch LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--HhZAxpuppBM8l8d1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTY+YgAKCRD2uYlJVVFO
o4uJAPsF/0tqkXJtyKWS9NFtEic6P8EFkZFBwN7whe0nGCG1TgD9ESkhI7yTyWaC
8KW7Y7+ovXXLIouw0NbhOqNjfpsr0w4=
=5e8G
-----END PGP SIGNATURE-----

--HhZAxpuppBM8l8d1--
