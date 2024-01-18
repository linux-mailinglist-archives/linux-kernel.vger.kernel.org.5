Return-Path: <linux-kernel+bounces-29896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC3A8314D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB011C22123
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB128DB8;
	Thu, 18 Jan 2024 08:29:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9C28DB4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566556; cv=none; b=erAVgK79eTPT/hG0iLmflzndoibO9X2kjvzU6qoDeEaHLNoOi7fxkWahzeVw8tFsHFvnJY61maWaetzxEtBocPA0h5YBZY7rC1k/2d7Abx43fN7We7u5pgxJPPxoD3VCPWwn7yglNhCEPkTrxVTpuRwmKBjE8mE8EW1+9Ip2ybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566556; c=relaxed/simple;
	bh=2AYP5CD9AZz8aB6EdtcR9jZS/dHOeqWoSjb7AvRioso=;
	h=Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Mail-From:X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=XWlYiQ7M6lyc5tFZsQ8ptRKR096wdHTvEsnVaWCdySEWAqHlpkU4dj2aDGwIQ3/HxWbAr1e6+pc81clia1dqD3/NJiqEPPiuPAvg4SmvjTqsKODasLI3lMV/xVE0D9ohfAZLieIB4SubPEyQ1VEMVCklZxbcmn6YbDVVn1o5c0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQNlv-0005et-5z; Thu, 18 Jan 2024 09:29:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQNlu-000eGH-My; Thu, 18 Jan 2024 09:29:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQNlu-002Gq5-21;
	Thu, 18 Jan 2024 09:29:10 +0100
Date: Thu, 18 Jan 2024 09:29:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Young <sean@mess.org>, kernel@pengutronix.de
Subject: [GIT PULL] pwm: Changes for v6.8-rc1, take 2
Message-ID: <sbjugedbn2pyqcskybmxj2evju74ldyiwugnjpu4u5ln7ufrfj@m7hi2ie63aai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oel4hbh7smqzfdfw"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--oel4hbh7smqzfdfw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

the following changes since commit 7afc0e7f681e6efd6b826f003fc14c17b5093643:

  MAINTAINERS: pwm: Thierry steps down, Uwe takes over (2024-01-12 16:40:34=
 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/ukleinek/linux tags/pwm/=
for-6.8-2

for you to fetch changes up to 9320fc509b87b4d795fb37112931e2f4f8b5c55f:

  pwm: jz4740: Don't use dev_err_probe() in .request() (2024-01-12 18:25:05=
 +0100)

The commits are in next since next-20240117 only, but they are small
and obvious enough to qualify for inclusion IMHO.

Please pull this for v6.8-rc1.

Thanks to Sean for his contribution to this PR.

Best regards
Uwe

----------------------------------------------------------------
pwm changes for 6.8, take 2

The first commit fixes a duplicate cleanup in an error path introduced
in pwm/for-6.8-rc1~13.

The second cares for an out-of-bounds access. In practise it doesn't
happen---otherwise someone would have noticed since v5.17-rc1 I
guess---because the device tree binding for the two drivers using
of_pwm_single_xlate() only have args->args_count =3D=3D 1. A device-tree
that doesn't conform to the respective bindings could trigger that
easily however.

The third and last one corrects the request callback of the jz4740 pwm
driver which used dev_err_probe() long after .probe() completed. This is
conceptually wrong because dev_err_probe() might call
device_set_deferred_probe_reason() which is nonsensical after the driver
is bound.
----------------------------------------------------------------

Sean Young (1):
      pwm: bcm2835: Remove duplicate call to clk_rate_exclusive_put()

Uwe Kleine-K=F6nig (2):
      pwm: Fix out-of-bounds access in of_pwm_single_xlate()
      pwm: jz4740: Don't use dev_err_probe() in .request()

 drivers/pwm/core.c        | 2 +-
 drivers/pwm/pwm-bcm2835.c | 4 +---
 drivers/pwm/pwm-jz4740.c  | 7 ++++---
 3 files changed, 6 insertions(+), 7 deletions(-)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oel4hbh7smqzfdfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWo4VUACgkQj4D7WH0S
/k7FqggAqzHss9G/SniAytw4Kh6MuU+Dzu55g71yItXx1o2XK21pgfCwsiGdGBBS
1xXuHBaluaj92NceWK8/ID1ikLhvJJSCN5AyeOrow+JOru3RbiCZEg14LC0enb9s
3cXB/BduiEvSxzS6iPdACxMFtn0o02yYVMWWM65YcFRej05dYP2fVLWUD6o63JTE
O3e6b9Iac3LFFY3Vd/Hhrz9q/lJtjv6RgL0UJ+J610r775zURq+rp4N00z9wKQHq
eq16Be4ONHfida9pTlH1g882wIOQaejChCem9BTYugiGFSw4CT6TmsY5facBYsA6
tj9pw07DQSoljyini9JBDnRll68D0A==
=mReT
-----END PGP SIGNATURE-----

--oel4hbh7smqzfdfw--

