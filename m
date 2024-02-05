Return-Path: <linux-kernel+bounces-52490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3FA8498EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDD2283116
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0602199B0;
	Mon,  5 Feb 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BPsx4y3I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7wGwfKYs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD018C3A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132822; cv=none; b=mrZjqMQZynmdzqCMe69oUhEARGbi4tQ8c76pO2yIDzox7zzd5bV7j3X6hgCnFoPg4UXezZk8QbNWc2MgxlQffOxDWqFi9RfJC3MGQ1g1QlazK9Ye+8ZTCysCgAZMRrnwANy37QHFfeTUphjAyIMp6RHXWM23oMLtx+PSnaVElYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132822; c=relaxed/simple;
	bh=3n8tju5MgjfQBO9+cSnvLd3JT7XF+Z0H9ANnUEk2a04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTdBJb/MdYHcDSjYgTCkDKF8qrXRCz0gPa9WvkXy58cHzTz4na/yJT/V0yUluW7B2FhGL9z3FlSOLD2jJzOEa2CJI0grVnJZ/3GEr62FOij4r+xeMOJ26GsPfs96H3se/tbOXqJ2Ay5w19IFQ1PkfkS6tS+GwwmOp8J2VjVNZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BPsx4y3I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7wGwfKYs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707132817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ73q89s5DsAVDwR2ENYw/vxOkP4xwuyDLdeOx9W3zQ=;
	b=BPsx4y3IrW0kIXkF0e9XAvlNFWHbxfqVQIvEQG5YqhBqYZZvzDPr9mStu+WVQIml8zQkBs
	EPadBms3lIo0gkpKd6Xty08dM6Y8oViNuPeHer14MRibjqoSiJ5SNiGeuyOWK1Jg0mgdeE
	7Bsmf2zlPWzi3OClUVRLCCclPS0C9JkN2rYzWUe0HAL+kpukEWdGXSv0Edg+aA+2uDHvx+
	vcqRMteMxiefn3xeLTWQF54vOG2nsRK4mC9CI14JrAZRvLnlRFIa60vAPWQWQ7joAdiY6s
	yRAXtr8nOB286jHNrYDpQ2q5o16ttq/42Xm2XCFEC2H8eyg0jleIgyBjQRnEww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707132817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ73q89s5DsAVDwR2ENYw/vxOkP4xwuyDLdeOx9W3zQ=;
	b=7wGwfKYst8OwqBFVtAlVytFuTnr2OEhMi71KF7HUC1gcsjV3lfbGKf0W73muzQz1ik5obn
	IT6mwUidOA06IwAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH printk v3 04/14] printk: ringbuffer: Do not skip
 non-finalized records with prb_next_seq()
In-Reply-To: <ZaVkqJ-KMRp9mbLR@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-5-john.ogness@linutronix.de>
 <ZaF_eJ_BCddZl5z1@alley> <874jfeg69z.fsf@jogness.linutronix.de>
 <ZaVkqJ-KMRp9mbLR@alley>
Date: Mon, 05 Feb 2024 12:39:30 +0106
Message-ID: <871q9rp2lx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-15, Petr Mladek <pmladek@suse.com> wrote:
>> The acquire is with @last_finalized_seq. So the release must also be
>> with @last_finalized_seq. The important thing is that the CPU that
>> updates @last_finalized_seq has actually read the corresponding
>> record beforehand. That is exactly what desc_update_last_finalized()
>> does.
>
> I probably did not describe it well. The CPU updating
> @last_finalized_seq does the right thing. I was not sure about the CPU
> which reads @last_finalized_seq via prb_next_seq().
>
> To make it more clear:
>
> u64 prb_next_seq(struct printk_ringbuffer *rb)
> {
> 	u64 seq;
>
> 	seq = desc_last_finalized_seq(rb);
> 	      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	      |
> 	      `-> This includes atomic_long_read_acquire(last_finalized_seq)
>
>
> 	if (seq != 0)
> 		seq++;
>
> 	while (_prb_read_valid(rb, &seq, NULL, NULL))
> 		seq++;
>
> 	return seq;
> }
>
> But where is the atomic_long_read_release(last_finalized_seq) in
> this code path?

read_release? The counterpart of this load_acquire is a
store_release. For example:

CPU0                     CPU1
====                     ====
load(varA)
store_release(varB)      load_acquire(varB)
                         load(varA)

If CPU1 reads the value in varB that CPU0 stored, then it is guaranteed
that CPU1 will read the value (or a later value) in varA that CPU0 read.

Translating the above example to this particular patch, we have:

CPU0: desc_update_last_finalized()       CPU1: prb_next_seq()
====                                     ====
_prb_read_valid(seq)
cmpxchg_release(last_finalized_seq,seq)  seq=read_acquire(last_finalized_seq)
                                         _prb_read_valid(seq)

> IMHO, the barrier provided by the acquire() is _important_ to make
> sure that _prb_read_valid() would see the valid descriptor.

Correct.

> Now, I think that the related read_release(seq) is hidden in:
>
> static int prb_read(struct printk_ringbuffer *rb, u64 seq,
> 		    struct printk_record *r, unsigned int *line_count)
> {
> 	/* Get a local copy of the correct descriptor (if available). */
> 	err = desc_read_finalized_seq(desc_ring, id, seq, &desc);
>
> 	/* If requested, copy meta data. */
> 	if (r->info)
> 		memcpy(r->info, info, sizeof(*(r->info)));
>
> 	/* Copy text data. If it fails, this is a data-less record. */
> 	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, info->text_len,
> 		       r->text_buf, r->text_buf_size, line_count)) {
> 		return -ENOENT;
> 	}
>
> 	/* Ensure the record is still finalized and has the same @seq. */
> 	return desc_read_finalized_seq(desc_ring, id, seq, &desc);
> 	       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	       |
> 	       `-> This includes a memory barrier /* LMM(desc_read:A) */
> 		   which makes sure that the data are read before
> 		   the desc/data could be reused.
> }
>
> I consider this /* LMM(desc_read:A) */ as a counter part for that
> acquire() in prb_next_seq().

desc_read:A is not a memory barrier. It only marks the load of the
descriptor state. This is a significant load because prb_next_seq() must
see at least the descriptor state that desc_update_last_finalized() saw.

The memory barrier comments in desc_update_last_finalized() state:

    * If desc_last_finalized_seq:A reads from
    * desc_update_last_finalized:A, then desc_read:A reads from
    * _prb_commit:B.

This is referring to a slightly different situation than the example I
used above because it is referencing where the descriptor state was
stored (_prb_commit:B). The same general picture is valid:

CPU0                              CPU1
====                              ====
_prb_commit:B
desc_update_last_finalized:A      desc_last_finalized_seq:A
                                  desc_read:A

desc_read:A is loding the descriptor state that _prb_commit:B stored.

The extra note in the comment clarifies that _prb_commit:B could also be
denoted as desc_read:A because desc_update_last_finalized() performs a
read (i.e. must have seen) _prb_commit:B.

    * Note: _prb_commit:B and desc_update_last_finalized:A can be
    *       different CPUs. However, the desc_update_last_finalized:A
    *       CPU (which performs the release) must have previously seen
    *       _prb_commit:B.

Normally the CPU committing the record will also update
last_finalized_seq. But it is possible that another CPU updates
last_finalized_seq before the committing CPU because it already sees the
finalized record. In that case the complete (maximally complex) picture
looks like this.

CPU0            CPU1                           CPU2
====            ====                           ====
_prb_commit:B   desc_read:A
                desc_update_last_finalized:A   desc_last_finalized_seq:A
                                               desc_read:A

Any memory barriers in _prb_commit() or desc_read() are irrelevant for
guaranteeing that a CPU reading a sequence value from
desc_last_finalized_seq() will always be able to read that record.

> Summary:
>
> I saw atomic_long_read_acquire(last_finalized_seq) called from
> prb_next_seq() code path. The barrier looked important to me.
> But I saw neither the counter-part nor any comment. I wanted
> to understand it because it might be important for reviewing
> following patches which depend on prb_next_seq().

desc_update_last_finalized:A is the counterpart to
desc_last_finalized_seq:A. IMHO there are plenty of comments that are
formally documenting these memory barriers. Including the new entry in
the summary of all memory barriers:

 *   desc_update_last_finalized:A / desc_last_finalized_seq:A
 *     store finalized record, then set new highest finalized sequence number

John

