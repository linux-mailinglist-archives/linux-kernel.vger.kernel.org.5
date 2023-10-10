Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA17C03A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjJJSpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJSpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:45:38 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574B494;
        Tue, 10 Oct 2023 11:45:35 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.96)
        (envelope-from <m@bues.ch>)
        id 1qqHjR-0004TG-1n;
        Tue, 10 Oct 2023 20:45:24 +0200
Date:   Tue, 10 Oct 2023 20:43:46 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] ssb: relax SSB_EMBEDDED dependencies
Message-ID: <20231010204346.78961fc4@barney>
In-Reply-To: <e551fb4c-1e3d-4e1a-a465-5b88842789c6@infradead.org>
References: <20231007182443.32300-1-rdunlap@infradead.org>
        <20231008093520.42ead15f@barney>
        <22bc05d3-86e9-4cf6-aec6-10d11df1acc3@infradead.org>
        <e551fb4c-1e3d-4e1a-a465-5b88842789c6@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FN/=Ev6SLbQKxhIfhwxFUxO";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FN/=Ev6SLbQKxhIfhwxFUxO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Oct 2023 23:12:49 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> -	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
> +	depends on PCI=3Dn || SSB_PCICORE_HOSTMODE

I thought about something like this:

depends on (SSB_DRIVER_MIPS && PCI=3Dn) || (SSB_DRIVER_MIPS && SSB_PCICORE_=
HOSTMODE)

Would that solve the warning?

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/FN/=Ev6SLbQKxhIfhwxFUxO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmUlm2IACgkQ9TK+HZCN
iw5urA/+NOSFVeXgWibs9YUNACLlI2Qwzqc47vH9YbRl6mLSljFSWOcbeA21KWK7
kfZt/Iw08MQiRGPgZ/fb754lLrp+5GS/Fur5qE6Og4qk8GIXDotteWCLmQdUshdD
CC9F7y7oFXXrMVxl7ChEDjEhOx1cWK8kVst0TjFQTqxgzPdMXbhvMShsTLXjUb3H
uHv8FXbOPQ2IsYBXb5vdYOvLGSW/OrVoSLuRnvrXhLxDVmagFmfpaTu/uFx96X4o
gOUzcmoJAFwWPW9EzRIGQTRvpOnHhU474fMsc4mI6rgqp+X0qs0z96uMDO6iDZ1U
fqwecJ/6IxRSs5xtytND2Wz7E7mY5+kjEJh8qrTFIt3tivs38FHAIw9HT0Brgx2d
+/JcFmcyzcAsF6AJ/ZFXY1XcRg8pA7CGqP8GJQ7EVf1JULX8pJFY7b5mjU2G/wLE
+1UVHf1Iz9n5XWTIJi6xrWscDghN9jS4bmerfrwy06DkgLbSZBGzllTTFR3+/dWb
SrnW3OE3sx6Pob3PpUYcbYkIYKGIA8x4Y66thqqUbx47US/qdYtGwbG2P3yf4d+F
e38ysvlv6sR+lHTmd+b2CxR2/qCs/rfld09XcJnCW1mPElUhfBqoYl3KqDhhZtOs
IuzdFiyowbt1XYXadCIXa95BV4K3KBacMealYRsQFMd/y0+ONd8=
=feI5
-----END PGP SIGNATURE-----

--Sig_/FN/=Ev6SLbQKxhIfhwxFUxO--
