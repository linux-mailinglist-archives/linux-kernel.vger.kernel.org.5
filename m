Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3337BCA98
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjJGX77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjJGX76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:59:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB62B9;
        Sat,  7 Oct 2023 16:59:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso3043710b3a.1;
        Sat, 07 Oct 2023 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696723196; x=1697327996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sGMrrHTB+tR0vTLCrN7mfWdKJmRNgxB3WVQ9VyrNzI=;
        b=aAfax5/HrnoVzk6C75CBveuxphaHH/PqVfJ6c/4b0KIGwum7h+pP4A3Z7ZbJUTCiFH
         WcKDGbpu9dCtjSHIpMzmjkLcsNUy417PHujEVChJkGSFIWs20oWuwo2CjGnrfinA4kgS
         VHlxq6PGzJP0Q6SWD49GTMzvDEhMauFVeNfT85Lx3Pt0ZWWckq3nTx/USI82wgUXH2mB
         /qBNZkbS252zaKvjksjYYs9uwxrchpnpAkz6cI/PvoEqQDTS8yf2XAH161MVG6GLiqZl
         thIsOAmd4Puhd/TEUAgpQWo7NbE0QAqGAc2EdJLFhlGe4Q7VM0Iftg/V2WMFx5oZs8MY
         1X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696723196; x=1697327996;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sGMrrHTB+tR0vTLCrN7mfWdKJmRNgxB3WVQ9VyrNzI=;
        b=j0VO5ABJkrcIXVVuPgSqrJEm/4Q1shDFeHlq739CGT/OVG5DNU/7I8i50vdNq8DzNR
         yDalLKcSGl3ysm3+w26+5gef4beH64hyRCeoGUgwajMNduVL4Pi/Za9yjYWFOrUVSwzN
         4U/olmnHq1ZqrA4sR2UDdZRGDRzlL/cjP/1J9AMVjw1wx5LAO+9LCS2CMs/8/2PDAzmL
         v2QvlvP1RCwhG5snx2g1uzOx6SM6QCX/3fZM5wun9iQ4+PTnIEw/wfLwZrxfkUagV8Rq
         CPK4RzlUGxvF0ce3tBRvo1GYvZYwp7ZxZPGVrIOsvBtUyzRUUmFL63PYnwqK88gL7vlI
         SwLQ==
X-Gm-Message-State: AOJu0YybvDk1iI2Fs636eWglYXTUM1IiqeD+1QKYOdjBmZQiiFdiP8kD
        rWYg0mEbVp3BTHxZRIRpjoY=
X-Google-Smtp-Source: AGHT+IHJ9hE857rlcCCEcXGpcF+Gvj1SrB3Na2tvBurEBoU5+ZizPLQo14DoJbjzAoU0GtMSMNPcow==
X-Received: by 2002:a05:6a00:1511:b0:690:cb8f:3320 with SMTP id q17-20020a056a00151100b00690cb8f3320mr14902520pfu.24.1696723195652;
        Sat, 07 Oct 2023 16:59:55 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m16-20020aa79010000000b0068fde95aa93sm3649742pfo.135.2023.10.07.16.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 16:59:55 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 131A881B5CE3; Sun,  8 Oct 2023 06:59:50 +0700 (WIB)
Date:   Sun, 8 Oct 2023 06:59:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: I can't get contributors for my C project. Can you help?
Message-ID: <ZSHw9aGGHOpJ825J@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rIWI1lPtTC5iY74n"
Content-Disposition: inline
In-Reply-To: <457035954.3503192.1696688953071@mail.yahoo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rIWI1lPtTC5iY74n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[trim Cc: list as it becomes mess]

On Sat, Oct 07, 2023 at 02:29:13PM +0000, chaosesqueteam@yahoo.com wrote:
> Bagas;=20
> There is no other place that C projects are talked about. In the past I c=
ould get help and contributors just asking; now you are all silo'd in your =
own little worlds and seethe with extreme anger or some castrated-drug-stup=
or in "irony" and smugness against anyone that asks for some contributors. =
Every single place bans anyone that asks for contributors to free-software =
projects.
>=20
> You feel you are superior because you "did code" 10 years ago and "suppor=
t trans rights".
> When asked to even allow a message to be seen that asks for contributors,=
 in this case a file format, to a fellow C project: you seethe or pretend y=
ou are superior.
> As if I didn't know where I was sending the message?=C2=A0
> I sent it to: RMS, ESR, Bruce Perens, redhat, OpenBSD, NetBSD, and Line-U=
nix. All C projects. Just like this engine.
> I'm just asking for contributors. Not promoting "outrecehery" (some femin=
ist BS), Not "master vs main", not "noo can't call things whitelist/blackli=
st", and not Codes Of Conducts for free contributors. I'm just asking for C=
 programming help for 3d file formats I'd like to add to this free-software=
 project.
>=20
> sourceforge.net/p/chaosesqueanthology/tickets/2/=C2=A0
>=20

Please don't top-post; reply inline with appropriate context instead.

I repeat, this is not userspace application support forum. This (LKML)
is for Linux kernel development instead. You better get support somewhere
else.

Bye!

--=20
An old man doll... just what I always wanted! - Clara

--rIWI1lPtTC5iY74n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSHw8QAKCRD2uYlJVVFO
o9EgAQCRF6Zc4wh0NemCn3xpeWh3IkCq0j4AIB0fgpqiR5qt2wD+N999nC+PZtUo
p2GRkb8+MrgrB8ZOzzuqBawblwKZ7Qs=
=oe2q
-----END PGP SIGNATURE-----

--rIWI1lPtTC5iY74n--
