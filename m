Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB5E7F4524
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjKVLw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjKVLw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:52:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CBF19E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:52:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB449C433C8;
        Wed, 22 Nov 2023 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700653973;
        bh=6HUfCsIZN73Rfw9oZVATg1h0lM2yZjP8z3Oyozgx/P8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmli1BSFtWbxoDvzjlM4fWq1nk+WcjRWNLmiG6UGJFyjEQXAkOt4zsDfPUF1AJtbU
         qPSB+aPTAvHc4X27KHfzCx3/1k4J7VZiLZPJXh9O5nGxhAtvF2W2c25Eorr1rnguuE
         stWlEj8kgsygCPcoHTjKpI+OpZPJZ/2TjmZKUu/DeI2v0avddvgLS0nPw7hl/1X9HK
         9u6j3BK0WdKCaECaYDCRT9hrG8tNdQ3s86C1ONUdbimNjqMbajMawtdQQqpgQXUq+S
         ZJNcTytEhPuxLTzIj665mLon2G2riQs17UGYT+zXOBoQyEHZybpqvlcrhXCsEQGv2J
         tFGOB7dq12N3g==
Date:   Wed, 22 Nov 2023 11:52:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] soc: sifive: shunt ccache driver to drivers/cache
Message-ID: <20231122-reanalyze-modified-9e59bbc89864@spud>
References: <20231012-mooing-refined-ad1ab421c0d3@spud>
 <d94d54d2-50a3-4dc8-9178-e69c118aeefe@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rNDhmjMV63rJ3BwW"
Content-Disposition: inline
In-Reply-To: <d94d54d2-50a3-4dc8-9178-e69c118aeefe@sifive.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rNDhmjMV63rJ3BwW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 07:25:20PM -0600, Samuel Holland wrote:

> > +if ARCH_SIFIVE || ARCH_STARFIVE
>=20
> Since this is now in a file grouped/sorted by subsystem instead of by pla=
tform,
> maybe it makes sense to convert this to a "depends on" line?

I did that on application, thanks.

> > -source "drivers/soc/sifive/Kconfig"
> >  source "drivers/soc/starfive/Kconfig"
>=20
> This file has a conflict and needs to be rebased, but otherwise:

am -3 took care of it :)

> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>

Cheers,
Conor.

--rNDhmjMV63rJ3BwW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV3rkAAKCRB4tDGHoIJi
0gJRAQCwfZQa91tNalHtWg8iTRs3q9HQ052E5Uh3dKT//WBpWwD/QP7AySJZUHGo
PAy7SRowDv8Qyg7KxGUqZSh3hgp/rw4=
=4nYW
-----END PGP SIGNATURE-----

--rNDhmjMV63rJ3BwW--
