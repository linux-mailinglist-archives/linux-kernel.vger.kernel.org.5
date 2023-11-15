Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427CB7EC37B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbjKONTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343916AbjKONTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:19:21 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10DF123;
        Wed, 15 Nov 2023 05:19:15 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19B58E000B;
        Wed, 15 Nov 2023 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700054354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kh863IS7u51LKmMBYZ7PkwB+t+FoHqfRUvoHcoXoRyA=;
        b=ZemHxIE0oh3YTdce0+h4sKgelzDV1AcYbfoDS8gsEMMeKHWCNWXEeTBlBbXZAy559nPtE1
        onOHHFmd1eNjCGnWsCNFUTryj/3SsCvAMGFzEW8ZuYfQS4pxFlE9WAJ7/z/m6Z7Rrtb38A
        3F1y522W1zGTWSr4dsdgv+BNSj6uPS0e4f7JSLjnXgr0rBuMGoU2pl7gFPQkq9k8iu4TN7
        6/FAv7I/qOMdl/fprO4Fb2Foy9pA29UrpWEkzG2/B20wyAsCB6AZReXPfosP4mVPTHrUk8
        9b/D4lILeauWdJLknHWNSWm2h3MRf42ysFBPcQN5YyXOSh3yXH+6DzZIdEBTFQ==
Date:   Wed, 15 Nov 2023 14:19:12 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Message-ID: <ZVTFUKPxKvcBjg95@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <ZNTp1e4gJ2zeYmS-@aptenodytes>
 <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
 <ZNaVQ-zxIuCpGGha@aptenodytes>
 <720c476189552596cbd61dd74d6fa12818718036.camel@collabora.com>
 <ZOW91rIXS8fTWZ6I@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3XZa7c14TyG2LllA"
Content-Disposition: inline
In-Reply-To: <ZOW91rIXS8fTWZ6I@aptenodytes>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3XZa7c14TyG2LllA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

Just a quick message on this thread to let you know that we have just publi=
shed
the code for the H.264 encoding extension to cedrus for the V3/V3s/S3.

You can find more details in the dedicated blog post:
- https://bootlin.com/blog/open-source-linux-kernel-support-for-the-allwinn=
er-v3-v3s-s3-h-264-video-encoder/

And the code is at:
- https://github.com/bootlin/linux/tree/cedrus/h264-encoding
- https://github.com/bootlin/v4l2-cedrus-enc-test

As announced this doesn't really help advance our uAPI discussion here since
there is no rate-control yet and the stateful controls are reused for
controlling the encoding features (including things like GOP).

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--3XZa7c14TyG2LllA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVUxVAACgkQ3cLmz3+f
v9ENfAf/cJNtVqIttbn+OgAhNyMjAzoHsBnfzqQ3PxedfqcycLxpqNweZtSAhdjz
r/hZKT88PmyX0hilYA7dz/PNiqWVdYcokLyIKIDoDvWQhVR2fiUj7sc/w0485Cpk
lA6LH/t2dlQwPbL94AkXqdXt0mbk9u+YzrCEuyUwUcn3+kwR4bWBkheGXC98Y0Q2
KymMYlBPzgBpWp2XKdpq6wx3ldSwBzXmEg61pWhivQ21mX5f3JFBA211jM9qZJsi
BYhvd79JKDVW87bdE7m0leMkrgfL2NG+c7z80cdaHWm4FlCmCN1aRegWCIqySKKP
cvn+flA7FJdmz18rYhVQYWQfToAFFQ==
=Db/e
-----END PGP SIGNATURE-----

--3XZa7c14TyG2LllA--
