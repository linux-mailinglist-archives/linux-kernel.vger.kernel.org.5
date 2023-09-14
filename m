Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2707A0C24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjINSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjINSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:02:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12142B9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:02:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E94FC433C8;
        Thu, 14 Sep 2023 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694714553;
        bh=u2uKvCKS3midq3haWQnJKbw1soML/UV33sJ4XPbBMH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNewOcqz4IYX15gybK4ltio6PlLFZBa6NN9tHoxcvJfKbppUVlS33bLQQ3ev3n7n3
         5jeV1xOdPUqdMbyF+lacjzlKV+oCBGFiWQLfavlVVBnkPWr8W9obtKwGmkPLrL6jBB
         HLPdQtP8IGVrTzZt0D42pwrlzGKj0KB9PKYoJ51XkU2DtkVzOa0X2MKtJTTbJ4/DOj
         nmU9+dux0DUar3PEqDQStAv/VUR6LOesWGg8zQ9/VWSZN2oYxjdGqUX6IMDowKBSZo
         Cty/e7i16lO3xVVUWKnFFUkLdBzlkYm/WbYIQbbi93RFYAbgJXB/IRncId/cKoG7FX
         SUj/NOwqEbHag==
Date:   Thu, 14 Sep 2023 19:02:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 2/5] riscv: Add checksum library
Message-ID: <20230914-thinness-overtly-70c49b219c26@spud>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-2-77cc2ad9e9d7@rivosinc.com>
 <20230914-mural-deskbound-0e37d0767f6f@wendy>
 <ZQNJ0LQhZyJWlcSy@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ChjGALr+r4z5FydN"
Content-Disposition: inline
In-Reply-To: <ZQNJ0LQhZyJWlcSy@ghost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ChjGALr+r4z5FydN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > +#ifndef CONFIG_32BIT
> >=20
> > These can also be moved to IS_ENABLED() FYI, since there's no 32-bit
> > stuff here that'd break the build for 64-bit. Ditto elsewhere where
> > you've got similar stuff.
> >=20
> > Cheers,
> > Conor.
> This is an ifndef, so 32-bit compilation would throw a warning about
> shifting by 32 bits if IS_ENABLED was used instead.

 Fair enough. I did accidentally invert things in my mail, I did notice
 the n, I just thought it did the elimination beforehand those checks,
 sorry for the noise.

--ChjGALr+r4z5FydN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQNKtAAKCRB4tDGHoIJi
0hQIAP0TaJ5v9C2aA8jh9MwH/7topxwBBzwWIRbDvY/3q85ADwEAvxQzCaG4ICHq
BiX5F2KfS/M6cJhJcXvBCcJrctFo8w0=
=Sgyp
-----END PGP SIGNATURE-----

--ChjGALr+r4z5FydN--
