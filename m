Return-Path: <linux-kernel+bounces-26249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692882DD81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9F7B224F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D617C73;
	Mon, 15 Jan 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Stp1t1vT"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7C17C6A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55790581457so10120987a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705335445; x=1705940245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hjrtSvPiB/hyG1Ab95O0rJfpQxWTj5EKfW98jSeEX70=;
        b=Stp1t1vTvxjwxfVKui2hJthmIARn01PmKmVIT8/jFdlQeq9mf1ZH+B+jHZtSfmuIpu
         hfQ/BqUKZCvUGmNkD2N+oUE0mhgI287jRBjqsnGHxKv6nsjwAMlfJSAwJ4Pgs2j4qv2d
         21G+LOL0nFzLtY7c5W7vdESq493jvJKVeHLFhv01LdXmiU0Eb1gxgPbfyTEsMGN8JxJl
         RuDi3NjxT2XjWsO9DFmEk7aPdrzAn9WYwoNFivmw96atNI+pTMrK+CPjL02WCKCneRaR
         nKbRX0RimwpQqGL5BRKHWqEDcndCslKO6XKsA3kBbJBjLiu8E2sVjghPzqkdXxUlSE3N
         t/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705335445; x=1705940245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjrtSvPiB/hyG1Ab95O0rJfpQxWTj5EKfW98jSeEX70=;
        b=eM/JmqOhQB/O+krECvJyw8OhZbZOZGyeUYe92MQ3N0Yc++uHXwyufSXTRGP/Z7mxh9
         PkJlZVJU6yLna+FLgMnLe3xXSarVGXYBIyE8rGS9ATpAupfhTIcYI2zMcEey4+rQKpTp
         Db33Nx2+AyG955dlVGGidTuLoMiDMCvCmtbIK/RI0mfd3U8je8Ejipc7t6MI7Ab85kIH
         d6Jgdcvp0vo4r7Bmv1Ln68A4vciHIkRjQwth3b0O3r2GrQX8hAVhrmu12gPjjBv2p9vL
         UKtdMHP7sUERhEQFb0MT0PGt/1GuEM0ccQGWuQgOGHQTJh5yx9NV+bQVhLvcwOiZOoPr
         QIAQ==
X-Gm-Message-State: AOJu0YwJG04Ri2vOEk/4wP6G8OsSCHfa2Wy/USpZhdiPqcypYO5WmHH+
	pK/aM+ivge1mDlop2rI2jAJP7DumYBXO8Q==
X-Google-Smtp-Source: AGHT+IFncuQOahZ7aFQaeZLFJMZQ4vtO6euITJzrVkszBy5G1vQ6mGyPdZftuBHDXaTZMKYu+vBlzw==
X-Received: by 2002:aa7:c993:0:b0:557:f24:9d8a with SMTP id c19-20020aa7c993000000b005570f249d8amr2951888edt.67.1705335444828;
        Mon, 15 Jan 2024 08:17:24 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402104a00b005593a4e1635sm1851543edu.11.2024.01.15.08.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:17:24 -0800 (PST)
Date: Mon, 15 Jan 2024 17:17:21 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	kernel test robot <oliver.sang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH printk v3 02/14] printk: Adjust mapping for 32bit seq
 macros
Message-ID: <ZaVakcK7Bh0tYF9x@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-3-john.ogness@linutronix.de>
 <ZaEUUZ6PICA54qVH@alley>
 <ZaGBlDTuQ0hYBpeJ@alley>
 <87a5p6g96w.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5p6g96w.fsf@jogness.linutronix.de>

On Mon 2024-01-15 11:58:39, John Ogness wrote:
> On 2024-01-12, Petr Mladek <pmladek@suse.com> wrote:
> >> > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> >> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >> > Closes: https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.com
> >> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >> > Closes: https://lore.kernel.org/oe-lkp/202311161555.3ee16fc9-oliver.sang@intel.com
> >> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> >> 
> >> Great catch! It must have been complicated to debug this.
> >> 
> >> Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> > That said, I am a bit nervous that a bug like this might cause
> > workqueue stall and panic() the kernel.
> >
> > At least, this is how I read
> > https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.com/
> 
> Note that the bug is reported for code that mainline will never
> have. This patch "fixes" the problem before it is a problem. From the
> perspective of mainline, the problem never existed. Perhaps it is
> inappropriate to list these with the Closes tag.

I think that it is better to keep the reference. It might help
archaeologists to understand the problem ;-)

> > It looks like it caused some loop and refcout overlow or so.
> > But I might be wrong.
> >
> > I would like to better understand this and check if we could prevent
> > it somehow.
> 
> The code in question can be found here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/printk/printk_ringbuffer.c?id=768c33033e41ad195a9304ebb183afb730d5ae98#n2031
> 
> The URL above points to prb_next_reserve_seq(), which is in an infinite
> loop.
> 
> desc_last_finalized_seq() is returning a huge garbage value due to the
> 32bit sequence value 1 being incorrectly mapped to 0xffffffff00000001
> (which is 18446744069414584321). When desc_read_finalized_seq() is
> called (line 2082), it obviously returns -EINVAL because there is no
> record with this huge sequence number.
> 
> The code interrupts -EINVAL to mean that the record has been
> overwritten, and so it tries again with an updated last finalized
> sequence number => infinite loop.
> 
> With this patch applied, the 32bit value 1 is correctly mapped to
> sequence number 1 and all is OK.
> 
> The problem was that desc_last_finalized_seq() returned a sequence
> number that was higher than the highest record. That was the bug. As
> long as desc_last_finalized_seq() always returns a sequence number that
> exists or used to exist, the retry loop is fine. And since the tail
> record is always in the finalized state, there will always be a
> finalized record available.

Thank you both for explanation. You are right that this was kind
of special.

You know, the code around reading the messages is getting more
and more complex. Also the u32 -> u64 transition is not 100% safe.
So some sanity checks might be useful.

That said, I do not see any obvious trivial one. Just the following
came to my mind. prb_first_seq() is reliable and we could do:

void next_seq_sanity_check(struct printk_ringbuffer *rb, u64 next_seq)
{
	struct prb_desc_ring *desc_ring = &rb->desc_ring;
	u64 first_seq = prb_first_seq(rb);
	u64 desc_count = DESC_COUNT(&rb->desc_ring)).

	WARN_ONCE(seq > first_seq + DESC_COUNT(desc_ring));
}

Well, I am not sure if it is worth it. Also the WARN() won't
be printed on consoles when the reading is broken.

Best Regards,
Petr

