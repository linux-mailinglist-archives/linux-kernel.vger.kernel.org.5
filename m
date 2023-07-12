Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62089750FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjGLRvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGLRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDB1BC6;
        Wed, 12 Jul 2023 10:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97BB8618A3;
        Wed, 12 Jul 2023 17:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E858DC433C8;
        Wed, 12 Jul 2023 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689184268;
        bh=Cp1aI+fc+P9DejxRV+rOKeNNAXqjZv56Y8hzH777L+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2ZIYBSWoLBLTyUcJDkxwbMOen1+zJrTeoZFDGz4p/opeqFB17sKE5MZRuDpf9AkS
         l/HMuBjf9DPow9iS3qAtbDy2HlVCQ1QQ8bYsVsJM1hq7Vxb/0i4Efl4A2rcMXWpD2W
         IhzG9rmmb+VrHBB2rx90A2jpp2nxKDxAt1xhn2tdndBswHT6Kh8dMlnMm9oRIb0SWI
         uf+Lei/zvwb1JL5yD+NI99EnUcv9QnqHTh5xp0SKqJQNPtsn+GizlZ0NsLAuJbNB7o
         NDzTdxJ080QD9lZ+IAiO5vHVieZlD9ZQkTZk34T277rL09EQ0GeABLw3DgJPLMOrpz
         Jo8uMizkxWHRA==
Date:   Wed, 12 Jul 2023 18:51:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        devicetree@vger.kernel.org, sorear@fastmail.com,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH v4 1/4] RISC-V: Add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <20230712-emote-onscreen-c11aa71b00a3@spud>
References: <20230712084134.1648008-1-sameo@rivosinc.com>
 <20230712084134.1648008-2-sameo@rivosinc.com>
 <20230712-bulldozer-affected-199042dc3afd@wendy>
 <CALs-HsuxxVcwX=mSwktPiEiAFkfK+5qJ6zg1Bzf2t37L=pZWjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v3mGsgwTVrXCWkzs"
Content-Disposition: inline
In-Reply-To: <CALs-HsuxxVcwX=mSwktPiEiAFkfK+5qJ6zg1Bzf2t37L=pZWjw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v3mGsgwTVrXCWkzs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 12, 2023 at 10:43:33AM -0700, Evan Green wrote:

> This looks alright to me. At the risk of getting into bikeshedding

I very much do not think that that is bikeshedding FWIW.

> territory, the only awkward bit of it is it composes the extensions in
> sort of the opposite way you'd expect. I tend to think of Zks as being
> comprised of {zbkb, zbkc, zksed, zksh}, rather than zbkb being a part
> of {zks, zkn, zk}, though both are of course correct. Here's an
> untested version of the other way. You can decide if you like it
> better or worse than what you've got, and I'm fine either way.

I'm happy to do it this way too, just wanna see how it interacts with
the new property stuff. I actually found it confusing to implement the
arrays, it just seemed easier to integrate with the new property stuff
this way.

> Sorry
> gmail mangles it, if you want the patch for real I can get it to you:

Please, reading the line-wrapped mangling hurts my head unfortunately.
Tree or attachment WFM :)

Thanks,
Conor.

--v3mGsgwTVrXCWkzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7oBQAKCRB4tDGHoIJi
0mIFAP92dJfa+U4vPOtK6HIzhgoVC2mg0JyOI8zgfJzRRSzV0gEAieics5MVx9MA
WEUAz/SetjYFkBa4tO96h0am7lSlSAc=
=jwFk
-----END PGP SIGNATURE-----

--v3mGsgwTVrXCWkzs--
