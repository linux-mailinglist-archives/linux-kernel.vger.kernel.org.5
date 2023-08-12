Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE6779CA3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjHLCgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjHLCg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:36:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590F72683
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:36:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3c8adb27so350511166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691807786; x=1692412586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtg+keftJRj1GAGPnWqMjYAi2LDgfBuNTq5Si7vTecY=;
        b=EFOEq2BK/3AphDg71atGtLZ3JNf6pD/7iQNGpkLyIQvAGsS+4+4SDj5EXwfcZuKpN9
         A+kszuv1uvx3C1buqXecddsH+TNzr3nNv+/ciToEnvZYJMhXRN7Ig7OTiyTdiGQKjsz+
         PxH7SdFaIg8DGqgE0GVTY+L2ezzu7vbB4GCjgFqW5+jEJwgkGezz9nifLOg7fBEhg1tQ
         JVzQodQQ4p5Dk3pR5ARWlMWQ3Vp9/ZAJduQ+pZ++7N8u9oacbRZGmvI13+4QrcmPS3qk
         iEFNSRzrzGb3SDnZ6+WSWTeMLfKh8Nb4YBVqq28kkXxyqT1XDUOrMQd2rGJFcvD29Q1R
         yXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691807786; x=1692412586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xtg+keftJRj1GAGPnWqMjYAi2LDgfBuNTq5Si7vTecY=;
        b=a3Ch0xTUIBh8rQXUtd/dlYgiueKOcSkQ1VncO39Ze3LK9hDogVxm0FWs3xfWGzYTV3
         /USerXOXrmECGRUExTkE+drkNSFv8y3i1HiFn3kt28s+AdDTFtuyXa3qWO5473QKkSPU
         jYYx/C7M/DJa3Seu3I47kyKT32tDc59W0Te3O7ymWslUZUmghpIJArd205cg9kxoPF84
         AG12V8Pc8DyqubrsENQXK71IpUNM4b/lBy6/VKFytHVpMRsC9FGh1BR1jE1Rx9mhGxrJ
         8dLRgRpGP6PqczZV/U4Zaqi+/1dw2xmUHnUuc2NDLEfJiZVz/umhV8R9iuoXeNwt6ZqF
         eLMA==
X-Gm-Message-State: AOJu0YwLgQieF9AN/eAqd4T6/yGSPCqSp2hHsSsWLoQyWhlNDacCZsYo
        voMwTtQvmEEDU4npuKNxVItMwupKa0h/fvNGdG+zw18lnon4du1RroHDyA==
X-Google-Smtp-Source: AGHT+IGMWSN+c8sxymGLB2eGBzyRHqN3Nj8gg9iLZSl8EdNpkwkkZ6CXqWPC7ShChxyvlcU2yRKpXnHyvkAU+/55/yU=
X-Received: by 2002:a17:906:13:b0:993:e9b8:90ec with SMTP id
 19-20020a170906001300b00993e9b890ecmr3343614eja.22.1691807785763; Fri, 11 Aug
 2023 19:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz> <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz> <CAJD7tkb9C77UUxAykw_uMQvkzGyaZOZhM0nwWn_kcPjV0umyuA@mail.gmail.com>
 <ZNOVS0Smp2PHUIuq@dhcp22.suse.cz> <CAJD7tkZFxbjas=VfhYSGU84Y5vyjuqHqGsRjiDEOSDWh2BxNAg@mail.gmail.com>
 <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz> <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
 <ZNaLGVUtPu7Ua/jL@dhcp22.suse.cz> <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
 <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com> <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
In-Reply-To: <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 11 Aug 2023 19:35:49 -0700
Message-ID: <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 11, 2023 at 7:29=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Fri, Aug 11, 2023 at 7:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> [...]
> >
> > I am worried that writing to a stat for flushing then reading will
> > increase the staleness window which we are trying to reduce here.
> > Would it be acceptable to add a separate interface to explicitly read
> > flushed stats without having to write first? If the distinction
> > disappears in the future we can just short-circuit both interfaces.
>
> What is the acceptable staleness time window for your case? It is hard
> to imagine that a write+read will always be worse than just a read.
> Even the proposed patch can have an unintended and larger than
> expected staleness window due to some processing on
> return-to-userspace or some scheduling delay.

Maybe I am worrying too much, we can just go for writing to
memory.stat for explicit stats refresh.

Do we still want to go with the mutex approach Michal suggested for
do_flush_stats() to support either waiting for ongoing flushes
(mutex_lock) or skipping (mutex_trylock)?
