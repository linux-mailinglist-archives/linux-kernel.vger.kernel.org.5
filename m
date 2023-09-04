Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9FA790FE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350855AbjIDCHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbjIDCHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:07:39 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E1210C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:07:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so278467a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 19:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693793231; x=1694398031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQJ9QCa6FQtC3tkMRp9THJpoMasl6gGHI0oe62CLOJk=;
        b=ZZie/J6FYustFTVjWIHzEuDfFlvoMYKrOCuntiWxzLVOZOS4fEmWaW/9kx5sP2YsJi
         fgSoUMJ967bHXSzYk3Sn+xntjYE98lHHW5izJik3jvBr+w8Haa9TfnCXGAs89XyY+V5v
         NtXJvDMTYVLcZDkb0dyMapZUObdC5hwAfRKSHE2+RVxFWWslAmF3b7k+DQrew0JF6bRi
         BcAlfgWc5ejqEALyBHjGHetAGGtVTebFUJLQVzWB18eAPEq0uUx9yZaC0rTkwCUQQbxe
         KjfxMG3G9UWcwCP+mqAXKslcF8R5ehjVHtKjGOTgC095/pQYg9Nuf/PiMSZnSgvcGdk/
         0AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693793231; x=1694398031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lQJ9QCa6FQtC3tkMRp9THJpoMasl6gGHI0oe62CLOJk=;
        b=Y0STKfzru6M7WJ7Lp29GhJsh9QngYZiT9FuWpKANKllCMFLcIYbyL0y7RVBLJDljcy
         T9mn7WfR0hr0YYRDUZsfRCVrubPUoF7+7SZKk+hPJZMVrQSWtyYEPw1pzvvNupmBJJj9
         2q0yYhivfAgzz/qRKelKplwOzyi4x2PjQA0mweFQ+V0B0ypnVus0fzxH4NiiGy7Pf+s4
         a0yYL1uWozWnvlgwFeeGLI6ZOw3cAJ5YXnp5EyxLMtAiZ/Cuw3H/TlNUuetlNjCboZi4
         2RzAGstsOOhbiX1Bw6kyDbw2IqCwrJlV9f1wiBIALlLIuvJKZCdIHwQcR/Pl23nuqnQ5
         7HdA==
X-Gm-Message-State: AOJu0YxL7ai0wG80ozG7fgBRfJ81Tk3677h+TrYkIoNLYiAbs7BCXvnS
        XkyovPk1hom7V8voddQJh+PVtA==
X-Google-Smtp-Source: AGHT+IG2Cd0YqVwkNvk8B2ct9yL3AJjzvgEY5++BngaCb9038fb+43O+5ycLCZZTs4tJI5LkRJaG1w==
X-Received: by 2002:a17:903:2605:b0:1c0:93b6:2e4b with SMTP id jd5-20020a170903260500b001c093b62e4bmr5652266plb.33.1693793231173;
        Sun, 03 Sep 2023 19:07:11 -0700 (PDT)
Received: from [10.84.146.222] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001b8a7e1b116sm6545111plb.191.2023.09.03.19.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 19:07:10 -0700 (PDT)
Message-ID: <6ce9d118-912a-df27-c015-17dee5762e1f@bytedance.com>
Date:   Mon, 4 Sep 2023 10:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next 0/4] Add Open-coded process and css iters
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, linux-kernel@vger.kernel.org
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

在 2023/8/27 15:20, Chuyi Zhou 写道:
> In some BPF usage scenarios, it will be useful to iterate the process and
> css directly in the BPF program. One of the expected scenarios is
> customizable OOM victim selection via BPF[1].
> 
> Inspired by Dave's task_vma iter[2], this patchset adds three types of
> open-coded iterator kfuncs:
> 
> 1. bpf_for_each(process, p). Just like for_each_process(p) in kernel to
> itearing all tasks in the system with rcu_read_lock().
> 
> 2. bpf_for_each(css_task, task, css). It works like
> css_task_iter_{start, next, end} and would be used to iterating
> tasks/threads under a css.
> 
> 3. bpf_for_each(css, pos, root_css, {PRE, POST}). It works like
> css_next_descendant_{pre, post} to iterating all descendant css.
> 
> BPF programs can use these kfuncs directly or through bpf_for_each macro.
> 
> link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
> link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/
> 
> Chuyi Zhou (4):
>    bpf: Introduce css_task open-coded iterator kfuncs
>    bpf: Introduce process open coded iterator kfuncs
>    bpf: Introduce css_descendant open-coded iterator kfuncs
>    selftests/bpf: Add tests for open-coded task and css iter
> 
>   include/uapi/linux/bpf.h                      |  13 ++
>   kernel/bpf/helpers.c                          |   9 ++
>   kernel/bpf/task_iter.c                        | 109 ++++++++++++++++
>   tools/include/uapi/linux/bpf.h                |  13 ++
>   tools/lib/bpf/bpf_helpers.h                   |  18 +++
>   .../testing/selftests/bpf/prog_tests/iters.c  | 123 ++++++++++++++++++
>   .../testing/selftests/bpf/progs/iters_task.c  |  83 ++++++++++++
>   7 files changed, 368 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
> 
