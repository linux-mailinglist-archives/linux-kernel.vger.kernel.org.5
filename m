Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075FA79E15D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbjIMIBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbjIMIAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:00:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47534198A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:00:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-573f722b86eso4606393a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694592025; x=1695196825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIwCz4faVfGKEVy049aFmV+8W59Pfbk4tk2yjPYgoB8=;
        b=JQ9dHnxXqwxlhV3ZE+L2zLI3zRPAs0D80hjuj15dYucpBFGwTuJF1Ns9Tl0HhDQmBc
         GwszwtZy7K0aFM/bvOABgai+q5dAveYh8UxxmcCLVHrgnC2wNAaYII6v6rn8YuissJJG
         9V7jxa3pIcgZrxACAyEARRRQQMVKyhEPw/MkYAddk3a7UHE+A8+MAseAVgGSi/R37fdP
         1UwDHi3HRHsUIazL29FkCDpqOwtBuvb30q+vaEEANWpCerCDrMhCtUL2g2pwcqfG0ujk
         9a72SFT4NdZ6ZGJzoesISib0H0/CsJmdQkrr6SrW57zlvjT692Jis6p/xvuU9KMrKXNk
         LORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592025; x=1695196825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dIwCz4faVfGKEVy049aFmV+8W59Pfbk4tk2yjPYgoB8=;
        b=FxVs+YD3kcLQi7roOHW0VuXYsBQSXRDsYrYJN7KmIQTinZhs71d1hjxAm+h9jXHTw+
         BtB7rUfFIVuNaUNc0BcOzg8gA+nCUcV6gjmkGwyS1qu22DZM50C6rCMETUGxA8xz+E2a
         92KLAX4LiFzOZ4hztIECju2xmg71mKqT6nHku0Uhh0oOw1qta4v28DN3sQjbxmaShm/o
         mIZq+SM8vQV3LS6yhJv0nNgq8Z4gxDu/vNbxK1Jj4Ngzf5RVxOGghic4TewViomkk3qZ
         hD/BC7P54GyPgDv6OGSCSvl5VL4t32LPyr2S9d17zKzk8z8FamT+XgtQyvopIsY/npDq
         wU8Q==
X-Gm-Message-State: AOJu0YyCTGG5QvuMVn/NIUxptBYL1PPvm3lY3fiTL6rtOD+WCWGoptAt
        yBal3OJ3tkLam85DBuYJUs8tJw==
X-Google-Smtp-Source: AGHT+IGSfghnaKlgMzQ4SkAe9zaZTX6miCTsIa8a3+D7CDVac7Rg1w4Q94HbBRGXRM1BmbIAX+07Ig==
X-Received: by 2002:a05:6a21:19b:b0:152:efa4:228 with SMTP id le27-20020a056a21019b00b00152efa40228mr1956725pzb.20.1694592024709;
        Wed, 13 Sep 2023 01:00:24 -0700 (PDT)
Received: from [10.254.99.16] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903230b00b001bb99ea5d02sm9794632plh.4.2023.09.13.01.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:00:24 -0700 (PDT)
Message-ID: <89afc718-b5e5-38e4-6698-bb28b80e2c83@bytedance.com>
Date:   Wed, 13 Sep 2023 16:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To:     Bixuan Cui <cuibixuan@vivo.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Michal Hocko <mhocko@suse.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com>
 <e88fe274-cd53-40d4-9a8e-7c6a4e1d8c44@vivo.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <e88fe274-cd53-40d4-9a8e-7c6a4e1d8c44@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Bixuan.

在 2023/9/13 09:18, Bixuan Cui 写道:
> 
> 
> 在 2023/8/10 16:13, Chuyi Zhou 写道:
>> +#include <linux/bpf.h> #include <linux/oom.h> #include <linux/mm.h> 
>> #include <linux/err.h> @@ -305,6 +306,27 @@ static enum oom_constraint 
>> constrained_alloc(struct oom_control *oc) return CONSTRAINT_NONE; } 
>> +enum { + NO_BPF_POLICY, + BPF_EVAL_ABORT, + BPF_EVAL_NEXT, + 
>> BPF_EVAL_SELECT, +}; +
> 
> I saw that tools/testing/selftests/bpf/progs/oom_policy.c is also using 
> NO_BPF_POLICY etc. I think
> +enum {
> +    NO_BPF_POLICY,
> +    BPF_EVAL_ABORT,
> +    BPF_EVAL_NEXT,
> +    BPF_EVAL_SELECT,
> +};
> +
> definitions can be placed in include/linux/oom.h
> 

Thanks for your feedback!

Yes, Maybe we should move these enums to a more proper place so that 
they can be generated by BTF and we can take them from vmlinux.h.

> Thanks
> Bixuan Cui
