Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A75806DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377441AbjLFL0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377871AbjLFKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:55:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F93A9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:55:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F62C433C8;
        Wed,  6 Dec 2023 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701860153;
        bh=CvKE1IH3LYnXGhtee6s3Q9ZQyTzdlpf3P98EaHJKW/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aW9tMVZ8X8hTnrUJt2kVZEBKg3OqNJNF0L0l9tspUrRzVceWE6yMFP6tQoDrVXCxS
         iCME7Z7Qty6HE/6uXnIIgyae9s4cz+fEO2d6Lo4r8ekJbk/kcjW614pX+O89Pe5U6C
         iIRU0EdtdDOjQLkyrMNfsn43pzlI0SY88bTXl1TrL69nLzjkTdasDdPtJl28UKNVnu
         HAfQW8pTkpCGrZ0Hl3RPFhAZ2ofQXkphd0sXu4uWRVXogGv1ZAkUrS68h3RWLBNTaq
         O3MKr2UvcxTM9qUxiTgAYwWmEoF52mUmJzFUwryYHIVfDi32fy4EAOVUuX7dOoxcKY
         jRFsD/yQvBtpg==
Date:   Wed, 6 Dec 2023 10:55:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] drivers: perf: constify the ctl_table argument of the
 riscv user access handler
Message-ID: <20231206-flanking-frill-fffeca740221@spud>
References: <CGME20231206084652eucas1p1fd6025710032f3a4a64b05dab67a2a17@eucas1p1.samsung.com>
 <20231206084642.802053-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bllXRtefT9FoHVhp"
Content-Disposition: inline
In-Reply-To: <20231206084642.802053-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bllXRtefT9FoHVhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 09:46:42AM +0100, Marek Szyprowski wrote:
>=20
> Fix riscv build break after commit c8be9e66ca1e ("sysctl: treewide:
> constify the ctl_table argument of handlers").
>=20
> Fixes: c8be9e66ca1e ("sysctl: treewide: constify the ctl_table argument o=
f handlers")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

This breaks the build when applied to the RISC-V tree. I'm going to mark
it "handled elsewhere" in patchwork since it needs to go into whatever
tree has the broken commit.

Thanks,
Conor.

--bllXRtefT9FoHVhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXBTNAAKCRB4tDGHoIJi
0g+CAPwJ49hgJ9JEla24sr8w7HMLc1m/NehzyP5r8yTlkre2TQEA7SZee3gvdL7i
80kwXZlyHO6IsP9BRkSoWLYBnpaxKAw=
=NaDC
-----END PGP SIGNATURE-----

--bllXRtefT9FoHVhp--
