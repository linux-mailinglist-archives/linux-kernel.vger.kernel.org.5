Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0877CA1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjJPIlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjJPIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:41:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F121DE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:40:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1516128b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697445644; x=1698050444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X62F/9eWsOOWQV6WTuRQGSW94ij2zs1Yw6YCDuBcLY=;
        b=clvEKQVxVpgU+r7cdplGBBW8tlxnQoTCIYqPEkiK5tSXATPuDhgWCqh5ozORdkm/WL
         k+dtvqww7wBpca5o7U81CnvQp+ehCok5mpx3/LHDrL2gAwIb7Zz/tv3vGjcCm08LeA5T
         2HWwtXfsk3b+brJmhY73ahngohsc1x5Kj/0dFqTXU4AEOBGsKZ5ZDynCv84/tT2u11k3
         Ps9jRx0rZ+gKvvR0/03DKrERLpQ4xwabesDypiMjqOY6Pqqif+eYsiVtyqDGXTa2UR80
         AC7Uey3yL8FMjaBBLgVmwDvBOqIC+bZbSG7N4sx4YngBknw/pmN7Z98WfA1APr1L/TIk
         FnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445644; x=1698050444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1X62F/9eWsOOWQV6WTuRQGSW94ij2zs1Yw6YCDuBcLY=;
        b=VHUabHi8AJ7QqpTdSzFeDfI4cCIjKtyF5Gfau9eMB/rTOFmuMBeZHi4cj9N5AQjCXB
         VniKPx+jRnAuhEANFdd21ljX8nRH5iB94cN29fK57fk+91pihm7naoX2WBeIVSciSiPK
         avIKs0WRfMdINZIi5k+kv0hcJhIX9ZZ/Hn799bdOmdgl2qmX40XsvD+5cJDOAoo5h5rX
         VyeoyPt3uxPCEed7B4Y+uD5rS7h6FoJohXFY9tamOijeqk153amx5enYBgDmAtOClCVR
         8ugbtTbesGSWzUNvUDlYFTA7aecyrTeLgczR30SyDwZXp8E3t7hy58WCzjDJlpguHY38
         smqw==
X-Gm-Message-State: AOJu0Yzwsy7vj4qNRwxV6sWMpGg2y9QDYBs0cyI1RNoZNcdqscdIPtSL
        FJwdMDSkiKuV3eM6HIQKGeWm0A==
X-Google-Smtp-Source: AGHT+IHl0zhI4PyWipDX3Dh8iIf8uCjysXwg3nhxCMguY3vErB8Tgzsuw/j+OR0xZ3EqZFfClQjjDQ==
X-Received: by 2002:a05:6a00:14c5:b0:68b:e29c:b69 with SMTP id w5-20020a056a0014c500b0068be29c0b69mr11066705pfu.9.1697445643796;
        Mon, 16 Oct 2023 01:40:43 -0700 (PDT)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79dc5000000b006be0c9155aasm1775812pfq.91.2023.10.16.01.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 01:40:43 -0700 (PDT)
Message-ID: <850f21d0-4bd1-42df-8165-9ae985bb5601@bytedance.com>
Date:   Mon, 16 Oct 2023 16:40:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/8] bpf: Introduce task open coded iterator
 kfuncs
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20231011120857.251943-1-zhouchuyi@bytedance.com>
 <20231011120857.251943-4-zhouchuyi@bytedance.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20231011120857.251943-4-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/11 20:08, Chuyi Zhou 写道:
> This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_task in open-coded iterator
> style. BPF programs can use these kfuncs or through bpf_for_each macro to
> iterate all processes in the system.
> 
> The API design keep consistent with SEC("iter/task"). bpf_iter_task_new()
> accepts a specific task and iterating type which allows:
> 
> 1. iterating all process in the system(BPF_TASK_ITER_ALL_PROCS)
> 
> 2. iterating all threads in the system(BPF_TASK_ITER_ALL_THREADS)
> 
> 3. iterating all threads of a specific task(BPF_TASK_ITER_PROC_THREADS)
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   kernel/bpf/helpers.c                          |  3 +
>   kernel/bpf/task_iter.c                        | 82 +++++++++++++++++++
>   .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
>   3 files changed, 90 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cb24c4a916df..690763751f6e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2555,6 +2555,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 2cfcb4dd8a37..caeddad3d2f1 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -856,6 +856,88 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
>   	bpf_mem_free(&bpf_global_ma, kit->css_it);
>   }
>   
> +struct bpf_iter_task {
> +	__u64 __opaque[3];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_task_kern {
> +	struct task_struct *task;
> +	struct task_struct *pos;
> +	unsigned int flags;
> +} __attribute__((aligned(8)));
> +
> +enum {
> +	BPF_TASK_ITER_ALL_PROCS,
> +	BPF_TASK_ITER_ALL_THREADS,
> +	BPF_TASK_ITER_PROC_THREADS
> +};
> +

In next version, I would add the missing __diag_ignore_all for 
-Wmissing-prototypes in Patch2 ~ Patch4 to avoid kernel build warning.

Thanks.

> +__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
> +		struct task_struct *task, unsigned int flags)
> +{
> +	struct bpf_iter_task_kern *kit = (void *)it;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) > sizeof(struct bpf_iter_task));
> +	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
> +					__alignof__(struct bpf_iter_task));
> +
> +	kit->task = kit->pos = NULL;
> +	switch (flags) {
> +	case BPF_TASK_ITER_ALL_THREADS:
> +	case BPF_TASK_ITER_ALL_PROCS:
> +	case BPF_TASK_ITER_PROC_THREADS:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (flags == BPF_TASK_ITER_PROC_THREADS)
> +		kit->task = task;
> +	else
> +		kit->task = &init_task;
> +	kit->pos = kit->task;
> +	kit->flags = flags;
> +	return 0;
> +}
> +
> +__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
> +{
> +	struct bpf_iter_task_kern *kit = (void *)it;
> +	struct task_struct *pos;
> +	unsigned int flags;
> +
> +	flags = kit->flags;
> +	pos = kit->pos;
> +
> +	if (!pos)
> +		goto out;
> +
> +	if (flags == BPF_TASK_ITER_ALL_PROCS)
> +		goto get_next_task;
> +
> +	kit->pos = next_thread(kit->pos);
> +	if (kit->pos == kit->task) {
> +		if (flags == BPF_TASK_ITER_PROC_THREADS) {
> +			kit->pos = NULL;
> +			goto out;
> +		}
> +	} else
> +		goto out;
> +
> +get_next_task:
> +	kit->pos = next_task(kit->pos);
> +	kit->task = kit->pos;
> +	if (kit->pos == &init_task)
> +		kit->pos = NULL;
> +
> +out:
> +	return pos;
> +}
> +
> +__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
> +{
> +}
> +
>   DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>   
