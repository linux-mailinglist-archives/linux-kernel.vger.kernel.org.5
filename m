Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FA1800CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379099AbjLAODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379060AbjLAODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:03:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DA94
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:03:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240B3C433CA;
        Fri,  1 Dec 2023 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701439390;
        bh=7X5mlH1FhTlTWpG02lqQC92oSHhlD5sS209SMgQyx6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=stL7FE/1UdRHQoA4JD28o4m8ZZAhui6Ys2h0U+lWV8hdxzUvKwpowl/6zDD1ZWtWg
         +MY8LZ1/GMi3f5z6nJ4L165KRJQiaqDfapf9GBxlu+w8w5m8vy1KQvtPGz/gN/ckPj
         hULoLTtnG3iAvDTTpaUaXuUiu/3iQGUZE1KM3ojoKkMZS83LqJJxor9k95eqhJWqpN
         J6kXBVPMJLcs1X2S4rUistazhuiLhCiHUZGJW1db7MEbtjXAH9MVMkm3GnKyMkWFAB
         mUkSVsIhtNoln+r6hu18pvK9WVVa0GiIUs6GrukiWTloWtTvNL8/aUwX0Zo+ogX5/D
         92UBll4+mxDFg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r947N-0002Bi-2q;
        Fri, 01 Dec 2023 15:03:45 +0100
Date:   Fri, 1 Dec 2023 15:03:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: pxrc - simplify mutex handling with guard macro
Message-ID: <ZWnnwfzqHlfjSqFK@hovoldconsulting.com>
References: <20231201-pxrc-guard-v1-1-38937e657368@gmail.com>
 <ZWnfsjIukIbAvQ-l@hovoldconsulting.com>
 <ZWnkFjFeEV7y9tUr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RvzoCxPxgrfnamj4"
Content-Disposition: inline
In-Reply-To: <ZWnkFjFeEV7y9tUr@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RvzoCxPxgrfnamj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 02:48:06PM +0100, Marcus Folkesson wrote:
> On Fri, Dec 01, 2023 at 02:29:22PM +0100, Johan Hovold wrote:

> > Eh, this looks obviously broken. Did you not test this before
> > submitting? I assume lockdep would complain loudly too.
>=20
> Sorry, it is more that I'm not in the habit of using b4 for submitting
> patches yet, so things got wrong.
> There is a v2 out there.

Ah, good, you noticed yourself.

Johan

--RvzoCxPxgrfnamj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZWnnvQAKCRALxc3C7H1l
CF+ZAPUQtJxNLf02XShjHdKS6NdhEE7tjiBvw9T/Jojh4lZ7AQCdctKkAWxZaw8n
0jC/CUrBTqsPcu0LBukxRPzPePx3Ag==
=8Tt0
-----END PGP SIGNATURE-----

--RvzoCxPxgrfnamj4--
