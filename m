Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FB67F4BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344545AbjKVQDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKVQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:03:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D549A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:03:13 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b2018a11efso6976030b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700668992; x=1701273792; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEprTtuN02FAdH66dWhU95Pv9VHvp+em8IQE2HZkFyk=;
        b=NnKLBhA3Aq6G7s2sDwgqPp47Z71aXbQHlnYyaOv/WNJuKtk0whV17Do9/NLKFRFj94
         ALMmI9dn42oVoMHn+bJJK3Cz6vQLlIUcxbqqIUSSvSMuZaTOjBHXXqTay9AwJ45XGlsw
         Tz7Ckq6yh9bohWdV6rVlJUkKKkVmFfwPrD5lBrqPQVBViBf8W3gKfp0fFsxZXBakREK3
         8LrYOmBLmodT/vOsSWEVe9bfuTZ/IoRWeEYKWXAxzvqMnSPTVVL7GlK6+alyNmiLkwjP
         1AuvI+qlrBary0/3gzzDqXI5uR3Ctbqj1v7DfR3+Ba3cYiBxTsLU+TH74X9U60OFDNS1
         Irzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668992; x=1701273792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEprTtuN02FAdH66dWhU95Pv9VHvp+em8IQE2HZkFyk=;
        b=qtPCqUVIvuHJceGOHTj5NWpigGh/YJ+dNtZb11PZHLLXDCkMThJjCJli7nUGOfm8E1
         ue66uglfSzMmorpZPREbv/ENmrcXKUdm9vmLQZcxKaDQExmmzlsGwXB5VcElcju1IDpf
         dGkRRJ3NpVXzRG1EpBJ/PJWJVxDirMeCuSo29CJtIQ4mc1i0liXHboufaYxsUv8h+S+a
         DqtSwkGkPoYGrG7UDqKozohBIHJH5AuuP3U9uxz7R1uYxPudvFvhoW5E4enpRf3o/M8S
         LtElJ8vzfKcBYkn32ME8TB+1mDSmG/mV4r9ELfTO3VsBCuwM46J1dxuNY7ylKSqZB7au
         2rBg==
X-Gm-Message-State: AOJu0YxjtkB68jN9pY70LGWz/c618kX1tmq+3L4euttcFxbXNnPPMZj5
        5FBKmgnYS7rx5JwSsJxW5qw=
X-Google-Smtp-Source: AGHT+IEwwymuaMyou2nalQTxwQPGh+NQFeooHErxQvkctV+dC+zfNpy/odp0thl9vwKshkz0BQ+SQg==
X-Received: by 2002:a05:6a20:9e4d:b0:187:9521:92a7 with SMTP id mt13-20020a056a209e4d00b00187952192a7mr2925567pzb.18.1700668992442;
        Wed, 22 Nov 2023 08:03:12 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id o18-20020a056a0015d200b006cb903ab057sm6162412pfu.83.2023.11.22.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:03:12 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 22 Nov 2023 06:03:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     zhuangel570 <zhuangel570@gmail.com>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Make sure that wq_unbound_cpumask is never
 empty
Message-ID: <ZV4mPoOvIgX9Um0z@slm.duckdns.org>
References: <20231120121623.119780-1-alexyonghe@tencent.com>
 <ZVuudtAtDqHqYJr8@slm.duckdns.org>
 <CANZk6aTS9BODJiqtDSHxwhz2dV3RmaxRautR8WZfH5aYYhcQJw@mail.gmail.com>
 <ZV0jmGSismObVncD@slm.duckdns.org>
 <8f469287-e29a-4473-a181-9013292ef62c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f469287-e29a-4473-a181-9013292ef62c@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 21, 2023 at 05:08:29PM -0500, Waiman Long wrote:
> On 11/21/23 16:39, Tejun Heo wrote:
> > During boot, depending on how the housekeeping and workqueue.unbound_cpus
> > masks are set, wq_unbound_cpumask can end up empty. Since 8639ecebc9b1
> > ("workqueue: Implement non-strict affinity scope for unbound workqueues"),
> > this may end up feeding -1 as a CPU number into scheduler leading to oopses.
> > 
> >    BUG: unable to handle page fault for address: ffffffff8305e9c0
> >    #PF: supervisor read access in kernel mode
> >    #PF: error_code(0x0000) - not-present page
> >    ...
> >    Call Trace:
> >     <TASK>
> >     select_idle_sibling+0x79/0xaf0
> >     select_task_rq_fair+0x1cb/0x7b0
> >     try_to_wake_up+0x29c/0x5c0
> >     wake_up_process+0x19/0x20
> >     kick_pool+0x5e/0xb0
> >     __queue_work+0x119/0x430
> >     queue_work_on+0x29/0x30
> >    ...
> > 
> > An empty wq_unbound_cpumask is a clear misconfiguration and already
> > disallowed once system is booted up. Let's warn on and ignore
> > unbound_cpumask restrictions which lead to no unbound cpus. While at it,
> > also remove now unncessary empty check on wq_unbound_cpumask in
> > wq_select_unbound_cpu().
> > 
> > Signed-off-by: Tejun Heo<tj@kernel.org>
> > Reported-by: Yong He<alexyonghe@tencent.com>
> > Link:http://lkml.kernel.org/r/20231120121623.119780-1-alexyonghe@tencent.com
> > Fixes: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for unbound workqueues")
> > Cc:stable@vger.kernel.org  # v6.6+
> > ---
> > Hello,
> > 
> > Yong He, zhuangel570, can you please verify that this patch makes the oops
> > go away? Waiman, this touches code that you've recently worked on. AFAICS,
> > they shouldn't interact or cause conflicts. cc'ing just in case.
> 
> It does conflict with commit fe28f631fa94 ("workqueue: Add
> workqueue_unbound_exclude_cpumask() to exclude CPUs from
> wq_unbound_cpumask") as it has the following hunk:
> 
> @@ -6534,11 +6606,14 @@ void __init workqueue_init_early(void)
>         BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long
> long));
> 
>         BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
> + BUG_ON(!alloc_cpumask_var(&wq_requested_unbound_cpumask, GFP_KERNEL));
> +       BUG_ON(!zalloc_cpumask_var(&wq_isolated_cpumask, GFP_KERNEL));
>         cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
>         cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask,
> housekeeping_cpumask(HK_TYPE_DOMAIN));
> 
>         if (!cpumask_empty(&wq_cmdline_cpumask))
>                 cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask,
> &wq_cmdline_cpumask);
> +       cpumask_copy(wq_requested_unbound_cpumask, wq_unbound_cpumask);
> 
>         pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
...
> Is it possible to route this patch to cgroup for 6.8 to avoid conflict?
> Other than that, the patch looks good to me.

It's a workqueue fix patch, so what I'm gonna do is land this in
wq/for-6.6-fixes and just resolve it in cgroup/for-next.

Thanks.

-- 
tejun
