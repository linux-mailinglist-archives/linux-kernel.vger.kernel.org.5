Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EAB76FFD0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjHDL6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjHDL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C453F126;
        Fri,  4 Aug 2023 04:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A4C861F98;
        Fri,  4 Aug 2023 11:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C5DC433C8;
        Fri,  4 Aug 2023 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691150270;
        bh=Hy5tBLVvyiNSH0rp2i+vLXsQeQlV4Nlwg6l4ueJwAn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7cjC8BT7JZEUauN1+f9MosXfMgeBYGrsx/jD4vSZi9JhVXz1w9JrIUoJjxI3LC/V
         2+kPizIHwNhQ3Thukq8BDqICnVrEQuErZw+vWV01sX2W3zgzpQtfuGCk9IcJcfw8aV
         7nZ9XrhJE/l5+VigGsZQj7xulFJoNPedQomoGULn55iVKyTw26szInv4gjpz9qu/8f
         /NrPUpQ6U9J+2r+TWjO/RsRK/40hjWqSPPUq8sCpLvQeBtyoJ9/gZ+L3txky+3UZeO
         i6H+ecXRhdpySHxTTpzAe07RUJ2mn0So0dZIhSORdRwDsJNJ7Uzmgr5U4FFY/1QWus
         XXBi5fdko9tyg==
Date:   Fri, 4 Aug 2023 12:57:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     coolrrsh@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] fixes warning
Message-ID: <d8dee07b-dffe-4c01-87fe-aa9e6793a9ad@sirena.org.uk>
References: <20230804115121.34035-1-coolrrsh@gmail.com>
 <20230804115121.34035-2-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="izFkksqRR1HeZCfX"
Content-Disposition: inline
In-Reply-To: <20230804115121.34035-2-coolrrsh@gmail.com>
X-Cookie: I'm hungry, time to eat lunch.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--izFkksqRR1HeZCfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 05:21:21PM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>=20
> drivers/spi/spi-mpc52xx-psc.c:332:5-13:
> WARNING: Unsigned expression compared with zero: mps -> irq < 0

Same issues here.

--izFkksqRR1HeZCfX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM57kACgkQJNaLcl1U
h9BQ8Qf/bMGfH248D/CvTPjmRz989S56xktgSHZdNyZgCA4d1qeywVUzMaCC1Vua
KVWTVpX4M9n1XBLtBDg7J5RxuqtBrGOOoVJVJCbKdBnNRlbvvxQPOeMUJmd8mizO
zkQo5womAePvY5ePRIkAbWbtlO8QVlBiO1NicNRaSWZjLap73Jge6QmbtGLatEsX
ERe3YR45fSVSpM25M4SokjkIANW9CFSZcCp96xKnYOgrdnn4M398Oa1AjDAMA+5x
372zCmFC4uCMHS22dvjTPV+P4mHVepZDRpSxbioIN0QPo+6P2rRWiSFgj/L+6T0Y
qXPHnX3ZSCSJW6vrPmGx84LEUPhQYg==
=wUH/
-----END PGP SIGNATURE-----

--izFkksqRR1HeZCfX--
