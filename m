Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE7801B83
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjLBIb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBIbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:31:25 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573AA19F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 00:31:32 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-285d331c6f7so3115018a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 00:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701505892; x=1702110692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RsUdxN3rEKIxfrBuDtxm58n3Q5/dFJQLUdAs66Hut1M=;
        b=MShJEUEzENjNwWoJezzhBQZOjctUkNEpt0Ur0LcriNCkEPkJeXV5Hzt48ikjmbdlEE
         4flTeoovGc5J98C7K3KrUu4jD+0HvgvrVmcdP/u8qws8PPFg76fveDJqvW17GIUXSWF9
         MZMpFttgoyDmuUBDlk300DRq9QaQnAk8ntLudSo3TY6RLVtlPSLF4SGaetiyTTYGk+J1
         bC9fCyBk4Bbrq8v1wiZP5IiFnl9aY7eu/Etb8L0QR3TXxNAB1U46XPCvEiH3B0bTQJKK
         9ojkRXjzqwUbWbNQG8PJLwX0SeZj4LCooIycUA5Iic8r4v++IpRCuc6KsikZYVajxep2
         LNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701505892; x=1702110692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsUdxN3rEKIxfrBuDtxm58n3Q5/dFJQLUdAs66Hut1M=;
        b=PJUC95PzX5Y0WzrZC8K3JYEGRhmD0mDsCiVYoAxhIGmFYKq355H6j/IVRwBABrd5AM
         wGh51qM7B6JreeWX05oHaXVvRlgFf+mMOcIbA0wkN1y7d7DLVTkTktunFKFeoobbXBu0
         /YzVWQXtxKCzCM3c1xopCLt6YcA0JwLSHZmpNA0mYu1nBD9Liz/9zXkUilUuzP9FFx18
         f7DevRMmm3p6pNanwgPlQh4bnnFYQIKHa8LGUj4NOTPr4IsIg9+UKaFJUhwdU3bJ1lMJ
         lDVMCoaxUsxFMJNYOkNjfBHgMSwxX+Sd+cGTOxr0bcFxM1iBw+dIlksx+uK1Wd+i6t6q
         4rkA==
X-Gm-Message-State: AOJu0YxQJqiyScw19mR5Aa6vbLUWHYRcJIWkvsIfyWo1TlnAceo0pK7t
        B34lKMGMxu0jz+IleYzSCznlegdLq9ocoA==
X-Google-Smtp-Source: AGHT+IF4f5vUtic/5wEWsO4maQQ3yGnMxcSHVpbovj/TMUbKq4uvbD+NDX7zW2s8EKvkAZHr3JG7LPHRBRuUXQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:d249:0:b0:5bd:408a:5e1f with SMTP id
 t9-20020a63d249000000b005bd408a5e1fmr4143862pgi.3.1701505891574; Sat, 02 Dec
 2023 00:31:31 -0800 (PST)
Date:   Sat, 2 Dec 2023 08:31:29 +0000
In-Reply-To: <20231129032154.3710765-6-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com> <20231129032154.3710765-6-yosryahmed@google.com>
Message-ID: <20231202083129.3pmds2cddy765szr@google.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:21:53AM +0000, Yosry Ahmed wrote:
[...]
> +void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  {
> -	if (memcg_should_flush_stats(root_mem_cgroup))
> -		do_flush_stats();
> +	static DEFINE_MUTEX(memcg_stats_flush_mutex);
> +
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	if (!memcg)
> +		memcg = root_mem_cgroup;
> +
> +	if (memcg_should_flush_stats(memcg)) {
> +		mutex_lock(&memcg_stats_flush_mutex);

What's the point of this mutex now? What is it providing? I understand
we can not try_lock here due to targeted flushing. Why not just let the
global rstat serialize the flushes? Actually this mutex can cause
latency hiccups as the mutex owner can get resched during flush and then
no one can flush for a potentially long time.

> +		/* Check again after locking, another flush may have occurred */
> +		if (memcg_should_flush_stats(memcg))
> +			do_flush_stats(memcg);
> +		mutex_unlock(&memcg_stats_flush_mutex);
> +	}
>  }

