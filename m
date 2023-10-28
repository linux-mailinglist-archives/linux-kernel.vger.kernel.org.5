Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D417DA668
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjJ1Kb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJ1Kb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:31:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA010E5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:31:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so778745b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698489084; x=1699093884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2GySqZOk9lw/mCBfX2becssT8j/7QRVN5jjdGNKoi8=;
        b=hbDkwMGUuGI7AWKiZ6kN21LdrjPJva1YESeK5I348dGp+vB654HZMlOMBGgn6zvOpG
         Gj82lIsNfGvIJkrI7tjpaLW0XawC3xNms0DDWbiDOK09ypl4ptj7dnuvv0jsXepFX7uR
         pr2Rw8XXrn9ZZchusF6OIZQp+ZX4pzGTOrXKcXvib1NemUGc8i5Lp/xqgh55eU7afBDo
         8TURcODhZpKh2Hfwy9bye+/qxHSqOaES3YprkKyK12kUxYGj3YMtQOG86Xl/7K/+N/h6
         eL3NBp/ET4uTqBcAsTFoGIy1yuAoSt//4bEBOuKdPbEjdgr7iFFb97Csn2u5WHivj6nR
         zpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698489084; x=1699093884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2GySqZOk9lw/mCBfX2becssT8j/7QRVN5jjdGNKoi8=;
        b=TTDvv1HHtbjpb3JwedVPjFji/2rYQ/8E9deXi71vxCPQwYEJXHoRLhOmrvUnGhIm2x
         OezYA52usnvZai/NBHAsyJ8MXDhii7FHsC0hnrrbSdwbt0Oh562lgtNZ6Xs+9nZ+Ftis
         dBIUroNVDOBm+CLDqt9DJmXxiGj0EP4a9ycYd1ls5AIRwJAs/3y12sIRgurGvpWyfY5j
         YLoMirvds/VV71JVPc9LGg+i5X9b3RAFSXK1tieZgvGWWACIeN+8xoAcGL9allXjxxux
         bRUFxUq0KcUo3Mych5M6+3g6KZ83t+PVBrH4d16eE5J3Oj2wccX74WKyXfZ0ClwTTeYh
         Q9RQ==
X-Gm-Message-State: AOJu0Yx4j0LXkgCoaGqdRm25T67oCGtR3UVcfMFZgwmm9ivXGnnBnJvj
        196/Xtdwd6DLnxbFfDE+oHg=
X-Google-Smtp-Source: AGHT+IENXe2JAUJizchzMKP3yhyuleg8xkzi7EggQ3PMszAhQY54bt/d08+l5jxF4PsiGpkKG9VrWg==
X-Received: by 2002:a05:6a00:468c:b0:6be:4b10:b27d with SMTP id de12-20020a056a00468c00b006be4b10b27dmr5453347pfb.0.1698489084072;
        Sat, 28 Oct 2023 03:31:24 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b006979f70fdd5sm2678492pfh.219.2023.10.28.03.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 03:31:23 -0700 (PDT)
Message-ID: <1abcad65-5367-44e0-8000-11feec1015e8@gmail.com>
Date:   Sat, 28 Oct 2023 16:01:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
To:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231027122221.GA24128@redhat.com>
 <20231028102247.404488-1-singhabhinav9051571833@gmail.com>
Content-Language: en-US
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231028102247.404488-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/23 15:52, Abhinav Singh wrote:
> This patch fixes the warning about directly dereferencing a pointer
> tagged with __rcu annotation.
> 
> Dereferencing the pointers tagged with __rcu directly should
> always be avoided according to the docs. There is a rcu helper
> function rcu_dereference(...) to use when dereferencing a __rcu
> pointer. This function returns the non __rcu tagged pointer which
> can be dereferenced just like a normal pointer.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
> v1 -> v2 : added rcu_dereference(...) at line 2694
> v2 -> v3 : added rcu_dereference(...) at line 2695
> 
>   kernel/fork.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..e78649974669 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2369,7 +2369,7 @@ __latent_entropy struct task_struct *copy_process(
>   
>   	retval = -EAGAIN;
>   	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> -		if (p->real_cred->user != INIT_USER &&
> +		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
>   		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>   			goto bad_fork_cleanup_count;
>   	}
> @@ -2690,9 +2690,9 @@ __latent_entropy struct task_struct *copy_process(
>   			 * tasklist_lock with adding child to the process tree
>   			 * for propagate_has_child_subreaper optimization.
>   			 */
> -			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
> -							 p->real_parent->signal->is_child_subreaper;
> -			list_add_tail(&p->sibling, &p->real_parent->children);
> +			p->signal->has_child_subreaper = rcu_dereference(p->real_parent)->signal->has_child_subreaper ||
> +							rcu_dereference(p->real_parent)->signal->is_child_subreaper;
> +			list_add_tail(&p->sibling, &rcu_dereference(p->real_parent)->children);
>   			list_add_tail_rcu(&p->tasks, &init_task.tasks);
>   			attach_pid(p, PIDTYPE_TGID);
>   			attach_pid(p, PIDTYPE_PGID);

I tested the above with these two config enabled, CONFIG_PROVE_LOCKING 
and CONFIG_PROVE_RCU. In qemu it booted fine without any issues. I then 
checked dmesg log (inside booted qemu envirnoment) for any issues with 
rcu, but didnt get any error or warning.

I didnt receive any warning message "suspicious rcu_dereference_check() 
usage" atleast from sparse tool or in the dmesg log as suggested by Oleg 
Nesterov.
