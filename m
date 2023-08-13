Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA0C77AA50
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHMRZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjHMRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBFD10DD;
        Sun, 13 Aug 2023 10:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79D976111D;
        Sun, 13 Aug 2023 17:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF3FC433C7;
        Sun, 13 Aug 2023 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691947545;
        bh=8lbfPPJ4n+8aA2NeyWf4XOSw9lu+CR89Quao+yjZXQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRoPtJg213x03htNDDiHekOtRmlSdoA2tLPvw83vbGbU00QIw8xPQp9VqQ04QPXih
         NZvAzzctwjLoI2grRD3TclRM/NmQWjaGiq0klLd7vsH2vocnb4qUAQk2Cuiqw/CzuM
         9qOOUFiSBvlZZwnP7SROh02qTUuYX1WhF1JwzJP58Wvbud6FXky3sHMDq+g1kmvbJo
         mi5s2t53lnCfzp9I1KH/g29bu1mq6UyQZHCsTTs8V950imgXf4pWBQonqnGo4FAjMc
         4QSHt2PTn/XhnEH6sVXd3K/xoiXY5YgNKG++KOKhtEXn37TUWNHP5t5IwTm2A0qzo7
         Ytxu7qHrpUefw==
Date:   Sun, 13 Aug 2023 18:25:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
        spujar@nvidia.com, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: simple-card: Document new DAI
 flags playback-only/capture-only
Message-ID: <ZNkSFvZkQgtudM5Z@finisterre.sirena.org.uk>
References: <20230801082433.548206-1-daniel.baluta@oss.nxp.com>
 <20230801082433.548206-3-daniel.baluta@oss.nxp.com>
 <20230811191236.GA3937407-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2MQbhxQeL2I8OcPf"
Content-Disposition: inline
In-Reply-To: <20230811191236.GA3937407-robh@kernel.org>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2MQbhxQeL2I8OcPf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 01:12:36PM -0600, Rob Herring wrote:
> On Tue, Aug 01, 2023 at 11:24:33AM +0300, Daniel Baluta wrote:

> > +  playback-only:
> > +    description: dai-link is used only for playback
> > +    $ref: /schemas/types.yaml#/definitions/flag

> > +  capture-only:
> > +    description: dai-link is used only for capture
> > +    $ref: /schemas/types.yaml#/definitions/flag

> Wouldn't this be implicit based on limitations in the either the cpu or=
=20
> codec DAI?

You can see cases where people just don't connect some of the signals
for whatever reason so even if the two devices could do bidrectional
audio the board can't, and there are also cases like the at91sam9g20ek
where the DAI is connected for bidrectional audio but there's not
actually any audio inputs you can connect (even loopbacks) for one of
the directions so it's best to just mask things out from the user.

--2MQbhxQeL2I8OcPf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTZEhUACgkQJNaLcl1U
h9AFoAf9GbJjlpdCljVFwIbGL4YEzDszN7Bqo2ShmBFc2t6+CJ3cFIZIe3xx0e/n
Brz83l9paS8ptdkksscqnvp8FsIK91gGI4o2UamvpF46DI3+t6yJ9AiNmtnC9JQx
WMVBqNK4gUmlLnvcwM6Esy3BBpHU4XkuOgacAyaOYc2r2Knztc1LQwgk3Kmm4KGx
FeESWRjTKDsFT1YjCOHgYEG4LRg5zoClyuL8O4DlzJ3suQwpjPogqoWVRexP/55A
QAD8JtPo190LjiOWsp1qxVkNba/KRPADOS4KqBeQM+YFmcOW92E30t+0wdLthv5W
Y5oiKJ0YF/0pprKQ+nTij4kxyPxokQ==
=yaLR
-----END PGP SIGNATURE-----

--2MQbhxQeL2I8OcPf--
