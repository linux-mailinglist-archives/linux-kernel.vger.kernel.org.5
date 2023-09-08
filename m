Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B516A79862A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbjIHKul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbjIHKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:50:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090651BF4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:50:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA26C433C9;
        Fri,  8 Sep 2023 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694170229;
        bh=ZSWpv6f67wgG58fbLgFGlk1364L8vHRxR8dNE9OwY+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7/f0fv2Fg24nYEenjrx/redQRUwV9ICopaR0NdmE4EV8hmRlprH4AkmoI2Jg24Tv
         1lNz8Gthr4HyC4RRV1KeFcSv8t+iugglLM85m7ycYCKOmiIKRMEXQt5U/Q1HOtIw1m
         cSwhYQMKTz1Dcq9POPLjBQJbcKckQxNNyDQItcqCm/lzjOSop5T3vow437FOW4fANf
         4vEFscuGhAnxyuQaaRACxNohyqjpxjF8lBbjYX7yUhDyXASO5cFhrZrKRCPbf/k95t
         FcJegCVBsgTtazhA75xX6x62nLaTI1kV9DAycmsTySt9zONA4rIpreeQfVzQ4HnfT3
         FP8e5Kp3s487Q==
Date:   Fri, 8 Sep 2023 11:50:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Myunguk Kim <mwkim@gaonchips.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Uw e =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: dwc: Add Single DMA mode support
Message-ID: <13ca65a8-c3cd-4bb3-b058-4d6303474748@sirena.org.uk>
References: <20230908035449.2211723-1-mwkim@gaonchips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qSFCahxkwBz/kXdc"
Content-Disposition: inline
In-Reply-To: <20230908035449.2211723-1-mwkim@gaonchips.com>
X-Cookie: My EARS are GONE!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qSFCahxkwBz/kXdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 08, 2023 at 12:54:49PM +0900, Myunguk Kim wrote:

> +	#define DW_I2S_QUIRK_NOT_SUPPORT_BURST	(1 << 3)

_NO_BURST might be a slightly less awkward name.

> +		if (of_get_property(pdev->dev.of_node, "not-support-burst", NULL))
> +			dev->quirks |= DW_I2S_QUIRK_NOT_SUPPORT_BURST;

The new property needs to be documented.

--qSFCahxkwBz/kXdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT6/G8ACgkQJNaLcl1U
h9CvTQf+KXCFcsxokWQOrmQY7s0TYYSztjz4+rbKZx4KzA5Dcsriw8E9a3inQ/hp
rzlQj4RN4u33D3ny5IaxKW7kZnc2vJxBpkf2J/SA7ulnAu2MRsX7KaO0quuTFhGD
+XQAQPAAYycBQXEaudOscT04BwtWabUVWE0MBYK9S4DiKV2l4+3z67VDaNf4OFa6
cGZErZAZhRCleWaZQPYaemKHYAi362V7cKblgz1Jd74lXdvn247ESddrOyD2l+GJ
KHd8NLYJ2Uuaf08wPdInfq4lehGZk1UIjrxOZgxGrgip8Bkz3Dgl5sImC34fbRXR
NuEEWixfKv/qEBWliEhfyvRBoZnOuw==
=Avmr
-----END PGP SIGNATURE-----

--qSFCahxkwBz/kXdc--
