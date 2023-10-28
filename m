Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0F27DA958
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJ1Unt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjJ1Unr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:43:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C6FB8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:43:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc13149621so5974115ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698525825; x=1699130625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ceYIwJI5/04/uPSpsws6LLcq3g+qs0ox6bPNsl8T5AI=;
        b=AqgQk4YZ1Sgnot76rwbIsRHFnE8RvPi68jg7ZiLKxijqSDgXc+PLeJS+nf6oulSPaJ
         b1xz4qhgBpMo9cz5DtmDgqrp65iBwygF3U4RAy5NZSp0eM5mzmLSaajHLFKfUgGRY17c
         A8o7coKn9HjdSCGiiU8AB8FykvzJPKpJceXfQFx5l9tIBqwbPXiWecEJMc58Jg0/U1qn
         Ftp7RLgHkHlhtq+cZRBE2gZaOEWgXCs9LJAxYXOtmHI2cREkYsY2SZLzAKiQDx7U/oFW
         x5IdJqi6GYfztYcsOjYnxv/FpAe4KvrpMWEM64D9+pSaC/UcqnsREaZKKirM7J6pIyXH
         xGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698525825; x=1699130625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ceYIwJI5/04/uPSpsws6LLcq3g+qs0ox6bPNsl8T5AI=;
        b=sj3hzRJKHWNcSuTzv0VJwW0BSe4cwm655KNYXnMdFJooWp1qR9sGPO2sleKumrTiY9
         p7GsfeHn4o/3yV2jldutl8AzLC9nuyJQ2PirkAitmlFkIFQOsPwsOu6qNslLGIMPUVIV
         DeIByrInIzGN17ghuw20Zzd4jaPWXgIq3HdptHfK/LqHScxI/JFUl2L6+q0vmrG34OuV
         QzO9GCF1/oUGmAexL0enWuHYW4U6LWzGDuWut1UwhR5Yxi7oq39KP1aCBFLQTBhk0B8X
         CuCKAJXO+6iXqudQnKtXjy2qQynumobHBfoffsdy/cEo6iVadtz+qShinAHed/gwZ8aa
         8P6Q==
X-Gm-Message-State: AOJu0Yw7p/tHcAI8zqbC6JaXHSIxst/oZQaPvq8641z/KJLFjyr884Yk
        rDwpxCLQM4UYO1YDc52km54=
X-Google-Smtp-Source: AGHT+IFJDgTO4GC29uJeMqClXt7FNH3XB7LXD899DW+Fr3mNR0Vlq1ylhWgG38hY5tD6bpvYyYIPpg==
X-Received: by 2002:a17:90b:4cd0:b0:27d:2261:73e4 with SMTP id nd16-20020a17090b4cd000b0027d226173e4mr6010666pjb.2.1698525824814;
        Sat, 28 Oct 2023 13:43:44 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id x8-20020a17090a164800b00278ff752eacsm3362690pje.50.2023.10.28.13.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 13:43:44 -0700 (PDT)
Message-ID: <93115738-6919-4855-81b7-eb9b2fc60137@gmail.com>
Date:   Sun, 29 Oct 2023 02:13:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, shakeelb@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231027122221.GA24128@redhat.com>
 <20231028102247.404488-1-singhabhinav9051571833@gmail.com>
 <20231028081915-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231028081915-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/23 17:50, Michael S. Tsirkin wrote:
> On Sat, Oct 28, 2023 at 03:52:47PM +0530, Abhinav Singh wrote:
>> This patch fixes the warning about directly dereferencing a pointer
>> tagged with __rcu annotation.
>>
>> Dereferencing the pointers tagged with __rcu directly should
>> always be avoided according to the docs. There is a rcu helper
>> function rcu_dereference(...) to use when dereferencing a __rcu
>> pointer. This function returns the non __rcu tagged pointer which
>> can be dereferenced just like a normal pointer.
>>
>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>> ---
>> v1 -> v2 : added rcu_dereference(...) at line 2694
>> v2 -> v3 : added rcu_dereference(...) at line 2695
>>
>>   kernel/fork.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 10917c3e1f03..e78649974669 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -2369,7 +2369,7 @@ __latent_entropy struct task_struct *copy_process(
>>   
>>   	retval = -EAGAIN;
>>   	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
>> -		if (p->real_cred->user != INIT_USER &&
>> +		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
>>   		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>>   			goto bad_fork_cleanup_count;
>>   	}
>> @@ -2690,9 +2690,9 @@ __latent_entropy struct task_struct *copy_process(
>>   			 * tasklist_lock with adding child to the process tree
>>   			 * for propagate_has_child_subreaper optimization.
>>   			 */
>> -			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
>> -							 p->real_parent->signal->is_child_subreaper;
>> -			list_add_tail(&p->sibling, &p->real_parent->children);
>> +			p->signal->has_child_subreaper = rcu_dereference(p->real_parent)->signal->has_child_subreaper ||
>> +							rcu_dereference(p->real_parent)->signal->is_child_subreaper;
>> +			list_add_tail(&p->sibling, &rcu_dereference(p->real_parent)->children);
>>   			list_add_tail_rcu(&p->tasks, &init_task.tasks);
>>   			attach_pid(p, PIDTYPE_TGID);
>>   			attach_pid(p, PIDTYPE_PGID);
>> -- 
>> 2.39.2
> 
> 
> You seem to just ignore review comments. NAK. I'm not going to review this anymore.
> 
> 
I m really sorry for ignorance and careless behaviour. This is 
completely my fault, a maintainer has to do a lot of work and he cant 
correct me all the times. On my defense I will only say that I was 
really confused about a thing, instead of asking you question, I thought 
of sending in another patch with some more information is a better 
choice then a clearing my confusion by sending in a extra mail. You were 
very concise and clear about your comments but MY stupidity was on 
another level today. I m sorry for ignorant behaviour. And also thanks 
and appreciate a lot for reviewing this patch till now to all the 
maintainers.

Not sure if this patch will be reviewed again or not, but I think I 
should answer the queries.

The last patch I sent, I tested with `lockdep` on (I hope "test with 
`lockdep on`" means booting the kernel with lockdep enabled),
with these config options `CONFIG_PROVE_RCU` and `CONFIG_PROVE_LOCKING` 
enabled and it booted just fine. To confirm if lockdep was really 
enabled I found these paths inside the qemu virtual envirnoment
/proc/lockdep
/proc/lockdep_chains
/proc/lockdep_stat
/proc/locks
/proc/lock_stats

I tested the above kernel using qemu with this command
qemu-system-x86_64 \
	-m 2G \
	-smp 2 \
	-kernel /home/abhinav/linux_work/linux/arch/x86/boot/bzImage \
	-append "console=ttyS0 root=/dev/sda earlyprintk=serial   net.ifnames=0" \
	-drive file=/home/abhinav/linux_work/boot_images/bullseye.img,format=raw \
	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
	-net nic,model=e1000 \
	-enable-kvm \
	-nographic \
	-pidfile vm.pid \
	2>&1 | tee vm.log

I did not get warning `the run-time "suspicious rcu_dereference_check() 
usage"` as mentioned by Oleg Nesterov, which mean rcu_dereference(...) 
it called inside of rcu read side critical sections.




