Return-Path: <linux-kernel+bounces-63607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C550E85322D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337FD1F22530
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED365647E;
	Tue, 13 Feb 2024 13:44:20 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836556444;
	Tue, 13 Feb 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831859; cv=none; b=JqwhRaNfSh6s8+wRu+1pGO8M1Oyggpzl4XewrJBJJGTXSSmqD7RZEmGFTEH2QoaFTMlFXV7iJzVHZN1WDEq0KycdHYGtDvDsiBRdXSVvwaxPQdCRIxmXOhiwJsvE3qvG8RnMJKERVlSBEJNPCMalp08Pzrh8CjqEJZaAu8dq1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831859; c=relaxed/simple;
	bh=Al+OIDSwr1PRilbCX04+e3dBAlrgqKv7y2SaHw6pOeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFWy0X9JtnB75GzJqDFDAGAN44NOwH36cMKLv8LyBv17r0+NUvbmEpq4y19c/t7MlZpuIs1DifjnOhoC/IM53QxMURlqYt7fIdP8lT4ouAct4QnF0KvDW5DgoEGLoFZfYbA05iNMKkVbI4uzOFcTsEtE4Y2kBba03TXqZYhv7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3832ef7726so510628266b.0;
        Tue, 13 Feb 2024 05:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831855; x=1708436655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5DeZbkSxboHr0pPFTvXpwxDIQjK3BTjbERvjTy55B4=;
        b=dNu1Jnz5I/ihEUpWiKeiv8AeVnlqrkSc7vrdQL8pF53zb6x1Tjcr6Ez47iX6KzEinH
         HeKHm/EiWTyU/N5bCigM7NogqiiBl9FpFZiNzhDmim0rgz6ANq94Q3bsC2ekxug8Cd0C
         AjLKHdW+vklbFI82QKeW9PD7zgyTjqHK/NHwYKIfyTfy1fdbGTJCpyOy+ZGa0pgmHMrL
         Lq1JwpiBw2Sin/LLXPOTW+ohB1KI69bp7hS9FPVI81gRToiq/FwHzItEPUl+yjWzXg6w
         K7x2KRnh77geQaLPLiO21JQJhfaX6A+ECYD9XpZAV/h96C6e7Mxnrp8hJj+ENkRRf5Fg
         G1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXPzDoGATLVxdX++HL0ZSJ3MvtGsDjzcCfh9hWVFq3njIPVT9Peu+lm8mc00s1SE8czWzBUjRx2B7K/YlJwK2wrU97oafOtlmZr6bMEuIHxE/EmADUDy3S2J4OT19wni94yGWJZUubyGtQ6yQQ13ZVBQHPisYMr4MoEx3aoUzeA2bzt1RTtgE/9
X-Gm-Message-State: AOJu0YwR4WpRQAD1NqT8l7k6tauTPEOZdf6Pew9yQ6aUXUPXG7I2o9k4
	5F+rl2cTFJlvSuqViWbOqKOnlm+XQyu/nb4R8x+ko5xEF6CgpVok
X-Google-Smtp-Source: AGHT+IGhRZ61SWtdZeHx3ArbCxE2WR8Ny5X4gZF3rPbcSnW/6AZhuYTHDw7z2mgem0HeiZNreS/j4A==
X-Received: by 2002:a17:906:5002:b0:a38:45fc:1f01 with SMTP id s2-20020a170906500200b00a3845fc1f01mr6545985ejj.45.1707831855252;
        Tue, 13 Feb 2024 05:44:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAITtL5myEYzIFRohG+uZUnKEBDGOqkFIdmDb8mx2JyWxEiM4777BteOsIwJmVCxBliB3obNq434+d8Vv9rWZTcsUxiJ0c4d0Sn3sJ9nGGyRlXXYqPaS4HzGVMBuUggunBYMxq9p9GGkFWJdQyVVT/2YCDh7B2ACsFlnFMO7YkdkPGJLp1j4B+TRdIyt5U819953D6GYT0Bb7v91BCs83laDJpWk4Dwx7hHszw6aVf+rTINFuGOKRNiCWEdpXMAwruxtgsdOuNMz1MYpIR1E2OISLuZN/O2dsjR24O2kSraWsCE9eE/G/sLUUdAVCsAYnkdN6l5/8W03ijMTFictNvhq7DZZ3hgFS80YWDbIW0wnNvV+fOgY5Rx3F5SdNlrKZEGH3sErnqQcbeZbR1AyInOQuYHiOhTL6fOTkTgGjK6K9ddUG0k1cBsJW2qbQpeE4NacQCZ2C0QO9n/OKh/Hz7V+CgA+TlMoZSrsbwXBp9RcPvjx0lsAyna2Ty9ufaEkRuk3BOa4Hli3DVh+KDFLWAKOxRLBBf0enUTYEiUolCqrXon/A84k4=
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906689a00b00a38620c3b3dsm1296854ejr.198.2024.02.13.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:44:14 -0800 (PST)
Date: Tue, 13 Feb 2024 05:44:11 -0800
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on BQL
Message-ID: <ZctyK+qpXV/pquei@gmail.com>
References: <20240202165315.2506384-1-leitao@debian.org>
 <dc049b1e556ef7b398fb78c01b6e2e693c185273.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc049b1e556ef7b398fb78c01b6e2e693c185273.camel@redhat.com>

On Tue, Feb 06, 2024 at 12:40:13PM +0100, Paolo Abeni wrote:
> On Fri, 2024-02-02 at 08:53 -0800, Breno Leitao wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > 
> > softnet_data->time_squeeze is sometimes used as a proxy for
> > host overload or indication of scheduling problems. In practice
> > this statistic is very noisy and has hard to grasp units -
> > e.g. is 10 squeezes a second to be expected, or high?
> > 
> > Delaying network (NAPI) processing leads to drops on NIC queues
> > but also RTT bloat, impacting pacing and CA decisions.
> > Stalls are a little hard to detect on the Rx side, because
> > there may simply have not been any packets received in given
> > period of time. Packet timestamps help a little bit, but
> > again we don't know if packets are stale because we're
> > not keeping up or because someone (*cough* cgroups)
> > disabled IRQs for a long time.
> > 
> > We can, however, use Tx as a proxy for Rx stalls. Most drivers
> > use combined Rx+Tx NAPIs so if Tx gets starved so will Rx.
> > On the Tx side we know exactly when packets get queued,
> > and completed, so there is no uncertainty.
> > 
> > This patch adds stall checks to BQL. Why BQL? Because
> > it's a convenient place to add such checks, already
> > called by most drivers, and it has copious free space
> > in its structures (this patch adds no extra cache
> > references or dirtying to the fast path).
> > 
> > The algorithm takes one parameter - max delay AKA stall
> > threshold and increments a counter whenever NAPI got delayed
> > for at least that amount of time. It also records the length
> > of the longest stall.
> > 
> > To be precise every time NAPI has not polled for at least
> > stall thrs we check if there were any Tx packets queued
> > between last NAPI run and now - stall_thrs/2.
> > 
> > Unlike the classic Tx watchdog this mechanism does not
> > ignore stalls caused by Tx being disabled, or loss of link.
> > I don't think the check is worth the complexity, and
> > stall is a stall, whether due to host overload, flow
> > control, link down... doesn't matter much to the application.
> > 
> > We have been running this detector in production at Meta
> > for 2 years, with the threshold of 8ms. It's the lowest
> > value where false positives become rare. There's still
> > a constant stream of reported stalls (especially without
> > the ksoftirqd deferral patches reverted), those who like
> > their stall metrics to be 0 may prefer higher value.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changelog:
> > 
> > v1:
> >   * https://lore.kernel.org/netdev/202306172057.jx7YhLiu-lkp@intel.com/T/
> > 
> > v2:
> >   * Fix the documentation file in patch 0001, since patch 0002 will
> >     touch it later.
> >   * Fix the kernel test robot issues, marking functions as statics.
> >   * Use #include <linux/bitops.h> instead of <asm/bitops.h>.
> >   * Added some new comments around, mainly around barriers.
> >   * Format struct `netdev_queue_attribute` assignments to make
> >     checkpatch happy.
> >   * Updated and fixed the path in sysfs-class-net-queues
> >     documentation.
> > 
> > v3:
> >   * Sending patch 0002 against net-next.
> > 	- The first patch was accepted against 'net'
> > 
> > ---
> >  .../ABI/testing/sysfs-class-net-queues        | 23 +++++++
> >  include/linux/dynamic_queue_limits.h          | 35 +++++++++++
> >  include/trace/events/napi.h                   | 33 ++++++++++
> >  lib/dynamic_queue_limits.c                    | 58 +++++++++++++++++
> >  net/core/net-sysfs.c                          | 62 +++++++++++++++++++
> >  5 files changed, 211 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-net-queues b/Documentation/ABI/testing/sysfs-class-net-queues
> > index 5bff64d256c2..45bab9b6e3ae 100644
> > --- a/Documentation/ABI/testing/sysfs-class-net-queues
> > +++ b/Documentation/ABI/testing/sysfs-class-net-queues
> > @@ -96,3 +96,26 @@ Description:
> >  		Indicates the absolute minimum limit of bytes allowed to be
> >  		queued on this network device transmit queue. Default value is
> >  		0.
> > +
> > +What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/stall_thrs
> > +Date:		Jan 2024
> > +KernelVersion:	6.9
> > +Contact:	netdev@vger.kernel.org
> > +Description:
> > +		Tx completion stall detection threshold.�
> 
> Possibly worth mentioning it's in milliseconds
> 
> > Kernel will guarantee
> > +		to detect all stalls longer than this threshold but may also
> > +		detect stalls longer than half of the threshold.
> > +
> > +What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/stall_cnt
> > +Date:		Jan 2024
> > +KernelVersion:	6.9
> > +Contact:	netdev@vger.kernel.org
> > +Description:
> > +		Number of detected Tx completion stalls.
> > +
> > +What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/stall_max
> > +Date:		Jan 2024
> > +KernelVersion:	6.9
> > +Contact:	netdev@vger.kernel.org
> > +Description:
> > +		Longest detected Tx completion stall. Write 0 to clear.
> > diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
> > index 407c2f281b64..288e98fe85f0 100644
> > --- a/include/linux/dynamic_queue_limits.h
> > +++ b/include/linux/dynamic_queue_limits.h
> > @@ -38,14 +38,21 @@
> >  
> >  #ifdef __KERNEL__
> >  
> > +#include <linux/bitops.h>
> >  #include <asm/bug.h>
> >  
> > +#define DQL_HIST_LEN		4
> > +#define DQL_HIST_ENT(dql, idx)	((dql)->history[(idx) % DQL_HIST_LEN])
> > +
> >  struct dql {
> >  	/* Fields accessed in enqueue path (dql_queued) */
> >  	unsigned int	num_queued;		/* Total ever queued */
> >  	unsigned int	adj_limit;		/* limit + num_completed */
> >  	unsigned int	last_obj_cnt;		/* Count at last queuing */
> >  
> > +	unsigned long	history_head;
> > +	unsigned long	history[DQL_HIST_LEN];
> > +
> >  	/* Fields accessed only by completion path (dql_completed) */
> >  
> >  	unsigned int	limit ____cacheline_aligned_in_smp; /* Current limit */
> > @@ -62,6 +69,11 @@ struct dql {
> >  	unsigned int	max_limit;		/* Max limit */
> >  	unsigned int	min_limit;		/* Minimum limit */
> >  	unsigned int	slack_hold_time;	/* Time to measure slack */
> > +
> > +	unsigned char	stall_thrs;
> > +	unsigned char	stall_max;
> 
> Why don't 'unsigned short'? 

Yes, it seems fine for me.

> 
> 
> > +	unsigned long	last_reap;
> > +	unsigned long	stall_cnt;
> >  };
> >  
> >  /* Set some static maximums */
> > @@ -74,6 +86,8 @@ struct dql {
> >   */
> >  static inline void dql_queued(struct dql *dql, unsigned int count)
> >  {
> > +	unsigned long map, now, now_hi, i;
> > +
> >  	BUG_ON(count > DQL_MAX_OBJECT);
> >  
> >  	dql->last_obj_cnt = count;
> > @@ -86,6 +100,27 @@ static inline void dql_queued(struct dql *dql, unsigned int count)
> >  	barrier();
> >  
> >  	dql->num_queued += count;
> > +
> > +	now = jiffies;
> > +	now_hi = now / BITS_PER_LONG;
> > +	if (unlikely(now_hi != dql->history_head)) {
> > +		/* About to reuse slots, clear them */
> > +		for (i = 0; i < DQL_HIST_LEN; i++) {
> > +			/* Multiplication masks high bits */
> > +			if (now_hi * BITS_PER_LONG ==
> > +			    (dql->history_head + i) * BITS_PER_LONG)
> > +				break;
> > +			DQL_HIST_ENT(dql, dql->history_head + i + 1) = 0;
> > +		}
> > +		/* pairs with smp_rmb() in dql_check_stall() */
> > +		smp_wmb();
> > +		WRITE_ONCE(dql->history_head, now_hi);
> > +	}
> > +
> > +	/* __set_bit() does not guarantee WRITE_ONCE() semantics */
> > +	map = DQL_HIST_ENT(dql, now_hi);
> > +	if (!(map & BIT_MASK(now)))
> > +		WRITE_ONCE(DQL_HIST_ENT(dql, now_hi), map | BIT_MASK(now));
> 
> Do you have measure of performance impact, if any? e.g. for udp
> flood/pktgen/xdp tput tests with extreme pkt rate?

I've looked at our Meta Internal profiler, if that helps. Currently Meta has this feature
enabled in every machine.

In the profiler, the only function that shows up in the profiler is dql_completed(),
which consumes 0.00204% of all kernel cycles. Does it help?


> What about making all the above conditional to a non zero stall_thrs,
> alike the check part?

Makes sense, I will update.

> >  }
> >  
> >  /* Returns how many objects can be queued, < 0 indicates over limit. */
> > diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
> > index 6678cf8b235b..272112ddaaa8 100644
> > --- a/include/trace/events/napi.h
> > +++ b/include/trace/events/napi.h
> > @@ -36,6 +36,39 @@ TRACE_EVENT(napi_poll,
> >  		  __entry->work, __entry->budget)
> >  );
> >  
> > +TRACE_EVENT(dql_stall_detected,
> > +
> > +	TP_PROTO(unsigned int thrs, unsigned int len,
> > +		 unsigned long last_reap, unsigned long hist_head,
> > +		 unsigned long now, unsigned long *hist),
> > +
> > +	TP_ARGS(thrs, len, last_reap, hist_head, now, hist),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(	unsigned int,		thrs)
> > +		__field(	unsigned int,		len)
> > +		__field(	unsigned long,		last_reap)
> > +		__field(	unsigned long,		hist_head)
> > +		__field(	unsigned long,		now)
> > +		__array(	unsigned long,		hist, 4)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->thrs = thrs;
> > +		__entry->len = len;
> > +		__entry->last_reap = last_reap;
> > +		__entry->hist_head = hist_head * BITS_PER_LONG;
> > +		__entry->now = now;
> > +		memcpy(__entry->hist, hist, sizeof(entry->hist));
> > +	),
> > +
> > +	TP_printk("thrs %u  len %u  last_reap %lu  hist_head %lu  now %lu  hist %016lx %016lx %016lx %016lx",
> > +		  __entry->thrs, __entry->len,
> > +		  __entry->last_reap, __entry->hist_head, __entry->now,
> > +		  __entry->hist[0], __entry->hist[1],
> > +		  __entry->hist[2], __entry->hist[3])
> > +);
> > +
> >  #undef NO_DEV
> >  
> >  #endif /* _TRACE_NAPI_H */
> > diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
> > index fde0aa244148..162d30ae542c 100644
> > --- a/lib/dynamic_queue_limits.c
> > +++ b/lib/dynamic_queue_limits.c
> > @@ -10,10 +10,61 @@
> >  #include <linux/dynamic_queue_limits.h>
> >  #include <linux/compiler.h>
> >  #include <linux/export.h>
> > +#include <trace/events/napi.h>
> >  
> >  #define POSDIFF(A, B) ((int)((A) - (B)) > 0 ? (A) - (B) : 0)
> >  #define AFTER_EQ(A, B) ((int)((A) - (B)) >= 0)
> >  
> > +static void dql_check_stall(struct dql *dql)
> > +{
> > +	unsigned long stall_thrs, now;
> > +
> > +	/* If we detect a stall see if anything was queued */
> > +	stall_thrs = READ_ONCE(dql->stall_thrs);
> > +	if (!stall_thrs)
> > +		return;
> > +
> > +	now = jiffies;
> > +	if (time_after_eq(now, dql->last_reap + stall_thrs)) {
> > +		unsigned long hist_head, t, start, end;
> > +
> > +		/* We are trying to detect a period of at least @stall_thrs
> > +		 * jiffies without any Tx completions, but during first half
> > +		 * of which some Tx was posted.
> > +		 */
> > +dqs_again:
> > +		hist_head = READ_ONCE(dql->history_head);
> > +		/* pairs with smp_wmb() in dql_queued() */
> > +		smp_rmb();
> > +		/* oldest sample since last reap */
> > +		start = (hist_head - DQL_HIST_LEN + 1) * BITS_PER_LONG;
> > +		if (time_before(start, dql->last_reap + 1))
> > +			start = dql->last_reap + 1;
> > +		/* newest sample we should have already seen a completion for */
> > +		end = hist_head * BITS_PER_LONG + (BITS_PER_LONG - 1);
> > +		if (time_before(now, end + stall_thrs / 2))
> > +			end = now - stall_thrs / 2;
> > +
> > +		for (t = start; time_before_eq(t, end); t++)
> > +			if (test_bit(t % (DQL_HIST_LEN * BITS_PER_LONG),
> > +				     dql->history))
> > +				break;
> > +		if (!time_before_eq(t, end))
> > +			goto no_stall;
> > +		if (hist_head != READ_ONCE(dql->history_head))
> > +			goto dqs_again;
> > +
> > +		dql->stall_cnt++;
> > +		dql->stall_max = max_t(unsigned int, dql->stall_max, now - t);
> > +
> > +		trace_dql_stall_detected(dql->stall_thrs, now - t,
> > +					 dql->last_reap, dql->history_head,
> > +					 now, dql->history);
> > +	}
> > +no_stall:
> > +	dql->last_reap = now;
> > +}
> > +
> >  /* Records completed count and recalculates the queue limit */
> >  void dql_completed(struct dql *dql, unsigned int count)
> >  {
> > @@ -110,6 +161,8 @@ void dql_completed(struct dql *dql, unsigned int count)
> >  	dql->prev_last_obj_cnt = dql->last_obj_cnt;
> >  	dql->num_completed = completed;
> >  	dql->prev_num_queued = num_queued;
> > +
> > +	dql_check_stall(dql);
> >  }
> >  EXPORT_SYMBOL(dql_completed);
> >  
> > @@ -125,6 +178,10 @@ void dql_reset(struct dql *dql)
> >  	dql->prev_ovlimit = 0;
> >  	dql->lowest_slack = UINT_MAX;
> >  	dql->slack_start_time = jiffies;
> > +
> > +	dql->last_reap = jiffies;
> > +	dql->history_head = jiffies / BITS_PER_LONG;
> > +	memset(dql->history, 0, sizeof(dql->history));
> >  }
> >  EXPORT_SYMBOL(dql_reset);
> >  
> > @@ -133,6 +190,7 @@ void dql_init(struct dql *dql, unsigned int hold_time)
> >  	dql->max_limit = DQL_MAX_LIMIT;
> >  	dql->min_limit = 0;
> >  	dql->slack_hold_time = hold_time;
> > +	dql->stall_thrs = 0;
> >  	dql_reset(dql);
> >  }
> >  EXPORT_SYMBOL(dql_init);
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index a09d507c5b03..94a622b0bb55 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -1409,6 +1409,65 @@ static struct netdev_queue_attribute bql_hold_time_attribute __ro_after_init
> >  	= __ATTR(hold_time, 0644,
> >  		 bql_show_hold_time, bql_set_hold_time);
> >  
> > +static ssize_t bql_show_stall_thrs(struct netdev_queue *queue, char *buf)
> > +{
> > +	struct dql *dql = &queue->dql;
> > +
> > +	return sprintf(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
> > +}
> > +
> > +static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
> > +				  const char *buf, size_t len)
> > +{
> > +	struct dql *dql = &queue->dql;
> > +	unsigned int value;
> > +	int err;
> > +
> > +	err = kstrtouint(buf, 10, &value);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	value = msecs_to_jiffies(value);
> > +	if (value && (value < 4 || value > 4 / 2 * BITS_PER_LONG))
> 
> I admit I'm more than a bit lost with constant usage.. why 4/2 here?

4 in this case is DQL_HIST_LEN, so, it needs to be updated.

> Perhaps some more comments describing the implement logic would be
> helpful.

Agree, Let me work on it.


