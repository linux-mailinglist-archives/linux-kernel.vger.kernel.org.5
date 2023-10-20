Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F404A7D0AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376518AbjJTIqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376472AbjJTIqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:46:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5FD41
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:46:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso86677966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697791597; x=1698396397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Msl3mVmSy6+Gq7AtNX6ffagUflryyN28BFdYCytPHMM=;
        b=GT3Lpuho7cl+KurHEO2OAXBZcjEX9WQa4BDAXD+Xbf6Vy6xqqzGzGe/ocj20vH1wpb
         xhxQJOaJ4GHMGs2YknRDE5709pv2n+Ji3gkQOM5SS89B3DGRX7hAtzd2mLbpdj6WDQW9
         OZNUdl03Qf/ezFWrBZb1OhwDBTNVcd4bBKMcjO44XFXIylTjMp0YucKc3pfLzCWgrf5+
         1JOOiOThIhB31Fxqv9Ds4qntVHJPHo6noLhNiMKcUhSt+v2QpFUHuEmyAli1jMfcepK7
         9Yo2ZbEdh423f52hb6ZAEzjESnghA4bSzcPa3ujSmxIdpaQ+B8AiFul1MHuAWZWTXcjV
         nY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697791597; x=1698396397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Msl3mVmSy6+Gq7AtNX6ffagUflryyN28BFdYCytPHMM=;
        b=YBYiY5Itlo1ei1FKNDmd+9MX7GRXFlabpXRjg7abw0YmapXKe5vWpVEqgKqyGiFM0g
         owF02b1wiUOAmhbwzqyvmRzwB+mw65HVI+1wddmFIeIvgO+bZpBJhUqi03HyVQmKWnPG
         iVq0Q0oKFwCgNjUry3n49/SHd8yGrGnQ65GvLb4EFwmtTdDMxbmCtbvb9RJaX0dSxRPP
         6Ta1VuwvSUSJKX2GGkcswNeBBRLYcbpQFJ/YWz9Py46FlgvES59J5PmN78+qy5H6iMuZ
         Rz3QZTKwf6chME1hPoM4yEkc+DXVszTfi5mms6iX4ZMdHBq3tJEIOSLphO8jzo1qZdd2
         NgKw==
X-Gm-Message-State: AOJu0YwTjvGaoP0sDssk8quBbJOO8Awod4lrMZ92RBTsVZpl9z0MqYh4
        jkA+Dl9evnLxZdsy5C74mbU=
X-Google-Smtp-Source: AGHT+IHgJc2e0pa5iZwqPSKoPrb9P/cgXaL8EZrLoMZi9f7Db/sqCcC75jerHDXM4/xGnaNbQx/21w==
X-Received: by 2002:a17:907:9623:b0:9ae:6da8:1819 with SMTP id gb35-20020a170907962300b009ae6da81819mr789653ejc.48.1697791597177;
        Fri, 20 Oct 2023 01:46:37 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id n27-20020a170906119b00b009ae587ce133sm1043294eja.188.2023.10.20.01.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:46:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 20 Oct 2023 10:46:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/mm: Drop 4MB restriction on minimal NUMA node
 memory size
Message-ID: <ZTI+aiL/eKGbem6G@gmail.com>
References: <20231017062215.171670-1-rppt@kernel.org>
 <ZS+2qqjEO5/867br@gmail.com>
 <605cc166-e731-e7d1-25d7-b6797a802e6f@bytedance.com>
 <ZS/TRNf02Un8IOTK@gmail.com>
 <35bd1d51-35ac-3ee6-e068-f50dff7774bf@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bd1d51-35ac-3ee6-e068-f50dff7774bf@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> Hi Ingo,
> 
> On 2023/10/18 20:44, Ingo Molnar wrote:
> > 
> > * Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > 
> > > > While I agree with dropping the limitation, and I agree that
> > > > 9391a3f9c7f1 should have provided more of a justification, I believe a
> > > > core MM fix is in order as well, for it to not crash. [ If it's fixed
> > > > upstream already, please reference the relevant commit ID. ]
> > > 
> > > Agree. I posted a fixed patchset[1] before, maybe we can reconsider it.
> > > :)
> > > 
> > > [1]. https://lore.kernel.org/lkml/20230215152412.13368-1-zhengqi.arch@bytedance.com/
> > > 
> > > For memoryless node, this patchset skip it and fallback to other nodes
> > > when build its zonelists.
> > 
> > Mind resubmitting that to the MM folks, with the NULL dereference crash
> > mentioned prominently? Feel free to Cc: me.
> 
> OK, I will resend it if no one else objects. :)

Thanks, much appreciated - and I see Andrew already applied your two fixes 
to -mm.

With that background I was able to apply the x86 fix as well - which can be 
backported without the MM changes. The current commit in tip:x86/mm is:

  a1e2b8b36820 ("x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size")

Which should hit v6.7 in about ~1.5 weeks, unless there's unexpected 
problems.

Thanks,

	Ingo
