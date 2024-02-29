Return-Path: <linux-kernel+bounces-85868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800ED86BC85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F202884D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F486EDB;
	Thu, 29 Feb 2024 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="kvLc2qxq"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819536E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165303; cv=none; b=Z8q3dT1H0cpFWCQHkYNcpKm6JtEW3nCKqTXSVqlrhwWmUYUxfJNjFSHhy+Cp+EMCn3Qt/weMC7Ts+VDoEqky5XuBHz1u6VkBLJhTVfzo6rj9rXeSofKLKpAxKNwdhM7kfmjNxkIfJ6jJDslTunT6TJADonaKPZAMJxBttFccnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165303; c=relaxed/simple;
	bh=paDv2q3Pj0hk/petqVjdUe6Lv8ps2fhGqsGP8rMoAy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxzJTUb2oibfaNOhVlzqUesQ1v3bxeKxXLPCcF85vOOvT+CzVkZ6Sl5FVDyAvmyyV0trimW6Eb1IjkpRk7pyuSgSwmaTQeOexLav0dwYGpmoEuQkrkak1uSH1grCTBaSLizHPG/Osb7kV9nkhsjm4+MRkGEbPN2LnZH4IibQWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=kvLc2qxq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412af574501so2207115e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709165300; x=1709770100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0wkdBufZ3Q5kPBTUCskgln+KBfpK1DSPE0KUyssAIE=;
        b=kvLc2qxqcngNlHFW6M1J0mkeCv05Qyxg4hsOK3u0vxmew/ISCs7ZiS3qfDm4GvEC6O
         QRCcH2eY3eripk7i/NWSucHObQNFYbls7xlqfBQjTtBgK9MzgV+42v+kXzCnyd1jYRHo
         Vz5OSGIc14Y1yEgfghi58uZ0QEPbmDam7QQOrlEuZu/lrmG3AzIUVRtawGT+x0UR2Gpc
         yN1BQkizQ76koCg+6ERdSPq14h7kKrI5qFU/Opi87q5a8wADfCdx9/lb8OuoQLBpdsdS
         gifPAQLTgBe5yqqbE9e9MrVh01qC2WiI3Qy+qyMv2ZRrrnwrYf4zv6T7G/vGZpc9laNP
         zHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165300; x=1709770100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0wkdBufZ3Q5kPBTUCskgln+KBfpK1DSPE0KUyssAIE=;
        b=IePM9/4mgGiY3JDoGRRMqd3oXEHOqXdL5BnQgZLvPMkJvLYUZZv1u8Hsv8QEz8mUi0
         IezHllq5V7VOSSsolOUt557/nDNEOXyIqQ0EzgO8skYsL38gJfpwYZ8ymzDRBn6nvevw
         /in0qP/M6Y3xi8sPbqcBcFmh1qPB1x++2NkVmFHPlXDKnIuPbq0iw6XHWVKLp7puvt0p
         mPQebgwgWVD3hlvQJcKPEYYEdfxdw+zu9MxdPgwTn4PiYihWe0n8jix56AzPQij9XXDB
         WO6pQwzibSj5Ju6ySMKNXbIBnLzr35tO+QvJRbRJlgNVE1ty7dX69S8PB51lD9Dv/rBH
         V7mw==
X-Forwarded-Encrypted: i=1; AJvYcCVmgPmLsUPl8Nkwc1JkyOrjNQoxx09ZYpr3sfXavx8eKOzhRYNqb5Yvcvl0CMKWYTA6RDCWLtyPAGzkX2Vb7FnF+lO14vVphaXuEds+
X-Gm-Message-State: AOJu0Yzzbsy5y6pDmoBTK6klb4mSbYTaUQK9o3MXpzhdphT/AA4dM2Lw
	34+sK/f1y67HzWvAFMmJIKZimpHK52KSsUxKho4iWdz2ZB/5SDvZb2cbJHH4uPGoEamU5CWvqjm
	U
X-Google-Smtp-Source: AGHT+IGZiwIML+HI/5sMSVGnCfBYssvJE6xopzMoC1X3fhBn5xxezA3YJXgljkpXlvG+ZH9NWo+TUw==
X-Received: by 2002:a05:600c:4f8a:b0:412:b673:8b18 with SMTP id n10-20020a05600c4f8a00b00412b6738b18mr547072wmq.5.1709165299686;
        Wed, 28 Feb 2024 16:08:19 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id p18-20020adf9d92000000b0033cf29a67c7sm139906wre.7.2024.02.28.16.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:08:19 -0800 (PST)
Date: Thu, 29 Feb 2024 00:08:17 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	yu.c.chen@intel.com, dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
	aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com,
	vschneid@redhat.com, pierre.gondois@arm.com,
	morten.rasmussen@arm.com
Subject: Re: [PATCH v2 0/2] sched/fair: Limit access to overutilized
Message-ID: <20240229000817.n2bnr4kioigaqtct@airbuntu>
References: <20240228071621.602596-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228071621.602596-1-sshegde@linux.ibm.com>

On 02/28/24 12:46, Shrikanth Hegde wrote:
> When running a ISV workload on a large system (240 Cores, SMT8), it was
> observed from perf profile that newidle_balance and enqueue_task_fair
> were consuming more cycles. Perf annotate showed that most of the time
> was spent on accessing overutilized field of root domain.
> 
> Aboorva was able to simulate similar perf profile by making some
> changes to stress-ng --wait. Both newidle_balance and enqueue_task_fair
> consume close to 5-7%. Perf annotate shows that most of the cycles are spent
> in accessing rd,rd->overutilized field.
> 
> Overutilized was added for EAS(Energy aware scheduler) to choose either
> EAS aware load balancing or regular load balance. As checked, on x86 and

It actually toggles load balance on/off (off if !overutilized).

misfit load balance used to be controlled by this but this was decoupled since
commit e5ed0550c04c ("sched/fair: unlink misfit task from cpu overutilized")

> powerpc both overload and overutilized share the same cacheline in rd.
> Updating overutilized is not required for non-EAS platforms.

Is the fact these two share the cacheline is part of the problem? From patch
1 it seems the fact that overutlized is updated often on different cpus is the
problem? Did you try to move overutlized to different places to see if this
alternatively helps?

The patches look fine to me. I am just trying to verify that indeed the access
to overutilzed is the problem, not something else being on the same cacheline
is accidentally being slowed down, which means the problem can resurface in the
future.

> 
> Patch 1/2 is the main patch. It helps in reducing the above said issue.
> Both the functions don't show up in the profile. With patch comparison is in
> changelog. With the patch stated problem in the ISV workload also got
> solved and throughput has improved.
> Patch 2/2 is only code refactoring to use the helper function instead of
> direct access of the field, so one would come to know that it is accessed
> only in EAS. This depends on 1/2 to be applied first
> 
> Thanks to Aboorva Devarajan and Nysal Jan K A for helping in recreating,
> debugging this issue and verifying the patch.
> Detailed perf annotate can be found in cover letter of v1.
> 
> v2 -> v1:
> Chen Yu pointed out minor issue in code. corrected that code and updated
> the changelog.
> 
> v1: https://lore.kernel.org/lkml/20240223150707.410417-1-sshegde@linux.ibm.com/
> 
> Shrikanth Hegde (2):
>   sched/fair: Add EAS checks before updating overutilized
>   sched/fair: Use helper function to access rd->overutilized
> 
>  kernel/sched/fair.c | 49 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 13 deletions(-)
> 
> --
> 2.39.3
> 

