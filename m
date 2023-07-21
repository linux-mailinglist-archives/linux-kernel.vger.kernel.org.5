Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40EE75C893
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjGUN41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGUN4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:56:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B71359F;
        Fri, 21 Jul 2023 06:55:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9926623e367so319628766b.0;
        Fri, 21 Jul 2023 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689947738; x=1690552538;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUTml+j0BKcM+haAeIip69fhehsDqEFXRsZ2bgoeHNs=;
        b=Z4SVq1N4Jb+zb+PMQ9MDYCPFL5uBWO5QOdXVfkLipaPjpJ7GjH3cn6h9O1MMQ994/U
         QVS/wtFa2Zyn/JsTx36gX5MTFBUT6GA0O0YzjjVEDeFpNyMpRGezci3DsjRWBoKvNrua
         y20KEkKqQpkMJFrZ+xjHT/wKZdgfXr6E7+5nr2ER7BdroAq6a64e8SzMkLcqKEdjUvRP
         vT2xWw1C07MD1P06YCmnuby+TSJ8A5eA1Wdw7AIRM7hj9qa9luMTeYEw4wyajR/wAOIJ
         Tg3E9LdNsMnt1V/QtdyOwbMXY2fitQUGsBKBy+wmxgkNnlRcJH0h68ZYDKnU8NeWk6lq
         qsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947738; x=1690552538;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUTml+j0BKcM+haAeIip69fhehsDqEFXRsZ2bgoeHNs=;
        b=LMx//O3HxnUMAUUvKRRD/9BF5BYZc18W5hW0Q2gLg/GQmOptC8UTO2OHtxNlBmeOs3
         Qg2VOLAlmrw/I711w/yzjoxU+YUaujxAqJzEMuBKSuipQfqHiQJZwQjwl3PZLNCbqhGo
         KNS6lbYXBv/LG5NKvZaJ3bR+AG79C6inv9EB6Xqu3/HhO5sCrutq4PuDzPrt296UJGDl
         fQJS/GbVBoCvrx8xoFZD3ptdm61BGAv/4+E3tCNMvmjT+hv5IYUyHLtdFwNCk1+a+JYG
         LwaGjHaXNLwK7V6vL2MRfLhVC3AUo7HX8b5iAvOmKWBuA5kJ1IFgyPt30zAddm6Sn1ZL
         +Geg==
X-Gm-Message-State: ABy/qLbOAGT7KLQILEMAK0ivB9zQ9LlukDI4yrQLuUB/vJ4qVo6cw09B
        eSN3GSsU8u263SFcGU/fz8Q=
X-Google-Smtp-Source: APBJJlH12b3UgDv0tSheU2gyswihEDjvN9eEW2IOO0q9dK9Kc2Su63zlxtNb3lxNpVzJqyKhpLrlow==
X-Received: by 2002:a17:906:7a01:b0:992:a0c7:8d2a with SMTP id d1-20020a1709067a0100b00992a0c78d2amr1828274ejo.54.1689947737589;
        Fri, 21 Jul 2023 06:55:37 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709062a4900b0098748422178sm2226858eje.56.2023.07.21.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:55:37 -0700 (PDT)
Date:   Fri, 21 Jul 2023 15:55:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yang Li <yang.lee@linux.alibaba.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     jckuo@nvidia.com, jonathanh@nvidia.com,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] phy: Remove duplicated include in xusb.c
Message-ID: <ZLqOV-ShmOKcldcZ@orome>
References: <20230719003614.5506-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aiG/Z8uoJevjxZrs"
Content-Disposition: inline
In-Reply-To: <20230719003614.5506-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aiG/Z8uoJevjxZrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 08:36:14AM +0800, Yang Li wrote:
> ./drivers/phy/tegra/xusb.c: linux/platform_device.h is included more than=
 once.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5930
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/phy/tegra/xusb.c | 1 -
>  1 file changed, 1 deletion(-)

It's typical to list the maintainers on the "To:" line to increase the
chances of them noticing. This is obviously correct, so:

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index ed30866e7647..142ebe0247cc 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -12,7 +12,6 @@
>  #include <linux/phy/phy.h>
>  #include <linux/phy/tegra/xusb.h>
>  #include <linux/platform_device.h>
> -#include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> --=20
> 2.20.1.7.g153144c
>=20

--aiG/Z8uoJevjxZrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS6jlUACgkQ3SOs138+
s6EFLw//dG+cVN7R6it4gQ+baHeWZRJwGmi2xEyeqmjVhZ+9c99KL63rmtIhsL7x
b1+Qz3xit8FltZdDIYd+CJrW//1cxzvtt0KKHTMg2+91D2DZVpC7DRIl8Nj/2L46
q04tHomOlrQ1vxzOvKJSxKVTai9Xk2lABp2Tz4EtP7An42s4mKUYxF68nXVxESkN
w6F4uf8xVhkqbvcPmcnms8sQeIs5C+DCx1wUIWF8ucKcF+PcOTs2xFftgeoivpdv
s9OgAzvGg6+KSDp2Ngx8iIoDHZWMFoFMqi01fOvnzXtj2gxcFzIts/E4NCKG/yJz
dZfSYlDAQ6/WmG+KHgqXVMMe/4u4FYIJI8KiLEtNvQjAH+lc9NxvhimBEMRoY2LY
PjpCxYfNWCzxuY1Dzckb1UB0671gRsDDkcH09pJeiOumV2cKWuSErLMDbOzEVeT9
gr9tzQ24D6Vzwdyu6zKzzKpFfIzrNAyW1FwrVtx+XsXsOJbNe62o2IXCTqXEUFf6
rDRwPsDGYw7gPkGigoFokOzaU8pXIPSkGh1GaCOFwwzPY2eXR4PMC88xoJu4lYds
7nTOHYURaPsA0YEW96iZAYQdPeAUXqze8ZI3hdWJrv6KX1idVacy+sKDcRVDo3ty
w7nV2GydZ5JTeuVjiXHgjjYLp0FRQF6H2azbIGma7obEJaCfMQI=
=fsKZ
-----END PGP SIGNATURE-----

--aiG/Z8uoJevjxZrs--
