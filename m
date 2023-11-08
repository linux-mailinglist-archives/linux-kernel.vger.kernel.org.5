Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396E87E51BD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjKHIP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKHIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:15:24 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0909ED40
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:15:22 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9e28724ac88so229884066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699431320; x=1700036120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FKYvrBE119KQzoa2wyjzJbw+x+PQ+UBi4regXf/m/8=;
        b=mr20JlNsfPdyHm/N3NMaBuUpd9vnUJEltIvlNBpeQ/RDEjXziV+W+aXWM5m/t2nMFJ
         H5qDpykm4dUDTrT4AEVg7BuV6TuTBQI1EN03gL6+SG7WIw23yJLVaX4O13FdKqzpsxZ4
         Wxf5nKo7YIZbVZrZyhC7E52PrBmuJWvp0gLWaiEKTDs4L3LY0fh/0no2SkrYaiQZLk5y
         aoM/7oRLtDxTEoYJhdtty10HKx1lsZgYxHbOzalza/gv9xYrneBKZcvqToVMsBjI6F1a
         FrSlC/ZSUp1tGr4LPKaz1l4KrSFamLEuG/w+RcvGFmcYdDXrLf2FX+OqipuoUwVpAbar
         ueLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699431320; x=1700036120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FKYvrBE119KQzoa2wyjzJbw+x+PQ+UBi4regXf/m/8=;
        b=cZKWPy6obsd1hBTtZ7PceDxTlmtOoEtKbJfrLBBjRM6sJ1GV5Se3g9y9FeGXs2ordI
         19RR0PgRUd1TuRXeRCqhtew0c/RiGhYUxHeyCmiadOb88m4WWABAX7Jksmz/PHRkLN3t
         ym1zCqnWGT9F/TNny/E5xtza9xVSiH0ZWvFrWV1pezFdEHPqv9VCaJyBo2HmekZkmQ/v
         QqLhTp8LSa4aCPyGA+sPBO9dTZWsPAR107o5ipmDFKN1GLoP87Uot/PY3gheCStcqqAD
         GCl/v1aKpdpG/WKVXlazvdsK7S2GK2KIy5FsMIpkj7rZ6mso6URXnUgeUMthlecdlR8B
         2kDQ==
X-Gm-Message-State: AOJu0YwzgqgIy5TqqE9GWhF7mq0m9rtk8GcRN3jvFgsNwg4dP0Cp8WHm
        TNNWd8Sfx8Lgn02Bs22Y60zzTMZUDTSvl5W6qr3e1g==
X-Google-Smtp-Source: AGHT+IElW6cSCNI2mjlOLKAQpiHS/RxO47h/3ylrXY5GAAJz8eQxZfAIV+9yyvxvBU6Bp67ABA0MLFRnF34NBV0dtuw=
X-Received: by 2002:a17:907:5c7:b0:9dd:b8ba:1640 with SMTP id
 wg7-20020a17090705c700b009ddb8ba1640mr874063ejb.12.1699431320292; Wed, 08 Nov
 2023 00:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20231108065818.19932-1-link@vivo.com> <87v8ack889.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d3d2f43f-0733-4205-a649-0a42ea88f377@vivo.com> <87r0l0k6o6.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87r0l0k6o6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Nov 2023 00:14:44 -0800
Message-ID: <CAJD7tkY2iOeaYfzjRp__kVDyYYK5_KycS6PnMTtudUHghTnZLw@mail.gmail.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Huan Yang <link@vivo.com>, Tejun Heo <tj@kernel.org>,
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

On Wed, Nov 8, 2023 at 12:11=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Huan Yang <link@vivo.com> writes:
>
> > HI Huang, Ying
> >
> > Thanks for reply.
> >
> > =E5=9C=A8 2023/11/8 15:35, Huang, Ying =E5=86=99=E9=81=93:
> >> Huan Yang <link@vivo.com> writes:
> >>
> >>> In some cases, we need to selectively reclaim file pages or anonymous
> >>> pages in an unbalanced manner.
> >>>
> >>> For example, when an application is pushed to the background and froz=
en,
> >>> it may not be opened for a long time, and we can safely reclaim the
> >>> application's anonymous pages, but we do not want to touch the file p=
ages.
> >>>
> >>> This patchset extends the proactive reclaim interface to achieve
> >>> unbalanced reclamation. Users can control the reclamation tendency by
> >>> inputting swappiness under the original interface. Specifically, user=
s
> >>> can input special values to extremely reclaim specific pages.
> >>  From mem_cgroup_swappiness(), cgroupv2 doesn't have per-cgroup
> >> swappiness.  So you need to add that firstly?
> > Sorry for this mistake, we always work on cgroupv1, so, not notice
> > this commit 4550c4e, thank your for point that.
> >
> > I see this commit comment that `that's a different discussion`, but,
> > to implements this, I will try add.
> >
> >>
> >>> Example:
> >>>     echo "1G" 200 > memory.reclaim (only reclaim anon)
> >>>       echo "1G" 0  > memory.reclaim (only reclaim file)
> >>>       echo "1G" 1  > memory.reclaim (only reclaim file)
> >>>
> >>> Note that when performing unbalanced reclamation, the cgroup swappine=
ss
> >>> will be temporarily adjusted dynamically to the input value. Therefor=
e,
> >>> if the cgroup swappiness is further modified during runtime, there ma=
y
> >>> be some errors.
> >> If cgroup swappiness will be adjusted temporarily, why not just change
> >> it via a script before/after proactive reclaiming?
> > IMO, this unbalance reclaim only takes effect for a single command,
> > so if it is pre-set using a script, the judgment of the reclamation ten=
dency
> > may become complicated.
>
> If swappiness =3D=3D 0, then we will only reclaim file pages.  If swappin=
ess
> =3D=3D 200, then we may still reclaim file pages.  So you need a way to
> reclaim only anon pages?
>
> If so, can we use some special swappiness value to specify that?  I
> don't know whether use 200 will cause regression.  If so, we may need
> some other value, e.g. >=3D 65536.

I don't think swappiness is the answer here. This has been discussed a
while back, please see my response. As you mentioned, swappiness may
be ignored by the kernel in some cases, and its behavior has
historically changed before.
