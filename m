Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11727E5240
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjKHI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKHI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:59:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09F5171C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:59:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9dbb3d12aefso983405766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699433982; x=1700038782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tor/EJdIpY1mQ+T8Qhv4C03xA4q/rVwv1DfBop2f0Do=;
        b=aNbrAE1yKFuBCJcFtCPknM0so7xM+RsD4m7nVZNzkZdpNJ+0oXH5OWhjcthKbfmfB9
         L0Bzxe+oNszY9pkU2lUgvfUpEDO0vwkRgXV1Xo4eU24afFdalnzg61OSKdqybd7x7q5e
         A9WG2rW7wh1IjZaNUtyHNIHgNvPP2tOD9DVL1TWKhyzNStPNy1zbb4u0dBd9xRX7vAyV
         vwRTW6S+ro8x+Mq1EAEG3B+vjlWNVkOEhKn8Z0y15LBilQQeDBMUxQ0zO+UdBiqkbxmH
         xQxqKW0BScknWn+grt9msHa9qOLKizqJGFtucxNaCwljc31BDi58JtkaYagTM21FSKLK
         m4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699433982; x=1700038782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tor/EJdIpY1mQ+T8Qhv4C03xA4q/rVwv1DfBop2f0Do=;
        b=iHQmpQTeYmkiX53oGuGH2sldh/pcVPXnblTTFpdJE34h9CDNcl4MbOty07aLuBS11B
         lVUexTDlhhQk6Z7VOAjEGbSPf8Uuz+ybUvOvT92Z0FqzRQy5s/wY1L3iVtyYbmqZESQY
         Hd8ybSI44Euzo4/LWi5wBCf0uzdR4/7gRdk0asaogk4AyuI+1a/fEqplY1i5y7B/WQP/
         3rXjS3hMgk3LsMBbULmIKhMZya2qCtwJ/4hXJ81vrDwb59oLzLB04/VEI4XDKVT6Ph6Q
         62P2JJvlqo8l2fshZ+hZD4g93Qw1JztCy/D9Qsps5PS3cDR/4Z5tuNCdQIqM0gtODE+3
         wJjA==
X-Gm-Message-State: AOJu0Yy+MUlBsBx6JfhSkHcbH0NRs/y+HDiXEJQ1IWVhYbmvqqkrdBmK
        rsnPG23K5whTIeLYnktgmjzzjCKKbocRvPd3+sit0g==
X-Google-Smtp-Source: AGHT+IGn6eGFsclyYzD50WFiPGxzCz+3fCLF0s6JgmmAuiqTby0HByPXoOE0rEbXVr+CVfr+KMHxOfjP0b/dgUSvGvM=
X-Received: by 2002:a17:906:c103:b0:9c0:2897:1588 with SMTP id
 do3-20020a170906c10300b009c028971588mr790461ejc.17.1699433982110; Wed, 08 Nov
 2023 00:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20231108065818.19932-1-link@vivo.com> <CAJD7tkYVtaX=W5XWhn-Y+d==mbHs5AZG-7sAaYmo7FDONpoQ7g@mail.gmail.com>
 <4c7db101-a34f-47ff-ba64-952516cc193a@vivo.com>
In-Reply-To: <4c7db101-a34f-47ff-ba64-952516cc193a@vivo.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Nov 2023 00:59:02 -0800
Message-ID: <CAJD7tkZ2cnp6tSr6jb2Xpt4J-5oeTmAq1KNw6f7KBWPfjca8gA@mail.gmail.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To:     Huan Yang <link@vivo.com>
Cc:     Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
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

On Wed, Nov 8, 2023 at 12:26=E2=80=AFAM Huan Yang <link@vivo.com> wrote:
>
>
> =E5=9C=A8 2023/11/8 16:00, Yosry Ahmed =E5=86=99=E9=81=93:
> > +Wei Xu +David Rientjes
> >
> > On Tue, Nov 7, 2023 at 10:59=E2=80=AFPM Huan Yang <link@vivo.com> wrote=
:
> >> In some cases, we need to selectively reclaim file pages or anonymous
> >> pages in an unbalanced manner.
> >>
> >> For example, when an application is pushed to the background and froze=
n,
> >> it may not be opened for a long time, and we can safely reclaim the
> >> application's anonymous pages, but we do not want to touch the file pa=
ges.
> >>
> >> This patchset extends the proactive reclaim interface to achieve
> >> unbalanced reclamation. Users can control the reclamation tendency by
> >> inputting swappiness under the original interface. Specifically, users
> >> can input special values to extremely reclaim specific pages.
> > I proposed this a while back:
> >
> > https://lore.kernel.org/linux-mm/CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk=
51yKSNgD7aGdg@mail.gmail.com/
> Well to know this, proactive reclaim single type is usefull in our
> production too.
> >
> > The takeaway from the discussion was that swappiness is not the right
> > way to do this. We can add separate arguments to specify types of
> > memory to reclaim, as Roman suggested in that thread. I had some
> > patches lying around to do that at some point, I can dig them up if
> > that's helpful, but they are probably based on a very old kernel now,
> > and before MGLRU landed. IIRC it wasn't very difficult, I think I
> > added anon/file/shrinkers bits to struct scan_control and then plumbed
> > them through to memory.reclaim.
> >
> >> Example:
> >>          echo "1G" 200 > memory.reclaim (only reclaim anon)
> >>            echo "1G" 0  > memory.reclaim (only reclaim file)
> >>            echo "1G" 1  > memory.reclaim (only reclaim file)
> > The type of interface here is nested-keyed, so if we add arguments
> > they need to be in key=3Dvalue format. Example:
> >
> > echo 1G swappiness=3D200 > memory.reclaim
> Yes, this is better.
> >
> > As I mentioned above though, I don't think swappiness is the right way
> > of doing this. Also, without swappiness, I don't think there's a v1 vs
> > v2 dilemma here. memory.reclaim can work as-is in cgroup v1, it just
> > needs to be exposed there.
> Cgroupv1 can't use memory.reclaim, so, how to exposed it? Reclaim this by
> pass memcg's ID?

That was mainly about the idea that cgroup v2 does not have per-memcg
swappiness, so this proposal seems to be inclined towards v1, at least
conceptually. Either way, we need to add memory.reclaim to the v1
files to get it to work on v1. Whether this is acceptable or not is up
to the maintainers. I personally don't think it's a problem, it should
work as-is for v1.
