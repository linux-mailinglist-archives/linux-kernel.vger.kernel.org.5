Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A5E79CF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjILLMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjILLLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:11:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA192172C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:10:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so7051926a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694517007; x=1695121807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sq0fA/VatZ++ayfpGlQL3susC/RviepPCleB3baLTw=;
        b=ibueTLkYyDcakKnfmNNANAP0ZaZtuoHKt8ZiLX4Me5YTXK4m40JAcqFjJH463s68gA
         BCzfDROkDsS8eC4dlXWZ6nMWOJH12ce/HKdjFOmBD2wBBnHH11x9rNDPvb2ZfHfEqC+r
         4xgJML+gnriCrUO2Lb05RoDLr7IISXXtjM2NCh02a1hMd8zO6Pff0hR3XwylXCh3VAZJ
         F9+m07hsjzGA3YSAPQaTn4ZH/uXbhNGFO4fn0fDjlGqpRsMKCLwOmAeXvIThiBR94yJz
         zPRx3x8EjVpr+Cxj9xWR50hXpdArrUp0Ur0Dq1tNUbzCtPYzck+m2C1fd1v62U+LInqW
         cOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694517007; x=1695121807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Sq0fA/VatZ++ayfpGlQL3susC/RviepPCleB3baLTw=;
        b=drz8EZWCJwKP0rF+gm4i4YcHRT9rG6UzUOcHIMZ3Mbx67dY/JjMmKqvcFNjbTBn+3i
         3t7FspyqpxSaD2+S2KLxW9BJ71pcu7zsx2MNHfxQ4CyC0nNfNSrANt469S1+2W4IPj5m
         bGpIu0qI4So02vZK9CbQrIPHvQelPQy7G8mC3EedQKGPoIVPTHnmIC/o0Gd+KG9l6gIB
         9bEEg/f0Clb+kAWX5BzHd1OXUtrlQO20ldzxdQE3mEfilZZoLxDmFmNkudu5Acl1U0ov
         3cALiIPalrde+u0NqnpI7acqrtShOGaBVlIasuJxYqDjHFYZ4aGtQidY48KAZAla0O01
         wMzw==
X-Gm-Message-State: AOJu0YzPUmMCtPD3o/D6+W2HnUamCgcYHWftiAFXSZZrZ66v32GFehwP
        3pEgR+tdg+SkZ9KmL9oAN3kb+A9vALLZDSo2t6KRTQ==
X-Google-Smtp-Source: AGHT+IEqf692PpcwWJ+KIdN9fRGhrkF5AMtPRxevzTGnCQ4lbfLrNNYioDArel+eLcA3y9SeK6u55VX/HEgsrXww4s0=
X-Received: by 2002:a17:906:10dc:b0:99c:f47a:2354 with SMTP id
 v28-20020a17090610dc00b0099cf47a2354mr12544637ejv.70.1694517007270; Tue, 12
 Sep 2023 04:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com> <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
 <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com>
 <ZP8SDdjut9VEVpps@dhcp22.suse.cz> <CAAPL-u8NndkB2zHRtF8pVBSTsz854YmUbx62G7bpw6BMJiLaiQ@mail.gmail.com>
 <ZP9rtiRwRv2bQvde@dhcp22.suse.cz> <CAAPL-u9XwMcrqVRu871tGNKa3LKmJSy9pZQ7A98uDbG6ACzMxQ@mail.gmail.com>
 <ZP92xP5rdKdeps7Z@mtj.duckdns.org> <ZQBFZMRL8WmqRgrM@dhcp22.suse.cz>
In-Reply-To: <ZQBFZMRL8WmqRgrM@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 12 Sep 2023 04:09:28 -0700
Message-ID: <CAJD7tka4zEcu-jMycMo0=xB7PP1j7P0gu_weGJSLQvbhYMzv9Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 4:03=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 11-09-23 10:21:24, Tejun Heo wrote:
> > Hello,
> >
> > On Mon, Sep 11, 2023 at 01:01:25PM -0700, Wei Xu wrote:
> > > Yes, it is the same test (10K contending readers). The kernel change
> > > is to remove stats_user_flush_mutex from mem_cgroup_user_flush_stats(=
)
> > > so that the concurrent mem_cgroup_user_flush_stats() requests directl=
y
> > > contend on cgroup_rstat_lock in cgroup_rstat_flush().
> >
> > I don't think it'd be a good idea to twist rstat and other kernel inter=
nal
> > code to accommodate 10k parallel readers.
>
> I didn't mean to suggest optimizing for this specific scenario. I was
> mostly curious whether the pathological case of unbound high latency due
> to lock dropping is easy to trigger by huge number of readers. It seems
> it is not and the mutex might not be really needed as a prevention.
>
> > If we want to support that, let's
> > explicitly support that by implementing better batching in the read pat=
h.
>
> Well, we need to be able to handle those situations because stat files
> are generally readable and we do not want unrelated workloads to
> influence each other heavily through this path.

I am working on a complete rework of this series based on the feedback
I got from Wei and the discussions here. I think I have something
simpler and more generic, and doesn't proliferate the number of
flushing variants we have. I am running some tests right now and will
share it as soon as I can.

It should address the high concurrency use case without adding a lot
of complexity. It basically involves a fast path where we only flush
the needed subtree if there's no contention, and a slow path where we
coalesce all flushing requests, and everyone just waits for a single
flush to complete (without spinning or contending on any locks). I am
trying to use this generic mechanism for both userspace reads and
in-kernel flushers. I am making sure in-kernel flushers do not
regress.

>
> [...]
>
> > When you have that many concurrent readers, most of them won't need to
> > actually flush.
>
> Agreed!
> --
> Michal Hocko
> SUSE Labs
