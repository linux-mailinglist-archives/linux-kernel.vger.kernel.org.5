Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6823076E87C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjHCMkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjHCMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:40:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC52C2D42;
        Thu,  3 Aug 2023 05:40:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2bc2701bso9065685e9.2;
        Thu, 03 Aug 2023 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691066400; x=1691671200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj4eDXUQ0hd/CHLJPkf3X+wyAGwaXVulDB8/LGcuRFk=;
        b=ja7J8p9lj1tfpGOIP6D3UnKuayHYmRJH+H63ksGG6zR1dqZdG2+pboVUfugiBQ8n3Z
         tPptQzDHHF4JouP0nD3r9QjBdUcOZR+ckAYF3Okz6QCYEc+yFYlO62x4G2pTo6qhe4Ya
         c4Gt0m/By0woz0/GIU6Mx5LMsSausyopcOC4x9E7Fq9Diqf8Ak6BOzAvgFv5WBO5qmY/
         RBpzgmfpe8yASyrrWAJLaNsXpJnAsWO5U3J5LHG8IMKN53bCcinpXnI7ehytGzr39rvD
         Yxpw90FOn2HecmptvBrrw62eiWgUCLolXJBz7AKlHmv4jRY4XGflwcoeKG3Ips8N+iZB
         GwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691066400; x=1691671200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oj4eDXUQ0hd/CHLJPkf3X+wyAGwaXVulDB8/LGcuRFk=;
        b=LZ7aXS/WtVVuFy0K2efmHdxcxk+Ce2CcXs35Rn7IoRreDxwrMRncZqU1HZY8+m/UDa
         l4Vmc9mHe/3zlypV/U3IsDwodg/qA1YMWZR2Gmloci9YZcJtozUkfqQA6cK3BQIcEyDO
         iATEDD12BgFnq4z2+rKaa+2JtRKgsFwNvNA7B4FPUPlTUJ4eRhwXME4dlbWk/PJT1oJh
         eqNk9R9jXagwxHo/IFewcQuuxqZx1Iu/sQcy2nPkIAac81fmsJwNnlmZVk5dOH4ObKAX
         DYndcvGNXCIC1CXuMdho5RvkPvv2iEHFV4bhB9z0h6KtpGVUrTM8sI81Av7y79fDD5gz
         Z5PQ==
X-Gm-Message-State: ABy/qLaifNuVBkGNIWphQnSMyoydF3P2yWzJop5cJhuMNxXG29oe9gs4
        Qecukg5FYEsIcwYSasAGE9FRrIYPpseDhIxWn1o=
X-Google-Smtp-Source: APBJJlHgHJLpvX5gAnfAM1Uke4wjAoweR86m5yXSND8ums9wN7Db4fMBYDseDHM+IQ9wC042+KKgEVNkzjszWcFUT+o=
X-Received: by 2002:a5d:4c43:0:b0:317:60ae:2ef5 with SMTP id
 n3-20020a5d4c43000000b0031760ae2ef5mr7255970wrt.31.1691066400298; Thu, 03 Aug
 2023 05:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-2-zegao@tencent.com>
 <20230803050900.5007d2f5@gandalf.local.home>
In-Reply-To: <20230803050900.5007d2f5@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 20:39:49 +0800
Message-ID: <CAD8CoPALuH=Enbi23Q9LF+eL-2iipZDmhiXfwg125PHS7gMx1g@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/5] perf sched: sync state char array with the kernel
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. For the removing the stale macros, the change log can simply state that
> the macros are unused in the code and are being removed.

I've split this part into a separate patch, and here is the changelog:

    perf sched: cleanup to remove unused macros

    The macros copied from kernel headers are unused and
    stale in the code and are being removed to avoid confusions.

    Signed-off-by: Ze Gao <zegao@tencent.com>

Regards,
Ze
