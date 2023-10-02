Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A087B7B50A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbjJBKzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBKzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:55:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F390B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:55:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2DBC433C8;
        Mon,  2 Oct 2023 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696244135;
        bh=F5fHvFLRPSXGAJr5Hur9dBSrn1AlR9jGY19xXDVZ+To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebkPo+WRr0ngMFnObD+G/SsGSqtuAZEKlpHHoqkawi7RHXBd0sxsUG1QkXKc4cspE
         yXV9hVW556TzPBMhNay2gmLR0xCSP7cTqvz24ZSxXFPJHxS7EbVrLlkbu5tPn/va28
         KiRrn96lV6TFqopL8izAFIlDB1GsqBvOqDGZbicqpaER2bm9y9z60L/vIcN48UqDMr
         ldNgeV+OVuCnO8knQ+oMMYiDA8FCXzE1s/WQCoYF6JqHlaCnS6Q9U7ae2hcazzxqQP
         7HD6J9uiy4kr71HI+xrd4V1XoE+8q8CmsuaLjEAQr3KbLmBTmTaQA+bP9OVyYNXc5U
         3E2ep5dWxtknw==
Date:   Mon, 2 Oct 2023 11:55:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v2 1/2] riscv: errata: thead: use riscv_nonstd_cache_ops
 for CMO
Message-ID: <20231002-angles-utopia-6c6c7b18231e@spud>
References: <20231001103433.3187-1-jszhang@kernel.org>
 <20231001103433.3187-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U/Lf1c64QYsza03U"
Content-Disposition: inline
In-Reply-To: <20231001103433.3187-2-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U/Lf1c64QYsza03U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 06:34:32PM +0800, Jisheng Zhang wrote:
> Previously, we use alternative mechanism to dynamically patch
> the CMO operations for THEAD C906/C910 during boot for performance
> reason. But as pointed out by Arnd, "there is already a significant
> cost in accessing the invalidated cache lines afterwards, which is
> likely going to be much higher than the cost of an indirect branch".
> And indeed, there's no performance difference with GMAC and EMMC per
> my test on Sipeed Lichee Pi 4A board.
>=20
> Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
> the alternative code, and to acchieve Arnd's goal -- "I think
> moving the THEAD ops at the same level as all nonstandard operations
> makes sense, but I'd still leave CMO as an explicit fast path that
> avoids the indirect branch. This seems like the right thing to do both
> for readability and for platforms on which the indirect branch has a
> noticeable overhead."
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--U/Lf1c64QYsza03U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRqhowAKCRB4tDGHoIJi
0piXAP9YVt+cUOHo4WTwqUZ7/v9f9zmKv0aMbkueUtWc8W5O7QD/RBTXAJXMS6mi
pEEyPYGX00rO85GTDF1mlRpvqiiPKAA=
=KGQg
-----END PGP SIGNATURE-----

--U/Lf1c64QYsza03U--
