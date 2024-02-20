Return-Path: <linux-kernel+bounces-73753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53185CA80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004AD1C21829
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5715152DE5;
	Tue, 20 Feb 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwtcFMaR"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E1152E00
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467155; cv=none; b=Rgkh9L4BmJ8vmu//k0qgKQM68nayhVaWXB2z++K/tzwOnuxZY7Ifd0ms3vP9lPBAHZCvMPxi3nfmwLU4kpGxihqKuQGlVm4yWOQBSTuBFauM0HASUViwxS9765o3wffOeZqxCZUCFXi6SSwPteCly5zAgOtcC6yNs5SvrCFTJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467155; c=relaxed/simple;
	bh=MdBao4m4xd9E0PIc9f4OH0t4I1SHruw2qwKFaJ4QdXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0SA7VS5lja/o5xM4ptthl/FLwMOs/VjGJbVMCNT0SMBelIpo0TkCRqVpr6/KLWblbTKJACTW/0SFfOMM7OXhKVyQBdYxc87X7jpj/odjtVGhlU5oP1WD04foVOhduqktUSNR+9k4k5N1penifYRmJJGL55Sz9dSuUo+jUco6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwtcFMaR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4127552a477so226245e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708467150; x=1709071950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNaRiN9Bf5zdH/MAgVRJX5f88QotWSNrDLzJMcP+CQc=;
        b=DwtcFMaRdYra8bC9eBpeYhzrMNbQKTR/naUiOdZXY+6GFQaKA/2fkrQjfkFlm0InnB
         jfInXMbIrR4VNzAcqAuNXBgjkewjmNDAxfi951E4RE0ElGOH9+YFPjGCT9TvoOm5XwnR
         QQBMMGrToUUJvX4NYlYEPUDGKvwuG9Q0n3Py60U+vy6v2cL5bGgwLcNSEaumQDIxqpvG
         qNVGhDX/ybOwVa4F14XX6krRbRjQt6GpkBe2BbaD6eMVEuXXnlNqZjgqLlm0JhyTzAA5
         uw0nbU0wAdcq4Y2emAzHk/Kx0eZ1Q6+ofxMAzaoTBfCK81yNZJYaUoNy4SnTw1WUk1O9
         lhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708467150; x=1709071950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNaRiN9Bf5zdH/MAgVRJX5f88QotWSNrDLzJMcP+CQc=;
        b=S4neFvFG2u1tZq8h+Igc3Udoz/vOn7zsUWH7ZAKfgh/X2zxnmDXGDnGlw/4o12ydOF
         tSVk9krB90laTUqK/d+cVuDVUMahetcuKbROWtoRAW9+jbtaMFyBNBBeRQAWDveMeqk8
         QUfPUAQA0ngB1pQrlIgB/AN53cN1fV7dOzZ3Gyo7hvGtbhxY2e9sudlGwgI2uhhPqNSJ
         yyIuDcFQT98IdUVSGxDpfKyu74moKps3dMNurC8hLnmfjADZCd5zB89zVGRHnFmTUizN
         1YK+DJDur3z9iCIxsgk0PftDlmXVj8lALs6phtJBT9MY4G3CdQAs3/Qgiy23iWPoNjKV
         7Tbg==
X-Forwarded-Encrypted: i=1; AJvYcCU73+FPVn8xtzuuPDhHZdpyUPRNUBiNo45TKfBlzVVpYCkosogc2QE2QyJIc2n5cqomfSgASp6HhdxAtrx4U/mwsK9+sPD27rjvNKKR
X-Gm-Message-State: AOJu0Ywx7wcMkl9jCUYlug6E/EXfW1rdJnr/mlAvN3GJnW/rwExuwgGM
	LuPkd7mBf73LHV4/JIqEt5+wF3DJF1K5A9bVVPYrMnEuTDeB0WxcSgTb/ql4
X-Google-Smtp-Source: AGHT+IHzTXhHrUUQOhFclGSxI9cVcHGOgBNyNE7dn6pzkooYv3QZnq/3zXnUSQCwdbOg5bewV/mhzQ==
X-Received: by 2002:a05:600c:b97:b0:412:7190:ad0f with SMTP id fl23-20020a05600c0b9700b004127190ad0fmr1260528wmb.11.1708467150120;
        Tue, 20 Feb 2024 14:12:30 -0800 (PST)
Received: from localhost (host86-164-109-77.range86-164.btcentralplus.com. [86.164.109.77])
        by smtp.gmail.com with ESMTPSA id fs14-20020a05600c3f8e00b00411a595d56bsm15789922wmb.14.2024.02.20.14.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:12:29 -0800 (PST)
Date: Tue, 20 Feb 2024 22:10:13 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: [PATCH] mm/mmap: Add case 9 in vma_merge()
Message-ID: <33023080-9e11-475e-a199-b7ff1e655c57@lucifer.local>
References: <20240218085028.3294332-1-yajun.deng@linux.dev>
 <a5cd692e-34e3-4bc1-a8fa-f6bb56f04e8a@lucifer.local>
 <f88de15e-508f-f651-0164-346845d23e85@linux.dev>
 <bc9e3cc3-26b8-41ad-b791-10ba61edc1c2@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9e3cc3-26b8-41ad-b791-10ba61edc1c2@lucifer.local>

On Tue, Feb 20, 2024 at 09:00:15PM +0000, Lorenzo Stoakes wrote:
> On Tue, Feb 20, 2024 at 11:00:30AM +0800, Yajun Deng wrote:
> >
> > On 2024/2/19 07:03, Lorenzo Stoakes wrote:
> [snip]
> >
> > Yes, it's not a merge case. I label this to make it easier to understand.
>
> OK, I guess I have to be more explicit + less soft here to avoid confusion
> as you seem not to be paying attention to what I have said - We can't have
> this in the patch, full stop.
>
> I (+ Liam) have already explained above as to why, but to emphasise - each
> case number refers to a merge case consistently throughout. Arbitrarily
> adding a new case label to describe one of the many early exit conditions
> proactively HURTS understanding.
>
> >
> > > >    *                    PPNNNNNNNNNN       PPPPPPPPPPCC
> > > >    *    mmap, brk or    case 4 below       case 5 below
> > > >    *    mremap move:
> > > > @@ -890,6 +890,9 @@ static struct vm_area_struct
> > > >   	if (vm_flags & VM_SPECIAL)
> > > >   		return NULL;
> > > >
> > > > +	if (prev && end < prev->vm_end) /* case 9 */
> > > > +		return NULL;
> > > > +
> > > I need to get back into vma_merge() head space, but I don't actually think
> > > a caller that's behaving correctly should ever do this. I know the ASCII
> > > diagram above lists it as a thing that can happen, but I think we
> > > implicitly avoid this from the way we invoke callers. Either prev == vma as
> > > per vma_merge_extend(), or the loops that invoke vma_merge_new_vma()
> > > wouldn't permit this to occur.
> > No, it will actually happen. That's why I submitted this patch.
>
> You aren't explaining any situation where this would happen. As Liam says,
> this is something you have to provide.
>
> I have taken a moment to look into this and I am afraid I don't feel this
> patch makes sense.
>
> Firstly, let's assume you're right and we can reach this function with end
> < prev->vm_end:
>
> 1. curr will be NULL as find_vma_intersection(mm, prev->vm_end, end) will
>    always find nothing since end < prev->vm_end.
>
> 2. We discover next by using vma_lookup(mm, end). This will always be NULL
>    since no VMA starts at end (it is < prev->vm_end so within prev).
>
> 3. Therefore next will always be NULL.
>
> 4. Therefore the only situation in which the function would proceed is that
>    checked in the 'if (prev)' block, but that checks whether addr ==
>    prev->vm_end, but since end < prev->vm_end, it can't [we explicitly
>    check for addr >= end in a VM_WARN_ON()].

OK I say below about feel fre to embarrass me if I am mistaken, but I can
go ahead and do embarrass myself directly :)

Apologies - the above is not correct, vma_lookup() doesn't look for an
exact match so will assign next = prev in this scenario.

However the vm_pgoff check will cause this case to fail also.

>
> Therefore - we will always abort in this case, and your early check is
> really not that useful - it's not something that is likely to come up
> (actually I don't think that it can come up, we'll come on to that), and so
> being very slightly delayed in exiting is not a great gain.
>
> You are then also introducing a fairly useless branch for everybody else
> for - if it even exists - a very rare scenario. I do not think this is a
> good RoI.
>
> As to whether this can happen - I have dug a bit into callers:
>
> 1. vma_merge_extend() always specifies vma->vm_end as the start explicitly
>    to extend the VMA so this scenario isn't possible.
>
> 2. Both callers of vma_merge_new_vma() are trying to insert a new VMA and
>    explicitly look for a prev VMA and thus should never trigger this
>    scenario.
>
> This leaves vma_modify(), and again I can't see a case where prev would not
> actually be the previous VMA, with start/end set accordingly.
>
> I am happy to be corrected/embarrassed if I'm missed something out here
> (vma_merge() is a great function for creating confusion + causing unlikely
> scenarios), so please do provide details of such a case if you can find
> one.

Also, I discovered that I can *ahem* reliably reproduce this scenario, so
apologies, you were right to say it can arise (but it would have been
useful for you to give details!)

I can repro it in mprotect_fixup(), quite reliably, so it might be worth
digging into why this scenario is happening.

>
> TL;DR:
>
> - The case 9 stuff is completely wrong.
> - I do not think this patch is useful even if the scenario you describe
>   arises.
> - I can't see how the scenario you describe could arise.
>
> So overall, unless you can provide compelling evidence for both this
> scenario actually occurring in practice AND the need for an early exit,
> this patch is a no-go.
>
> In addition, if you were to find such, you'd really really need to beef out
> the commit message, which is far too short, and frankly incorrect at this
> point - if you perform a branch which 99.9999% of the time is not taken,
> you are not 'reducing unnecessary operations' you are creating them.
>
> If you could find compelling evidence to support this patch and send this
> as a v2 then I'd consider it, but for the patch in its current form:
>
> NACK.

I'll stick with the NACK (though slightly less assuredly), as the case 9
stuff has to go, that is the real bugbear here for me. It's more review
feedback, but the commit message needs beefing up in any case too.

I'm still not hugely convinced this is a worthwhile early exit, since we
don't treat any other 'can't merge' case specially here.

I think the more interesting thing to do here is to figure out why
mprotect_fix() (or perhaps others) is even trying the merge under these
circumstances.

Again as I said in the first reply, thanks for your efforts looking at
this! The nacking + such is simply an effort to ensure we are being
extremely careful around this highly delicate function.

Thanks, Lorenzo

