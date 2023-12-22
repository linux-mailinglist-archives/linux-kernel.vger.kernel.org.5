Return-Path: <linux-kernel+bounces-9312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F081C3D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB0B1F2565F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEB524F;
	Fri, 22 Dec 2023 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS0XZ7lK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8891C2F;
	Fri, 22 Dec 2023 04:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d774533e73so1448778b3a.1;
        Thu, 21 Dec 2023 20:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703219118; x=1703823918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FI28OOdgrC3b3WvGuekm1c4zR7iBHpXdXn/h9IBkfrU=;
        b=mS0XZ7lKfSKGDL7TzvQmV3rZgTwqV7Q3COdsYp6/vXssxlHRpClYujQszUg4WXxSEg
         vedYzRxF61cGQ8Rigtx7EPkneDZChQ5WzQPl5wtE1uvCocZM0i2BNP/wft7ZbmU7Sxym
         DLFSzCoIohLLW3kCFBxItu4ecp+wZma48ARXgUF8u5jmg3uoUzJqghkwDpoiI/bJ1aEG
         ISxEmtHOMKF1bZFVUXFit+QwCrC0R2HaGU0NjWMUlXyLInb7SuGThdK1cqOdZ16ITD+3
         d0N4i2moWTdwSbtEEJTzidkNUj4iAc7BMePOd3D/uFRhkxbwJbtCmOdOHGMtl/j6N2iS
         Y1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703219118; x=1703823918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI28OOdgrC3b3WvGuekm1c4zR7iBHpXdXn/h9IBkfrU=;
        b=acv7VSqSDJogMROZsjVRgbNyKaDXnSJ2uTvNVamYrK7R2u1ucdXvDpSAkXUCFIZd5X
         veUs2nxGj2yhVPltuNOdxP8XX2+zShJPbuCkYSUUEosJYEzXkpXHO0XdXyam6QZ54nBY
         06WlwqnzjKjAOr/AP6HyNnunP9QQHSvGpCwTfblUTboPumbxhA+fci4rlj8eneBd0V5h
         mcG69Tk3DR1nBULE5T2A3RnUjZ6fnkimz7EE6eViXnyZV6hxOBOhgGi5kNWwWqTlT0/Y
         Q8gsHAOJcbbZ1p/RUbFPWBN7GK7/HzvwW7Ca8kL0UZvdeL7dVw5gEcfzpu3Bkd8jDHdf
         641w==
X-Gm-Message-State: AOJu0YzY+55DxxCamnIUK8jIw/gqAs6pfLn2563hsWLMaBZfcGG+8m+5
	Jl6473ZDMYmGLPOyH69uEMc=
X-Google-Smtp-Source: AGHT+IGtH6T3Jw9IPcPlpeNp3K8Lkb+hHArZ83pzbQZ/Ic8gDBms+SUAFEYYClpAcqmIu9vUW0Sprw==
X-Received: by 2002:aa7:85d0:0:b0:6d9:4687:c38d with SMTP id z16-20020aa785d0000000b006d94687c38dmr771382pfn.68.1703219117848;
        Thu, 21 Dec 2023 20:25:17 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m20-20020a635814000000b005ab281d0777sm2328915pgb.20.2023.12.21.20.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:25:17 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 80ED811978D9B; Fri, 22 Dec 2023 11:25:13 +0700 (WIB)
Date: Fri, 22 Dec 2023 11:25:13 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Dmitry Safonov <dima@arista.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	YouHong Li <liyouhong@kylinos.cn>
Subject: Re: [PATCH] net/tcp_sigpool: Use kref_get_unless_zero()
Message-ID: <ZYUPqXO7VYJ79HMc@archie.me>
References: <20231222-tcp-ao-kref_get_unless_zero-v1-1-551c2edd0136@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sBQ04bcKWONUwGSt"
Content-Disposition: inline
In-Reply-To: <20231222-tcp-ao-kref_get_unless_zero-v1-1-551c2edd0136@arista.com>


--sBQ04bcKWONUwGSt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 01:13:59AM +0000, Dmitry Safonov wrote:
> The freeing and re-allocation of algorithm are protected by cpool_mutex,
> so it doesn't fix an actual use-after-free, but avoids a deserved
> refcount_warn_saturate() warning.
>=20
> A trivial fix for the racy behavior.
>=20
> Fixes: 8c73b26315aa ("net/tcp: Prepare tcp_md5sig_pool for TCP-AO")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/tcp_sigpool.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/ipv4/tcp_sigpool.c b/net/ipv4/tcp_sigpool.c
> index 55b310a722c7..8512cb09ebc0 100644
> --- a/net/ipv4/tcp_sigpool.c
> +++ b/net/ipv4/tcp_sigpool.c
> @@ -162,9 +162,8 @@ int tcp_sigpool_alloc_ahash(const char *alg, size_t s=
cratch_size)
>  		if (strcmp(cpool[i].alg, alg))
>  			continue;
> =20
> -		if (kref_read(&cpool[i].kref) > 0)
> -			kref_get(&cpool[i].kref);
> -		else
> +		/* pairs with tcp_sigpool_release() */
> +		if (!kref_get_unless_zero(&cpool[i].kref))
>  			kref_init(&cpool[i].kref);
>  		ret =3D i;
>  		goto out;
>=20
> ---
> base-commit: 1a44b0073b9235521280e19d963b6dfef7888f18
> change-id: 20231222-tcp-ao-kref_get_unless_zero-fe7105781ba4
>=20

No observable regressions when booting the kernel with this patch applied.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--sBQ04bcKWONUwGSt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYUPpgAKCRD2uYlJVVFO
o5zSAP9XM+SDEqMkhUuRetgAbHF2sJx0QgYDoulGVSRNB/T7QQEAnhMonLXOsrps
YmuFq34V+WZllvw9pPxO6RgmAEqSbAk=
=vig/
-----END PGP SIGNATURE-----

--sBQ04bcKWONUwGSt--

