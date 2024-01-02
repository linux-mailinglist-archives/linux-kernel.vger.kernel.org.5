Return-Path: <linux-kernel+bounces-14203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7782190E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858821C21990
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B1DC8F5;
	Tue,  2 Jan 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPfMzz/b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0F7470
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso94773185e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 01:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704188839; x=1704793639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7ojcp2dbDyRW3OreP4mBJTzhyFdUANE5vMCwyKkm88=;
        b=DPfMzz/bQtENNBQ70GAaE7RjWgeuxLx0IstkJa9Jdljk3z2L90rUPMqKWWNC2I0GeJ
         3hQu78G8VEfZwxe3zPAL4b8d3K32mtivEEkP76lmzDKp4UhOkolUmHVkrRtkhYaEtOAc
         mgqJy0U74zFGyEPspagxSWthMllvovbzrbweDVMRnHC77H+Z/tpifQV7oHW8CbYqWMLq
         Jqrt13aOE8twQ2A1C9AlhK9VJilWNbp4dyZMRyMi1hcIcc5fIX1pg3hPCRmsznVj9/X6
         gC4WDKpJzcJfrat2lxWFJNTMDp0zKAGiPspCbNtcgaNW8aNEHbC/L1/JNTAje+JHLFlX
         2+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704188839; x=1704793639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7ojcp2dbDyRW3OreP4mBJTzhyFdUANE5vMCwyKkm88=;
        b=ARZoW24v3NTUsWOxn/o3nFcQ+3ToSsXOhH6SUnygp/7XH6gQHjhFAQncjcuqViq7ck
         8jN5UMiAOOE8Rsi9cPnnKIhHlSMmeOwZ1+GIWQE1OeXhfNvv114neN9ScB8uMviW6mUw
         CVc+VA5Q62sycaCJyB/N8mx8dOlFI38lEXpSpE7CxBl9iaWUcI+vMZCbT7VdRIJJb2u6
         2cuWcTxJb6X6gGAobcfrErjWKZqy90r51VdpJVdaFMvy/uqFVf2SzB+r08M8YI7+ZVpg
         HP9lnHZMMnHLZTKMo0L770q8GhOq96jX9qPASHy1MtKj83BfjaZkrZX2iNXVlInhVwq1
         P9sQ==
X-Gm-Message-State: AOJu0YwbV4xMT7Dy5voK1OQsQC8vcS2LPcoCMvvb644QEMw/tnhf33Xw
	Ix64s8+MkjB538ymuZ1izY4=
X-Google-Smtp-Source: AGHT+IFWJ+IvDpEcqEsJAyOvMYPgoON85E2aD+ewCnnsASGnoIXua1Y29Ox7PjM5n0vY6mgrIktyKQ==
X-Received: by 2002:a05:600c:35c7:b0:40d:87cc:4acd with SMTP id r7-20020a05600c35c700b0040d87cc4acdmr1390780wmq.148.1704188839104;
        Tue, 02 Jan 2024 01:47:19 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040d6b91efd9sm18522525wmb.44.2024.01.02.01.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:47:18 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 2 Jan 2024 10:47:16 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>,
	"'longman@redhat.com'" <longman@redhat.com>,
	"'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'" <virtualization@lists.linux-foundation.org>,
	'Zeng Heng' <zengheng4@huawei.com>
Subject: Re: [PATCH next v2 4/5] locking/osq_lock: Avoid writing to
 node->next in the osq_lock() fast path.
Message-ID: <ZZPbpPaxi0zy8UyF@gmail.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <06a11b2c7d784f2d80dc8e81c7175c57@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a11b2c7d784f2d80dc8e81c7175c57@AcuMS.aculab.com>


* David Laight <David.Laight@ACULAB.COM> wrote:

> When osq_lock() returns false or osq_unlock() returns static
> analysis shows that node->next should always be NULL.
> This means that it isn't necessary to explicitly set it to NULL
> prior to atomic_xchg(&lock->tail, curr) on extry to osq_lock().
> 
> Just in case there a non-obvious race condition that can leave it
> non-NULL check with WARN_ON_ONCE() and NULL if set.
> Note that without this check the fast path (adding at the list head)
> doesn't need to to access the per-cpu osq_node at all.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>  kernel/locking/osq_lock.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 27324b509f68..35bb99e96697 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -87,12 +87,17 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>  
>  bool osq_lock(struct optimistic_spin_queue *lock)
>  {
> -	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> -	struct optimistic_spin_node *prev, *next;
> +	struct optimistic_spin_node *node, *prev, *next;
>  	int curr = encode_cpu(smp_processor_id());
>  	int prev_cpu;
>  
> -	node->next = NULL;
> +	/*
> +	 * node->next should be NULL on entry.
> +	 * Check just in case there is a race somewhere.
> +	 * Note that this is probably an unnecessary cache miss in the fast path.
> +	 */
> +	if (WARN_ON_ONCE(raw_cpu_read(osq_node.next) != NULL))
> +		raw_cpu_write(osq_node.next, NULL);

The fix-uppery and explanation about something that shouldn't happen is 
excessive: please just put a plain WARN_ON_ONCE() here - which we can 
remove in a release or so.

Thanks,

	Ingo

