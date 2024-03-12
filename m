Return-Path: <linux-kernel+bounces-100149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F8879293
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A121C22533
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C139978693;
	Tue, 12 Mar 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctLk6VFm"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F743AD53
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241076; cv=none; b=umouw3RRin3S6HkukHQQMsaT1fDWxLLJIMMfdQfIWX8Htf44ZLYx6cW2IPvLOSNZnjGJ/N4ihMrT8FEytsXM/9TkbACA8UfiYxsdLdDGuxSjIh54LghdmNbeIzIQ/tTLqQrzaIf0FVdFIZlB/Iyk4yTgbHmt1RV8NR8SOBPQQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241076; c=relaxed/simple;
	bh=MAQg29TQfQMG4G9Q99vWibsGEbRGnMkEEKQ3jUCFFbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPMomQeQqsXBgZ3ccFg7+EyZ22dF0v+dQ+L1wHJyVtiOsDDa0ovdp7n8x4mP5NClUSLslDiwrfZ1CAsZOIoxprPDRTqUuscNJNMUdr5p/S/Hevp+QaIrVroqbra3YsGadQ358CKq1I5LAJF4tWngQDFoxflicae+KmYIZrIuKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctLk6VFm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a462a1b7754so241626166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710241072; x=1710845872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVOCs2TUGUS5arc/IboU8MT7pMnIZ1PuWNFmYUPPKAg=;
        b=ctLk6VFmJ6JZqxcr0Nd+PZLLkLVeMCEBp0OzsiiNwed7UANmtXzoclk91CGWMigq15
         qwCh3ULy7MDD5cZ/9k8CD9HxH0hOh5+t6njaCp18WkEBuo+dnC4w5dZlsaAUVgNj1pRA
         v0SfaUyZLYLvArqt1oYIM2eT/OVTba1O9v8XAEnIGPtROvZ4Tq3NzjyDvhfM2QbQmtfo
         4y0UIbWzO6X3Hg0I4Sc0j3XM0N4TWiVesC1qwLF1lcUjErTuO7U1SNly4IxjFFRmdoM4
         2gTRdTt298VDYYPPGuaLAa8J25B+8Ane4adPySi6/ialyoCjAwPFhXG2ws8GSVknMic7
         D6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710241072; x=1710845872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVOCs2TUGUS5arc/IboU8MT7pMnIZ1PuWNFmYUPPKAg=;
        b=NZpOXh33W0v1niBu608nFcy0eCr9IkgU9G50RLHnbKCSwEFHKWf8OoVrYhgYfku0OC
         L1RJI0fYyhPxWrFLFvWmn8FasVsU9odYmTvt8gJSCeJiD+aP/ilKY3kKHSMc3fsJrSlS
         Lqn6KgosVozXmmUEml2HSusqkiaxaNzpS3zhHCci0b7c1UnV7FXlQDAMINyvsllFoxgz
         Nde96LT8wUNLOzIEaNFarOqF+VS39CWI8piFBe9L/ACyfGp316eAH1UtPp8sKVSVlWLc
         +r+oYjHxXKKmHLIA6b+0DxJAaTnuGptyM6qyP21gwaxItQzOHcfjI0IMgnG3uUCTTM/N
         MedA==
X-Gm-Message-State: AOJu0Yz0j7BjqjOu3BRwIsIISli4RBY9WJUOeyP5M/GxSxnnCkaXQ5e4
	2D79m9Y6pV0beykRbnqNkShwZpzCIKxbi+YvWsXvCQO3kLymC3ZS
X-Google-Smtp-Source: AGHT+IGKFkBHtsykbh9VJNJhxDlqQFrvPbA5q6S/SG7B2yoBhpx/sBKyndxtZ371SwQ0Z8v3pRA6Ew==
X-Received: by 2002:a17:907:a0cc:b0:a46:22c:7d1 with SMTP id hw12-20020a170907a0cc00b00a46022c07d1mr5612952ejc.1.1710241072008;
        Tue, 12 Mar 2024 03:57:52 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709062f8f00b00a4503a78dd5sm3814433eji.17.2024.03.12.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:57:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 12 Mar 2024 11:57:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 1/9] sched/balancing: Switch the
 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t
 sched_balance_running' flag
Message-ID: <ZfA1LRq1d2ueoSRm@gmail.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-2-mingo@kernel.org>
 <bf612672-f7c3-4585-ac31-e02a1ebf614c@linux.ibm.com>
 <Zer1Hkxh/UMxs3xs@gmail.com>
 <41e11090-a100-48a7-a0dd-c989772822d7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41e11090-a100-48a7-a0dd-c989772822d7@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> > I think we should probably do something about this contention on this 
> > large system: especially if #2 'no work to be done' bailout is the 
> > common case.
> 
> 
> I have been thinking would it be right to move this balancing 
> trylock/atomic after should_we_balance(swb). This does reduce the number 
> of times this checked/updated significantly. Contention is still present. 
> That's possible at higher utilization when there are multiple NUMA 
> domains. one CPU in each NUMA domain can contend if their invocation is 
> aligned.

Note that it's not true contention: it simply means there's overlapping 
requests for the highest domains to be balanced, for which we only have a 
single thread of execution at a time, system-wide.

> That makes sense since, Right now a CPU takes lock, checks if it can 
>  balance, do balance if yes and then releases the lock. If the lock is 
>  taken after swb then also, CPU checks if it can balance,
> tries to take the lock and releases the lock if it did. If lock is 
> contended, it bails out of load_balance. That is the current behaviour as 
> well, or I am completely wrong.
> 
> Not sure in which scenarios that would hurt. we could do this after this 
> series. This may need wider functional testing to make sure we don't 
> regress badly in some cases. This is only an *idea* as of now.
> 
> Perf probes at spin_trylock and spin_unlock codepoints on the same 224CPU, 6 NUMA node system. 
> 6.8-rc6                                                                         
> -----------------------------------------                                       
> idle system:                                                                    
> 449 probe:rebalance_domains_L37                                                 
> 377 probe:rebalance_domains_L55                                                 
> stress-ng --cpu=$(nproc) -l 51     << 51% load                                               
> 88K probe:rebalance_domains_L37                                                 
> 77K probe:rebalance_domains_L55                                                 
> stress-ng --cpu=$(nproc) -l 100    << 100% load                                             
> 41K probe:rebalance_domains_L37                                                 
> 10K probe:rebalance_domains_L55                                                 
>                                                                                 
> +below patch                                                                          
> ----------------------------------------                                        
> idle system:                                                                    
> 462 probe:load_balance_L35                                                      
> 394 probe:load_balance_L274                                                     
> stress-ng --cpu=$(nproc) -l 51      << 51% load                                            
> 5K probe:load_balance_L35                       	<<-- almost 15x less                                
> 4K probe:load_balance_L274                                                      
> stress-ng --cpu=$(nproc) -l 100     << 100% load                                            
> 8K probe:load_balance_L35                                                       
> 3K probe:load_balance_L274 				<<-- almost 4x less

That's nice.

> +static DEFINE_SPINLOCK(balancing);
>  /*
>   * Check this_cpu to ensure it is balanced within domain. Attempt to move
>   * tasks if there is an imbalance.
> @@ -11286,6 +11287,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  	struct rq *busiest;
>  	struct rq_flags rf;
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
> +	int need_serialize;
>  	struct lb_env env = {
>  		.sd		= sd,
>  		.dst_cpu	= this_cpu,
> @@ -11308,6 +11310,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  		goto out_balanced;
>  	}
> 
> +	need_serialize = sd->flags & SD_SERIALIZE;
> +	if (need_serialize) {
> +		if (!spin_trylock(&balancing))
> +			goto lockout;
> +	}
> +
>  	group = find_busiest_group(&env);

So if I'm reading your patch right, the main difference appears to be that 
it allows the should_we_balance() check to be executed in parallel, and 
will only try to take the NUMA-balancing flag if that function indicates an 
imbalance.

Since should_we_balance() isn't taking any locks AFAICS, this might be a 
valid approach. What might make sense is to instrument the percentage of 
NUMA-balancing flag-taking 'failures' vs. successful attempts - not 
necessarily the 'contention percentage'.

But another question is, why do we get here so frequently, so that the 
cumulative execution time of these SD_SERIAL rebalance passes exceeds that 
of 100% of single CPU time? Ie. a single CPU is basically continuously 
scanning the scheduler data structures for imbalances, right? That doesn't 
seem natural even with just ~224 CPUs.

Alternatively, is perhaps the execution time of the SD_SERIAL pass so large 
that we exceed 100% CPU time?

Thanks,

	Ingo

