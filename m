Return-Path: <linux-kernel+bounces-70618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C87859A29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238E71F21202
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671456F074;
	Sun, 18 Feb 2024 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKouVEAG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB16EAD3
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708297577; cv=none; b=McQfVRUkECCLqfsafQQ8GS5PkrhviIHiBscs09PSvVsmV+NhfYBDabwA07PZ/qBQe5UUYA7gMTjd3OHfT6jPpYqSwvX1zCPKJWIScGkzMYIikynuPrR+BYDWKanq9FFJiZCvl2A0VjqiWnoFfTUU4VfYoYQzWr8yVDx+hgv1psI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708297577; c=relaxed/simple;
	bh=dZBfVvcwyKFXAPZ431/ounbBcYEHNKswoI5m5uhlx9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc8SooEwUM43ZP3KeRD0ZV9Rc7TMHXoCyn46uhRq/xdaqVEepwHw4Y6igkK/pFguZj77fVGLaW+rmE3pllAOxXdfTMimJEhCwZfp+h2QXBAS+JNNmPmTP/rS6mBuxcNgC33jL8NhI63s4c6SrOTkYP8xA3t7U/ts41oVGll4SqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKouVEAG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41260f946c8so6704475e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708297574; x=1708902374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZYwbs0hT6XgKoPOkjoQHSc7t5jEfrmq2mFVWPjwFrA=;
        b=aKouVEAGz/0j5as8e8qboJEtpuaQjMcByY5eRXleHnlg8jC+bWcWtRCnB7h93htLVI
         q8RjIH6MKJ8hSCuclF7HUWnKx8KP7um04C7Jz0q7FFqe9HPi0uxY1DRLPY0at31AR6F+
         WgmPVurGcB4ZYqbfC4piB40ze0iHrbuRKBFtCS/SuMBcP80fTSj7zuiQit091Shp6iDz
         lLaA/naeQVrbVFX+kIciIfFBwrMyffJhqRF290yAG3hA33EQhLn/cqQrlKDKCPYYQ35t
         J93K4QhkfTu/SlrCVSJLEJbfJsXdf4DYTMKZH9SbscSuk9LQuAeSMMp6A6mzpZh2h7S0
         2BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297574; x=1708902374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZYwbs0hT6XgKoPOkjoQHSc7t5jEfrmq2mFVWPjwFrA=;
        b=rajr0Owh8Ay96ihM3gd7vlOc50A/2VfN2EcqeNoTdhk2wlPHEhjgaa5CLDTi6gEZGd
         ZsAnv//f2r65IOxYZCO21QvZvpTIN4/LkD2AhXJ/pVikLiDek0OoRa0mMdpvf3KA0BLD
         vD/dfnCho/bIeNHRI10wiLPfLKNkxay85Z29FPJKbScQnp4d3oKSyeGL5WYJzL+GZKxz
         0KZBjKtt3KFLyN32yVFR0byQwcGNbn9TM24ZGYyk6OfQJwjfzFDs3HBaBr32OgsGCp2/
         rcxMsdH28PH+MvPNU1QDssJoHuvogCP47adub1++g5JSe6kZpEBG+O7NMa/3szdV5eDP
         f7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUX+eldrHWyXQC4BUeBQRhZWR0Kj9P/eMb/GWEjYezD4/tZIfFcDvW75T9ssobToSRsv6CG3aicCKHEMGoNXpuxg8cgmtAwPpD4My3y
X-Gm-Message-State: AOJu0YyESGgUJMuY1NUpXQsWiH/VRKvhcVuTO7wCzVxgiqWD7ppwP64I
	iz5MBqU1HNu4VZJ1r9BtFAM434Pr4T9ubxtyLXOZwh64uukk8cW2
X-Google-Smtp-Source: AGHT+IFfsgFbsxq4soP1Z2GRcSLOZ+0kTntkGcPP34eWmwvFtWvoL+zVmEaUlO+++jirsuRbhXzAsQ==
X-Received: by 2002:a05:6000:1ac6:b0:33b:1bcc:7ed9 with SMTP id i6-20020a0560001ac600b0033b1bcc7ed9mr7854417wry.44.1708297574149;
        Sun, 18 Feb 2024 15:06:14 -0800 (PST)
Received: from localhost (host86-164-109-77.range86-164.btcentralplus.com. [86.164.109.77])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600011c300b0033cf453f2bbsm8544712wrx.35.2024.02.18.15.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:06:13 -0800 (PST)
Date: Sun, 18 Feb 2024 23:03:58 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: [PATCH] mm/mmap: Add case 9 in vma_merge()
Message-ID: <a5cd692e-34e3-4bc1-a8fa-f6bb56f04e8a@lucifer.local>
References: <20240218085028.3294332-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218085028.3294332-1-yajun.deng@linux.dev>

On Sun, Feb 18, 2024 at 04:50:28PM +0800, Yajun Deng wrote:
> If the prev vma exists and the end is less than the end of prev, we
> can return NULL immediately. This reduces unnecessary operations.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Adding Vlastimil, while get_maintainers.pl might not show it very clearly,
myself, Vlastimil and Liam often work with vma_merge() so it's handy to cc
us on these if you can!

> ---
>  mm/mmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8f176027583c..b738849321c0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -827,7 +827,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>   *
>   *     ****             ****                   ****
>   *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
> - *    cannot merge    might become       might become
> + *    cannot merge 9  might become       might become

While I welcome your interest here :) I am not a fan of the 'case' approach
to this function as-is and plan to heavily refactor this when I get a chance.

But at any rate, an early-exit situation is not a merge case, merge cases
describe cases where we _can_ merge, so we can drop this case 9 stuff (this
is not your fault, it's understandable why you would label this, this
function is just generally unclear).

>   *                    PPNNNNNNNNNN       PPPPPPPPPPCC
>   *    mmap, brk or    case 4 below       case 5 below
>   *    mremap move:
> @@ -890,6 +890,9 @@ static struct vm_area_struct
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
>
> +	if (prev && end < prev->vm_end) /* case 9 */
> +		return NULL;
> +

I need to get back into vma_merge() head space, but I don't actually think
a caller that's behaving correctly should ever do this. I know the ASCII
diagram above lists it as a thing that can happen, but I think we
implicitly avoid this from the way we invoke callers. Either prev == vma as
per vma_merge_extend(), or the loops that invoke vma_merge_new_vma()
wouldn't permit this to occur.

Let me look into it more deeply + reply again a bit later, I mean we could
perhaps do with asserting this somehow, but I don't think it's useful to do
an early exit for something that ostensibly _shouldn't_ happen.

>  	/* Does the input range span an existing VMA? (cases 5 - 8) */
>  	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
>
> --
> 2.25.1
>

