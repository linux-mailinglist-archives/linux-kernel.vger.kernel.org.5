Return-Path: <linux-kernel+bounces-85749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A8986BA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644101F252D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E072911;
	Wed, 28 Feb 2024 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dxUVRkZp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED086241;
	Wed, 28 Feb 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157444; cv=none; b=HKzOOLLqbKIuiz84FiPB5GpuaU3ptWpJ/pTg5p1mccY5qByCDTYKYOiDNLEW9gwCT+nPrfHJ0PIU/xjmT9tak4bSFNks2YZ5kcXMJcZmrBmSYMS+bpxPKe7g+cQpsTugKqZHzqyPOoTe/OTImMLPCcb28/QX4KsL0wfRJ2kzH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157444; c=relaxed/simple;
	bh=1+LVLjOpDU7K/uDlhk0mGw5Kdy7KZzXFjgIZnDyaAew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2fj+dhO5yNtXkloK1devYwyYYTt+E8RpTmxFxu2jxg5PIBM4w0kLzlBucvkbanxglTLErJnRI3gGWgtxKy9hsMxRWvAKCzowAa9qTCDELGMf6SWBYbVrvNM2Ufu1QGPjip1UZ2g2S8xBPrAIh91w06lyI5Ox+VvfjWeHq+E2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dxUVRkZp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 394E1418B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709157440; bh=DO5e71RdTX5yUtcfDd+c4uOig1miJfhV0O+dktJFG1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dxUVRkZpaECQw8FDTWr//PM0MbQcGua0rXo1i2RpfOg0OFNM1sBN2VIFLkow6V+yK
	 9dbwd6yXwx0gRV0fpj+A4KUVKQi/4fNaxob9Tv4WKGt0b6tk2QVcD7bckWP6Wz8AL+
	 92vjQoT6nDPMomFH24YYXNGpUeL5zKj5S6HJ+vGcLByQ18LH4vyddkcCWkgyzMclIH
	 l1IW7Uqye+8Z9XHCThRr1EUVe49NoP6ABrnlSKNl2mtMzgg5FdtdpQdMZMcIJ61HPP
	 jMPNFetu60PQABmDiSBnHA+bOqif1H/+u0kR8JJGRil3MuRGVZX2bIv6cn1asyckOw
	 KY8QdtUa7uuGg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 394E1418B5;
	Wed, 28 Feb 2024 21:57:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] docs: submit-checklist: structure by category
In-Reply-To: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
References: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
Date: Wed, 28 Feb 2024 14:57:19 -0700
Message-ID: <87h6hsp800.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> While going through the submit checklist, the list order seemed rather
> random, probably just by historical coincidences of always adding yet the
> next point someone thought of at the end of the list.
>
> Structure and order them by the category of such activity,
> reviewing, documenting, checking with tools, building and testing.

So this is clearly a step in the right direction, so I'm not opposed to
it.  But I do have a couple of thoughts:

- This document is old and unloved.  Its age shows in a lot of ways
  (wmb() rather than the sorts of barriers that are socially acceptable
  in 2024, for example).  It makes no mention of the CI systems that
  should get their say for a lot of subsystems; nor does it mention the
  subsystem-specific maintainer profiles that should also be
  consulted. And so on.  It needs a lot of work rather than a
  reshuffling.  (But, as I say, the reshuffling is an improvement, so
  I'll take it).

- It's a bit of an awkward fit with submitting-patches.rst.  Someday
  we'll have a set of coherent docs, maybe.

Anyway, I'm done grumbling now...:)  I'll look forward to v2 -
preferably soon; I have travel coming up and may need to cut things off
for 6.9 a bit earlier than usual.

Thanks,

jon

