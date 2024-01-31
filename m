Return-Path: <linux-kernel+bounces-47259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51709844B10
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849C91C22C01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12239FE3;
	Wed, 31 Jan 2024 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgyHmitG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5185438FA4;
	Wed, 31 Jan 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740142; cv=none; b=tQ7ScVbfcSk5/lbiidVZuj+ubAdvclJHpfOGI9bKdfUKZq9nNdFdjvawRS03h7evzxe0BFZWw0nUoKPp6Km/X+cbqToMhqKzvIWWNHrYoSxjJr+lJ9NHv32Ku03PHdLhYUCPZF3wkQlwoKhIQTxTCzhSEfYo/uOdytPNmCfdGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740142; c=relaxed/simple;
	bh=o8QhU6PXRn0FWV9WeF8MomXhKC9ONFhUtRlfDlW3ndw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXY6V8BZIqAgiO1iJZ0VzGPbhW+pX+NPNWoFnR8STHUfmceonRcL1lLfJqgGf8GibPV65JM0IvKrVr3sa5FlgqAagHOYpYrq2/sf2lshagbAPARjbq0bXva9XSdG8b15EQYNwTn+6f23t56QaM4qE6TvpY8+XZrNgbIgq5qJT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgyHmitG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d51ba18e1bso2841775ad.0;
        Wed, 31 Jan 2024 14:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706740140; x=1707344940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jmur6T5mZGQKYVYzLYzXWlcErNmYge/Ids/pkRMTDgA=;
        b=AgyHmitGoHIWYeSu3Wtz5t2asudi97ikAffXb1nYQkGHB5yMEs2GofC/Ufjy4d+3zC
         w0TxdcUb/Y1wMZf8cz+ZBKQHNx28uxIBSgaoLGjQxzZVLS6nTcT1y679QfwAEWo+CX8x
         CqGviYR0vqtafCjt32Zmbx82jmmGTCWzpg7KUJR7iQuPVo3Hvrp2LI6C+gD0x0elPO5K
         8JcCHnDbIsr+ZN9+SvpzMZGHNURves69VnY+cjPDRRHSdU7OcWEpZiM45ThtvCDzY83K
         Kl8b8cS2i5W7d4UPielMfi+shUwzqDhkvAvKhScmDQ8sjiclJpFEi6NrVDn4qfjFphls
         SQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740140; x=1707344940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jmur6T5mZGQKYVYzLYzXWlcErNmYge/Ids/pkRMTDgA=;
        b=q8xmFW5rfwmiN/8I4OcCH5q7c0SFPNM/WkjoU1AlIR7ywTXoA24cue1yxXZ628g2i7
         9jfwVXoEdWbbYbLqHK8mfDWHvXlHc8lTqWl4rWomRpinq6UQQsnocryybWWJH1doj1ED
         I6aE5Sz6b4su19P0PcAeQ1Vhlv4jjRT2IRDoO3gB6EsemPgykLsAz1D8XOtcJwLKVys2
         1JtNThvQK4sH/dAD8aKaYgc0WBUzW+Oo0GGqXpRGmMBia90uXRghc5iNwl2OIsnqZdLj
         72vlxtMnnv/6f9gy1/KlQatqiGoQRay3Kmh0YrjDisH4gU0EkmxBaQxBEunZz15Ab1gK
         Dpcw==
X-Gm-Message-State: AOJu0Yw1f/klc8Jng6s309pnqCrCZJrGlE+/lWhYo+1g4DQjwxrIHv9/
	Fs/kzeOZSWojXkMXCds3fh48ouD5TozA8cKTSwEY5UMHoJcO9Ugvc3VASHynXA0=
X-Google-Smtp-Source: AGHT+IGRg3QCi53M1+UV+9txsOxdw45LyisS9f36UwLm82dt7LgNfF3wdDc7nd4RGzmS1Omucc+aWg==
X-Received: by 2002:a17:903:41c4:b0:1d9:3b54:d857 with SMTP id u4-20020a17090341c400b001d93b54d857mr2671478ple.23.1706740140432;
        Wed, 31 Jan 2024 14:29:00 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id kt14-20020a170903088e00b001d90306bdcfsm4020079plb.65.2024.01.31.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:29:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 31 Jan 2024 12:28:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Helge Deller <deller@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Message-ID: <ZbrJq3X63hIMkbl2@slm.duckdns.org>
References: <ZbqfMR_mVLaSCj4Q@carbonx1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbqfMR_mVLaSCj4Q@carbonx1>

Hello,

On Wed, Jan 31, 2024 at 08:27:45PM +0100, Helge Deller wrote:
> When hot-unplugging a 32-bit CPU on the parisc platform with
> "chcpu -d 1", I get the following kernel panic. Adding a check
> for !pwq prevents the panic.
> 
>  Kernel Fault: Code=26 (Data memory access rights trap) at addr 00000000
>  CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 6.8.0-rc1-32bit+ #1291
>  Hardware name: 9000/778/B160L
>  
>  IASQ: 00000000 00000000 IAOQ: 10446db4 10446db8
>   IIR: 0f80109c    ISR: 00000000  IOR: 00000000
>   CPU:        1   CR30: 11dd1710 CR31: 00000000
>   IAOQ[0]: wq_update_pod+0x98/0x14c
>   IAOQ[1]: wq_update_pod+0x9c/0x14c
>   RP(r2): wq_update_pod+0x80/0x14c
>  Backtrace:
>   [<10448744>] workqueue_offline_cpu+0x1d4/0x1dc
>   [<10429db4>] cpuhp_invoke_callback+0xf8/0x200
>   [<1042a1d0>] cpuhp_thread_fun+0xb8/0x164
>   [<10452970>] smpboot_thread_fn+0x284/0x288
>   [<1044d8f4>] kthread+0x12c/0x13c
>   [<1040201c>] ret_from_kernel_thread+0x1c/0x24
>  Kernel panic - not syncing: Kernel Fault
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> ---
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 76e60faed892..dfeee7b7322c 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4521,6 +4521,8 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
>  	wq_calc_pod_cpumask(target_attrs, cpu, off_cpu);
>  	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
>  					lockdep_is_held(&wq_pool_mutex));
> +	if (!pwq)
> +		return;

Hmm... I have a hard time imagining a scenario where some CPUs don't have
pwq installed on wq->cpu_pwq. Can you please run `drgn
tools/workqueue/wq_dump.py` before triggering the hotplug event and paste
the output along with full dmesg?

Thanks.

-- 
tejun

