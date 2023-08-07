Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403C87725E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjHGNgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjHGNgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775231701
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C139061B5C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D838C433CA;
        Mon,  7 Aug 2023 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691415371;
        bh=84SKzUj1lW6SYLLyC9xE6s6qjg/dmYZSliovkhMuFJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJyrTKMaAvL+ZK7Y6+Ut5lEIz/0jDsKVL7fKOOK2Y8cRN1d36tPONGs4N9wWSSG7r
         A6xweMHhkTxOaRlMpx5fMRg2mt67Ves6kVDSt7hGzQLXR4r/aYFVLojNGt/KhIk6J9
         OuosGxSH/Q6vV+vTzWIOZJY3kQbQerBF2kPSNaOfJfPgkq8sZZevP0e1GSZWenBNB8
         hi2ZPca/tqGUP010q/BeSHxxy4vScs6aP3YbAHN4fhCMbP7aZCqeC90UhKSNuRlzt/
         cdQYaeJjz9XUYDt92n8PXNLT0FoNZ+KGFi8yttUJBqZ746zemPXxINDyx5fOFom2la
         i8I2hnQIC7QjA==
Date:   Mon, 7 Aug 2023 14:36:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] regulator: Make clkin_name and xin_name static
Message-ID: <8c0e8e88-66cf-440c-942e-a897c7f8ef87@sirena.org.uk>
References: <20230807015027.21085-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="10BPR3cbPH25LytB"
Content-Disposition: inline
In-Reply-To: <20230807015027.21085-1-guozihua@huawei.com>
X-Cookie: Truckers welcome.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--10BPR3cbPH25LytB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 09:50:27AM +0800, GUO Zihua wrote:
> clkin_name and xin_name is not referred elsewhere, so make them static.
>=20
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>=20
> v2:
>   Re-formatted patch and tested on the most current master.

This still doesn't apply against my current tree, please check and
resend.  It should apply against the for-6.6 branch.

--10BPR3cbPH25LytB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTQ80UACgkQJNaLcl1U
h9D7gAf/b+oP0LpiA+Ac3K3JPYLG0VX6Jdj+VIXPaxwdtm0IYEnV4Y4pNeHTdrki
h4mL57sY+54k+IjHkPVJDGp9AXFeWkPyhrEgnCSrOXNMaVLW0gRxnCWxjsS4+zbq
uBYmDVwEo4I7fDHtXNcFwmpIVFV/JStvFPK9KnVd90GTpBSs/3ViV1Sbm7BtXN+a
6HzscZmWG65HqC0FW1V7bsjfX/SKhnN50tfe1VvSOWUiW2WOCkPdiF0QqdMrUCgS
jtS95tqgQuX0JhLil4HHKeqdrp5MAPql6J2lMDOH7jPUQuP6ojWpU3/ttBesNs+s
oUa2oxEHZHBqvbGz2zkPJu+nqdCt2Q==
=NDYr
-----END PGP SIGNATURE-----

--10BPR3cbPH25LytB--
