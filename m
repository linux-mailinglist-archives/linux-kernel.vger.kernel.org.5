Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F098479AE29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbjIKU5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjIKMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:11:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FE0193
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:11:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C7EC433C8;
        Mon, 11 Sep 2023 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694434275;
        bh=R+ql+mzGwM93y+MReTjjqW4uZhvIVp9cZ/7Q+YuOjf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvJLyYjzCnVwb66Q7aIf4Frmxb3Tc+AM3h9ijkk20KXu5nQE1FTLzJz8L9YJH9TJB
         2uG0YXoj99CekIZmlt9VMQkhdudYozBzK4PGaNApqUosJYayC3yUvld2VvrBnm5vab
         +50mjNHA1JmoE8e98xqkK05wsunF3DfYPbBz3Do9gwVcD4AHu/fPpB1Kmo2SDWfsYq
         FutrJHByJrrVHRYR8W3RKGFtqq/AGaLOP2AXCFATo/RctMAPz/mkpes25H+BPPv5gE
         bkPNyyDPs5+dOUyvVI41fy5QFDwCBl6f+kgOBYsDeiiE415e04v57opKcCtYzxqgrG
         ZLAhtwEJAWq/w==
Date:   Mon, 11 Sep 2023 13:11:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: Adds support for TAS575x to the pcm512x driver
Message-ID: <ZP8D3QMXX0TyVYs9@finisterre.sirena.org.uk>
References: <20230907161207.14426-1-joerg.hifiberry@gmail.com>
 <a9c3d43a-af26-44a0-9352-4666107f9f56@sirena.org.uk>
 <ZPn4nsypsSXdB3J7@ubuntu>
 <bb3e5ccf-6eb5-4a36-9af0-b33f2db68445@sirena.org.uk>
 <ZP8BMkDeZakUyACL@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XTxCuQJGmxqT6raY"
Content-Disposition: inline
In-Reply-To: <ZP8BMkDeZakUyACL@ubuntu>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XTxCuQJGmxqT6raY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 01:59:46PM +0200, Joerg Schambacher wrote:
> Am 07.09.2023 um 17:28 hat Mark Brown geschrieben:
> > On Thu, Sep 07, 2023 at 06:21:50PM +0200, Joerg Schambacher wrote:

> > > But in the case of the TAS-devices we even then need the PLL to
> > > drive the AMP clocks.

> > That's definitely a separate quirk, and does sound like it should be
> > driven from the bias management or DAPM more than hw_params.

> Then it makes sense to use a DT-param 'force_pll_on' and even
> remove the compatible string fixes from the patch series.

If this device always needs the PLL then we should just figure it out
=66rom the compatible rather than requiring a DT property which every
system with the device is going to need to set.

> Still, I think, this is the best part of the code to act on the PLL.
> Simply instead of checking 'do we need it or not' just let it run.
> What do you think?

It's probably fine.

--XTxCuQJGmxqT6raY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT/A90ACgkQJNaLcl1U
h9C9Vwf8CN87CIUnOdszx1yA2ch0s+QLbm/OlXB++k5xtAT7ZT2GAoWr93CkBwa7
KSV2AjgMVMsT7MYDaLoVLa9AVaWpT+Q2IQnaWNn4yoqfLOONAyc+WgKVgIaAPmYC
oSVrF2/hlk7Wlg2+xZwoXEYTCk+YdozTddQyAcUSVKVWclZSt3YE+ot3YWhmxlUh
i5LG2/KGKL3Yj8Q1GL2EOrZRvM3vqrmoiC5agHCaPfXsvObJImd7CnMgBQ5Zx/TF
F7lvgm44lRpwJVP006vdwelLCLO7L1hKEC4NOIBhsxELmQ9EgV+eUks5ADvZ1pcH
C+4ikfO+mg0em7+2oX/aIRVVHB3JVw==
=OddO
-----END PGP SIGNATURE-----

--XTxCuQJGmxqT6raY--
