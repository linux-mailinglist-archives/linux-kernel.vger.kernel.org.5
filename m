Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C517C7024
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbjJLONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjJLONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:13:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B0A91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:13:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50307acd445so1338212e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697120008; x=1697724808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK+AWSsQ2H33A1L6bytZOXVSGoyHWqpSkicQBPY+zcE=;
        b=ki48xhz4RL/TZdXfN5lkFhIqHvTmZ2+eSKn2TZyVlh7COIGWiR26+zOWzWfbUQKYsD
         7yvWxEqr/sQZ0SU91UTg4Ot5gP8XZJwUPCPAS01I1l36vsMgi3PWhbA4uqiE9JuTGd6W
         9jvFIzSumIfJJb+8+G3HjTSf5p+/SNzTflqm7mtZF+V25gyvHZ2b9AXyrAteicF7UAmj
         jw6Co2f6y6uljCgKDLxpH/X/P2C7IRUFlx+w9Skp70E6NZd7vPD+dBnji4wf4d19Jj0a
         weyqwz+y1PTF0BO5bZjTKhhdftM/bhMwW75AN9XU446S9UBEf954hnBONK57jAGuMRPr
         d4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697120008; x=1697724808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK+AWSsQ2H33A1L6bytZOXVSGoyHWqpSkicQBPY+zcE=;
        b=ohIAAUtRNrqLOPBUXHcJ/KuaHNFsqgDdyVOebJgOUkJqxmysr3DA7BrM33bQpyBxmY
         q+UFOj2iVx6q8LELhT5mvdmyWoB/Wv2jy6WJqlQa5Srq0RhDz9ryYG2odxgPglj4Atyd
         cnv0liFCm8vlI8PmiJoOV1DG+j8BgZrLiGXyoHaKaoWSz9Vxwj2tpx+5a5gUuZ2zMJdT
         KljM0F0uyJ4T6BgZFVZ7KVROapU9HTvcmUUp+fqX2qpKz6udTwPWDzc06B6gxIavnUnb
         hL2wvAJHzK0IndgoEpGyS1GWOQwSW+Tmz87t0iQ9hXFPWOTUt8FKq0/LTdiokxLQRZky
         2/nQ==
X-Gm-Message-State: AOJu0Yy4omE1NNylzi/rxBqpI3VCnPOIk4/UMuvX6e7oHeC+m7Rn8ke/
        JVXRJ3ZflOs5xTD97hAK+8drzzJRpRCq5JTkKZbv/p97u33pBmsI7Io=
X-Google-Smtp-Source: AGHT+IEW8LIlJF+IkYg1FO+B3C5kxp9FpL15COCm5jVowYGJmAblgTumAbou3m74W4CMu7tujdudQ+0HT4xU0N0/Y8Q=
X-Received: by 2002:a19:f015:0:b0:500:9dd4:2969 with SMTP id
 p21-20020a19f015000000b005009dd42969mr18161152lfc.59.1697120008183; Thu, 12
 Oct 2023 07:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com> <CAKEwX=OBYiH+G17YLRvEhx2Ode6q_hc0NgR6ZisBD_h0URcgSw@mail.gmail.com>
In-Reply-To: <CAKEwX=OBYiH+G17YLRvEhx2Ode6q_hc0NgR6ZisBD_h0URcgSw@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 12 Oct 2023 22:13:16 +0800
Message-ID: <CACSyD1N6PPJCJ6TCTGijRKGEf2bGm+3mBLfr=DwCKgy+7-PBEw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat, thanks for your detailed reply.

> We're currently trying to solve this exact problem. Our approach is to
> add a shrinker that automatically shrinks the size of the zswap pool:
>
> https://lore.kernel.org/lkml/20230919171447.2712746-1-nphamcs@gmail.com/
>
> It is triggered on memory-pressure, and can perform reclaim in a
> workload-specific manner.
>
> I'm currently working on v3 of this patch series, but in the meantime,
> could you take a look and see if it will address your issues as well?
>
> Comments and suggestions are always welcome, of course :)
>

Thanks, I've seen both patches. But we hope to be able to reclaim memory
in advance, regardless of memory pressure, like memory.reclaim in memcg,
so we can offload memory in different tiers.

>
> My concern with this approach is that this value seems rather arbitrary.
> I imagine that it is workload- and memory access pattern- dependent,
> and will have to be tuned. Other than a couple of big users, no one
> will have the resources to do this.
>
> And since this is a one-off knob, there's another parameter users
> will have to decide - frequency, i.e how often should the userspace
> agent trigger this reclaim action. This is again very hard to determine
> a priori, and most likely has to be tuned as well.
>

I totally agree with you, this is the key point of this approach.It depends
on how we define cold pages, which are usually measured in time,
such as not being accessed for 600 seconds, etc. So the frequency
should be greater than 600 seconds.

> I think there might be some issues with just storing the store time here
> as well. IIUC, there might be cases where the zswap entry
> is accessed and brought into memory, but that entry (with the associated
> compressed memory) still hangs around. For e.g and more context,
> see this patch that enables exclusive loads:
>
> https://lore.kernel.org/lkml/20230607195143.1473802-1-yosryahmed@google.c=
om/
>
> If that happens, this sto_time field does not tell the full story, right?
> For instance, if an object is stored a long time ago, but has been
> accessed since, it shouldn't be considered a cold object that should be
> a candidate for reclaim. But the old sto_time would indicate otherwise.
>

Thanks for your review=EF=BC=8Cwe should update the store time when it was =
loaded.
But it confused me, there are two copies of the same page in memory
(compressed and uncompressed) after faulting in a page from zswap if
'zswap_exclusive_loads_enabled' was disabled. I didn't notice any differenc=
e
when turning that option on or off because the frontswap_ops has been remov=
ed
and there is no frontswap_map anymore. Sorry, am I missing something?
