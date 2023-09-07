Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CFF79734D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjIGPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjIGPVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:21:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386EE199
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:21:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68e4700c931so255350b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100067; x=1694704867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CdG/yEmvsuQjOBoALKvigFMhVG4ZkbJlbNCVNFCW95k=;
        b=hFOYkRmmoIHO9n9MuKwUf0WLl6jMhh1INbgRHXwdw14pUsq5FUQylWcx9x8Xmh3/as
         jj/onsC61P9yAKaa66tu9QUR3zu1jsa+U9Ou1thc27maynS+IRsomqAAJ4aE4tlb0gyc
         54sm3bJQBOu048bTwVKcAmdFNq1JFTpinlhmzmETDijw7dkqIpueeOITLbU/i9D/eN3u
         n98Mw/3Dar4NWkneUTi8Lrfv76zgItVKjVnl1CYIEJf6XRG9mQXMGh6UkpvCLUOcuAwq
         yC7oJvS5v2FC5iO+V+pL96L2IS5378BtwlqS3Ax81Gnv14PUiZriwT3LYl4yRYqEmQ6i
         2H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100067; x=1694704867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdG/yEmvsuQjOBoALKvigFMhVG4ZkbJlbNCVNFCW95k=;
        b=Xhj9V2FeorHfDwL+liD7aK9kA93euwU+JXJDwI0nknWMiX3MC5Jb1/7l9LGyXZyL/j
         zgLFdvss1Xh6eSP/yc3z5KAEaEnzoLpvVI5iSn7lmubqdCSQhH2SAXRSjXIS1bN/MuiY
         8hyuS0BP++/Qfo+YxeHNvXtTpkPaYRCOYWVqQo2RFXde/If2q93No5UvkeCu8KCqsmY8
         l6cDNMIAkjtQ7h6eLK9lLn55v0Lsfwl/kM5wY8QJvxEamIrnjc5bmZNbYbsyKmUL4p7C
         /VC/kCt7Wf5jrT7IoE0rgIAE9duExOqq6n9ZoQPRrveDl8Ks3rEXTjQUtazLqyX42gOU
         Bu9Q==
X-Gm-Message-State: AOJu0YxEjiHV7RsKH6LrWSSGr6/iojEpqMOF+yLiCG1iKMa4D3nwI4bI
        9x2zipN8luZBKKYWxHpKn9pwCLMmzoexW+FTA/eFBj4ctVCl+X3XQwogsg==
X-Google-Smtp-Source: AGHT+IHvJa/7FkPw5UU4MQhoWrNN0JeNEpF4NYmZOKhJtjjWQqdbyDvw0AaJBhSfLDJ+K7NB4oYLX/Nq50B/h5Hi3tI=
X-Received: by 2002:a05:6122:9a9:b0:493:7c76:bbac with SMTP id
 g41-20020a05612209a900b004937c76bbacmr2374358vkd.2.1694093097716; Thu, 07 Sep
 2023 06:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230907024710.866917011@goodmis.org>
In-Reply-To: <20230907024710.866917011@goodmis.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 7 Sep 2023 18:54:46 +0530
Message-ID: <CA+G9fYt1dC7=pggtwX2D3jibbLweg+a2LnvYtxfF1nCnqELZSg@mail.gmail.com>
Subject: Re: [PATCH 0/6] tracing: Fix removing instances while reading/writing
 to their files
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 08:17, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> It appears that the dynamic code of eventfs has caused a race window
> to open up a bit more and showed that several files were not protected
> by the trace array ref count. This means that a task could open one
> of the files in an instance, remove the instance, and still be able to
> read or write to that file. That access will then cause a "use-after-free"
> bug.
>
> Close those holes!
>
> Also, fix a left over unused variable in the eventfs dput fix.

This patch set applied on top of Linux next master branch and
tested selftests ftrace tests [1]. The test run to complete and not
found any crashes.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

>
> Steven Rostedt (Google) (6):
>       tracefs/eventfs: Use dput to free the toplevel events directory
>       tracing: Increase trace array ref count on enable and filter files
>       tracing: Have tracing_max_latency inc the trace array ref count
>       tracing: Have current_trace inc the trace array ref count
>       tracing: Have option files inc the trace array ref count
>       tracing: Have event inject files inc the trace array ref count
>
> ----
>  fs/tracefs/event_inode.c           | 17 +++++++---
>  fs/tracefs/inode.c                 |  2 +-
>  fs/tracefs/internal.h              |  5 +--
>  kernel/trace/trace.c               | 68 ++++++++++++++++++++++++++++++++++----
>  kernel/trace/trace.h               |  2 ++
>  kernel/trace/trace_events.c        |  6 ++--
>  kernel/trace/trace_events_inject.c |  3 +-
>  7 files changed, 85 insertions(+), 18 deletions(-)

[1] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2V4IYQhAHrFXjwQvHLc2w3mKhXs

--
Linaro LKFT
https://lkft.linaro.org
