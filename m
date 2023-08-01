Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1476BF48
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjHAV2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHAV2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D9C3;
        Tue,  1 Aug 2023 14:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECD3761722;
        Tue,  1 Aug 2023 21:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EA8C433C7;
        Tue,  1 Aug 2023 21:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690925323;
        bh=1hZbWxxV5RMauZkFKthmzEnmRTfZCL7wqxiHcUSUHL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWZ2VPpoaHlYZK6D1CS5Sp7OUZKTwMPcygm/CfB98tYWa6bNRl8BCFt/lSv/sX8c9
         n6rVJv4s7c7BEWhM4bqvuTO7tZPbhuwIvYVdcZCm9BOaHVm/G8+Vt4filP2hb+CsAA
         SQ8U/a7lXEMm6r8V4chFc0fEiCm+5GPhd/GgomF+n19a7aPFoChMcoqpEm5Jd7jv26
         6UuIGebIpggHOlzOSQbpJPG/lzT6LZ227yYHXvQJZlLI/RDyMDI9rRjXbEEoG8DW7E
         vRlvQvf5SpYQAtaDA/g1tyc1c65o/JN8pAphtkx5YuMEesemDq05apB/qzpCE446Aq
         8YQM182JPgCYA==
Date:   Tue, 1 Aug 2023 22:28:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
Message-ID: <20230801-selective-strife-b595804cdb27@spud>
References: <20230801170015.40965-1-festevam@denx.de>
 <20230801-clobber-attempt-7033f92b3d08@spud>
 <8b0e048208220b2ae09eb1a3c52219b9@denx.de>
 <20230801-dividers-chooser-bd0df9b72d91@spud>
 <f9ab7525f048f3ce814d89f106947c34@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gUKqyMISu6fVtEZu"
Content-Disposition: inline
In-Reply-To: <f9ab7525f048f3ce814d89f106947c34@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gUKqyMISu6fVtEZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 06:18:29PM -0300, Fabio Estevam wrote:
> On 01/08/2023 18:13, Conor Dooley wrote:
> > On Tue, Aug 01, 2023 at 06:10:52PM -0300, Fabio Estevam wrote:
> > > On 01/08/2023 17:47, Conor Dooley wrote:
> > >=20
> > > > Removing it without re-adding it elsewhere does not seem right, sin=
ce
> > > > there'll now be some undocumented compatibles in the tree, no?
> > >=20
> > > Currently, there is no ov5642 support in the kernel.
> >=20
> > It is present in devicetrees.
>=20
> Yes, and none of them have the ov5642 camera functional:
>=20
> arch/arm/boot/dts/nxp/imx/imx53-smd.dts
> arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
> arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
>=20
> > > If someone adds the support for the ov5642 camera, then a specific
> > > binding
> > > will have to be created.
> > >=20
> > > I prefer to remove it from trivial-devices to avoid confusion.
> > >=20
> > > As is, it gives a false impression that ov5642 is supported and that
> > > it
> > > is a trivial device.
> >=20
> > The latter only do I agree with.
>=20
> Care to explain how ov5642 is supported by the current mainline kernel?

I never said it was chief. Please re-read the quoted text.

--gUKqyMISu6fVtEZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMl5BwAKCRB4tDGHoIJi
0k0IAQCNv8s+X+RCfwYHOiCvyjiPiqb4lPzr7IHB5qEFYOBqnAD/ZasQ1C3hrdQx
ZlN5zokekiZ19LazDguvK34yglrEcA4=
=5Ek4
-----END PGP SIGNATURE-----

--gUKqyMISu6fVtEZu--
