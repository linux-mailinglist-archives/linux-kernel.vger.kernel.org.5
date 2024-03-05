Return-Path: <linux-kernel+bounces-92155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23810871C00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABBA7B21DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A975B5A9;
	Tue,  5 Mar 2024 10:39:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADC5B5A3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635176; cv=none; b=YeeHZ2PPO/ae+2oqX1B0N/7e+E7gKTRiaA2aaBMFO7gNx54NtD6Bzst4eoZYSBEiLrP/0ROYtIcpTUpyZ898S7LBRgFEFDcQhGVUU5Z0jZuFNq5NmhtDVVFx/rXotZ1oEJliuhJ4agrfwSN2bR+Dyqj77gLW1inrVPllkuuUJXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635176; c=relaxed/simple;
	bh=xJC6jDGTZbfYNZLeIFZXozgT6kJjE2Q9dhe8/M+AlaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpIW4frXEqzAR6dtFYLxwGCX1Z4xEILzWGxnnmdCuleBn/4nueaqGab2tDVd0hAqD9+m4ZRJk+161PwYCVrUqD19iTCO6v34nKln0qY32n5D/etGxDI6NMoQvtJioelE4H3xpoRulTK2x/jGrpiWeuTJbf1rXw70IDYtZsDmR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhSCq-0005q9-Kv; Tue, 05 Mar 2024 11:39:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhSCn-004X6O-Dh; Tue, 05 Mar 2024 11:39:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhSCn-00005d-15;
	Tue, 05 Mar 2024 11:39:29 +0100
Date: Tue, 5 Mar 2024 11:39:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: William Qiu <william.qiu@starfivetech.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v11] pwm: opencores: Add PWM driver support
Message-ID: <isbszrmgdsipmlolzbhf2wlcen7hq4yre3titcrmzea7rvty3s@ugp6hsodvm4k>
References: <20240223084332.100410-1-william.qiu@starfivetech.com>
 <ZQ0PR01MB12534DB9109EA8AEA33A221B9F22A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxlbcuxknmfufojp"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB12534DB9109EA8AEA33A221B9F22A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--wxlbcuxknmfufojp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 06:12:23AM +0000, William Qiu wrote:
> Could you please help me review this patch series to see if there is
> anything that needs to be modified? If not, could you help me integrate
> this patch into the mainline? Thanks.

I know I'm behind on reviewing this driver. There are a few more and I
still have your patch on my radar. New drivers require a big effort on
my side for review---each revision takes easily >1h for me to comment.
When I find time to review, I usually pick the oldest on
https://patchwork.ozlabs.org/project/linux-pwm/list/ to reply. So as
long as your patch appears there, it's not lost.

So I ask you for some more patience.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wxlbcuxknmfufojp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXm9mAACgkQj4D7WH0S
/k70xAf+L/NjaLnO4btjhXBXfmOqh5Ri5vCe5ftI5y1i5oMovpEpAfMnPxJRWyEU
lMJBlyHRNbFQmsKxR/vbk63RIn0yV8nCYCVas29BUc6dQMPkkk59j9FDmPNB4bvr
4l3HQmHfqM7h/kLEhWpbNLZWBnE5jA+JxWLLGsjljArSmqZavQ0ozZ1fNEjTJZUn
mY9Du3E+GF+2nOZsIrZVJdGmIho6RL7n+CLydiqtX0Nzref06E7Ex5MQARoabMo6
9Dclkb91uhYxg8yO6kC+EdtfARNBxpXsql9N6p8MCFVKeFcy0O1pipyLMGmYXRJS
0QnUrgv5qOOMRW3EwP5v3PU5o1TkfA==
=j+NC
-----END PGP SIGNATURE-----

--wxlbcuxknmfufojp--

