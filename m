Return-Path: <linux-kernel+bounces-8243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C812881B459
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B541C22E22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE2A6D1DE;
	Thu, 21 Dec 2023 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4XqYdcv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2506A02C;
	Thu, 21 Dec 2023 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d2e6e14865so4481095ad.0;
        Thu, 21 Dec 2023 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155799; x=1703760599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4N2RE6AvTzpax8v3fM5XZeoxUYCbygA0gYkrnpQaZuA=;
        b=J4XqYdcvwQiBW/wqqCzmONM6McXGJpbhsfNq2BeQNKILYOxHJEQ/v11GEgtRW67Ghp
         QUiYAs8aDRgJCHEqJEJ3RVHlEWwQR5/b+WcWGgmOgqqxkxnA+7jMHT3oYNHfHOSTmoiE
         fzXNHdXRe9t6AgnLIgHhBkRtP6wrgnaOS7pGRjWRO9PxR8usf452hoNoBpoST7GAnJ0D
         0/lWxew48bPtzrVyvgVCekXK/3s7QS4z1BQqTp5vgnxpVJ//M2uz0jPzZCtVru888ZPH
         QCGNo7ejrmL/no/PvIyxxZvZTKrVh2EXdjsYZKHqn5UHUPiFZnBE99gv/l5oERsATldH
         IINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155799; x=1703760599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N2RE6AvTzpax8v3fM5XZeoxUYCbygA0gYkrnpQaZuA=;
        b=PbyWI+9+5Y4qUdJObm89AqtXfSMhU3mGd9WX4BA8ydVqYGxUXGDlO8jRcVrfn5l8xW
         VS3oN5+4Bdu1pX+bgyiaTbVcm90hBURjFm690XOk130rBBTn4imI5PQqJn0HephjRAd1
         SoOmuKeoSP0XoaS72H/q7hubMxEdaB1IW4qu+dcnsM8/PBXfWMfBV+Z51twMQgKtLE17
         /FIUOacPzlkybUg0xb555Xie720sJ2apoe/i5vzdKmDGQY0Cho5vb7aF3SgW3VEmwedP
         Udd62mWnQTSr5if480u0EYAa2HcUJZkXmOvritTD8WVPpHUQ4riBykK62Kk+Iuqm9H4W
         92pQ==
X-Gm-Message-State: AOJu0YyJI+90/I8ht7AsqzTp4uPFdr/MH62siohGTRRpMmTMMWcLI1Xo
	8o1UjrZghjq02/wT7kfKvvA=
X-Google-Smtp-Source: AGHT+IHC0clJbYsgR3ZfoFMNQ9eOgk1PTWwZbhRHnRtS1TdPoI8n7SNRoFsLB3+Pl4pwpKSnAb4aMQ==
X-Received: by 2002:a17:902:d509:b0:1d2:fa24:2266 with SMTP id b9-20020a170902d50900b001d2fa242266mr12567233plg.6.1703155798908;
        Thu, 21 Dec 2023 02:49:58 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090264c800b001d1cd7e4ad2sm1348515pli.125.2023.12.21.02.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:49:58 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 2A7791025E0AC; Thu, 21 Dec 2023 17:49:54 +0700 (WIB)
Date: Thu, 21 Dec 2023 17:49:54 +0700
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
Message-ID: <ZYQYUgZrewi2Up50@archie.me>
References: <20231221091419.11764-1-bagasdotme@gmail.com>
 <20231221091419.11764-2-bagasdotme@gmail.com>
 <2023122156-diocese-movie-3d75@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vTDxja+sUVdToaj8"
Content-Disposition: inline
In-Reply-To: <2023122156-diocese-movie-3d75@gregkh>


--vTDxja+sUVdToaj8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:32:09AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 21, 2023 at 04:14:18PM +0700, Bagas Sanjaya wrote:
> > He's no longer active maintaining ISDN/mISDN subsystem: his last message
> > on kernel mailing lists was three years ago [1] and last commit activity
> > from him was 1e1589ad8b5cb5 ("mISDN: Support DR6 indication in mISDNipac
> > driver") in 2016 when he gave Acked-by: from his @b1-systems.de address.
> >=20
> > Move him to CREDITS, as netdev people should already handle ISDN/mISDN
> > patches.
> >=20
> > Link: https://lore.kernel.org/r/0ee243a9-9937-ad26-0684-44b18e772662@li=
nux-pingi.de/ [1]
> > Cc: Karsten Keil <isdn@linux-pingi.de>
> > Cc: Karsten Keil <keil@b1-systems.de>
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> Are you sure he's not active?  It doesn't take much work to keep an old
> subsystem like this alive, last I remember, real changes were accepted
> just fine.

As for LKML messages, yes; he doesn't post any new messages since 2020.

>=20
> Perhaps just don't send coding style cleanups to old subsystems?  :)
>=20
> I would not take these unless Karsten agrees that he no longer wants to
> maintain this.

OK, I will send a private message to him asking for continuing maintainer
role. If there's no response from him by the new year, then it's safe to
route this through net tree instead (hence [PATCH net]).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--vTDxja+sUVdToaj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYQYTgAKCRD2uYlJVVFO
owYLAP9jcvHw7NMOSzovxwxjoUi/bpB1EK0qoM6z6CNZjGfdGAEAs5rTbKJZHo9P
NW7yJNyW95AR3T94fVPUBioTGiyjsAU=
=PYnq
-----END PGP SIGNATURE-----

--vTDxja+sUVdToaj8--

