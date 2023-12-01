Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B16801430
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjLAUSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjLAUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:18:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F1810FD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:18:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC784C433C7;
        Fri,  1 Dec 2023 20:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701461921;
        bh=NxTGq4XICzSbkv4PfwRRf+8lYts9VpVqDOrxlyo+0v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uj+TV+vQeoEuy/0GVxKhq6wsGPRdGTY9simuiPntm4YKXH81e5yFMrZEcP8E+5m9g
         DRl6lTfNm0S7BM/B58uAMxkJxP02h2Mox6GSlfVM+trYvVHIYJl/x14eXz6FyVUTBq
         d1a1M/ijkgLC0/vPRFwmutsrCM1Y3awaBVrhG7/FfNuH7sGl8Bh01FLRmZExwd3fSH
         Vaa+eCW4YTHd+QPkRRbOuyDG3r4ZjCHjmy2o3S0hcuAf2OcuwiqDHRzLfSAwSbHMjC
         RDjhl45FOPHKz9dWlwguh5vnDO6pdrwLKd6G/GKE/Nsa0TeLK3OfTFOTXluaCW4D4L
         lu4e6iSZYQyaQ==
Date:   Fri, 1 Dec 2023 20:18:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     nikita.shubin@maquefel.me
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 15/39] spi: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <e9aeb91e-3c70-48c0-a981-8a3111e9bf63@sirena.org.uk>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-15-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GULY8lxYL233GdGV"
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-15-d59a76d5df29@maquefel.me>
X-Cookie: The early worm gets the late bird.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GULY8lxYL233GdGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:59:53AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> - add OF ID match table
> - add device tree DMA request, so we can probe defer, in case DMA is not
>   ready yet
> - drop DMA platform code

Reviewed-by: Mark Brown <broonie@kernel.org>

If you hadn't added the removal of the platform code then I could queue
this even if the rest of the series still ends up getting stuck again
(which seems likely given the size...).  :(

--GULY8lxYL233GdGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqP5wACgkQJNaLcl1U
h9C7tgf9Gu6/hpm7OBciLHLVxKzom5b3rDAdVqnIuxFD6kiMi5e3fki1hEr+IAxG
fjHpG4iZrehHUCL8MBx2gierEUieRT0DIQUCMReNPxieQW20rWhzG6NFqZhimPCp
/oGzHWuhKAB855DBzzsina8TXJTmDUKtkNvVSgzdiv0pAbKxgXHXLBH+QXT7T9rV
MhK3jbzogBk8f1W4uaxqaZBJBOK5cy7dl/1eiLCCfrSHMB+uB3wIYbLqJMuYmgf7
CJfPCTmA6ALpvZ6MNRqLcKR7luhuTzLexbK2Dai2L8510SxARszF//9UsEvoqi0R
0EDZIrP3Uz1nQHajRDHMueUl+cgBtw==
=Phzx
-----END PGP SIGNATURE-----

--GULY8lxYL233GdGV--
