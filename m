Return-Path: <linux-kernel+bounces-8552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C981B94C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3069A2852AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE0C55E52;
	Thu, 21 Dec 2023 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nls8uA/Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EB6D6D4;
	Thu, 21 Dec 2023 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so5488465ad.2;
        Thu, 21 Dec 2023 06:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703167595; x=1703772395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeYY+B/0an9doKVtx7kHfVX+n7t8supsqIk+dco+MIo=;
        b=nls8uA/YhhqZRnbAyD4lmr/DsUyI0fOW7UuFhYmrY/aaOpcfQzWHa66qpWOI9nVgME
         SCSThKCLh29eg8e9/GRQ05CCpw8qbWv2uQqwb7UB6lJ1m4ut6bpg/egwQtjh4fJ4kyFC
         nuFhcMO7fJLwju8NWw2cX2NYnbBLEoXPDMgeQA7GzRpypJTvhPhWED3pIxhuJp/s2uji
         GMkEwsxmgbpdbuzokpFkph33CrYeg1GNlIL7AfHcO93r2FKaPszlYOjFQ3KdvR1IifBQ
         1OjPn0XlWvf7Q6zpOSmEghYe4nmWmCKI/mY+LsT2odrnKPnOkFXEoexNLm6+y7N1wn/b
         PEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703167595; x=1703772395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeYY+B/0an9doKVtx7kHfVX+n7t8supsqIk+dco+MIo=;
        b=rnCeY+YVv1OAAfHC7uAIA+qnB9lMH1tV2mfLxCufjvToXqwxr5U6u9TH3oZodblIU6
         aPOlqkrNsSnMbDm8+T/8L9F3Tgh8gbpYemuXF7dkRBW3FLwDt5ugRcctUHC8iNA2UOhY
         qbTyIz+quC70wu6zZQ292MtsSSXJfbUDLUoEX8FyCysq9KB9lh3Csw4XSrH5AWDgGJV0
         V3CfiSRZXwPwFOgfchWMgd1Y+C2ViYxFmf25INdWrbwu5Qf3qLucQ8fbF/h4pAwiS0AM
         5661u2AOnFEKFgRkoztNFpf0kdTjH8GbWPhzDR9fjNYwrFin0NPPzTuM7puHx3CEXkD0
         xGow==
X-Gm-Message-State: AOJu0YyHQghrKHp4Rv9zRN2qqVmfaJpj+y0d1n6Gysmtmz6LWWeJPn4U
	9cgdAWiPFUeChUXkdq4OUsU=
X-Google-Smtp-Source: AGHT+IEaqrSjm0IZ1a6acVewPpBsKczPCHT9IPDk2tpoKnvcbLP5Yuo2cBtidGgtLaaCcCnZVwLsjA==
X-Received: by 2002:a17:902:cec1:b0:1d4:53b:c8ea with SMTP id d1-20020a170902cec100b001d4053bc8eamr722173plg.137.1703167594899;
        Thu, 21 Dec 2023 06:06:34 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ix2-20020a170902f80200b001d3f1ca06b0sm1671360plb.233.2023.12.21.06.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 06:06:34 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 521BB10206DCF; Thu, 21 Dec 2023 21:06:29 +0700 (WIB)
Date: Thu, 21 Dec 2023 21:06:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Karsten Keil <isdn@linux-pingi.de>,
	Karsten Keil <keil@b1-systems.de>,
	YouHong Li <liyouhong@kylinos.cn>
Subject: Re: [PATCH net 1/2] MAINTAINERS: Remove Karsten Keil
Message-ID: <ZYRGZInfXmIfmAF7@archie.me>
References: <20231221091419.11764-1-bagasdotme@gmail.com>
 <20231221091419.11764-2-bagasdotme@gmail.com>
 <2023122156-diocese-movie-3d75@gregkh>
 <ZYQYUgZrewi2Up50@archie.me>
 <2023122116-favoring-roulette-554f@gregkh>
 <ZYQgGxKOKqIe4TIL@archie.me>
 <2023122125-departure-squishier-95d4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="peM86azSLoLfqTfS"
Content-Disposition: inline
In-Reply-To: <2023122125-departure-squishier-95d4@gregkh>


--peM86azSLoLfqTfS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:53:36PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 21, 2023 at 06:23:07PM +0700, Bagas Sanjaya wrote:
> > On Thu, Dec 21, 2023 at 11:54:02AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Dec 21, 2023 at 05:49:54PM +0700, Bagas Sanjaya wrote:
> > > > On Thu, Dec 21, 2023 at 10:32:09AM +0100, Greg Kroah-Hartman wrote:
> > > > > On Thu, Dec 21, 2023 at 04:14:18PM +0700, Bagas Sanjaya wrote:
> > > > > > He's no longer active maintaining ISDN/mISDN subsystem: his las=
t message
> > > > > > on kernel mailing lists was three years ago [1] and last commit=
 activity
> > > > > > from him was 1e1589ad8b5cb5 ("mISDN: Support DR6 indication in =
mISDNipac
> > > > > > driver") in 2016 when he gave Acked-by: from his @b1-systems.de=
 address.
> > > > > >=20
> > > > > > Move him to CREDITS, as netdev people should already handle ISD=
N/mISDN
> > > > > > patches.
> > > > > >=20
> > > > > > Link: https://lore.kernel.org/r/0ee243a9-9937-ad26-0684-44b18e7=
72662@linux-pingi.de/ [1]
> > > > > > Cc: Karsten Keil <isdn@linux-pingi.de>
> > > > > > Cc: Karsten Keil <keil@b1-systems.de>
> > > > > > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > > >=20
> > > > > Are you sure he's not active?  It doesn't take much work to keep =
an old
> > > > > subsystem like this alive, last I remember, real changes were acc=
epted
> > > > > just fine.
> > > >=20
> > > > As for LKML messages, yes; he doesn't post any new messages since 2=
020.
> > > >=20
> > > > >=20
> > > > > Perhaps just don't send coding style cleanups to old subsystems? =
 :)
> > > > >=20
> > > > > I would not take these unless Karsten agrees that he no longer wa=
nts to
> > > > > maintain this.
> > > >=20
> > > > OK, I will send a private message to him asking for continuing main=
tainer
> > > > role. If there's no response from him by the new year, then it's sa=
fe to
> > > > route this through net tree instead (hence [PATCH net]).
> > >=20
> > > Why are you arbritrarily saying that "no response in 2 weeks, during =
the
> > > time of the year almost all of Europe is on vacation, means we drop
> > > someone from the MAINTAINERS file"?
> > >=20
> >=20
> > Because I'm impatient.
>=20
> Then kernel development might not be the best thing to work on as
> patience is required here.
>=20
> > Maybe I can wait for right timing to reroll once
> > Karsten agrees to remove his MAINTAINERS entry.
>=20
> That's up to Karsten, not you.
>=20
> Again, please relax, slow down, and perhaps work on something more
> technical, like actual kernel fixes?

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--peM86azSLoLfqTfS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYRGYAAKCRD2uYlJVVFO
ozyGAP0XcaEQNG9bvpBMWxVQSIG7yeRUDESyR/RgSsfYHGWS+wEA548W5hUxYiHm
fhnCJUKNLdB/n9K1C5tkWnWv2kReNQw=
=IUn+
-----END PGP SIGNATURE-----

--peM86azSLoLfqTfS--

