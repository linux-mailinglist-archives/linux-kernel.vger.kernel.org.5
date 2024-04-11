Return-Path: <linux-kernel+bounces-140615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B53628A16EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A29B29310
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13C14EC71;
	Thu, 11 Apr 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vs1wjnwO"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042314E2D9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844901; cv=none; b=mLJ9BJu88cLTDhAyHhZZX05orD8sjWuDZyWY6z9QBfQrnuWaIvAO/1WIJmRW9QhGRnMJp6C7c10E8YTZj5Wt5TYLyh1wCgloFh0JtUOOuweAxAAbD7xSOQrpeKDLaw0XdPmO8uQ+9K1/wULG4Wvmg1/2VUzL/8BHKRqH0cBamQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844901; c=relaxed/simple;
	bh=8jJA6FP2jbflHl0/aJ0hO92E4SBepfSCUkcvkEYOyjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBPaaVe9Eigs4ai7xpB6K37qOpKtz1DcM4pSTOqXVoeDWurmRFY4eFQ0qAZZhd5EHGWPvO3rG5elrvSqUoC7oywpNAc4iqSJ3lSAOZHKg7JDLhQvsNhjFPQCkyJNEVj5XvXDfB1rB4env7CFMg0K5VA4snXMywOiVl8q+zZJ5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vs1wjnwO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-346b96f1483so397449f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712844897; x=1713449697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAEUmrK0NXm+hnO4FYaS/MGMwPvV+skmzIoLnDdcV2w=;
        b=Vs1wjnwOqaINc69wn/UiVSYLvqpVjQUj6iGJeFlIVekyvKEZ4SLpcuhz/PKUR6xuuL
         5zhogSUXkNBKAhafKUitWvi2O35vDMf2MRH+cff1p1gE8+WYdI5Z9d497709zdkUHJ5L
         uO6OL5FzRxf4gnVF9KM9FYuOv41t2Sto1UuJIlkLfceSpR1CMzTyfi5EWnEzTxM9MWoT
         z3cbgYTRV+MLR2OvMzW8iM8TpKlEMJCn4Af7m8C3GbXVaXVlxTH67pfUWARNJSFZaAtS
         iDw6/shY86atdL+pSkBLa4TvZ0bFdXM+7rUXnOof28zPXmF7eMuluigsNWTkUleNgvye
         5dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844897; x=1713449697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAEUmrK0NXm+hnO4FYaS/MGMwPvV+skmzIoLnDdcV2w=;
        b=ND3/gyXC4EJ3Ab8S+YwOZSkinpkrPAkmETV9WTBQKzyDzArzuj2vn7fMDXKVqlFYfn
         wsJuNvNnEnRXs8b5jQ5WxgOJFVEbUNJiHWOOfeMdYzlRInvXy3TVQJxNCafg85Xol3uy
         rY2JGRwy8EsbrjuHTGK5Ng957R9mOGJcTy2MKVIjxWMBzs0tbNuKj1vcd9YPbEQ7W1I3
         3HHT2J0DGECmLbcb/h/6D4fHlbwBB1I8HSluN+jbJYfWBgny48VOuf3/41Mm2RZRUXq0
         SvQhtokWe7CX7aDjFBP5JJcJ5wYpp9NUdqN3Nn/1MgbrvsjhBP9iNT5s3Ed8ijJGwY4K
         gwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh3D79dZRjt1/eqWMnBC20lIMk6DrHVE+vc8VoJBszxUUD4W/HydU2Dv6ht6tDKSQwwSJI/SGd/FTFAj07MwlUOL8JnaFgM0eVcbn2
X-Gm-Message-State: AOJu0YzC+ZB44BD17q3QzQEPhKFoF2rr2uxh9uc4snkJIFI+FAGHmZKt
	ZWY+BJt3StiSQxcFVqBBmoxgPtLmdaeJF8hgkvJ3tVoAU6hhOMSYxQ50da7GQmU=
X-Google-Smtp-Source: AGHT+IG3Ursn3mswJ8MkK2YH27p/8VPif84PWdh56UEVeK4Qw9kvJpUQIpFBIcaeXF4CuGXZGrMnfQ==
X-Received: by 2002:adf:fd4b:0:b0:343:6b42:b3bb with SMTP id h11-20020adffd4b000000b003436b42b3bbmr2565881wrs.31.1712844896710;
        Thu, 11 Apr 2024 07:14:56 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b00346bda84bf9sm1611791wrr.78.2024.04.11.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:14:56 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:14:54 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 17/27] printk: nbcon: Use nbcon consoles in
 console_flush_all()
Message-ID: <ZhfwXsEE2Y8IPPxX@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-18-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-18-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:19, John Ogness wrote:
> Allow nbcon consoles to print messages in the legacy printk()
> caller context (printing via unlock) by integrating them into
> console_flush_all(). The write_atomic() callback is used for
> printing.

Hmm, this patch tries to flush nbcon console even in context
with NBCON_PRIO_NORMAL. Do we really want this, please?

I would expect that it would do so only when the kthread
is not working.

> Provide nbcon_legacy_emit_next_record(), which acts as the
> nbcon variant of console_emit_next_record(). Call this variant
> within console_flush_all() for nbcon consoles. Since nbcon
> consoles use their own @nbcon_seq variable to track the next
> record to print, this also must be appropriately handled.

I have been a bit confused by all the boolean return values
and what _exactly_ they mean. IMHO, we should make it more
clear how it works when it can't acquire the context.

IMHO, it is is importnat because console_flush_all() interprets
nbcon_legacy_emit_next_record() return value as @progress even when
there is no guaranteed progress. We just expect that
the other context is doing something.

It feels like it might get stuck forewer in some situatuon.
It would be good to understand if it is OK or not.


Later update:

Hmm, console_flush_all() is called from console_unlock().
It might be called in atomic context. But the current
owner might be theoretically scheduled out.

This is from documentation of nbcon_context_try_acquire()

/**
 * nbcon_context_try_acquire - Try to acquire nbcon console
 * @ctxt:	The context of the caller
 *
 * Context:	Any context which could not be migrated to another CPU.


I can't find any situation where nbcon_context_try_acquire() is
currently called in normal (schedulable) context. This is probably
why you did not see any problems with testing.

I see 3 possible solutions:

  1. Enforce that nbcon context can be acquired only with preemtion
     disabled.

  2. Enforce that nbcon context can be acquired only with
     interrupts. It would prevent deadlock when some future
     code interrupt flush in NBCON_PRIO_EMERGENCY context.
     And then a potential nested console_flush_all() won't be
     able to takeover the interrupted NBCON_PRIO_CONTEXT
     and there will be no progress.

  3. console_flush_all() should ignore nbcon console when
     it is not able to get the context, aka no progress.


I personally prefer the 3rd solution because I have spent
last 12 years on attempts to move printk into preemtible
context. And it looks wrong to move into atomic context.

Warning: console_flush_all() suddenly won't guarantee flushing
	 all messages.

	 I am not completely sure about all the consequences until
	 I see the rest of the patchset and the kthread intergration.
	 We will somehow need to guarantee that all messages
	 are flushed.


I propose the following changes to make console_flush_all()
safe. The patch is made on top of this patchset. Feel free
to squash them into your patch and remove my SoB.


From 8dd9c0be5ab693c6976a0f7f8b99de48ecebcbf6 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Thu, 11 Apr 2024 15:45:53 +0200
Subject: [PATCH] printk: nbcon: Prevent deadlock when flushing nbcon consoles
 in the legacy loop

Ignore pending records in nbcon consoles in the legacy console_flush_all()
loop when the nbcon console context can't be acquired. They will be
flushed either by the current nbcon context owner or to-be-introduced
printk kthread.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c57ad34a8d56..88c40f165be4 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -964,8 +964,12 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
  *				write_atomic() callback
  * @wctxt:	An initialized write context struct to use for this context
  *
- * Return:	False if it is known there are no more records to print,
- *		otherwise true.
+ * Return:	True, when a record has been printed and there are still
+ *		pending records. The caller might want to continue flushing.
+ *
+ *		False, when there is no pending record, or when the console
+ *		context can't be acquired, or the ownership has been lost.
+ *		The caller should give up. Either the job is or	can't be done.
  *
  * This is an internal helper to handle the locking of the console before
  * calling nbcon_emit_next_record().
@@ -975,7 +979,7 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 
 	if (!nbcon_context_try_acquire(ctxt))
-		return true;
+		return false;
 
 	/*
 	 * nbcon_emit_next_record() returns false when the console was
@@ -983,7 +987,7 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	 * longer valid.
 	 */
 	if (!nbcon_emit_next_record(wctxt))
-		return true;
+		return false;
 
 	nbcon_context_release(ctxt);
 
@@ -1023,8 +1027,13 @@ enum nbcon_prio nbcon_get_default_prio(void)
  * @cookie:	The cookie from the SRCU read lock.
  *
  * Context:	Any context except NMI.
- * Return:	False if the given console has no next record to print,
- *		otherwise true.
+ *
+ * Return:	True, when a record has been printed and there are still
+ *		pending records. The caller might want to continue flushing.
+ *
+ *		False, when there is no pending record, or when the console
+ *		context can't be acquired, or the ownership has been lost.
+ *		The caller should give up. Either the job is or	can't be done.
  *
  * This function is meant to be called by console_flush_all() to print records
  * on nbcon consoles from legacy context (printing via console unlocking).
-- 
2.44.0


Best Regards,
Petr

