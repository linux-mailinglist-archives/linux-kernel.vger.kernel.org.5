Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0537700D7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHDNLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjHDNLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C513D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F53261FEB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1E7C433C8;
        Fri,  4 Aug 2023 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691154674;
        bh=f2/rWiiZ+BWOnBDUaju5TgK3fx+//iSl49gAZ5rDVNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMZro10+B2k4gmweNm4CE5LN/6SBKu5OhUflU/VvQYH2x7i40okckpp48M95nYEci
         9oNjuKrY1qEmsJg+XEhXulFTpGkyyr/W4l/9p5nlO+L7ELtxGPkUdw6///YTtCt3kL
         do/TiZJ7K3E7e1Ml9D/rU753Wz8W20meD17h2sz6qItA5ZPbRHR94BKWkh/7jsQpVx
         sqaqu493oYy9ackeXbASMyg4acPgNA5nJxbEnDfVYvIj+8XzLM0cNGf7zDQ7xMOyit
         ZPRnBmieNpxj+TxSJsedXmMK3OGHZX9oqcyzYZ9c+/d5mP7iTxxpfqCwS1gr8x2aUf
         V5xzm9RRUjMcw==
Date:   Fri, 4 Aug 2023 14:11:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>
Subject: Re: [PATCH 04/27] ASoC: amd: acp3x-rt5682-max9836: Map missing jack
 kcontrols
Message-ID: <a0ba4144-7763-4d55-8517-f1c44fa4257e@sirena.org.uk>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
 <20230802175737.263412-5-alpernebiyasak@gmail.com>
 <277be798-9bd0-baa0-9e0d-8a7a9ac67f02@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aUxVXCjCALHmLMJ0"
Content-Disposition: inline
In-Reply-To: <277be798-9bd0-baa0-9e0d-8a7a9ac67f02@gmail.com>
X-Cookie: I'm hungry, time to eat lunch.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aUxVXCjCALHmLMJ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2023 at 05:04:52PM +0900, Akihiko Odaki wrote:

> Mark Brown has a raised question if the jack is really not driven as a line
> output[1], but I never answered him (sorry for that!) I don't know if the
> hardware is capable, but I think we better to remove it for now since the
> codec driver does not handle it.

> Mark, does it sound reasonable?

Sure.

--aUxVXCjCALHmLMJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM+OwACgkQJNaLcl1U
h9BG5Qf/Zh+JDihZs7ro532usaJFwZMp9Cb1GgiFE9rokNJ0kEQYEJtO/ho/6YR0
43E4WxyobGMN/Rn0mrkPQhLeRJ4ivilk5GvzZBSg27cbetAIzWyAAZMb+uEdK/yE
FVg/Yh7ZS4hIbym2E3MtN/KxVzSMNpAdrPv77AhVaXgMZyneSmF/aLn7S+Am3F5G
w6UFUB6znB1bcApjfP1uKoxAdxUD2MqZfE5TixaH/zpyciWyI1j9fzjQhb+Z615O
VHKkZTWwlt1AlEMn511/vOhTa6kGkFGI5SstyYFNugiRL0O7vSmHpK+rXjBAVQct
4xZdQxTvXrT2f0quFNGXKIuHjk2zGg==
=qIVR
-----END PGP SIGNATURE-----

--aUxVXCjCALHmLMJ0--
