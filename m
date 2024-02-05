Return-Path: <linux-kernel+bounces-52720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD7E849BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903A31C22DA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288D22EFD;
	Mon,  5 Feb 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AekYs2nS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGMT1n6x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE822EED
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139995; cv=none; b=nWUFG6cWNlT3TzAO6+vrK4DawKZjHNZsx+2i4jzQtE6JPg05HkrINtWEHHp0j5HB2yPK4HoyzW3wVPQFvj40WjgahSuEu0CY/ds1j7NL5vpfNGE6xbmQY+R8B7NgEcSAL4fkxcaG1ZRUsTqf5zfYA9D0pHcRMWr5fBvQVhFkB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139995; c=relaxed/simple;
	bh=La/eaIeKBAw8pAPWSub0LJ1IVIKM4EzM45Kyy0Hc3Gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AFo0Mc72JVrnvf9MJ9YRn0hUK+fGJ5jTZ7w6wZm49gMCwRlDeLUV4Xfta7wQh6DyykDuccNOXTPc7V6cDkGBNbenniXMw98ZF1KZJYUiv7JIQljVtULaqy7OKpla9YGI7bdn7DK+4WQhRo71al+hCluFWk4wbY3eH4g1qrzIbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AekYs2nS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGMT1n6x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707139991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbAq7mDhkwWr5LR/rECWxpDInKH2ifL77/bt24XfeCQ=;
	b=AekYs2nSXScBJVjs/iGl9IjmaU2WS7zlw+AK+ynHWY+7pO+HumWmTP3YDmU0CyQ0QkETrj
	ROIdQqNt5fQd2OwmgiGCdUT2A1WhO4y8CVIzqOhHZnVDnPjVa/lWOZH/Nxf2jYLw3NAans
	zVrAJNHGufq6Rx0gZkGVIBUiy8V+ExAQelBrzgXfb0kVFVADqaRfm/N5Rs88B3+JTi089+
	1Om3AhlM8WS3D+mt+b5EnCgrbUjpgmGlpTKxPOENC2nBpJ+SMqJmgWXyUSM8RKhGD/KZb7
	nl42gyFXg9GladfQdXHFpBZaJvfRMIOtpdGiVqQVgmMuVoHrgoc/efNCzsef0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707139991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbAq7mDhkwWr5LR/rECWxpDInKH2ifL77/bt24XfeCQ=;
	b=BGMT1n6xwLyHx73McQl3xezepcwd/PVbY4mLBchCC5VE5GYEBv7QXUqL8ZqdvgGPiSVUbZ
	jdoM6JCw6m4jH5CA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 09/14] printk: Wait for all reserved records
 with pr_flush()
In-Reply-To: <ZbowlkOVWiSgCxNX@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-10-john.ogness@linutronix.de>
 <ZbowlkOVWiSgCxNX@alley>
Date: Mon, 05 Feb 2024 14:39:03 +0106
Message-ID: <87y1bznii8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-31, Petr Mladek <pmladek@suse.com> wrote:
>> +	last_finalized_seq = desc_last_finalized_seq(rb);
>> +
>> +	/*
>> +	 * @head_id is loaded after @last_finalized_seq to ensure that it is
>> +	 * at or beyond @last_finalized_seq.
>> +	 *
>> +	 * Memory barrier involvement:
>> +	 *
>> +	 * If desc_last_finalized_seq:A reads from
>> +	 * desc_update_last_finalized:A, then
>> +	 * prb_next_reserve_seq:A reads from desc_reserve:D.
>> +	 *
>> +	 * Relies on:
>> +	 *
>> +	 * RELEASE from desc_reserve:D to desc_update_last_finalized:A
>> +	 *    matching
>> +	 * ACQUIRE from desc_last_finalized_seq:A to prb_next_reserve_seq:A
>> +	 *
>> +	 * Note: desc_reserve:D and desc_update_last_finalized:A can be
>> +	 *       different CPUs. However, the desc_update_last_finalized:A CPU
>> +	 *       (which performs the release) must have previously seen
>> +	 *       desc_read:C, which implies desc_reserve:D can be seen.
>
> The most tricky part is desc_reserve:D. It is a supper complicated
> barrier which guarantees many things. But I think that there are
> many more write barriers before the allocated descriptor reaches
> finalized state. So that it should be easier to prove the correctness
> here by other easier barriers.

Yes, desc_reserve:D provides memory barriers for several orderings. But
it is _not_ providing a memory barrier for this ordering. It only marks
where @head_id is stored.

The only memory barriers involved here are desc_update_last_finalized:A
and its counterpart desc_last_finalized_seq:A.

CPU0                                 CPU1
====                                 ====
store(head_id)
store_release(last_finalized_seq)    load_acquire(last_finalized_seq)
                                     load(head_id)

> To make it clear. I am all for keeping the above precise description
> as is. I just think about adding one more human friendly note which
> might help future generations to understand the correctness an easier
> way.  Something like:
>
> 	* Note: The above description might be hard to follow because
> 	*	desc_reserve:D is a multi-purpose barrier. But this is
> 	*	just the first barrier which makes sure that @head_id
> 	*	is updated before the reserved descriptor gets finalized
> 	*	and updates @last_finalized_seq.
> 	*
> 	*	There are more release barriers in between, especially,
> 	*	desc_reserve:F and desc_update_last_finalized:A. Also these make
> 	*	sure that the desc_last_finalized_seq:A acquire barrier allows
> 	*	to read @head_id related to @last_finalized_seq or newer.

Non-global memory barriers must operate on the same memory. In this
case, the acquire/release memory barriers are operating on
@last_finalized_seq. The other ordered memory load in this situation is
for @head_id, so it makes sense to specify the store of @head_id as the
start of the release block.

> In fact, the desc_update_last_finalized:A release and
> desc_last_finalized_seq:A acquire barriers are enough to prove
> that we read here @head_id related to @last_finalized_seq or newer.

Yes, which is why they are listed here. ;-)

> Or maybe it is exactly what you described and my "human friendly"
> description is too naive. I am still not completely familiar
> with the "Memory barrier involvement:" and "Relies on:"
> format.

Yes, the format takes some getting used to. I thank Andrea Parri for
helping me to understand memory barriers and contributing ideas to
formalize the documentation.

>> +	if (err == -EINVAL) {
>> +		if (last_finalized_seq == 0) {
>> +			/*
>> +			 * @last_finalized_seq still contains its initial
>> +			 * value. Probably no record has been finalized yet.
>> +			 * This means the ringbuffer is not yet full and the
>> +			 * @head_id value can be used directly (subtracting
>> +			 * off the id value corresponding to seq=0).
>> +			 */
>> +
>> +			/*
>> +			 * Because of hack#2 of the bootstrapping phase, the
>> +			 * @head_id initial value must be handled separately.
>> +			 */
>> +			if (head_id == DESC0_ID(desc_ring->count_bits))
>> +				return 0;
>> +
>> +			/*
>> +			 * The @head_id is initialized such that the first
>> +			 * increment will yield the first record (seq=0).
>> +			 * Therefore use the initial value +1 as the base to
>> +			 * subtract from @head_id.
>> +			 */
>> +			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;
>
> It took me long time to understand the above code and comments. I
> wonder if the following looks easier even for you:
>
> 	if (err == -EINVAL) {
> 		if (last_finalized_seq == 0) {
> 			/*
> 			 * No record has been finalized or even	reserved yet.
> 			 *
> 			 * The @head_id is initialized such that the first
> 			 * increment will yield the first record (seq=0).
> 			 * Handle it separately to avoid a negative @diff below.
> 			 */
> 			if (head_id == DESC0_ID(desc_ring->count_bits))
> 				return 0;
>
> 			/* One or more descriptors are already reserved. Use
> 			 * the descriptor ID of the first one (@seq=0) for
> 			 * the @diff below.
> 			 */
> 			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;

I will use your comments for the next version.

>> +	/*
>> +	 * @diff is the number of records beyond the last record available
>> +	 * to readers.
>> +	 */
>
> This is kind of obvious from the code. Also it is not true when the
> first record has not been finalized yet. The following might
> be more useful:
>
> 	/* Diff of known descriptor IDs to compure releted sequence nubmers. */
>
>> +	diff = head_id - last_finalized_id;

I will use your comments for the next version.

> BTW: It came to my mind whether the logic might be more
>      straightforward if we store desc_ring->next_finalized_seq instead
>      of @last_finalized_seq.

I thought about this as well. But I felt like the meaning was a bit
confusing. Also @head_id points to the latest reserved descriptor, so it
makes the code a bit easier to follow when creating a diff based on the
latest finalized descriptor.

>      Even the initial value vould be valid. Also the value is
>      used only in prb_next_reserve_seq() and prb_next_seq() where
>      we need to start with this value anyway.

Agreed. I just didn't like how the code looked, even though there were
less +1 operations. It was hard(er) to follow.

>      Note that prb_next_seq() actually does not need to try _prb_read_valid()
>      for @last_finalized_seq. It should always be valid unless
>      the record has been already overwritten. In which case,
>      there should be a newer readable record.

Correct. The current code increments before reading.

> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Well, it would be nice to update the comments if you liked the
> proposals.

Thanks. I will use your comments.

John

