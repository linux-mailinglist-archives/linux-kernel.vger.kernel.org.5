Return-Path: <linux-kernel+bounces-45307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD0842E50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936091F24C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5364E71B58;
	Tue, 30 Jan 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="f8Ljt0gM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1871B25;
	Tue, 30 Jan 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648481; cv=none; b=Z/1hM8y8+B3nHgGfr3aDR9Bves+vRjALASh5pfyWqoqADMCnIvJYNu3HjyveC1m72smGFkInhXEtK/CGo1Hd+BEfMt2/iL4/VXY31Y8qgJDmQ3l+wxgJXs70r2aHz9xUHy7PUwr5yymOWtwMxdV0GBPE2qdZAMYMwrlNl9Xo0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648481; c=relaxed/simple;
	bh=UYzcU7g2ijd8oW1EgLiv1YFGLNuPEFEYN2+RM4twt44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rkDNzCRYEV1S0VMSHHh7a2P5Q4oQpecVKLk8XIbjdk0KTwfG2hP1cMw51J0wa09oPQMXO0CRQxiEuKOKQPc/LrzWKD2lRIv1nl5nJ+PauI9dXb00lPpR7VE2aaM5VZwrqXuWyd4lWxcM0nrjlCuc519YkJIXAmgv5unUQcB7Rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=f8Ljt0gM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8B85041A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706648479; bh=cWshhURW71jdHLyjOGrPTJgCAaNECwBWRc+9TQhQxho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f8Ljt0gMoNBjLSiYzaYEPCTl4gFEGxIh0o5CLnPZsuPSjrQxeBJNg8hDNxCVSmVX2
	 9B6KJZKFS3TZZKG85IocGTZWf40kVZWwArNKeN4QylrL8vXmou8/QxP/Z0f/zJbntY
	 XRmfBhTJej79xAwZA7Xd0aZaGEatsDrSGPdvoyBcbCv2sZhBVJJRPTv9nTngTvgxyC
	 Ca6nJD+DgDrMzLw8NUkRvvjDmbxes4Q0qWFRVp7LcchhFqpxKJdYie3tBxTgfwKFNX
	 Od8ZaorqhvLZwTq7pRpCRdllgOFCZLfAXmHV+6gGiFNYhY7MWF5Y6mRp/REVAzwv86
	 DxX+Gal6drR7g==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8B85041A47;
	Tue, 30 Jan 2024 21:01:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andrew Ballance <andrewjballance@gmail.com>, mchehab@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>
Subject: Re: [PATCH] docs: sphinx-pre-install fix-noto-sans-cjk on fedora
In-Reply-To: <20240124043918.31771-1-andrewjballance@gmail.com>
References: <20240124043918.31771-1-andrewjballance@gmail.com>
Date: Tue, 30 Jan 2024 14:01:18 -0700
Message-ID: <87o7d2a63l.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Ballance <andrewjballance@gmail.com> writes:

> fedora 38 and later changed the directory and package name that
> provides NotoSansCJK-Regular.ttc. this adds the new search path and
> suggests the correct package if on fedora 38 or later.
>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  scripts/sphinx-pre-install | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied, thanks.

jon

