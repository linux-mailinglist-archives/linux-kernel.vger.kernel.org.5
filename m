Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6899793585
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbjIFGqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjIFGqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:46:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371F0E50
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:45:45 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so2742607b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 23:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693982744; x=1694587544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL9I+GvbSGqk/J8L4Cy7qgQpbEluwLV+xYN2QshRUP8=;
        b=kCIzvy/ykX/ndWrHgzkESxjuGJ9JB7UPfNclva5DOozAHyj3ahqqSNq0dBg0dLYWFx
         id3uPziyJ/ozMaydlKvtPX2B77g2pEf2NcGoOpF/Yo0m/fTxOa8w/0/3hSfB+CFizdNq
         wGyZlWovsLWNwkZmf2FoDI9wqMOIpuMMvH1GTQIBcuLBcV0lEOsAKw58IHvPefOWzJVv
         jtG8BwJQt1JJQTUrf/GhCYI0zxUOPbmohs50RYRMNf03n7mNNXaI6OQ/LieNq85xuONg
         C+2CnwEz1xCioZ7A+hQ0rlsnfJsi7GUrXWApOGtteX8L6gLzawixB9vFkkx5Beswthb+
         RglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693982744; x=1694587544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nL9I+GvbSGqk/J8L4Cy7qgQpbEluwLV+xYN2QshRUP8=;
        b=gluCi3APzdJQ4QGrxFX8A/x1dHSoZ6qdG5jTg0fZCplX3/I1bYJB/t++JcPHiF2g3G
         M5cjhJf4v+SR5uIikb6tBXdATPxqdmtbu29y0de4o0iD+ze5ZNtaoCHZCay6Sgmv6h0i
         IHg4FrpdewU4qFkMqWttWUghz/bxOEXToobxnxnetabOlLQC7D2Ic6uzYExrKnjOhTU0
         sP2eUWwsELbRY2LNT1sCaOgLye20g9IcJDw7U9RIuwKTTuSdxIjd4wJboUj4GMubYglj
         NJz8Jn5qAUmq1ZAf48B8xXyJxdk1kRAr/ErzYvAaejYaWpi/B0hhd/0upx3Pso8Zzx32
         U+sg==
X-Gm-Message-State: AOJu0Ywr9GfyJrg1HOMkOsTuZrsxPmuT/kWxFIINCZPq5YpZ+jgbMc5d
        RrZRAcTB9dckw1wKCKOQely9aw==
X-Google-Smtp-Source: AGHT+IHsQdZ40WECGY06TpycsrNPhrky2XUvZwavzN2oCU78QD8Awx98aKeFYsmCgk6YsDoC4APibg==
X-Received: by 2002:a05:6a20:8e1f:b0:14c:e1ee:7608 with SMTP id y31-20020a056a208e1f00b0014ce1ee7608mr20667119pzj.9.1693982744698;
        Tue, 05 Sep 2023 23:45:44 -0700 (PDT)
Received: from [10.254.111.218] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id l15-20020a62be0f000000b006875be41637sm10320237pff.145.2023.09.05.23.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 23:45:44 -0700 (PDT)
Message-ID: <1823b6fd-037f-38dc-2d33-0879d77768c3@bytedance.com>
Date:   Wed, 6 Sep 2023 14:45:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 0/2] Fix nohz_full vs rt bandwidth
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pauld@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20230821094927.51079-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230821094927.51079-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Friendly ping...

On 2023/8/21 Hao Jia wrote:
> Since the commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop
> when cfs bandwidth in use") was merged, it handles conflicts between
> NOHZ full and cfs_bandwidth well, and the scheduler feature HZ_BW
> allows us to choose which one to prefer.
> 
> This conflict also exists between NOHZ full and rt_bandwidth,
> these two patches try to handle it in a similar way.
> 
> patch1: Extracts a can_stop_tick() callback function for each
> sched_class from sched_can_stop_tick(), it will make things clearer
> and also convenient to handle the conflict between NOHZ full
> and rt_bandwidth.
> 
> patch2: If the HZ_BW scheduler feature is enabled, and the RT task
> to be run is constrained by rt_bandwidth runtime. Then it will
> prevent NO_HZ full from stopping tick.
> 
> Hao Jia (2):
>    sched/core: Introduce sched_class::can_stop_tick()
>    sched/rt: Block nohz tick_stop when rt bandwidth in use
> 
>   kernel/sched/core.c     | 67 +++++--------------------------
>   kernel/sched/deadline.c | 16 ++++++++
>   kernel/sched/fair.c     | 56 +++++++++++++++++++++++---
>   kernel/sched/rt.c       | 89 ++++++++++++++++++++++++++++++++++++++++-
>   kernel/sched/sched.h    |  5 ++-
>   5 files changed, 168 insertions(+), 65 deletions(-)
> 
