Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE07BFD49
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjJJNXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjJJNXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:23:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0020DB;
        Tue, 10 Oct 2023 06:23:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c296e6543fso69885301fa.3;
        Tue, 10 Oct 2023 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696944180; x=1697548980; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4OkJhMqhpJlQA7D4mEBZ0eKbSauF06ASDuYayzw6gs=;
        b=CMTZAYPuO+306XqoBfb7Ud7xhmJTALHVryytjtOE959KmOAieJRmZH67U9dRDvt7vN
         ANw3bLFZcm/5Wxun5HjGTqg+mhtfeQUs0Ue5AjI6XRA4lU1mbcmUccWnZxA0glpZzUXo
         641H9mN18Jvsc806HBjS91cDGkxiHMM5LgzqhWVOEZcs2HUpEOcyoZvhMmpE4ELgHuI7
         GzYK1F0su2UBYC8mPG8QbL/B4PDxHHHq1sRQaeqkATRSzYD2+1Vyor2eldSK5v5msXBm
         rZHJO0F6bfloEPQHMQA0MRHWpL3jw0hdTGdbKsl0Qu/7Iw6aOoQjHFawb6EU23rYYcd4
         F7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944180; x=1697548980;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4OkJhMqhpJlQA7D4mEBZ0eKbSauF06ASDuYayzw6gs=;
        b=H8KJhzWujI/+uqW6q/j6Drcz6LLTiEriw8KpQ5EiLWtrIEyRsuLQzSX71QlgtOvCWc
         jiqUlrJsExPsK4eWN8MojNuiniskhBJ19IRp6Wu+F0xTzO8HkDn9CfiJhyzkkNXshXY/
         g3QQKcz3xeb2znR/OxcYXab1MQ8ANrfefGzprly5amlBBA0P8/tpd3Y9RjUp4500oalk
         EnmZDxNGObTzRG/SiTTDL9AcSLzcDJybBl1Oyqs00SdyYXIPHNIhojaa4f1ai66O6EOP
         6k7+/7w7hiIr9SY3lYM2EmN5AQLAELIXarFka+noQvHI4NIvZVofpyZbIgyPaaoe+jQX
         0zXQ==
X-Gm-Message-State: AOJu0YwC1Hb4hZWsw9z9VcNAfloC7JUVo9pKyosqwCTNmdaibvetP51F
        /O6a8AkOYQsCqZ4Ic1nwXdY=
X-Google-Smtp-Source: AGHT+IG4E1Rsd4mR8zKAlFKL3gBiWJYcWwe6obioes7OUwKszflS+BDw7LqnVeVigL3XOU4ZXBP1cg==
X-Received: by 2002:a05:651c:114:b0:2b4:5cad:f246 with SMTP id a20-20020a05651c011400b002b45cadf246mr14945414ljb.7.1696944179734;
        Tue, 10 Oct 2023 06:22:59 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q23-20020aa7d457000000b00537e822458esm7603769edr.20.2023.10.10.06.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:22:58 -0700 (PDT)
Date:   Tue, 10 Oct 2023 15:22:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/tegra: Return an error code if fails
Message-ID: <ZSVQMPuRnXzC0lgf@orome.fritz.box>
References: <20230626143331.640454-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pfm0RnLdhwUV4frN"
Content-Disposition: inline
In-Reply-To: <20230626143331.640454-1-suijingfeng@loongson.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pfm0RnLdhwUV4frN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 10:33:30PM +0800, Sui Jingfeng wrote:
> Return -ENOMEM if tegra_bo_mmap() fails.
>=20
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/tegra/gem.c | 2 ++
>  1 file changed, 2 insertions(+)

Sorry, this fell through the cracks. I think it'd be better if
tegra_bo_mmap() were to be improved to always return either an ERR_PTR()
encoded error code or a valid pointer. Throwing NULL into the mix isn't
useful because it typically means something like -ENOMEM anyway. Error
codes are more explicit, so since we're already using them for some
cases, might as well return them for all.

Actually, looks like tegra_bo_mmap() never actually returns an ERR_PTR()
encoded error code. It's either obj->vaddr, the return value of vmap()
(which is either NULL or the address of the mapping), or the address
obtained from dma_buf_vmap_unlocked() (i.e. map.vaddr) or NULL on
failure. So I think it would equally make sense to keep your patch and
to remove the IS_ERR() check below it.

I would slightly prefer the first option, but either is fine.

Thierry

> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index dea38892d6e6..0ce22935fbd3 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -710,6 +710,8 @@ static int tegra_gem_prime_vmap(struct dma_buf *buf, =
struct iosys_map *map)
>  	void *vaddr;
> =20
>  	vaddr =3D tegra_bo_mmap(&bo->base);
> +	if (!vaddr)
> +		return -ENOMEM;
>  	if (IS_ERR(vaddr))
>  		return PTR_ERR(vaddr);
> =20
> --=20
> 2.25.1
>=20

--pfm0RnLdhwUV4frN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUlUC4ACgkQ3SOs138+
s6G12g//SDtyUQdjlNkFYALQ7xVJv2ZZ7b1urqiIrnAyqUtUfeiEqsckl+yNpbM7
k0gluSK5XHKMY0+VLibxBSRzGF5Kth++GEl709FCWSxAy+3cupNtX66hwkuqovpz
CnTVi25vjKDxM8AsVeCeJJin8qn721NMByrVdv9790kh6SS6HSgboP936ayD4AtN
14ckJ2RENrsBPUCj+XEol68DBQwHTbGlc+2B/znECFEDkUr/myf/O6rqLLyC/ErJ
UeHFjac5al+/zNeu4SAYobBT/RbhU11Yg1CNINiOexzzYDzYYGMppK+Uph1QfhCN
obaipcKDIb43LrzrlC6YsjsP0OgnbmdAzxYdiSvTMvzIdjp960WuFVlyxw/ofWD2
XAH1jr8DnDHdQ/Bzu4D5eD00dyGaBX3BqavZVFSNSGEC6MalA7fkZP5wk2mOGY1s
sIlTJLtQkfJngFT68SSFbPV5t5iFuLNcYvcszSn41no1CshU/ZlJMd4l2tJwLp33
2PJIpQhwBjw62/K9ZaTbvG7xiceUnkMjYfhfOi6EYNvj666qU3QxIgENyyaeMQgS
4f7XYeBY0Um7V+xEDqIcIRjhGqVv7fhtwMq5YBYjB2C6xAIgFoHiBzsbJSe8BTvr
wXCuE6mjY9+mfzxG2YmS+eRmGvO6djHAcAepluLlLOK+ib1K4OY=
=muHC
-----END PGP SIGNATURE-----

--pfm0RnLdhwUV4frN--
