Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F367E806F67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378296AbjLFMEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378255AbjLFMEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:04:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38712B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:04:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B093FC433C7;
        Wed,  6 Dec 2023 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701864277;
        bh=hf0wwGoj3vFrFNGbV6LvWeYIVPa195ZSUjfPzyMczCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Do+BQYA2BbTAupbDP9XR8jO2ohSeFNqxyzegnLwHKShStnB6/e5XbUuBKdETV0Nih
         iflDUYbuMxd6iYNeQg/ADATBJIKCUEDrRdrsHHQD6YcUcWxwb/1oo5tvmmRVQE5/b/
         euGknZhN9/euy2ebbbNktSs4uYl0+3xKa4vPoB74SaOtoVZ2rUi9SzUW/+LjzgPHQZ
         cwDEJp2bOjXOCUD2DpR37PHPhHnK9UECvC2cMP0Tv3h5HbSmklrNiizF1z5DpGCNua
         r7xxW2WzVCrO5D8yeFvouk7DJQJYk5OE4yZXBJs5QtN0FqItlF1l7hGR8wTyDRtNFl
         2y4U65ty/SXKQ==
Date:   Wed, 6 Dec 2023 12:04:33 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231206-sacrament-cadmium-4cc02374d163@spud>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
 <20231124192407.7a8eea2c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q7cAzhk5In1+P+K8"
Content-Disposition: inline
In-Reply-To: <20231124192407.7a8eea2c@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q7cAzhk5In1+P+K8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 07:24:07PM -0800, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 14:52:43 +0100 Kory Maincent wrote:
> > Jakub could you create a stable branch for this patch and share the bra=
nch
> > information? This way other Maintainers can then pull the patch.
>=20
> Tagged at:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git firmware_loa=
der-add-upload-error

It's taken me longer than I would like to get back to this, sorry.
I tried pulling the tag today and I think there's been a mistake - the
tagged commit is the merge commit into net, not the commit adding the
firmware loader change:

commit 53775da0b4768cd7e603d7ac1ad706c383c6f61e (tag: firmware_loader-add-u=
pload-error, korg-kuba/firmware_loader)
Merge: 3a767b482cac a066f906ba39
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Nov 24 18:09:19 2023 -0800

    Merge branch 'firmware_loader'

commit a066f906ba396ab00d4af19fc5fad42b2605582a
Author: Kory Maincent <kory.maincent@bootlin.com>
Date:   Wed Nov 22 14:52:43 2023 +0100

    firmware_loader: Expand Firmware upload error codes with firmware inval=
id error

I'm going to merge in a066f906ba39 ("firmware_loader: Expand Firmware
upload error codes with firmware invalid error") so that I don't end
up with a bunch of netdev stuff in my tree.

Have I missed something?

Thanks,
Conor.

--q7cAzhk5In1+P+K8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXBjUQAKCRB4tDGHoIJi
0vHBAP0cRxI/7yWoWbLPFAqgbREYK80xk0WLfy3vuYw0StDJ7QD+IWVoxwm4FoLI
0/P0tJpoFx+o2qU0EjYb3/YzT1/s+gE=
=WDQi
-----END PGP SIGNATURE-----

--q7cAzhk5In1+P+K8--
