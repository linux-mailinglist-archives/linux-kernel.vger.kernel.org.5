Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F256E7DB1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 01:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjJ3ApF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 20:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjJ3ApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 20:45:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A726BC;
        Sun, 29 Oct 2023 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698626697;
        bh=VeiWM7mPmr6XiBbotJXD+Rpit3AEjKLnxEsF9zMYmyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G7fLwjXOFwPWHvno28pk/ri9io9tWTuti3M2FyqztWbEeO767UW+qu2F2g6KcNHR9
         lUPCGBnwQ8TnRFI3xMyCvdul/9qADwPKZBQ0+KIeCMBRzIF7CtmlhE2PwpGISWmOkw
         4gnmSsXeAa2Y/Utdxo11BNTyz0XBq6SoZNGhGpAfjM1olH48EbRHzs7UTptdaclVWo
         3JDsHlltxhDj+7xIXlklz36sTZKaqVFUFqdYomxfM9ODSEamFIhxds4LG3uC0fS5I+
         hn6TPF4tB5c4mjqrvFGTrbPUIoeA2HQywH1VDUgzDSH5Rrr6XkCtcZ5AIbIbMjffxj
         aqCtk8tccfKrA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJZL13TM8z4wc8;
        Mon, 30 Oct 2023 11:44:57 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 11:44:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chancel Liu <chancel.liu@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: linux-next: manual merge of the sound tree with the
 sound-asoc-fixes tree
Message-ID: <20231030114456.650b1371@canb.auug.org.au>
In-Reply-To: <20231030114115.2a9f0260@canb.auug.org.au>
References: <20231030114115.2a9f0260@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O9wvm+fA9xAlnfBAaoDmsSo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O9wvm+fA9xAlnfBAaoDmsSo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 30 Oct 2023 11:41:15 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the sound tree got a conflict in:
>=20
>   sound/soc/soc-pcm.c
>=20
> between commit:
>=20
>   f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during=
 trigger")
>=20
> from the sound-asoc-fixes tree and commit:
>=20
>   3efcb471f871 ("ASoC: soc-pcm.c: Make sure DAI parameters cleared if the=
 DAI becomes inactive")
>=20
> from the sound tree.
>=20
> I fixed it up (I just used the latter) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

And then when I merged the sound-asoc tree, I used the version from that.

--=20
Cheers,
Stephen Rothwell

--Sig_/O9wvm+fA9xAlnfBAaoDmsSo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU+/IgACgkQAVBC80lX
0Gy3pAf9FNcHWr+r3gg0LVhzvKuWy/6tFt5amM/WJNBw2P9l0hVdas2UudgzaRUz
3cZTZ1wS1IanvIrz6YKFByW7llPYCnNN84Ge5PwUo+WLzRIUv57ZH8IMquj/gDPf
aKZPXphkl3IiczosHxaKabV3Kj6GkUEzktZY/BaSy5r+wbDbZD/XHlzhMeUSs5rm
3sRxHkuK+2r+Bc4Gsk7wkF59hiP6XSaeSKpwnekoRVUWLBo2oQT2keHb0zkaKNRF
4ki8AkedVzzd492ssYP1Uftu7Gag3/lxufXyee0+/PmL6RaoLN/r+HfxC7zGXtrF
nRFTPpW3ecFMPOwM2c4ykCtavW6CdA==
=/J4p
-----END PGP SIGNATURE-----

--Sig_/O9wvm+fA9xAlnfBAaoDmsSo--
