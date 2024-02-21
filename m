Return-Path: <linux-kernel+bounces-75475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC01C85E935
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E601C210C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8437281213;
	Wed, 21 Feb 2024 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARWqzCTU"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA73A1DB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548237; cv=none; b=QfqgbQ5zW3Le73Bk5j/uLHQvrWs1Q9K3zyNgltf0+W7ViRMk/SSm4zU1qCc+IFuOpQYsowZyR0kV6PQmza5/ZYyukFTLQ3f+EBx5s/c1Qxlehs4mFvHxCoLw+J+f0slUDlL+ShSiEywrNTP4OgOieJ4JtdztHY4B+R/RqPsD7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548237; c=relaxed/simple;
	bh=c8MfMgRUZW8qxd9gubgL7YFRZDYcZnmwcwl2hw5IXdk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKQDkiPossPzyitnev53c2xXy5g2e1DunU16kGLTBCFt5+DoGy3WT9PZTlQ9Ol3AjJYx4jDMe/whkkRpZIkassGcNzbBkqhNWzzo96wNFO69ZtbLc8E7hY+6aPcOgvsa28M9X+42Toqe78pSLRCPnozFRs9D2GDRjxV6MUw4WkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARWqzCTU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41275d2edbcso8311925e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708548234; x=1709153034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQKBdsBXJqQPwRNGAXBAfHtnvpBdZt9I1p+3iXhYFuE=;
        b=ARWqzCTUh0LqBDoxJkxEF3XYXXJQmdFFGepPJPdi13GbcvI8YShn0aP6rEFo9G8DuH
         EszBgGu6CC+87ULJ3DmKn07SOmB2+e5MkhdWw2bEcGH7DT2gZfewG8QSca8l60y0Um63
         Ldk/ERjkw152/ZdjqVntWBd8u2dSENgAbfgAlVafrukXpMZpRZd+6siZWAC9DywEALRp
         crPZFtfac7yiaCS+PAPUAw8JkkPzStO5iO1S0Ys2AvrehAMf4OzAIP3M03DP0Xc7CXCZ
         +qGAFCbfs/ceM+DWqTIBLTO6Wa8v0CpXYYzeMVGBlswr9uxOgBiEn2cYwJw2Yo/X1KHx
         yC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708548234; x=1709153034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQKBdsBXJqQPwRNGAXBAfHtnvpBdZt9I1p+3iXhYFuE=;
        b=KyP/x5wM7GWi2t8D+grOar0p+7+TM+/W2SDUzSqhT+3ZphnmLYsq6UBLOGIKxUKp7q
         bYoaMvIpsRlaZQQh4NMenAhEFUql5i4UADCu/8+Qe1BQgLXoqLzfBU5fAEYRCQqnKyXY
         jpQ3acSRgNy7VdRTBY4O9TVR8VzIx4/EwCYpsFrUkd6GsG9TYhH0WDETIczeJWV3/jbK
         4z11G/ysWAbU3j5uqtHLmip4xZpcxVyDQvc9v+JfL5udZKSrZTJrmNNJbY6O39xy7YiU
         w0vMOW8tA8Oro8y8awfYjeTNgCSf8gevLm2dWcIc1Q+VptazOt2SIdeJtHEglQhICuXB
         4kdg==
X-Forwarded-Encrypted: i=1; AJvYcCVyEYXElxI9YXNc9E1sVEZWW1ufoI5T1oSjM8TaLG62a7w1NGWt7yW19N6rQt/RSi5lXdpu0IrkI7JEVNXsSN1+fDESvkvvG6T6Aft9
X-Gm-Message-State: AOJu0YyCpFJ6vInstI4hTAD3argLEoILbOA/8VsxolnDiATIiJM+9arB
	4PkZJ50nviC8OYxbsejsTqMc5vL0IcsAwBSBqdNqrIVQHPhjk0qg
X-Google-Smtp-Source: AGHT+IGgtUvjV/jJGCiYwhCbpRW1x+SE9MZ7JJC29jUKrNye7C5xmVAOxyBEWykJhlJrHuiU8UEJBw==
X-Received: by 2002:a05:600c:6cf:b0:412:d8d:1d98 with SMTP id b15-20020a05600c06cf00b004120d8d1d98mr15226515wmn.37.1708548234197;
        Wed, 21 Feb 2024 12:43:54 -0800 (PST)
Received: from localhost (host86-164-109-77.range86-164.btcentralplus.com. [86.164.109.77])
        by smtp.gmail.com with ESMTPSA id bp24-20020a5d5a98000000b0033cdf4bea19sm19940088wrb.9.2024.02.21.12.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 12:43:53 -0800 (PST)
Date: Wed, 21 Feb 2024 20:41:39 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mmap: return early if it can't merge in vma_merge()
Message-ID: <f3847dd7-5564-4d7e-951e-1a9d8f55fb78@lucifer.local>
References: <20240221091453.1785076-1-yajun.deng@linux.dev>
 <20240221153827.wkmjnnwsf6lyxatc@revolver>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221153827.wkmjnnwsf6lyxatc@revolver>

On Wed, Feb 21, 2024 at 10:38:27AM -0500, Liam R. Howlett wrote:
> * Yajun Deng <yajun.deng@linux.dev> [240221 04:15]:
> > In most cases, the range of the area is valid. But in do_mprotect_pkey(),
> > the minimum value of end and vma->vm_end is passed to mprotect_fixup().
> > This will lead to the end is less than the end of prev.
> >
> > In this case, the curr will be NULL, but the next will be equal to the
> > prev. So it will attempt to merge before, the vm_pgoff check will cause
> > this case to fail.
> >
> > To avoid the process described above and reduce unnecessary operations.
> > Add a check to immediately return NULL if the end is less than the end of
> > prev.
>
> If it's only one caller, could we stop that caller instead of checking
> an almost never case for all callers?  Would this better fit in
> vma_modify()?  Although that's not just for this caller at this point.
> Maybe there isn't a good place?

I definitely agree with Liam that this should not be in vma_merge(), as
it's not going to be relevant to _most_ callers.

I am not sure vma_modify() is much better, this would be the only early
exit check in that function and makes what is very simple and
straightforward now more confusing.

And I think this is the crux of it - it's confusing that we special case
this one particular non-merge scenario, but no others (all of which we then
deem ok to be caught by the usual rules).

I think it's simpler (and more efficient) to just keep things the way they
are.

>
> Or are there other reasons this may happen and is better done in this
> function?
>
> Often, this is called the "punch a hole" scenario; where an operation
> creates two entries from the old data and either leaves an empty space
> or fills the space with a new VMA.
>
> >
> > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > ---
> > v2: remove the case label.
> > v1: https://lore.kernel.org/all/20240218085028.3294332-1-yajun.deng@linux.dev/
> > ---
> >  mm/mmap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 0fccd23f056e..7668854d2246 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -890,6 +890,9 @@ static struct vm_area_struct
> >  	if (vm_flags & VM_SPECIAL)
> >  		return NULL;
> >
> > +	if (prev && end < prev->vm_end)
> > +		return NULL;
> > +
> >  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> >  	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
> >
> > --
> > 2.25.1
> >

So overall I don't think this check makes much sense anywhere.

I think a better solution would be to prevent it happening _at source_ if
you can find a logical way of doing so.

I do plan to do some cleanup passes over this stuff once again so maybe I
can figure something out that better handles non-merge scenarios.

This is a great find though overall even if a patch doesn't make sense
Yajun, thanks for this, it's really made me think about this case (+ others
like it) :)

