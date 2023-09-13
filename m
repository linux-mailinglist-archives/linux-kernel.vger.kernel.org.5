Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567A079DF48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 06:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbjIME5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 00:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbjIME52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 00:57:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37E173A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 21:57:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26f57f02442so4553328a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 21:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694581022; x=1695185822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUuT6xhrpskEbCzNwuseee5gbPTwHN5TLgP+3rePu4A=;
        b=OYwhRxFuUjVxZfcHZ7wgGCoQdIUN6L4GmpZ/ndjFKwo6oml/cofDN4bl2DlhmPoM6Y
         djSigpzXOR9epFla3Mb7nFkmPU321XdAZWzp791ib1Or5Jg5XWb/rvOiFY/37L7cbrve
         BUyYLR8H7p5Dc+00fO/0rbAKHkjx4SNDj+qFjw6gPUEQUsxHJsHFRpYsHe0GKf4LiAlf
         wSafCTEf+bxf+2M6f/wK6INowxkMw6jwTvqBHQbeX4UO/lodcW1840bLjYuDsv4hRj5O
         WSMe2JtI/su14tL1M9AryR0zbf5qTI8zAHVq5t7K2U0qYroRVIIUKwQUDZLtalV8InWR
         PnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694581022; x=1695185822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jUuT6xhrpskEbCzNwuseee5gbPTwHN5TLgP+3rePu4A=;
        b=vKS3FvvDL4zk8ppak0ScVpMnRlelMWFWJP6OEqnOwRDeTwj3L2cjH+p5fUj7fltoa0
         czXl3qgj6vC6innd1x/d13QhWkSXwOmTIJZoK/x556evFXeFpBmoJ2VdFsKQnmD9FKhL
         C890F2t/Yk5CD/k8s2HZhJuM3dtpfTOPxfP0t9a0EpcUX2JhSNHixkB55HlWES2qrQUf
         FG+RxEFgoCzpGRBqRS7ASU5W1fAYDs+PY4MWDuepLaAfrLUOi3LOZuWGST1lQcILEfUs
         4omGvFohEmO2Q7UE2N+aLo8jv/QsI+ciS4oSEfO0toMXLNhAPatwR9FYYEbWB3ovk/sK
         eR5w==
X-Gm-Message-State: AOJu0YxRCS9XG8iec9O4AQ4ekwJDTbTKB4yTHCYKZ9n3j12Lc+9kUXh9
        Dp9V/QeVu7SVUWB/meROUXRZeg==
X-Google-Smtp-Source: AGHT+IEBec3QFxac/FCTbUrO0hwTGE1AiPM5bwc+ak1kXddh13Nhapx5BBORG5ZLIDtUcmXbPQmexA==
X-Received: by 2002:a17:90a:b297:b0:269:3cdb:4edf with SMTP id c23-20020a17090ab29700b002693cdb4edfmr1184930pjr.16.1694581022410;
        Tue, 12 Sep 2023 21:57:02 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0026d6ad176c6sm2182802pjb.0.2023.09.12.21.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 21:57:02 -0700 (PDT)
Message-ID: <88825625-283a-d521-3e7e-058784455577@bytedance.com>
Date:   Wed, 13 Sep 2023 12:56:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Introduce css_task open-coded
 iterator kfuncs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-3-zhouchuyi@bytedance.com>
 <8b272d63-5dd7-13bd-7691-d061895fdbe1@linux.dev>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <8b272d63-5dd7-13bd-7691-d061895fdbe1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin.

在 2023/9/13 03:57, Martin KaFai Lau 写道:
> On 9/12/23 12:01 AM, Chuyi Zhou wrote:
>> +__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>> +        struct cgroup_subsys_state *css, unsigned int flags)
>> +{
>> +    struct bpf_iter_css_task_kern *kit = (void *)it;
>> +
>> +    BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != 
>> sizeof(struct bpf_iter_css_task));
>> +    BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
>> +                    __alignof__(struct bpf_iter_css_task));
>> +
>> +    switch (flags) {
>> +    case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>> +    case CSS_TASK_ITER_PROCS:
>> +    case 0:
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    kit->css_it = kzalloc(sizeof(struct css_task_iter), GFP_KERNEL);
>> +    if (!kit->css_it)
>> +        return -ENOMEM;
>> +    css_task_iter_start(css, flags, kit->css_it);
>> +    return 0;
>> +}
>> +
> 
>> +static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
>> +{
>> +    enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>> +
>> +    switch (prog_type) {
>> +    case BPF_PROG_TYPE_LSM:
> 
> This will allow the non-sleepable lsm prog to call 
> bpf_iter_css_task_new. The above kzalloc(GFP_KERNEL) in 
> bpf_iter_css_task_new should trigger a lockdep error in the lsm selftest 
> in patch 6.

Thanks for your test. I missed the dmesg error since I did not set 
CONFIG_LOCKDEP.

I think here we can use kzalloc(GFP_ATOMIC) to eliminate this error if 
we want to use this iter in non-sleepable lsm prog. I just tested, it 
works well.

> 
>> +        return true;
>> +    case BPF_TRACE_ITER:
>> +        return env->prog->aux->sleepable;
>> +    default:
>> +        return false;
>> +    }
>> +}
> 
