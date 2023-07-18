Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDD75756B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGRHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGRHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:35:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86064116;
        Tue, 18 Jul 2023 00:35:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9922d6f003cso745732366b.0;
        Tue, 18 Jul 2023 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689665717; x=1692257717;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR4V+aJkLkCM/JmLo15q5+va3R94sRKLeNW/ZLFTIUI=;
        b=Pp1hHkfi/Vv9ZqXwqD6RoytdWryBzgLJuLp5Um9ru109TzbWCyJ8c8nzgut3r3wj3i
         9mI07koNLBXrrTUxktLP9Os+bUaffRRjSAidFZVHHUZPTiY4SPvHPVdlX+Yizlyviqoi
         hJtLDurb8uJDgGUzFt1T12pLyq17exk/XLp3OAe+6QLCr8ubXd1K7l6e9wFZhVOakO3j
         Qeqz/W/QJbEC4DuL3LtUBVlArCXYiAKqB5X0BWzTxn3lIIZPDF7pJA8lz5Tqajj4HNgm
         SU1SkN78LwnTL/u4CFJQi8sSrr10VhQEB6c7wVAXhwk3l2HMf5RoMTqRm6lm24CvacWG
         K46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665717; x=1692257717;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR4V+aJkLkCM/JmLo15q5+va3R94sRKLeNW/ZLFTIUI=;
        b=OVeR+uLbiJ2w83FbTk7ThcdDluKo79UZH4KVt73nzQec4Y1g77eDcYqmKwM5o1y0QL
         BK/xcTnLDdcRzyyWg5psY9tV+Vqk0iiwcgwH3958PREkUVajswc1TlTV4IO4/5Rv3pa1
         gxhlec3FX1PY4i8XxsEhrvQfwjwmGj2v/TVWNh+Y0tJbuZ8OnEfv9POHZlfFXNXZACML
         cBcFJPgMGlo+PatkvX0Euoyxthbxj2Q7TT0Ut7BEQ2VwH024/OmIpvk5Ocy5G9Pg6ZU1
         OP3p/FFfcnLMwSkvPIMmcBXksSOlD5bm50pOHpBsbhCCdkawMCafZQdSjLXYZgJnGtyT
         DSjQ==
X-Gm-Message-State: ABy/qLZFX4KYYu2aenUaI89cFojm0A8MYyujgdJsHueJgGi1lRucE4B5
        c2x/eQnWtioYOkf7LhE45HvFRLCj064=
X-Google-Smtp-Source: APBJJlHe/1AMuJmS6dry+PYpYsby+JNjUJxqCaFQSHts6iBUDi2tuT3m9Lhpyp4FXYYHELg6qxiYAw==
X-Received: by 2002:a17:906:7393:b0:993:f6db:1589 with SMTP id f19-20020a170906739300b00993f6db1589mr13119982ejl.2.1689665716888;
        Tue, 18 Jul 2023 00:35:16 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qn5-20020a170907210500b009937e7c4e54sm659618ejb.39.2023.07.18.00.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:35:16 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:35:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        inux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>, WK Tsai <wtsai@nvidia.com>,
        Henry Lin <henryl@nvidia.com>
Subject: Re: [PATCH] usb: xhci: tegra: Add shutdown callback for Tegra XUSB
Message-ID: <ZLZAso-kaNwCbWCT@orome>
References: <20230718072057.233011-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QfX9Jz0QAjHjoW3v"
Content-Disposition: inline
In-Reply-To: <20230718072057.233011-1-haotienh@nvidia.com>
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


--QfX9Jz0QAjHjoW3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 03:20:57PM +0800, Haotien Hsu wrote:
> From: Henry Lin <henryl@nvidia.com>
>=20
> If memory accesses by the Tegra XUSB controller are translated through
> the SMMU (System MMU), the hardware may continue accessing memory even
> after the SMMU translations have been disabled during the shutdown
> process and this can in turn cause unpredictable crashes.
> Fix this by adding a shutdown implementation that ensures the hardware
> is turned off during system reboot or shutdown.
>=20
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--QfX9Jz0QAjHjoW3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2QLIACgkQ3SOs138+
s6E2EA//Ti2gGtziy55L8HXPtNfWoeobc4xQ5CSAGfFVAyzYBTSnz+iRmeBY6j3k
zuz8OvbMLy7w83wGuuQ8XPPrVoPcuF2kJGa1Qy+IenUWIe6SXq11I7xRCmCCDmTh
wx4n/dxooOV6ol6TbbeswYDYKklpupVfrvYCMm5DChNRpYTC7feDtCl+hOda4Mxp
nPvu05tzxlP4w6DGJnsKT3Zm29RJxfGHZdTiJGq32YAYrtVHcyoez2z6UX2Fa/dw
glk//oe0XBZ7BeygGe2maWYICOALVWRNAOqQ5hMLYsOTEMpz+zx2KxHIv7ipfcJG
p9pFfjCeBUEQKnLAKKO3b7o0uBxN18EumteasHQXXjJmLRQj77hSGtaUcGoJYRUl
f6gLI+wmNUzhmD8vZA93M9uazLVmE6Tu8xAf2RpeucCxuWzPQH+R5+AWBr742Ba/
jntEFbyCZpy+jOvyfiVDkAn9e4gDY14RM5N3XBqQSiovSeSmno/RQ1nL3iPBdHZf
SUtkiD4fuXSnLMdljUu0gQw9odvK3MNiCiHK29pKZ3A6GHU3u5gpnq0p1Pa+I3bF
rSpS1AZ9so+9EEQIK/HNif/d7bGl6Z9ZsY35npKkvzGZXRK7tIWUOrVruc2CuEtC
GatyLzpWSLvXkiBeHMSsAOOVzWU2Puy8+xGzNewzANueEoS4wR8=
=t53d
-----END PGP SIGNATURE-----

--QfX9Jz0QAjHjoW3v--
