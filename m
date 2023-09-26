Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188FF7AE620
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjIZGjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjIZGjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:39:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8B116;
        Mon, 25 Sep 2023 23:39:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso135128941fa.1;
        Mon, 25 Sep 2023 23:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695710340; x=1696315140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOK6OfHsH5UzXX07PzrwQsARRjCcdnyHQS4dDua03nw=;
        b=eVBYK/fZZ8sArYAzt80NlSEYz5YueAeTBmFrv1BxvFdVsIuLC4Plueq9E4SW7V8rhp
         s0dZhrb1JdrjoCvTmSTdp2ls3R+6aM39VBwALow+xq5vA8+RRcOm6Imv8gBuqb7guN8V
         1gP4qqiy/lCJbysGtH1PypTLuJJ+QJupGB26gyo0hcthkRkTtOR1CpJFTo8gW9tHlyZC
         CJF47ol8t5pS0yo47UKX94fsrKP7hdwj/oy4H53ngC+xgXPoBgFjVA2MiEP/xaLReqQ6
         ATTpzkY2ji093g6ulAkz/uiZlfgUiE5oPhNi5FhiiKw36ornbV7f1jxVeFuZ0WrLmDzC
         LDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695710340; x=1696315140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOK6OfHsH5UzXX07PzrwQsARRjCcdnyHQS4dDua03nw=;
        b=HiBM1U6+j7skFecrjJqGdh2k2btq/9VzXwzu4c7j9imRN0GVwP3KzVUhk957ThpJRu
         yKOZdjzkxwrJ/4Dzd3OHQWV3o5h/EfOcHmnncxu8eyOq5mB/rV7xKmZpnMl/o64RWFov
         KoA3OaZVIs/38b5yiAOuZZON+FeGPOzsWbjNQ2b3SAzV5/yrG5POBAi2LrIvCgmkYFjo
         W42e951IsjObh78peF7uO/sAT7FissUuB49iqL6eBkYr0PlyBalD3VejtC52HBIhIokH
         OnC+Dn2ypjRmB+66ecbI7MOeFVWqGgXvD8/wKHl2jcb5HJkDV14R8ikaeDFYQ+OCfX/q
         ursw==
X-Gm-Message-State: AOJu0YwK0qcMxI/sfNM87/ayn7DBxLjZf446QYx1wNrYHp6hVXtAdfIx
        SEC/WR/X/oVYicsoJUbWhIpi9mL6U60H9g==
X-Google-Smtp-Source: AGHT+IEZbAEvu9lgt5JJh/Z2GjloOrBpRgTUgnNCYG3KavjqfNt/qHcgljINrUwUMAXGwze8s6FBiQ==
X-Received: by 2002:a2e:97c8:0:b0:2bc:e954:4203 with SMTP id m8-20020a2e97c8000000b002bce9544203mr7159098ljj.26.1695710340426;
        Mon, 25 Sep 2023 23:39:00 -0700 (PDT)
Received: from f (cst-prg-24-34.cust.vodafone.cz. [46.135.24.34])
        by smtp.gmail.com with ESMTPSA id lw3-20020a170906bcc300b009ade1a4f795sm7244603ejb.168.2023.09.25.23.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:38:59 -0700 (PDT)
Date:   Tue, 26 Sep 2023 08:38:57 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [apparmor] use per-cpu refcounts for apparmor labels?
Message-ID: <20230926063857.h3afce5hagnlkoob@f>
References: <CAGudoHFfG7mARwSqcoLNwV81-KX4Bici5FQHjoNG4f9m83oLyg@mail.gmail.com>
 <87a5t9bypm.fsf@intel.com>
 <c6379a39-42f2-b3f9-c835-bbebe516ba3a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6379a39-42f2-b3f9-c835-bbebe516ba3a@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:21:26PM -0700, John Johansen wrote:
> On 9/25/23 16:49, Vinicius Costa Gomes wrote:
> > Hi Mateusz,
> > 
> > Mateusz Guzik <mjguzik@gmail.com> writes:
> > 
> > > I'm sanity-checking perf in various microbenchmarks and I found
> > > apparmor to be the main bottleneck in some of them.
> > > 
> > > For example: will-it-scale open1_processes -t 16, top of the profile:
> > >    20.17%  [kernel]                   [k] apparmor_file_alloc_security
> > >    20.08%  [kernel]                   [k] apparmor_file_open
> > >    20.05%  [kernel]                   [k] apparmor_file_free_security
> > >    18.39%  [kernel]                   [k] apparmor_current_getsecid_subj
> > > [snip]
> > > 
> > > This serializes on refing/unrefing apparmor objs, sounds like a great
> > > candidate for per-cpu refcounting instead (I'm assuming they are
> > > expected to be long-lived).
> > > 
> > > I would hack it up myself, but I failed to find a clear spot to switch
> > > back from per-cpu to centalized operation and don't want to put
> > > serious effort into it.
> > > 
> > > Can you sort this out?
> > 
> 
> I will add looking into it on the todo list. Its going to have to come
> after some other major cleanups land, and I am not sure we can make
> the semantic work well for some of these. For other we might get away
> with switching to a critical section like Vinicius's patch has done
> for apparmor_current_getsecid_subj.
> 

Is there an eta?

I looked at dodging ref round trips myself, but then found that ref
manipulation in apparmor_file_alloc_security and the free counterpart
cannot be avoided. Thus per-cpu refs instead.

Perhaps making the label as stale would be a good enough switching
point? Is it *guaranteed* to get labelled as stale before it gets freed?

btw, __aa_proxy_redirect open-codes setting the flag.

> > I was looking at this same workload, and proposed a patch[1] some time
> > ago, see if it helps:
> > 
> > https://lists.ubuntu.com/archives/apparmor/2023-August/012914.html
> > 
> > But my idea was different, in many cases, we are looking at the label
> > associated with the current task, and there's no need to take the
> > refcount.
> > 
> 
> yes, and thanks for that.
> 
