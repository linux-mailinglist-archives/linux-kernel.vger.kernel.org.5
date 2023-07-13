Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37BD752770
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjGMPkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjGMPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF2C2117;
        Thu, 13 Jul 2023 08:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9DD61A0D;
        Thu, 13 Jul 2023 15:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A29C433C9;
        Thu, 13 Jul 2023 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689262796;
        bh=ucDuyNLNzA/3oK02pdOW1Qt7U+ttoZNdyoo8EnGWRFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfWfHok/E74jgDuSre3kPiXGu7mcfkYHn5jYUOj+8nWfbK243KYBZ3v2ZdyrDzjwU
         /iiz0fMHkNi4xYIVXzm6hSAd2W3261aYrpvEihnadUyTE+N+DKwem2XOi0rSTU3y3T
         h6KM7KsZJWXgFdgkLj2rgHDXOvobE6BY/sjZ9YTRMcRloviSEYKiAZlhah8Qd3eVP8
         ZLftVX9S65R4g97BJNg6oxCQjQS4hr7GgjaPvp+BY32zZyUGFPLKDU62OAANbf2FQR
         TmsormxOWLynkPHf6dwGwSif2fx2dVmbY94+U4NIbWgBS4rZKOd7q0SzDqyWfwWzXS
         60C5YlduFPS5Q==
Date:   Thu, 13 Jul 2023 16:39:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, stable@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
Message-ID: <20230713-irritant-rarity-5f7b424fe43e@spud>
References: <cover.1689008220.git.linux@leemhuis.info>
 <2023071002-phrasing-tranquil-49d6@gregkh>
 <a97a37bf-86b5-cd8e-a8ce-00e38720cee4@leemhuis.info>
 <2023071221-blade-reactive-0707@gregkh>
 <d8403c45-3561-4759-f6c2-d18afa5e323a@leemhuis.info>
 <2023071215-able-mushy-c889@gregkh>
 <18238769-39c3-2b40-7725-367aa0e5c50b@leemhuis.info>
 <2023071341-twitter-apron-e023@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5zCBt+dSDALTpKvC"
Content-Disposition: inline
In-Reply-To: <2023071341-twitter-apron-e023@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5zCBt+dSDALTpKvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 05:06:22PM +0200, Greg KH wrote:
> On Thu, Jul 13, 2023 at 10:48:14AM +0200, Thorsten Leemhuis wrote:
> > On 12.07.23 21:00, Greg KH wrote:
> > > On Wed, Jul 12, 2023 at 07:02:34PM +0200, Thorsten Leemhuis wrote:
> > >> On 12.07.23 17:16, Greg KH wrote:
> > > [...]
> > >>>>   .. warning::
> > >>>>      The branches in the -stable-rc tree are rebased each time a n=
ew -rc
> > >>>>      is released, as they are created by taking the latest release=
 and
> > >>>>      applying the patches from the stable-queue on top.
> > >>>
> > >>> Yes, that is true, but they are also rebased sometimes in intermedi=
ate
> > >>> places, before a -rc is released, just to give CI systems a chance =
to
> > >>> test easier.
> > > [...]
> > >> Nevertheless makes me wonder: is that strategy wise in times when so=
me
> > >> ordinary users and some distributions are building kernels straight =
=66rom
> > >> git repos instead of tarballs? I'm one of those, as I distribute
> > >> stable-rc packages for Fedora here:
> > >> https://copr.fedorainfracloud.org/groups/g/kernel-vanilla/coprs/
> > >=20
> > > As we keep the patches in quilt, not git, it's the best we can do.  T=
he
> > > -rc releases are never a straight-line if we have to do multiple ones,
> > > we remove patches in the middle, add them at the end or beginning, and
> > > sometimes even change existing ones.
> > >=20
> > > All of this is stuff that a linear history tool like git can't really
> > > model well, so we keep a quilt series of the patches in git for anyone
> > > that want to generate the tree themselves, and we provide the -rc git
> > > tree for those that don't want to generate it and can live with the
> > > constant rebasing.
> >=20
> > /me first didn't want to reply, as this is not really important, but
> > then reconsidered; again, feel free to just ignore this
> >=20
> > FWIW, I do not consider that rebasing to be problem at all; it are those
> > rebases "sometimes in intermediate places, before a -rc is released,
> > just to give CI systems a chance to test easier" make things this
> > slightly annoying bit harder when you want to distribute stable-rc
> > releases to users.
> >=20
> > But as I said, I can fully understand why you do those as well. I just
> > with there was a way to reliably get a -rc release from git as well.
> > Simply tagging them when you do a -rc release would solve all that. Is
> > that maybe something that could be easily added to your -rc release scr=
ipts?
>=20
> I can add a tag, but it would have to be a tag that can be rebased, and
> git doesn't like that very well :)

I figure the desired tagging behaviour is that you do it when the email
is sent out for a corresponding version & so the tag "should" not need to
be rebased?

> > /me looks at https://github.com/gregkh/gregkh-linux/tree/master/stable
> > but failed to find the -rc release script :-/
>=20
> Hah, no github, it's at:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/=
tree/scripts/quilt-mail
>=20
> But I don't think tags will help much.  I'll let anyone who actually
> runs a CI that uses this to speak up to see if it would before adding
> them.

I'm not sure that it is particularly valuable to the usual flow of
testing what is about to come down the tracks, at least in my simple
case where I trigger it based on the -rc emails or whenever something
else interesting happens, like a patch being dropped that breaks the
build.

I suppose it may be useful if an issue presents itself but disappears
when a backport is dropped from the queue & some developers are
interested in figuring out why the backport went awry?

Other than that, I'm not sure what the value is in "I just with [sic]
there was a way to reliably get a -rc release from git as well", in
_my_ CI use case I don't care about the superseded stable -rc versions,
just whatever is about to be released.

Others with more complex CI infrastructure, like Linaro etc, might feel
differently :)

> Also, as proof this works, I just got a report of someone testing the
> queues and finding a problem at the moment, before we sent anything out
> for review.  So this is working well today.
>=20
> thanks,
>=20
> greg k-h

--5zCBt+dSDALTpKvC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLAaxQAKCRB4tDGHoIJi
0ufnAPoDpPrRw9iwibvmWTaKWO72V+pyNZUp7/9FmQCwxMfs0QEAgV1zbDgb6hIu
J1txvI3y+DExvTq+h1xUqgdvVZduRA8=
=X8n3
-----END PGP SIGNATURE-----

--5zCBt+dSDALTpKvC--
