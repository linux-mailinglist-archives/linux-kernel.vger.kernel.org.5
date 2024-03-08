Return-Path: <linux-kernel+bounces-96783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430D87615B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF581F22891
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2223A537E4;
	Fri,  8 Mar 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCif3ZeM"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB7535B8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891755; cv=none; b=YB8fKRGS2V6bHwr5EEj+LGFUMb0CX9L5IS39fGsBF+5jukNyP9cGUj/vMPzbxmYmu5EzbHm5UBwhxtrJ9wPjSlTERMPSm7MJo7Pof45dDHZ1/WcZ6EXnMPae54oqNIJKy92J90G2SMVOanTypc9cZw9ed3N4tVYFWuhCGm8kLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891755; c=relaxed/simple;
	bh=w2hC1LfibGwAL2Hszwk4QEy+nGwOZku05++q0gYAoPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukSw8bJ/OeqlgwPnOTYZZrLfXjIL9DETJ7moHm9ja3TjEyyjnkTWntUP4YBheb5gDZ2jA4Su80b+dZaPAkRXMsZSzLqTa2JZTBtHbl+7rrA1C26wkXbiJvjFj4uOCdHtmK+Zt2S+ZNqtyOGlqJ7xJ7x8J4jFs+9K1wHGfxh52Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCif3ZeM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512f3e75391so1567090e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709891752; x=1710496552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrS3sXgxKDxQnMuKrjdM3GAm5Om75INykXJTugop1Go=;
        b=gCif3ZeMP02HSzgeK07r7L9wRKk7tpjAvJIyLwgqohvmCHisWL6YZjHtCy6XCcfPKR
         m6INN2dmiTsnBtzDeW4vzEQWta0OCWNFmGFlkg7fnBbz29kZ2/nYkDvk7K4iCmkMDNm8
         q+QGCGpW29+S82u4WAUpR1zZV7IHAoeMKvUK+TfMEtTtQbDgD5uKi4o7Cr1HQQYtq6UD
         RnvZx3Zd3BoTf2CPd9S8Ve4aHFJNSUFUEvsdF7iOKvrbzvoeDrjxVLLTtmjs2atxkzP8
         F9wSW/5qdSR6EbmHMAOdttq+sGJPvPk5bu7Y1LBmFVbtVj+2Z1BlvopBXOvor1/97Y6t
         aiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891752; x=1710496552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrS3sXgxKDxQnMuKrjdM3GAm5Om75INykXJTugop1Go=;
        b=n7QfLwwAtThictWotoboblA2oL+wshxetNnZ5GcOmqEbr7I8kRHB337tdavxV4Osgm
         JTIr1FKcOyEnss3vGW5NJktzMrx0KWN2/hvFfFt3gc05+iRjk3qLt2AZBMl8JrfoAm1w
         Hjend0ITfOzt85qbqZS9BdFDuRF1g1aAdLrAhhtQP3rGzTVbjNo80wBuHVU8enBAywy8
         n5pkVbE+TWdqLSwQBxbu+z6OwY7MgznO6WlZENfkzaP3us1p9tuuMACDIZVsjhkM3DNX
         uQMDIqZiOSCE1X9VX8Cc8naxdbHBkrO5AsNb8F+uPhAkbjTzeQO5JMbJq8sAC/4HpgXl
         QjfA==
X-Gm-Message-State: AOJu0YwRKIZDz1eS3r2dmcd9LMS8p1czEWtKze7v+T5BpPQUeqpZ0hao
	3rp7MBdP7OUqVqX1DWk04leLIWyk1ia7dacGhAnbNehv9goLPDZg
X-Google-Smtp-Source: AGHT+IFZA1Q80JTXU5KoZpgNGOMt+5oabc/tMNFauHAF1z4jtSPxDCSxDHqvOHjcQ9cHggNI3iIZ5w==
X-Received: by 2002:a05:6512:3ca0:b0:513:177e:4254 with SMTP id h32-20020a0565123ca000b00513177e4254mr3939007lfv.14.1709891751309;
        Fri, 08 Mar 2024 01:55:51 -0800 (PST)
Received: from gmail.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0a4600b00412d4c8b743sm5469812wmq.30.2024.03.08.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:55:50 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 8 Mar 2024 10:55:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 2/9] sched/balancing: Remove reliance on 'enum
 cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in
 show_schedstat()
Message-ID: <ZergpN1xpWIwPsbx@gmail.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-3-mingo@kernel.org>
 <aa13842e-ab81-45e0-87d4-2b5360ff4782@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa13842e-ab81-45e0-87d4-2b5360ff4782@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> 
> 
> On 3/4/24 3:18 PM, Ingo Molnar wrote:
> > From: Shrikanth Hegde <sshegde@linux.ibm.com>
> > 
> > Shrikanth Hegde reported that show_schedstat() output broke when
> > the ordering of the definitions in 'enum cpu_idle_type' is changed,
> > because show_schedstat() assumed that 'CPU_IDLE' is 0.
> >
> Hi Ingo. 
> Feel free to drop me from the changelog. 

Yeah - I made you the author of the commit, and indeed it should not refer 
to you in the third person. :-) Fixed.

> 
> > @@ -150,8 +150,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
> >  
> >  			seq_printf(seq, "domain%d %*pb", dcount++,
> >  				   cpumask_pr_args(sched_domain_span(sd)));
> > -			for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
> > -					itype++) {
> > +			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
> 
> 
> It would still not be same order as current documentation of schedstat. 
> no? The documentation would need changes too. Change SCHEDSTAT_VERSION to 
> 16?

Correct. I've bumped SCHEDSTAT_VERSION up to 16 now, but since it hasn't 
been changed for the last 10+ years I'm wondering whether that's the right 
thing to do or we should add a quirk to maintain the v15 ordering?

I think we should also output the actual symbolic cpu_idle_type names into 
schedstat, so that tooling (and observant kernel developers) can see the 
actual ordering of the [CPU_MAX_IDLE_TYPES] columns.

A new line like this (mockup):

  cpu0 0 0 4400 1485 1624 1229 301472313236 120382198 7714    
+ cpu_idle_type CPU_IDLE 0 CPU_NOT_IDLE 1 CPU_NEWLY_IDLE 2 CPU_MAX_IDLE_TYPES 3
  domain0 00000000,00000000,00000055 1661 1661 0 0 0 0 0 1661 2495 2495 0 0 0 0 0 2495 67 66 1 2 0 0 0 66 0 0 0 0 0 0 0 0 0 133 38 0

.. and after the change this would become:

  cpu_idle_type CPU_NOT_IDLE 0 CPU_IDLE 1 CPU_NEWLY_IDLE 2 CPU_MAX_IDLE_TYPES 3

or so?

This gives tooling (that cares) a way to enumerate the idle types, without 
having to rely on their numeric values. Adding a new line to schedstat 
shouldn't break existing tooling - and if it does, we've increased 
SCHEDSTAT_VERSION to 16 anyway. ;-)

Thanks,

	Ingo

