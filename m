Return-Path: <linux-kernel+bounces-155006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B48AE43C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BEB1F2174D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BFC81722;
	Tue, 23 Apr 2024 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="OYBl3rA4"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8E7D3E6;
	Tue, 23 Apr 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872354; cv=none; b=kkrnyaEK5/6ML0tGDcm4a6jhinrApCVhIDrZuhgDikKQA1PKNK3nO/OUDzGRHsaX1diYTl0IP8yT3a0t93x/HuPFWCo4EzfIxAw+n/m5yqpxOvKJEUnAr0p+5WUkU7lTvvReIMkLeiJco4rv8DL5J2diXTKX7Lckzr3+Po9lCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872354; c=relaxed/simple;
	bh=EHK8LGGOba5Ls7MH+lKJT7LB4adD9mbKWZ8jV5fAUbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/eF75HcOjLWaXVm5wNUtXN3gkdsh3a8p5vkP67tei0Qdl7cR/9TLFaDmQ5IN5sTEL00zanm9LLU7QtzL986Q+Ch3uAOyK4O6BqrDD91HatWwW4gPGwTfCvHqV4iK2q66cpyRSnE++suRe5+HHkFRPzIhupahASgx/8yDASJnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=OYBl3rA4; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ED98A1C0080; Tue, 23 Apr 2024 13:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1713872343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYT6jJUSJy5wHOowMTeCZ3pp3Tmnao3IC/VvUAo2Hv0=;
	b=OYBl3rA4LQLGaPvpDvGoyAou52frnZRv8qUTpt62HjtQitHp9LXNvWcUvP32zyzj39R6yv
	2nStxD7L9S+yKLQSfmLFfojU+wgpycekvcJgvVeSGPYffHv6Ukoh2hu44tXp9QzyO8Pt9o
	BVa+vkNKuBif4ftpoGlXsqPlR8ZYFgs=
Date: Tue, 23 Apr 2024 13:39:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, yong.wu@mediatek.com,
	joro@8bytes.org, will@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 4.19 7/7] iommu: mtk: fix module autoloading
Message-ID: <Zied1/2cELhaQupG@duo.ucw.cz>
References: <20240422232040.1616527-1-sashal@kernel.org>
 <20240422232040.1616527-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+UxX/KApw3y0ssBB"
Content-Disposition: inline
In-Reply-To: <20240422232040.1616527-7-sashal@kernel.org>


--+UxX/KApw3y0ssBB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 7537e31df80cb58c27f3b6fef702534ea87a5957 ]
>=20
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.

This patch is queued for 4.19 and 5.15, but not 5.10. I believe that's
wrong.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--+UxX/KApw3y0ssBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZied1wAKCRAw5/Bqldv6
8t3gAKCGrYHwFMHP8GJXLn7d7BZRrWiYFACgnWZYqAPYYddh29p9HUpGKDbADuM=
=gPbY
-----END PGP SIGNATURE-----

--+UxX/KApw3y0ssBB--

