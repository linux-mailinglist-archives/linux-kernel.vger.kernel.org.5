Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08337E5249
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjKHJBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:01:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B021718
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:01:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so11322422a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 01:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699434067; x=1700038867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul5okWy9o9xZFKWypAudbUF2nSuflBiQ/Bzce/xS+LI=;
        b=0xUV6ro5YwSBYCGRu/1z8rJ++q6VPSEInfvHorPBOwuFj6bI3CDD3HPCIu8rwVG3L7
         0+Q2G1UQfAxHXQ0FPYhHIX/mWK7FDg2MPdYETWsurYfr5irU2JlT+zNbMnp2zgCzsyMk
         MOrQXmWiHqP09Z/0GvOUdOaRjK53lKhulFQx/nRpM8khE0I9NoMXejXMMTkNHMX/deqZ
         L/n32OqnaYeDTSt64l3e6VEkzd3fR21uI/T/CrNZfIzeJ7aw4eaZyrFr8iWuTmShNFar
         yXMSvKtAWtVUNtG5yaRk/Z7GvRzWZtl1CWngUIiSroVJFb2MMZ6YNMJ3o8+ynNKZpKyD
         TROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699434067; x=1700038867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ul5okWy9o9xZFKWypAudbUF2nSuflBiQ/Bzce/xS+LI=;
        b=JtkVr6HpBCrGqVy4hNKFPe/vfsg/LvVnABGt9l2zoElTqhKLNT+ZJwEjQ+dztyoe6N
         EnDDy3YHyUez7A7mWocP0Ti/J0AgKLlThnnIb1St9gPR36SddQbrvwYVx1Jr9J6bHHcE
         mB5YXY01CH+szfuGnfDSP8YOslupUFWrX4ImIL27b7vh8SSyOgzBSyL06/4GdBRGI8ga
         mvjiZlpR0rBxBRtPQTXe6r4jGVryFoShzo69nr1T0j62is1G6Zmh/rDwbH3TxzLRDVcI
         2y1hTGsjdmSI8maACzWZH6iYPTrj/ySqFVnaog85ijfeAnGFRED1UAhyImS7Iq0nC3rs
         dxqg==
X-Gm-Message-State: AOJu0YwlpGfKQQe5AGJF4AyDMuxD9nFiKlzaVy8Plz6NLy2tElheIwCV
        vKBnqzohegSJY45iVlU88ZnXyuJiusCDhMpS6Dm9Kw==
X-Google-Smtp-Source: AGHT+IEZQFC5MQYN795SKbWm92b2+UaHLZXSe/S2e2/CpQ62gaOvDm5Nw9fOUkGFPY5jbdEA0C8GDl6/30L2c0Sxb/c=
X-Received: by 2002:a17:907:2da5:b0:9c1:9b3a:4cd1 with SMTP id
 gt37-20020a1709072da500b009c19b3a4cd1mr866287ejc.3.1699434067155; Wed, 08 Nov
 2023 01:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20231108065818.19932-1-link@vivo.com> <87v8ack889.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d3d2f43f-0733-4205-a649-0a42ea88f377@vivo.com> <87r0l0k6o6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAJD7tkY2iOeaYfzjRp__kVDyYYK5_KycS6PnMTtudUHghTnZLw@mail.gmail.com> <4db7e55f-c6cb-4be2-89e1-339f6e32b85b@vivo.com>
In-Reply-To: <4db7e55f-c6cb-4be2-89e1-339f6e32b85b@vivo.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Nov 2023 01:00:31 -0800
Message-ID: <CAJD7tkbnGykSriLVKeZOoWxHzM6o6AfCASONFCdaeNg2oaa1LA@mail.gmail.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To:     Huan Yang <link@vivo.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 12:22=E2=80=AFAM Huan Yang <link@vivo.com> wrote:
>
>
> =E5=9C=A8 2023/11/8 16:14, Yosry Ahmed =E5=86=99=E9=81=93:
> > On Wed, Nov 8, 2023 at 12:11=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >> Huan Yang <link@vivo.com> writes:
> >>
> >>> HI Huang, Ying
> >>>
> >>> Thanks for reply.
> >>>
> >>> =E5=9C=A8 2023/11/8 15:35, Huang, Ying =E5=86=99=E9=81=93:
> >>>> Huan Yang <link@vivo.com> writes:
> >>>>
> >>>>> In some cases, we need to selectively reclaim file pages or anonymo=
us
> >>>>> pages in an unbalanced manner.
> >>>>>
> >>>>> For example, when an application is pushed to the background and fr=
ozen,
> >>>>> it may not be opened for a long time, and we can safely reclaim the
> >>>>> application's anonymous pages, but we do not want to touch the file=
 pages.
> >>>>>
> >>>>> This patchset extends the proactive reclaim interface to achieve
> >>>>> unbalanced reclamation. Users can control the reclamation tendency =
by
> >>>>> inputting swappiness under the original interface. Specifically, us=
ers
> >>>>> can input special values to extremely reclaim specific pages.
> >>>>   From mem_cgroup_swappiness(), cgroupv2 doesn't have per-cgroup
> >>>> swappiness.  So you need to add that firstly?
> >>> Sorry for this mistake, we always work on cgroupv1, so, not notice
> >>> this commit 4550c4e, thank your for point that.
> >>>
> >>> I see this commit comment that `that's a different discussion`, but,
> >>> to implements this, I will try add.
> >>>
> >>>>> Example:
> >>>>>      echo "1G" 200 > memory.reclaim (only reclaim anon)
> >>>>>        echo "1G" 0  > memory.reclaim (only reclaim file)
> >>>>>        echo "1G" 1  > memory.reclaim (only reclaim file)
> >>>>>
> >>>>> Note that when performing unbalanced reclamation, the cgroup swappi=
ness
> >>>>> will be temporarily adjusted dynamically to the input value. Theref=
ore,
> >>>>> if the cgroup swappiness is further modified during runtime, there =
may
> >>>>> be some errors.
> >>>> If cgroup swappiness will be adjusted temporarily, why not just chan=
ge
> >>>> it via a script before/after proactive reclaiming?
> >>> IMO, this unbalance reclaim only takes effect for a single command,
> >>> so if it is pre-set using a script, the judgment of the reclamation t=
endency
> >>> may become complicated.
> >> If swappiness =3D=3D 0, then we will only reclaim file pages.  If swap=
piness
> >> =3D=3D 200, then we may still reclaim file pages.  So you need a way t=
o
> >> reclaim only anon pages?
> >>
> >> If so, can we use some special swappiness value to specify that?  I
> >> don't know whether use 200 will cause regression.  If so, we may need
> >> some other value, e.g. >=3D 65536.
> > I don't think swappiness is the answer here. This has been discussed a
> > while back, please see my response. As you mentioned, swappiness may
> > be ignored by the kernel in some cases, and its behavior has
> > historically changed before.
>
> For type base, reclaim can have direct tendencies as well. It's good.
> But, what if
> we only want to make small adjustments to the reclamation ratio?
> Of course, sometimes swappiness may become ineffective.
>

Is there a real use case for this? I think it's difficult to reason
about swappiness and make small adjustments to the file/anon ratio
based on it. I'd prefer a more concrete implementation.
