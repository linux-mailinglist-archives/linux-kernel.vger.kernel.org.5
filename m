Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92BC7C8645
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjJMM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjJMM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:59:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40633D7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:59:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso227161e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697201968; x=1697806768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg6s+PkmAT7pmMliH2xO/Md/Hft9jtXneskCjh9+2ds=;
        b=Koa3lLSNMjkB8ByG9692xuUgl47CTLLr9wU0Yyh2AqbUekf23ooerFDGHyOG/ZUjne
         YFd/54pPoSxXfx/7pnTTgeZtWUhwI5YbECmuYgJvi/98ZzrZqBpgKaJFh74tSfikoU+L
         Q0fhwGw8kuF+9NSoDUoA9za5BhQx7K0Z2uO8s6mSrEwxjkODeZ5ifbCJ9WFpok9UFp1+
         0PpWC3hGRYR9z1rR19IXVIZWQBy/YxGQRseaxWFjOZwHCPjnabxwg7bO/kmK6aL7lZXd
         UsNAEk7AcMTyySJYZJatdXX91gXe0sQEsenZWjFmalElSu/okD0RGV3OisX3kRKgAMdP
         dOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697201968; x=1697806768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg6s+PkmAT7pmMliH2xO/Md/Hft9jtXneskCjh9+2ds=;
        b=dS1O1oP8bCdVr8X3V/sOo51Gj/v/pKd4rEkqyYObpPwNL56o+piWLh145kaB0zC2xs
         51hNRI+Kc5EesgLtlsqQLY/bPqLSWsbtV1AP/aV58mvghWgobUtLrPj9OfastgcuoCyA
         h//wUQmndovb4yPCw3ZGkyZmokedOxvJ2D1ZoAudQhCzrJGX/GkXSNs/lO/QUa91KZ+f
         6w0KuKoQeWssiirEerelTNY9mR7bhmjGtaM2HAc+CiMIxbbD7HACIKOp4nI3V/dQT6lQ
         3yFDlo7Kz6qauR4xq41MAT9L9pNh/mkPawoMb5+dKNA7+TcwUYD4p7ieFCayG08bmI5i
         C3Ng==
X-Gm-Message-State: AOJu0Yw+75b6xIladU8U7cLKucbC9BqSUSgRKY1nNZ92x5ITJiz29+LL
        vc+OOTG+R7OJOfP9zkZQW6HFvGvFdbDR94R+aZv0pyfWxfzWXB2T
X-Google-Smtp-Source: AGHT+IF8wms366Ocsuw+3/X4x3cARD5bRqEjcX99vqDV4+xvzcKp0vvywQs7RHegbwHauJoJefab87c2mHdjolL3u08=
X-Received: by 2002:a05:6512:3ca4:b0:500:b9f3:1dc4 with SMTP id
 h36-20020a0565123ca400b00500b9f31dc4mr28837815lfv.68.1697201968478; Fri, 13
 Oct 2023 05:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OBYiH+G17YLRvEhx2Ode6q_hc0NgR6ZisBD_h0URcgSw@mail.gmail.com>
 <CACSyD1N6PPJCJ6TCTGijRKGEf2bGm+3mBLfr=DwCKgy+7-PBEw@mail.gmail.com> <20231012142203.GB470544@cmpxchg.org>
In-Reply-To: <20231012142203.GB470544@cmpxchg.org>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Fri, 13 Oct 2023 20:59:16 +0800
Message-ID: <CACSyD1NYD+JvLSLj-y2c0qdjn2SrTTB3uuezoEjNOPzWkAW0qA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] zswap: add writeback_time_threshold
 interface to shrink zswap pool
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Can you use memory.reclaim itself for that? With Nhat's shrinker, it
> should move the whole pipeline (LRU -> zswap -> swap).
>

Thanks,  I will backport it and have a try.

> In many instances, swapins already free the swap slot through the
> generic swap code (see should_try_to_free_swap()). It matters for
> shared pages, or for swapcaching read-only data when swap isn't full -
> it could be that isn't the case in your tests.

Got it. Thanks for your reply.
