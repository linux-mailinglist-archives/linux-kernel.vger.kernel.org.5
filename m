Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63FD7D9AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbjJ0OLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346076AbjJ0OLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:11:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A32C18F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:11:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAD3C433C9;
        Fri, 27 Oct 2023 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698415900;
        bh=qiPK2+5bbIvnFZbVVqos1S/u2AdHxbqykbMWZHHXeiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+h2mAlTeznQyw9FEZ6q7a/Yc4daSJLb373j7XfWgfwt4u6pT/QB7I7r26Uvy6l1v
         jeLTaV9iB8eXeABbaFc78yp3zyZoVcYj3phgewglZpGrTZV2hg3WFPadlQ3Bv3XxgJ
         mTaH6IWdx5I4wF6mskwkrrmp0Z3Li1M2m/48WkmYRzWtT8JYVM3xEZNnNiVNJ1Eq3B
         xFWdWhVtkPTu0wVIEh/avYTQwxwtiiK7B5orqm0IGXzm4wHDfZLqc7jwwh/heSLTi1
         Ry9ucEsKi1dPYYO4LiM80iGu5cH4sq5QMTt9juk96LdVv4uIHk/oKQhjGIxJXjTnYR
         s7ukr0I9mrMSg==
Date:   Fri, 27 Oct 2023 15:11:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
        CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
        supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: nau8821: Add DMIC slew rate
 selection
Message-ID: <20231027-pronto-prideful-2cf3415a9d87@spud>
References: <20231027082144.639369-1-wtli@nuvoton.com>
 <20231027082144.639369-2-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Utulr+me0/RPd4KV"
Content-Disposition: inline
In-Reply-To: <20231027082144.639369-2-wtli@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Utulr+me0/RPd4KV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Oct 27, 2023 at 04:21:43PM +0800, Seven Lee wrote:
> Add input with DMIC slew rate selection
>=20
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nuvoton,nau8821.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml=
 b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> index 3e54abd4ca74..01028b7ff85c 100644
> --- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> @@ -89,6 +89,13 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 3072000
> =20
> +  nuvoton,dmic-slew-rate-selection:
> +    description: the number from 0 to 7 that sets the DMIC slew rate.
> +        The unit is mV/ns. 0 is the slowest, and 7 is the fastest.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 7
> +    default: 0

I meant make the property in terms of the unit, so
nuvoton,dmic-slew-rate-volt-per-sec (or similar, Rob would likely know
better how he likes the unit suffix for a more complex unit like this
one) and then make it an enum with possible values corresponding to
the real values that putting 0, 1, 2, 3 etc into the register produces.

Cheers,
Conor.

> +
>    nuvoton,left-input-single-end:
>      description: Enable left input with single-ended settings if set.
>          For the headset mic application, the single-ended control is
> @@ -127,6 +134,7 @@ examples:
>              nuvoton,jack-insert-debounce =3D <7>;
>              nuvoton,jack-eject-debounce =3D <0>;
>              nuvoton,dmic-clk-threshold =3D <3072000>;
> +            nuvoton,dmic-slew-rate-selection=3D <0>;
>              #sound-dai-cells =3D <0>;
>          };
>      };
> --=20
> 2.25.1
>=20

--Utulr+me0/RPd4KV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTvFFwAKCRB4tDGHoIJi
0oU8AQCj7pUfn9S1XRtqy6D5OsCQmxBVTCNuJ1c20C0wtxBy1AD+O3vJBYzE6iVc
BMhcpZ436Z5tHhcVPq+K0vt37JpUTwo=
=y/dP
-----END PGP SIGNATURE-----

--Utulr+me0/RPd4KV--
