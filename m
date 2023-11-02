Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE927DF33B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376425AbjKBNHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjKBNG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:06:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48133112
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:06:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAABC433C7;
        Thu,  2 Nov 2023 13:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698930416;
        bh=GdzkL2rMR/w2blFaOs+cPZdEUazxbS2cI+qhuzRw6Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cW5FlNNR0fIl6JO4+fTYwnzkDPnaHFm396+U6smgx4+u7ED5SipB7flpCuGjoQTi7
         DcwpfHsSmrpTMgYgyMiWWXOtxM8pukObOs/K5lcTKEySTv6UV3tSupmtkYksVZlVzW
         RUBtjnRLMDS527WbBE4s+itO7edjIsAFqHeNtx+cB1vBaMSPTqmdL8wLNEqAra5MXa
         cTg+8z8bS0ssFnJGW+yijGGZt6KWsyj7iAy+se6um+RQD6iW3Gl4m8zEXuIIkcoRJZ
         OGX3iWpa8wbcjm8ajk1cFMAN4lEpGeRxvj8WN8Xp/kCtx5yg4JtoX2jFF4c6iV1L3F
         YNEGfRVKNSaSw==
Date:   Thu, 2 Nov 2023 13:06:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
Message-ID: <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk>
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
 <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk>
 <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KxBcZHb1OtPbqR3A"
Content-Disposition: inline
In-Reply-To: <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
X-Cookie: A is for Apple.
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KxBcZHb1OtPbqR3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 02, 2023 at 05:35:42PM +0530, Naresh Solanki wrote:
> On Thu, 5 Oct 2023 at 22:30, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Oct 05, 2023 at 03:30:58PM +0200, Naresh Solanki wrote:

> > We probably should filter the events more, there's events for pre and
> > post voltage change for example which aren't status changes so would be
> > spurious.  It ought not to break anything but we should still avoid
> > unneeded work.

> Can you please provide me inputs on the additional filtering needed for this.
> Like some list of events for notify on status?

I think I'd start off with just reporting things that are obviously
errors and not things that should ever go off during normal operation.

--KxBcZHb1OtPbqR3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVDnusACgkQJNaLcl1U
h9CHcgf+NaEN2T3CtYbMVQsvj1Pj061L+saEsZkDL4d6Q55K3sY5QOIQvdRatbse
8BQUqzkADfiuE+c5IsVB90+OSM1IUx0duomjcLt3WrVLt7nxz6vI89AqR/F3pqzk
38fGUCogq+/Rp1nTCUr9JaIxOuo13kc6APx3Prurm/CSvQEeQ+JLSAE+qZ1nQKne
mRYgMMlMXleDSBXf1gmlP/HROH8zqJnybjEvVRmW0PWOjYnQTlUpjLI7q21BSucD
9OgMvJM1tx+rT3Obm9WtU7Gsp8+khojxR87JtHxmPfjLnpxNeXvMbWXtJpMI9I00
TFhvfd1g1Pm/z3HV9W5SZJkFyMNztg==
=hVBO
-----END PGP SIGNATURE-----

--KxBcZHb1OtPbqR3A--
