Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765E37AD9A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjIYN5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjIYN5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:57:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1CA109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:57:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c60778a3bfso26720145ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695650224; x=1696255024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZProgDFYbtPLT1IHeCAbc9TyFpXdnsEMk1OY2dVcw9Q=;
        b=Typ/tVl9DEa0ZNVyOQ1hkfclykoADo8VSGBsBmtPqUiihz/3deZAcm+vDUgaa5qgei
         T18E+GUfXRjS/h+xofuqnPSnoYxYBGHWZ/chNXk9SNKIo4RyRafv1OHMBSglJLNYPDTp
         h4UB96w1GHzB2FRyvlv6ZwLnEN7m4KXSm8eQcpFDkO6WLU0sI/lozOeo+vgceYbblsDF
         Hog6phNWd75s37hwyRmtVe2Mg5oJ9tjEhUg2f1ZBUtyfarHqMy4t4GJNYcYsrYC11bpZ
         6g7vHgcEYIHLH73wsz2Ri3xc3EtXU/SBBd2JK0lCAfb5HAmE/G/tzJDcUfCtAkFCUtWc
         fcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695650224; x=1696255024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZProgDFYbtPLT1IHeCAbc9TyFpXdnsEMk1OY2dVcw9Q=;
        b=viRA0RXyPLTH3gokciPf6n5mmE2qfqBJfR994cHA+BpIaGgvdXpQCbWrgYgJ7MKxtG
         SmBwnF6fZhJZtsJn8KdhvxnYuFB+0EGa1ek7V7f3Il9i7sJFyd+X6FxDeINqN5mpX3In
         DHZHmyElJtIaKdTcjCW3SIhOg6CWYcSV3rSl3deAKxeUZjnsbJ2DpONff3JkiABuK1rr
         A6sY4Ja8CX5T7/MmWyqlac5Qty63ONYyHvq1GfWkwcz/8AM0I++JB6jTWyX/1ivo1Nsp
         X96tn8TgucQ6WV4gYyfhYbz23ZZhCq9c56Y6s15JGNUpUyuj6sDlgAEkPYsYXTMt8iL5
         j3tQ==
X-Gm-Message-State: AOJu0YzVu1vq1j6WqOJ7zshmu3fkETc3D51CergXhfBhan6eQlVkCiVs
        a/47yXvpYxAShH/EFDPN2fcjim3NomMJx3NvItM=
X-Google-Smtp-Source: AGHT+IG7g+gZLYLvgfLIweiBWT35v34bpQ+n8JnBJGhKv48K6uxHeHCtJi3/LA11ABN2S+bVQHdNHA==
X-Received: by 2002:a17:902:c10d:b0:1c0:c4be:62ca with SMTP id 13-20020a170902c10d00b001c0c4be62camr6296681pli.17.1695650224598;
        Mon, 25 Sep 2023 06:57:04 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e65:17d0:bcff:bf03:732d:884c? ([2409:8a28:e65:17d0:bcff:bf03:732d:884c])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001a80ad9c599sm561262pld.294.2023.09.25.06.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 06:57:04 -0700 (PDT)
Message-ID: <4f5b8a45-4952-43b0-8818-b78d85fbbf74@bytedance.com>
Date:   Mon, 25 Sep 2023 21:56:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/psi: bail out early from irq time accounting
To:     Haifeng Xu <haifeng.xu@shopee.com>, hannes@cmpxchg.org
Cc:     surenb@google.com, linux-kernel@vger.kernel.org
References: <20230925102143.462545-1-haifeng.xu@shopee.com>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230925102143.462545-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/25 18:21, Haifeng Xu wrote:
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
