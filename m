Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12D57F135F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjKTMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjKTMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:32:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C54CFD;
        Mon, 20 Nov 2023 04:32:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2356EC433C7;
        Mon, 20 Nov 2023 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700483521;
        bh=VpMPOPnBOLwfyHymSSUGd+phFrwbtBpjEwHwsuBlbMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWDhq05VMoKau5vnLggUuY/d5j9oy9QIWFlMqRLO1Ag3AFMP3y5Is71d0hvAxBF84
         XRUR5gewxyQNWKd2Kv51/jmCh2dxJMgJEZ7RIGGM5tTJ4bDiduTmT/FttJk6ocf2tF
         ynZPwUCZv6vJYvK9ttzi6DHE4OH7uJUPqrGpxWRpni82g+91CMPL54c/YC4CqX0Y4f
         /hrF0FFYxHeupA1TQ4DniLGIskO9eRS9wGm4npBqLbcT9ktwVwzAfqV6zsepBdLjuL
         xomg1+0KiacXGP1uZ4I8kCW0g9vjeK4xFFp87CQWIZj4ePZWmDPcJ0zWjlQHLVukzC
         Z+g0CUVLpdnog==
Date:   Mon, 20 Nov 2023 12:31:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ASoC: cs43130: Allow driver to work without IRQ
 thread
Message-ID: <7d8bf03f-e9a5-405b-8753-a360f46a04df@sirena.org.uk>
References: <20231120104153.76248-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EzncKgt07jbCVykN"
Content-Disposition: inline
In-Reply-To: <20231120104153.76248-1-mstrozek@opensource.cirrus.com>
X-Cookie: <Manoj> I *like* the chicken
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EzncKgt07jbCVykN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2023 at 10:41:53AM +0000, Maciej Strozek wrote:
> This is to support systems without physical IRQ connection. The device
> only requires the IRQ for a couple of internal delays, this polling
> mechanism is a fallback when no IRQ is specified.

Your changelog here doesn't describe the change - is then intention here
to remove the IRQ thread (and presumably open code?) or to make
interrupts entirely optional?

I'm assuming there aren't six more patches in this series?  The whole
point in numbering patches is to order things, if you're only sending
one patch you don't need numbering at all.

--EzncKgt07jbCVykN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbUbsACgkQJNaLcl1U
h9C57gf+OEQRsK3uPH+3kIvhWgpooIAYMV7UzScIDl8wRnQhxGviU2Oct85qI5cG
P1zEHfPMM/oqJbwUOF3W1jkhGYNkMxyF5gNoWuF4aZwiyW2jYPXwp/DPNt91Ahbr
+fvedg7bLZHzBTJ2jCWdTlNVMuUetCFafrbTbIYJnAGMKO3j+Sp0HEyT2/kfHx9J
Nfq4TDOTUbN/sOoL/UzpIMCqgGhDl6P1hjtm2EV64zJ1XFxrzzfVetRpaO4+Avgn
NfDBNsJjEZk6c3usl0u/fLbS3SxYkgqRtZXqKqlwHQcyqVLApgFmgv6aN59QaKdO
kCAiub3Df+k7nUtAs/AKR4iZLf924w==
=Nli+
-----END PGP SIGNATURE-----

--EzncKgt07jbCVykN--
