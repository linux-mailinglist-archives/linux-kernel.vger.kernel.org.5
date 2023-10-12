Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6561A7C75AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379651AbjJLSIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjJLSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:08:43 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB7B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:08:41 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3512efed950so4669165ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697134121; x=1697738921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbiB7IDPfah5L2y1Sjju6t9s6q0wXECDy1+qTIk2YZM=;
        b=QvXr/skGYyX1TnD6HGdSY/9I6P7vrn1M4X3bJzPTCpyfvdsNxVWul4jSfCQTFc/5cO
         6tDCsVv2+IiMQWNCo1OWjXVFcHSu05VQKhV4lGHB80hN98JsOzwu1aHRP2APKwa2C+p6
         4iJWRDGtucUrd44JUDrMBF6iHAdeGiHxyOIpbcNjJNwYid7yR4ZBldBS26WLt1M36FfH
         QZcBHRyhGEt+HsQnKefxwjsZkRhk4YnE6WY/JrJNaBkLl12OBHWbUjivxby1h1lQY1a1
         XqsWmifMbRsripQzR4LvT6tXLsE42jsfRvtwGzRHyZpzC0fHC3ih1FroPhMOwnFgO2Fv
         pT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697134121; x=1697738921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbiB7IDPfah5L2y1Sjju6t9s6q0wXECDy1+qTIk2YZM=;
        b=DmyNtDdiyI01oq2c5FzBX03MpWOvUyE+L/KyGZcumFeaEpwi4ULmD0s7zdwFKHRk5P
         Y2XCKh62w3btITbrXVLGa7c7HmddPONclBqQxfWoFgiuv5kqw22XyKJ//QosO7peOj6Y
         y/96wCp9/DrOp6FvZZ5YwsZRVKATV5VXqYbXOmwDgDAU5Jm2/d8xHVfgnvvvFebwYOal
         yvA0mfOe0g4ANb2lkDSf+JEIJ3jgyQPBaRLmpNAib+NPoyg85wu1LOPlqNnnEdqM3V9K
         pAdEG42c0pUCcLGTvo8SY7MPnfudLeJATTplb3C0ayTJd84sXtZi2Q1RUfm2MrwhFdwA
         /dig==
X-Gm-Message-State: AOJu0YyvHlP9p6C7qm6c1WjqzaAKfSBAVYAP61WVjMGrkwc+GJGUDOOV
        97P6Rr0YDrtzvoof9wuyC+jkTeSE8VjTn4vi+0w=
X-Google-Smtp-Source: AGHT+IFSLEV7OEcYRQFGknsfYPQqbcrCozhl99CRBE2eSR2+COWbmttOhirKwuni2UaGZIAyIjUQVjLRc3JIVHp8I20=
X-Received: by 2002:a92:cb50:0:b0:357:5dff:f5e4 with SMTP id
 f16-20020a92cb50000000b003575dfff5e4mr1181679ilq.23.1697134120883; Thu, 12
 Oct 2023 11:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OBYiH+G17YLRvEhx2Ode6q_hc0NgR6ZisBD_h0URcgSw@mail.gmail.com> <CACSyD1N6PPJCJ6TCTGijRKGEf2bGm+3mBLfr=DwCKgy+7-PBEw@mail.gmail.com>
In-Reply-To: <CACSyD1N6PPJCJ6TCTGijRKGEf2bGm+3mBLfr=DwCKgy+7-PBEw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 12 Oct 2023 11:08:29 -0700
Message-ID: <CAKEwX=OmYB39QD2QLJG+OYRGQSOoTAfP+z65n3=q-x3yw8vEWw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] zswap: add writeback_time_threshold
 interface to shrink zswap pool
To:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 7:13=E2=80=AFAM =E8=B4=BA=E4=B8=AD=E5=9D=A4 <hezhon=
gkun.hzk@bytedance.com> wrote:
>
> Hi Nhat, thanks for your detailed reply.
>
> > We're currently trying to solve this exact problem. Our approach is to
> > add a shrinker that automatically shrinks the size of the zswap pool:
> >
> > https://lore.kernel.org/lkml/20230919171447.2712746-1-nphamcs@gmail.com=
/
> >
> > It is triggered on memory-pressure, and can perform reclaim in a
> > workload-specific manner.
> >
> > I'm currently working on v3 of this patch series, but in the meantime,
> > could you take a look and see if it will address your issues as well?
> >
> > Comments and suggestions are always welcome, of course :)
> >
>
> Thanks, I've seen both patches. But we hope to be able to reclaim memory
> in advance, regardless of memory pressure, like memory.reclaim in memcg,
> so we can offload memory in different tiers.

As Johannes pointed out, with a zswap shrinker, we can just push on
the memory.reclaim knob, and it'll automatically get pushed down the
pipeline:

memory -> swap -> zswap

That seems to be a bit more natural and user-friendly to me than
making the users manually decide to push zswap out to swap.

My ideal vision of how all of this should go is that users provide an
abstract declaration of requirement, and the specific decision of what
to be done is left to the kernel to perform, as transparently to the user
as possible. This philosophy extends to multi-tier memory management
in general, not just the above 3-tier model.

>
> >
> > My concern with this approach is that this value seems rather arbitrary=
.
> > I imagine that it is workload- and memory access pattern- dependent,
> > and will have to be tuned. Other than a couple of big users, no one
> > will have the resources to do this.
> >
> > And since this is a one-off knob, there's another parameter users
> > will have to decide - frequency, i.e how often should the userspace
> > agent trigger this reclaim action. This is again very hard to determine
> > a priori, and most likely has to be tuned as well.
> >
>
> I totally agree with you, this is the key point of this approach.It depen=
ds
> on how we define cold pages, which are usually measured in time,
> such as not being accessed for 600 seconds, etc. So the frequency
> should be greater than 600 seconds.

I guess my main concern here is - how do you determine the value
600 seconds in the first place?

And yes, the frequency should be greater than the oldness cutoff,
but how much greater?

We can run experiments to decide what cutoff will hurt performance
the least (or improve the performance the most), but that value will
be specific to our workload and memory access patterns. Other
users might need a different value entirely, and they might not have
the resources to find out.

If it's just a binary decision (on or off), then at least it could be
one A/B experiment (per workload/service). But the range here
could vary wildly.

Is there at least a default value that works decently well across
workload/service, in your experience?

>
> > I think there might be some issues with just storing the store time her=
e
> > as well. IIUC, there might be cases where the zswap entry
> > is accessed and brought into memory, but that entry (with the associate=
d
> > compressed memory) still hangs around. For e.g and more context,
> > see this patch that enables exclusive loads:
> >
> > https://lore.kernel.org/lkml/20230607195143.1473802-1-yosryahmed@google=
.com/
> >
> > If that happens, this sto_time field does not tell the full story, righ=
t?
> > For instance, if an object is stored a long time ago, but has been
> > accessed since, it shouldn't be considered a cold object that should be
> > a candidate for reclaim. But the old sto_time would indicate otherwise.
> >
>
> Thanks for your review=EF=BC=8Cwe should update the store time when it wa=
s loaded.
> But it confused me, there are two copies of the same page in memory
> (compressed and uncompressed) after faulting in a page from zswap if
> 'zswap_exclusive_loads_enabled' was disabled. I didn't notice any differe=
nce
> when turning that option on or off because the frontswap_ops has been rem=
oved
> and there is no frontswap_map anymore. Sorry, am I missing something?

I believe Johannes has explained the case where this could happen.
But yeah, this should be fixable with by updating the stored time
field on access (maybe rename it to something a bit more fitting as
well - last_accessed_time?)

Regardless, it is incredibly validating to see that other parties share the
same problems as us :) It's not a super invasive change as well.
I just don't think it solves the issue that well for every zswap user.
