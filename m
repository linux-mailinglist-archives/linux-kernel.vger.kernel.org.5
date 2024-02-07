Return-Path: <linux-kernel+bounces-56795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18BB84CF48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672621F22367
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410A4823B5;
	Wed,  7 Feb 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EGA1ZxPe"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD1823AC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324809; cv=none; b=e4muWFCInBzNzrkULCrzQiaO76u0cF2+frzjxRrEv4w0B+6pGn5DYPFjBv78vSzx96jfK4+PqqJJvCo4qapgnLzIN8rlWLgvJp2t8C/Vz4iZeOpFX2SmyDwq54e3Aw1iT46kExADfeJccDzjNsSmeFvk3OqryR1ZO/YEu0Cwu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324809; c=relaxed/simple;
	bh=n/o4MonGS1PrploNP/7IkYMhiWZNltaEGfYClBTgrwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaHb/GSqrBUKwM+gLEe9T6sQkbZdHnDunHL13df18oTBTv+NIUYiX5/tm2jxaQtwYy0EF+vcxbZmuaHUfjc3Zd3NOU4dPOztkAV38BIiBKj0rwPeQjhsWKch3UIjHHDw+wRfv37eg5+9WSYq9+u7IGs4FC+uzR7YaM5ZdRvTBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EGA1ZxPe; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a389ea940f1so33646266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707324805; x=1707929605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2BN2yRMNi5wZHfPrYZADiXibXtctI9gouyNYRhVgwg=;
        b=EGA1ZxPeBzLPNALJJo49Zj5eITepy/gU3HM1yglB0sezHqK8eGne8cTx0CJ+twqAqA
         I0IBQw1LEmprbdPN69PN4VDYOH1rBTN6b0ABzM/adbPw1/EhQoZNkt6qoun+qrkw/7f2
         KgfZvhqdzlsk/Lf/oe+046gyB3onjdtIDcGNsf693aDdWi8HT/bLg5iZMaW+N9UC8m2F
         v8aMWYOYYpMWkvwjJBGDXPBNae69IF2oQln3VMrBRMX/CZ/Wti/Bq6AwztmYKpYJEe7Z
         7BXyOleHE1nSCNC98/paulRjQRJ3kUpyEUOE5ScIKzHhEJIoSvKfjGaTT6zYfcCNOqUh
         bPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324805; x=1707929605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2BN2yRMNi5wZHfPrYZADiXibXtctI9gouyNYRhVgwg=;
        b=NH9zsw7niIuIEBbSNpfCYsu0BjkfHeJ/ZbmYIHdo6xT758azj+5UH+H3ohZRLZlgIn
         ZuCGj9s/u8mI5fZdC2TErqC+g3DyNrru+RTyU5F73XEbtUy/F9buYG01qy9Mv/RtxPkZ
         Rq0hSqw80PXucsmLIN4WqkoxB5MbAasP0bQPGh9JTqDKkuxM8fOVYOR/yw9q0vOVKqHb
         WWQ9HNlbpxyF3rwCECMQyqywAj/LIIEggbc/uPJB5bV7ZDeCsg4lqDiBJpNBAFQREvFn
         c5Wz3iNZhErVhTp02wvPJwuxMmMEQuZ9FpvNBIV3s+kM+eG5STz/K85XEAFrEsyispTV
         Cn+w==
X-Gm-Message-State: AOJu0YwV23aCVkSi9VcOdgWrATEyeQPSn9How70GJEbII6621KO32GU1
	0wtBl0kr3hsILFzwG2zlrzKwwRuIpmaiRLD5HBooE2Y7Dpw9+F+e+pLrkAzqF1s=
X-Google-Smtp-Source: AGHT+IHW/O3U+v8KDkJVOlvrfebmPIH0lsTDy+hKOWB/g/UtUWmEwDCUznUMNiKXn1G58XeX2knrCw==
X-Received: by 2002:a17:906:1c6:b0:a38:1ba8:4609 with SMTP id 6-20020a17090601c600b00a381ba84609mr3946999ejj.13.1707324805093;
        Wed, 07 Feb 2024 08:53:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3RzTHzCn5WQcqy5t82NWtoo6EqeDAMKA88yRwQUQ8EIZsGSnhYIWAP/kPW6xKf+P4tUBZWi1s6upbPd00iG1MvaAdX4nOEry5rtAXBQaIZ6at7cuvSuySt2OyosSlYpFwdZnVmATd8TxzR2f9a2ZoCKauaujksF02V47X/eNB9efHY5uv3rlZYlZ3C+v4/MtPxRqaZgd120A8c0LtORBGMRid8JgFc0qMzTl0AfbEcGF5NGlmOsCceU4j5x+GgUsXtNFFea0nYyalzrlJI67Cny8G0ghWW56KqpGK82NyEITjbcI95m9PEEeXeK/OPKFfLW+fKZJL0183+fTo3VpuHkYDKeprxgnjyHbYGRghTQ4C+Xj3nYpXcnYHC7/OZc0RFce9LEdErqd+WGw4CwOhH1CLQw9pheA=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id oq2-20020a170906cc8200b00a3845a75eb7sm939663ejb.189.2024.02.07.08.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:53:24 -0800 (PST)
Date: Wed, 7 Feb 2024 17:53:23 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, Uros Bizjak <ubizjak@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH printk v4 00/14] fix console flushing
Message-ID: <ZcO1g0dDmdJMefnC@alley>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
 <ZcOtXKtHuVUTQNRN@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOtXKtHuVUTQNRN@alley>

On Wed 2024-02-07 17:18:38, Petr Mladek wrote:
> On Wed 2024-02-07 14:46:49, John Ogness wrote:
> > Hi,
> > 
> > While testing various flushing scenarios, I stumbled on a few
> > issues that cause console flushing to fail. While at LPC2023 in
> > Richmond, I sat down with Petr Mladek and we reviewed the
> > v2 [0] series. This series is the result of that offline
> > discussion. v3 is here [1].
> > 
> > This series addresses the following issues:
> > 
> > 1. The prb_next_seq() optimization caused inconsistent return
> >    values. Fix prb_next_seq() to the originally intended
> >    behavior but keep an optimization.
> > 
> > 2. pr_flush() might not wait until the most recently stored
> >    printk() message if non-finalized records precede it. Fix
> >    pr_flush() to wait for all records to print that are at
> >    least reserved at the time of the call.
> > 
> > 3. In panic, the panic messages will not print if non-finalized
> >    records precede them. Add a special condition so that
> >    readers on the panic CPU will drop records that are not in
> >    a consistent state.
> > 
> > 4. It is possible (and easy to reproduce) a scenario where the
> >    console on the panic CPU hands over to a waiter of a stopped
> >    CPU. Do not use the handover feature in panic.
> > 
> > 5. If messages are being dropped during panic, non-panic CPUs
> >    are silenced. But by then it is already too late and most
> >    likely the panic messages have been dropped. Change the
> >    non-panic CPU silencing logic to _immediately_ silence
> >    non-panic CPUs during panic. This also leads to clean panic
> >    output when many CPUs are blasting the kernel log.
> > 
> > 6. If a panic occurs in a context where printk() calls defer
> >    printing (NMI or printk_safe section), the printing of the
> >    final panic messages rely on irq_work. If that mechanism is
> >    not available, the final panic messages are not seen (even
> >    though they are finalized in the ringbuffer). Add one last
> >    explicit flush after all printk() calls are finished to
> >    ensure all available messages in the kernel log are printed.
> > 
> > 7. When dumping the stacktrace from panic(), do not use the
> >    printk_cpu_sync because it can deadlock if another CPU holds
> >    and is unable to release the printk_cpu_sync.
> > 
> > This series also performs some minor cleanups to remove open
> > coded checks about the panic context and improve documentation
> > language regarding data-less records.
> > 
> > Because of multiple refactoring done in recent history, it
> > would be helpful to provide the LTS maintainers with the proper
> > backported patches. I am happy to do this.
> 
> The series seems to be ready linux-next from my POV. I am going
> to push it there so that it gets as much testing before
> the merge window as possible.

JFYI, it has been committed into printk/linux.git,
branch rework/console-flushing-fixes.

Let's keep our fingers crossed.

Best Regards,
Petr

