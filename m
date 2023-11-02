Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8FE7DEEAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbjKBJPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjKBJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:15:29 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9401912D;
        Thu,  2 Nov 2023 02:15:26 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5845213c583so333366eaf.0;
        Thu, 02 Nov 2023 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698916525; x=1699521325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=caPEzYV4J4M0wWYvtr+GB3NqWn9lERS8wHGxpAZ7shc=;
        b=SiJl0KdfKe5954iYcTf5/pEKWtmbkyTAdpoJYP9L7ggM0YAizce8JkaLECrwxODPlB
         vtxs++FNvi7ST17PY8jyNo3sWa+5vMQ8WpUc2SCrLvUMoo0olzPSfJpkERm5CPkWx2K1
         dyBVIbFtGT5LjjjepM+W1njRHu/qx3Vbrm8mXcR6AwHN03n/BqgmiXCoHuAU6WxSWSx8
         UWI4BHguhOqcnoQ3rx6JoHrroDX5vquYzke7leIQlHZGvbHHbkfSVLSWFKUEjguhBh3y
         fi6frC36+xCpheWR1f3ahBbp27S7/uQGeOvJC/Hvg2psfPM+8rMyNJycEh6Yd1xkL7eD
         wbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698916525; x=1699521325;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caPEzYV4J4M0wWYvtr+GB3NqWn9lERS8wHGxpAZ7shc=;
        b=neMnT6NkTBfk6avo8mZaotA5aSpIvH1StjGdMAtXfbNjAiM3l9T7rZcnQWC3FplI2s
         TZmrfLyU2CUJ80LdT3Twnz6zBQdsl1BucJZGSkWxBGaTEF1ctAlarP3n+3XxuKj0Ysxs
         LoIbwN/G/sThDnhyRWNtwni2vuVc+URfd9+LMY9HA1UTejNpf+hjkF8t9pYVfEcsbpsa
         ZdWAy1h0AefNJ50DR/MtgoUAGC9XGuhJYeKtTQssZ+bMW/Xob1MzJZHSJj54dso1mceW
         UpX8hCmLBh5wHqTE/lFvZQaKu4V/QSQPVzcuDJIr+QKOJq1hh49z2eXj0fKR51iOgZN/
         Ge+w==
X-Gm-Message-State: AOJu0Yzf+IwDTD864KA2Hq/1PrWdJXgDOqHCHPjzmroUKVEe7alAhRzD
        HwOnLh7Ivya496gX+g3H+4vl3WhEX5/K729yF9c=
X-Google-Smtp-Source: AGHT+IGcPuomBK8TNpeziKDesTihsWNjAp2h3J1FWTC79dSussXvee+MrBWw6arKMMvPhYHRrxeyLSdrDICPywYRba8=
X-Received: by 2002:a4a:bb09:0:b0:56e:466c:7393 with SMTP id
 f9-20020a4abb09000000b0056e466c7393mr16749040oop.5.1698916525728; Thu, 02 Nov
 2023 02:15:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:118c:0:b0:4f0:1250:dd51 with HTTP; Thu, 2 Nov 2023
 02:15:25 -0700 (PDT)
In-Reply-To: <ZUNYNEnGC8cm6ALH@debian.me>
References: <bede02c1-ef90-8e30-aa8b-e6fae49a8ccf@gmail.com>
 <ZPql6tqBCnXJh64J@amd.com> <ZUNYNEnGC8cm6ALH@debian.me>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 2 Nov 2023 10:15:25 +0100
Message-ID: <CAGudoHGfjRd9r7ec7S+HcGf7=dVTAJz9WDxPc_5w5Fykns+vrg@mail.gmail.com>
Subject: Re: Fwd: Abnormal battery drain with kernel 6.5 (Ryzen 5500u)
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Huang Rui <ray.huang@amd.com>, Meng Li <li.meng@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michele Della Guardia <micheledellaguardia@yahoo.it>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/23, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On Fri, Sep 08, 2023 at 12:41:14PM +0800, Huang Rui wrote:
>> On Fri, Sep 01, 2023 at 05:42:22PM +0800, Bagas Sanjaya wrote:
>> > Hi,
>> >
>> > I notice a regression report on Bugzilla [1] that have been already
>> > handled
>> > there. Quoting from it:
>> >
>> > > After switching from 6.4.x kernel to 6.5 I experienced an abnormal
>> > > battery drain since my laptop is actually never idle.
>> > > I accepted default CPUfreq to schedutil and AMD Processor P-State mode
>> > > is 3 (active).
>> > >
>> > > I expected a different behaviour, but am I missing something?
>> > > In my boot configuration I had "amd_pstate.shared_mem=1" and tried to
>> > > remove this switch, but did not affect my power consuption.
>> > >
>> > > Is there something changed from 6.4.x to 6.5 that requires a different
>> > > configuration to get an optimal power consumption?
>> > >
>> > > Thanks a lot for your attention
>> >
>> > See Bugzilla for the full thread.
>> >
>> > Anyway, I'm adding it to regzbot:
>> >
>> > #regzbot introduced: v6.4..v6.5
>> > https://bugzilla.kernel.org/show_bug.cgi?id=217853
>> >
>>
>> + Meng Li/Perry,
>>
>> May we know which CPU type are you using? Try "lscpu"?
>>
>
> Sorry for the replying just now.
>
> The reporter (on Bugzilla) had bisected to commit c8afaa1b0f8bc9 ("locking:
> remove spin_lock_prefetch"). Telling regzbot:
>
> #regzbot introduced: c8afaa1b0f8bc9
> #regzbot title: spin_lock_prefetch() removal causes abnormal battery drain
> on Ryzen 5500u
>

This particular commit is highly unlikely to be causing anything of the sort.

Looking at the bz I suspect the reporter did not follow through with
bisection, to quote:
> Tried to bisect following docs and I had just this output:
> [c8afaa1b0f8bc93d013ab2ea6b9649958af3f1d3] locking: remove spin_lock_prefetch

But that's what one gets when bisection is still in progress.

Final message, should one go through with everything and this commit
indeed was the culprit, would start with this:
> c8afaa1b0f8bc93d013ab2ea6b9649958af3f1d3 is the first bad commit

Perhaps you could help the reporter through building the kernel and
picking good/bad status. I don't know how easily visible the issue is.

-- 
Mateusz Guzik <mjguzik gmail.com>
