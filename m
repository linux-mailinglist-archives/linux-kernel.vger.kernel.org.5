Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17517AEC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjIZMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZMPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:15:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7FCEB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:14:53 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-578af21ff50so5136094a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695730493; x=1696335293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVLSnPZRPh3IUGltAtRx2kbSqd+69xY7hEP2Xyp16EU=;
        b=LBFmnCyEd/x7Gk7PTeqxr/J7ygAU/r/JeyY5rPz7+WAWGgrJiv+A+eBoNEFTKI9rWH
         JlLMmae3nVk2Xjo/VlULeyhk0i3isHoYZqoCgk5na9nZn7Cu1e0I0CqO+jFJ2OF9r2LG
         vFqI5CO8hh4N2nWoNtTgTUOr/WzIGUU5vxJ4hZALSdKCzunc69o6J7B/caVXGC2ANxOA
         J6kzrYv25YyuUjVgpxEhcwsWvuPMpQuimW2To5amJqhNdXsKIStp47DGkmZiZRCppAXR
         BeYf91I8OJoh//HQE3uH5XZXXJNhSDXNhL4yPN4IRGRzZgqgDPmohe9ltkM/f6tRFH2s
         uN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695730493; x=1696335293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVLSnPZRPh3IUGltAtRx2kbSqd+69xY7hEP2Xyp16EU=;
        b=R2wa/oxljbBMnwu1umrHmBjqW4QNNjYoCRBSzVku3N0cepEvmFaZJKJmu9ASKe1tIn
         44dNvSvfvCZ3e2jl4Kho6d2cMI9kuxfwh5SW/ierFhGOnnw8nPjAWBHd52Co9h9pYRd/
         CChZsLY1q2GfOCpeXpRbh/gp2O2APnYLYqSk+rOog7sgcX7nyaFxSRSk2W2XFC41aILQ
         K48Id5UWpGiJTzysvnQvkOXdezI1hYvWwmMQOoN2riswPfExHh9vQsUGpqIO4hqtf/Lj
         XG0I293GlqEoh8gr//kvD22oiKXEb6oRTBpbVK5e/87NmZi0EDTSQbekiaPuSUYW04Ou
         oGTQ==
X-Gm-Message-State: AOJu0Yyn9DbLRmI2Ja1zr5rjb0y/A50fnlIwXYMpwMqr7bhtEwOEwSMj
        CgfKLwF2CHwpngTurqxSufe577ZlmvQM7sc3Kr8=
X-Google-Smtp-Source: AGHT+IEa93Ct9s9tsQY7buH3wVw5Mh85PiJ/K776BQHAxbMbhQACaWHOUvcg6nPCndJM1yhg6s5xjQ==
X-Received: by 2002:a05:6a20:1398:b0:15e:240:3c35 with SMTP id hn24-20020a056a20139800b0015e02403c35mr6660012pzc.31.1695730493191;
        Tue, 26 Sep 2023 05:14:53 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e65:17d0:d15f:5a75:dc09:b72? ([2409:8a28:e65:17d0:d15f:5a75:dc09:b72])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b0068fb8080939sm9883990pfu.65.2023.09.26.05.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 05:14:52 -0700 (PDT)
Message-ID: <826082e4-8b67-429b-951b-ae3f69455791@bytedance.com>
Date:   Tue, 26 Sep 2023 20:14:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sched/psi: bail out early from irq time accounting
To:     Haifeng Xu <haifeng.xu@shopee.com>, hannes@cmpxchg.org
Cc:     surenb@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
References: <20230925123106.GB347250@cmpxchg.org>
 <20230926115722.467833-1-haifeng.xu@shopee.com>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230926115722.467833-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/26 19:57, Haifeng Xu wrote:
> We could bail out early when psi was disabled.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  kernel/sched/psi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 81fca77397f6..e74e14762d49 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1005,6 +1005,9 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
>  	struct psi_group_cpu *groupc;
>  	u64 now;
>  
> +	if (static_branch_likely(&psi_disabled))
> +		return;
> +
>  	if (!task->pid)
>  		return;
>  

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.
