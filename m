Return-Path: <linux-kernel+bounces-58792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7876B84EBD4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792DF1C2415F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CC050A6C;
	Thu,  8 Feb 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JQb7KLnG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4350A80;
	Thu,  8 Feb 2024 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432168; cv=none; b=au2ECU9PD0ZML/xl/a/14Jr0lEwRvN/C/VuR0Esv+hPGt8DyRxfc9y0qyBksI1UuB0AMNvdIzZb0wESvHpbKrF3ATBlmWQsLVDTYnKg8vT6HsmMCJtsjS/dUBGaZpVghA+y5CdJ+4vyBMpSEAXP3areDtGGtrQSJeXkCadHv3Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432168; c=relaxed/simple;
	bh=tPopddPokWzvKTDXNmXGYkQ+NQBNOktakJhneyDUziE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+oV3sgI0oKs/dc/4oZFd+98EwNLJcx+NsaKOTRXfIpflDzNO13lupNKSOJ/ognBpdgJf0CtEAKfOBxsCLNf0rbKGezpi7wFNi1R9vD12F93vo+5Y5XB/QUIclZ5wwG905acZwbyDEyKGsKVQAYuy1fGfJGA4jVG6kB83eNvnYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JQb7KLnG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1A64E45917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707432162; bh=jydrZ40GisSC4rzzPCfj/cTMoaX/disrkf3oXpumN5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JQb7KLnG/BIN/1oF3g82A9o7bGHz93JjIUYI0YaKwqiZToc6Qb68F2tdSNm3svIyv
	 wSBiKc8dpe7QcAqlWYyNIFroUdNnaZLDvvKsVkSuKLLIzbrabeQYObtBe/9ARr8uy4
	 +d0K4SuaA7ui1cwEtkr23l9xtIpaSM9n1dcsIodj8yPqoBB7c61/KZhoAAs74cOjpk
	 1FiCWDiOH8yJTuGJlM0pPz59wMowbOMSgLR/KPeMTb43WnlSj4PWV1A9eYa94nCICD
	 e5JY+FiYXl0VBokUEFKe1L8k9A1lH96Oh0aOjfTy1xBpf5AzOloK45JTPz92/mGBc0
	 9lcWunse18pWA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1A64E45917;
	Thu,  8 Feb 2024 22:42:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Vincenzo Mezzela
 <vincenzo.mezzela@gmail.com>
Subject: Re: [PATCH] docs: staging: fix typo in docs
In-Reply-To: <20240208162748.111120-1-vincenzo.mezzela@gmail.com>
References: <20240208162748.111120-1-vincenzo.mezzela@gmail.com>
Date: Thu, 08 Feb 2024 15:42:41 -0700
Message-ID: <87r0hmfuhq.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vincenzo Mezzela <vincenzo.mezzela@gmail.com> writes:

So your fix is fine, but I need to point out a couple of things with the
changelog.

> This patch resolves a spelling error in the documentation found
> with codespell.

If you look at Documentation/process/submitting-patches.rst, you'll see
that changelog text should be phrased in the imperative mode; no "this
patch".  I tend not to be too fussy about that, but some maintainers
will reject a patch out of hand for that, so it's a good thing to learn
to avoid.

> It is submitted as part of my application to the "Linux Kernel Bug
> Fixing Spring Unpaid 2024" mentorship program of the Linux Kernel
> Foundation.

This is interesting (I'd never heard of the Linux Kernel Foundation),
but it's not really relevant for the kernel development history.  If you
want to put this kind of information in a submission, put it after the
"---" line so that it doesn't end up being committed with the patch.

> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>

I have gone ahead and fixed up these things and applied your two
patches, thanks.

jon

