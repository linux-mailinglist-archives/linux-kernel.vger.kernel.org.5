Return-Path: <linux-kernel+bounces-73708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59E85C68C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5151F22BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1C151CDC;
	Tue, 20 Feb 2024 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyIB3vGE"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC114F9C8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462955; cv=none; b=RxeFnfZifPhu8+1+JEYp9wY93XbPuCu4uDn6n6s7x/myHPuFt/MPx7XP5NIGYeQpHnU4ElFhuFmylhU6mVZsRF2wtpbartI4ZTQjQWuTiJEysvHsxAfaqkSBBH8aXyoJ5pOByvxkHFbWbGNGBjo3u7jBgwIHGkA6gbSZMtll5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462955; c=relaxed/simple;
	bh=o6XPqB/8zxNHpvV0fHVJdWnCnt75Wb6tUvyGsRj0mEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPykxc+K+EuCtdP3u0byhsp4K+aJnm8g7HzDWcH+FXpQgLD03L9M5XjdHP93Ru1uzQ+KVZFZvZwYTqnnWlzJvnrjQDfXmFpaB/t5Si+7mriGjaZ45EfALbdMPwDm1tHE6VbkF5yhZuomC+v3nsoCfT+uWXNwkEgKTkejRQDcIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyIB3vGE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412748b183aso270705e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708462952; x=1709067752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHk8B1G9ngPFWZyvzcJjpFnWjSLSm2alsXCknI8ZS8Y=;
        b=CyIB3vGE8eSTX9uWbtaob7o6JmuFZQ1x7nVLtjylPqvpzsK61iokku/uHoUHrFwvj4
         +VmErEWnhSQfMz0UpEBg8rJXnqHgtSgVMBLV6CopJMOMFJ81T00o3DU/SSHx/tLe1yAy
         10LjbjcfrVmBFyJtwuEL5zeCAbBlcMGdBwEYz9XQmRBDgkffK1nXg2tpTqbH59HDXAnl
         fSRDzNEc0oTEC7JV7MBhslLaJvF+ealBdxTa3zp3uRbLOBBkJMTo1jmmcgoofQmXvStO
         sFKqMotFp1xXCFWnrSfvr4+aLVqnPMi/13eJ/iVZqNZoIcRTWKG8CvVpC9mVU92vDatQ
         dcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708462952; x=1709067752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHk8B1G9ngPFWZyvzcJjpFnWjSLSm2alsXCknI8ZS8Y=;
        b=oFc0V02DgKtzs8PjZQT4ecx+f5dSfMpII6A0rRVqxb4BNFT9ZJ0yw1HTRVV/6eYI9r
         fY2N2PuptcEIcfqJ4Y6uDkRjgQOBXyLoHnnVCcx+VHqJfuT8kdpL8RGM3FvNzKRPQ+y2
         4QuCIJI/TOsNHy4bXDidE62IcYfp0SfT89E3O0dykG7jkqCc+IBGkQkp5rWaXaYEs0zj
         yW0GTRPnUjd3UjAbFHkcbvDXkqdPWdK3hv5n00vAMopJ3xfER3PP7EL1ZlaDarXpBLcS
         jcRv16XZVNoM8hgz+ZmTobLV0pjxjqFl4eHc1OJkUXZPNhBRPdGN7t1lvTm7eROjtEZj
         Aqyg==
X-Forwarded-Encrypted: i=1; AJvYcCWCITd82Vg2AsFxjog+HA1NNpiuxUf6buYNOYH1VXXhxhsVMskLKlp3KpluOwESs7eyPKWKYq3IYeojm8GXqFkF0Hyv2377ItsaDkLo
X-Gm-Message-State: AOJu0YwCyj5mj9p5DAQpFwOX6YGb6vg79jjkIsVhRsz2OsDcCRx7ihQS
	C32q7HXSmc8s3Qh9wz8RbLJivGdsxGaoSTBQSyDGy5jGPuoNdWp/Lrl7FP5J
X-Google-Smtp-Source: AGHT+IGNd4EhKrOF2qguezkMCdiri+YzoOSXxtGqLSGpEMpRRkdkkVB+APiJgoZ4zrZJv+9oUTVssg==
X-Received: by 2002:a05:600c:190c:b0:411:cb30:8e00 with SMTP id j12-20020a05600c190c00b00411cb308e00mr12141209wmq.3.1708462951917;
        Tue, 20 Feb 2024 13:02:31 -0800 (PST)
Received: from localhost (host86-164-109-77.range86-164.btcentralplus.com. [86.164.109.77])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c451200b0040fd1629443sm16087456wmo.18.2024.02.20.13.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:02:30 -0800 (PST)
Date: Tue, 20 Feb 2024 21:00:15 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: [PATCH] mm/mmap: Add case 9 in vma_merge()
Message-ID: <bc9e3cc3-26b8-41ad-b791-10ba61edc1c2@lucifer.local>
References: <20240218085028.3294332-1-yajun.deng@linux.dev>
 <a5cd692e-34e3-4bc1-a8fa-f6bb56f04e8a@lucifer.local>
 <f88de15e-508f-f651-0164-346845d23e85@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88de15e-508f-f651-0164-346845d23e85@linux.dev>

On Tue, Feb 20, 2024 at 11:00:30AM +0800, Yajun Deng wrote:
>
> On 2024/2/19 07:03, Lorenzo Stoakes wrote:
[snip]
>
> Yes, it's not a merge case. I label this to make it easier to understand.

OK, I guess I have to be more explicit + less soft here to avoid confusion
as you seem not to be paying attention to what I have said - We can't have
this in the patch, full stop.

I (+ Liam) have already explained above as to why, but to emphasise - each
case number refers to a merge case consistently throughout. Arbitrarily
adding a new case label to describe one of the many early exit conditions
proactively HURTS understanding.

>
> > >    *                    PPNNNNNNNNNN       PPPPPPPPPPCC
> > >    *    mmap, brk or    case 4 below       case 5 below
> > >    *    mremap move:
> > > @@ -890,6 +890,9 @@ static struct vm_area_struct
> > >   	if (vm_flags & VM_SPECIAL)
> > >   		return NULL;
> > >
> > > +	if (prev && end < prev->vm_end) /* case 9 */
> > > +		return NULL;
> > > +
> > I need to get back into vma_merge() head space, but I don't actually think
> > a caller that's behaving correctly should ever do this. I know the ASCII
> > diagram above lists it as a thing that can happen, but I think we
> > implicitly avoid this from the way we invoke callers. Either prev == vma as
> > per vma_merge_extend(), or the loops that invoke vma_merge_new_vma()
> > wouldn't permit this to occur.
> No, it will actually happen. That's why I submitted this patch.

You aren't explaining any situation where this would happen. As Liam says,
this is something you have to provide.

I have taken a moment to look into this and I am afraid I don't feel this
patch makes sense.

Firstly, let's assume you're right and we can reach this function with end
< prev->vm_end:

1. curr will be NULL as find_vma_intersection(mm, prev->vm_end, end) will
   always find nothing since end < prev->vm_end.

2. We discover next by using vma_lookup(mm, end). This will always be NULL
   since no VMA starts at end (it is < prev->vm_end so within prev).

3. Therefore next will always be NULL.

4. Therefore the only situation in which the function would proceed is that
   checked in the 'if (prev)' block, but that checks whether addr ==
   prev->vm_end, but since end < prev->vm_end, it can't [we explicitly
   check for addr >= end in a VM_WARN_ON()].

Therefore - we will always abort in this case, and your early check is
really not that useful - it's not something that is likely to come up
(actually I don't think that it can come up, we'll come on to that), and so
being very slightly delayed in exiting is not a great gain.

You are then also introducing a fairly useless branch for everybody else
for - if it even exists - a very rare scenario. I do not think this is a
good RoI.

As to whether this can happen - I have dug a bit into callers:

1. vma_merge_extend() always specifies vma->vm_end as the start explicitly
   to extend the VMA so this scenario isn't possible.

2. Both callers of vma_merge_new_vma() are trying to insert a new VMA and
   explicitly look for a prev VMA and thus should never trigger this
   scenario.

This leaves vma_modify(), and again I can't see a case where prev would not
actually be the previous VMA, with start/end set accordingly.

I am happy to be corrected/embarrassed if I'm missed something out here
(vma_merge() is a great function for creating confusion + causing unlikely
scenarios), so please do provide details of such a case if you can find
one.

TL;DR:

- The case 9 stuff is completely wrong.
- I do not think this patch is useful even if the scenario you describe
  arises.
- I can't see how the scenario you describe could arise.

So overall, unless you can provide compelling evidence for both this
scenario actually occurring in practice AND the need for an early exit,
this patch is a no-go.

In addition, if you were to find such, you'd really really need to beef out
the commit message, which is far too short, and frankly incorrect at this
point - if you perform a branch which 99.9999% of the time is not taken,
you are not 'reducing unnecessary operations' you are creating them.

If you could find compelling evidence to support this patch and send this
as a v2 then I'd consider it, but for the patch in its current form:

NACK.

