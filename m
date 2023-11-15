Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE77EC339
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbjKONEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKONES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:04:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B082109;
        Wed, 15 Nov 2023 05:04:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc5b7057d5so60567175ad.2;
        Wed, 15 Nov 2023 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700053454; x=1700658254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkYOVnrNszXvWvkQGHx/ExOJXa42vN+162FNhiylr54=;
        b=Gu6Sz4bRazO9on9jC4CWuSiWuzi1mDnzSEB5TV2dEmBDip5OWoLITCus1C6eqyVeXR
         y8fcHyV/4KprUWyaibOoLMXKdcoIp6t+CiQoaX6uktQtrWA6Eh/wNpi3yzjxzzGme1gb
         0r5RU4iK94WLG7Q6SMWJ8ZJEp2da3sPiRB5AIqvyvksl7T2I9BhewPHtm7Ytcso2qHAX
         C4ZyusUrm5dXZQ0d6hqTTO9m2q50zEP5Xx6l7J8bLW9+l0QQOO03Pfys9/BP4qVP4wl4
         NadMqt/yI6cUgMt98/6vZL2ODBljZaXrvcT9bedAtJSEuQhZIabJ7DXIFOWOJZKqxGpM
         MWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053454; x=1700658254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkYOVnrNszXvWvkQGHx/ExOJXa42vN+162FNhiylr54=;
        b=I89TwYLCIL1fNdj1Y05i5B08+Sg2MDutHiu9gR/0Q3LQPxKonaRokZetoJD6og3BnJ
         oIEx5+Mr3H5qSkBt6tNc8lmI1lKyXlWv+Av7qPrrSV0kaRDZfBgeHmvjp7LrEha8Aaku
         XQm1o+sy29m2FXXc61uVd0kyJSvsjcKOHRXc1aeFF9x3J5oemNnSWiqiNx0duyFvhQjC
         DdyuVTVrB0TFmA7VgNZWBSUEdzhKiIrStqp/xmpsf+p59anYx8ewf1sRtJpHkts9SXKU
         9kP2sPxluaHuw0Y9NNpvUwDErH1BoX5UXZp1M64oQ5b4I6KyD+sR9f6Xo/WSwxh5DVrl
         v2vA==
X-Gm-Message-State: AOJu0Yx6mAjOC9LGG0PNIhEea5n85dksV0vuXp+09xySP5HIUFhsyrK4
        0VIK+ac1hcsggdDUHLb1+CV93IK0aqkKyA==
X-Google-Smtp-Source: AGHT+IFoJc5v2jLX5P6naZxuHnJGL8hluqhvmcPS71ADf+fwTIah/n7HHi6vjowFiwV9Es0U4e+6Hg==
X-Received: by 2002:a17:902:e88e:b0:1c5:6157:f073 with SMTP id w14-20020a170902e88e00b001c56157f073mr5749438plg.11.1700053454452;
        Wed, 15 Nov 2023 05:04:14 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001cc2c6cc39asm7327074plg.243.2023.11.15.05.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:04:13 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 2CD7C10D2CF4C; Wed, 15 Nov 2023 20:04:08 +0700 (WIB)
Date:   Wed, 15 Nov 2023 20:04:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Regressions <regressions@lists.linux.dev>,
        Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        Andy Gospodarek <andy@greyhouse.net>,
        Ivan Vecera <ivecera@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Anil Choudhary <anilchabba@gmail.com>
Subject: Re: sr-iov related bonding regression (two regressions in one report)
Message-ID: <ZVTByHx1HfYds_v-@archie.me>
References: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
 <32716.1700009673@famine>
 <0f97acf9-012d-4bb2-a766-0c2737e32b2c@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HhXcdjV1bC1Xdz0l"
Content-Disposition: inline
In-Reply-To: <0f97acf9-012d-4bb2-a766-0c2737e32b2c@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HhXcdjV1bC1Xdz0l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 06:50:26AM +0100, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> On 15.11.23 01:54, Jay Vosburgh wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >=20
> >> I come across LACP bonding regression on Bugzilla [1].
>=20
> Side note: Stephen forwards some (all?) network regressions to the right
> people:
> https://lore.kernel.org/all/20231113083746.5e02f8b0@hermes.local/
>=20
> Would be best to check for that, no need to forward things twice, that
> just results in a mess.
>=20
> >> The reporter
> >> (Cc'ed) has two regressions. The first is actual LACP bonding
> >> regression (but terse):
> >>
> >>> Till linkx kernel 6.5.7 it is working fine, but after upgrading to 6.=
6.1 ping stop working with LACP bonding.
> >>> When we disable SR-IOV from bios , everything working fine
>=20
> Makes me wonder if things have been working with or without the OOT
> module on 6.5.7, as strictly speaking it's only considered a kernel
> regression if thing worked with a vanilla kernel (e.g. without OOT
> modules) beforehand and broke when switching to a newer vanilla kernel.
> If that's the case it would be okay to add to regzbot.
>=20
> >> And the second is out-of-tree module FTBFS:
> > [... skip OOT stuff ...]
> >=20
> >> Should I add the first regression to regzbot (since the second one
> >> is obviously out-of-tree problem), or should I asked detailed regressi=
on
> >> info to the reporter?
> >=20
> > 	My vote is to get additional information.  Given the nature of
> > the workaround ("When we disable SR-IOV from bios , everything working
> > fine"), it's plausible that the underlying cause is something
> > platform-specific.
>=20
> Maybe, but when it comes to the "no regressions" rule that likely makes
> no difference from Linus perspective.
>=20
> But I guess unless the intel folks or someone else has an idea what
> might be wrong here we likely need a bisection (with vanilla kernels of
> course) to get anywhere.
>=20

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--HhXcdjV1bC1Xdz0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVTBxAAKCRD2uYlJVVFO
ox6sAP40u0SKVLzT4BNbDjtm94gpIOlXkZH3Ws+BPEiboL4k3gEApxdqq7NlgEAD
GyJzIx/ubZyOfPDwwwJIr67RSLUaZQg=
=OikB
-----END PGP SIGNATURE-----

--HhXcdjV1bC1Xdz0l--
