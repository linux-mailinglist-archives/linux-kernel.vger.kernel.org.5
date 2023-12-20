Return-Path: <linux-kernel+bounces-6841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732CE819E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADF6285DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B85E2137C;
	Wed, 20 Dec 2023 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7gPLQEq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0E219F3;
	Wed, 20 Dec 2023 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so6966957a12.1;
        Wed, 20 Dec 2023 03:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703072618; x=1703677418; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3Hrrww3/q9zrrOhRgX3lPr2/9drbsz7GbzoFtUlfZk=;
        b=Y7gPLQEq2IvAlO+THPxTy5SlibYV9avbEpOycjOSp2EhUzAcevjxs8EJkWLuptj3yb
         aa/GTwbQeVxpcTyO/MDpqFHahlVZjNEPEgCD2ivq/PGNTk97sGbW1SwsT3yZ1rfN/FbG
         7IGoMVYC64B1EyqKqq6NSjPI0HRBdDj5I4SJl1tUJy9HAXlTyudBHTw8HJ9b6IquwqET
         w4F11ub3Np15mSHKEphxGUabK/5BmGES0IidACPCX9ms46kinRvkv5VpaJnPbojU5V98
         GLdhpsXntgOuA7Rvub0mscZqEEjNib6Q/pfFbfkGBU/+iAtM7HSz8B0WR5AkSUh3n0Gk
         +lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703072618; x=1703677418;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3Hrrww3/q9zrrOhRgX3lPr2/9drbsz7GbzoFtUlfZk=;
        b=fUcECrdw/5oox+FqEe42NqaKNdJWpg2PRM4YPG3Vcu/PpTHttX/rygXUYAru4mYxWy
         WtR6QLxfYDRskW92FidydqCzpg6vg9VzLilualZZF1pUjbN9quiwSv2LEpd0Ns9t71zO
         H0+fu6VwILpLlIJxTnWcJBK7Nq6GjfaQPV9S8+l53oHXp5YeRUT/UfArE3MujYzjdz5Y
         lCMWtZNGvH6AorYsIkGjo0NGglCQjhxTAJvrFPHQZC46UdlWJboV1pmcmqZdqg3HB8rh
         bq6Ql9EBUtVrh4+psSTkcclJZm3QhvOFtSQnapAdqQR/d0dh76EuvnBH2frA/cAd0s/u
         Y5Xg==
X-Gm-Message-State: AOJu0YwFLz4vdhsVIID00HvCu3c1A3o4xrtUCVWBzGumR7kvq8ieaczS
	ieBFhyr606oIXjyNyhLxwkRGQnFhmAg=
X-Google-Smtp-Source: AGHT+IFeS+mwiDKoz41d/4hOnWmA2xl8RlSjK/74CEiNQqJjreS0w3KGmyDMuAaWkzOWrkXPMUw5QQ==
X-Received: by 2002:a17:906:3f5a:b0:a19:35eb:7c8a with SMTP id f26-20020a1709063f5a00b00a1935eb7c8amr10781626ejj.3.1703072618174;
        Wed, 20 Dec 2023 03:43:38 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1ca6f5f189sm16725673ejc.179.2023.12.20.03.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 03:43:37 -0800 (PST)
Date: Wed, 20 Dec 2023 12:43:36 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Kartik <kkartik@nvidia.com>
Cc: rdunlap@infradead.org, sfr@canb.auug.org.au, jonathanh@nvidia.com,
	frank.li@vivo.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: fuse: Define tegra194_soc_attr_group for
 Tegra241
Message-ID: <ZYLTaMvCClFKAL8h@orome.fritz.box>
References: <20231220061013.120173-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kASl1LDAhVZzDkAk"
Content-Disposition: inline
In-Reply-To: <20231220061013.120173-1-kkartik@nvidia.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--kASl1LDAhVZzDkAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:40:13AM +0530, Kartik wrote:
> Tegra241 SoC data uses tegra194_soc_attr_group, which is only defined
> if config CONFIG_ARCH_TEGRA_194_SOC or CONFIG_ARCH_TEGRA_234_SOC or
> both are enabled. This causes a build failure if both of these configs
> are disabled and CONFIG_ARCH_TEGRA_241_SOC is enabled.
>=20
> Define tegra194_soc_attr_group if CONFIG_ARCH_TEGRA_241_SOC is enabled.
>=20
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 3 ++-
>  drivers/soc/tegra/fuse/fuse.h       | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--kASl1LDAhVZzDkAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmWC02gACgkQ3SOs138+
s6ELmg/9GJAdHN1hEHfiDcG0vjrGjYDxD46wDykHZUpZwOdQolddlH7uTSNGZVSR
VkF53NY3rOLLZAToLCOzzweTVFiG4D/54k5DHWd+YXHd18lYaHsaySP29go2oYEl
jdzRE/FoEpdY3Tx5RURYXSyqFoy8DK4fUIAdvOg82L2EOCKF8YLXMKxS0D+S+z/g
h95ObHrkD8pN/SZdQSb8CzAlZQxoRMCQqvdPqoFisJgBe1Tu+J8TDcSoxe4zYqzB
Qza7AqLNlbQTpBdhkWJUKfwxe/AQ/bCgIRRKRErtWpMRjPY4SjFhzlcPMDoYiUbI
rJFgYsv9WGIxp3qcaraEJyVFQ/UlNYdpgLr9N3d2R2l23elVxgg5OPApb69h6nzS
Rccw3FCYL1Z/JjGyuRDKP0RRb/GMYRjqUxWm8y0tsGkn/ROdCbJUkzsVBMfhsa1L
Elq4gxVkSgCNLpR2LiArZOIzkmYB3HoJ4jGJeA5Rv1r+YmFX8ePg/PU02PjYfpFb
ofC/KDuaI/BMEZIO+P1q7m+c9dotn2ZcG4kXa8XRF+AhpKtU5KXeWJTMk2V45ZTt
TCvHt2Xivsn+9DNzxdMBITmG+U6fByFraS05wY6FdrL5BswTW3U1bp0v1XmgYafv
FvPpywWRbXKr0eFOIJdZAtbE3ON7SdQgIBnznXNURge5Saphgv0=
=bO4k
-----END PGP SIGNATURE-----

--kASl1LDAhVZzDkAk--

