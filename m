Return-Path: <linux-kernel+bounces-148843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADAD8A87FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195D6B23E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A40147C7F;
	Wed, 17 Apr 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQxnPZ3P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991338DEC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368757; cv=none; b=D+fPdCR7qoMogqKZVoKyA4zYwRHnS3J1uFGkvy27foZW8dbBlqSnJbNEKATKFaB39jyqHrwY4IiG4vC8oWeptaH2/7lecXSEakCLuXC758stnwJMCF9HZOP9Os1cEJS5NINa4ulNygVLvVrMuxmGrorSJer6JFtAh9SDx20pCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368757; c=relaxed/simple;
	bh=FkhLi0l+6ZQrGYmjsZ3QPjRP3VFib8PbMZ0d05h1nGI=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=Hr2EaNmcYah8U7y98iW7evwtPi0yK6RN/kt33l9oZRVkPKvY69PymgiUP3SAeTAm4gQv62ADisEJOL5K8xgDbIM9NPBTsxmWP13VdD9MEINASWbfUY7rrTh5h05l41m4ac2S9RumOKhoXEZMQouD1BTUNV34StCyowYNqBY6VNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQxnPZ3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA963C072AA;
	Wed, 17 Apr 2024 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368757;
	bh=FkhLi0l+6ZQrGYmjsZ3QPjRP3VFib8PbMZ0d05h1nGI=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=LQxnPZ3PuikwhLTTWXHWEnQH23jfeyk7M/Q93UwrJrwgmZS5j92AluZqIOfI2qOo9
	 o+N8cl/UXcwKhjUya76HH7QUzxR2RnT26VuiQNoS9dBDiU/b/MAKkk0nNOmxGNqorU
	 BkOzUQQ46Ct6nBA9Fu/hWZqgLax0q1LN02MEfhqJPppZN+ASa+hszvNxBbTRCS5pr9
	 zn9h54liEqJfIEbkV3KCtGgfxweL4TEoEtlnqnsoHFveN+2w88T8enxfhp4dQ/NCCI
	 9kowpUs5GRgZRyKLSwSz2XcavykqD9y8bXXJODYyDkMJ07plWMmY6u6G1VyXhX8JLX
	 NXSIvAm97ASoA==
Content-Type: multipart/signed;
 boundary=321d08e96716c0149393a1bb7ecffc24c14fc8e2fbca5068bc9efe4c8478;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 17 Apr 2024 17:45:51 +0200
Message-Id: <D0MIJ6FT9Q2J.3B75NFD9SOJ7P@kernel.org>
To: "Pratyush Yadav" <pratyush@kernel.org>
Subject: Re: [PATCH v1 3/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-4-mwalle@kernel.org> <mafs0sezk6rcr.fsf@kernel.org>
 <D0MH78KYG87L.ETRH24X6MK6X@kernel.org> <mafs0frvk6luy.fsf@kernel.org>
In-Reply-To: <mafs0frvk6luy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--321d08e96716c0149393a1bb7ecffc24c14fc8e2fbca5068bc9efe4c8478
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Apr 17, 2024 at 5:37 PM CEST, Pratyush Yadav wrote:
> BTW, -M and -C options for git-blame can help you a bit. They can detect
> moved and copied lines, and look for the original one to blame. From man
> git-blame:

I know, did you saw "So You Think You Know Git - FOSDEM 2024", too? ;)
Anyway, at least in netdev unnecessary code churn is frowned upon ;)

-michael

--321d08e96716c0149393a1bb7ecffc24c14fc8e2fbca5068bc9efe4c8478
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZh/usRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jeLQF8DbNQGNsJD35l7/QS+EQaMXqVzmNTxaNE
SzCYwDuZ5/RG+JuKK1c0htIiKn6ckJItAYDQ9znC2sNyH6Du70EKIN4C6yau1Xpe
ph6WBDJBx8emXDvlct5RiwPdVSIcQ4zdR1w=
=agYx
-----END PGP SIGNATURE-----

--321d08e96716c0149393a1bb7ecffc24c14fc8e2fbca5068bc9efe4c8478--

