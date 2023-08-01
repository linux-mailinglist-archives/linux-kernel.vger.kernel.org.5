Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E0B76BD56
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjHATJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjHATJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901B71BF5;
        Tue,  1 Aug 2023 12:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DBA8616A5;
        Tue,  1 Aug 2023 19:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAE9C433C8;
        Tue,  1 Aug 2023 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690916955;
        bh=dAh5inHpSc5Eih6HTIPWodjYBRbBt5z/XQeIIkmS9O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/jBSaBK+Oku8L8RDZd8qPXZk+YOAU6ATEk0xGAk73Vd/WmcByrwA02EPClYBujKW
         qmnjHFRLSpK4Qr8eyBfmawP+WRvSJViZvPj0fgTPNb3yUa3Kcya/tuRGJi/ICpbQ1x
         mfIQwfmXTkGognKfh+k7KhZP1KBWbuMP9yqW2RCTQkjAf1TVKtmLbMpmA8k6IAzE3R
         MWfhpSwRjT/SACGW3Fllr2AsVdohtPIJgYih9h3f9Pz/2tdr48Z2HUfzeLiJw3po66
         4L7GFZmwn1yel8Jvsw4uR+g/JD3VcvPZqIXcEOKz3wdUITcT5/q1SKzZ1RsKgnVFqo
         c5R+uA/uAVfrA==
Date:   Tue, 1 Aug 2023 20:09:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, robh+dt@kernel.org,
        kuninori.morimoto.gx@renesas.com, spujar@nvidia.com,
        tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        daniel.baluta@gmail.com
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: simple-card: Document new DAI
 flags playback-only/capture-only
Message-ID: <8c3f90ef-5f12-42aa-bae9-dec997e2b82a@sirena.org.uk>
References: <20230801082433.548206-1-daniel.baluta@oss.nxp.com>
 <20230801082433.548206-3-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lzabSlSNKrz1vv9q"
Content-Disposition: inline
In-Reply-To: <20230801082433.548206-3-daniel.baluta@oss.nxp.com>
X-Cookie: I thought YOU silenced the guard!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lzabSlSNKrz1vv9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 11:24:33AM +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> Document new playback-only and capture-only flags which can be used when
> dai link can only support just one direction: playback or capture but
> not both.
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Please add new features to audio-graph-card2 - we're trying to deprecate
simple-card, audio-graph-card2 is a superset with more flexibility.
It's not the end of the world to also support things in simple-card but
it definitely shouldn't have any capabilities that the newer card lacks.

--lzabSlSNKrz1vv9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTJWFQACgkQJNaLcl1U
h9ApjQf/cWvoHZfKG9fC0sAkmpQfTqqul0KPx4mcBD/lJdJGzc0BY91BinbZ2/eD
MaHRMlOnz9feDkcIty7oeB9UEp55hl2MaTgQAdUQop2tRz4g8x9u7A1EgV6H6L1P
NHsMKzgqtRiIxZGPtwMJYVxOP+nyCov74BjSSY0+JuJQN0vG+7UwDi/4FuAOwZmv
ZfLzLPN2ZXKVQ8drGPo4VBlkU/9UcefpIs0/f6KeRea1iP60tx1BYOcayd2KZoxA
iV5Az3WwlAozJQoTiuzdW+WoUk4xz6dSu4efzq80uI8zth4zBrnSJFtCITtw2DU2
Eb6Jj8cc8JaZ3aOv/0164/xXWHfk+w==
=KxEv
-----END PGP SIGNATURE-----

--lzabSlSNKrz1vv9q--
