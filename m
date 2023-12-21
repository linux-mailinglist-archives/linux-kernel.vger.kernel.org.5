Return-Path: <linux-kernel+bounces-8276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9881B4D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801CF1C235F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48816E2B0;
	Thu, 21 Dec 2023 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0rqv1YD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF236BB3D;
	Thu, 21 Dec 2023 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3e2972f65so2766495ad.3;
        Thu, 21 Dec 2023 03:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703157792; x=1703762592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iurPx6U1Yq+NZr3UnEVxu22VONJz6nR4G9rGokJKtfI=;
        b=c0rqv1YDPQQkIOq2WVrS0ll7SYfRhXpKkU4dq8CIGijAiL6DATbORglgiJmRMC9Sh6
         gS7L+hF735IEUZ03YKm2jVTx2oD2w/u+eLPt6vUvx1ERFOhPFKdTBp21BEFzQN01FemJ
         cRw1MfVokkK59mEQGT9RTXm77yX8wMpxQjwiOHDi3b1A/c8lAT3GKdPvkMyExLb9Prnp
         L14sAnbZ42si5kXlcqYq/sjDf7gt61RxpNsAsylSg/zUkG1Tak9b1I9PgC2PbXs0oEgp
         pdKkqFlJkd5a896iXimXL7hZ6Ac3b7BJcUDnr6ZTTyw8CDnUrauLx1DXAmyTA9YfnAyA
         kcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703157792; x=1703762592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iurPx6U1Yq+NZr3UnEVxu22VONJz6nR4G9rGokJKtfI=;
        b=ulfuYX+Dr1G+WC0pC0okK45ycZbvqMZszk7p4zkU+HJ/gYgmyHs2mxG7F8fMzA4hYn
         yxuVR/NqXCikrqBlnEAOmimO4bwHjLGriTeeKX3gIm5GcWv7bJvqztrCQfQ7ngWJJk/a
         kiJHzAvrUMAYg9CRnNY9o6lFnTOoeNt+q82dgyHy0tloHbKOZ0jgCv0CK2q0BugWMQ1I
         LtevQj6XQ1SQdTuBVAZi+9is9Ap3EvK1xwvOsTGlcuiBxCvGOJzNWwiZLGpDyYAYDaID
         SDJNUWusI719QmkjiT2w9LFtT8of6dIoTADaWa8b+byEbQv9PuOxMDsTyEENJgX9h1FK
         fZ8A==
X-Gm-Message-State: AOJu0YzwoDso9qiCJMf/LtwcttkqRipqOJnl3G5LxFx9X3ScV35nHL9g
	PG+zAuzg+aSE0Y/oNoMNR0M=
X-Google-Smtp-Source: AGHT+IExJqNXn7XmZ803oCoArKhVQWyZmpB8PHbShkKvYBOvRSlQv57Xx7zYUNX6P4EjV6J0PZjwGg==
X-Received: by 2002:a17:902:684c:b0:1d3:f285:15a5 with SMTP id f12-20020a170902684c00b001d3f28515a5mr1727435pln.35.1703157791960;
        Thu, 21 Dec 2023 03:23:11 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170903429600b001d1cd7e4acesm1410398plb.68.2023.12.21.03.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:23:11 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id E149C1026AE88; Thu, 21 Dec 2023 18:23:07 +0700 (WIB)
Date: Thu, 21 Dec 2023 18:23:07 +0700
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
Message-ID: <ZYQgGxKOKqIe4TIL@archie.me>
References: <20231221091419.11764-1-bagasdotme@gmail.com>
 <20231221091419.11764-2-bagasdotme@gmail.com>
 <2023122156-diocese-movie-3d75@gregkh>
 <ZYQYUgZrewi2Up50@archie.me>
 <2023122116-favoring-roulette-554f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZMxuX3fRkHidytpf"
Content-Disposition: inline
In-Reply-To: <2023122116-favoring-roulette-554f@gregkh>


--ZMxuX3fRkHidytpf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:54:02AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 21, 2023 at 05:49:54PM +0700, Bagas Sanjaya wrote:
> > On Thu, Dec 21, 2023 at 10:32:09AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Dec 21, 2023 at 04:14:18PM +0700, Bagas Sanjaya wrote:
> > > > He's no longer active maintaining ISDN/mISDN subsystem: his last me=
ssage
> > > > on kernel mailing lists was three years ago [1] and last commit act=
ivity
> > > > from him was 1e1589ad8b5cb5 ("mISDN: Support DR6 indication in mISD=
Nipac
> > > > driver") in 2016 when he gave Acked-by: from his @b1-systems.de add=
ress.
> > > >=20
> > > > Move him to CREDITS, as netdev people should already handle ISDN/mI=
SDN
> > > > patches.
> > > >=20
> > > > Link: https://lore.kernel.org/r/0ee243a9-9937-ad26-0684-44b18e77266=
2@linux-pingi.de/ [1]
> > > > Cc: Karsten Keil <isdn@linux-pingi.de>
> > > > Cc: Karsten Keil <keil@b1-systems.de>
> > > > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > >=20
> > > Are you sure he's not active?  It doesn't take much work to keep an o=
ld
> > > subsystem like this alive, last I remember, real changes were accepted
> > > just fine.
> >=20
> > As for LKML messages, yes; he doesn't post any new messages since 2020.
> >=20
> > >=20
> > > Perhaps just don't send coding style cleanups to old subsystems?  :)
> > >=20
> > > I would not take these unless Karsten agrees that he no longer wants =
to
> > > maintain this.
> >=20
> > OK, I will send a private message to him asking for continuing maintain=
er
> > role. If there's no response from him by the new year, then it's safe to
> > route this through net tree instead (hence [PATCH net]).
>=20
> Why are you arbritrarily saying that "no response in 2 weeks, during the
> time of the year almost all of Europe is on vacation, means we drop
> someone from the MAINTAINERS file"?
>=20

Because I'm impatient. Maybe I can wait for right timing to reroll once
Karsten agrees to remove his MAINTAINERS entry.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ZMxuX3fRkHidytpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYQgGwAKCRD2uYlJVVFO
o+uUAQDfsKMoaQFtaOT6DpcRB+FMAkidQGmnQpY0Aq69jjG64gD+JIUIecWepwwo
X4o7niyGHz992tTPL+VyT7bt9eZfIQg=
=BYT9
-----END PGP SIGNATURE-----

--ZMxuX3fRkHidytpf--

