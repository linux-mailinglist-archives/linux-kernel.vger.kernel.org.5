Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9FD7BA842
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjJERmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjJERmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:42:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B3D3A96
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:31:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad8a822508so245407566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696527072; x=1697131872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1memPM/vxBDQ1ObeKhzGvTLOKg7eQnb02BOsVR5S3is=;
        b=psCt8nZnNBVWGDKo+dCX5VIHhD2VKRP0qIZh8PzAZqduScsJIgDLOBcyMACSB/UB4M
         nT1kqlpBRRa7PTYzLCbKljz5rtX2vFgnlPQ0pnEBpHpd1J+0gMH9MYlbUu5YAUD2CUB8
         VPjX8Xz+P8adMTta4y2FF5BrHYCLUwp7tbtR/Wup+TvQa4LkLr/mmrX2jgbbsauenGBf
         N7IQM76fQD4py6foF48AQMkbohSnsP6YnkaueYT+ef/PYeRvREtdN367D04pEEQA9HfR
         XWxRTnxWT7cF/bIaX1e4mdC3nI3Y+GYmhpCwI/ox75kzRiAXdR4DY9+w+MpsH8oo+kl3
         +pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696527072; x=1697131872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1memPM/vxBDQ1ObeKhzGvTLOKg7eQnb02BOsVR5S3is=;
        b=ru4gWQ8r53I6S8UYeO1/X/SFMw+gKhN/drRmVHWLTV19fnxo8pgl5MRTOHB06yvUiD
         1AvefPCFeOxeLXV9A6/5CKVInQVjFlqoxAXsaTgB1TZDIUPUVKEXsULyGU9fzI5cqKBF
         A0cQff9wabJx3l9QI4lYP8iP1nn59pfEyVaQ/Wqmkizpmnm8shU0fVJsWzVtW3jypjGq
         9dW8oUzb2qj7TD07yln0z6JQVIUffPH1SdjsqqSny73NDnQ72cYLLkSzyH0XAaxFhskk
         QSCZKIcZPdgs0NQuIVnVjvCQmzDgi036H7YtW0njmq/DI+KZAJlzovdY3mSTD+J6Z2Qn
         18Og==
X-Gm-Message-State: AOJu0Yw2wMQbAFq9Xf65fVPV1FP+6vQjc4+I1IGDvQ5/wmwDqCws1Dtu
        UCEOLZFTaIWgU6gBfUGzwKYJbC+xlz+dr0019LpMow==
X-Google-Smtp-Source: AGHT+IEL4DuC4ou8q35SZgnZsg9C0xl0WVzmWjTBKA09JsJKsmFjoBPQ+GWYLCFjWvyffBZGjdzuZu4/fxie0IehC/c=
X-Received: by 2002:a17:906:7389:b0:9a5:b878:7336 with SMTP id
 f9-20020a170906738900b009a5b8787336mr6334195ejl.7.1696527072207; Thu, 05 Oct
 2023 10:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com> <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
 <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com>
 <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
 <20231004183619.GB39112@cmpxchg.org> <542ggmgjc27yoosxg466c6n4mzcad2z63t3wdbzevzm43g7xlt@5l7qaepzbth6>
 <CAJD7tkbaTRu838U=e_A+89PY1t4K+t_G1qkYq84BSDO7wAEtEg@mail.gmail.com> <4h5uae72ti6jyiibcyfg2bytooy6d6ggtkrgod5a6rmpateyra@4setu5jmd5kn>
In-Reply-To: <4h5uae72ti6jyiibcyfg2bytooy6d6ggtkrgod5a6rmpateyra@4setu5jmd5kn>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 5 Oct 2023 10:30:36 -0700
Message-ID: <CAJD7tkZaWVhedgVAU+6WUk08V5AW=fmtken5rZJyQm+JhoDs9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 9:30=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Thu, Oct 05, 2023 at 02:31:03AM -0700, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > I am not really sure what you mean here.
>
> My "vision" is to treat WORKINGSET_ entries as events.
> That would mean implementing per-node tracking for vm_event_item
> (costlier?).
> That would mean node_stat_item and vm_event_item being effectively
> equal, so they could be merged in one.
> That would be situation to come up with new classification based on use
> cases (e.g. precision/timeliness requirements, state vs change
> semantics).
>
> (Do not take this as blocker of the patch 1/2, I rather used the
> opportunity to discuss a greater possible cleanup.)

Yeah ideally we can clean this up separately. I would be careful about
userspace exposure though. It seems like CONFIG_VM_EVENT_COUNTERS is
used to control tracking events and displaying them in vmstat, so
moving items between node_stat_item and vm_event_item (or merging
them) won't be easy.

>
> > We don't track things like OOM_KILL and DROP_PAGECACHE per memcg as
> > far as I can tell.
>
> Ah, good. (I forgot only subset of entries is relevant for memcgs.)
>
> > This will mean that WORKINGSET_* state will become more stale. We will
> > need 4096 as many updates as today to get a flush. These are used by
> > internal flushers (reclaim), and are exposed to userspace. I am not
> > sure we want to do that.
>
> snapshot_refaults() doesn't seem to follow after flush
> and
> workigset_refault()'s flush doesn't seem to preceed readers
>
> Is the flush misplaced or have I overlooked something?
> (If the former, it seems to work good enough even with the current
> flushing heuristics :-))

We flush in prepare_scan_count() before reading WORKINGSET_ACTIVATE_*
state. That flush also implicitly precedes every call to
snapshot_refaults(), which is unclear and not so robust, but we are
effectively flushing before snapshot_refaults() too.


>
>
> Michal
