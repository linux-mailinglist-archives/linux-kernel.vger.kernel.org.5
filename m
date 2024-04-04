Return-Path: <linux-kernel+bounces-131949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31C898DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7435528414B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3974A1304A9;
	Thu,  4 Apr 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VKWxIBSO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768812EBDC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254665; cv=none; b=rscEGDaQMGZBbfiggdnNoEeJ3ajTpQkXEY4F/HSDmK4pk0Lyo+Rynmf05h3uqvk0cuQi3ZSRA0cOBDmvK7gEmEOHs7vRJHpI7fEMpeEM+n9DW56tA+hP+JaV5mWjAeMLxL2MRjoly8ligWhnXVu9Otx/yy8vNUa9FZ8DcdybVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254665; c=relaxed/simple;
	bh=Ys+tfPTB29dKoiO/XRPcPu+ySPFIy2NcZ8tTJg+DcEU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pAL/jjzR1we7BXZsLQ4FHdaPnCjnEQFVL71aK8zTUaDYNpBsDwYbBaSfV2lgJhByu5IgrgjpbCVYvkizqaNTPWjLqpd7UuzTR0fQOaKne4REm9HQznpeGvDFp1DO9Ytg822jMb/fwYtecoNwsKObp6MAmfTDibS4f7BNxwvgpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VKWxIBSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C39C433F1;
	Thu,  4 Apr 2024 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712254665;
	bh=Ys+tfPTB29dKoiO/XRPcPu+ySPFIy2NcZ8tTJg+DcEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VKWxIBSOGkkveo9J0k/54HOhz1qVvosnpYa5vwgUx0d8aeKZPIDtcC8lxDXRu07GP
	 +qxe/ydvAexKVD/ILep3so990PjkvaixsUmi3OebfdphMJ30C+Xd0+fOt3kTqYcDZb
	 zmx/spqkAqMr7wnwsBtxtwgApyJZBL55sIdUXLnw=
Date: Thu, 4 Apr 2024 11:17:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Alexander Potapenko <glider@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: hw_tags: include linux/vmalloc.h
Message-Id: <20240404111744.40135657cd9de474b43d36c7@linux-foundation.org>
In-Reply-To: <20240404124435.3121534-1-arnd@kernel.org>
References: <20240404124435.3121534-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Apr 2024 14:44:30 +0200 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> This header is no longer included implicitly and instead needs to be
> pulled in directly:
> 
> mm/kasan/hw_tags.c: In function 'unpoison_vmalloc_pages':
> mm/kasan/hw_tags.c:280:16: error: implicit declaration of function 'find_vm_area'; did you mean 'find_vma_prev'? [-Werror=implicit-function-declaration]
>   280 |         area = find_vm_area((void *)addr);
>       |                ^~~~~~~~~~~~
>       |                find_vma_prev
> mm/kasan/hw_tags.c:280:14: error: assignment to 'struct vm_struct *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
>   280 |         area = find_vm_area((void *)addr);
>       |              ^
> mm/kasan/hw_tags.c:284:29: error: invalid use of undefined type 'struct vm_struct'
>   284 |         for (i = 0; i < area->nr_pages; i++) {
>       |                             ^~
> mm/kasan/hw_tags.c:285:41: error: invalid use of undefined type 'struct vm_struct'
>   285 |                 struct page *page = area->pages[i];
>       |                                         ^~

Thanks, but I'd like to know which patch this patch is fixing, please. 
Is it mainline or linux-next?  I'm suspecting it might be a fix for
fix-missing-vmalloch-includes.patch but without knowing how to
reproduce this I can't determine anything.

> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -16,6 +16,7 @@
>  #include <linux/static_key.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/vmalloc.h>
>  
>  #include "kasan.h"


