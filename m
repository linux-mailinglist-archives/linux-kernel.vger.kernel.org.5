Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AC480112E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378693AbjLARJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjLARJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:09:52 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3F197
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:09:57 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a959e3afaso4797626d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701450597; x=1702055397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHSBlrWKXm1wAl594fX7qblvpqL30ZdbgTyCgGt+Df8=;
        b=nCVmDprTxS0ZF+WtC5Pq/FiUtgi4HPiOKYuOq2vWTzMYbvdNkl4JEHP7OtLBdPXo7T
         iilMMPXDJLV8dsPsIDuI42FKpzZ56yq1Kagf9BurUQhXV1WnXkCXp2rDqGPAZMihvSNF
         DuEAYAcKdtP0+nqyVOlQ+zYeiFmudCDUkZQd6Ohm0t0NG3OnXX+DOvKhe/Htq61GHj14
         OiJK38WTkXvCcJMhBVYRte4rN1kcvcRGnzRaEqgIwck4Vjg+OIzV2OU5pNOG2WO3vO9y
         rhl76JxPT9wpyUzVzZDN3SYnqLg3qM15F4YMGlGzatq7EwNCwfAd66z+i3pJkBdFK8sO
         eKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450597; x=1702055397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHSBlrWKXm1wAl594fX7qblvpqL30ZdbgTyCgGt+Df8=;
        b=UEzVFSKgrdC5zYmCZI3A6JTUolHmKvkf1nStSzdy2m7Cfg6Vio0Txbj8R6SQVfzrHh
         BlgYURR1jjeysGSGUvBf+go47tzOpNzUTHujgLdfySrkJl2yq7kt40S8I+6TSc1o0aZc
         A92j3gbLtqRILjGPileS+hZ3mPE2Ap312n9v4s2CH/nH3clZDqSb7Da93dXiyEuv4iEn
         WIxv6QuIih1F1PDV+TJSGratuUrbgBrsih9AYk4q3iukFGHM1yDPt6qwQkpOvnsZGEV/
         MbbmpnigcHjP3ec/Bm91/JN7lF/3EGqocgxrNjPtmIkzD92nFsaBmaRKcz8EiTV9rK4E
         L+jQ==
X-Gm-Message-State: AOJu0YzR6cPnNxH+CFYHuiZLk/aDLBY8DiqLo5i/s0B3dlThKp2MZzdb
        cCw36GbhInW/U7IiTLsgbqCL+A==
X-Google-Smtp-Source: AGHT+IHqQfbSInVj9aP1pUXmAYQeii4YG2nj7kgSlMdhi5m0/8lKOirnLYXwBxYrgyzVTwed0GPvbA==
X-Received: by 2002:a0c:e90e:0:b0:67a:fd5:24a9 with SMTP id a14-20020a0ce90e000000b0067a0fd524a9mr30266352qvo.19.1701450596905;
        Fri, 01 Dec 2023 09:09:56 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id du5-20020a05621409a500b0067aa28ac616sm255221qvb.113.2023.12.01.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:09:56 -0800 (PST)
Date:   Fri, 1 Dec 2023 12:09:55 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <20231201170955.GA694615@cmpxchg.org>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
 <20231130165642.GA386439@cmpxchg.org>
 <ZWmoTa7MlD7h9FYm@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWmoTa7MlD7h9FYm@tiehlicka>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 10:33:01AM +0100, Michal Hocko wrote:
> On Thu 30-11-23 11:56:42, Johannes Weiner wrote:
> [...]
> > So I wouldn't say it's merely a reclaim hint. It controls a very
> > concrete and influential factor in VM decision making. And since the
> > global swappiness is long-established ABI, I don't expect its meaning
> > to change significantly any time soon.
> 
> As I've said I am more worried about potential future changes which
> would modify existing, reduce or add more corner cases which would be
> seen as a change of behavior from the user space POV. That means that we
> would have to be really explicit about the fact that the reclaim is free
> to override the swappiness provided by user. So essentially a best
> effort interface without any actual guarantees. That surely makes it
> harder to use. Is it still useable?

But it's not free to override the setting as it pleases. I wrote a
detailed list of the current exceptions, and why the user wouldn't
have strong expectations of swappiness being respected in those
cases. Having reasonable limitations is not the same as everything
being up for grabs.

Again, the swappiness setting is ABI, and people would definitely
complain if we ignored their request in an unexpected situation and
regressed their workloads.

I'm not against documenting the exceptions and limitations. Not just
for proactive reclaim, but for swappiness in general. But I don't
think it's fair to say that there are NO rules and NO userspace
contract around this parameter (and I'm the one who wrote most of the
balancing code that implements the swappiness control).

So considering what swappiness DOES provide, and the definition and
behavior to which we're tied by ABI rules, yes I do think it's useful
to control this from the proactive reclaim context. In fact, we know
it's useful, because we've been doing it for a while in production now
- just in a hacky way, and this patch is merely making it less hacky.

> Btw. IIRC these concerns were part of the reason why memcg v2 doesn't
> have swappiness interface. If we decide to export swappiness via
> memory.reclaim interface does it mean we will do so on per-memcg level
> as well?

Well I'm the person who wrote the initial cgroup2 memory interface,
and I left it out because there was no clear usecase for why you'd
want to tweak it on a per-container basis.

But Dan did bring up a new and very concrete usecase: controlling for
write endurance. And it's not just a theoretical one, but a proven
real world application.

As far as adding a static memory.swappiness goes, I wouldn't add it
just because, but wait for a concrete usecase for that specifically. I
don't think Dan's rationale extends to it. But if a usecase comes up
and is convincing, I wouldn't be opposed to it.
