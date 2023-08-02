Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8573576C627
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjHBHNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjHBHNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:13:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE921995
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:13:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-317716a4622so5927216f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 00:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690960386; x=1691565186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwq+yP8jDsvTAud/Th5cBrU0e0G6v46KPRumIYV4BfI=;
        b=HKyngWBSVi496wQZp8b2eI39SGr3C5W+4y2APvLNfadSYgM5QeRmanUUipNRqT1AeJ
         NHXhJQoX1eY28oGLKbxYKbfCUBGDTeJ7emMD3QepEfmHRALvBq3OUu1IS7uOQDn7bCep
         9jI5B8oEveZdA43Qmom+mimkXL+QJTWuucsbFTje1c7U5Wv8g+A4k5Be4oB1wz93ItLo
         YP6TsIQIqDSbTAWR3/oK3UgOtqHLlm6EBRTygJCjrvyW5T3Wdoz6P8uxMAkU1GKkHBY2
         qMDKfLJXzMQpcirBgPAiD3btzWjP1yg1TfS4uLCj9slctDJipIxmWUqfS0C+W37kXRJE
         pd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690960386; x=1691565186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jwq+yP8jDsvTAud/Th5cBrU0e0G6v46KPRumIYV4BfI=;
        b=kXzz5zmAyOp7DAzuTotyQQNf2d9nIayJFKKP68ozBr02hmqnHCopBDT1GI07B1R+uE
         iXt8gfsPwRJEplfQo8xOEfgqX0H2Yb0HhszTroOzUmDNy4KKVXumbbsUEVqhvzT5W4ew
         mrgsamuo1LjyUMY2fTDswP08gzxgoAgwlylLz6UXu7EDH5BrDdAiQ4dHFBeURcKfbINh
         5ni3klkRyxH2vXtEl2AbXO4PGQpX6WMYe46FEH5EAQIauvvWa+F90uqSuMGgDs62wN2x
         ImUHBx3I+6yWsalFBLjXtckKp1w7vL9QO7p1iDH3zkGGzfaaZeEncWnJbuJkwG+mK3pI
         Cm5Q==
X-Gm-Message-State: ABy/qLaH6j4m97YkgvNXEEsC5IKiECufKlHaHbSFB3GhwHPmFz52P6UZ
        eVugNNKB+nUSviBtGFWpAOnpBVNT5ILBv0x2
X-Google-Smtp-Source: APBJJlFq+iLzEmwZqJqYmwenA+kXqSswGJAFzhF0or3i+7LKn8qW01BuRwExIYk6pfUTQUYQgG6gsg==
X-Received: by 2002:adf:f08d:0:b0:317:7448:6613 with SMTP id n13-20020adff08d000000b0031774486613mr3563511wro.55.1690960386403;
        Wed, 02 Aug 2023 00:13:06 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d44d0000000b00317b5c8a4f1sm1335845wrr.60.2023.08.02.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:13:05 -0700 (PDT)
From:   Joel Granados <joel.granados@gmail.com>
X-Google-Original-From: Joel Granados <j.granados@samsung.com>
Date:   Wed, 2 Aug 2023 09:13:04 +0200
To:     Justin Ernst <justin.ernst@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH] Update HPE Superdome Flex Maintainers
Message-ID: <20230802071304.4rrop4nxczprlxxx@localhost>
References: <CGME20230801155851eucas1p2faea4b189a0794d44d10621ca85a0a11@eucas1p2.samsung.com>
 <20230801155756.22308-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sbnqcbascfgsbeaz"
Content-Disposition: inline
In-Reply-To: <20230801155756.22308-1-justin.ernst@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sbnqcbascfgsbeaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 10:57:56AM -0500, Justin Ernst wrote:
> Mike Travis has retired. His expertise will be sorely missed.
> Remove Mike's entry under SGI XP/XPC/XPNET DRIVER.
> Replace Mike's entry under UV HPE SUPERDOME FLEX.
>=20
> Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 53b7ca804465..db3dce00a274 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19285,7 +19285,6 @@ F:	drivers/misc/sgi-gru/
>  SGI XP/XPC/XPNET DRIVER
>  M:	Robin Holt <robinmholt@gmail.com>
>  M:	Steve Wahl <steve.wahl@hpe.com>
> -R:	Mike Travis <mike.travis@hpe.com>
>  S:	Maintained
>  F:	drivers/misc/sgi-xp/
> =20
> @@ -23144,7 +23143,8 @@ F:	arch/x86/platform
> =20
>  X86 PLATFORM UV HPE SUPERDOME FLEX
>  M:	Steve Wahl <steve.wahl@hpe.com>
> -R:	Mike Travis <mike.travis@hpe.com>
> +R:	Justin Ernst <justin.ernst@hpe.com>
> +R:	Kyle Meyer <kyle.meyer@hpe.com>
>  R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
>  R:	Russ Anderson <russ.anderson@hpe.com>
>  S:	Supported
> --=20
> 2.35.3
>=20

Reviewed-by: Joel Granados <j.granados@samsung.com>
--=20

Joel Granados

--sbnqcbascfgsbeaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTKAgAACgkQupfNUreW
QU8ZCwv/bzTouLXTrx7Imt8C4a7N0u9CA/LDyGXzbxFBLPlAgLV2OlgA1K0oxWCq
/MNLJ7oMFfpoH1uYOZQxTB0oFI3ZuQIIYeAV/zPxhemDamdKkS/9Qf1ZrRSxY7WB
tT+uK29gy96X8bnjheYvaEBZbk1J2lC5t4znWH3wRG9lhLg8XHXbf7jIbLTYBP0w
XuJv1AUTQvAZlAsLXHJ2kGx+vZbMO1Mva4jaX2kRqVgekL7GM0wd1pBojY2Yw0I8
0nXKHwLMMV1PnR/aY7RyF2q20/8DWKbnTNlR2/yCU8Dru9p56hgBbbAYnCDDTjJ+
5M1xh6E+xIXlwbfArRecRCJD5XGmh5S2OqRF9sNoVe30Xcv3oq+Plc3/jDn12DbB
aR2XCeTbYSupKZfT4eR4moBAr9+yKSueq21N1y1fuNEGsSs+NGbnzuBwXqzTs8oZ
OQcWDJigIPVHNI9/s6gDFivb/q7MjpjlrC4ZwD3PPSpeWbKbq2YuVLDxJmK+Sp2Z
CSO3ZpM2
=RMkr
-----END PGP SIGNATURE-----

--sbnqcbascfgsbeaz--
