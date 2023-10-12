Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB207C650F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbjJLGDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjJLGDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:03:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F56B7;
        Wed, 11 Oct 2023 23:03:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so86250066b.3;
        Wed, 11 Oct 2023 23:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697090587; x=1697695387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kndtBynulzd80/3J4MlffDuuBlHDmwn71hGuSrPpZLw=;
        b=LsRtx4w9pztGtB8bCb7XxL0sY2Nd4X77WFHEpPSLT7NhecpGUksEPofxIM+vzMLH3K
         71Vwa9CRBxFAtxq7S993Gva7O3J0BlogP+ea54TqO66+UiHEi7SE9xi6rvU8Q2L0smIV
         ESxzSKQ8os4+/10ZC8sLJoNu9LtlpDNSHmTyAgjHwqbYO0wctzMLlYAC/BCC9K2NzCkv
         nDreiE1vdJien0QffVh57cKBdGnaBVvkwMDYpn5DESbdhkj07HRgz/Cmtg5LCFwmZSC5
         HKNYnxs7K5yx+vR0GUAjQyY/u1DSxFbcVm+jmKFQ4xghOJSG8e5Z25oQFBPvhMzVHeah
         o4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697090587; x=1697695387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kndtBynulzd80/3J4MlffDuuBlHDmwn71hGuSrPpZLw=;
        b=Yvw2bWie7d78INAjW/EmUQx410Jj12gMqsiU5OaaGE6dy3roHWl+FsdkZ+fuf3ftvT
         swU0Y7Ia1YsgIKJcud9cE7Y88VGW4ygYcI68GjohrLQjyK0isAs5hKH8ijut7nYxtgBk
         WQ/gqGUzPomt+KATyeC+e/Sv0BJlNatKGXf1SwVEC9eFYioaVEqZZBeawFs/D4c0B8OU
         rZfgXjTAsqV6Projx6U9xJBD5ckWphDmWYLFaQJwSU4y5zLpxAIJ+lvZAHNHI40+FfoL
         NhzrkYm+zyO9Ewbf6P97eS2KOR/Ph8yejpEx33UHydXhD2Z3MxlBJtvpbuzztrJUj0dA
         foZQ==
X-Gm-Message-State: AOJu0YyVfBiLMJ0jiJf9Hb+X7e1nXDJgHEeroayhqKW8E5dJgM6X4661
        HRdv9e/frwuBKXC/DUVQpxM=
X-Google-Smtp-Source: AGHT+IEmX/JzwUcGC7jbh+Rrf2P2akTGynH5UTwmvD+60tSI08BzZGYYPdNgwsSVyfhdDsgNlPxROQ==
X-Received: by 2002:a17:906:738f:b0:9ba:14a3:7221 with SMTP id f15-20020a170906738f00b009ba14a37221mr10002481ejl.73.1697090587162;
        Wed, 11 Oct 2023 23:03:07 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709063c1100b009b94a8150d8sm10725280ejg.199.2023.10.11.23.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:03:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 08:03:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
Message-ID: <ZSeMGPPfxkMvdaP3@gmail.com>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Namhyung Kim <namhyung@kernel.org> wrote:

> * How to use it
> 
> To get precise memory access samples, users can use `perf mem record`
> command to utilize those events supported by their architecture.  Intel
> machines would work best as they have dedicated memory access events but
> they would have a filter to ignore low latency loads like less than 30
> cycles (use --ldlat option to change the default value).
> 
>     # To get memory access samples in kernel for 1 second (on Intel)
>     $ sudo perf mem record -a -K --ldlat=4 -- sleep 1
> 
>     # Similar for the AMD (but it requires 6.3+ kernel for BPF filters)
>     $ sudo perf mem record -a --filter 'mem_op == load, ip > 0x8000000000000000' -- sleep 1

BTW., it would be nice for 'perf mem record' to just do the right thing on 
whatever machine it is running on.

Also, why are BPF filters required - due to the IP filtering of mem-load 
events?

Could we perhaps add an IP filter to perf events to get this built-in? 
Perhaps attr->exclude_user would achieve something similar?

> In perf report, it's just a matter of selecting new sort keys: 'type'
> and 'typeoff'.  The 'type' shows name of the data type as a whole while
> 'typeoff' shows name of the field in the data type.  I found it useful
> to use it with --hierarchy option to group relevant entries in the same
> level.
> 
>     $ sudo perf report -s type,typeoff --hierarchy --stdio
>     ...
>     #
>     #    Overhead  Data Type / Data Type Offset
>     # ...........  ............................
>     #
>         23.95%     (stack operation)
>            23.95%     (stack operation) +0 (no field)
>         23.43%     (unknown)
>            23.43%     (unknown) +0 (no field)
>         10.30%     struct pcpu_hot
>             4.80%     struct pcpu_hot +0 (current_task)
>             3.53%     struct pcpu_hot +8 (preempt_count)
>             1.88%     struct pcpu_hot +12 (cpu_number)
>             0.07%     struct pcpu_hot +24 (top_of_stack)
>             0.01%     struct pcpu_hot +40 (softirq_pending)
>          4.25%     struct task_struct
>             1.48%     struct task_struct +2036 (rcu_read_lock_nesting)
>             0.53%     struct task_struct +2040 (rcu_read_unlock_special.b.blocked)
>             0.49%     struct task_struct +2936 (cred)
>             0.35%     struct task_struct +3144 (audit_context)
>             0.19%     struct task_struct +46 (flags)
>             0.17%     struct task_struct +972 (policy)
>             0.15%     struct task_struct +32 (stack)
>             0.15%     struct task_struct +8 (thread_info.syscall_work)
>             0.10%     struct task_struct +976 (nr_cpus_allowed)
>             0.09%     struct task_struct +2272 (mm)
>         ...

This looks really useful!

Thanks,

	Ingo
