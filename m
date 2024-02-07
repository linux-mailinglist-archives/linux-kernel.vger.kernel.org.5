Return-Path: <linux-kernel+bounces-56188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90A84C727
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D501C1F25974
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873C2210EC;
	Wed,  7 Feb 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JVBFPqdw"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411420DCC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297625; cv=none; b=SmPqDA8kK8nvvW8jC/7T9iEimbwHmUcVqkhY/A17un/AyAD1D9DI8a9+peUhDClD1jXjsyQLlzlXFfNgsvHyDI0eIxnmb5dd1Omo9HEyEVoJ0ywsxHjvA9CguFuiF4c7ehsUGCQdiNGd4mCtK4ZitoPGpZtl9Rmm0mLQZc5iwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297625; c=relaxed/simple;
	bh=95US5Bry8ta5OEd6eEVd0gOFFok1XZEXloks+CN3KJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXzYsKx/9sUwf6EUiK5UasduY10rHb2lEOwrcVJ+eLyjQTC/GuG2k923+E8+gaob/0E1nJJRBwbF2aO3Z0dKJpHC7F74YLjsAywOSjK5IOZ45fjEoXmTVljmQUx+qGWF3b2hdQHy62SadTB4JRcurgsIMq2NT6IFQXjgBZ50pUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JVBFPqdw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a37878ac4f4so49229466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707297621; x=1707902421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6LAyjJAkdZ4pS3ypf47UTM6Qe5HmDg2tiLAggF/HJ4=;
        b=JVBFPqdws4loMdY/NqlBLt96bf484flaOwD498BeZmgGsEvRe+kM9ogEzyPuYf6F+N
         SvKBR1SWLpXxOstED7mEJPsVUc0lok6KpGQIsx1aoXCgR0qWgIUaAVJyw7/thwrh0K0w
         XDiMwKM9rajLmopZ6WuUGMAUUDgIByzda9OlskFOByOiRgz2OeYwEERcUgwsDjatMJYS
         9x//OhAqdGfHCzM7azX6K3FHE3zN1jVbhMqv8qtQBINk8KSNHgBh744qK7LKlptrj2kV
         CsGUp8ue1BqaFV7M4DH+fjIYuSAoCOvvcLGPiNG0A63k+Nbe/d03nzEPCsEhefEF0mQ5
         9jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297621; x=1707902421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6LAyjJAkdZ4pS3ypf47UTM6Qe5HmDg2tiLAggF/HJ4=;
        b=TFH2y3PI/uzZUMGt+LbKjvxJj49ZKCx11iIfLQ++gyKfOwGx3qCZKUvgE5U4/iuogd
         hePXcRGJjoHsU6L2AGauhxpiXY/U+zrEBQ++0L1+13WzWDVkvwB1orZ30zlW/32EHLLH
         AXzJ8lyMAcIBXdme5XN9O4owtBKJO/ni5CwGD/c+fg+SMh3EXqnRl2XYLMzPEfjgfHKx
         L4KJ6Wpx3/KCMH1BlPXuvDOIyg3L+g6prna36MhxzH2qtIXQldyCuJY/xKGoZTn0xCcR
         pkzgKZup9ovCXOp6Z0wrWp32MVttwiwr5S9V6QLIguBbG0GvHvghNzQRe4CEDb81hSOq
         YUEw==
X-Gm-Message-State: AOJu0Yw7WyIWlPifsIBQAU1OXfGvc4YDn0it4fsino7JY0ndtwFI4Cu6
	T66HTbaJUwiR1gyoJGGh0LTc8Ydij2bLAKKlabn+DlPbl5pc+DNZYFq6ia7KL/o=
X-Google-Smtp-Source: AGHT+IE0WTzJt8mskCiQyaa5+K2iTcUUhhePnWZaNwIWSVRVmWxM8hY4BqDNBinQlZ1MOP5GLnYfIA==
X-Received: by 2002:a17:907:1de1:b0:a38:929d:b6ff with SMTP id og33-20020a1709071de100b00a38929db6ffmr55528ejc.77.1707297621258;
        Wed, 07 Feb 2024 01:20:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkQqsYL8jLO5d7z5SWG5LMTB+mZP1osevZZA3dnX+mztNdzyufRe7LLcndtBiDrw/A7RlGf7eVDpXJcljimjM5Te0LejetpbrwWRVosUTqFpLjK9NFpw6+qGiH/hzcdoCS/8RanrQP425OysSB670KBDSMOws=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id vg11-20020a170907d30b00b00a37210f1e92sm538503ejc.205.2024.02.07.01.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:20:20 -0800 (PST)
Date: Wed, 7 Feb 2024 10:20:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 09/14] printk: Wait for all reserved records
 with pr_flush()
Message-ID: <ZcNLU8g479-SEqrY@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-10-john.ogness@linutronix.de>
 <ZbowlkOVWiSgCxNX@alley>
 <87y1bznii8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1bznii8.fsf@jogness.linutronix.de>

On Mon 2024-02-05 14:39:03, John Ogness wrote:
> On 2024-01-31, Petr Mladek <pmladek@suse.com> wrote:
> >> +	last_finalized_seq = desc_last_finalized_seq(rb);
> >> +
> >> +	/*
> >> +	 * @head_id is loaded after @last_finalized_seq to ensure that it is
> >> +	 * at or beyond @last_finalized_seq.

Maybe we could do it the following way. I would slightly update the
above comment:

	 * @head_id is loaded after @last_finalized_seq to ensure that
	 * it points to the record with @last_finalized_seq or newer.

I have got it even from the previous record but I had to think about
it a  bit. You always wanted to make a difference between the IDs
and sequence numbers.

Anyway, this comment makes the safety kind of obvious.

@head_id always have to be updated when the related record is reserved.
And all other CPUs have to see it so that they have to bump @head_id
for a newer record.

And @last_finalized_seq points to an already finalized record.
If a record is finalized then other CPUs must be able to
read valid data.

Maybe, we should add the two above paragraphs into the human
readable part of the comment as well. They describe some
basics of the design. Everything would blow up when
neither of them is true.

My motivation is that a good human friendly description
helps to understand what the code does and that it is
"obviously" correct.

I agree that the below precise description is useful.
But people should need it only when they want to prove
or revisit the human friendly claim.

> >> +	 *
> >> +	 * Memory barrier involvement:
> >> +	 *
> >> +	 * If desc_last_finalized_seq:A reads from
> >> +	 * desc_update_last_finalized:A, then
> >> +	 * prb_next_reserve_seq:A reads from desc_reserve:D.
> >> +	 *
> >> +	 * Relies on:
> >> +	 *
> >> +	 * RELEASE from desc_reserve:D to desc_update_last_finalized:A
> >> +	 *    matching
> >> +	 * ACQUIRE from desc_last_finalized_seq:A to prb_next_reserve_seq:A
> >> +	 *
> >> +	 * Note: desc_reserve:D and desc_update_last_finalized:A can be
> >> +	 *       different CPUs. However, the desc_update_last_finalized:A CPU
> >> +	 *       (which performs the release) must have previously seen
> >> +	 *       desc_read:C, which implies desc_reserve:D can be seen.
> >
> > The most tricky part is desc_reserve:D. It is a supper complicated
> > barrier which guarantees many things. But I think that there are
> > many more write barriers before the allocated descriptor reaches
> > finalized state. So that it should be easier to prove the correctness
> > here by other easier barriers.
> 
> Yes, desc_reserve:D provides memory barriers for several orderings. But
> it is _not_ providing a memory barrier for this ordering. It only marks
> where @head_id is stored.
> 
> The only memory barriers involved here are desc_update_last_finalized:A
> and its counterpart desc_last_finalized_seq:A.
> 
> CPU0                                 CPU1
> ====                                 ====
> store(head_id)
> store_release(last_finalized_seq)    load_acquire(last_finalized_seq)
>                                      load(head_id)
> 
> > To make it clear. I am all for keeping the above precise description
> > as is. I just think about adding one more human friendly note which
> > might help future generations to understand the correctness an easier
> > way.  Something like:
> >
> > 	* Note: The above description might be hard to follow because
> > 	*	desc_reserve:D is a multi-purpose barrier. But this is
> > 	*	just the first barrier which makes sure that @head_id
> > 	*	is updated before the reserved descriptor gets finalized
> > 	*	and updates @last_finalized_seq.
> > 	*
> > 	*	There are more release barriers in between, especially,
> > 	*	desc_reserve:F and desc_update_last_finalized:A. Also these make
> > 	*	sure that the desc_last_finalized_seq:A acquire barrier allows
> > 	*	to read @head_id related to @last_finalized_seq or newer.
> 
> Non-global memory barriers must operate on the same memory. In this
> case, the acquire/release memory barriers are operating on
> @last_finalized_seq. The other ordered memory load in this situation is
> for @head_id, so it makes sense to specify the store of @head_id as the
> start of the release block.

I am a bit confused by the "non-global memory barrier" here. I would
expect that acquire()/release() variants provide global barriers.
They are used to implement locking.

Anyway, I am fine with keeping this precise description as is
if we make the correctness more "obvious" from the human friendly
part of the comment.

I am sorry for all the nitpicking. I want to make sure that
the entire comment is correct including the precise part.
This was not easy so I thought about ways to make it easier.
Sigh.

Anyway, I do not want to block the patchset much longer
because of this formal things.

> > BTW: It came to my mind whether the logic might be more
> >      straightforward if we store desc_ring->next_finalized_seq instead
> >      of @last_finalized_seq.
> 
> I thought about this as well. But I felt like the meaning was a bit
> confusing. Also @head_id points to the latest reserved descriptor, so it
> makes the code a bit easier to follow when creating a diff based on the
> latest finalized descriptor.

Fair enough.

Best Regards,
Petr

