Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9D7D8355
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbjJZNKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjJZNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:10:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2027A12A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:10:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F91C433C7;
        Thu, 26 Oct 2023 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698325841;
        bh=EfXXgft1MEBK+Cu8UhIL0I9B4dpq2qUgaI53cQZ71SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCbkkVkBmnV/JtBgJxk7QNRutR0z0QbFxnPJIMFqDXKdey/uM6vnZnIOAc8Jg7Pck
         Unc2ItPgRJDVmnyGihoszNI/jJiCi8C3g+RhC9l9Q8ELaMEV3SKV8onKvkH9WN8WgF
         fOVRIXBG5H75RMP3tz3pNXA7Qid6zxRDCto7XCWl/akHzziZxUltezEadjjwrtY3Tr
         DlbD1xw/W2T3PgpNBYG7fAXXjYrZKIHfRZdUABe+TBljpVNfa1/xyhRl+N20AUk7PF
         jf0eCwzQ3gwMBmZNBgIWVBvRRbW5I2rfh3n3GuRR7iwRMReyXVmioBpYb5SHu3l+zH
         YWBIKb2vOKFsg==
Date:   Thu, 26 Oct 2023 14:10:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/4] dt-bindings: cache: sifive,ccache0: Add StarFive
 JH7100 compatible
Message-ID: <20231026-paycheck-equation-b0f1a1191bf2@spud>
References: <CAJM55Z-vw1sbks0KcHOXMzP-6c9NMg+GOndi2pQ7iyWh0=oQiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="N3bHDx1Rs6y3UHHy"
Content-Disposition: inline
In-Reply-To: <CAJM55Z-vw1sbks0KcHOXMzP-6c9NMg+GOndi2pQ7iyWh0=oQiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N3bHDx1Rs6y3UHHy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 11:56:37AM -0700, Emil Renner Berthing wrote:
> This cache controller is also used on the StarFive JH7100 SoC.
> Unfortunately it needs a quirk to work properly, so add dedicated
> compatible string to be able to match it.
>=20
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> index 8a6a78e1a7ab..7e8cebe21584 100644
> --- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> +++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> @@ -38,7 +38,9 @@ properties:
>                - sifive,fu740-c000-ccache
>            - const: cache
>        - items:
> -          - const: starfive,jh7110-ccache
> +          - enum:
> +              - starfive,jh7100-ccache
> +              - starfive,jh7110-ccache
>            - const: sifive,ccache0
>            - const: cache
>        - items:
> @@ -88,6 +90,7 @@ allOf:
>            contains:
>              enum:
>                - sifive,fu740-c000-ccache
> +              - starfive,jh7100-ccache
>                - starfive,jh7110-ccache
>                - microchip,mpfs-ccache
>=20
> @@ -111,6 +114,7 @@ allOf:
>            contains:
>              enum:
>                - sifive,fu740-c000-ccache
> +              - starfive,jh7100-ccache
>                - starfive,jh7110-ccache
>=20
>      then:
> --=20
> 2.40.1

--N3bHDx1Rs6y3UHHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTplTQAKCRB4tDGHoIJi
0l+AAP4vVuMXUegOCudC7vu4oDma0ogJA3LYsJGQx+aFcJo2pAD+Jv0QZsCbaVCC
ZM+iTmoolMuerwlZgbvaO0N+e3S0uQE=
=w4QN
-----END PGP SIGNATURE-----

--N3bHDx1Rs6y3UHHy--
