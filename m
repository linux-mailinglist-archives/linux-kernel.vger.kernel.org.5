Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9128F7D3CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjJWQzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjJWQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:55:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF9EE6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:55:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF1CC433C7;
        Mon, 23 Oct 2023 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698080121;
        bh=Hpe7ekaJs73CJgZf5fhyangHoKF2l+kv/gkvQP5ZgmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhmS5jI05JwAioYZMc0FUT+5OFTFXShOEqQJCKnqWdA2tAS9QqOYhjLqNVCKDlATx
         LJuHsmtQA55nvPrV/HcQ/b9Jhm+9gxHsIdrIfw3r8LIN/8c6eC84kpEkNXkV2/GCLL
         XsfhMmfaq+u34YgutzjKqJKxiplQUcdVW+cU4e6ZS9B0XKhhVgwoTBlaCJ16UcuaOm
         sZWNJ7jzyjTUDsoEh6WRqtlh60agRqnpxxgxfPCbB2+6bTRTGvKLV6+zzMvbcXKXjj
         /cUNJ5GU+3B6KJgT9LeG58dn66g2hGW2tfTq6Mkq5JS9pFWm1c+ezfplQif+GuHKNz
         qUIldiPM+LTLQ==
Date:   Mon, 23 Oct 2023 17:55:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
        CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
        supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: nau8821: Add DMIC slew rate
 selection
Message-ID: <20231023-company-coziness-0b50388abfaa@spud>
References: <20231023021537.617980-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6XhV5INvunCnaq1A"
Content-Disposition: inline
In-Reply-To: <20231023021537.617980-1-wtli@nuvoton.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6XhV5INvunCnaq1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Oct 23, 2023 at 10:15:36AM +0800, Seven Lee wrote:
> Add input with DMIC slew rate selection
>=20
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nuvoton,nau8821.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml=
 b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> index 3e54abd4ca74..5f7f2eed4834 100644
> --- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
> @@ -89,6 +89,12 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 3072000
> =20
> +  nuvoton,dmic-slew-rate-selection:
> +    description: number from 0 to 7 that sets DMIC slew rate.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 7
> +    default: 0

I'd much rather this was an enum of possible values in $unit, than what
appears to be values you want to write to a register.

Cheers,
Conor.

> +
>    nuvoton,left-input-single-end:
>      description: Enable left input with single-ended settings if set.
>          For the headset mic application, the single-ended control is
> @@ -127,6 +133,7 @@ examples:
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

--6XhV5INvunCnaq1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTalcwAKCRB4tDGHoIJi
0lUgAP0dICzYGKOkFJyrsYF0Pcon1DPv052uYcDE0imGelULMQD9FUUVcAFtlJFy
ayCgZF3Du2NWFIzNgjEbBbFyfd77GQQ=
=7mpV
-----END PGP SIGNATURE-----

--6XhV5INvunCnaq1A--
