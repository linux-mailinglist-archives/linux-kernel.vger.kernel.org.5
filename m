Return-Path: <linux-kernel+bounces-4546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FED817F17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607111C22C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7550469D;
	Tue, 19 Dec 2023 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="zeuBa88q";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="pR0hDy50"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688E4426;
	Tue, 19 Dec 2023 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 62DAAC029; Tue, 19 Dec 2023 01:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702947311; bh=DXKTDlU/3ggaxpCA7PFEN3qYdi3PnWhgCPh7ujkXnls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zeuBa88qZfOpxn85WJOfE/jJhV98foy+EG8TNmmyyQ3JauyNrP6fltbPnBeCtSYvX
	 g0iEGUTtaIIVtHLgNNZjsCQLTCtx7fBdt6TmSYQvJAYuIVspuip2quKsbmqraZQc2a
	 FVmjfBU6esuluZlcubqK7/oBRutf6et76YvNnWsPp6Hztvgi3qtpa773tgcbs6QDzv
	 /e0wilvexFxjnt/J/8YNThJAhxaFvqVPN6/HRRNcRYZfu2kXt4SfMlYfAJt6HEFCt3
	 TIbAuyXdAAl4sbZh+HyEpkZG5IrTFRwi2Jzms0Tj7J9im65w58oZS6KfoN1ft4N00n
	 MWY8h5CpG4QoQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 73A8AC009;
	Tue, 19 Dec 2023 01:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702947310; bh=DXKTDlU/3ggaxpCA7PFEN3qYdi3PnWhgCPh7ujkXnls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pR0hDy506GBvxJNN44FwI3d76mKE8H8JV1pvxf1tpG0VNGM2YZ61Mqb4Ulh1ZMnSV
	 rBQD35Iji37xfXcOAJwjqJzKcwrB0L4tG8wCM269K+6XLQIj+kaA1wNc9bCIQexgis
	 1l4J2wpZ+zfVPb7A4Wd16+UDeSvKZti6McIGjPqGwIedhfPQQ9HEb/YOTJvZ/q9uFQ
	 8zgxvV8k438c70RsDxJoYDfjqZ7QdRkBmWyBp4M3CrKO0Y7wj3Uwow1amWcm0L2tr8
	 Ihe5NPp1il6Zbe8YCiDtULw/fuYI+I23gJCuMpBkWVrYxv/608fY8GooJV2JuMq3eA
	 ooj5v/MCg8BIw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id b0e52337;
	Tue, 19 Dec 2023 00:55:00 +0000 (UTC)
Date: Tue, 19 Dec 2023 09:54:45 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, Maxime Ripard <maxime@cerno.tech>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 5.10 00/62] 5.10.205-rc1 review
Message-ID: <ZYDp1XeCrTlaOrIF@codewreck.org>
References: <20231218135046.178317233@linuxfoundation.org>
 <CA+G9fYszCtMbbrurrjqpDzSa20ZX5mVdQ+RZv-KdiyLU4o5=0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYszCtMbbrurrjqpDzSa20ZX5mVdQ+RZv-KdiyLU4o5=0Q@mail.gmail.com>

Naresh Kamboju wrote on Mon, Dec 18, 2023 at 08:54:13PM +0530:
> commit that is causing build failure,
> drm/atomic: Pass the full state to CRTC atomic begin and flush
> [ Upstream commit f6ebe9f9c9233a6114eb922aba9a0c9ccc2d2e14 ]

I also had to fix up a few nxp-provided drivers because of this commits,
it seems a bit heavy-handed for stable trees when users can have a
couple of out of tree modules.

It's marked as a stable dep of fe4c5f662097 ("drm/mediatek: Add spinlock
for setting vblank event in atomic_begin") but that looks like it's only
because of the context and it should be easy to backport that commit
without the crtc atomic begin/flush rework -- what do you think?

-- 
Dominique

