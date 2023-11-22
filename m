Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969B87F44FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbjKVLjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjKVLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:39:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F919E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:39:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAFDC433C8;
        Wed, 22 Nov 2023 11:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700653182;
        bh=VmW4F8kTifiFSh6BqDjXyPl2aYfa/5M1kYdSXNmpqUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tertpv0AmfAPt/Xcz7yBNiwzLEHsFibJOnFqrOxNxUWzaf4vyZSKqm5fzaVqgbaNF
         rwU/xatzndvY6xFDJxR1Y/YiMokIcqJQ38M9BmdU2+Toi0Rj/J03tRlOik7JJXHo6n
         JwTAqYm1JI5suSLS4988ZLVMKtCdvzRR1mBHROBkZQPEOD+k1qG/V8tMO/Mon76hrL
         BVE/WojeVMzZKq8ssy0/Eh++OnqMZQt1Hyl81nOKzJhGfVTOAqnYHgyzu74xReLeK0
         ay1NyYZGvvxHGFHtZPV1lp8Pn1pLAW7DHEdpVYmrZBW4ojLYZWW2zqDg9JEC5KsMXh
         pT2En0DU3eMrg==
Date:   Wed, 22 Nov 2023 11:39:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: Use the same CPU operations for all CPUs
Message-ID: <20231122-helpless-shaded-64908019806e@spud>
References: <20231121234736.3489608-1-samuel.holland@sifive.com>
 <20231121234736.3489608-4-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H0nbdlz8saF9L2tX"
Content-Disposition: inline
In-Reply-To: <20231121234736.3489608-4-samuel.holland@sifive.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H0nbdlz8saF9L2tX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 03:47:26PM -0800, Samuel Holland wrote:
> RISC-V provides no binding (ACPI or DT) to describe per-cpu start/stop
> operations, so cpu_set_ops() will always detect the same operations for
> every CPU. Replace the cpu_ops array with a single pointer to save space
> and reduce boot time.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--H0nbdlz8saF9L2tX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV3oewAKCRB4tDGHoIJi
0vo3AP93PDoNlu1sONLMMAIuktMR4gdPYlMY/mfVRifvpMqYOwEAsc0afAZCXp2T
W0/K/Y7VZa4GZyjCylaWW5XFCYaETQQ=
=Uow1
-----END PGP SIGNATURE-----

--H0nbdlz8saF9L2tX--
