Return-Path: <linux-kernel+bounces-55370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8D84BBD6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AE91C211A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A394134C6;
	Tue,  6 Feb 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M/U57joK"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAC134BC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240446; cv=none; b=UFEQmZd1sMPp7smf+iIgUAt0KOAQGeZVECpsmcBFF+0WH3oL5GT0tZzB7yR3U4RCOr8+uF9EZgIhPcrB++pro1PhaYkH7KKUfQ6zp8cIlYRyq+NZg0iCmmALAs1kRQEXK1KgrWeqp52RAasGdDFOuwDKQD0l6Y36F3lgGu8X75w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240446; c=relaxed/simple;
	bh=z3SvTIWCBj3dDHZAf/+OxWygHM3oDaa1MoxvXSwg+sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR8ErcP5tGFUrsXYNmi7bIN6KXU5yw+B/6E6vDz9hYFBKFWJ8hPw2whjMCcbJFVfKrxKdvIFXiGXmMW6D1/dznVj64ignl6587o0nC8XQUcNWVt49vI1g3Ql6imQvd+RMfDAiXGlQxOuBGf8M9AAHIv6+RVjE3f3RJTFn4xAVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M/U57joK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so713212966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707240441; x=1707845241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/HHEhgM2zyiBgcEROBuZtDDunDwNkAdKGtbKx2KyjY=;
        b=M/U57joKUZxQWqWlL4tQfIBnSNUGe0clXVceCFhNtlI7s0xqOTEkx/hqrWyKvAnjJB
         UGL29wXdeWTnT9liXEH18lFA9/jxXFgmTamP0coOxp72vXRiJAostZSeFuVwuWd2a6/D
         5csFlL4gbRc0RtmoCiGJM2jZMkmZVPx464QEzH8ImSfqNuKI8AUHh3UGpWeofs8GZiS+
         VeHi12LpnjUnHNSXx/c/+lTpvgCdmvzUYeLKPpEl3foptoYGbRyW18JB/W1rqL2Faodn
         JWGQSOYIvZC6WEab/ssNHmHs1cdv2EpWbf0gJmQEG/oyIZVv5SqI4M3Bq7+JXXj/37KB
         J8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240441; x=1707845241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/HHEhgM2zyiBgcEROBuZtDDunDwNkAdKGtbKx2KyjY=;
        b=HWX6R/VSMEIIPosVNfxmv3YoowNbkKzhBmc2sgqyuI+ISXCwnkBNvEmzYilIhmKHjQ
         ZcwAEW3KW7wTIG3s5f+8CNzMAbVKJtgDN8JWLJiCpcR2gVZZUJk0XULDOrm5aXNHJDe+
         bLpip6+UO7mvz2W8pRcZfx4XJ2BdghtkfUvYaks/SXR1HEyDTbeYxSjRjuxJaZUQfZlT
         YEp8Q/+YGvpBJdoz6epXBSICMpixO2nJU/sC0XWRB9vXMah513hWFT6ng8NuTfIo+0dT
         nytLoo5/kEqOs6VWyyV7/R9BG1sPSI+jRQhkeDeExQwWmLUS4/OFVRgHEYtpcfqGbmep
         SsSQ==
X-Gm-Message-State: AOJu0YyEjKVAgQTP9O5ivMjjntX2mzO5Og8ON56DHKxi6DVhRdLPlmcT
	xcUvsbVJw1pphagSIEaG0B+Wz8kWL5J5/9OvrV4XpYSHK/t0Us4C+ijSXBi9+Zw=
X-Google-Smtp-Source: AGHT+IGfVu/ZBOOxuOcGwmvBZ4iF9m3PcOLU1nxdvt6/JYZGoYtRfUr7B+duPImLoW2eHhAmAajKpA==
X-Received: by 2002:a17:906:f755:b0:a35:b73b:e626 with SMTP id jp21-20020a170906f75500b00a35b73be626mr1925264ejb.73.1707240441397;
        Tue, 06 Feb 2024 09:27:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5bVdrZFCXJBGCILai2TbcoVqgbrrHESlvvF0YiYv4UEPI+9HgpbkPRoFDDyuNITy/SbqZdnC8Z3dAdj3KspcR2pT5+JkVt+o5XJrd96BagA2MKF1lG3UhYqOXCV+lsMP/6ge+AThUduWXBke9vEMe5dk0FH/mK8CKot2UaZCWDZg0dNi3//MJHS88G1c=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906248900b00a3687cde34asm1370309ejb.5.2024.02.06.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:27:21 -0800 (PST)
Date: Tue, 6 Feb 2024 18:27:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH printk v3 04/14] printk: ringbuffer: Do not skip
 non-finalized records with prb_next_seq()
Message-ID: <ZcJr931mCz-JdoJh@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-5-john.ogness@linutronix.de>
 <ZaF_eJ_BCddZl5z1@alley>
 <874jfeg69z.fsf@jogness.linutronix.de>
 <ZaVkqJ-KMRp9mbLR@alley>
 <871q9rp2lx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q9rp2lx.fsf@jogness.linutronix.de>

On Mon 2024-02-05 12:39:30, John Ogness wrote:
> On 2024-01-15, Petr Mladek <pmladek@suse.com> wrote:
> >> The acquire is with @last_finalized_seq. So the release must also be
> >> with @last_finalized_seq. The important thing is that the CPU that
> >> updates @last_finalized_seq has actually read the corresponding
> >> record beforehand. That is exactly what desc_update_last_finalized()
> >> does.
> >
> > I probably did not describe it well. The CPU updating
> > @last_finalized_seq does the right thing. I was not sure about the CPU
> > which reads @last_finalized_seq via prb_next_seq().
> >
> > To make it more clear:
> >
> > u64 prb_next_seq(struct printk_ringbuffer *rb)
> > {
> > 	u64 seq;
> >
> > 	seq = desc_last_finalized_seq(rb);
> > 	      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 	      |
> > 	      `-> This includes atomic_long_read_acquire(last_finalized_seq)
> >
> >
> > 	if (seq != 0)
> > 		seq++;
> >
> > 	while (_prb_read_valid(rb, &seq, NULL, NULL))
> > 		seq++;
> >
> > 	return seq;
> > }
> >
> > But where is the atomic_long_read_release(last_finalized_seq) in
> > this code path?
> 
> read_release? The counterpart of this load_acquire is a
> store_release. For example:
> 
> CPU0                     CPU1
> ====                     ====
> load(varA)
> store_release(varB)      load_acquire(varB)
>                          load(varA)
> 
> If CPU1 reads the value in varB that CPU0 stored, then it is guaranteed
> that CPU1 will read the value (or a later value) in varA that CPU0 read.
> 
> Translating the above example to this particular patch, we have:
> 
> CPU0: desc_update_last_finalized()       CPU1: prb_next_seq()
> ====                                     ====
> _prb_read_valid(seq)
> cmpxchg_release(last_finalized_seq,seq)  seq=read_acquire(last_finalized_seq)
>                                          _prb_read_valid(seq)

I think that I was confused because I had acquire/release mentally
connected with lock/unlock. Where the lock/unlock surrounds some
critical code section. I think that it is actually the most common
usecase.

Our usage is not typical from my POV. There are two aspects:

   1. They do not surround a critical section, at least not
      an obvious one.

   2. In my mental code, this patch patch uses the release
      before the acquire. When I think about this code,
      than I first imagine the write path (using release)
      and then the reader (using acquire).

I think that this code (mis)uses the acquire/release
semantic just for optimized memory barriers.

It might be worth a note that this is not a typical acquire/release
scenario.

> > IMHO, the barrier provided by the acquire() is _important_ to make
> > sure that _prb_read_valid() would see the valid descriptor.
> 
> Correct.
> 
> > Now, I think that the related read_release(seq) is hidden in:
> >
> > static int prb_read(struct printk_ringbuffer *rb, u64 seq,
> > 		    struct printk_record *r, unsigned int *line_count)
> > {
> > 	/* Get a local copy of the correct descriptor (if available). */
> > 	err = desc_read_finalized_seq(desc_ring, id, seq, &desc);
> >
> > 	/* If requested, copy meta data. */
> > 	if (r->info)
> > 		memcpy(r->info, info, sizeof(*(r->info)));
> >
> > 	/* Copy text data. If it fails, this is a data-less record. */
> > 	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, info->text_len,
> > 		       r->text_buf, r->text_buf_size, line_count)) {
> > 		return -ENOENT;
> > 	}
> >
> > 	/* Ensure the record is still finalized and has the same @seq. */
> > 	return desc_read_finalized_seq(desc_ring, id, seq, &desc);
> > 	       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 	       |
> > 	       `-> This includes a memory barrier /* LMM(desc_read:A) */
> > 		   which makes sure that the data are read before
> > 		   the desc/data could be reused.
> > }
> >
> > I consider this /* LMM(desc_read:A) */ as a counter part for that
> > acquire() in prb_next_seq().
> 
> desc_read:A is not a memory barrier. It only marks the load of the
> descriptor state.

I see. The real read barriers are desc_read:B and desc_read:D

> This is a significant load because prb_next_seq() must
> see at least the descriptor state that desc_update_last_finalized() saw.
> 
> The memory barrier comments in desc_update_last_finalized() state:
> 
>     * If desc_last_finalized_seq:A reads from
>     * desc_update_last_finalized:A, then desc_read:A reads from
>     * _prb_commit:B.
> 
> This is referring to a slightly different situation than the example I
> used above because it is referencing where the descriptor state was
> stored (_prb_commit:B). The same general picture is valid:
> 
> CPU0                              CPU1
> ====                              ====
> _prb_commit:B
> desc_update_last_finalized:A      desc_last_finalized_seq:A
>                                   desc_read:A
> 
> desc_read:A is loding the descriptor state that _prb_commit:B stored.
> 
> The extra note in the comment clarifies that _prb_commit:B could also be
> denoted as desc_read:A because desc_update_last_finalized() performs a
> read (i.e. must have seen) _prb_commit:B.
> 
>     * Note: _prb_commit:B and desc_update_last_finalized:A can be
>     *       different CPUs. However, the desc_update_last_finalized:A
>     *       CPU (which performs the release) must have previously seen
>     *       _prb_commit:B.
> 
> Normally the CPU committing the record will also update
> last_finalized_seq. But it is possible that another CPU updates
> last_finalized_seq before the committing CPU because it already sees the
> finalized record. In that case the complete (maximally complex) picture
> looks like this.
> 
> CPU0            CPU1                           CPU2
> ====            ====                           ====
> _prb_commit:B   desc_read:A
>                 desc_update_last_finalized:A   desc_last_finalized_seq:A
>                                                desc_read:A
>
> Any memory barriers in _prb_commit() or desc_read() are irrelevant for
> guaranteeing that a CPU reading a sequence value from
> desc_last_finalized_seq() will always be able to read that record.

I believe that they are relevant exactly because 3 CPUs might be
involved here. I believe that

  + _prb_commit:B makes sure that CPU0 stores all data before
    setting the state as finalized.

  + desc_read:B makes sure that CPU1 will see all data written
    when it reads the finalized state.

  + desc_update_last_finalized:A makes sure that saw the record
    with the given seq in finalized state.

  + desc_last_finalized_seq:A makes sure that it sees the record
    associated with "last_finalized_seq" in the finalized state.

This is why the "Note:" is very important. And maybe desc_read:B
or desc_read:D should be mentioned in the note as well.

Also all these dependencies are really hard to follow. This
is why I suggested to add another note in the 9th patch,
see https://lore.kernel.org/all/ZbowlkOVWiSgCxNX@alley/

Or maybe we should document that pr_read() and _prb_read_valid()
provides these guarantees and just reference it here.

By another words. IMHO, the current "Note:" tries to
prove that _prb_read_valid() guarantees that all data
can be read when it sees the finalized state. IMHO,
we should document this above these functions and
just reference it here.

The current comments for desc_update_last_finalized:A
and prb_next_reserve_seq:A are really hard to follow
because they both try to explain these transitional
guarantees between prb_commit() and prb_read() APIs.
The comments mention many barriers even though the guarantees
should be there by design and should be mentioned
in the prb_read() API.

My motivation is that it took me long time to understand this.
And I am still not sure if I understand it correctly.
IMHO, it might be better to describe some guarantees of
upper level API so that we do not need to look at
the low level barriers again and again.

Best Regards,
Petr

