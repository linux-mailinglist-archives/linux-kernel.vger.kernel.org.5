Return-Path: <linux-kernel+bounces-159552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42E38B302C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB54281D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1C13A416;
	Fri, 26 Apr 2024 06:17:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADE13A404
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112276; cv=none; b=CBhm+Iw/7ui2fNydoBq75fJqMVuFd9n0N7ec39HLOcSveGdZsmETkWBg4ZhD+mHA4+XEwwaOSTHwoV633VRjsL4Annb8rj5hY6CnD6hr6vOrXd8kR0BhHrDK6BEF8Eh399FfLtZuTlSgn7DO6nZ3URAHv6vksVPCDATZXJsF0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112276; c=relaxed/simple;
	bh=quehoQ6DdK+mQ9RBHc2jh07gWC1RMDRjLQT8IC7XHaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqZDuVvep2w++o2nLTW9bKbjVBCTopXY+bQ/cwkJBFTc0F0vbaJwAjOIppFSZgOipwit3lqa7SHb7gtZX+/bTC+BRH7p8eYM/pvIdfy1xrw2K5ukJNR61G5y2hiQshacUtrrIfEAnw8YHdIbNHSUhVSwNou98cN0iPMjzzIwCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s0Ety-0001Ls-K8; Fri, 26 Apr 2024 08:17:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s0Ety-00EOe0-4e; Fri, 26 Apr 2024 08:17:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s0Ety-0097PL-0C;
	Fri, 26 Apr 2024 08:17:42 +0200
Date: Fri, 26 Apr 2024 08:17:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: kernel@pengutronix.de, linux-pwm@vger.kernel.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-leds@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: pwm: Disable PWM when going to suspend
Message-ID: <yitqw57rdkr44ly32sxukxa2m4a6jm74upfxc74dmbklucl6kq@3ni7emsqgzx4>
References: <20240417144943.GA2399047@google.com>
 <20240417153846.271751-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="difcfriydj6k3jns"
Content-Disposition: inline
In-Reply-To: <20240417153846.271751-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--difcfriydj6k3jns
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Wed, Apr 17, 2024 at 05:38:47PM +0200, Uwe Kleine-K=F6nig wrote:
> On stm32mp1xx based machines (and others) a PWM consumer has to disable
> the PWM because an enabled PWM refuses to suspend. So check the
> LED_SUSPENDED flag and depending on that set the .enabled property.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218559
> Fixes: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED shoul=
d be off")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> On Wed, Apr 17, 2024 at 03:49:43PM +0100, Lee Jones wrote:
> > On Tue, 16 Apr 2024, Uwe Kleine-K=F6nig wrote:
> > > If you don't consider that suitable, I can create a patch that is eas=
ier
> > > to pick up.
> >=20
> > Yes, please submit it properly.

Gentle ping. Even given the regression was introduced in v6.7-rc1
already, I think this should go into v6.9. If you don't agree that's
fine, but then getting it onto next to queue it for v6.10-rc1 at least
would be great.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--difcfriydj6k3jns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYrRwUACgkQj4D7WH0S
/k5XXQf+Lk6n3RbWMZZNm8vnkZn09tLkBIs9ubRFmALUCL5rA7j63qNrJ3S3aqwr
B5N01uxZuj5urnyux+OrIhBzYind99dVKfuudU1u7Db6BZuzeh85oMHSdle/f3ie
y+amKsoRmr+bSMUmNIQnRVBcW2mz9x5IQE3JbMrIETWRTcxg8sL1M7tF4I6KyBGj
oyqWtNoxIPlck90C2IS3GG1oxuzAtItCTZRr5iORf6TjUc+LPIgoI71CaxDpHUZo
RQLpEMgBIa4PnTgZhlbAc/D4fLqP+s8Us44/3Xy0FHXCqttr6EGjJog0qFHrdd0U
iJ2o47qFORbDqEDYHKFOwfXWyuC1UQ==
=S8es
-----END PGP SIGNATURE-----

--difcfriydj6k3jns--

