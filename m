Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C789813AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjLNTUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 14:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjLNRko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:40:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE6121;
        Thu, 14 Dec 2023 09:40:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c4f95e27fso7910901a12.1;
        Thu, 14 Dec 2023 09:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702575649; x=1703180449; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1N4WLdf7sdlP56PS4ELYG6Uf5jhTf+hRZAedOnp114=;
        b=cQraBOG3mat1Eloaoc8+Y24tpxu4poxTw74iycUwZ0W554MBa/SQtdPEhqtB9/zXas
         +/TRm6NASEBG3jGft9MzIWCyKgOpHZlb1sdM8xhVyy4jMHxpUumfnuLwgh5XQl+5cNrX
         pEpRiEZOFapl2FTZEuCgbluprfOU94QOZTd0HfEaNzXspyoj0yi5zY9GXiNVySoP31gE
         IY029GSXzjTupmfiTcV7slWhIB2Rz9ynlbJjcYhHhgQejUuYenOiZQ/hk2GB5DhvIQE8
         PnctuQYWiUZmgUwTNAydjzhg+Rkzq9fOj2Mz+sxD6Pm9EVqcWRrJh+HEUANr+tt/3GJu
         aetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575649; x=1703180449;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1N4WLdf7sdlP56PS4ELYG6Uf5jhTf+hRZAedOnp114=;
        b=ZOV2gQXWDOgJT1uNrBQCC+dSKYwUgYgU3EVkKFosalESQTddzHTW/6Ut1Ldm0pGbbZ
         d6eIvPJzpijG4RUBZ7zQeJgBl/J9XEMizEZpv3iBqBSFurjuOOiY83HIcN7LKOWK9kN0
         0Dj8zErQb3ZW9RbQj+G4V/kciCttKcGWGHKFy7Z4fXJFagnOwd+LB8Co2t0B9mC+ki3w
         HviahpflvRWcJ8ye5MSoVGvhGGmuMG0JiJA29MKpjZP6dWBkO4xZOLUXBZBNRLDV0VC9
         o2p/ZXsX0qfuXUsSj8DsrpcPB0o3gr79XlLd5TE8po/u9msDKxtBaHYAi36ChTGVRxf1
         PqxA==
X-Gm-Message-State: AOJu0YzYp/XiGhu3IKZFXab7R1ksmfGQJYvPFpNVGV/yeBI3wpE5Hd2I
        YMehMACvdcX29NDV4x53aws=
X-Google-Smtp-Source: AGHT+IFcl9XlzbvFL+8a3OrPkQbfjXbIVp/KME6onEiUZmeuxVQdKBh9vlarUhl0lcc0nX1MDxy64A==
X-Received: by 2002:a50:c88b:0:b0:551:e411:3b04 with SMTP id d11-20020a50c88b000000b00551e4113b04mr2198866edh.54.1702575648799;
        Thu, 14 Dec 2023 09:40:48 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l12-20020a50cbcc000000b0054b53aacd86sm6850033edi.65.2023.12.14.09.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:40:48 -0800 (PST)
Date:   Thu, 14 Dec 2023 18:40:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mperttunen@nvidia.com, airlied@gmail.com, daniel@ffwll.ch,
        jonathanh@nvidia.com, digetx@gmail.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/6] drm/tegra: Fix some error handling paths
Message-ID: <ZXs-HmMORtbEKtTB@orome.fritz.box>
References: <cover.1693667005.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B7QFJ7EdQEv+w64a"
Content-Disposition: inline
In-Reply-To: <cover.1693667005.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B7QFJ7EdQEv+w64a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 02, 2023 at 05:22:07PM +0200, Christophe JAILLET wrote:
> Most of the patches are retated to tegra_output_probe() and missing
> tegra_output_remove(). Others are things spotted while writting the serie.
>=20
>=20
> Patches 1, 3, 4 are verbose, but some functions called in the probe can
> return -EPROBE_DEFER, so it is nice to correctly release resources.
>=20
> Maybe moving the tegra_output_probe() call would minimize the changes, bu=
t I'm
> always reluctant to move code, because of possible side-effects.
>=20
>=20
> Christophe JAILLET (6):
>   drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()
>   drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling
>     path of tegra_dsi_probe()
>   drm/tegra: dsi: Fix some error handling paths in tegra_hdmi_probe()
>   drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()
>   drm/tegra: rgb: Fix missing clk_put() in the error handling paths of
>     tegra_dc_rgb_probe()
>   drm/tegra: output: Fix missing i2c_put_adapter() in the error handling
>     paths of tegra_output_probe()
>=20
>  drivers/gpu/drm/tegra/dsi.c    | 55 ++++++++++++++++++++++------------
>  drivers/gpu/drm/tegra/hdmi.c   | 20 ++++++++-----
>  drivers/gpu/drm/tegra/output.c | 16 +++++++---
>  drivers/gpu/drm/tegra/rgb.c    | 18 +++++++----
>  4 files changed, 74 insertions(+), 35 deletions(-)

Sorry, this fell through the cracks. Applied now, thanks.

Thierry

--B7QFJ7EdQEv+w64a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV7PhwACgkQ3SOs138+
s6GS9w//STu4g/vBWEfc4q5m0e7gCrQ3UzXsy8t1imWkMTk852LmQdXLz5vl5sBf
wIsHVsun6jAYMHL6ItSZkUz5Qrxw+3WQpwTP757lUyNI9ECxE2A5QUfuYq+hDtAq
YDs7VQODIJs6yj1aKHVVYsW1QW/xiQu/oH1YuA6AhJ5TzhR01R8ihVnFHrO1QrbL
OXd0SSlf3t8zMrIxqnBJonMKBlWt64FgG8qIs2+M/FJLFnqnCo97FLJdzpSFVhnA
Wbmp4ddR/tAhgMamFVkcFxRJ+ug8UEohMYdb73Hu5m0IlNIjygVyr2328RUAzB1u
NveWNQBp082mPd7Vuaf2dapDKD+oAmFEqkIDsPWQjYSWUp3v6xHk4IHPACMrqsx6
zdnLqhXU2u8nK+eFIAd1/NVVhYq43IV5yOFI8rwfsjq+fUPhQoZM5vH7A5MPGKsa
Dya+y2ysUsBMzZxvpDjUG/nXBhuJ6aDXQggNZPVdNpcnvkTrpakl7WaJQCn6WtMB
gxO7x2dXcbwFSW8mWLFB1W7ZwAOS7TRTYRvHlwZGHQHvejDePb9FyxGT26OG9Urp
cK9KfH1WmPSLJvM1iAADFApGD9CvY09US/b4+tH1Tz0K9gjoTPEeP/W/wj4/bYW1
y+hWfjwbfh79c8Nfg4gnWJFo2AaqtZmlwWDHiiO2pDnA2W289BQ=
=MZfe
-----END PGP SIGNATURE-----

--B7QFJ7EdQEv+w64a--
