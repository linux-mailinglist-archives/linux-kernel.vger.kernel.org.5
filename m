Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EA2799F8C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 21:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjIJTqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjIJTqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:46:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EDD12C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:46:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FC9C433C7;
        Sun, 10 Sep 2023 19:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694375202;
        bh=0mvlneHp3c5CaAZWyTI0H0bsvFFK1kORjGTdIZMpYRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNu7XQCOOWWxuhn83tvc45l4SurevbxCseaO3e7zweDPnkiFN79JVQ8NBbOSw8zF2
         rxppa4yUMHfgC7ofTpxl7BseKR9GMA+GleM5xt+C7Q7t1sTHk7NF7satVwjWYUN66e
         s1E8q9k6ge1M6v9dAaH6NVkiqkz3HuvGuQ19JmQtxNUJp2nfesCePg3nhCBL6Rv0Xb
         b+Cy0UbkeWqHMtoguJxOtLLglVtRgTOb7HYFaoH1Mkt8d7MSzbGUWCn3qploEb87q/
         PAlXt7DmRi4bIgLM8+SxCPYdY1tCZ4CRVjymtWbG3vwwE8KYMmXUtwvz9HuT7R3pit
         zugbaYRnjekJQ==
Date:   Sun, 10 Sep 2023 20:46:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] riscv: mm: Always flush a single MM context by ASID
Message-ID: <20230910-haggler-barrier-421cefb0cc79@spud>
References: <20230909201727.10909-1-samuel@sholland.org>
 <20230909201727.10909-7-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XAP+SDGC73uO892R"
Content-Disposition: inline
In-Reply-To: <20230909201727.10909-7-samuel@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XAP+SDGC73uO892R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 09, 2023 at 03:16:34PM -0500, Samuel Holland wrote:
> Even if ASIDs are not supported, using the single-ASID variant of the
> sfence.vma instruction preserves TLB entries for global (kernel) pages.
> So it is always most efficient to use the single-ASID code path.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

On nommu:
arch/riscv/include/asm/tlbflush.h:59:69: error: 'mm_context_t' has no membe=
r named 'id'
arch/riscv/include/asm/tlbflush.h:61:9: error: implicit declaration of func=
tion 'local_flush_tlb_all_asid'; did you mean 'local_flush_tlb_all'? [-Werr=
or=3Dimplicit-function-declaration]

Cheers,
Conor.

--XAP+SDGC73uO892R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP4dHgAKCRB4tDGHoIJi
0m6yAQC30XIJEbs6GqdPJenN69cc0QqOG8mlUD4J0NJQ1HsG6QEAmbJu7+FKS0oJ
Cv27cSMuq/YLDqJFq8GD2qPkVIAsywE=
=NMxL
-----END PGP SIGNATURE-----

--XAP+SDGC73uO892R--
