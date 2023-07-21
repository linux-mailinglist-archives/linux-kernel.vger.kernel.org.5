Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0D75C47F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjGUKSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjGUKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:18:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F293C35;
        Fri, 21 Jul 2023 03:17:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso2427032a12.0;
        Fri, 21 Jul 2023 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934573; x=1690539373;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9pbsGWRmQhFYBMY/NJD5z7H5GccL1796KX7w2BJdUk=;
        b=sW2HstlhQOPYQt5Hw7uJQSwQ4UtzmoY5z/4vM740TYB2/SGN+uqlSU1h7MfaX3jLfv
         SG+u5TQV7A9JnRvoVQOr+pZfo3iCcT1HsL6GkWGRC7kgshtYDmdklYdhXY9Nc5pOp2No
         PWXnUqFloCggSTG7CPewpL0+QIyDkMS3I/2RpPOIDIwFkuc9a7CVKa28PfzMaRRDcpsm
         2yG6RgXxjeXPuJv3GMHLnZFoZ9dZxqO4Fdw0zZ8prMnZf16D+Vkdq35PMibd6b5wUIOx
         fkp5t1fbyyOrl1Fj0fQoIiIRv+J1M5Q25cSh9vdXtx6AhVNCV5AuSJavU+/OxGtukbte
         6gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934573; x=1690539373;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9pbsGWRmQhFYBMY/NJD5z7H5GccL1796KX7w2BJdUk=;
        b=CHrOHZXKmrUL54ROjQzTWZiIhYN1uLEn50TPhuAQL4N46jyKwaSsH/TGnf+4G/VC/r
         4uOoj018kg3OA60G503xV8dlkGu6JtRJQNChING6ft8gG2DkufPqcIxVrlOiSDzDsQ9h
         nH49rO/51ejqxOWPu7cdRI180yJUVc5eXuQ9zqTC5QK6Fw6UFS2pjYzEt767xKX8ReqJ
         0giC0kjwOLmGm5OWQ3uOZepw1tuFQAyrp59/kGCruPwB1CXgHETVKad0Zd+/dyRQBoHX
         mmBSPTiN4sIs0dEZWs5d8diRKh+gkitd6YbQfqjsajwQbjhaKsHNVS6IO2gooxN6IB9Y
         JZBw==
X-Gm-Message-State: ABy/qLYRHjJcGTP/OQhiJ9O8WWqOcEA/9AO7TlgELTEC+dh21epwmrLP
        DT8ql4g6R3HO96hB36nCSOQ=
X-Google-Smtp-Source: APBJJlEG42wOwEYSG/XTXRiaQNAwS0FxDO+0N4WtgeWi+e7+3SPSBAvmdZViEOuur5CuBKK7xXxnHg==
X-Received: by 2002:a05:6402:713:b0:51f:f168:a83 with SMTP id w19-20020a056402071300b0051ff1680a83mr1269892edx.33.1689934573033;
        Fri, 21 Jul 2023 03:16:13 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f20-20020a50ee94000000b00521ce1f04b8sm1894946edr.12.2023.07.21.03.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:16:12 -0700 (PDT)
Date:   Fri, 21 Jul 2023 12:16:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu/host1x: Explicitly include correct DT includes
Message-ID: <ZLpa6yezfXUx_x8w@orome>
References: <20230714174549.4056675-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QM4hLCGNIRW16k8r"
Content-Disposition: inline
In-Reply-To: <20230714174549.4056675-1-robh@kernel.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QM4hLCGNIRW16k8r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 11:45:49AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/host1x/context.c | 2 +-
>  drivers/gpu/host1x/dev.c     | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Applied to drm-misc, thanks.

Thierry

--QM4hLCGNIRW16k8r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS6WuoACgkQ3SOs138+
s6ECow/+NNmR0ClidT/qBm/ZSwIdWoje3YSoYYTlv9kySXuMHCdqe7IubPeLAv1N
KIjZwqkCNJDM3z5+ycXxV3jBONIsHn3bnZkQYs58vr3hoJpFFg4yGCfGq4V9wwyh
2caMfzXdzlBum4P88aHQk35fIgOAMk4u1SmGWNH1y/uHFY+PMekH0kTYqdupRGpP
NYzOL1QbZHZtnViy8tOt10olTI8ke0+jzGBVgB1gFrlXmgruU+94ljNey1KZZBJp
uzotsjI0E8tcU+/sVk2ODAmNuNfqSbmQRpLht9nlGBPnyOs2UN+Df9SLDu4GyFKC
3AtyyckgYmpKo/tROB67+QC6oh+MD6vyE595LVjX0geYMgxEi4oSX4h8DWm8R1z1
IEGJ/8zPZk1gkadYhc3BnBStrGj8BIIaKfmGN3e/wwClPUsLjHWAK7PwCEm+uGwG
wA0j5A/0oH0i4Yd+Pbghw7grY+lgzZi8LT/NYOFQaN4HTz8vsr7uWBNdsMWocZZC
VF36CYD9BAWjY607pO8FAM3jfLZy+Iw2aCduIBQZ3hsi1zORLZ/HXExOApQuk7Av
pE+yFTgHs4/xTFinowmz4OsIuk6i82pbgSomJulOR5TsS0UT5h2LOBwtoKREmLah
Q01LASs1XGN6e/sc16O61cq8eGPSRgb0ULiuAZB1IfJ3rA+bOqU=
=F+K4
-----END PGP SIGNATURE-----

--QM4hLCGNIRW16k8r--
