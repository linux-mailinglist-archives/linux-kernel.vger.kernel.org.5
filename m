Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3244A75B236
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjGTPPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjGTPPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0CF26B0;
        Thu, 20 Jul 2023 08:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5FB361B40;
        Thu, 20 Jul 2023 15:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F333C433C7;
        Thu, 20 Jul 2023 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866131;
        bh=04mRcNWXgjQaxb3drv8PqaZhrLgEK17mnXzAi5oyt+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZ7zi/YChc7USpnQSp5T0WNJP3whsLqNWbYH0AXGbZ+OPIel3HkL12V4RKtTgkT3q
         12cinlCgxfelVNBEDAe/C0Nug7zGF65Y84fptydiaXuEy/BOgWQmMqwP3Vk3usLG7u
         3miKCy4dtQr/lMDbN52RFCxGfNngX2QivUxp114Tc6xZ2qBGdMQLKmuJTze6tSUeSA
         t1s8ShqnRBSwyTwAM+xWRnykyxYYelnnPwhfWr7DhahqaYfd2teQXHFSN7bOVgrJj0
         z4jdKRMjh1U/oMSe6H9AvAsgbvJy/MGYoL5COk72Gbzu/sIgrRNmoJYLy53QDhrCSF
         aJNHRycL1Vrzg==
Date:   Thu, 20 Jul 2023 16:15:26 +0100
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
Message-ID: <20230720-proxy-smile-f1b882906ded@spud>
References: <20230719183225.1827100-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d/z8QjQ7RZYLewHr"
Content-Disposition: inline
In-Reply-To: <20230719183225.1827100-1-kuba@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d/z8QjQ7RZYLewHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jul 19, 2023 at 11:32:25AM -0700, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
>=20
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.

Thanks for writing this up, it's great to have this stuff written down.

I had one minor comment from reading through things...

> +Responsibilities
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The amount of maintenance work is usually proportional to the size
> +and popularity of the code base. Small features and drivers should
> +require relatively small amount of care and feeding. Nonetheless
> +when the work does arrive (in form of patches which need review,
> +user bug reports etc.) it has to be acted upon promptly.
> +Even when a particular driver only sees one patch a month, or a quarter,
> +a subsystem could well have a hundred such drivers. Subsystem
> +maintainers cannot afford to wait a long time to hear from reviewers.
> +
> +The exact expectations on the response time will vary by subsystem.
> +The patch review SLA the subsystem had set for itself can sometimes
> +be found in the subsystem documentation. Failing that as a rule of thumb
> +reviewers should try to respond quicker than what is the usual patch
> +review delay of the subsystem maintainer. The resulting expectations
> +may range from two working days for fast-paced subsystems (e.g. networki=
ng)
> +to as long as a few weeks in slower moving parts of the kernel.
> +
> +Mailing list participation
> +--------------------------

> +Reviews
> +-------

> +Refactoring and core changes
> +----------------------------


> +Bug reports
> +-----------

=2E.I noticed that none of these sections address actually testing the
code they're responsible for on a (semi-)regular basis. Sure, that comes
as part of reviewing the patches for their code, but changes to other
subsystems that a driver/feature maintainer probably would not have been
CCed on may cause problems for the code they maintain.
If we are adding a doc about best-practice for maintainers, I think we
should be encouraging people to test regularly.


--d/z8QjQ7RZYLewHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlPigAKCRB4tDGHoIJi
0vo7AP9SiCGy+w1ylCijiSy5SGDnWjSKXk19XlvB6y46RGchEgD/eDPkXorZb8NH
dbM/yc7dITacGo/AZysVMhOVCS2KYA4=
=umN0
-----END PGP SIGNATURE-----

--d/z8QjQ7RZYLewHr--
