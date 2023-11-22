Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8571D7F4BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbjKVQEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344202AbjKVQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:04:03 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A8D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:04:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c34e87b571so5609766b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700669040; x=1701273840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7cMDqBu4Wn/LO2k1S5o95VYZgM9JQiq8BqEettnVXo=;
        b=S7DOaT7IjtSegrgRvWqn5pLuT43JcjFM6r4XHmu8hTccTfGsshJ1duC/aKMKJe1OG3
         M1qzzWlxyH17eXYAFn9pkcpX5sXvuMWVftQDSbsSmZjWt3nGKN8uhVBgxVIF8S8zzaRn
         VyS/qSIAK+MVeZ7Rw8QEhzITY30F05RcZdWuTyt3Z4Umt11eN+/naiBArSx4jDdB7HGX
         c39JE2Xzv18IT35QzDHOopjicNnY3jifgmUy6arm+RsNK2AWi1QROeiNTMwDGDASEv/2
         F7iAxwju9XVaSACAUFlLNgmzu/SUGh4UawcJbzqD/cXkN+JzydSSJpC78r2kofzkqwH4
         SBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669040; x=1701273840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7cMDqBu4Wn/LO2k1S5o95VYZgM9JQiq8BqEettnVXo=;
        b=L5ksIXSQMLXHtZpFtNxX1vRLIW04S2bxFa7pIE5mDDyjq9Vkr3AO53fvUYwz+e+npn
         +9GuwXO/6MVrMAHFOheaPYVHpH/+ITJmL4alhhxwob5cmjT1fTGhUbCCym2QyvUZKkdl
         5uF/LnpSiSu7LoZ3Yyw9EPPNVzDGhhdGLKFWecvs7ZjNRCa2MjSSOV3UWmFi44My+WQ8
         Qg/UV7KG90gh3buhnb78AYzjUJDnokLkCTq/824OiktXe02j7pO7HqtKzzeqGdE0ecbM
         8bPkaq3IJRxZhwP6jvQR6ErcLi+9dSLCWxzf7JqBE4GaL88wO9ey03IfnjUZNg5gFLF7
         48cQ==
X-Gm-Message-State: AOJu0YzkVkNVcYRZbkQdHjtmz0LnOxVliZjFBA1el6qoMzBMwu4iZhwl
        dcU22rH4qzApx36RbWbH/w7VEwrxJEFtgg==
X-Google-Smtp-Source: AGHT+IFHDyxS+0fAyXBTMXk/KqKXy5N1u5NuA7bjzZNdV51MFBkx0BrdxisBs9vdZFVwEi2AOvzNBQ==
X-Received: by 2002:a05:6a21:193:b0:18b:2254:98eb with SMTP id le19-20020a056a21019300b0018b225498ebmr3379867pzb.27.1700669039726;
        Wed, 22 Nov 2023 08:03:59 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id n56-20020a056a000d7800b006cbbfeec4e0sm3359873pfv.92.2023.11.22.08.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:03:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 22 Nov 2023 06:03:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     zhuangel570 <zhuangel570@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] workqueue: Make sure that wq_unbound_cpumask is never
 empty
Message-ID: <ZV4mbn3LLQHsKIGq@slm.duckdns.org>
References: <20231120121623.119780-1-alexyonghe@tencent.com>
 <ZVuudtAtDqHqYJr8@slm.duckdns.org>
 <CANZk6aTS9BODJiqtDSHxwhz2dV3RmaxRautR8WZfH5aYYhcQJw@mail.gmail.com>
 <ZV0jmGSismObVncD@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV0jmGSismObVncD@slm.duckdns.org>
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

On Tue, Nov 21, 2023 at 11:39:36AM -1000, Tejun Heo wrote:
> During boot, depending on how the housekeeping and workqueue.unbound_cpus
> masks are set, wq_unbound_cpumask can end up empty. Since 8639ecebc9b1
> ("workqueue: Implement non-strict affinity scope for unbound workqueues"),
> this may end up feeding -1 as a CPU number into scheduler leading to oopses.
> 
>   BUG: unable to handle page fault for address: ffffffff8305e9c0
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   ...
>   Call Trace:
>    <TASK>
>    select_idle_sibling+0x79/0xaf0
>    select_task_rq_fair+0x1cb/0x7b0
>    try_to_wake_up+0x29c/0x5c0
>    wake_up_process+0x19/0x20
>    kick_pool+0x5e/0xb0
>    __queue_work+0x119/0x430
>    queue_work_on+0x29/0x30
>   ...
> 
> An empty wq_unbound_cpumask is a clear misconfiguration and already
> disallowed once system is booted up. Let's warn on and ignore
> unbound_cpumask restrictions which lead to no unbound cpus. While at it,
> also remove now unncessary empty check on wq_unbound_cpumask in
> wq_select_unbound_cpu().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Yong He <alexyonghe@tencent.com>
> Link: http://lkml.kernel.org/r/20231120121623.119780-1-alexyonghe@tencent.com
> Fixes: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for unbound workqueues")
> Cc: stable@vger.kernel.org # v6.6+

Applied to wq/for-6.7-fixes.

Thanks.

-- 
tejun
