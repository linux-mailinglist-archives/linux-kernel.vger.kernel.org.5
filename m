Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B967A1F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjIOMte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjIOMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:49:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C91713;
        Fri, 15 Sep 2023 05:49:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4189CC433C8;
        Fri, 15 Sep 2023 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694782167;
        bh=2ydyxneTfCpinGvO54rbyZn3Mfp9YAi9sO/z27uytQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ao09E5CZ91+rCAhWj0g5k1broaZOxuFINgfeG1D1ILanpL+6B1wyEchq2OkEOhUW2
         vqJJUw63RFXOtrmVePJiSd2x0jBCwv3COE9QfCWRbw//0s40s3V+zpihQtidrfJl1T
         ktyi6Qt1exGmiRygoA3n4ZVO5/sLE655kCvxQ9Ib7tPzRRwkuU35ERqsH5MzUExfGh
         fh2NZOm6gwzKqKSYnuOJaUomEz2klZwOclYIOAFgIozfPwYlBmSA5Clab8mOPmocg/
         nq/Jxbw6olncLqs26CwRTyQs2rQvE9IrEfzea5kjuKTW2z2DkmHch9jzchwZzWcwny
         nkDKNUs/b/VRA==
Date:   Fri, 15 Sep 2023 13:49:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <b22f9e16-1c65-4a9d-b3ea-9f6571647923@sirena.org.uk>
References: <20230915123103.2493640-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpyuU1a/ZYWxmAlQ"
Content-Disposition: inline
In-Reply-To: <20230915123103.2493640-1-d-gole@ti.com>
X-Cookie: Gravity brings me down.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zpyuU1a/ZYWxmAlQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 06:01:04PM +0530, Dhruva Gole wrote:
> Fix the smatch warnings that were recently introduced in the runtime pm
> patch [0]:
> drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
> unwind goto?
>=20
> [0] https://lore.kernel.org/all/20230829062706.786637-1-d-gole@ti.com/

Please use normal fixes tags for things like this and in general
please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on trains or flights, or while
otherwise travelling so this is even more pressing for me than just
being about making things a bit easier to read.

--zpyuU1a/ZYWxmAlQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUEUtIACgkQJNaLcl1U
h9DLzQf/Zq2f2eNVQGdWNGg7k0+E+QFvt1OrEZnKyNd8Ftq3lYhwMsngjU4zh3kW
7zn0ydMaTZ78PSyTU82iJq0nQb5xzVbk8ayjataknnn9fmGo80gX86UOtZNdFZMv
kvrrtf4q9ITwvyLQJiiao/XivvvqQrGOW5Q9juxKq9HyR+twPrsLkXo8015LTnYq
XYJKI0A/H8zhaEMHALhJfbHo3of39aIj63bSN7UN474Gz0wgYYG2Oc6av21V++Nn
gIaUWPfPffIaKxR+ryWeNP4BrYLWFsdm+L3fLgYbwwGrVefB0YbNReh3a85E8uiY
a6uax+ajCB3ZXEW6auBwIgFc++Miww==
=OkDo
-----END PGP SIGNATURE-----

--zpyuU1a/ZYWxmAlQ--
