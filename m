Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3279277B403
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjHNIWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjHNIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:21:29 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39EF1733
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:21:22 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a5a7e7cd61so2533004b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692001282; x=1692606082;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EfzDg0tcvsZaIz86c4Cz2T/dWCigh2lZ1yHtRanABY8=;
        b=bgRWTGEDX+DBUNiCRpyOaEjR3cpZfC915z0NyfMFtHVeKu+a8iHB9jY03vMaBMT8wk
         DphqS3FFL4hG48q9b+ERoGVKnvZz1P9sU5Wgqc9vJTcI0MEaRxHX1po/OCA/BY6kTtpn
         /ADaYDwv2yLGHonokL4ivI4T1CKdoDYVbr4sc/OSTSW5rvaQWpyr8c9dewPDYHVOKJUO
         r3xtz6kzEIj4YUdmcR2LxhTIEjmP7e83zVgNCyjaLhUSjZDtjvcGQjig+oH/TvNIpW+k
         ykZZUQDyaryszGSnd19kyK+JwUvZhGxh5TaaUSGcy+wosP7wH+QD9SEe7tJHNqMvRZze
         15/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001282; x=1692606082;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfzDg0tcvsZaIz86c4Cz2T/dWCigh2lZ1yHtRanABY8=;
        b=ANT3LgUBxAvgp+SYuJx+y0sps7+o99flJwlJXqI9xlffQ+lr9OHzaHt1LvSPQiijsD
         rxkDuncFiPpnmI1vEHgLG8bVvWrduj3ySrBA6KPeoHmHbViWBaC8Q+FMxDT9k4AkSZvN
         s8DfuVXR4b84zN5QwgWcqTYp0RBNANTdh9P2qdPjRh590m0lIzBwnfy8K+41Nv1MVoIy
         t2NvaVn/BvlmxTgXfR0Emv/XaITvJKrvyidXN1Y1a4Da71Lz3czJsT68BwIWOG/AmhH8
         YvAm0VtFcPPg5plNSTziOxXc3jLGQFKR8NK3wbV651xrF8fpexrFrhYogYb+4tHq8UrH
         GUXw==
X-Gm-Message-State: AOJu0Yz1tgaDabOX+O5UEAgQ3uSq9AtH09iOUbWGnvvGyh2J7aUXv8lp
        kADcw6xjykH/8PjVOej//o/qQ+Mj0tsB8Yrxjr4=
X-Google-Smtp-Source: AGHT+IFr3MOzKwuHkNHECq4eLP71wzXUVrb9SjmwKDzpW8JnlO6/A0HXTjLcdBREw41rM+vs58pbN0Ye/jRkXMLo+YM=
X-Received: by 2002:a05:6808:1508:b0:3a1:bced:9e83 with SMTP id
 u8-20020a056808150800b003a1bced9e83mr8385042oiw.5.1692001282099; Mon, 14 Aug
 2023 01:21:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:9cf:0:b0:4f0:1250:dd51 with HTTP; Mon, 14 Aug 2023
 01:21:21 -0700 (PDT)
In-Reply-To: <00dd353b-e5aa-69fb-6b52-cb59028ea90a@redhat.com>
References: <20230813123333.1705833-1-mjguzik@gmail.com> <00dd353b-e5aa-69fb-6b52-cb59028ea90a@redhat.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 14 Aug 2023 10:21:21 +0200
Message-ID: <CAGudoHHHyZJXkNfGjGyxqHDay3yAzCm97r6SOdiSLYao7q2Z7A@mail.gmail.com>
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file replacement
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, koct9i@gmail.com,
        oleg@redhat.com, dave@stgolabs.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23, David Hildenbrand <david@redhat.com> wrote:
> On 13.08.23 14:33, Mateusz Guzik wrote:
>> xchg originated in 6e399cd144d8 ("prctl: avoid using mmap_sem for
>> exe_file serialization"). While the commit message does not explain
>> *why* the change, clearly the intent was to use mmap_sem less in this
>> codepath. I found the original submission [1] which ultimately claims it
>> cleans things up.
>
> More details are apparently in v1 of that patch:
>
> https://lore.kernel.org/lkml/1424979417.10344.14.camel@stgolabs.net/
>
> Regarding your patch: adding more mmap_write_lock() where avoidable, I'm
> not so sure.
>

But exe_file access is already synchronized with the semaphore and
your own commit added a mmap_read_lock/mmap_read_unlock cycle after
the xchg in question to accomodate this requirement.

Then mmap_write_lock around the replacement is the obvious thing to do.

> Your patch doesn't look (to me) like it is removing a lot of complexity.
>

The code in the current form makes the reader ask what prompts xchg +
read-lock instead of mere write-locking.

This is not a hot path either and afaics it can only cause contention
if userspace is trying to abuse the interface to break the kernel,
messing with a processs hard at work (which would be an extra argument
to not play games on kernel side).

That said, no, it does not remove "a lot of complexity". It does
remove some though at no real downside that I can see.

But then again, it is on people who insist on xchg to justify it.

-- 
Mateusz Guzik <mjguzik gmail.com>
