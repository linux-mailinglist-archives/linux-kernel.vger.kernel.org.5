Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4827F44EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbjKVL2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbjKVL2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:28:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004AA112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:28:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6C2C433C8;
        Wed, 22 Nov 2023 11:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700652527;
        bh=nd29HlBeBDrnX7RmuEDzI2lVmEwQmMASfSYYYr5JFg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4caps0ZnFGaM00pnG5/NA9htCJdRb4ndMuCq99cMHA4qlxlfdFxt+gAiZVWidUQP
         wJinw27dr8gIyIZ3LqhnJYvgYm5HD7qNM46e188lnUiW1EgI3+cfSxM0HmBC7Z3WuF
         1auiMro9qE/todxKFWQJcnAndlMB85RyRNTMGVG8QwN8Ijf1jocygipaPOuqVvua9/
         UN+aw3lRemlbYj3vWem//BZyF2htvlHZMBsVBHmgnDHMKvn1L3KtjS6MUm+vkuJF7o
         zr95EvAe4GxPjiTLTyK6fNQ+AU87niZLWULgpyhbBCo01IhWzoOuWsGXeGVHQc/2Sm
         xo0WwHIn9HULg==
Date:   Wed, 22 Nov 2023 11:28:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] riscv: Remove unused members from struct
 cpu_operations
Message-ID: <20231122-undiluted-five-d40876e02215@spud>
References: <20231121234736.3489608-1-samuel.holland@sifive.com>
 <20231121234736.3489608-3-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gXVNW1QTj3aHYLp1"
Content-Disposition: inline
In-Reply-To: <20231121234736.3489608-3-samuel.holland@sifive.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gXVNW1QTj3aHYLp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 03:47:25PM -0800, Samuel Holland wrote:
> name is not used anywhere at all. cpu_prepare and cpu_disable do nothing
> and always return 0 if implemented.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Part of me says this should be split so that it can be partially
reverted whenever we grow users for these, but I doubt that the
implementer of that will notice nor that anyone will remember you
removed them. Certainly wouldn't object if there was a split though.
I guess in general this was a case of copy-pasting stuff from arm64
that we did not yet have users for.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--gXVNW1QTj3aHYLp1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV3l6wAKCRB4tDGHoIJi
0kl1AQDhseUuUd0jU6qSScl/lRKQnVwGX8tlmltIkuT/WI8aCgEAwZuWythyAXhC
jdsv0bHcPQywC95asqRQCp5PUulYBwQ=
=1A/a
-----END PGP SIGNATURE-----

--gXVNW1QTj3aHYLp1--
