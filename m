Return-Path: <linux-kernel+bounces-24949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B2182C52A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5792BB220E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189817C9B;
	Fri, 12 Jan 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="biTqXLQy"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFE17C8D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so727791566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705082747; x=1705687547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LDSE1bgf5fZdyITd7bEipODloewC5Ssd3BWAn/o1ew=;
        b=biTqXLQy6LPYUDRB8XAvuvdquTG6+uVob5FEwT/WRfxTLA+GfRQgU7QxwtLyGutwrA
         /EALWCtxORuKa2PYboCJLoInA6c/aA9B9cL99tkx4VbyTLYyv1lUqhJFQH616Rm2X4Y9
         IQo/El+a8SOqABJj2hWRg5coDFi4EQbSEWMesh5MXFS44mpwA8FtVvFrPhGrfZtSQec/
         k0dvwOQxAPkXBw9dTH9f8l9j0/6O4Ic7dk387lhT3tHaJ/jH5sFqxv3U7a+cs7eG5mec
         WwUi6JJfrGtYRnVgNR9j4JRtGUKw6THf/KwM7XCtxYZUn/YFV4OUNlHVwQokxMJzqf+N
         x7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705082747; x=1705687547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LDSE1bgf5fZdyITd7bEipODloewC5Ssd3BWAn/o1ew=;
        b=Jc3XX5AxrInfdrVX0MMbjnjm1PcmYQWqtB21DQVPPtwOpkM07kGX0rE0+TOkXsqcsZ
         XBvMtsqBosCnJoc7iMLFuvoa5xjtgeIhgBh6aw/E7yQqncXd6mZJvrqiWAoWVm/+dP6o
         9TqyBtV929MNZttGPD+uCV5LjFNjGJWoqeKhCzUHQ2wP5YyPQLK5iTzNoDrJE/ASdtZc
         iGTFpRcyRkcsstsJ8J9MbsT9jggWiyPJGZdDC62vn1ovL7udS1g2rwoh1oxp1t2tGknA
         SRQeD9YQJJ8k58vT6Bwt1MiiO0CIonA1WpcmxFiWxeMQt3BAssvW0h8Z5sCiYDlbE1bA
         sY4w==
X-Gm-Message-State: AOJu0Yxng5EbFsSr+SORqxcLBYQz4r+6g+6B5JQaBJZl868AfsloqA2T
	q4x92vkYs+u7EdDpYHj6Crpe6n0zdNKk4A==
X-Google-Smtp-Source: AGHT+IGt0DSL/avnUOOepPHYN2AIYKyPGFfLVogsAAGSmF6mMEslUGWibIx0v6ddBC1wOmBzp62m6Q==
X-Received: by 2002:a17:906:94e:b0:a2a:dda1:b9e8 with SMTP id j14-20020a170906094e00b00a2adda1b9e8mr894130ejd.138.1705082746596;
        Fri, 12 Jan 2024 10:05:46 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906395100b00a2c29fe8b2esm2014786eje.212.2024.01.12.10.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:05:46 -0800 (PST)
Date: Fri, 12 Jan 2024 19:05:44 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH printk v3 04/14] printk: ringbuffer: Do not skip
 non-finalized records with prb_next_seq()
Message-ID: <ZaF_eJ_BCddZl5z1@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-5-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:51, John Ogness wrote:
> Commit f244b4dc53e5 ("printk: ringbuffer: Improve
> prb_next_seq() performance") introduced an optimization for
> prb_next_seq() by using best-effort to track recently finalized
> records. However, the order of finalization does not
> necessarily match the order of the records. The optimization
> changed prb_next_seq() to return inconsistent results, possibly
> yielding sequence numbers that are not available to readers
> because they are preceded by non-finalized records or they are
> not yet visible to the reader CPU.
> 
> Rather than simply best-effort tracking recently finalized
> records, force the committing writer to read records and
> increment the last "contiguous block" of finalized records. In
> order to do this, the sequence number instead of ID must be
> stored because ID's cannot be directly compared.
> 
> A new memory barrier pair is introduced to guarantee that a
> reader can always read the records up until the sequence number
> returned by prb_next_seq() (unless the records have since
> been overwritten in the ringbuffer).
> 
> This restores the original functionality of prb_next_seq()
> while also keeping the optimization.
> 
> For 32bit systems, only the lower 32 bits of the sequence
> number are stored. When reading the value, it is expanded to
> the full 64bit sequence number using the 32bit seq macros,
> which fold in the value returned by prb_first_seq().
> 
> @@ -1441,20 +1445,118 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
>  	return false;
>  }
>  
> +/*
> + * @last_finalized_seq value guarantees that all records up to and including
> + * this sequence number are finalized and can be read. The only exception are
> + * too old records which have already been overwritten.
> + *
> + * It is also guaranteed that @last_finalized_seq only increases.
> + *
> + * Be aware that finalized records following non-finalized records are not
> + * reported because they are not yet available to the reader. For example,
> + * a new record stored via printk() will not be available to a printer if
> + * it follows a record that has not been finalized yet. However, once that
> + * non-finalized record becomes finalized, @last_finalized_seq will be
> + * appropriately updated and the full set of finalized records will be
> + * available to the printer. And since each printk() caller will either
> + * directly print or trigger deferred printing of all available unprinted
> + * records, all printk() messages will get printed.
> + */
> +static u64 desc_last_finalized_seq(struct printk_ringbuffer *rb)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	unsigned long ulseq;
> +
> +	/*
> +	 * Guarantee the sequence number is loaded before loading the
> +	 * associated record in order to guarantee that the record can be
> +	 * seen by this CPU. This pairs with desc_update_last_finalized:A.
> +	 */
> +	ulseq = atomic_long_read_acquire(&desc_ring->last_finalized_seq
> +					); /* LMM(desc_last_finalized_seq:A) */
> +
> +	return __ulseq_to_u64seq(rb, ulseq);
> +}
> +
> +static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
> +			    struct printk_record *r, unsigned int *line_count);
> +
> +/*
> + * Check if there are records directly following @last_finalized_seq that are
> + * finalized. If so, update @last_finalized_seq to the latest of these
> + * records. It is not allowed to skip over records that are not yet finalized.
> + */
> +static void desc_update_last_finalized(struct printk_ringbuffer *rb)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	u64 old_seq = desc_last_finalized_seq(rb);
> +	unsigned long oldval;
> +	unsigned long newval;
> +	u64 finalized_seq;
> +	u64 try_seq;
> +
> +try_again:
> +	finalized_seq = old_seq;
> +	try_seq = finalized_seq + 1;
> +
> +	/* Try to find later finalized records. */
> +	while (_prb_read_valid(rb, &try_seq, NULL, NULL)) {
> +		finalized_seq = try_seq;
> +		try_seq++;
> +	}
> +
> +	/* No update needed if no later finalized record was found. */
> +	if (finalized_seq == old_seq)
> +		return;
> +
> +	oldval = __u64seq_to_ulseq(old_seq);
> +	newval = __u64seq_to_ulseq(finalized_seq);
> +
> +	/*
> +	 * Set the sequence number of a later finalized record that has been
> +	 * seen.
> +	 *
> +	 * Guarantee the record data is visible to other CPUs before storing
> +	 * its sequence number. This pairs with desc_last_finalized_seq:A.
> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If desc_last_finalized_seq:A reads from
> +	 * desc_update_last_finalized:A, then desc_read:A reads from
> +	 * _prb_commit:B.
> +	 *
> +	 * Relies on:
> +	 *
> +	 * RELEASE from _prb_commit:B to desc_update_last_finalized:A
> +	 *    matching
> +	 * ACQUIRE from desc_last_finalized_seq:A to desc_read:A
> +	 *
> +	 * Note: _prb_commit:B and desc_update_last_finalized:A can be
> +	 *       different CPUs. However, the desc_update_last_finalized:A
> +	 *       CPU (which performs the release) must have previously seen
> +	 *       _prb_commit:B.
> +	 */
> +	if (!atomic_long_try_cmpxchg_release(&desc_ring->last_finalized_seq,
> +				&oldval, newval)) { /* LMM(desc_update_last_finalized:A) */
> +		old_seq = __ulseq_to_u64seq(rb, oldval);
> +		goto try_again;
> +	}
> +}
> +
>  /*
>   * Attempt to finalize a specified descriptor. If this fails, the descriptor
>   * is either already final or it will finalize itself when the writer commits.
>   */
> -static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
> +static void desc_make_final(struct printk_ringbuffer *rb, unsigned long id)
>  {
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>  	unsigned long prev_state_val = DESC_SV(id, desc_committed);
>  	struct prb_desc *d = to_desc(desc_ring, id);
>  
> -	atomic_long_cmpxchg_relaxed(&d->state_var, prev_state_val,
> -			DESC_SV(id, desc_finalized)); /* LMM(desc_make_final:A) */
> -
> -	/* Best effort to remember the last finalized @id. */
> -	atomic_long_set(&desc_ring->last_finalized_id, id);
> +	if (atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
> +			DESC_SV(id, desc_finalized))) { /* LMM(desc_make_final:A) */
> +		desc_update_last_finalized(rb);
> +	}
>  }
> @@ -2008,7 +2107,9 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
>   * newest sequence number available to readers will be.
>   *
>   * This provides readers a sequence number to jump to if all currently
> - * available records should be skipped.
> + * available records should be skipped. It is guaranteed that all records
> + * previous to the returned value have been finalized and are (or were)
> + * available to the reader.
>   *
>   * Context: Any context.
>   * Return: The sequence number of the next newest (not yet available) record
> @@ -2016,34 +2117,19 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
>   */
>  u64 prb_next_seq(struct printk_ringbuffer *rb)
>  {
> -	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> -	enum desc_state d_state;
> -	unsigned long id;
>  	u64 seq;
>  
> -	/* Check if the cached @id still points to a valid @seq. */
> -	id = atomic_long_read(&desc_ring->last_finalized_id);
> -	d_state = desc_read(desc_ring, id, NULL, &seq, NULL);
> +	seq = desc_last_finalized_seq(rb);

desc_last_finalized_seq() does internally:

	ulseq = atomic_long_read_acquire(&desc_ring->last_finalized_seq
					); /* LMM(desc_last_finalized_seq:A) */


It guarantees that this CPU would see the data which were seen by the
CPU which updated desc_ring->last_finalized_seq.

So far so good.

The problem is that I somehow miss the counter part. Maybe,
it is not needed. It just looks strange.

> -	if (d_state == desc_finalized || d_state == desc_reusable) {
> -		/*
> -		 * Begin searching after the last finalized record.
> -		 *
> -		 * On 0, the search must begin at 0 because of hack#2
> -		 * of the bootstrapping phase it is not known if a
> -		 * record at index 0 exists.
> -		 */
> -		if (seq != 0)
> -			seq++;
> -	} else {
> -		/*
> -		 * The information about the last finalized sequence number
> -		 * has gone. It should happen only when there is a flood of
> -		 * new messages and the ringbuffer is rapidly recycled.
> -		 * Give up and start from the beginning.
> -		 */
> -		seq = 0;
> -	}
> +	/*
> +	 * Begin searching after the last finalized record.
> +	 *
> +	 * On 0, the search must begin at 0 because of hack#2
> +	 * of the bootstrapping phase it is not known if a
> +	 * record at index 0 exists.
> +	 */
> +	if (seq != 0)
> +		seq++;
>  
>  	/*
>  	 * The information about the last finalized @seq might be inaccurate.

Below is the code:

	while (_prb_read_valid(rb, &seq, NULL, NULL))
		seq++;

Maybe, the release() should be here to make sure that the CPU which
would see this "seq" would also the data.

Would it make sense, please?

Otherwise, it looks good.

Best Regaards,
Petr

