Return-Path: <linux-kernel+bounces-56288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A13C84C854
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2938D1C23D07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7004B25611;
	Wed,  7 Feb 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZjYl8/kb"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2C250E0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300682; cv=none; b=puExQHfa0cotCkQ1NSNU4FpzZ6QGc0Zxec/YsF9deCAkx6JZXcEe7A39d+vjyJa8g5T2Dw+NHP3PXdFYlXziyvRvN36yRI081nCvPnuC7IuBP5iy2Tpq20B/j2IQsplDJMEgbJ1aMEgmzeDwE8qNckfKHebo9EZD2e3RgyvToEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300682; c=relaxed/simple;
	bh=n5Xh+vbjD8NYGOPRuedCrFHR9pHohoqUseQDPK69RDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqPBkrzPJGoY9Xq2PW+pq6QsBNf1o+pvI27p0s+EMSLcERNzwn4xQjgedGltx/Pi7l+10fQfIh7VSxELFb75pNWFiWzly6im3dJxg7XfftO3j5MQ18NfKm11CAETSkNBxEA6AurPeJcFPeqjbVE2ITasZftatM2t/NqFFFAkeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZjYl8/kb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3832a61a79so51139166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707300677; x=1707905477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/4lC9UqJd85mLw2RszDX5scYsYV0+T2mSxomkF60Ow=;
        b=ZjYl8/kbRnOJteUYbvrxJKEROI9SkwhlY0KUlmrZQGudyQF3osP1eMj/MV2odLRymb
         wbHdnn4zGHv19ELofNgrbA401CKpwFVqsP0u06sywNZub4+peJjuha9iZhjorJM5+e+M
         llnJNOtnNYl2DorYov/FMp8AcPFeEMxc5DldDW1MZ8CDyR8thr59bDWEiSTzji4gRyV1
         uQAtAdgWrQs/0/ORQ4Gd8/mUdrs6ntFu8WJW3rbYRGxLcflYVvWMOyUr8g2kGX8LWQQu
         nNSNxJR2N9Q8q1QezxU4sm3xT6+F/xxA/F50KAVplQBYr8ki9Qbg8a9xUQSM//AVntID
         rt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707300677; x=1707905477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/4lC9UqJd85mLw2RszDX5scYsYV0+T2mSxomkF60Ow=;
        b=q9a85wef0yWtoL4+ixeYflOG/uNEu+j1Qf4PA4j0x+2JvA9H26bbQNw97XCyRhTa8y
         klScCedU2xsRTxmfA4uETVEoO5hNQvskVJtmfnFij0lv2q865qS/8OvOTuoQyKUhVRKa
         gORiVzwU4O1VNkO2awwmt/j76ty6y41Bl6oI/Bmf3LCP6XclUiRbIY/kdTmwF/H3J0wA
         SZQYmgN7BFmY98jtHirHLxTAKblD0wW5XZdWkF60GH0gBGPCwEhwAcQVdBiomKV1RdL4
         dwQJyaPFI/8iYEJTcUtdWa5M8Igv7UE7C0IxIrudrA5JankNQtsCkcI2GyEWSieqQldk
         yHJA==
X-Gm-Message-State: AOJu0Yzc0kx70dCvDRWk1i3Q6kR1Z5Oy2eqb2mXgv97BszDP7szlLRrD
	7PIsJA/ZlhvTo0sflodQy1oxgsMkeXU/0nA3oVKZNcc6rPTF+wYJNozoYrS1Wrg=
X-Google-Smtp-Source: AGHT+IFWKQav4R5uVBdZpgHSIXLdwroT5wrhWfoXMeAp4ygKopdqO6HRhzcTKKFdNnUCLI/WrrqwZQ==
X-Received: by 2002:a17:906:cc99:b0:a38:24dd:f44f with SMTP id oq25-20020a170906cc9900b00a3824ddf44fmr3299565ejb.65.1707300676992;
        Wed, 07 Feb 2024 02:11:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrg9raypcSsjQyIHSAy+eoZN8uAIPMZpcU8Uyp56wi5SCnq1E2daXLVXdCb/DN0Cm/lN0UXYvqp7nPc7HSRNXehHcoJlBi1DTypSLze0xGOANQ/nCdBuI5LkwigTDEqWJP074BIuj/iQck+v20XozNWXFs/kE=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906264800b00a3860356f42sm595530ejc.19.2024.02.07.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:11:16 -0800 (PST)
Date: Wed, 7 Feb 2024 11:11:15 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 11/14] printk: ringbuffer: Consider committed
 as finalized in panic
Message-ID: <ZcNXQ3qZBdyB7GmK@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-12-john.ogness@linutronix.de>
 <ZbvcJwsIEsii3oi2@alley>
 <87v873ngvl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v873ngvl.fsf@jogness.linutronix.de>

On Mon 2024-02-05 15:14:14, John Ogness wrote:
> On 2024-02-01, Petr Mladek <pmladek@suse.com> wrote:
> > On Thu 2023-12-14 22:47:58, John Ogness wrote:
> >> A descriptor in the committed state means the record does not yet
> >> exist for the reader. However, for the panic CPU, committed
> >> records should be handled as finalized records since they contain
> >> message data in a consistent state and may contain additional
> >> hints as to the cause of the panic.
> >> 
> >> Add an exception for records in the commit state to not be
> >> considered non-existing when reading from the panic CPU.
> >
> > IMHO, it is important to describe effects of this change in more
> > details. And I think that it actually does not work as expected,
> > see below.
> 
> I reviewed my notes from our meeting in Richmond. We had agreed that
> this feature should not apply to the latest message. That would change
> the commit message to be as follows:
> 
>     printk: ringbuffer: Consider committed as finalized in panic
>     
>     A descriptor in the committed state means the record does not yet
>     exist for the reader. However, for the panic CPU, committed
>     records should be handled as finalized records since they contain
>     message data in a consistent state and may contain additional
>     hints as to the cause of the panic.
>     
>     The only exception is the last record. The panic CPU may be
>     usig LOG_CONT and the individual pieces should not be printed
>     separately.

This was my first understanding. But then I realized that appended
pieces would not be printed at all when a committed part
was printed.

And it might be even worse. I have realized yesterday that an
attempt to print the last record in the committed state might
cause missing the trailing '\0' in the copied data. Just imagine
the following race:

CPU0				CPU1

prb_read()
  // read last record in committed state
  copy_data(.., info->text_len)

				prb_reserve_in_last()
				printk_sprint(&r.text_buf[0], reserve_size, ...
				prb_commit()

     // copy data_size before appending
     // from already appended buffer
     // The trailing '\0' is not in the copied part
     memcpy(&buf[0], data, data_size);

BANG: CPU0 would try to use a string without the trailing '\0'.

We should probably add a sanity check and fixup for this potential
problem.


>     Add a special-case check for records in the commit state to not
>     be considered non-existing when reading from the panic CPU and
>     it is not the last record.
>
> >> --- a/kernel/printk/printk_ringbuffer.c
> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> @@ -1875,16 +1877,25 @@ static int desc_read_finalized_seq(struct prb_desc_ring *desc_ring,
> >>  
> >>  	/*
> >>  	 * An unexpected @id (desc_miss) or @seq mismatch means the record
> >> -	 * does not exist. A descriptor in the reserved or committed state
> >> -	 * means the record does not yet exist for the reader.
> >> +	 * does not exist. A descriptor in the reserved state means the
> >> +	 * record does not yet exist for the reader.
> >>  	 */
> >>  	if (d_state == desc_miss ||
> >>  	    d_state == desc_reserved ||
> >> -	    d_state == desc_committed ||
> >>  	    s != seq) {
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> +	/*
> >> +	 * A descriptor in the committed state means the record does not yet
> >> +	 * exist for the reader. However, for the panic CPU, committed
> >> +	 * records are also handled as finalized records since they contain
> >> +	 * message data in a consistent state and may contain additional
> >> +	 * hints as to the cause of the panic.
> >> +	 */
> >> +	if (d_state == desc_committed && !this_cpu_in_panic())
> >> +		return -EINVAL;
> 
> And this code would change to:
> 
> +	/*
> +	 * A descriptor in the committed state means the record does not yet
> +	 * exist for the reader. However, for the panic CPU, committed
> +	 * records are also handled as finalized records since they contain
> +	 * message data in a consistent state and may contain additional
> +	 * hints as to the cause of the panic. The only exception is the
> +	 * last record, which may still be appended by the panic CPU and so
> +	 * is not available to the panic CPU for reading.
> +	 */
> +	if (d_state == desc_committed &&
> +	    (!this_cpu_in_panic() || id == atomic_long_read(&desc_ring->head_id))) {
> +		return -EINVAL;
> +	}

This is clever.

Well, it would help only with a very small race window. Older
records are automatically finalized when committed. It is because
they could not be reopened. See prb_commit().

> > If I get it correctly, this causes that panic CPU would see a
> > non-finalized continuous line as finalized. And it would flush
> > the existing piece to consoles.
> >
> > The problem is that pr_cont() would append the message into
> > the same record. But the consoles would already wait
> > for the next record. They would miss the appended pieces.
> 
> Exactly. That is why we said that the last message would not be
> available. Maybe this new version is acceptable.
> 
> > Honestly, I think that it is not worth the effort. It would add
> > another complexity to the memory barriers. The real effect is not easy
> > to understand. And the benefit is minimal from my POV.
> 
> I am OK with dropping this patch from the series. It is questionable how
> valuable a LOG_CONT piece from a non-panic CPU is anyway. And if the
> non-panic CPU managed to reopen the record, it would be skipped anyway.
> 
> I will drop this patch unless you want to keep the new version.

Honestly, I would drop it. It is kind of tricky code. And it would
help only with a very small race window with messages from
non-panic() CPUs. Especially with the 14th patch which
blocks messages from other CPUs during panic() anyway.

Best Regards,
Petr

