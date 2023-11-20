Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408D57F1963
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjKTRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjKTRJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:09:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D91BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:09:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F99CC433C7;
        Mon, 20 Nov 2023 17:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700500171;
        bh=t6WmvTgs952iHMO/Vabb8nvYQyqm9iI509KruWl4Ha0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyrIJvXWGPl1/C9FXkGpUWUU1yEMwKLL/+WVG2nDBIx2x6P97lcmJZLuVy74NJuJr
         +Q1iOsdYgf+w9Qvr9VB6Xvv5R3vwi0iNFdMHJ7aNZxol3ud1Twu2DZJlSfGL2brCIc
         qFTi82u+06iRn6pppCygI6qAsPsdXeHMdYKdtK68ifSPaofSRUAl3PORGXrIa3VmgH
         gRoNp0tRMszLkidEC50kLzpYVtfq3ZieBPknSQS6EtTEmSzdrYiPjU81T7H2MPXebJ
         e2sQzbifdoBRzq4VdCIF797JmkmVJ4hw9XGZzLZ2+ZETYfHlejW5I5aMmhm4O5VlfX
         BVZBJuVBKGAaQ==
Date:   Mon, 20 Nov 2023 17:09:27 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Expand Firmware upload error codes with
 firmware invalid error
Message-ID: <20231120-shopping-mortally-fd3e5e0c9512@spud>
References: <20231117-feature_firmware_error_code-v1-1-92c973a50847@bootlin.com>
 <2023111720-slicer-exes-7d9f@gregkh>
 <548c3b60-60ce-4166-9943-224e03152cc5@lunn.ch>
 <2023111727-exert-dab-b940@gregkh>
 <20231120162537.468de5b6@kmaincent-XPS-13-7390>
 <4cae34b1-b68b-4ebd-aee9-4e39f4243f9f@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ENfSVIuQ6qSwBs+s"
Content-Disposition: inline
In-Reply-To: <4cae34b1-b68b-4ebd-aee9-4e39f4243f9f@lunn.ch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ENfSVIuQ6qSwBs+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 05:52:09PM +0100, Andrew Lunn wrote:
> > Sorry, my fault, I did not know well the merge actions that were needed=
 for
> > this particular case.
> >=20
> > > > If you don't want to do that, we can ask Arnd to take it, and he can
> > > > create a stable branch which we pull into netdev. =20
> > >=20
> > > You want a stable tag to pull from, right?
> > >=20
> > > But really, why not just take this through netdev?  It's just one
> > > commit, I have no problem with it going that way at all.  If the odd
> > > chance there's a merge conflict in the future, I can handle it.
> >=20
> > Seems a good and simple idea to me, Andrew any thoughts about it?
> > Do I send a single patch to net-next and ask Conor to pull it in his
> > subsystem for his patch series?
>=20
> Yes, send a single patch to netdev. Under the ---, ask for a stable
> branch. Jakub should then hopefully reply with information about the
> branch, which other Maintainers can then pull.

Sry, lost track of this a little with catching up on life after being in
the US for a week. Obv. stable branch doesn't matter to me where it
comes from, so that'd be neat.

Cheers,
Conor.

--ENfSVIuQ6qSwBs+s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVuSxwAKCRB4tDGHoIJi
0plBAQDMP58ziQ4djyM+IKszUdt/dofOg8OOGS68mIuPci8TmgEAquCyhMIBchPz
bfoB+Fcctar6sMAIJV3Lwp+a/YFwYwc=
=WwQb
-----END PGP SIGNATURE-----

--ENfSVIuQ6qSwBs+s--
