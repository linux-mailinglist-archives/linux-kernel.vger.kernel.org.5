Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A657BC641
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjJGI4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJGI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:56:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64DEB9;
        Sat,  7 Oct 2023 01:56:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a26fd82847so120919239f.3;
        Sat, 07 Oct 2023 01:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696669010; x=1697273810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTJg/SBhjNDXbVUr06AuAeTLWkYO2OxyUU+KgBhGwpY=;
        b=ast7+XWCp82WY2ICk0kIt6Wig0meFeGY22pQWbVdEIwEbYwCFtTlGkIx1DUEO/3nYZ
         R/GRcrvi70QcxHZCgjL+p3Fut7Vv2QEFDesHYbpHoNAgDVItCuhJT/A5emra79M+Mtb6
         3SMOYqdcqoduyJ7pcoCOy/qHUC1lJszI8pS5Cu+tWT+lA6U7C6yRIx/jox5DMTD/jdAH
         8d6bktIivT+e9p2AlizUVb1kWDU6co5DLKwpQ08WXIQMi3rS8tubwy9lH+S8Xdozufz0
         i2ddq1/7VUQ7Uuw6NvkTTcrf8n4knCJd87rJVg/m7O5N720TCkvgT+UhQPGj+c5t0Gg2
         Ylxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696669010; x=1697273810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTJg/SBhjNDXbVUr06AuAeTLWkYO2OxyUU+KgBhGwpY=;
        b=GmL1DVoVdjdEDVaxUhjb+znrJ1sfd0qs3AdP39Xu5wtevqwR57Q4MXBOEmWYPtle8U
         2LpHSMQaGUaKDo0JYKg1KwCjAAufrlxB1a8Xk8RINSPSTCq4KyFFIBbrXRrQFXmLg9ip
         46Cq3etztIp37m1CCOeR7eLd9Lp6Yx3QvIZio1K0O6mcbQitvQpX/+kgYQqd5DtpLz87
         vJ7FVqiftAcNm7sAtPUTAoB0d81+u9imxBp06feKStgkF8yL3hG8FDMszyxdFX3dxTLD
         b3/EX55p1CUxP/3JhoZ4JyW7BZfyK3HiXe7joOPdmi896VAqzz3QaICpaqemkYKi5jcW
         GGAA==
X-Gm-Message-State: AOJu0YwYqRKBrN96RbjKbPZG3Gv0vxXW1V9PZ8dL3usYh4b11iQz5rEL
        CbS1tI2+X7iTr9NeKxqr9Mw=
X-Google-Smtp-Source: AGHT+IEAC5engv3pY/b9bZ8YPLy67YXivc4Xcvg9IoKQy4aUtcZnJNztZCi+X8HibiAkemCwG8j6Vg==
X-Received: by 2002:a05:6e02:3201:b0:351:1dfb:3e88 with SMTP id cd1-20020a056e02320100b003511dfb3e88mr9558999ilb.11.1696669010118;
        Sat, 07 Oct 2023 01:56:50 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c26-20020aa7881a000000b0068fdb59e9d6sm2750051pfo.78.2023.10.07.01.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 01:56:49 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 22B5391D0C52; Sat,  7 Oct 2023 15:56:43 +0700 (WIB)
Date:   Sat, 7 Oct 2023 15:56:43 +0700
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
Message-ID: <ZSEdS8a5imvsAE8F@debian.me>
References: <875007189.3298572.1696619900247.ref@mail.yahoo.com>
 <875007189.3298572.1696619900247@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P/Yz30KNoY+loJhM"
Content-Disposition: inline
In-Reply-To: <875007189.3298572.1696619900247@mail.yahoo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P/Yz30KNoY+loJhM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 07:18:20PM +0000, chaosesqueteam@yahoo.com wrote:
> Dear RMS;
>=20
> I've read that you are both a lisp and C developer. I cannot get any cont=
ributors for the longstanding C 3d engine I work on as part of my fully-fre=
e-software (including media) 3d game/architecture project. I've been workin=
g on it alone for 10 years but now have branched into supporting more 3d fi=
le types and can't do that alone.
>=20
> I've gone to "opensource" forums and gotten banned every single time for =
asking for help. Every single time. The message gets deleted. This is extre=
mely difficult: it's not like 20 years ago when communication was free. Obv=
s the "opensource" community is no longer interested in any collaboration o=
r development.
>=20
> The reason I wanted to find more contributors, is that I recently (last 2=
 years) programmed more file format support myself (wolfenstine:enemyterrit=
ory bsp support) and extended and fixed support for existing formats (obj f=
ile support for use as maps, and support for minetest and minecraft object =
exports as maps directly into the game, and BZFlag exported obj as maps (th=
ese didn't work at all before: now they do (bzflag and the engine previousl=
y had different opinions on what an obj file was mathmatically))). That ope=
ned up 600 3d maps with the bsp work, and then 1000s of obj files with the =
obj_to_mc work. So I felt I was on a roll. Sketchfab was "opened up" and lo=
ts of free-software-licensed terrain and such were easily used from there. =
It was nice. I wanted to keep going.
>=20
> I thought it might be possible to get unreal 97 and unreal tournament 99 =
3d map formats working: as there are tons of maps there and I used to make =
little 3d worlds using that format. The two main formats here are .t3d ; an=
 ascii format (like obj) but which requires CSG math, and .unr : a binary f=
ormat which pre-compiles the csg math down to vertex and face info; but is =
more complex a format.
>=20
> I found free software projects in C++ that tackle each (my project is in =
C): that could be used to learn the math. The t3d one even does the csg wor=
k. I just need to plead to you: please: I need contributors now. I did ever=
ything I could in these last 10 years under free-software licenses: made lo=
ts of maps, made tons of 3d models, made textures, game code (QuakeC), engi=
ne code (C). I extended the engine to beable to address up to 4 million ent=
ities, I programmed procedural map generation routines that allow creating =
cities out of nothing. I modeled tons of buildings, with both interiors, an=
d level-of-detail models; so you can explore cities and not just go on the =
ourside of buildings. I modeled vehicles, added vehicles, programmed vehicl=
es. I added 200 wps, and building code so players can do whatever they want=
 in this 3d platform: from architecture, city building, town building, to f=
ighting eachother, or racing cars, helicopters, to putting out fires. I've =
made music for it. All free software licensed.
>=20
> I just cannot get contributors. Every single place I post a plea for help=
 the thing is banned and deleted.
> The only thing I've gotten is people trying to take down the project beca=
use they're mad I dared asked for file format help or for another programme=
r to join.
> Can you and the free software people help?
>=20
> I've asked "opensource" they sad "banned" and "scram"
> So I turn to you. It's in C. Your language.
> Please.
> I beg of you.
>=20
> I can't do these file formats alone.
>=20
> ----------
> Here's a ticket of the issue: sourceforge.net/p/chaosesqueanthology/ticke=
ts/2/=C2=A0=C2=A0 ( #2 Please help with .t3d and .unr loading (3d world fil=
e types) )
> Here's a git of the source code: sourceforge.net/p/chaosesqueanthology/co=
de-t3d_attempt_engine/ci/master/tree/
> And here is a tarball of the source code: sourceforge.net/p/chaosesqueant=
hology/discussion/general/thread/72c4ff80c1/f23d/attachment/darkplaces_work=
ingon_sep_06_2023_aug19cde_SOURCEONLY.tar.gz
>=20
> I started in model_brush.c , added in a new file handler: void
> T3d_Attempt_Which_will_Mod_OBJ_Load(dp_model_t mod, void buffer,
> void *bufferend)
> and got it printing the vertex info of the t3d stuff.
>=20
> I found 2 free software projects that handle (in C++) the two file format=
s, and I asked them for help but no response: (.t3d) T3d2Map(C++): github.c=
om/mildred/t3d2map (.unr) UShock(C++): sourceforge.net/projects/ushock/
>=20
> So I just need help here.
> I cannot do this part of the engine coding alone.
> I know I did other formats: but it was alot of hacking and they weren't t=
oo different.
> But here: it would take me years since I'm a hacker (at best) and not a p=
rofessional file programmer.
>=20
> Please help. Is there anywhere I can ask? Everywhere seems shutdown, filt=
erd, and blocked, and very very unfriendly to any C dev requests.
> Hope you get well soon.
>=20
>=20

Seems like you have a userspace application issue. This ML (LKML) is for
Linux kernel development, not userspace. But if you want to contribute to
the kernel, you can apply for Outreachy program (see [1] for the announceme=
nt).

Bye!

[1]: https://lore.kernel.org/outreachy/alpine.DEB.2.22.394.2310020741050.31=
66@hadrien/

--=20
An old man doll... just what I always wanted! - Clara

--P/Yz30KNoY+loJhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSEdRgAKCRD2uYlJVVFO
o9KFAP9RCXLR4KsY9VX+GPgbGk0SEd0fL/c4+57dXA0LHJDRpQEAmEQZY/Ri+wsM
w/W5k520vhqk5HGw82NjPOzseO5OjwE=
=6I9h
-----END PGP SIGNATURE-----

--P/Yz30KNoY+loJhM--
