Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1757DD41C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjJaRHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjJaRGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:06:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B47E181;
        Tue, 31 Oct 2023 10:05:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so10251870a12.1;
        Tue, 31 Oct 2023 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698771927; x=1699376727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHOq+cM1i5HvilDCUI3n2s0JE2fFsAEJIBhWGuopi9E=;
        b=USHGYfnnsTMSxXqdmOHwuBfdbU20Ymow/HfF6shFT4ANCtcq9ICZYYA4pIQ7RE4jlX
         7edaUJ1TE4Bt+Q0K9g/7WHYnrQccXZLlreQ7M2ohQw7pcxjZr/yjUiJ7JFtTn+mH2arx
         UEEnhjHTRVPLSHZPJWnbVvf9j2wNAK3gOc1DM95z2MGQSAlS0ol/9u1l8RzJr6tOOfQS
         fr30yKguNEDQ5lRenE7t4VjovjYGAu8bFD8sbskAgYzQYR6RRkqfujVJORRK0Ml34sqh
         tnh2lLkfqn962QwobeG1u2MLS6qwMWpQPse5K/3y2Tw8ALqZpfgaABfYpmTrBEiaUrJy
         WlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698771927; x=1699376727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHOq+cM1i5HvilDCUI3n2s0JE2fFsAEJIBhWGuopi9E=;
        b=op2CYNNIZSgchTC1HWY1FpYVPC2ZKpDNjehyv5ttAsDNAdvKv+oxTPyOpLkx5Tjvtz
         9Fa0/RaEP4M57oDss7r8/Jpg6J60VcqPKnIy8c2MQv+85HjqCMvtxp9mpD2Sg2+cqRR1
         9zKOQh0F6xf5x9tgDzuAid6VleUm8YMDplI+437d0e+ZilqC7rNcSWRdYvGvWGDuQXWV
         0IV4y8RjaEjTbzRxOxr+MytQ35R9XdXQIlXnwH4rcdCliEo15GPk+xT67yNts7QfnNAc
         olLGNWxRVP7swXLBNrSYcbizmDtXZdt9dDJfN3/WIOItqp1O9PGnURGm9i2H0gcT72Fm
         Pv3w==
X-Gm-Message-State: AOJu0Yzt8nYIC6N8pxY+o4vAeFt/C001l3PETe7TgNu0Yi7hPb9LemAf
        +JuoPzlkhrAA0K/GvxCjOPZb8iMQezOw7Q==
X-Google-Smtp-Source: AGHT+IHaRXGmxNROU+qgeKBTMhFayeYLeKfBdCCE+0SfI7lcwuHO+zQmfzKBoA+F2pfuixIZlMBnpA==
X-Received: by 2002:a17:906:dace:b0:9c3:730e:6947 with SMTP id xi14-20020a170906dace00b009c3730e6947mr10822219ejb.41.1698771926710;
        Tue, 31 Oct 2023 10:05:26 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z5-20020a170906714500b0099ce188be7fsm1279516ejj.3.2023.10.31.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:05:23 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 31 Oct 2023 18:05:17 +0100
To:     Matthieu Baerts <matttbe@kernel.org>
Cc:     Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: fix compilation error without CGROUPS
Message-ID: <ZUEzzc/Sod8OR28B@krava>
References: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 04:49:34PM +0100, Matthieu Baerts wrote:
> Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> possible to build the kernel without CONFIG_CGROUPS:
> 
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
>   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |              ^~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is reported only once for each function it appears in
>   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |                                    ^~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
>     927 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
>         |                                                            ^~~~~~
>   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
>     930 |         css_task_iter_start(css, flags, kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~~~
>         |         task_seq_start
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
>   kernel/bpf/task_iter.c:940:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~
>         |                class_dev_iter_next
>   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Werror=int-conversion]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
>   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
>     949 |         css_task_iter_end(kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~
> 
> This patch simply surrounds with a #ifdef the new code requiring CGroups
> support. It seems enough for the compiler and this is similar to
> bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
> been added in kernel/bpf/helpers.c and in the selftests.
> 
> Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")
> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665206927
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp@intel.com/
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>

Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/task_iter.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 59e747938bdb..e0d313114a5b 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -894,6 +894,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>  
>  __diag_pop();
>  
> +#ifdef CONFIG_CGROUPS
> +
>  struct bpf_iter_css_task {
>  	__u64 __opaque[1];
>  } __attribute__((aligned(8)));
> @@ -952,6 +954,8 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
>  
>  __diag_pop();
>  
> +#endif /* CONFIG_CGROUPS */
> +
>  struct bpf_iter_task {
>  	__u64 __opaque[3];
>  } __attribute__((aligned(8)));
> 
> ---
> base-commit: f1c73396133cb3d913e2075298005644ee8dfade
> change-id: 20231031-bpf-compil-err-css-056f3db04860
> 
> Best regards,
> -- 
> Matthieu Baerts <matttbe@kernel.org>
> 
