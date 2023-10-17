Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869C37CC976
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjJQRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQRF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:05:57 -0400
X-Greylist: delayed 1371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 10:05:55 PDT
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1438192;
        Tue, 17 Oct 2023 10:05:54 -0700 (PDT)
Received: from [213.219.164.206] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1qsn9l-0000b9-Ae; Tue, 17 Oct 2023 18:42:57 +0200
Received: from ben by deadeye with local (Exim 4.97-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1qsn9k-00000003p6a-3FLY;
        Tue, 17 Oct 2023 18:42:56 +0200
Message-ID: <8ebc783f95ee255d56372bfa59622bcb8cb4d79c.camel@decadent.org.uk>
Subject: Re: [PATCH v2] docs: add backporting and conflict resolution
 document
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Vegard Nossum <vegard.nossum@oracle.com>, Willy Tarreau <w@1wt.eu>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        backports@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 17 Oct 2023 18:42:49 +0200
In-Reply-To: <12b082c8-908f-4de2-b0b5-4b638e10c402@oracle.com>
References: <20230824092325.1464227-1-vegard.nossum@oracle.com>
         <87bkdfg2ds.fsf@meer.lwn.net> <877cnu5jy0.fsf@meer.lwn.net>
         <83fd1a05-974e-4d91-82b0-c09cc2f8da1e@oracle.com>
         <20231014094320.GC20662@1wt.eu>
         <12b082c8-908f-4de2-b0b5-4b638e10c402@oracle.com>
Autocrypt: addr=ben@decadent.org.uk; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-T2Gq0/eSGsrekyVKrt0t"
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.164.206
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T2Gq0/eSGsrekyVKrt0t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2023-10-14 at 13:48 +0200, Vegard Nossum wrote:
> On 14/10/2023 11:43, Willy Tarreau wrote:
> > Hi Vegard,
> >=20
> > On Fri, Oct 13, 2023 at 05:24:31PM +0200, Vegard Nossum wrote:
> > > I've now added Steven Rostedt and Willy Tarreau as well on the
> > > off-chance that they have something to say about it (Steven presented
> > > his conflict resolution method at Kernel Recipes and I think Willy is
> > > experienced with backporting), but this is in no way meant as pressur=
e
> > > to review this patch. Here's a link to the top of the thread:
> > >=20
> > > https://lore.kernel.org/all/20230824092325.1464227-1-vegard.nossum@or=
acle.com/
>=20
> (Adding Ben Hutchings to Cc as well for the same reasons.)
[...]

I previously wrote some text for CIP about reviewing stable backports.
The "Read the code" section should be applicable to writing them as
well:
<https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmain=
tenance#read_the_code>.

I didn't compare with your text so it may be that you already covered
all those points.

Ben.


--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, on joining IRC


--=-T2Gq0/eSGsrekyVKrt0t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmUuuYkACgkQ57/I7JWG
EQlWoxAAoYTYvDLaLYc6/mndCvqwQPVYPqnuGWFk/NtXrL8LdELB7khnPcUk5ei8
42idK4016efuzjZgusn49LgCQ69BPWMT+ODHYQXLxm6+m0z6dLCu+m5OjTy3oU8u
Fjp9XBlc/OTMIqiexOm5Z3ELjFReeooHXxSVztaumQIW51z4+LupacpGTP3IWcii
0UF1LwyvX72Gk8Fyr7dUjCHvCRUSsNSxselxcGgq51it4Ksr1JjaVwppVyLcGHqV
CiuojfEvAviMpmHFqalN6hbboGRNDl3a+aYv1EY2slMtp0ZfAP1YGbgAx2znoDw1
YQ+gjbNI3UN0VaTRZEGoB5PW/1NJo5Wz4vi4am97RwlW9ZVo3pYN2Mle8Kv3aNfA
ngM0KOEXRR8kRbKTNpMAADlKfgcqho4HWgZ5KVWtl69PpJQZe59ng+E7mDjZlMQ0
3rOLCpxfrFCnFncSgbBZmYKDMF9bUfEiuZbTxTtrKkmmc5Fp5KYRF16VOS7u4Vwt
ikCuwUrodxkPGDPfFsE/YIOc2XGK2N5oIe+KCmzx53FEaepPx9aUzL1+fGumiUD2
nHE8VK7wInOmivSBMvg4xvUoD0d/fchVwhva8xSmqt1l6Gf/VbapoDs3B1nBy9CD
xlWPP6WXcIyP0ZxpJwuFinRIXaRvnVqE8OC31EYkGJ8JeQ04LmE=
=N87o
-----END PGP SIGNATURE-----

--=-T2Gq0/eSGsrekyVKrt0t--
