Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434407C86FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjJMNib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjJMNi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:38:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3139E8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:38:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50481a0eee7so3894165e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697204299; x=1697809099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr3E/uN8pNJ2Tl7rBw3tcz06mz6kFhL5wHJ5Z55gU3s=;
        b=bScaall34MI94wvRRQbNx0uhHbJk7tISlh9q/6imAIMgKu4VD6OV0L9x4JKMcGBw2w
         DI7itBQaW00VzsnJ/AbjrlopbWfiIvGnCOB1OLjWsS8epA2ncg6mZDyb6bjPPNeVsi5h
         2o1gjQkltRjd8HWnkDyur/0RLGwQQpD44MapxqhRJKOOvAcENCQo5TAV+JlWmwT8XDF/
         Soaacu+38YoWV63Oh41n/MZERdhlXzr6Vsq4KJSb2F+NnXVkQ+JVD1zesZ67ERRZ2x4R
         v84X8AultV0xqITxN3fIS2ymBt0tJOlVJ1Mv9i9YXAFGSd41zviyTmlueVLzuDfeKdL9
         GhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697204299; x=1697809099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr3E/uN8pNJ2Tl7rBw3tcz06mz6kFhL5wHJ5Z55gU3s=;
        b=hnwVZerdHSVnwvJb50gyjukeTCjIDkO88q0952Gd+1OOsJJiF6xa7zQyh/KGVyc2aS
         16sbfCCRkX1sAV+WJeEpbodHTzG3FFGG0ZZr3q7V4W0IZwjCHdFgPdbwTCP4MAGeWYM0
         EqAKZUMY0JSO+aq9SUTLtik+HPg7WKkb69Kxp/NEduEiOJwTYayTMFwWBXeVOs8JHo/z
         3wVSHHe4uHq43welBeOW2oxdRVydg5SGo4BCwAXBaQmoNpykAh58I1YSTodWwg5v67zO
         Lsg+lg+b7IVIKL79XeJ8Xp/p490AMf3XCLimXz1QXED9G0oHGtdodTnCxJQ03KOw+8CO
         PiYA==
X-Gm-Message-State: AOJu0Yzz8Wu9ofQcXjeq/mqlVvBCmJGsvr83w5iOyBqEEzp9jczVu39g
        OPOq0Fw2GE9Qh4lhyKyW6LBpguTInfxTvWO/gsORVg==
X-Google-Smtp-Source: AGHT+IHa8fvsa6suyV63dmf8+FA9YHAAh+rAXfMlRc/PLDXmWAIZONkhLVjCj1dNi3erb0QveuA4UTO1oX8xqMYaYB0=
X-Received: by 2002:a05:6512:3da3:b0:501:bf37:1fb3 with SMTP id
 k35-20020a0565123da300b00501bf371fb3mr123610lfv.24.1697204299525; Fri, 13 Oct
 2023 06:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OBYiH+G17YLRvEhx2Ode6q_hc0NgR6ZisBD_h0URcgSw@mail.gmail.com>
 <CACSyD1N6PPJCJ6TCTGijRKGEf2bGm+3mBLfr=DwCKgy+7-PBEw@mail.gmail.com> <CAKEwX=OmYB39QD2QLJG+OYRGQSOoTAfP+z65n3=q-x3yw8vEWw@mail.gmail.com>
In-Reply-To: <CAKEwX=OmYB39QD2QLJG+OYRGQSOoTAfP+z65n3=q-x3yw8vEWw@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Fri, 13 Oct 2023 21:38:07 +0800
Message-ID: <CACSyD1PXoSfmwSyuY7nu_EtnWmx30G7gZSUzi4w11y4Or0keVQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] zswap: add writeback_time_threshold
 interface to shrink zswap pool
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> As Johannes pointed out, with a zswap shrinker, we can just push on
> the memory.reclaim knob, and it'll automatically get pushed down the
> pipeline:
>
> memory -> swap -> zswap
>
> That seems to be a bit more natural and user-friendly to me than
> making the users manually decide to push zswap out to swap.
>
> My ideal vision of how all of this should go is that users provide an
> abstract declaration of requirement, and the specific decision of what
> to be done is left to the kernel to perform, as transparently to the user
> as possible. This philosophy extends to multi-tier memory management
> in general, not just the above 3-tier model.
>

That sounds great=EF=BC=8Ci will backport it and  have a try.

>
> I guess my main concern here is - how do you determine the value
> 600 seconds in the first place?
>

I will test based on different applications and corresponding memory
access models. Usually we run similar programs on the same machine.
First, we can use memory.reclaim to swap out pages to zswap, and with
this patch , I would find the distribution of times the page resides in
zswap, and then choose the appropriate time.

> And yes, the frequency should be greater than the oldness cutoff,
> but how much greater?
>
This depends on the user's memory needs. If you want to reclaim
memory faster, you can set it to 1.5 times the threshold. On the contrary,
you can set it to 1 hour, two hours, etc.

> We can run experiments to decide what cutoff will hurt performance
> the least (or improve the performance the most), but that value will
> be specific to our workload and memory access patterns. Other
> users might need a different value entirely, and they might not have
> the resources to find out.
>
> If it's just a binary decision (on or off), then at least it could be
> one A/B experiment (per workload/service). But the range here
> could vary wildly.
>
> Is there at least a default value that works decently well across
> workload/service, in your experience?
>

Yes I agree, it's difficult to set a perfect value, but it's actually benef=
icial
to just have a normal value, such as 600 seconds by default. This
means that the zswap value stores values that have not been accessed
within 600 seconds and then unloads them to swap.

> I believe Johannes has explained the case where this could happen.
> But yeah, this should be fixable with by updating the stored time
> field on access (maybe rename it to something a bit more fitting as
> well - last_accessed_time?)

Thanks, I agree.

>
> Regardless, it is incredibly validating to see that other parties share t=
he
> same problems as us :) It's not a super invasive change as well.
> I just don't think it solves the issue that well for every zswap user.

I've noticed this problem before and thought about some solutions,but only
saw your patch recently. I can also try it and discuss it together.At the
same time, I will think about how to improve this patch.
