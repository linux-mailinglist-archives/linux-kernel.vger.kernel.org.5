Return-Path: <linux-kernel+bounces-45269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3E842DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8041C23E94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4379DDC;
	Tue, 30 Jan 2024 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FY8eqXAx"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032479DCA;
	Tue, 30 Jan 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646711; cv=none; b=L9GvrxUW0OYVEKP+yA4x3hdkNIkyoCfqHdjF4w3O9hUyupFK03aA6unLV6tQv+vXEDN+uiAv8SoDUnVn3REqokxK1ToWUc8fGGWQzuGq0NYr6BTz/xSg1dMtGCwk2Uw9sCUVNEjHsxUuQxAr1feZwcZK9E33FPtTclhlL1+HvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646711; c=relaxed/simple;
	bh=LOP+6Gd8XzSZncwRf7uGMAG0j2Ql64OEcnAO+AqFH8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KHs26priTw032ZQks6zeD5XnamxGAhH1miQqjdY7CWvzARglp0u78MD+bwN670f2htTl7zoUR4Q/t3B/3OXdOkjzJFKRRupCf2QG1s1puuYctCtYio6kB12lUgdyS4m+BwE/XpL2TlorjBHklG84CgW3f6r6pnUoQQNrUyEtil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FY8eqXAx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 33FB641A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706646709; bh=EDJoJIFoiaWQo8LexHsdvIE4pZPld1QgS2DhtQSIQ2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FY8eqXAxH813hKcE8MPW5zA9a5xhZm0OSkdFqVn+CrIE21aVr4ep3/5/bbLPbwm5K
	 rUj0ALrqZx0pKXMes1WafO/n2enLXwkfYlrwzCIZVpkSqw53liR5FnPxRd3VRTfEzd
	 4SbNbJ7ikXRYqV/0c8yVXzrxxw4zuElC6cmDqvgnkcTp+nuN8ajcgdlPGrsObS4j9X
	 jPixq8zKDm0RH6qtBGsFn/MZk9sZiSCfI4a7Onin9aZqY/0w2Zl0+QjHdheLdy5/j0
	 ybLvrlEsO0ac39xiSTXDlcLCJWQmUkO+KeMfqMAUbLnmkL7M0xC9qIs1i1r4+s3IEk
	 NAkpQ66r2uH4A==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 33FB641A47;
	Tue, 30 Jan 2024 20:31:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Randy Dunlap
 <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] doc-guide: kernel-doc: tell about object-like macros
In-Reply-To: <CAKMK7uGQqH7Y7bnNb=zeKkLyavtoJBpGJxwptBBUSqsYGdFEtA@mail.gmail.com>
References: <20240107012400.32587-1-rdunlap@infradead.org>
 <CAKMK7uGQqH7Y7bnNb=zeKkLyavtoJBpGJxwptBBUSqsYGdFEtA@mail.gmail.com>
Date: Tue, 30 Jan 2024 13:31:48 -0700
Message-ID: <875xzabm17.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> On Sun, 7 Jan 2024 at 02:24, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Since 2014 kernel-doc has supported describing object-like macros
>> but it is not documented anywhere. I should have required some
>> documentation for it when I merged the patch. :(
>>
>> There are currently only 3 uses of this (all in DRM headers, in
>> include/drm/*.h).
>>
>> Add object-like macro kernel-doc documentation now so that more may
>> know about it and use it.
>>
>> Fixes: cbb4d3e6510b ("scripts/kernel-doc: handle object-like macros")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>> v2: Previous attempts to use kernel-doc were for data definitions,
>>     not macros, so remove that comment.
>>     Remove a duplicate word in the patch description.
>>     Add examples.
>
> Randy pointed to this in another thread and also mentioned that
> function-like macros are already documented, so this also has my
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

OK, I'm slowly catching up with the world...I've applied this in favor
of Daniel's version.

Thanks,

jon

