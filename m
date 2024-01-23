Return-Path: <linux-kernel+bounces-36085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3EB839B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6DE286D07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506EF3B2A6;
	Tue, 23 Jan 2024 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qayLSBac"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC93A8F5;
	Tue, 23 Jan 2024 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046381; cv=none; b=SZmDiSZIrgneXKZJCbqhF/opbzpRpeE/aZDKIgf0l9t4OGzejZ1hASo+uVJfTgy/43AI3JA4iOX3tkXsmEO+2hLrllWF0vaFe2SHxi+dr0GcjmpslmAC2V76AAxFJGqUbJpCJR/07V42eVeTES6pRl5ygP3vHTIvS4tScCTZLxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046381; c=relaxed/simple;
	bh=KojkoHvSyEPj0/IRewwiGqslZRt2AKZhw6xtlG1Zfn8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DOE+5a3LPHcxWgCDtXw/NrtissE5KaomYr73qBqpqh5z2VGs/2N+hNzEzUlMnMDE1QEVvfCGLQRJOjhW91tT0rKNDsZl3FGDJaGPUP4BD11o8SAg2VMqHaM9Dh8bEuQbPc76igJat0a3y0NerV2sFzcVvW/tubN+jg1SAOrz6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qayLSBac; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (c-98-53-138-11.hsd1.co.comcast.net [98.53.138.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 36AC17A98;
	Tue, 23 Jan 2024 21:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 36AC17A98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706046379; bh=HPI8p2QRl4kGlKIQRh26wR6sCf+wAiwRF3Njhaehc68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qayLSBactxJVtDUoeQiCqnap39JvQUIaSgBdtiN6R7lqTyj1I1acdx6AW+BMv6R5r
	 PPo+XES7zSaKY9/KhtXLdYe6WTyEdfs4JIwDDNzZHJyXoCRhhvhl9zPk7lozPEtNpi
	 GxY6NhwGkmS3PLhVLyCoAAaIX/0s5R6wJNeeXjLNEro8NAzD7Io/1A2aDMas6i6mJC
	 cjqQnCxjymqYChsNKnnYfx6h4azhAE5uA8LqxMQzRPZApQGJvGSlJ7h3yHB7u1ikbu
	 30fpYZ+x0NjoonJ9TBRCnovC1JFsbw3dvZuyHGUfRMIAdmNRM5RgoRDbDUFWxydImJ
	 sn/kiOoq16vzw==
From: Jonathan Corbet <corbet@lwn.net>
To: Hu Haowen <2023002089@link.tyut.edu.cn>, ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/accel: correct links to mailing list archives
In-Reply-To: <20240118090140.4868-1-2023002089@link.tyut.edu.cn>
References: <20240118090140.4868-1-2023002089@link.tyut.edu.cn>
Date: Tue, 23 Jan 2024 14:46:18 -0700
Message-ID: <87jznzk9jp.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hu Haowen <2023002089@link.tyut.edu.cn> writes:

> Since the mailing archive list lkml.org is obsolete, change the links into
> lore.kernel.org's ones.
>
> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
> ---
>  Documentation/accel/introduction.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/accel/introduction.rst b/Documentation/accel/introduction.rst
> index 89984dfececf..ae3030136637 100644
> --- a/Documentation/accel/introduction.rst
> +++ b/Documentation/accel/introduction.rst
> @@ -101,8 +101,8 @@ External References
>  email threads
>  -------------
>  
> -* `Initial discussion on the New subsystem for acceleration devices <https://lkml.org/lkml/2022/7/31/83>`_ - Oded Gabbay (2022)
> -* `patch-set to add the new subsystem <https://lkml.org/lkml/2022/10/22/544>`_ - Oded Gabbay (2022)
> +* `Initial discussion on the New subsystem for acceleration devices <https://lore.kernel.org/lkml/CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com/>`_ - Oded Gabbay (2022)
> +* `patch-set to add the new subsystem <https://lore.kernel.org/lkml/20221022214622.18042-1-ogabbay@kernel.org/>`_ - Oded Gabbay (2022)

Applied, thanks.

jon

