Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4A7F7464
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjKXM4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:56:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB9310E3;
        Fri, 24 Nov 2023 04:56:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54af61f2a40so757649a12.3;
        Fri, 24 Nov 2023 04:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700830599; x=1701435399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsG/xpa6fYr9saCYlpjmtHbE191RyPnMbq2PrnjwWUE=;
        b=dTxzI/nUvZDNm6z2WTgQlSCzR8HlSQdJApnMMHNr8q8gn40B8KVjhpTxXlrzrFaJ2K
         8gWwgC6V3yUYqjhYK2tY4X3cNvroE77tbSWqXmaRlJdrho/qCHzTz1iW5jzCHoQqWjZ3
         chYyW42UVqvp7SAHkjCOv+QuwwUJLRGgNjPQQHfuNvu0szvWk79s0k5iLay1aA9v8Qde
         pbiMGdzIjjM7oy0XCIcDhrSCfZ9azmlzoCGlTMPhsCDxJOlHYNzOtXdIYsHhmtOfudDA
         68Lppf9a9JHwM87fnTgzXVxuNa/eUK4AsBW+C+qFB8Fds6M0sSOIhSOBMTD9uBhoXBR6
         dmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830599; x=1701435399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsG/xpa6fYr9saCYlpjmtHbE191RyPnMbq2PrnjwWUE=;
        b=SUlFp/rq/q4vDeywcZMhfj+V9tYZxgF5Wqtao9o6zoqYq+HUiqp7nQjHhqancTXxRN
         4jlKFu12f3BZYcqDEEgjHNoLm3y4n1S2jeuo6clDtOoUA4pfaXTbSHG79oQfImM+mXgE
         r8I9ZkzULXDrciJFanwCU4o1SXheOJoPH+CwGUrWB6cdwsuvfsRz0Dy3iLnApk0NBQt7
         cX5713cOFjwq+dqYv/o5bDMg9etdHgyJtF7hZjSpReeQ3PcZNCPpb/TtKh0CCpIoDQyD
         N8AseeBKeE0TQJ6pjfrHL50aI7/StaJvlUqzWYs7IT/YcOCF3Q55GkAcMFusI0tx6T5i
         dTPA==
X-Gm-Message-State: AOJu0YyxLwgcz4VDscE4r371mp/JMbJKtDHFGuDxIiHB34ehoKlC5mOy
        3/g/LjwORA8y0EbH3ob3DZE=
X-Google-Smtp-Source: AGHT+IGHhB0W7LrNFaiTC07AZdhYUaA1fzJ0LYKGOarscRN/3Vxd7ogp8nATxdNnsuo1g2r9KtLMDQ==
X-Received: by 2002:a50:f68c:0:b0:547:bb6:5830 with SMTP id d12-20020a50f68c000000b005470bb65830mr1953661edn.34.1700830598661;
        Fri, 24 Nov 2023 04:56:38 -0800 (PST)
Received: from gmail.com (1F2EF15C.nat.pool.telekom.hu. [31.46.241.92])
        by smtp.gmail.com with ESMTPSA id d25-20020a50fb19000000b0054a92ddc3e2sm1758320edq.48.2023.11.24.04.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:56:38 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 24 Nov 2023 13:56:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf lock: Fix a memory leak on an error path
Message-ID: <ZWCdg5gcizJitxVw@gmail.com>
References: <20231124092657.10392-1-zhaimingbing@cmss.chinamobile.com>
 <20231124095319.GN3818@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124095319.GN3818@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Nov 24, 2023 at 05:26:57PM +0800, zhaimingbing wrote:
> > if a strdup-ed string is NULL,the allocated memory needs freeing.
> > 
> > Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> > ---
> >  tools/perf/builtin-lock.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index b141f2134..086041bcb 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -2228,8 +2228,10 @@ static int __cmd_record(int argc, const char **argv)
> >  		else
> >  			ev_name = strdup(contention_tracepoints[j].name);
> >  
> > -		if (!ev_name)
> > +		if (!ev_name) {
> > +			free(rec_argv);
> >  			return -ENOMEM;
> > +		}
> 
> Isn't this an error path straight into exit?

It increases the quality of implementation if resources are free()d 
consistently regardless of whether the task is going to exit() immediately, 
for example it makes it easier to validate perf for the lack of memory 
leaks with Valgrind.

Thanks,

	Ingo
