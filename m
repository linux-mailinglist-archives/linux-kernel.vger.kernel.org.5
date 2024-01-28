Return-Path: <linux-kernel+bounces-41549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D383F455
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 07:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA631F21865
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3424D52A;
	Sun, 28 Jan 2024 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vdizl39s"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162098BF7;
	Sun, 28 Jan 2024 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706423214; cv=none; b=TI4MQQy3gKqoJzvtWzsyPpoZLAdleloTauq6Cn6QAr8OhLwNceknuuGY0O+M4XtSSo+SLbibsn/QZcuoiM0evFCjh06lHTGi1SYsANpJWcTzXZL6jjFh//8S88o/M7mo6PthIUQmd1TPHer/K1HiIYvbzuF/xbYajB7mO4PWRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706423214; c=relaxed/simple;
	bh=u06AxDE/ERNHphJgllEbxmKf0TouXDyp3C/4i66D+lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGfIdagKuXajRN+9hSY25unMcZPn4dpaTyrOOz19AczQKdQBj0dwsYj7elHwgNnn2mHXjRnzUjb4ryDv33RM6WO2XyZjGTtH1e1zODzplJwkzCgmkbQLuxk70JdkqUq5X6BIydHp29fz2HF4NlYwgiOEuNoxnyxYOp67Oz9g6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vdizl39s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3rA06n96WGLK2ibap/ECyjeIxpRARSJPprcl5Inbv4k=; b=Vdizl39swonXgRvIB3URmUUHeI
	bU49yxcR7zVIiSc+jJ7z1+W7uBnuwYkFkzx+rSOHshxVp0MuF4qE61z3ttgzPzrR/hm8e1DvWOC9m
	4HCy86c7mi8lRhJLoB21mthAab4RNQFzltv4HHl+Bc1+ROXTNDx1C+/bH3ooO2fUUVBXBqgWBgbxh
	L9vgTvqpydua42924Uqwe+uYPQ/8DkrhbqnYA4M/Vghs3K2Dky6IYwY92MWMjgnjR/P6jDH6OZZAH
	IDavZxILp8sXVhlzwkWF2cfWS0zTxu++nzTTUJ1c6Vmy95Fxsna/uPU+Kf0ZP0QbN1ecMz3fqHYOt
	+wcCZylQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTycq-00000008r9L-3te3;
	Sun, 28 Jan 2024 06:26:41 +0000
Message-ID: <7a0f057c-1544-49e2-9bbe-a46eb33dc8ac@infradead.org>
Date: Sat, 27 Jan 2024 22:26:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] coding-style: recommend split headers instead of
 kernel.h
Content-Language: en-US
To: Yueh-Shun Li <shamrocklee@posteo.net>, Jonathan Corbet <corbet@lwn.net>
Cc: Hu Haowen <src.res.211@gmail.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
 <20240108201851.191604-1-shamrocklee@posteo.net>
 <20240108202217.191839-1-shamrocklee@posteo.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240108202217.191839-1-shamrocklee@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/8/24 12:22, Yueh-Shun Li wrote:
> In section "18) Don't re-invent the kernel macros" in "Linux kernel
> coding style":
> 
> Recommend reusing macros from headers inside include/linux, instead of
> the obsolete include/linux/kernel.h
> 
> Change wording
> 
> - "The header file contains macros" -> "the header files provide macros"
>   Some macros are intended to use inside the header file only, or are
>   considered the implementation detail of other facilities. Developers
>   are expected to determine if a macro is meant to be used outside the
>   header file.
> 
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/process/coding-style.rst | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 6db37a46d305..2a5c4f4c568c 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -1048,27 +1048,29 @@ readable alternative if the call-sites have naked true/false constants.
>  Otherwise limited use of bool in structures and arguments can improve
>  readability.
>  
> +
>  18) Don't re-invent the kernel macros
>  -------------------------------------
>  
> -The header file include/linux/kernel.h contains a number of macros that
> -you should use, rather than explicitly coding some variant of them yourself.
> +The header files in the ``include/linux`` directory provide a number of macros
> +that you should use, rather than explicitly coding some variant of them
> +yourself.
> +
>  For example, if you need to calculate the length of an array, take advantage
> -of the macro
> +of the macro ``ARRAY_SIZE()`` from ``include/linux/array_size.h`` by
>  
>  .. code-block:: c
>  
> -	#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +	#include <linux/array_size.h>
> +	ARRAY_SIZE(x) // The size of array x
>  
>  Similarly, if you need to calculate the size of some structure member, use
> +``sizeof_field()`` from ``include/linux/stddef.h``.
>  
> -.. code-block:: c
> -
> -	#define sizeof_field(t, f) (sizeof(((t*)0)->f))
> -
> -There are also min() and max() macros that do strict type checking if you
> -need them.  Feel free to peruse that header file to see what else is already
> -defined that you shouldn't reproduce in your code.
> +There are also ``min()`` and ``max()`` macros in ``include/linux/minmax.h``
> +that do strict type checking if you need them. Feel free to search across and
> +peruse the header files to see what else is already defined that you shouldn't
> +reproduce in your code.
>  
>  
>  19) Editor modelines and other cruft

-- 
#Randy

