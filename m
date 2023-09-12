Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84179B5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbjIKUv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244308AbjIKUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:01:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C2CC4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:01:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31f6ddb3047so4710927f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694462497; x=1695067297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc/ITscuXzrOZNzjOX81ClkWsxPRiA/63di+UZB/Fss=;
        b=loVr5hheOIVu6QcpbW91kAq1raiTl38ExhJf72I1lu/K0nWWQ469avMmQXzMhv6z5A
         mB4jLNCPgCkONX9xh9AQooa160FrsBB22SHjqDlVOx3DqEaYw/qVA1bNDTgLvtajW8dR
         MYhpJ+/ltVZd5yes+IDWvg+AWy0pq7lrAKoMWgifahmI4Ocep8YkkamDSR//fi3FhFYa
         k6rV6eQwg8/jJzqGhsWUebGgxg4+mYCDHKGws/FSVH3jFb+3bs+yxYdFdWp/2AJ5lJjr
         qBVmQjJh1p2qWInGgN5+OQ3oT56vZjcczn8X9xKQfLhr5UywVbcT55CKtDccOvRbFFKi
         hM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462497; x=1695067297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rc/ITscuXzrOZNzjOX81ClkWsxPRiA/63di+UZB/Fss=;
        b=s75mv2KF3P90gzT9dfhmlhkgHJxIjkm7yp7rdnqS0P08QhCrIB5wo0JC55nli4QyjX
         VV4Yn9CPGZlwbpVdmJClTiP5OwWfa8tCR6c6dv63ez6w7uqrUcCiOXyC01GeI5hOqxYb
         NGsvjkvLnRp6BGyc2wYNqn3NaiGqHNxmooQioR85WyHXTCGqT3077FaD+Ftoi7Q4ztTH
         xYbu+irdHS+KZLWX73/sM6F4f+c4naXwaUfjRrDjgCJJyarBvR4duVnCuDf77srh9sMW
         /0bRX38L18qHNb9kqNVxCnr7DJ44/dJobG4cDgCG3IIhqepFqHBzrQ0Jysv/iKA/ZihQ
         Hp5A==
X-Gm-Message-State: AOJu0Yxxyc42wXT4WfOAHKw7yt7EbZbGkp2pVOwcTZnWJVI22708pfcs
        jVn/f1hIQAjEig9Jb/mKvYi/Wp4GCZItPclAG4p/ww==
X-Google-Smtp-Source: AGHT+IFl+KdEdEZPM6dgoOAIbUh01xAe49DOxDPyclO9MjoDMPy6oI+PGBUbBzXjIZIb0Pzdpfqm23roWvQdVndSEEw=
X-Received: by 2002:a5d:4f8c:0:b0:314:3e77:f210 with SMTP id
 d12-20020a5d4f8c000000b003143e77f210mr8531185wru.59.1694462497487; Mon, 11
 Sep 2023 13:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com> <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
 <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com>
 <ZP8SDdjut9VEVpps@dhcp22.suse.cz> <CAAPL-u8NndkB2zHRtF8pVBSTsz854YmUbx62G7bpw6BMJiLaiQ@mail.gmail.com>
 <ZP9rtiRwRv2bQvde@dhcp22.suse.cz>
In-Reply-To: <ZP9rtiRwRv2bQvde@dhcp22.suse.cz>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 11 Sep 2023 13:01:25 -0700
Message-ID: <CAAPL-u9XwMcrqVRu871tGNKa3LKmJSy9pZQ7A98uDbG6ACzMxQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:34=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Mon 11-09-23 12:15:24, Wei Xu wrote:
> > On Mon, Sep 11, 2023 at 6:11=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Thu 07-09-23 17:52:12, Wei Xu wrote:
> > > [...]
> > > > I tested this patch on a machine with 384 CPUs using a microbenchma=
rk
> > > > that spawns 10K threads, each reading its memory.stat every 100
> > > > milliseconds.
> > >
> > > This is rather extreme case but I wouldn't call it utterly insane
> > > though.
> > >
> > > > Most of memory.stat reads take 5ms-10ms in kernel, with
> > > > ~5% reads even exceeding 1 second.
> > >
> > > Just curious, what would numbers look like if the mutex is removed an=
d
> > > those threads would be condending on the existing spinlock with lock
> > > dropping in place and removed. Would you be willing to give it a shot=
?
> >
> > Without the mutex and with the spinlock only, the common read latency
> > of memory.stat is still 5ms-10ms in kernel. There are very few reads
> > (<0.003%) going above 10ms and none more than 1 second.
>
> Is this with the existing spinlock dropping and same 10k potentially
> contending readers?

Yes, it is the same test (10K contending readers). The kernel change
is to remove stats_user_flush_mutex from mem_cgroup_user_flush_stats()
so that the concurrent mem_cgroup_user_flush_stats() requests directly
contend on cgroup_rstat_lock in cgroup_rstat_flush().

> --
> Michal Hocko
> SUSE Labs
