Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ECA77CDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbjHOOUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbjHOOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9DF173F;
        Tue, 15 Aug 2023 07:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0AC262500;
        Tue, 15 Aug 2023 14:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A470EC433C8;
        Tue, 15 Aug 2023 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692109200;
        bh=M6CDBqRLiTm3hil0xMDraWij30Iy1mPwFRVOlkOBWRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kh5JOKzYNFtCORZofGVo+WWAEOYTnPQ7hLnXju+uRgP7NOc2+z1lBihPytdEDWSIv
         zQOf6F+54CjpfCoEy8rtZJjCwHKbvibS28v+94JVV5tKp5N/AIjRHnuVph3p779aEu
         tBpZ7o/jCt1EAq1MX3aCv2cYv0zsVbLajaU9ut8vjxzBsHIQmLdCTLzX3RtxtRltIv
         jau/Wmv3PUKd61NlvUEXjqmqxxWUs8nYuFaIUiHAa02nijzTgbyRII9PqEQnrLREo2
         GeNQkToLIub5RBhwq+LRgEH9I/+8V2au2NbGWx+f5J4lCCCHdQ0bPTtsKLIEdMq3Ma
         wLbTilISxICvQ==
Date:   Tue, 15 Aug 2023 15:19:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: loongson,liointc: Fix
 warnings about reg and interrupt description
Message-ID: <20230815-certainly-sprang-209024530924@spud>
References: <20230815084713.1627520-1-zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZyVqBzIaMuBVfm1G"
Content-Disposition: inline
In-Reply-To: <20230815084713.1627520-1-zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZyVqBzIaMuBVfm1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Aug 15, 2023 at 04:47:13PM +0800, Binbin Zhou wrote:
> As we know, some Loongson-2K CPUs are single-core, e.g. Loongson-2K0500,
> and the "isr1" means routing interrupts to core1, which should be
> optional. So add maxItems/minItems limits to reg/reg-names.
> Also, The interrupt-names attribute represents a list of parent
> interrupt names that should change with interrupts.

This should have been with the other series that introduces the users
probably so that things make more sense to the reader.

> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../interrupt-controller/loongson,liointc.yaml     | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loong=
son,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/l=
oongson,liointc.yaml
> index 00b570c82903..adb428211a72 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,lio=
intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,lio=
intc.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =20
>  description: |
>    This interrupt controller is found in the Loongson-3 family of chips a=
nd
> -  Loongson-2K1000 chip, as the primary package interrupt controller which
> +  Loongson-2K series chips, as the primary package interrupt controller =
which
>    can route local I/O interrupt to interrupt lines of cores.
> =20
>  allOf:
> @@ -33,6 +33,7 @@ properties:
>        - const: main
>        - const: isr0
>        - const: isr1
> +    minItems: 2
> =20
>    interrupt-controller: true
> =20
> @@ -45,11 +46,9 @@ properties:
>    interrupt-names:
>      description: List of names for the parent interrupts.
>      items:
> -      - const: int0
> -      - const: int1
> -      - const: int2
> -      - const: int3
> +      pattern: int[0-3]

=46rom a quick look at the new devicetrees, I don't understand the
ordering relaxation. Do you actually have a system that only has, for
example, int3?

Also, as the interrupt-names are not required, changing the ordering
here is not ABI compatible AFAICT. Does that have any fallout?

Thanks,
Conor.

>      minItems: 1
> +    maxItems: 4
> =20
>    '#interrupt-cells':
>      const: 2
> @@ -73,7 +72,6 @@ required:
>    - '#interrupt-cells'
>    - loongson,parent_int_map
> =20
> -
>  unevaluatedProperties: false
> =20
>  if:
> @@ -86,7 +84,8 @@ if:
>  then:
>    properties:
>      reg:
> -      minItems: 3
> +      minItems: 2
> +      maxItems: 3
> =20
>    required:
>      - reg-names
> @@ -113,7 +112,6 @@ examples:
>                                  <0x0f000000>, /* int1 */
>                                  <0x00000000>, /* int2 */
>                                  <0x00000000>; /* int3 */
> -
>      };
> =20
>  ...
> --=20
> 2.39.3
>=20

--ZyVqBzIaMuBVfm1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNuJiwAKCRB4tDGHoIJi
0hS5AP0XAkJJcHVeqW/yF5gJ9Z/MyINBReOsxwdQjBgsXlPIygEA4tz9NQ2OsYWL
aB7ZCv2HblA3kM5ikbl5HscxuIBlTQg=
=By9N
-----END PGP SIGNATURE-----

--ZyVqBzIaMuBVfm1G--
