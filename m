Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60117CF517
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbjJSKYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbjJSKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:24:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E88FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:24:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF24C433C7;
        Thu, 19 Oct 2023 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697711057;
        bh=8w/zkHRa1JdAqlwq/E0kRF19C4ENGGq0dlrO06vTgUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eK1Xp6sFnz1B6gliEaZ+xBeCJf1peb9IMNOhrsL4RWq+dnvbEfuuC2dsJk/JRRkXM
         J3ZkFfUpKW4V5Vd7PCpdXcGP3ZN0OCHdeGIWhNBkfTBlxN+CFqPazcwS9gJ6H7w2DQ
         ovFyEaelYdJh9ij0CwFsJXmMpZ2jZVgkvvxfUpyp73ptRTAneUOMqEjsA1ukabD6rd
         vwhSOg/c5khxXZ24UZ2iXryyq1gWZcZst41KXM57jeVjBWmmfB/iyJZzra+VrN+J1q
         wo91KM3ZtTml7zOAIxrJ3M9F3zqBX/plEF85/b19XJo/0XoIbvKA/JtA2OEgGPaqBS
         R3M9RKhLdYPLQ==
Date:   Thu, 19 Oct 2023 11:24:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 01/19] riscv: hwprobe: factorize hwprobe ISA extension
 reporting
Message-ID: <20231019-smith-purging-627c50cfa3de@spud>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-2-cleger@rivosinc.com>
 <CALs-HssL=wNwj9nRuZwpZhy1CB9p9-X=OqgwBw9zvgA7hA4fEg@mail.gmail.com>
 <20231018-scrap-bankable-a0f321d97a46@spud>
 <20231018-flagpole-footpad-07a6228485f3@spud>
 <CALs-HsteDO0PvAKKQje7wU0f4z8w2V3f7WiHh5+LvQeVaSua1w@mail.gmail.com>
 <0b2cbc89-7892-4c43-898c-03757eaaf3b7@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MSxFgo6sxF0bjJRN"
Content-Disposition: inline
In-Reply-To: <0b2cbc89-7892-4c43-898c-03757eaaf3b7@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MSxFgo6sxF0bjJRN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 11:46:51AM +0200, Cl=E9ment L=E9ger wrote:
> Indeed the comment was a bit misleading, is this more clear ?
>=20
> /*
>  * Only use CHECK_ISA_EXT() for extensions which are usable by
>  * userspace with respect to the kernel current configuration.
>  * For instance, ISA extensions that uses float operations

s/that uses/that use/

>  * should not be exposed when CONFIG_FPU is not set.

s/is not set/is not enabled/

But yeah, definitely more clear, thanks.

--MSxFgo6sxF0bjJRN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTEDywAKCRB4tDGHoIJi
0iLiAQCVvbdU9kMXk61P1KCsz7hQbLc/FDPWHPqbM77la819uAEAmKVIMjRr/pbZ
zKR82CM26DAk6y9VBR56NcHWjJucaA4=
=NmdN
-----END PGP SIGNATURE-----

--MSxFgo6sxF0bjJRN--
