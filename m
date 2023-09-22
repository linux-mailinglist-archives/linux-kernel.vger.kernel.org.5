Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1C67AB408
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjIVOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjIVOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:48:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C0180
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:48:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67FAC433C9;
        Fri, 22 Sep 2023 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695394088;
        bh=MOhFtSxywGBpaqP+/PDz7RXVCPUbnemaokEwfMmBonY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlAYPKrG13tOQTGsGM+XdpmN2DJRaTkS/TM8UYhSO4pkDN8UsBgPgD8cCIHLTJbPQ
         IG1CuSDapXaqT+WeQDUbGm230ecSUaDJfiHkX6Joo4+5AhgU7hlrfZIpGhhnr4d6j9
         6tteYJ+qhV4xUWQdsUyyhE64VnhArtYLOJu9qv65SaExEjMp1Hdx1gJ0mP4hWBzeU9
         oBDsHVw1VbZ2iTjjSo10M5seJyA8Ous4uD+vxAcdqt1zUW0BIX+EcChGyecpEpzUc1
         qYazKBatGp4EFmGRFVTfbkuFuay4U8PJh6LJskJPFGapvXFYPza0jsOpzeWatQNZP+
         QZJttlhGL6c8w==
Date:   Fri, 22 Sep 2023 15:48:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     'Takashi Iwai' <tiwai@suse.de>, 'Jaroslav Kysela' <perex@perex.cz>,
        'Takashi Iwai' <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v1 0/2] ALSA: cs35l41: prevent old firmwares using
 unsupported commands
Message-ID: <8adda3b7-90f0-4d0b-b990-669a591becad@sirena.org.uk>
References: <20230922142818.2021103-1-sbinding@opensource.cirrus.com>
 <87a5tecm2m.wl-tiwai@suse.de>
 <005e01d9ed63$4b605550$e220fff0$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YQfCH/+O2F9Rglbu"
Content-Disposition: inline
In-Reply-To: <005e01d9ed63$4b605550$e220fff0$@opensource.cirrus.com>
X-Cookie: A day without sunshine is like night.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YQfCH/+O2F9Rglbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 22, 2023 at 03:44:30PM +0100, Stefan Binding wrote:

> > So those are fixes needed for 6.6 kernel?  Or they are something
> new?

> These are to fix the issue that was reported on the Lenovo Legion 7
> 16ACHg6,
> which was introduced after the fixes to CS35L41 HDA System Suspend.

Could you be more specific about which fixes these are and which tree
they're in?  If they're fixes then I don't have anything queued for 6.6
so I'm confused about why you say there's a dependency on my tree.

--YQfCH/+O2F9Rglbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUNqSIACgkQJNaLcl1U
h9A/Ogf/biZHy048dz2KHe8iObwC+lZhV5DTWj/Pj8I3PIvn9kkIGQaUqzZLN1Kg
JUrnxb83CnArTEoeFJO/oa48ZGfY20p30AqNIzmPQ50kE4rEGIp3adBMXUEovr64
zBRnLiDsh6lbltPt+oTQOF5bO2V39AuKmHYiGEpE0yQbAATOva53Roscyz7PnLAm
USTUAV317CdEvMAI17EabnvwKSsLugyNfrF+3lI2yweSGItJlJlla88kqTeOyBfE
GAzSsMJWyuVwQaJ36+UMd23oDwQDEh6sYJXYtr1dSyITw27ujxkgSZdB9TbiB0Lm
A8c02pWrJA6VDC2W5l/4NoDYokQQRA==
=/X3M
-----END PGP SIGNATURE-----

--YQfCH/+O2F9Rglbu--
