Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D387B012B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjI0J7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjI0J7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:59:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C5F3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:59:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A611C433C8;
        Wed, 27 Sep 2023 09:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695808773;
        bh=RUppI/q0xfwba/lP191K+gantdfVkA9gA7y81Dm/SuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2K2mtAIP7TYZS/yWD0wou+N4oeF1NVEgJUM0Q0Yv8xBypafLM/C7MJBo272AxFcn
         oVkeNn+UatZIGSygr8FuaQF0hCdLH+q4iYxwyLPY8We/sFR+QaqO/K/330BRQ8YcFe
         5usW4rivyCmCOtxuHpbjG4nYi8hWK++8JyR+Pb71ag9vZUXs/+GF9gVBjd48hCpRMd
         WsiWREWelBvOefp29sZ4Xz17m41vyvsArgVVwiu86gzGoP7S4DMZhtModATcyg3n8u
         uTlMJ2cOcn9XsebmVqV21ZIHaAIEP6LnK1I0QIdQ+NmW07ykO4uJOkXsbmHThU2k4w
         AAYQbvX++2dGQ==
Date:   Wed, 27 Sep 2023 11:59:31 +0200
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: rtq9128: Add TDM data source selection
Message-ID: <ZRP9Aw904ynL5Se/@finisterre.sirena.org.uk>
References: <1695780376-32301-1-git-send-email-cy_huang@richtek.com>
 <ZRPyMolOIjLBWXPC@finisterre.sirena.org.uk>
 <20230927094637.GA25905@linuxcarl2.richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1C4mWfMNaZDyDOFk"
Content-Disposition: inline
In-Reply-To: <20230927094637.GA25905@linuxcarl2.richtek.com>
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


--1C4mWfMNaZDyDOFk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2023 at 05:46:37PM +0800, ChiYuan Huang wrote:
> On Wed, Sep 27, 2023 at 11:13:22AM +0200, Mark Brown wrote:

> > Is this something that's going to be changing dynamically at runtime or
> > should this be a device property that's set either by firmware or when
> > we're doing the TDM setup?  This sounds like something I'd expect to be
> > fixed by the board design.

> I may think one case if ASoC platform support multiple data source outputs
> that share the same bck/lcrk on different data pin. If it can be dynamically
> adjusted for the scenarios, this will keep the flexibility for the differet
> platform design.

Sure, but is that actually a practical design - or if someone is doing
this shouldn't it be joined up with the TDM configuration since with
just the control it'd only be possible to switch the pins but not change
the TDM layout?  I'm not sure that this control works as a standalone
thing.

--1C4mWfMNaZDyDOFk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT/P8ACgkQJNaLcl1U
h9A3nAf9H92yVuO7k/UTjTIXfx3suPYVPOICJ5sKklHL8Vd2+uL3ks7E9EbmnCzR
Me3Esxfs9EdVnBVgIpoOBUOmtrZTzrlm9Y7DG6q0y4gV/6ShctHIqKgXhGlPftUY
7iUgF1GPTeHjpqg+PmlWh/C7zqtjrcauyxzrGclpBbilg/1CKRwaSyJNwblLXLDZ
c4kBua84DXvkBEUYRyr+S1HNzwo1bd2R3FF9Q39kgunTl+PAcEVs8AqzsnZx7Tgg
EABemg1WEyrRVjvVyfyZP7BmdjGcFzCllD96yJsIQf0W25a9ne3PxVftFbsiATVH
hic094EtySRJ8jr+PI+QWbqRCwYPYw==
=uBaT
-----END PGP SIGNATURE-----

--1C4mWfMNaZDyDOFk--
