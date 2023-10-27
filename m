Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81F07D8EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjJ0GmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:42:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F721B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:41:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bb744262caso429452b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698388919; x=1698993719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRyFJrR5fk8DHlbv1dDr6nCLPbHAmO3CAZkM/W8M2k8=;
        b=MRcMCl8WWv9tTvpaDNBzLQTDVmSgr2zB/wlp7kD4QWoSzNyAm0N1qvrwnxxDOsdVFt
         ArEv7D4iC0r/pVfh83pwHZ+dgWSsZuh73y8nBiCvbFaSDcJvmVfcDr3jaFAJ1iohrnB7
         E3sVj6vx4oSv+smGWIWD1Y8dGv3QYSJATu48vHRu5VJaJKRvQg9ux7Tdy1zLBNOKf76h
         gHVUPOveuyU0tFt6+T7CsyYGueG5Mxho6DdI3sSvqPWjW6u/zXzD8v4hr8TDLSEzWy+4
         HJPwIIAXSqUmPoz1lVlrkdpHmBya/XbwXkxdMlirdVAXd/DccOynfqJ6YijxaSp3cenJ
         Bz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698388919; x=1698993719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRyFJrR5fk8DHlbv1dDr6nCLPbHAmO3CAZkM/W8M2k8=;
        b=HUFz3gXkzrrdIOnBlgUBL1J3CY75BFsUAYptm69S0DrHZ14GI72jo/HtyQg9ewx3+w
         qgSvfHTyf1PDIkHkyYrhnnlt9/qv5QRd2Wz0Zj2JuBoQzfYDtJ/dk9X7z2VFWsipbjXH
         k0FH1D/fnk9taWB6QHd2DyOD8ZOWCOZtvRYxh3R3npHJapZxVxMkFNAo0gQWp1rIHT9d
         s5glp9f3n84E59wCy5V/zsU6g3xL3kPoKZsoEMgqSgnHrzD5NEMm58a/yM8hiHmin20I
         d6m/uMbmDzkitLL6Wauww4hXr4vl0zlSjKEoXCexnARj1zDr129sUzYmohmW7FX5+qHv
         tkRA==
X-Gm-Message-State: AOJu0YxlQPXSgXQMQxxlv7d9S+2q7bs+c/DrvkiBOtEjbEP1iZE7nP78
        fgVy0ptAHwU+Fipz4KDv6IU=
X-Google-Smtp-Source: AGHT+IHTG0/c51ndfUiYZV4hFH3T5sfIrOIwAUktBI/XNiC+oUTVEfSvUdl+e2E+ZuVWkL3BayVh0g==
X-Received: by 2002:a05:6a20:440d:b0:163:ab09:195d with SMTP id ce13-20020a056a20440d00b00163ab09195dmr2371620pzb.0.1698388919131;
        Thu, 26 Oct 2023 23:41:59 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id t6-20020a62d146000000b006babcf86b84sm678650pfl.34.2023.10.26.23.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 23:41:58 -0700 (PDT)
Message-ID: <db40353c-bee5-491c-b301-f994258ed0f9@gmail.com>
Date:   Fri, 27 Oct 2023 12:11:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
Content-Language: en-US
To:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231026114632-mutt-send-email-mst@kernel.org>
 <20231027063713.1018624-1-singhabhinav9051571833@gmail.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231027063713.1018624-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 12:07, Abhinav Singh wrote:
> This patch fixes the warning about directly dereferencing a pointer
> tagged with __rcu annotation.
> 
> Dereferencing the pointers tagged with __rcu directly should
> always be avoided according to the docs. There is a rcu helper
> functions rcu_dereference(...) to use when dereferencing a __rcu
> pointer. This functions returns the non __rcu tagged pointer which
> can be dereferenced just like a normal pointers.
> 
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
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

For this particular file I have resolved the rcu pointer dereferencing 
issue and I have tested the above by using qemu using this command
qemu-system-x86_64 \
	-m 2G \
	-smp 2 \
	-kernel /home/abhinav/linux_work/linux/arch/x86/boot/bzImage \
	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
	-drive file=/home/abhinav/linux_work/boot_images/bullseye.img,format=raw \
	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
	-net nic,model=e1000 \
	-enable-kvm \
	-nographic \
	-pidfile vm.pid \
	2>&1 | tee vm.log
it booted without any issues.
