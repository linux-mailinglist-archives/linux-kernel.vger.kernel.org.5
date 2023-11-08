Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2990A7E598F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjKHO5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjKHO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:57:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D841BE6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:57:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6465FC433C8;
        Wed,  8 Nov 2023 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699455440;
        bh=LKL1hs/khI8hKTDotLj4TlzooB07x3t7D/CuzzZG+Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3j5TevN8fsXBPvYnztlof7HiDniQcTKHv3coqsz0QT785G+eoPCtqqMYWpbFO96M
         gMvkHunctwfdJGhNwCe8dw1uq3Yxe5U9MJ3CYnAM4u2jwcGEtl5NnZSs1PNQJTdjzj
         qv1n3tARR6K9+GS2VGWHJS/G/+j7qLxDQg/RFlUal9qLJVdqA1pCnOGhrkpsKjIfR4
         3AZi5nGl5SRtY9i92JjRacjWwn2fyh9kLusChllojkFy1489ygIO8+CGvotGnX8rcZ
         JVOwoZxO4xvjiKsPRZgJTqaqAV9w0BFyxaEvM/rSYEudhIiDJ2x2sDxIINRNh4+0ji
         +R8XiS//Kmy4w==
Date:   Wed, 8 Nov 2023 14:57:15 +0000
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v3 05/20] dt-bindings: riscv: add scalar crypto ISA
 extensions description
Message-ID: <20231108-grower-handwash-63526d449e9c@spud>
References: <20231107105556.517187-1-cleger@rivosinc.com>
 <20231107105556.517187-6-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IXI5peX4j7nYK3nr"
Content-Disposition: inline
In-Reply-To: <20231107105556.517187-6-cleger@rivosinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IXI5peX4j7nYK3nr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Tue, Nov 07, 2023 at 11:55:41AM +0100, Cl=E9ment L=E9ger wrote:
> +        - const: zkr
> +          description:
> +            The standard Zkr entropy source extension as ratified in ver=
sion
> +            1.0 of RISC-V Cryptography Extensions Volume I specification.

So the topic of the seed CSR came up on the U-Boot ML in the last few
days:
https://lore.kernel.org/u-boot/20231107212431.GP6601@bill-the-cat
I think we need to document that having zkr in riscv,isa-extensions
means that the CSR is accessible at the privilege level to which that
devicetree has been provided.

--IXI5peX4j7nYK3nr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUuhugAKCRB4tDGHoIJi
0jq9AQCA7EiDhuy9EermqoTOWmWVVqY7W1Mxzc1nVYddhZ9YVAEA5v5PcwTZ0QpO
ppUXycCAScJGAc/3pFd+DuL0WqaXxAc=
=fV9h
-----END PGP SIGNATURE-----

--IXI5peX4j7nYK3nr--
