Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8231A75BA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGTWYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGTWX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE3E1737;
        Thu, 20 Jul 2023 15:23:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E9E361CAE;
        Thu, 20 Jul 2023 22:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC8CC433C8;
        Thu, 20 Jul 2023 22:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689891832;
        bh=B6W1N9chnY7IcnK3aYia8wRiaWLSW1VhXwx0aoj6k7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEdZggyJVgTuqkjHTW9vQYx8gKCeE1Xet8TZMC/fGc2BodpG5ZrAhZ3O4r/ZfsAP1
         0kdKUz9xtWPKZpfE2FOpprUfK7lO2u3GVhTX20Vx7ucTnqx0dPBkJvtWsCBxA4xmEW
         e8O/GY52Zi0Ug0lDLoBYZU/EcOqUeBTge+dnBuozEDW+iHKh2KNczSt6mLKztWjjQO
         J6mC+pA4Cqm/TSDGRiVfYQl5xISN/KL30Vz7vsGEAgtMxK2okIx27DwRvq6YvS4gA1
         OmzaL++lleNpAuPkTjCoLDmtt1g9gFCab3PoFyVMgKAw6/lnjKdW3SZcZoEQ9v7sz7
         J1Gzn/i6zRvtg==
Date:   Thu, 20 Jul 2023 23:23:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
        benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <20230720-mace-dipped-3bd066667b3f@spud>
References: <20230719183225.1827100-1-kuba@kernel.org>
 <20230720-proxy-smile-f1b882906ded@spud>
 <20230720143746.1adb159a@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7E5noNPs/iMecJG0"
Content-Disposition: inline
In-Reply-To: <20230720143746.1adb159a@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7E5noNPs/iMecJG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 02:37:46PM -0700, Jakub Kicinski wrote:
> On Thu, 20 Jul 2023 16:15:26 +0100 Conor Dooley wrote:
> > ..I noticed that none of these sections address actually testing the
> > code they're responsible for on a (semi-)regular basis. Sure, that comes
> > as part of reviewing the patches for their code, but changes to other
> > subsystems that a driver/feature maintainer probably would not have been
> > CCed on may cause problems for the code they maintain.
> > If we are adding a doc about best-practice for maintainers, I think we
> > should be encouraging people to test regularly.

> I think our testing story is too shaky to make that a requirement.
> Differently put - I was never able to get good upstream testing running
> when I worked for a vendor myself so I wouldn't know how to draw=20
> the lines.

I'm not saying it needs to be added as a must level item, some words to the
effect of
  Maintainers should test the drivers/features they are responsible for on a
  regular basis, independent of patches that modify their area of
  responsibility. This helps ensure that changes to other parts of the kern=
el
  do not introduce regressions in their driver/feature."
would suffice IMO.

The doc as it is is a useful addition though, so you can add a
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
if you like.

Thanks,
Conor.

--7E5noNPs/iMecJG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLmz8gAKCRB4tDGHoIJi
0pN2AP0Xd2XBsDNncFbZ2tU2esaZm61Bv1Qm8ravumVaJPp4aQEAp34+tM3RtH9V
grQF54xOH05cBTHFkohiAdRN/PILXww=
=E5Ol
-----END PGP SIGNATURE-----

--7E5noNPs/iMecJG0--
