Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4473B7C8751
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjJMOCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:02:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690DABD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:02:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5068692b0d9so2707369e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697205745; x=1697810545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F4Q1hPIpiSX7DqkBD7+SomvxsQ8tXqGNsU/QJenPxQ=;
        b=KdEbHdWX1lq9B8+lag6MBPAKmNGZXi8Wi5tLD21lIdKh5NmXH/rMr3OXhl+Ld3bfgh
         jhYu6lcxLtbhorg/R4pgH+infUGbItYhSpR3RLpLjqhzwPb7s7Q3L8Dj/8kWaxCQxorL
         tbk4XeuR9CAAZQTd16nTfL3jKhGz+veCjtw16DQgvIPhXw4fJ05JLOCV4TshDhNJHv92
         Hhbev6HkrZd/jRha9gSsQtei/3mVe6Gk3SwuPAMibgtQ9TzXyxt5uiEEY/6tq+XqW6qg
         1Quo6hN7aChxQrfK4d6P617U7B0u3HEzvH9GMM/dpfia0P6jNIDiCiH/eCaOvln34L/b
         hXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697205745; x=1697810545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F4Q1hPIpiSX7DqkBD7+SomvxsQ8tXqGNsU/QJenPxQ=;
        b=UvRevE3Ka4d9KA+/cBqHkdlQ8HeK6Ph7XbUeB0hdaz7uMyvpMriK8uzXGlLj9/Tfdt
         mLWradLu48zdGC4YkCeXdhhMw2cGuXnpjtgtgvrhP+CvFPhEl8TtPC2D9MpyAYx33VM5
         aPcjd6S+MaA9sri+nWD7gGoKUKuU9nVtKY188EClE85HCq5RNfJOJeT+q4AVhrYz4Xz/
         7WAboVzsLpdbbUy38SYGfmKw9aPOV9iHAnTFlGEtciJrDS1q9XtXfMFpCJfo7y1r4NHK
         J++LG1j9SRXxm+YQjykCvCE00UaRJntR23abtvAtdgrMq7haIr4bzT5yCsit/lFfzyoc
         Y/ww==
X-Gm-Message-State: AOJu0YwitN3yre1/rE53IP1/U0oSi2WAoHp9OjBGNoUY41DXt0yjoQQo
        Rd5YOMpZQOG6dXHDwOlxEoHbtv+fQ1QyCyDjCOA0Vw==
X-Google-Smtp-Source: AGHT+IFkuPJBzkLFtf/ZsAorx+3GM/UYYKYlPbN70XihOG+77Bs/KJ0PoObqpghK/P388pCMWjD03CCOxiVBBo52lyc=
X-Received: by 2002:a19:6754:0:b0:503:3278:3225 with SMTP id
 e20-20020a196754000000b0050332783225mr20512405lfj.63.1697205745635; Fri, 13
 Oct 2023 07:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com> <CAJD7tka+35CKYDLHus+LnN1yi_J=t_+kYXrZYh3asiWR41GKww@mail.gmail.com>
In-Reply-To: <CAJD7tka+35CKYDLHus+LnN1yi_J=t_+kYXrZYh3asiWR41GKww@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Fri, 13 Oct 2023 22:02:14 +0800
Message-ID: <CACSyD1NdYL4whDURJOC7_gqhpuqjbqsOkUacxS78iZm1pZCW9A@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] zswap: add writeback_time_threshold
 interface to shrink zswap pool
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

Thanks for your reply.
> I prefer if this can be done through memory.reclaim when the zswap
> shrinker is in place, as others have suggested. I understand that this
> provides more control by specifying the time at which to start writing
> pages out, which is similar to zram writeback AFAICT, but it is also
> difficult to determine the right value to write here.
>
> I am also not sure how you decide that it is better to writeback cold
> pages in zswap or compress cold pages in the LRUs. The pages in zswap
> are obviously colder, but accessing them after they are written back
> is much more expensive, to the point that it could be better to
> compress more cold memory from the LRUs. This is obviously not
> straightforward and requires a fair amount of tuning to do more good
> than harm.

I do agree.  For some applications, a common value will work,
such as 600s. Besides, this patch provides a more flexible way
to offload compress pages.

>
> That being said, if we decide to move forward with this I have a
> couple of comments:
>
> - I think you should check out how zram implements idle writeback and
> try to make things consistent. Zswap and zram don't really see eye to
> eye, but some consistency would be nice. If you looked at zram's
> implementation you would realize that you also need to update the
> access time when a page is read (unless the load is exclusive).

Thanks for your suggestion=EF=BC=8Ci will fix it and check it again.

>
> - This should be behind a config option. Every word that we add to
> struct zswap_entry reduces the zswap savings by roughly 0.2%. Maybe
> this doesn't sound like much but it adds up. Let's not opt everyone in
> unless they ask for it.
>

Good idea=EF=BC=8C Thanks.
