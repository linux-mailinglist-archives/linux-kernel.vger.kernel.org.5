Return-Path: <linux-kernel+bounces-153128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A88AC9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D391C212F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4813C9CC;
	Mon, 22 Apr 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5Cn1ogH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080043178
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779628; cv=none; b=uIeOh/wt8SUOgqZ7ekxFUSbuhYi/J/kqhubPCbztqBmizGjvTxnoseQ7kxv9Xi5W6c0qtCrEpaXjXMp0vhYcvj72OHeXpzAZGRvubdevNvAa9f/waNtfQLy+zzAJLgDikeKpKnrr+aPtlEQ7edPzmnH3XLl7M8ts62TGtRPGX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779628; c=relaxed/simple;
	bh=8+CCJrCws3RT752Z9I+0nlUuqHVENz1nohjmsspboWY=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=klwcGXYpS4B8ZnkepR2JYeMhktEMwLmtZYsXYlsXE7d3QX/xh/BtFgtwFDI8XpXhQbR3OSU5P/fo5XybCbRtEeS3l80rw8YmQK0UsY4I3rGbl2RLwXAlF/zjEUFnQQ2DC5JOV15PKwsknekyOargMBOPFq9e2eUN7onr7MG41BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5Cn1ogH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC913C113CC;
	Mon, 22 Apr 2024 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713779628;
	bh=8+CCJrCws3RT752Z9I+0nlUuqHVENz1nohjmsspboWY=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=Y5Cn1ogHk6ZrbriQ5w/sBHkX/bPBzJBVFiF2rYrfe/ZINzfmae+qgeIIDVD+zbxqm
	 /ADuC2EomfM9nMOZ1Erld0+5eq2H7qKInVBsss6qqyOgASEfw4awERYt60yoNh5lyi
	 Ae8KMngzvnDeGk4SlKOiH2fGbSuKR7XZpMdHpG1ryTIrI9Mmu3mLpEcRGv37VR8mgx
	 12lYXKxWIr3X3jYpjQgI/oIJQlZybZ3lYyLxhOGWOwcZHMDeXvFg5PD2i9JBTiTBbA
	 zuG8ORam9YnJv6lJCk6o4C5OgU+gGAQ6uxEuoBhrdSSWOgZSczB7TWKoomN02iVOCA
	 nyKxLHgFhFYHw==
Content-Type: multipart/signed;
 boundary=cb134ca7a9f8e269b067b74597d138b5ec5c5ba6f747c56adefe89ccdc46;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 22 Apr 2024 11:53:35 +0200
Message-Id: <D0QK66M6GGD7.2ESAAEDMDOUUO@kernel.org>
Cc: "Ricardo Ribalda" <ribalda@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>
Subject: Re: [PATCH v2 5/6] mtd: spi-nor: simplify spi_nor_get_flash_info()
X-Mailer: aerc 0.16.0
References: <20240419141249.609534-1-mwalle@kernel.org>
 <20240419141249.609534-6-mwalle@kernel.org>
 <ea3b32a8-7a1c-4a32-beb5-acc6f6435954@linaro.org>
In-Reply-To: <ea3b32a8-7a1c-4a32-beb5-acc6f6435954@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--cb134ca7a9f8e269b067b74597d138b5ec5c5ba6f747c56adefe89ccdc46
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> 	if (name)
> 		info =3D spi_nor_match_name(nor, name);
>
> 	if (!info || info->id) {
> 		jinfo =3D spi_nor_detect(nor);
> 		if (IS_ERR(jinfo))
> 			return jinfo;
> 	=09
> 		if (jinfo !=3D info)

info could be NULL here. So "info &&", apart from that looks good.

> 			dev_warn(();
> 		info =3D jinfo;
> 	}

Pratyush, should I'll drop your Rb tag then.

-michael

--cb134ca7a9f8e269b067b74597d138b5ec5c5ba6f747c56adefe89ccdc46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZiYzoRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hq0QF/W5w0LJO/Tlly9UKjiQWmjTnpkfEPgTaQ
Tp+tPIGsjpj72mnmkuBX4/JHyRKMGEelAXwOghOr7t3XVLc8EW+UQdr3cd4WmZET
4jwa6114y252B2D2XwB3Xr0k8qnU+QELAQs=
=AUVn
-----END PGP SIGNATURE-----

--cb134ca7a9f8e269b067b74597d138b5ec5c5ba6f747c56adefe89ccdc46--

