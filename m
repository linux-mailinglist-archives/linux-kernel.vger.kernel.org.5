Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822C67C6BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378234AbjJLLEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378351AbjJLLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:03:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E28FE7;
        Thu, 12 Oct 2023 04:03:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53406799540so1542613a12.1;
        Thu, 12 Oct 2023 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697108625; x=1697713425; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmO8gUEeWTIeugQ59PUPtNR1b1/YDjgV/Nl6BnlhrW8=;
        b=lq02rtKhtYV9WXEhHPIyywL6e0PVe5vDdvHSdIabg4poihEj4Omi4bVFi44wL0FkX2
         8MiPL1RRpVySaal6sepybMMQbNXuxjGcVERkvuoPs88pa49lGULdjTtwwC+aaw6topuO
         Uo4ONCjFtCTyp+g2awI0gUAAPFvOD6Ux2v7yqODqtxn3ApEhqoZfg1jsA8V5vlM7ZYOt
         8hoAt5Zg5Pw36AnLGhCszaPD/bEhEfu+o133EgWJT0YCq1ihGQ+5aB0sI9BJMso4qUKv
         tn5rZ0NAJc85w1C1HDC3kEzvtuw+MNoau6yWQCSO14bn7t4C/tdhVHaLdu7xLYW0ygZz
         BXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697108625; x=1697713425;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmO8gUEeWTIeugQ59PUPtNR1b1/YDjgV/Nl6BnlhrW8=;
        b=AOQH5Pffq7wFu72eEiDk44dA6/hKPjKuTrqhJb+tw+Xtr1G2iWPAmEOCDygOliFTLO
         Mg+guCBmGGJaH00mZXo5ZjmZlHxqryfdWU1rsJm4YKmbu3bzThFQR32EoD3mWtx/UQO2
         o+q2CjR9z36zayvdbUWeTrJRMb92JhI98QztFACK8v8t8tY8rxijuoQWV+Pa7QKxhFxU
         7mt3rNtWYtqtDgIgSr/n96xPNPwAHWPdCv+DRay98s5LKdQmjT+SxArIXVWzBcKPzJZZ
         EGuCH+KyBnGoe+19SJIpyQWHIRl8nFy4sHeQEQorJjjnZPy3wTO7X78aQyZ5SbHU8Kxm
         g7mw==
X-Gm-Message-State: AOJu0YxaOfbSlGLFLH3wrTI70f8G29jVKw7nc3vSqhsYVtgDbUJdx1mE
        jsXIosepMHaFQzIA18oOtidCWvThfro=
X-Google-Smtp-Source: AGHT+IHJ1KGqHqvgOy/LksbhX3FOc8BhoOJFt/mKXNAMyufYQ+XNXioG0Yvpj8Hc4U8pQ9x80GOZeg==
X-Received: by 2002:a50:fb82:0:b0:523:3754:a4e1 with SMTP id e2-20020a50fb82000000b005233754a4e1mr20669977edq.22.1697108625169;
        Thu, 12 Oct 2023 04:03:45 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id dk20-20020a0564021d9400b0053da3a9847csm2928338edb.42.2023.10.12.04.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:03:44 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:03:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Johnny Liu <johnliu@nvidia.com>,
        Ankur Pawar <ankurp@nvidia.com>
Subject: Re: [PATCH] memory: tegra: Add Tegra234 clients for RCE and VI
Message-ID: <ZSfSj42AXcnI895C@orome.fritz.box>
References: <20231012104909.48518-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kuGnPKGhjCeiwyg1"
Content-Disposition: inline
In-Reply-To: <20231012104909.48518-1-jonathanh@nvidia.com>
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


--kuGnPKGhjCeiwyg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 11:49:09AM +0100, Jon Hunter wrote:
> Add the Tegra234 memory client entries for the Real-time Camera Engine
> (RCE) and Video Input (VI) devices.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/memory/tegra/tegra234.c | 60 +++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

Krzysztof,

again, let me know how you want to handle this. I can pick it up into
the Tegra tree along with Sumit's 2-patch series, or you can take these
if you prefer, in which case:

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra=
234.c
> index 9e5b5dbd9c8d..42c79f9a70af 100644
> --- a/drivers/memory/tegra/tegra234.c
> +++ b/drivers/memory/tegra/tegra234.c
> @@ -449,6 +449,18 @@ static const struct tegra_mc_client tegra234_mc_clie=
nts[] =3D {
>  				.security =3D 0x38c,
>  			},
>  		},
> +	}, {
> +		.id =3D TEGRA234_MEMORY_CLIENT_VIW,
> +		.name =3D "viw",
> +		.bpmp_id =3D TEGRA_ICC_BPMP_VI,
> +		.type =3D TEGRA_ICC_ISO_VI,
> +		.sid =3D TEGRA234_SID_ISO_VI,
> +		.regs =3D {
> +			.sid =3D {
> +				.override =3D 0x390,
> +				.security =3D 0x394,
> +			},
> +		},
>  	}, {
>  		.id =3D TEGRA234_MEMORY_CLIENT_NVDECSRD,
>  		.name =3D "nvdecsrd",
> @@ -621,6 +633,30 @@ static const struct tegra_mc_client tegra234_mc_clie=
nts[] =3D {
>  				.security =3D 0x50c,
>  			},
>  		},
> +	}, {
> +		.id =3D TEGRA234_MEMORY_CLIENT_VIFALR,
> +		.name =3D "vifalr",
> +		.bpmp_id =3D TEGRA_ICC_BPMP_VIFAL,
> +		.type =3D TEGRA_ICC_ISO_VIFAL,
> +		.sid =3D TEGRA234_SID_ISO_VIFALC,
> +		.regs =3D {
> +			.sid =3D {
> +				.override =3D 0x5e0,
> +				.security =3D 0x5e4,
> +			},
> +		},
> +	}, {
> +		.id =3D TEGRA234_MEMORY_CLIENT_VIFALW,
> +		.name =3D "vifalw",
> +		.bpmp_id =3D TEGRA_ICC_BPMP_VIFAL,
> +		.type =3D TEGRA_ICC_ISO_VIFAL,
> +		.sid =3D TEGRA234_SID_ISO_VIFALC,
> +		.regs =3D {
> +			.sid =3D {
> +				.override =3D 0x5e8,
> +				.security =3D 0x5ec,
> +			},
> +		},
>  	}, {
>  		.id =3D TEGRA234_MEMORY_CLIENT_DLA0RDA,
>  		.name =3D "dla0rda",
> @@ -701,6 +737,30 @@ static const struct tegra_mc_client tegra234_mc_clie=
nts[] =3D {
>  				.security =3D 0x62c,
>  			},
>  		},
> +	}, {
> +		.id =3D TEGRA234_MEMORY_CLIENT_RCER,
> +		.name =3D "rcer",
> +		.bpmp_id =3D TEGRA_ICC_BPMP_RCE,
> +		.type =3D TEGRA_ICC_NISO,
> +		.sid =3D TEGRA234_SID_RCE,
> +		.regs =3D {
> +			.sid =3D {
> +				.override =3D 0x690,
> +				.security =3D 0x694,
> +			},
> +		},
> +	}, {
> +		.id =3D TEGRA234_MEMORY_CLIENT_RCEW,
> +		.name =3D "rcew",
> +		.bpmp_id =3D TEGRA_ICC_BPMP_RCE,
> +		.type =3D TEGRA_ICC_NISO,
> +		.sid =3D TEGRA234_SID_RCE,
> +		.regs =3D {
> +			.sid =3D {
> +				.override =3D 0x698,
> +				.security =3D 0x69c,
> +			},
> +		},
>  	}, {
>  		.id =3D TEGRA234_MEMORY_CLIENT_PCIE0R,
>  		.name =3D "pcie0r",
> --=20
> 2.34.1
>=20

--kuGnPKGhjCeiwyg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUn0o8ACgkQ3SOs138+
s6GexhAAvLAcvebVMhHUHBK35Y86JIbFkXBpIv5wNbGCC75VR8wJSE8aCSu4xGFy
UT/WippKF+E/QlKacmnAw72Vl3nu8RxmBLvLlRQbUt00P5NlYLv8cLkRz4PuqzX1
07+VH6bp95Mjls6Fk+kZUhH2USfLcKm68xz+tJeMYobccqJy32u2bqVJGgaejNpo
3NM9GOJsLKVfBDBcz6B/XthRDc0glT5/orzxTzrL9ikn3/iaVXu3AqzFqfiFBtxS
zdnjOL3GZN6mCfiKvGC8GCrmZUvLGixXsWJfTyDhpcBErd5mcObKuyWWiJyaKUru
CjSfFFN1CrOrFHGjPQBi13OsUxywtUMy6VAc8ztEn4wR+cgLpx2irPbEd7wqv19i
b3Xr669nv/uAes0SGE6jmVvXxOp6Y7MkFuiR1op8ODOsYNhcTf7dS8iSSamqvkge
7qY/AcrdSZnlpeVvjrLf1N2oftH73oK6YBntmkbvOqGdwSZCc+2Xdi3y0ghvWYbS
zxogIGW0M3CCajVxKDcYD9TdJ0nGX+/+TwTkzoIxBxUKxO/b2h1OXhTalxo3HpJa
DZT5jVw8aXtEGX+d7lBAxs7K6Iubvf3brSkujlGwuhZwEzGkVGdfHHTmWxwm12wL
g+6R90f2J5K86XtNMnwR1DW8cT2qg1wwDauVyeaAMEs8DLFYkV8=
=EA/3
-----END PGP SIGNATURE-----

--kuGnPKGhjCeiwyg1--
