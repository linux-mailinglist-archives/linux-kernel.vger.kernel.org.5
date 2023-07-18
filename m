Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC267585DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGRTzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRTzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4102E198E;
        Tue, 18 Jul 2023 12:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D196D60B45;
        Tue, 18 Jul 2023 19:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D68C433C7;
        Tue, 18 Jul 2023 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689710142;
        bh=gshhwkunm0Nkznr6q9yEkdRdIiyNHnhVMZurRxoSIOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgSBOvWQdpxF3liRy3mjW5e2MFL87uVxkeVJ1V2wPudywexzVM18dF3ko8cfRL/EH
         +VwKa8cr4Kojk/tBS5K9Qgl/+UXz39EWbpO3NmAtzd6k3bK6WcfCseH6RjE4b9UEcm
         mXH6ANOp6IJ5J4HdWrjaWQ2bH7ueTtEr2KM+8PHf40GJni1e8zVZaR9s5f7b4rCTZv
         jWVCDticxRP5dKAu4n0O0N+dSF/tm9SBR1ORKXtt5NZBYCmt29WxD09jfTvNVNotFL
         HRTWsdMlFS+2DBMXp81oqy6bufzJUfwty4TFn9hCwiv1zt0UbDxJBxcaLPon+du3S8
         Cdw8dFvA/BYxQ==
Date:   Tue, 18 Jul 2023 20:55:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        linux@leemhuis.info, krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <71224ff9-98d0-4148-afb8-d35b45519c79@sirena.org.uk>
References: <20230718155814.1674087-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LSdGOUQcgKsH6g7g"
Content-Disposition: inline
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
X-Cookie: You are as I am with You.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LSdGOUQcgKsH6g7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 08:58:14AM -0700, Jakub Kicinski wrote:

> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.

I'm not super comfortable with all of the musts here but this is
probably fine so

Reviewed-by: Mark Brown <broonie@kernel.org>

One note:

> +Maintainers must be human, however, it is not acceptable to add a mailing
> +list or a group email as a maintainer. Trust and understanding are the
> +foundation of kernel maintenance and one cannot build trust with a mailing
> +list.

If you're revising this I'd add a note about the L: tag in MAINTAINERS
here, or possibly just adding a list in addition to humans.  It is
sensible and often helpful for companies to want to get mail copied to a
wider distribution list internally but they're not really what we mean
by list since external people typically can't join them.

--LSdGOUQcgKsH6g7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS27jgACgkQJNaLcl1U
h9CIIgf+LLz2FFY+gdDkyU+XJv8nVYZJr7tmYVzdbjT94MAsKgVXjd/DcXrUdISB
gItU3VHXnC2vXX+rgEUOSZwEBQ2HXi/Grj4As79eV6n29QwE4yMDZ2GIOhcDKqvH
2GZGDLYaShzkKQNzin2eyCkjVd9ZCquoNCpU8trTaUz56uX3DmuyD2JwqDWnqX1v
OkPdZHhfAF1jy9XPo1CNXMjgnhP3yNawqptigD7c/bVGY76VjwJ0pphpPij93BQl
eHMTeQceIZGAPnDtxJAcxFHojjZ9UoHPcit1hMLuIn4xSIIMMOJDVS2fyrcLTynJ
qg2xILiUbAc4zJlKhCe2eLYe8eM4sg==
=guc9
-----END PGP SIGNATURE-----

--LSdGOUQcgKsH6g7g--
