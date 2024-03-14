Return-Path: <linux-kernel+bounces-103273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7699187BD51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B18B1C20E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9965B666;
	Thu, 14 Mar 2024 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAsb3yBU"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AB55C35
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421762; cv=none; b=FOp63Qu9CYiTHNcVUydIbyg6Shqk15POQdGe8hamYgK0+aRpRSOHfKsDPp4a/L8DOomChSfQ9EV8xCSXHE7g4x6vIjIncJMOwf1vt8J4WA0UhH+Y9ETz7vYt2KXd3VhK7ItZ+etdQvhDBHsUfvBPUttpIQpIEMUY308+G4b2QHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421762; c=relaxed/simple;
	bh=ae1m3xW6WCjIV/EspFO7h+dSSAQ3/AzLWwUCOgDdzrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+iDFUuD6eZyd1GgDCA6wt4Px9iAFYVa6NgfHZgw+RbsITlPI4Q1wh8q+Akxqt32B98KTz/nikAKlEiWJzqn0mmuUkanenlTy/ofClPwfYwepnQLxMe+4fSFlOmdAfSVwx6OwkIjtIIzTqGftH7d7K3yMu9sI/EsCigsnJUiHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAsb3yBU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413eee86528so6455885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710421759; x=1711026559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpHqE4qRwayb9ewqa6TQgGRa9Y2eMKjnSCgSywsCAts=;
        b=YAsb3yBUv6NT5RQmg91JT8i5/Q1n8IijBZZSry60SIn1J0wHxe4Li+6cDKzMlQL3/5
         VwQNn1Ko4hgTVm7l/O9KEu07FoRBeWYV1ZYoeT16NIIt7s4rBYcrieNC64Ol49Hu37YC
         83W+OpkSEa4zhTVMr2lUGXaXXuriyuOrutpESS4AudHGuwxjSiKNh41Eonvv4D/KyBko
         /B7h32MhzovIKdxocb6PAMMBEMF49Wv82Fx5XHjMQ9zKGjiIA0EQyO9SPuCPKOWhqzvD
         4EiGgzGlFTtkvY4TrBjUMtvt9WmH5Iw73M4pvCK67NfCdR2RCGIJ7jaDvQ2yoRHDCIcR
         Yfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421759; x=1711026559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpHqE4qRwayb9ewqa6TQgGRa9Y2eMKjnSCgSywsCAts=;
        b=H68Ber4ByMAUgXqkr9E9+xATQNu/+vsxHLPGVxT0qPuPDAjRNrDYUXUQOvfhfYOTgh
         thrHVBGtG+8XifNrt+aD0FaF/82sf2zJffd93BktNudJSeynwoWHLLta9rtqPhRf2lN/
         CqyWwTWG6ku7DYvpm4V1rFlSq0r52nutxgiOoWJtmeBbZWr+LjAI6SG6zCn+yLTKBQMm
         yruTdShmcWqcHrcyhtAw6UkCm8R3BCKD813vih4EAmT5ICSwu3N6ZlIudyDUQc7lm525
         /96s3vv+hhREPKg6rBY6+ghzie0uMf71EhUPiVM4GFFCYkOpZMvYXpC7W7obpdEn9toy
         d7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUcRZyEaZLx8uQrAd5RlYexOsjXjg2vP51unTkkPTmRdtHh/GsfkjLjVQW5cbFZi/kqXQOGRVbZBR6+Z+gNgQkRx1U99B5+O6nEX1WB
X-Gm-Message-State: AOJu0YxnbThp80kAIN4nv6bdULXHs60WP15aOGTCJu/ktJ+hHuqadeof
	zHhYrdaio/btS9QtGiko4mayldmnQkwWbr9XChgNMEF7JGzXirFcco33kz9UnuU=
X-Google-Smtp-Source: AGHT+IHTa22l22nIxzhaVXMXhuyWIdndVhvd/KaEs8lLcbXOoyKU9c+RTspxjUWimBMIyTf9Pao1dg==
X-Received: by 2002:a05:600c:190d:b0:413:260e:22af with SMTP id j13-20020a05600c190d00b00413260e22afmr1143889wmq.19.1710421758959;
        Thu, 14 Mar 2024 06:09:18 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c138900b00412f2136793sm5587778wmf.44.2024.03.14.06.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 06:09:18 -0700 (PDT)
Date: Thu, 14 Mar 2024 13:09:16 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI06IOetlOWkjQ==?= =?utf-8?Q?=3A?= [PATCH] kdb: Fix
 the deadlock issue in KDB debugging.
Message-ID: <20240314130916.GE202685@aspen.lan>
References: <20240228120516.GA22898@aspen.lan>
 <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
 <20240301105931.GB5795@aspen.lan>
 <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
 <20240312095756.GB202685@aspen.lan>
 <06cfa3459ed848cf8f228997b983cf53@h3c.com>
 <20240312102419.GC202685@aspen.lan>
 <410a443612e8441cb729c640a0d606c6@h3c.com>
 <20240313141745.GD202685@aspen.lan>
 <56ed54fd241c462189d2d030ad51eac6@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ed54fd241c462189d2d030ad51eac6@h3c.com>

On Thu, Mar 14, 2024 at 07:06:22AM +0000, Liuye wrote:
> >On Wed, Mar 13, 2024 at 01:22:17AM +0000, Liuye wrote:
> >> >On Tue, Mar 12, 2024 at 10:04:54AM +0000, Liuye wrote:
> >> >> >On Tue, Mar 12, 2024 at 08:37:11AM +0000, Liuye wrote:
> >> >> >> I know that you said schedule_work is not NMI save, which is
> >> >> >> the first issue. Perhaps it can be fixed using
> >> >> >> irq_work_queue. But even if irq_work_queue is used to
> >> >> >> implement it, there will still be a deadlock problem because
> >> >> >> slave cpu1 still has not released the running queue lock of
> >> >> >> master CPU0.
> >> >> >
> >> >> >This doesn't sound right to me. Why do you think CPU1 won't
> >> >> >release the run queue lock?
> >> >>
> >> >> In this example, CPU1 is waiting for CPU0 to release
> >> >> dbg_slave_lock.
> >> >
> >> >That shouldn't be a problem. CPU0 will have released that lock by
> >> >the time the irq work is dispatched.
> >>
> >> Release dbg_slave_lock in CPU0. Before that, shcedule_work needs to
> >> be handled, and we are back to the previous issue.
> >
> > Sorry but I still don't understand what problem you think can happen
> > here. What is wrong with calling schedule_work() from the IRQ work
> > handler?
> >
> > Both irq_work_queue() and schedule_work() are calls to queue deferred
> > work. It does not matter when the work is queued (providing we are
> > lock safe). What matters is when the work is actually executed.
> >
> > Please can you describe the problem you think exists based on when
> > the work is executed.
>
> CPU0 enters the KDB process when processing serial port interrupts and
> triggers an IPI (NMI) to other CPUs.  After entering a stable state,
> CPU0 is in interrupt context, while other CPUs are in NMI context.
> Before other CPUs enter NMI context, there is a chance to obtain the
> running queue of CPU0.

Focusing on the run queue locks in this analysis is a mistake. Before
the other CPUs enter NMI context there is a chance for them to obtain
*any* locks, including the timer wheel locks.


> At this time, when CPU0 is processing kgdboc_restore_input, calling
> schedule_work, need_more_worker here determines the chance to wake up
> processes on system_wq.
>
> This will cause CPU0 to acquire the running queue lock of this core,
> which is held by other CPUs.  but other CPUs are still in NMI context
> and have not exited because waiting for CPU0 to release the
> dbg_slave_lock after schedule_work.
>
> After thinking about it, the problem is not whether schedule_work is
> NMI safe, but that processes on system_wq should not be awakened
> immediately when schedule_work is called.

I disagree with this conclusion.

The problem *is* that schedue_work() is not NMI-safe.

You cannot solve an NMI safety problem by replacing schedule_work()
with another function that is also not NMI-safe. That simply changes
the locks that need to be taken to provoke a deadlock.


> I replaced schedule_work with schedule_delayed_work, and this solved
> my problem.

This may stop some specific reproduction from taking place but it
does not fix the potential deadlock.

I still believe that using irq_work is the only way to solve this
properly. Please try the following change:

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7ce7bb1640054..161b25ecc5e15 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
+#include <linux/irq_work.h>

 #define MAX_CONFIG_LEN		40

@@ -99,10 +100,17 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)

 static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);

+static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
+{
+	schedule_work(&kgdboc_restore_input_work);
+}
+
+static DEFINE_IRQ_WORK(kgdboc_restore_input_irq_work, kgdboc_queue_restore_input_helper);
+
 static void kgdboc_restore_input(void)
 {
 	if (likely(system_state == SYSTEM_RUNNING))
-		schedule_work(&kgdboc_restore_input_work);
+		irq_work_queue(&kgdboc_restore_input_irq_work);
 }

 static int kgdboc_register_kbd(char **cptr)
@@ -133,6 +141,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */

