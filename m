Return-Path: <linux-kernel+bounces-98953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFDD87818B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB98B22C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEBB43AAC;
	Mon, 11 Mar 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noDyMGWR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B042075
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167029; cv=none; b=dSTxFQAzVv7LlAnGnkCDaX79rVrqdQ62KrOS8HrQb81GQwX8hrE1CQWkwnt4uYVrtgwpGDBkjLIE6CAxWhIS7rns+RfzS5nlFmwQwxlBLPP7jIkqZcBgf5LFIg793iPuQuiqg2eu2fsllb/SgbXMGINEGT41+jzomJYdVVKoyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167029; c=relaxed/simple;
	bh=QDQ3mgpPUgCapF3eUZvCYBDqcxaMhh1YdjLllS/UtnM=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=cuigUYl1jL4aoIccBvsGnueK1noJQnGJFriwHftEvwMvXHJyf/pVuB3FQDrwcSSDGWO+E3tP5pZ1+FCPKpJY6dcPHqgsv2P4dnYjDKMpVIyVD/UbQm5c2HWi3dZslUJFmH8Bzpi2J2Dg05iWALkHJj3ytvzauvQ/umbHUQiUsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noDyMGWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E0C43390;
	Mon, 11 Mar 2024 14:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710167028;
	bh=QDQ3mgpPUgCapF3eUZvCYBDqcxaMhh1YdjLllS/UtnM=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=noDyMGWRaNHlX2SAIRkaJPRQXdmZ3q54z4Dt4h/hb92+JGu7LJA5i5eR329JzWY3P
	 AogOEnkGerfjVRiPoFW+yloqO8cR3tJ1yAzSFGb6oOzCYuqPPXHs6aR1QHEmBTfnzP
	 C49en5V7LFadI9xRgod9b3CNHHIRjR0TpalnmkoHetxWeC4REHqOJ0jfp7T0C/PpgM
	 7CduF2bqc57KHihthWWYbhsKdWLc1qIp/uhDtAvwflF4P1mA9sPzGQomzK69Vk5+IJ
	 c9BaiqNo0eTASff7z7epzeRed3Y9Yz3jon2GS0VhDMmt5BLxJbTEh9vUmj/kss4w7F
	 ojdtyGHl1O4uQ==
Content-Type: multipart/signed;
 boundary=29380c7dbc2480426013ef519e8e75fca3b8b1943dcb785ea5fe898a2fd1;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 11 Mar 2024 15:23:39 +0100
Message-Id: <CZQZM2NMDNGU.1O7L4KJFYGA18@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Aapo Vienamo" <aapo.vienamo@linux.intel.com>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: core: Report error if first mtd_otp_size()
 call fails in mtd_otp_nvmem_add()
Cc: "Mika Westerberg" <mika.westerberg@linux.intel.com>
X-Mailer: aerc 0.16.0
References: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
 <20240307130418.3131898-2-aapo.vienamo@linux.intel.com>
In-Reply-To: <20240307130418.3131898-2-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--29380c7dbc2480426013ef519e8e75fca3b8b1943dcb785ea5fe898a2fd1
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Mar 7, 2024 at 2:04 PM CET, Aapo Vienamo wrote:
> Jump to the error reporting code in mtd_otp_nvmem_add() if the
> mtd_otp_size() call fails. Without this fix, the error is not logged.
>
> Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")

Not sure this qualifies as a Fixes patch, I'll leave that to the MTD
mainterainer.

Anyways,
Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

--29380c7dbc2480426013ef519e8e75fca3b8b1943dcb785ea5fe898a2fd1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZe8T6xIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvsSDQD+LmhRjiSOY5riC0MuNIx9H6dvoiMun43b
7fxJYqB2/v8A/1b5xgKNYvveX26fDM80P7xrRKdT4Ev62AIjvgmCtFMP
=wkxZ
-----END PGP SIGNATURE-----

--29380c7dbc2480426013ef519e8e75fca3b8b1943dcb785ea5fe898a2fd1--

