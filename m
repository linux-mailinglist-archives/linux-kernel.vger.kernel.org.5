Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D6754321
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjGNTQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbjGNTQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C8035B5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8AD061DD3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 19:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D5FC433C7;
        Fri, 14 Jul 2023 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689362200;
        bh=tdNmV87SfUSFyYaO2ts8ss5anDI4X4bOQwY9ferHgMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDyxLCmyt8dgmVus9sRqRcqSK2PXHCBF5KcwivgZpRbR2N0xECRuqHqN61ImjFZW7
         NWNpu4J++ZlijJkopY1VI7J/mSrDC1tcjUxK71NbSgcpSbeQfbSHyua8lxFaEVGxSg
         NuHawuho2eMUFaLHGLPOkg6WjRVFUEwe4RblrG7zyU9pNt3W/GbetN5Bj9lBFlVvV1
         s4LeVvSmkaFa9eg+lHJChNN2kx6CfLKlMmWHDRTk+WmEHNeqo/9kP85XoANPMiTK+Y
         uAy5+b9xDmE+vx2zisEmcxhZzTBqL/lVtskZm7EEZHtNpyNhVRtrt63nC8lnIFcjvL
         eR2qy6v/9HtMA==
Date:   Fri, 14 Jul 2023 20:16:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Message-ID: <d80b10d3-7c4a-4430-8467-4672e3824a04@sirena.org.uk>
References: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
 <d8f60e51-2d62-4370-9032-51eda744239d@sirena.org.uk>
 <9629970cc2c3452e83a43660823319e5@dh-electronics.com>
 <8558f2aa-09fd-4cd3-ae1e-c80893e00aa1@sirena.org.uk>
 <c9759811145747f98462388f63358dd6@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b85ysJ1Ohv9EB4nl"
Content-Disposition: inline
In-Reply-To: <c9759811145747f98462388f63358dd6@dh-electronics.com>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b85ysJ1Ohv9EB4nl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 07:03:28PM +0000, Christoph Niedermaier wrote:
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, July 13, 2023 6:34 PM
> > On Thu, Jul 13, 2023 at 03:36:38PM +0000, Christoph Niedermaier wrote:
> >> From: Mark Brown [mailto:broonie@kernel.org]

> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>> Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@intel.com/

> > That doesn't mean you should include tags like this, it makes it look
> > like they reported the commit...

> Thanks for helping me. May I asked which tags are you referring to here?

The ones quoted above.

--b85ysJ1Ohv9EB4nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxnxIACgkQJNaLcl1U
h9C4wQf9EVRp3B5Wv8fZqhwhBnRgIh4/IsZg+Mw05Vxka3ldluPYxyq3b6CJC8n5
fF6c/lOO3GKq/hGG54ug1KHtC3XqPkzKdSllmoEFOo8OU/YRoLtc8A9SHY3Oz/Dp
SlrBy8xMZIzctBTkQ9wAaew2g/qyqKIPxU5EMxfieGByd4OZmW9DTsL2ru89wYFY
ozIgDVUC2Ha+F+dOBbQBSf/Q0ffinC9Z5+AFfJh6dG5nq4dyqoYXwqsm3avWa+Ui
UV0zSQt8YhL7E/XjxVjGoQpIM+K1yamhRo8CBAe0k+V2slv/fxJ4rmvVRBdtIBW/
GSC0NFetrCp1zLV8kQgRHMx7MhyIyA==
=9mNh
-----END PGP SIGNATURE-----

--b85ysJ1Ohv9EB4nl--
