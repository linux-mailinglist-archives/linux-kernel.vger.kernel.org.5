Return-Path: <linux-kernel+bounces-26285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 827E682DE18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CB5B219E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26617C6F;
	Mon, 15 Jan 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BOOQpadg"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03C17C62
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso9041418e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705338026; x=1705942826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7KEoK+1CRfcxOv4zohzgJAUEx7vXNF1GS75PwQJz80=;
        b=BOOQpadgJUHHrx3n97+YX8uRPZDS1MS51pjBQ61mGWid0ZU28GAqGy55+mbBDZCkon
         AvwoTFkGGA7Cjb9o4KOcUgavZ8Oxg3UL9MK/AIJ/ICgeK17i7oM6dx7yeloT35TvPR72
         lZL90BYCf9bnbLlqWQ68zkzFkg87e2Xydqc6Msg4G1ub7FSINRoTRU+YTEsy298lGI1z
         KLGcb96zex5HmkGhSHJ5hMnDgxEHCcHDU6knemG8F6it31cd/+VkTVG7rffxriDdIzni
         SvqfZU0LPVX7ffOHnyrldy3Ts2TcjJDpXs26zkzk+8cIRjV+sGkwqpq/RCzw35re4bod
         3K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338026; x=1705942826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7KEoK+1CRfcxOv4zohzgJAUEx7vXNF1GS75PwQJz80=;
        b=RCk86D4YqRjBe0wszRacX9uHeV34x+ejHNf+TgzT5VzXS+3pbwU70YxvXchpBBF4uA
         DYx3UFPjjLrs5NczbuvfR88M6/iQvvY4dckQviwJDPErzt7rWqHB5oSaAVybpEQh8/mv
         skvj5e62Jv8HCA/D3hX1kMWz6oDW0yn6HTTlvrojwGTxNKtVKmA9UNeIOyf4bLOhLU2J
         3bDzvjH0uiFrfcOIUFhDQAbr14ZwpC+6myRMxiJZRiBceAGiAVV36cN7vN4K7aYtBskG
         Cbwin1E3AZPOn3l4tizXBNMhtnfr1WWVm4W2s7iNctGQRvCbhNu40g/dXYg7zsv2l8WU
         zOUQ==
X-Gm-Message-State: AOJu0Yz9xPpCo8RVjmA4ykd9tN0LpYS5/kvrJRoCfzn50uqQdke4INqK
	6QLderS+Om/h45owapPbPoYCu64DVMj5sGhvMYH3+ZO9Y5w=
X-Google-Smtp-Source: AGHT+IHaclMSWPVq+Hl2GVovpszCuGHzbkwMERBzAayU28UN7jAtc8m5z28/pPBqAbuPsBoWBQhzPg==
X-Received: by 2002:a19:f617:0:b0:50e:696e:150e with SMTP id x23-20020a19f617000000b0050e696e150emr2343432lfe.7.1705338026548;
        Mon, 15 Jan 2024 09:00:26 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d3-20020a170906544300b00a2693ce340csm5437609ejp.59.2024.01.15.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:00:26 -0800 (PST)
Date: Mon, 15 Jan 2024 18:00:24 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH printk v3 04/14] printk: ringbuffer: Do not skip
 non-finalized records with prb_next_seq()
Message-ID: <ZaVkqJ-KMRp9mbLR@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-5-john.ogness@linutronix.de>
 <ZaF_eJ_BCddZl5z1@alley>
 <874jfeg69z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jfeg69z.fsf@jogness.linutronix.de>

On Mon 2024-01-15 13:01:36, John Ogness wrote:
> On 2024-01-12, Petr Mladek <pmladek@suse.com> wrote:
> >>  u64 prb_next_seq(struct printk_ringbuffer *rb)
> >>  {
> >> -	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> >> -	enum desc_state d_state;
> >> -	unsigned long id;
> >>  	u64 seq;
> >>  
> >> -	/* Check if the cached @id still points to a valid @seq. */
> >> -	id = atomic_long_read(&desc_ring->last_finalized_id);
> >> -	d_state = desc_read(desc_ring, id, NULL, &seq, NULL);
> >> +	seq = desc_last_finalized_seq(rb);
> >
> > desc_last_finalized_seq() does internally:
> >
> > 	ulseq = atomic_long_read_acquire(&desc_ring->last_finalized_seq
> > 					); /* LMM(desc_last_finalized_seq:A) */
> >
> >
> > It guarantees that this CPU would see the data which were seen by the
> > CPU which updated desc_ring->last_finalized_seq.
> >
> > So far so good.
> >
> > The problem is that I somehow miss the counter part. Maybe,
> > it is not needed. It just looks strange.
> 
> As the comments in desc_last_finalized_seq() state: "This pairs with
> desc_update_last_finalized:A."
> 
> desc_update_last_finalized() successfully reads a record and then uses a
> cmpxchg_release() to set the new @last_finalized_seq value (of the
> record it just read). That is the counter part.
> 
> >> -	if (d_state == desc_finalized || d_state == desc_reusable) {
> >> -		/*
> >> -		 * Begin searching after the last finalized record.
> >> -		 *
> >> -		 * On 0, the search must begin at 0 because of hack#2
> >> -		 * of the bootstrapping phase it is not known if a
> >> -		 * record at index 0 exists.
> >> -		 */
> >> -		if (seq != 0)
> >> -			seq++;
> >> -	} else {
> >> -		/*
> >> -		 * The information about the last finalized sequence number
> >> -		 * has gone. It should happen only when there is a flood of
> >> -		 * new messages and the ringbuffer is rapidly recycled.
> >> -		 * Give up and start from the beginning.
> >> -		 */
> >> -		seq = 0;
> >> -	}
> >> +	/*
> >> +	 * Begin searching after the last finalized record.
> >> +	 *
> >> +	 * On 0, the search must begin at 0 because of hack#2
> >> +	 * of the bootstrapping phase it is not known if a
> >> +	 * record at index 0 exists.
> >> +	 */
> >> +	if (seq != 0)
> >> +		seq++;
> >>  
> >>  	/*
> >>  	 * The information about the last finalized @seq might be inaccurate.
> >
> > Below is the code:
> >
> > 	while (_prb_read_valid(rb, &seq, NULL, NULL))
> > 		seq++;
> >
> > Maybe, the release() should be here to make sure that the CPU which
> > would see this "seq" would also the data.
> 
> The acquire is with @last_finalized_seq. So the release must also be
> with @last_finalized_seq. The important thing is that the CPU that
> updates @last_finalized_seq has actually read the corresponding record
> beforehand. That is exactly what desc_update_last_finalized() does.

I probably did not describe it well. The CPU updating @last_finalized_seq
does the right thing. I was not sure about the CPU which reads
@last_finalized_seq via prb_next_seq().

To make it more clear:

u64 prb_next_seq(struct printk_ringbuffer *rb)
{
	u64 seq;

	seq = desc_last_finalized_seq(rb);
	      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	      |
	      `-> This includes atomic_long_read_acquire(last_finalized_seq)


	if (seq != 0)
		seq++;

	while (_prb_read_valid(rb, &seq, NULL, NULL))
		seq++;

	return seq;
}

But where is the atomic_long_read_release(last_finalized_seq) in
this code path?

IMHO, the barrier provided by the acquire() is _important_ to make sure
that _prb_read_valid() would see the valid descriptor.

Now, I think that the related read_release(seq) is hidden in:

static int prb_read(struct printk_ringbuffer *rb, u64 seq,
		    struct printk_record *r, unsigned int *line_count)
{
	/* Get a local copy of the correct descriptor (if available). */
	err = desc_read_finalized_seq(desc_ring, id, seq, &desc);

	/* If requested, copy meta data. */
	if (r->info)
		memcpy(r->info, info, sizeof(*(r->info)));

	/* Copy text data. If it fails, this is a data-less record. */
	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, info->text_len,
		       r->text_buf, r->text_buf_size, line_count)) {
		return -ENOENT;
	}

	/* Ensure the record is still finalized and has the same @seq. */
	return desc_read_finalized_seq(desc_ring, id, seq, &desc);
	       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	       |
	       `-> This includes a memory barrier /* LMM(desc_read:A) */
		   which makes sure that the data are read before
		   the desc/data could be reused.
}

I consider this /* LMM(desc_read:A) */ as a counter part for that
acquire() in prb_next_seq().


Summary:

I saw atomic_long_read_acquire(last_finalized_seq) called from
prb_next_seq() code path. The barrier looked important to me.
But I saw neither the counter-part nor any comment. I wanted
to understand it because it might be important for reviewing
following patches which depend on prb_next_seq().

Does it make sense now, please?

Best Regards,
Petr


