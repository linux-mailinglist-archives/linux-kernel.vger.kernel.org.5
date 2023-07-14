Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2527543B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjGNUUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbjGNUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F70930E3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13E8861DDA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7B4C433C7;
        Fri, 14 Jul 2023 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689366037;
        bh=A8OkRCsbD/nCU01SJsxyCy3+poA5Ls8iiUT+YXm/xfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPnQo6ah5fHuADVvu7j7tOfLPpG2L8jcEgzPmC4ziOQba05lrbQjw0jMsM6ld6bNw
         Snc/GFaiK+jG3/TToIIr1ANI406rlPukLRLugI1viPR6Cl2x417QacAR94LNDCw5dG
         fNmlJqHspe78lVdNaPY29994RwjYeZBv8twAF0EhwPGsi3NnL56/5xVI5xcM5F9HJb
         oSoxjrCNPRaPG/dN4UZJ5kJjz4ucDyuDeAAraXCb1jFONpvtTa0WkDIe2GpY9dPJ1F
         PimcsboPzddxZwxFnnih5pj96Gvv8XFDRYFF9M1vGe7W+tKXSC7RMh+4cBEGZPMkdX
         jKcZ0NShfUIDA==
Date:   Fri, 14 Jul 2023 21:20:32 +0100
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
Message-ID: <5f79c2c7-315b-409d-9f3d-78c1fb03bb49@sirena.org.uk>
References: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
 <d8f60e51-2d62-4370-9032-51eda744239d@sirena.org.uk>
 <9629970cc2c3452e83a43660823319e5@dh-electronics.com>
 <8558f2aa-09fd-4cd3-ae1e-c80893e00aa1@sirena.org.uk>
 <c9759811145747f98462388f63358dd6@dh-electronics.com>
 <d80b10d3-7c4a-4430-8467-4672e3824a04@sirena.org.uk>
 <d7718a5bb2384bdd96a2cc612ae3640a@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A/ETv++GvGjCK9O7"
Content-Disposition: inline
In-Reply-To: <d7718a5bb2384bdd96a2cc612ae3640a@dh-electronics.com>
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


--A/ETv++GvGjCK9O7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 08:15:40PM +0000, Christoph Niedermaier wrote:
> > On Fri, Jul 14, 2023 at 07:03:28PM +0000, Christoph Niedermaier wrote:

> > The ones quoted above.

> The kernel test robot wrote:
> [...]
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@intel.com/
> [...]

> Maybe that misled me.

Yes, I wish it wouldn't do that.  That really only applies when you're
sending a patch that's substantially a fix for the issue it reports, for
things that have not yet been applied it's just a normal review comment
and you shouldn't add the tags.

--A/ETv++GvGjCK9O7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxrg8ACgkQJNaLcl1U
h9BY3Af/W+v9gXYQG0aqgNWDl5aQ0Tw1NjfpyagKdMCIsvOsAo2e1HE18c/+NFBX
G9mn8Ra/k0/qcHrJKlxp+0x5941U1VHfkx/YNSVsTobf/QtHt/VowLlwESyl4weG
n8SJigq1Vsj61AKRzKRA+gYP6pLR5kdlG5jcpCH/65jwOI4iumujGCVFSoWSSxUw
HJJMgfsX+eK0UAxEcj/Qwz1OAWtqHAf7eNFeTdYliLqdOGvhczTXpqxqnpgWImfE
tLD369vAdBbXk6Sj7Vb+gAMo2dRPI9pnTHIuVkVrsyVRzlbaUJREGfTILhsB0YXA
JEMaKO41XrIfQHiCKUhFGyZ4ADUHvA==
=72Oe
-----END PGP SIGNATURE-----

--A/ETv++GvGjCK9O7--
