Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28D17B7C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbjJDJbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbjJDJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:31:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA29E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:31:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so3316211a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696411890; x=1697016690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHtNZdHRvOw+mXFDRhP9xM8Z1b6juON3eU/gvAI1BbA=;
        b=eaeY1eovLASgISGWJZqfDycskBine8nlO3sTIsOp0Wqw/7yvTXrApmfhJnrFQaFlfE
         FC+HW+XTNsLaoSjmTjegRk5fFAclQF/rRD5D1cG05VPcHSgiDpjS+4BJ/CbU2O2IWtGv
         4gAaBkF4fsZc8UO0AywfkQ56zjHfiKMTzFHRCXgkfEsdnhC579lnFgihug3nRCMjNEof
         WUDka6L7XwhU3TTPKZtETGLJUNmvwX29Qfl++ehKPwwWVNP7pFDSQwx+MDM+OTuuFKru
         7+rRTIoJgPeKpa8y2b4F7NHzpjQGcTnlh4LxBJGAIVaRbwYKZeBhvWEXJs7T5AqPI8Iw
         11Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411890; x=1697016690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHtNZdHRvOw+mXFDRhP9xM8Z1b6juON3eU/gvAI1BbA=;
        b=gDh6QhyHjTk4zW2YqdLxEDIio0LAzv//jeSbCaZOGWBbowGCgf1lnnixPysbkdTGEK
         8GW0t/vEK2kNsqrPMaSwTJeGPjw15X4igZY4y3/imjNLt716D+ZG266oRWKIX226/CGg
         NMLdjYFwoVp88atIvIIz49RPcmnw5sRqRx0XzUxZRPPyufi2lSF8ss0KVbYitgm21eHq
         RssdHT6FOx3Z6qr/hPwyV/PmsCnQgqohmjYZnGaAaGHCwwqN+aD9MDmdiLMSs2yPkca1
         S/z14NJgJIv9NKKulK+a6rWD4kn6oBXYuMnDTLf+ItjdzuiSsCcN3pZsQn3RrQQnVqOp
         /0qw==
X-Gm-Message-State: AOJu0YyFzToEyA5wYfIYb7/BYmrYinyJPXVdiGcNWAXweYYrxLSjo0Tn
        XM0TKA5C65JLvy0+9h3mNhs=
X-Google-Smtp-Source: AGHT+IE1cUh0IzZYfXgyqP2r0ykT735/p43pwTiY6s3mJqe0JvvUFjxtl7dgEENyqx0l6IoV6tgxBg==
X-Received: by 2002:aa7:c154:0:b0:522:b112:6254 with SMTP id r20-20020aa7c154000000b00522b1126254mr1560022edp.4.1696411890135;
        Wed, 04 Oct 2023 02:31:30 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id m6-20020aa7c486000000b0053112d6a40esm2122522edq.82.2023.10.04.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:31:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 11:31:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Update comment of try_invoke_on_locked_down_task()
Message-ID: <ZR0w7vtVhiOVI4uD@gmail.com>
References: <20230731085759.11443-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731085759.11443-1-zhangqiao22@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhang Qiao <zhangqiao22@huawei.com> wrote:

> Since commit 9b3c4ab3045e ("sched,rcu: Rework
> try_invoke_on_locked_down_task()") renamed
> try_invoke_on_locked_down_task() to task_call_func().
> Now, update some comment about it.
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d18c3969f90..540ac33ddb80 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4186,7 +4186,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
>  	 * __schedule().  See the comment for smp_mb__after_spinlock().
>  	 *
> -	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
> +	 * A similar smb_rmb() lives in task_call_func().

Except the matching smp_rmb() doesn't live in task_call_func() anymore, so 
you now turned a stale comment into a misleading one ...

And how about fixing the obvious 'smb/smp' typo as well?

Thanks,

	Ingo
