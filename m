Return-Path: <linux-kernel+bounces-76110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A7385F30B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FDF1C233EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE4D225AD;
	Thu, 22 Feb 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWduRbzA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DD17583
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590824; cv=none; b=R9vk5RXVjwmtI/WGGappXflTRaPRVnPXszQSLMkTTztgyV0HAUCsRidUVKaKU87V9syng+p1+n3xojUU9OrOP78OV6I02RG6zWknsMI70HHlHKPfAcnlrYdoQqP5HDnt7bR2GmJmgDtPBojoB36Jb9ETO4crck0axtrsLTxgLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590824; c=relaxed/simple;
	bh=eczCMoOhje0fMMdw0jLp7DoLJBhrJALUXaI5ihZAwJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2+FLPhrPFsxwjZ0LFopqaHBGH+RUzHFwRc+KAM+ogGdGfV9STikduKlZL2DCmB7i8ni7oPpxywN2aAT9Xr2+8VeP2FCNF74NEfvxvSgICylhQwGM9zoDsrEgjjDCG2Zf7mI2SisEYVgaP+rqDr1pT32nrZcKDOaH1XfXAo3Mwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWduRbzA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d28468666so1082746f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708590821; x=1709195621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bH5i/1tcGhrzuGuRkdGry1qY4fQR5qkGcCI1YHWBx9Q=;
        b=KWduRbzAdsoc0GcGePX+KyiJKqurmRC2wy/Q/oM0Z5G03AKUY3NtyYtx3lVyh4y1gM
         Hxdh3lhzXVfvu9N237P/gKD/U3iJmRXl7UBRicT2WpGc4LsFD1YnXWEAAeBSQgdtBm6q
         /IXQjbmP7z1RSHHL2GJmTtW+xZP8FRNFRq/7+x7gwHtcatk4dJW65cEAZPJgtVpI1O1W
         VvV8MFOmfnAe36Ksy4MOcyTiUmR9ZsSUqtxr5siEdBfGowoIlMEYEZPuGR+XgeDUfy0A
         ah1ABKZkEKR+rCHPvWQ/MIF5eYhQTEToEO/6wX309+PACgNdf3nm1uLBjy8PKI8uxBTO
         ls2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590821; x=1709195621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bH5i/1tcGhrzuGuRkdGry1qY4fQR5qkGcCI1YHWBx9Q=;
        b=Q3eqBcRPQ0E4Ztrpw7y385n+V3WF7qklTQNRL6XKLd7ErtAeN1u0kbWZS3VfgbrFsu
         4KyHIZRtEeezkH+gS8S6u8LmJg5+aKEHlup6If6mwBTYm0rcDZxVaRiW9wHp47DFLgxD
         9hFzywWK75A4PWw5WKtgBZd4Ivck/gv+jqld+Im9eLhr+Lt2tlO8tFpHRx0gtEhoponK
         Qsh4ppvdBAx4w3f5vWGq3C48RCz8stg0SRPFAzyCXE4sihw28d5FFTsxSoVNisJRpo+a
         mBKAYVh6RoHJn1V2y2W+bbKgE1CWTRjfKjMU6IayJYsy7GSfBemnSyMAxYcXDhNLjEWS
         YBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCULsA/9WAvCp1Uc3PdGUS150jnnUEnD7KOYQMq9jyRTuiaYeAme7fP04GLPSTDZ5p9UpMTCt7PUtUEOh+KNbSz8hai1/7O6T4vkt9ce
X-Gm-Message-State: AOJu0Yz8hg3Fm/y2DlCYd8I8PSZkmEZbrRi9ULR1201k346BTMeao1id
	7y5dseqMcizyIMobVIpbEgzOoaREb8tD4l2Hh8OIIxGUjN1Ml538
X-Google-Smtp-Source: AGHT+IGA36t4KzNPr+jWh8q57ab/UYxkN2JIqsVq8CaWM+itVn6VwkV3YGGQiMlqFlcrWxF1qrr0Fw==
X-Received: by 2002:adf:f4d0:0:b0:33b:3f43:e007 with SMTP id h16-20020adff4d0000000b0033b3f43e007mr15015688wrp.57.1708590820527;
        Thu, 22 Feb 2024 00:33:40 -0800 (PST)
Received: from localhost (host86-164-109-77.range86-164.btcentralplus.com. [86.164.109.77])
        by smtp.gmail.com with ESMTPSA id s8-20020adf9788000000b0033ae7d768b2sm19664667wrb.117.2024.02.22.00.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:33:38 -0800 (PST)
Date: Thu, 22 Feb 2024 08:31:23 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mmap: return early if it can't merge in vma_merge()
Message-ID: <b4232b44-083a-42d4-a245-7eb4382f7329@lucifer.local>
References: <20240221091453.1785076-1-yajun.deng@linux.dev>
 <20240221153827.wkmjnnwsf6lyxatc@revolver>
 <f3847dd7-5564-4d7e-951e-1a9d8f55fb78@lucifer.local>
 <082fed0a-8489-37d1-f990-067976260659@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <082fed0a-8489-37d1-f990-067976260659@linux.dev>

On Thu, Feb 22, 2024 at 03:47:04PM +0800, Yajun Deng wrote:
>
> On 2024/2/22 04:41, Lorenzo Stoakes wrote:
> > On Wed, Feb 21, 2024 at 10:38:27AM -0500, Liam R. Howlett wrote:
> > > * Yajun Deng <yajun.deng@linux.dev> [240221 04:15]:
> > > > In most cases, the range of the area is valid. But in do_mprotect_pkey(),
> > > > the minimum value of end and vma->vm_end is passed to mprotect_fixup().
> > > > This will lead to the end is less than the end of prev.
> > > >
> > > > In this case, the curr will be NULL, but the next will be equal to the
> > > > prev. So it will attempt to merge before, the vm_pgoff check will cause
> > > > this case to fail.
> > > >
> > > > To avoid the process described above and reduce unnecessary operations.
> > > > Add a check to immediately return NULL if the end is less than the end of
> > > > prev.
> > > If it's only one caller, could we stop that caller instead of checking
> > > an almost never case for all callers?  Would this better fit in
> > > vma_modify()?  Although that's not just for this caller at this point.
> > > Maybe there isn't a good place?
> > I definitely agree with Liam that this should not be in vma_merge(), as
> > it's not going to be relevant to _most_ callers.
> >
> > I am not sure vma_modify() is much better, this would be the only early
> > exit check in that function and makes what is very simple and
> > straightforward now more confusing.
>
>
> There are two paths that will cause this case. One is in mprotect_fixup(),
> the other is in
>
> madvise_update_vma().
>
>
> One way is to separate out the split_vma() from vma_modify(). And create a
> new helper function.

Absolutely not. I wrote the vma_modify() patch series explicitly to expose
_less_ not more.

>
> We can call it directly at source, but we need to do this in both paths.
> It's more complicated.
>
>
> The other way is to add a check in vma_modify(). Like the following:

As I said above, I really don't think this is a good idea, you're just
special casing one non-merge case but not any others + adding an
unnecessary branch.

>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0fccd23f056e..f93f1d3939f2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2431,11 +2431,15 @@ struct vm_area_struct *vma_modify(struct
> vma_iterator *vmi,
>         pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >>
> PAGE_SHIFT);
>         struct vm_area_struct *merged;
>
> +       if (prev && end < prev->vm_end)
> +               goto cannot_merge;
> +
>         merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
>                            pgoff, policy, uffd_ctx, anon_name);
>         if (merged)
>                 return merged;
>
> +cannot_merge:
>         if (vma->vm_start < start) {
>                 int err = split_vma(vmi, vma, start, 1);
>
>
> > And I think this is the crux of it - it's confusing that we special case
> > this one particular non-merge scenario, but no others (all of which we then
> > deem ok to be caught by the usual rules).
> >
> > I think it's simpler (and more efficient) to just keep things the way they
> > are.
> >
> > > Or are there other reasons this may happen and is better done in this
> > > function?
> > >
> > > Often, this is called the "punch a hole" scenario; where an operation
> > > creates two entries from the old data and either leaves an empty space
> > > or fills the space with a new VMA.
> > >
> > > > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > > > ---
> > > > v2: remove the case label.
> > > > v1: https://lore.kernel.org/all/20240218085028.3294332-1-yajun.deng@linux.dev/
> > > > ---
> > > >   mm/mmap.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 0fccd23f056e..7668854d2246 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -890,6 +890,9 @@ static struct vm_area_struct
> > > >   	if (vm_flags & VM_SPECIAL)
> > > >   		return NULL;
> > > >
> > > > +	if (prev && end < prev->vm_end)
> > > > +		return NULL;
> > > > +
> > > >   	/* Does the input range span an existing VMA? (cases 5 - 8) */
> > > >   	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > So overall I don't think this check makes much sense anywhere.
> >
> > I think a better solution would be to prevent it happening _at source_ if
> > you can find a logical way of doing so.
> >
> > I do plan to do some cleanup passes over this stuff once again so maybe I
> > can figure something out that better handles non-merge scenarios.
> >
> > This is a great find though overall even if a patch doesn't make sense
> > Yajun, thanks for this, it's really made me think about this case (+ others
> > like it) :)

I guess maybe again I've not been clear enough on this, so unless
compelling reasoning can otherwise be provided, I feel this check should
not be added _anywhere_.

Therefore, NACK.

