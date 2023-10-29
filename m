Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120C7DACC1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 15:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjJ2OLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 10:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2OLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 10:11:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB2EB0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 07:11:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9d407bb15so32558405ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698588676; x=1699193476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+k/F3pywcFNb9QPmBba7PeS4yjsOLc+34a2n9PbqANc=;
        b=ZTp1izMqliwu2wMqo9rM5i96s5pxdYIS0ikxOuPG/T4wtyDFnSh7kDLTUQulgyLMYP
         X2YzEENCYMOw7VQ7YLhKpo61NEMwyQ/+N2qXTvQf04WLt6BHvpUYrnw+PaOsWFvaKhnH
         XqX5NWZFqw9JIE+1wzFH7SMBOgkOEd2m2ONFnE1qqDWmyTwbZWpdfT+IFWk1KXWG38kG
         nT4eYa0rs5pm4jSUNSJKqyJzv7294bDu7x9F3gT7c1Sapb9gAIYnguaTvijFr4jWivBO
         qUCRJ9xa1uL8JXcqedWzReP0yNGNXv7MV6UA6fGbzh6U+oImfgru+FTjjJ9PQzQzJvvK
         HuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698588676; x=1699193476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k/F3pywcFNb9QPmBba7PeS4yjsOLc+34a2n9PbqANc=;
        b=qMoojYqDdYQK4JnJ9xtI6LXs4Vc9XPDwJszY5MfY2zKPIBixA1svfqYZ1u3Tssmb+J
         QwYrPdvPpejYcR6vrnT7zuP+cdaY+2IejrnNFdWURYB5KOmbzgUK1cErCiwZvT85pT2X
         sB9bewhaOc740SoHY5R2KzTRZld8lSvQYP1eWCABVcxdhDZ4Gck6VsanP6vWypdIO/Lb
         B+U5sSHwtCRoBUgnraAkOVkRvDgz7BSKditZfQnRY62oOOtTsHsqwZzl+HnpQDDffMh3
         D90vgKP/jj65bYgVc1WzRof/zxPB9lM70Ha3QSKpN9QEGKcmHxQ/tuE2vdmZiEWH8aUq
         E0Dg==
X-Gm-Message-State: AOJu0Yx54rAeiNpwSW8UsgQr3muUAox7WnQ2MexWVRwVg/nCDo9++Mx6
        E5EnJB0o2e6wQbGJtZPmcT8=
X-Google-Smtp-Source: AGHT+IH1AgjGDZDT4RHmsde26FFxupiT7h34t3COj9dMXHpKj9wEbiSmTqymPLKQOAUsECrwwivUPA==
X-Received: by 2002:a17:902:d2cf:b0:1cc:45f1:adf5 with SMTP id n15-20020a170902d2cf00b001cc45f1adf5mr1305980plc.40.1698588675884;
        Sun, 29 Oct 2023 07:11:15 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jf2-20020a170903268200b001cc32261bdfsm2609034plb.38.2023.10.29.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 07:11:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4EA20819823E; Sun, 29 Oct 2023 21:11:08 +0700 (WIB)
Date:   Sun, 29 Oct 2023 21:11:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dorine Tipo <dorine.a.tipo@gmail.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Terrell <terrelln@fb.com>,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] Fix line Length
Message-ID: <ZT5n-5hSfD0MqsnT@debian.me>
References: <20231029135104.5136-1-dorine.a.tipo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+IGZbxdgpE8N3o2c"
Content-Disposition: inline
In-Reply-To: <20231029135104.5136-1-dorine.a.tipo@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+IGZbxdgpE8N3o2c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 01:51:04PM +0000, Dorine Tipo wrote:
>=20
> Fix the line lengths of lines 8 and 49
>=20

Is it checkpatch fix?

> Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> ---
>  drivers/gpu/drm/ci/igt_runner.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_ru=
nner.sh
> index 2bb759165063..d7b779bb7f64 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -5,7 +5,8 @@ set -ex
> =20
>  export IGT_FORCE_DRIVER=3D${DRIVER_NAME}
>  export PATH=3D$PATH:/igt/bin/
> -export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu/:/i=
gt/lib/x86_64-linux-gnu:/igt/lib:/igt/lib64
> +export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu/:/i=
gt/lib/x86_64-linux-gnu
> +export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/igt/lib:/igt/lib64

I'd like the former (single-line) assignment version.

> -curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -s ${FDO_HTTP_C=
ACHE_URI:-}$PIPELINE_ARTIFACTS_BASE/$ARCH/igt.tar.gz | tar --zstd -v -x -C /
> +curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -s \
> +	${FDO_HTTP_CACHE_URI:-}$PIPELINE_ARTIFACTS_BASE/$ARCH/igt.tar.gz | tar =
--zstd -v -x -C /

This one LGTM.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--+IGZbxdgpE8N3o2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZT5n9gAKCRD2uYlJVVFO
o7KuAQCNWqOLgT6d0cU/7eaEiZMLafusZHMKJi1OvsPCdiDXOQEApgOKm+qME/IC
zdQejLNFHVo5rqO05qFFPEe71U05wQ4=
=buIf
-----END PGP SIGNATURE-----

--+IGZbxdgpE8N3o2c--
