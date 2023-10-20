Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC77D05CF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbjJTAag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJTAaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:30:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69328FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:30:10 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so210933a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697761810; x=1698366610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFVxp78twij10obCsSwgR7rxMUM9sI5ZKGkYU5zIYuc=;
        b=TcFvP4t++NEiy+JZQai0EII+0/PmfyvsItYQcmK+uXpNMNRaKfUCoy/l4x58/Rgfhh
         hJqyxVNOgzO90ukS9nMx5RD0dhkdbgZZL6Up04tkYfUcUNxJtfwBUaWWYWEUDb2tbG/u
         3umnnewyJm3kER6XqAk7af+Dor+fVbApUXkZAXnZrGRv8N6HNh/ojo6oJfMYuYt+/lEO
         +bjaIzd4haCv8g2R4bNRuRdZt21NW1afUGFjft5VHFnCdXJF4AnLfq16wQJn4LyhmA4p
         dL7S+fjU79q8BzSE4HqHgtbDjGifEwmeMdaQyPiJdGKXeCIjm+w5ZawBLXGk797kewKZ
         iUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697761810; x=1698366610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wFVxp78twij10obCsSwgR7rxMUM9sI5ZKGkYU5zIYuc=;
        b=rrHZnBwnQgv4IoLtb9rENKHP9uJPbTv2dyTO26F4Dz2aqBp2FsjApHgS67TaAjMsLt
         ocrjF/PSZpUIIM5Sfz64Hs2WcEfZm+J3gqYGIp+PuFoNDfOeB7IoFOo1wosSN1mz9ftp
         H2XcIHFPyDQolmYmBS/7Mw9hFos8dB0qXzJiFxaNw0BI49ej6VVd8vnslLWw2YN1A0Ej
         NTMjqfkLpXWNkZupwDPKj8EOn4wji82qWYIqEBDztqNvET7szkUEcKA+xgKpXErIjZT1
         aksDHYabBl0qMpqvvD/VKURx1eNt40nrwDTl97N8m4Q7zk8Yj7OxZ6+LSIqHk/cFSteY
         RepQ==
X-Gm-Message-State: AOJu0YxD298llWN6fArrzKkoKT6YfL8Jg5S9Mxphhnbt678zi1lgt7sL
        ek7aD4UY0YDQUpYj9W9LMNAubA==
X-Google-Smtp-Source: AGHT+IGu/TPiv9JbQ44i6PTX69vCOJN1LgwWJRmH3HD9gSIlE/ArFg/Dy+SI4fEPkgXheEAHBhf/jQ==
X-Received: by 2002:a17:90a:41:b0:27d:50a:f8a6 with SMTP id 1-20020a17090a004100b0027d050af8a6mr530733pjb.10.1697761809818;
        Thu, 19 Oct 2023 17:30:09 -0700 (PDT)
Received: from [10.5.91.97] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id nr12-20020a17090b240c00b0026b3ed37ddcsm326018pjb.32.2023.10.19.17.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 17:30:09 -0700 (PDT)
Message-ID: <92e8f98e-466d-45be-aa0a-35e02419a5c0@bytedance.com>
Date:   Fri, 20 Oct 2023 08:30:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH bpf-next v6 8/8] selftests/bpf: Add tests for
 open-coded task and css iter
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
 <20231018061746.111364-9-zhouchuyi@bytedance.com>
 <CAADnVQKafk_junRyE=-FVAik4hjTRDtThymYGEL8hGTuYoOGpA@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQKafk_junRyE=-FVAik4hjTRDtThymYGEL8hGTuYoOGpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/10/20 08:03, Alexei Starovoitov 写道:
> On Tue, Oct 17, 2023 at 11:18 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> +
>> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>> +__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s")
>> +int BPF_PROG(iter_css_task_for_each)
>> +{
>> +       u64 cg_id = bpf_get_current_cgroup_id();
>> +       struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
>> +       struct cgroup_subsys_state *css;
>> +       struct task_struct *task;
>> +
>> +       if (cgrp == NULL)
>> +               return 0;
>> +       css = &cgrp->self;
>> +
>> +       bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
>> +
>> +       }
>> +       bpf_cgroup_release(cgrp);
>> +       return 0;
>> +}
> 
> I think we should relax allowlist in patch 2 further.
> Any sleepable is safe.
> Allowlist is needed to avoid dead locking on css_set_lock.
> Any lsm and any iter (even non-sleepable) and any sleepable
> seems to be safe.
> 
> Then the above test would need s/fentry.s/fentry/ to stay relevant.
> 
> I would also add:
> 
> SEC("iter/cgroup")
> int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
> {
>          struct seq_file *seq = ctx->meta->seq;
>          struct cgroup *cgrp = ctx->cgroup;
> 
>          /* epilogue */
>          if (cgrp == NULL) ..
> 
>          bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
>             BPF_SEQ_PRINTF(); // something about task
>          }
> 
> To demonstrate how new kfunc iter can be combined with cgroup iter and
> it won't deadlock, though cgroup iter is not sleepable.
> 

OK.

> I've applied the current set. Pls send a follow up. Thanks


I would try to send a follow up patch next week.

Thank.
