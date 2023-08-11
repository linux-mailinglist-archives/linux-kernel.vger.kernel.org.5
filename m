Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489257792E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjHKPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbjHKPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5AE4486;
        Fri, 11 Aug 2023 08:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB19674F1;
        Fri, 11 Aug 2023 15:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF790C433C7;
        Fri, 11 Aug 2023 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691767272;
        bh=5yH/QY0qbIeK4kDqXoIZQCS0/v2CF5kLwjwQr2aVdjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXaNGE0ZDh36EgpW73kbhp8ZlQ8lfBJQKH2mYDG1xWouw9mNnArbV9fPQQR3QW/EC
         1j4uKlH9R/LfVx94e8U1ama48jB02z/LGyGrbEz48iv0ipnVNA5CjJthdDrl4dQYCb
         ym31+dc+S0vnSqayAs0KlngcXtKQHzYes2ZHAp4Xw+QTRptBe885Sbf5ov9Fj2hE7P
         5gJNkbhVvAXDLZ+LMdxbx5lG+TA6x1Q6P8ceNah88GqEmvMGqES6NquxdsIqJEfqb3
         tjKcGKlbneKOwjH2m/0vDsvb1Lc5O9y8tQfstXc+7pBa6P7k+8zp7GL1ApXT275qob
         9Ti1fYZ66BuAw==
Date:   Fri, 11 Aug 2023 16:21:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property
Message-ID: <20230811-ladylike-snore-abba84731921@spud>
References: <20230807110836.2612730-1-danishanwar@ti.com>
 <20230807-euphemism-trailing-ef4130dc7437@spud>
 <910a4a98-712a-5517-5a5b-ffb962f83463@ti.com>
 <20230808-unwomanly-generic-67d20f0e51cd@spud>
 <cd74e31f-8bc6-445b-9c33-51e53a439cd2@ti.com>
 <20230808-bazooka-uncoated-a3401d94b063@spud>
 <e49fb304-bd5d-5013-815f-5933a2a170c4@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UvC4hbAhKTdVUBxb"
Content-Disposition: inline
In-Reply-To: <e49fb304-bd5d-5013-815f-5933a2a170c4@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UvC4hbAhKTdVUBxb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 04:48:28PM +0530, Md Danish Anwar wrote:

> >> There are no standard defines for these interrupt types. However I can=
 create a
> >> new .h file defining all the three interrupt cells and their values fo=
r both
> >> PRU and RTU cores if you think that is required. Otherwise we can go w=
ith
> >> hardcoded values.
> >>
> >> Please let me know what you think should be done here.
> >=20
> > It'd be good to reference to the documentation for the cells, I don't
> > think adding a header is necessary here.
> >=20
>=20
> How should I reference to the documentation for the cells?
>=20
> Should I just add the details of cells in description of interrupt proper=
ty here.
>=20
>   interrupts:
>     maxItems: 1
>     description:
>       Interrupt specifiers enable the virtio/rpmsg communication between =
MPU
>       and the PRU/RTU cores. The value of the interrupts should be the PRU
>       System event number [cell 1], PRU channel [cell 2] and PRU host_eve=
nt
>       (target) [cell 3].
>=20
> Please let me know if this looks OK to you.

I was thinking there'd be an binding for the interrupt controller that
you could mentioned.

--UvC4hbAhKTdVUBxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNZR4wAKCRB4tDGHoIJi
0qvEAP99WX3NcLAixv8zdFz//y+7gtEByx3Dyc+XHWDHa7YrJAD9EBJnZ3J7vwcW
vT8XG04W7Q7owcS/c87Q6QIPDBR2RAc=
=Yd3F
-----END PGP SIGNATURE-----

--UvC4hbAhKTdVUBxb--
