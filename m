Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C17CC374
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbjJQMnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjJQMnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:43:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBE7F7;
        Tue, 17 Oct 2023 05:43:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507bd19eac8so987435e87.0;
        Tue, 17 Oct 2023 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546628; x=1698151428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dU8fcBg2qfnHqJfD8YzF7HjBo3pGHCr4x5VKwo1eLr0=;
        b=Lmp1O4NOqIU8AnkHQlwWrizbq1nY+neJpVLQbaY9wQaHDR//++bLnJt+uaq7Xautmy
         nZeofmYtz0GXMTVKdgPgfU71rAbFNZoxUrNpZHlNfNcvZL7Yxmu0VdeGQtov6aoLdHrC
         ANx16fzn5E2UfFabUhFGRoYid6PeDv7RTSxaJCcwvwt9n9rUudgsTUZ9yC3oHnimYlji
         jw+nDJitu3NeT3Es2izROC8cBJNM/e8HuIES/7ZVyOgCAaAjQr3AJUgAGUyNMUG/kDSg
         UXBpIQ7oSXUn/x1N4/2gA31Z5CLTvsHupUb+5iEmbHiHLt23x8UPrR59WKQKVkN+4ueV
         dJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546628; x=1698151428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU8fcBg2qfnHqJfD8YzF7HjBo3pGHCr4x5VKwo1eLr0=;
        b=Gz+OAqNCTjIdF0/kq503lvGe3vG0QxLqIGa2P/y5XQF9uOwTMvkLPrzIC/uXQkSHmT
         J3bLlkjc3wWSCQxJiakXHLmeNCCCJXbtDi7dcrrXnVFjSflYK+HGiNPFVag5EUCrKTVt
         +IHRtM4/BoArQt2/MJILj7u5roaNrWgojSi8f2A/AJy+FWXk4nxdKGUovxqYmV/oxY1B
         FItaDKRJoGWUxYxUc9CDkKaXJvw2x/8sekG4yW7QJvJRs9Kx3SWwded5dOipUg99O8pq
         s4aG+RUSuv5vgmEDP00TYcVXoIuR1eQum82xup411eXiTf87Ao2vFl1fX7C99vxK82YY
         TUbw==
X-Gm-Message-State: AOJu0YyudOfIu0XxS8eccvWaEGccBhTMdNqiawhJd1DCWYGYC3TSWtaH
        E/PpFANXsHozFxfBW7hQTKI=
X-Google-Smtp-Source: AGHT+IHvWVUF0JDmvlQh2xBjxEDBsuMN0cpQVq3rhVOa4Mis6fhC7TgE6BIM4XSfgwVi7PlUnIKM5g==
X-Received: by 2002:a05:6512:2387:b0:503:8fa:da22 with SMTP id c7-20020a056512238700b0050308fada22mr2072367lfv.22.1697546627970;
        Tue, 17 Oct 2023 05:43:47 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id a6-20020aa7cf06000000b0053e625da9absm1158420edy.41.2023.10.17.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:43:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Oct 2023 14:43:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [perf stat] Extend --cpu to non-system-wide runs too? was Re:
 [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS6BgfOUeWQnI1mS@gmail.com>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org>
 <ZS1c9RCh9MkzPbFG@kernel.org>
 <ZS2ecyCVpK8B2cQq@kernel.org>
 <ZS5yl3RzVGKBkCvY@gmail.com>
 <ZS592qxF3YxmCoG1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS592qxF3YxmCoG1@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Oct 17, 2023 at 01:40:07PM +0200, Ingo Molnar escreveu:
> > Side note: it might make sense to add a sane cpumask/affinity setting 
> > option to perf stat itself:
> > 
> >   perf stat --cpumask 
> > 
> > ... or so?
> > 
> > We do have -C:
> > 
> >     -C, --cpu <cpu>       list of cpus to monitor in system-wide
> > 
> > ... but that's limited to --all-cpus, right?
> > 
> > Perhaps we could extend --cpu to non-system-wide runs too?
> 
> Maybe I misunderstood your question, but its a list of cpus to limit the
> counting:

Ok.

So I thought that "--cpumask mask/list/etc" should simply do what 'taskset' 
is doing: using the sched_setaffinity() syscall to make the current 
workload and all its children.

There's impact on perf stat itself: it could just call sched_setaffinity() 
early on, and not bother about it?

Having it built-in into perf would simply make it easier to not forget 
running 'taskset'. :-)

Thanks,

	Ingo
