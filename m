Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4750A7D60E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 06:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjJYEef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 00:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYEec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 00:34:32 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF54123
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 21:34:31 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-49ab6c1869dso319881e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 21:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698208470; x=1698813270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVkIC9fUmLZDVWvlN2mUA1mgD/rtwCOE8cYC+FdYHCM=;
        b=WBjvNp+HnEACWYPtzRCqLdTSYUvxhIplEm6Tr5U4POMWqwTGDEAiSodQpNSEvZmWEP
         CMrAlkvBV+gcpkljko+WQcG69kj4zJjWYVnUa2Z1esEHLPPy8CJ4HNPpL7atqVQuJCyc
         I1tIeLuRZaTRpzPK++is+BHsWP/QWKrEPZoiYecW0fX5zG+U7Hr9ShqUCD1dr8xpsXfm
         OVHim9my1NzOadPnJtBV3qffeVMxSE4AQZCwRK6ggqTt9SRFnS0fnY8AXFPmLdwY9vdV
         iCmuJAaf/a+q6eqzSSYNoD6JCbKo/JgMU7uCRIq8/XEaqeV7q4q2CoxMIHTU0si4z2ll
         s2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698208470; x=1698813270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVkIC9fUmLZDVWvlN2mUA1mgD/rtwCOE8cYC+FdYHCM=;
        b=DfdVa6LmU7NePpa6AHppZrLTgEYj4cWaiLgRhSDZbLBzwaPAPJGJpAq+1Qg5OkJ6eS
         gwXyBhYjxnuIDgKT+8+JbtxEYGSDlV5sgKHS8yInmlY2YjcmIBfcB6nzZiyhYA0LqKMq
         vMdHOMrei8lTO1vz8KIGFgwiSS6AZZhrqEGu7LgqT7sA7ra+PNquMcEbQncD03t+iM4f
         Xx3S2xVvzzMw++E0o5lwnjmuLux4WSZxm/nKdIcOmvq/3N3aIdSHGd2ppYeSwK/QH+/u
         hhBoyU7B1JMlH40XZG3JsB57KIxVBqh6ojhQ0cVgptyPiyojfTcjNpQrmwle7GHZ06VM
         1EIA==
X-Gm-Message-State: AOJu0YzUCBpY6kAsfk0l0wGWlY74JDH6zI6kA36Biv4uWN0+NU2ffkfS
        gx4qBu1IPhFU0pkBYw+pf4vuU6qxN1T/eZNqkuA=
X-Google-Smtp-Source: AGHT+IGiUkhtzGa/ALcklBUpWuoI87pHjz1Amg9Y6T9HuMGZ6JAacd/9bYmnL0qPHH8WVBV5CGsFZYlM2/DL0pUM9yQ=
X-Received: by 2002:a1f:7309:0:b0:494:63f7:4e7f with SMTP id
 o9-20020a1f7309000000b0049463f74e7fmr6799213vkc.2.1698208470086; Tue, 24 Oct
 2023 21:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <44e32b0e-0e41-4055-bdb9-15bc7d47197c@intel.com> <f3047412-a53c-f8ba-f8aa-4f46e04c5a31@linux.alibaba.com>
 <a4ae7473-636b-4ff3-9f66-f47dbe934593@intel.com>
In-Reply-To: <a4ae7473-636b-4ff3-9f66-f47dbe934593@intel.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 25 Oct 2023 12:34:17 +0800
Message-ID: <CAGsJ_4x+UBtJNaGw8CswRrcDtNwXAGRUN8NogKMd5=MJRpyisw@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:09=E2=80=AFAM Yin, Fengwei <fengwei.yin@intel.co=
m> wrote:
>
>
>
> On 10/25/2023 11:03 AM, Baolin Wang wrote:
> >>
> >> My understanding is that arm64 doesn't do invalidate the TLB during > =
context switch. The flush_tlb_page_nosync() here + DSB during context
> >
> > Yes, we only perform a TLB flush when the ASID is exhausted during cont=
ext switch, and I think this is same with x86 IIUC.
> If we remove flush_tlb_page_nosync(), can we still claim TLB is flushed d=
uring
> context switch for ARM64?

No. in this case, we will have to depend on hardware replacement of
TLB on other CPUs. Considering LRU's list is
really long and TLB is really small,  a hot page needs a long time to
move-back to inactive tail, other CPUs' TLB is
likely to be replaced somewhere. But we do have a very small chance
other CPUs will lose setting access flags
in some corner cases. now i have more understanding why this nosync
tlb flush is still there though in practical,
removing it seems not to hurt.

>
> >
> >> switch make sure the TLB is invalidated during context switch.
> >> So we can't remove flush_tlb_page_nosync() here? Or something was chan=
ged
> >> for arm64 (I have zero knowledge to TLB on arm64. So some obvious thin=
g
> >> may be missed)? Thanks.
> >
> > IMHO, the tlb can be easily evicted or flushed if the system is under m=
emory pressure, so like Barry said, the chance of reclaiming hot page is re=
latively low, at least on X86, we did not see any heavy refault issue.
> >
> > For MGLRU, it uses ptep_test_and_clear_young() instead of ptep_clear_fl=
ush_young_notify(), and we did not find any problems until now since deploy=
ing to ARM servers.

Thanks
Barry
