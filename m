Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23DB79EA60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbjIMOCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjIMOCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:02:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F61BC8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:02:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf6ea270b2so47981335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694613742; x=1695218542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8TV/vYHUT88G2GqhITGFuP8X++DkQFLt8lcg7QPXWY=;
        b=Cdg7btD62WAqeVwfafPQCoww3Z8iidlaAgrmalliYz3wj9M/ynAZV9jr13xT0XBWM2
         b5xr6h0J5rzW6Dr8b5B5dHwW2TLu7f2svDMrcM7aOuynG5v8xDOC0NhIU9kuhXWnA8px
         ksfKAwPg1Cqb3mmqim8Y65mm5IfqhEqRJkBTD7nMCc9i1JgzmHrX305duyXO6seY4uxz
         HE/ezrer9QpM+a+N/olQsbl0koGX+lSfztRz1JNcl5SOYqRAd5ghVQkH5w+/Hd6mQFVd
         vhUYYF9F6CgQZtahXyOwDDGwJN8vJOziL1mIArbECTR6qETGeRtrnoEzEEDHLpvkyrkx
         CvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694613742; x=1695218542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8TV/vYHUT88G2GqhITGFuP8X++DkQFLt8lcg7QPXWY=;
        b=O5kOpda7St6DbMnh/6bRDcWDABliPf3NCx6d2PQns8qQj1Itx7FRBMUriDpuT2M8QB
         nscpWYOLunxDw2W4kUYzBMikMqUhAT4qgp+0NsHTC5nEwMqwi6oEjb9XRWc2Q1UhjcWz
         gFmMWQ0d5SnOxwNcKsYF9sxsXnjVqoTHUDNvM7qTG7AxlWZ1cxrcUKGSQprHNcqMnAfi
         vBuRVM4LjWlQifVLHsNh5D8+5/iwuvHlt77Y/MioDvPrbk9qGcixZxJgY69XTO6Vsxas
         S/lr5gX1yZhuNfyDfDOQygbNd/iKB9fW11gC02RZ4UE8r10ewyW3fi+zya0bDxlTuu3F
         u6tw==
X-Gm-Message-State: AOJu0Yz2g4WbL/8CDfTuFyQMU5+oVOYwObNCc4j+wZGToll00HwnL+0T
        nPHjyXNDKeqzksCMN4MdHPyhmdvm17Wgan4G2oc=
X-Google-Smtp-Source: AGHT+IFk6cTmiwFURg4gM8dH/WDxl6Sas5H/iaWjCRhncDQqPfSneK4dPfBcnJRi5FS1TgjMyuJL8A==
X-Received: by 2002:a17:90b:3ec1:b0:273:e8c0:f9b with SMTP id rm1-20020a17090b3ec100b00273e8c00f9bmr2314225pjb.15.1694613742251;
        Wed, 13 Sep 2023 07:02:22 -0700 (PDT)
Received: from [10.254.99.16] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a001300b00263f5ac814esm1604293pja.38.2023.09.13.07.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 07:02:21 -0700 (PDT)
Message-ID: <bec78588-7585-1ca9-1c52-ad626f981d89@bytedance.com>
Date:   Wed, 13 Sep 2023 22:02:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Introduce css_task open-coded
 iterator kfuncs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-3-zhouchuyi@bytedance.com>
 <20230912171337.px445hxd76uxxnu6@iphone-544e90d47a76.dhcp.thefacebook.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20230912171337.px445hxd76uxxnu6@iphone-544e90d47a76.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alexei.

在 2023/9/13 01:13, Alexei Starovoitov 写道:
> On Tue, Sep 12, 2023 at 03:01:45PM +0800, Chuyi Zhou wrote:
>> This patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_css_task in open-coded
>> iterator style. These kfuncs actually wrapps css_task_iter_{start,next,
>> end}. BPF programs can use these kfuncs through bpf_for_each macro for
>> iteration of all tasks under a css.
>>
>> css_task_iter_*() would try to get the global spin-lock *css_set_lock*, so
>> the bpf side has to be careful in where it allows to use this iter.
>> Currently we only allow it in bpf_lsm and bpf iter-s.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/uapi/linux/bpf.h       |  4 +++
>>   kernel/bpf/helpers.c           |  3 +++
>>   kernel/bpf/task_iter.c         | 48 ++++++++++++++++++++++++++++++++++
>>   kernel/bpf/verifier.c          | 23 ++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  4 +++
>>   tools/lib/bpf/bpf_helpers.h    |  7 +++++
>>   6 files changed, 89 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 73b155e52204..de02c0971428 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7318,4 +7318,8 @@ struct bpf_iter_num {
>>   	__u64 __opaque[1];
>>   } __attribute__((aligned(8)));
>>   
>> +struct bpf_iter_css_task {
>> +	__u64 __opaque[1];
>> +} __attribute__((aligned(8)));
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index b0a9834f1051..d6a16becfbb9 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2504,6 +2504,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>>   BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
> 
> Looking at selftest:
> struct cgroup_subsys_state *css = &cgrp->self;
> 
> realized that we're missing KF_TRUSTED_ARGS here.
> 
>> +BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index 7473068ed313..d8539cc05ffd 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -803,6 +803,54 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>>   	.arg5_type	= ARG_ANYTHING,
>>   };
>>   
>> +struct bpf_iter_css_task_kern {
>> +	struct css_task_iter *css_it;
>> +} __attribute__((aligned(8)));
>> +
>> +__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>> +		struct cgroup_subsys_state *css, unsigned int flags)
> 
> the verifier does a type check, but it's not strong enough.
> We need KF_TRUSTED_ARGS to make sure the pointer is valid.
> The BTF_TYPE_SAFE_RCU(struct cgroup) {
> probably doesn't need to change, since '&cgrp->self' is not a pointer deref.
> The verifier should understand that cgroup_subsys_state is also PTR_TRUSTED
> just like 'cgrp' pointer.

Got it. It seems we should also apply this to bpf_iter_css_{pre,post}_new.

> 
> Also please add negative tests in patch 6.
> Like doing bpf_rcu_read_unlock() in the middle and check that the verifier
> catches such mistake.

I will do it in next version.

Thanks.
