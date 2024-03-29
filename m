Return-Path: <linux-kernel+bounces-124028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3869489115F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB6E1C294ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999F83FB3C;
	Fri, 29 Mar 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="rlho6/bi"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886003FB2E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677980; cv=none; b=iwHcvK7M+li1FYLyWypg6UBVa9ZfjdGNJt590frKrYA6JehPpSWSvVWYtLllfVH68MVG53YPulmT1nI7nZGv0t2qnIT7WF+bEeJhU/Dmzn4q3MeXaIS0LZAg0iRd8ahgrdBTXmkLYO0wetGinvu5peFSX7Dw6uzAG/DpRgsHTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677980; c=relaxed/simple;
	bh=DBlPsbXkK9PuCFeKl5+wID1dbZnG1fC3D+fZKD+R0q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh4TkH6oGMNDIs1z6pYgwF9jRyVbZzIEUIx9LXuhTfY+BKv4lbgVMGa8pe3vlxT433sBbPTCVddTAvd0HqbWTakGDgSn+B9hBsPg6iGiU5bJZ2LlnyMQLGQqjoDefjXKFG480CpxHuZ0x7Yne8Nlr/YPlkxd/8Pq69WoFrjideM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=rlho6/bi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41544650225so8745105e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711677977; x=1712282777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OC01vknNdwK9p3bmYBn5CPtUhO8JVeO9YxURycVa+50=;
        b=rlho6/biosmqjlAFgJtwO8YwvWADW31X2zRmEfGx3+xpgUaSayyMGleTSMtqzG2IUG
         qVy/qBprEUiIbD7ij0kQodLzVpJhBChCR/Ui9RcGWn0TEClzh6zw/InTskFqeBI6wlfi
         Cma8dASezxgAa3AINlx3sSwugw4sPBlJ911Axr1lO4jOQlqp2xbrlwE86hiGbW1PIUCj
         5cHqLG3pCBQFg1iuHqRoy+kEva6dgRDIVWS3sXOCch1n800wVJUqg5SP3w7k4+L7y+CP
         t+/d5O1UThp2uS+Asvdz1YrdfhOk+fOaUaDPFLSpQPlFHJEp0BJSptygC6DzROovaoR1
         TtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677977; x=1712282777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC01vknNdwK9p3bmYBn5CPtUhO8JVeO9YxURycVa+50=;
        b=Sn0aqK6NBvY7gz/QHRF95umtYunQGA1PsMItDKIMBiTFpsqm+BNLUGNjXzt6F52ata
         2JnuxgLO+ADmQxXlDOqZ94FEn4juoG94NetG++SZElL1hy5R4b21dshq5PJhTysstnhB
         WkvJvy8FWIwYcFdynpXbmum02InmQDNvOHJLRcY1oEk0sSBaCjJSvbvVx0U3/tb8iE4t
         KbYHgs52v05XqG6pRQmP/UP12dGgbV7KZ8HhZCo99rjNZI1w2d0BWeLhm3v6xkThZBSY
         1IfG+6mNx8NwdICfQhSxQH4GB1V1LFbGqffYhiRtnvjKpqC5QF33PsVSZ0CLsys5WPJ4
         iptw==
X-Gm-Message-State: AOJu0YwHk9ahvtjcRgIGUDJGy7v+RhYJ3JXRwi6yBYQACTvzCSHtUYAy
	1MIkkV2lYTNr/x8mdb9dR69KpWITjeALSr9cHkKY3BbTx06J0W8PVtqUf51kev0=
X-Google-Smtp-Source: AGHT+IHG6/ho4Nc76ecQeEB6S/RMOGikV9IoO50wq62xTQ+YV8aQaWFrHM28OeNXiLjL0MtP+QYjaQ==
X-Received: by 2002:a05:600c:154f:b0:414:1351:8662 with SMTP id f15-20020a05600c154f00b0041413518662mr691503wmg.12.1711677976584;
        Thu, 28 Mar 2024 19:06:16 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id hg13-20020a05600c538d00b004154ef6c9b2sm370905wmb.16.2024.03.28.19.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 19:06:16 -0700 (PDT)
Date: Fri, 29 Mar 2024 02:06:14 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Pierre Gondois <Pierre.Gondois@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v8 0/4] sched: Don't trigger misfit if affinity is
 restricted
Message-ID: <20240329020614.ntohx3unopuo5ttl@airbuntu>
References: <20240324004552.999936-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240324004552.999936-1-qyousef@layalina.io>

+Lukasz

On 03/24/24 00:45, Qais Yousef wrote:
> There was a discussion on handling hotplug operation removing a capacity level
> and lead to unnecessary misfit lb to trigger again. I opted not to handle it
> now, but a working patch is available in [1]. I don't feel strongly about it
> and would leave it up to the maintainers to push which direction they prefer.
> Patch 4 will make sure that balance interval and nr_failed won't grow
> unnecessarily due to bad unnecessary misfit lb. It will lead to some
> sub-optimality, but no incorrect behavior.
> 
> After 6.9 merge window, dynamic Energy Model series would be merged and it can
> lead to the capacities of the CPUs being changed at runtime. This means I need
> to post follow up patch to handle this situation to ensure max_allowed_capacity
> is correct after an EM update. It might make then handling of hotplug operation
> attractive too as there would be some common shared ground.

I was trying to work on this follow up patch now tip has moved to 6.9-rc1, but
I can't see how the new dynamic EM logic will trigger an update to
asym_cap_list. Did I miss something? Will/should init_cpu_capacity_callback()
be triggered after the update?

How will scheduler know the new max capacities are different? Or did
I misunderstand the new EM runtime logic and it won't lead to having a new
arch_scale_cpu_capacity() values?


Thanks!

--
Qais Yousef

> 
> [1] https://lore.kernel.org/lkml/20240321122039.7gk2mc3syvkrvhjz@airbuntu/
> 
> Changes since v7:
> 
> 	* Remove sd arg from check_misfit_status()
> 	* Update typo in commit message in patch 2.
> 	* Add Reviewed-by from Vincent
> 
> Changes since v6:
> 
> 	* Simplify update_misfit_status
> 
> Changes since v5:
> 
> 	* Remove redundant check to rq->rd->max_cpu_capacity
> 	* Simplify check_misfit_status() further by removing unnecessary checks.
> 	* Add new patch to remove no longer used rd->max_cpu_capacity
> 	* Add new patch to prevent misfit lb from polluting balance_interval
> 	  and nr_balance_failed
> 
> Changes since v4:
> 
> 	* Store max_allowed_capacity in task_struct and populate it when
> 	  affinity changes to avoid iterating through the capacities list in the
> 	  fast path (Vincent)
> 	* Use rq->rd->max_cpu_capacity which is updated after hotplug
> 	  operations to check biggest allowed capacity in the system.
> 	* Undo the change to check_misfit_status() and improve the function to
> 	  avoid similar confusion in the future.
> 	* Split the patches differently. Export the capacity list and sort it
> 	  is now patch 1, handling of affinity for misfit detection is patch 2.
> 
> Changes since v3:
> 
> 	* Update commit message of patch 2 to be less verbose
> 
> Changes since v2:
> 
> 	* Convert access of asym_cap_list to be rcu protected
> 	* Add new patch to sort the list in descending order
> 	* Move some declarations inside affinity check block
> 	* Remove now redundant check against max_cpu_capacity in check_misfit_status()
> 
> Changes since v1:
> 
> 	* Use asym_cap_list (thanks Dietmar) to iterate instead of iterating
> 	  through every cpu which Vincent was concerned about.
> 	* Use uclamped util to compare with capacity instead of util_fits_cpu()
> 	  when iterating through capcities (Dietmar).
> 	* Update commit log with test results to better demonstrate the problem
> 
> v1 discussion: https://lore.kernel.org/lkml/20230820203429.568884-1-qyousef@layalina.io/
> v2 discussion: https://lore.kernel.org/lkml/20231212154056.626978-1-qyousef@layalina.io/
> v3 discussion: https://lore.kernel.org/lkml/20231231175218.510721-1-qyousef@layalina.io/
> v4 discussion: https://lore.kernel.org/lkml/20240105222014.1025040-1-qyousef@layalina.io/
> v5 discussion: https://lore.kernel.org/lkml/20240205021123.2225933-1-qyousef@layalina.io/
> v6, v7 discussion: https://lore.kernel.org/lkml/20240220225622.2626569-1-qyousef@layalina.io/
> 
> Thanks!
> 
> --
> Qais Yousef
> 
> Qais Yousef (4):
>   sched/topology: Export asym_capacity_list
>   sched/fair: Check a task has a fitting cpu when updating misfit
>   sched/topology: Remove max_cpu_capacity from root_domain
>   sched/fair: Don't double balance_interval for migrate_misfit
> 
>  include/linux/sched.h   |  1 +
>  init/init_task.c        |  1 +
>  kernel/sched/fair.c     | 79 +++++++++++++++++++++++++++++++----------
>  kernel/sched/sched.h    | 16 +++++++--
>  kernel/sched/topology.c | 56 ++++++++++++++---------------
>  5 files changed, 104 insertions(+), 49 deletions(-)
> 
> -- 
> 2.34.1
> 

