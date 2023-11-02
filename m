Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3E7DF293
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376351AbjKBMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347560AbjKBMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:37:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C781BF3;
        Thu,  2 Nov 2023 05:35:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507e85ebf50so1020968e87.1;
        Thu, 02 Nov 2023 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698928557; x=1699533357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ycHC9t4aBDz5P3W5PSRGotv4gN4GK5BqX9k1EeEI2U=;
        b=fEwtoU2LLo+v++SpLGDaAiCJf0ILYIiJI+zhxWiXwHqUEbrnFWRGYtQFfTEmLm3M7q
         IW27LCmcuJXFHuWQBl+MNX6yZC8NgrhxlOrvgpPmcoFDvu0w2XGCnjJkk/DT9neY1eLX
         UUgFmGlLgMoFG0zid6s3C+X1OltMkocChSBXX8UeBuMFwOW89U5YqbD0YtWluFvbzktP
         pJ1KKffyY4rXviRJT/bKrOIFnaNEkVIvywe3HaEhUc/lJrBuSCl/pRzBSH+6TmBV+iwu
         dvG/E2oMwGOMSAYRWzhjPbPA3yxH1hKX3/BRLj6p12ydhL1vnKvVe/F2VzKm6jBy9mEE
         Buzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698928557; x=1699533357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ycHC9t4aBDz5P3W5PSRGotv4gN4GK5BqX9k1EeEI2U=;
        b=GhFzSNWrJZbVMQMfQ8M/p3z+a2/tKUxHI2ePtd+k0AQB04ehr2aUUhQisjapuQ40Em
         vHGX9U2lRHFezQ/5NrrqllvgNsmCFsUEe7plBLdmZeV6kWEThhxRnZN63u8zYSKOVBGo
         qDnc3uVMWmMOoN+54tgDg5WiWp4IDYy0od8Rae2dqWiMJndn/RH4sv8imgjRc9UiLghT
         VHjx7jtJrtqylkKIP74K8pvpUtsmrxfjGa5pEPS0XhYuPp3gxQhCwTlDzu0UIk5EHvJp
         VrT9VU4n7aL7vn2CQymxJ3lx3O4aQ5WPOFOLB0Z5qevcqfJr0M2s3sogKBF34hfA1Zw8
         i+CA==
X-Gm-Message-State: AOJu0Yy5DDPCUrOj0BrN95NbQ/gBhV0gOaZ9RfD519ztxDMRoitQoBjR
        Dv3JYKTFfLTqdGzVtA0IrRs=
X-Google-Smtp-Source: AGHT+IGko239uyGK9V1EsPMGR4aXETRRj1yX0KwkcNIV5/pSA+0DjOSC3yTjfweMk8QtMFHqFhMsFA==
X-Received: by 2002:a05:6512:3b23:b0:4fb:7559:aea3 with SMTP id f35-20020a0565123b2300b004fb7559aea3mr18758934lfv.39.1698928556254;
        Thu, 02 Nov 2023 05:35:56 -0700 (PDT)
Received: from pc636 (host-90-233-220-95.mobileonline.telia.com. [90.233.220.95])
        by smtp.gmail.com with ESMTPSA id a26-20020a195f5a000000b005094535b277sm270675lfj.215.2023.11.02.05.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:35:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 2 Nov 2023 13:35:52 +0100
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZUOXqN3Ja0W3fRYI@pc636>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
 <ZTlNogQ_nWUzVJ9M@boqun-archlinux>
 <ZTpk7gvIgdHioL3c@pc636>
 <ZT6ilzH0HQNFLb2Y@boqun-archlinux>
 <ZUIpfzEt_rpTAS8T@pc636>
 <ZUJwKXcjK0064zkb@pc636>
 <ZUL1qEOV8QBHVFHP@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUL1qEOV8QBHVFHP@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 06:04:40PM -0700, Boqun Feng wrote:
> On Wed, Nov 01, 2023 at 04:35:05PM +0100, Uladzislau Rezki wrote:
> [...]
> > > Basically it does not work, because you do not fix the mixing "issue".
> > > I have been working on it and we agreed to separate it. Because it is
> > > just makes sense. The reason and the problem i see, i described in the
> > > commit message of v2.
> 
> As I understand it, your point is "if we want synchronize_rcu() faster
> in all the cases, then a separate list makes a lot of sense since it
> won't be affected by different configs and etc.", right? If so, then
> understood.
> 
Indeed. That was the reason. Since the call is blocked a waiter can to
do the job until it is done!

> I don't have any problem on that your patch does a good work on making
> synchronize_rcu() faster, and actually I don't think my proposal
> necessarily blocks your patch. However, I wonder: why synchronize_rcu()
> is more special than other call_rcu_hurry() cases? Sure,
> synchronize_rcu() means blocking and unblocking ealier is always
> desirable, but call_rcu_hurry() could also queue a callback that wake
> up other thread, right? By making synchronize_rcu() faster, do we end up
> making other call_rcu_hurry() slow? So in my proposal, as you can see,
> I tried to be fair among all call_rcu_hurry() users, and hope that's
> a better solution from the whole kernel viewpoint.
> 
The sync call blocks the caller, as you noted. I agree with you that
your proposal does not block my work and that is good, otherwise it is
just pointless doing one thing separately. As for your proposal, hurry
callbacks are also important for LAZY configuration because for !LAZY
all of them are hurry.

For LAZY it makes sense to me to start executing the ones which are
hurry! It would be good to analyze it more.

So i agree with you.

> Also another fear I have is the following story:
> 
> (Let say your improvement gets merged. And 6 months later)
> 
> Someone shows up and say "hi, the synchronize_rcu() latency reduce work
> is great, but we have 1024 CPUs, so the single list in sr_normal_state
> becomes a bottleneck, synchronize_rcu() on some CPUs gets delayed by
> other CPU's synchronize_rcu(), can we make the list percpu?"
> 
> (And 6 months later)
> 
> Someone shows up and say "hi, the percpu list for low latency
> synchronize_rcu() is great, however, we want to save some CPU power by
> putting CPUs into groups and naming one leader of each group to handle
> synchronize_rcu() wakeups for the whole group, let's use kconfig
> CONFIG_RCU_NOSR_CPU to control that feature"
> 
> Well, it's a story, so it may not happen, but I don't think the
> possiblity of totally re-inventing RCU callback lists and NOCB is 0 ;-)
> 
I have tested 60K doing synchronize_rcu() and it still wins. That was
just data. But to be honest i do not consider such scenario to be ever
happen. I do not want to speculate here.

>
> Anyway, I should stop being annoying here, I will use your test steps to
> check my idea, and will let you know!
>
Well, no problem. Let's focus on testing :)

1st test case is to check kvfree_rcu_mightsleep() slow path and improve it:

<snip>
...
	/*
	 * Inline kvfree() after synchronize_rcu(). We can do
	 * it from might_sleep() context only, so the current
	 * CPU can pass the QS state.
	 */
	if (!success) {
		debug_rcu_head_unqueue((struct rcu_head *) ptr);
		synchronize_rcu();
		kvfree(ptr);
	}
}
EXPORT_SYMBOL_GPL(kvfree_call_rcu);
<snip>

as we might hit it if low memory condition. See below the steps how i test:

Apply below patch:

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 189975f57e78..92a5cf6c0441 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3492,8 +3492,11 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	 * only. For other places please embed an rcu_head to
 	 * your data.
 	 */
-	if (!head)
+	if (!head) {
 		might_sleep();
+		success = false;
+		goto sync_kvfree;
+	}
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
@@ -3531,6 +3534,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
 
+sync_kvfree:
 	/*
 	 * Inline kvfree() after synchronize_rcu(). We can do
 	 * it from might_sleep() context only, so the current
<snip>

so we are reverted into a slow path always. To test it i use test_vmalloc.sh
test-suite as it contains single/double argument tests. It is located at the
./coding/linux.git/tools/testing/selftests/vm/.

<snip>
urezki@pc638:~$ sudo ./test_vmalloc.sh
...
parm:           use_huge:Use vmalloc_huge in fix_size_alloc_test (bool)
parm:           run_test_mask:Set tests specified in the mask.

                id: 1,    name: fix_size_alloc_test
                id: 2,    name: full_fit_alloc_test
                id: 4,    name: long_busy_list_alloc_test
                id: 8,    name: random_size_alloc_test
                id: 16,   name: fix_align_alloc_test
                id: 32,   name: random_size_align_alloc_test
                id: 64,   name: align_shift_alloc_test
                id: 128,  name: pcpu_alloc_test
                id: 256,  name: kvfree_rcu_1_arg_vmalloc_test
                id: 512,  name: kvfree_rcu_2_arg_vmalloc_test
                id: 1024, name: vm_map_ram_test
...
<snip>

256 is what we need. So run it. Example:

sudo ./test_vmalloc.sh run_test_mask=256 nr_threads=20 test_loop_count=1000

mask - is only our test case, nr_threads - number of worker doing single-kvfree
and each worker does it 1000 times.

Once it is completed you type "dmesg" to see the results. You will see
how many CPU cycles test took.

2. Also you can measure latency/duration of synchronize_rcu() using ftrace:

<snip>
root@pc638:/sys/kernel/debug/tracing# cat available_tracers 
blk mmiotrace function_graph function nop
root@pc638:/sys/kernel/debug/tracing# echo function_graph > current_tracer 
root@pc638:/sys/kernel/debug/tracing# cat current_tracer 
function_graph
root@pc638:/sys/kernel/debug/tracing# echo synchronize_rcu_normal > ./set_ftrace_filter 
root@pc638:/sys/kernel/debug/tracing# cat set_ftrace_filter 
synchronize_rcu_normal
root@pc638:/sys/kernel/debug/tracing# echo synchronize_rcu_normal > set_graph_function
root@pc638:/sys/kernel/debug/tracing#
<snip>

Run above test to see the duration. You will get a lot of data which
i usually plot for visualization.

3. Also i am testing loading a kernel modules, first 100:

<snip>
urezki@pc638:~$ cat load_modules.sh
#!/bin/bash

# Exclude test_vmalloc.ko
MODULES_LIST=(`find /lib/modules/$(uname -r) -type f \
        \( -iname "*.ko" -not -iname "test_vmalloc*" \) | awk -F"/" '{print $NF}' | sed 's/.ko//'`)

function moduleExist(){
        MODULE="$1"
        if lsmod | grep "$MODULE" &> /dev/null ; then
                return 0
        else
                return 1
        fi
}

i=0

for module_name in ${MODULES_LIST[@]}; do
        sudo modprobe $module_name

        if moduleExist ${module_name}; then
                ((i=i+1))
        fi

        if [ $i -eq 100 ]; then
                echo "Done 100 loading!"
                exit 0
        fi
done
urezki@pc638:~$
<snip>

time ./load_modules.sh to compare. I run it under qemu and usually i run Debian there.

4. Camera use case is what i also check since its launch time is important
for end user. I think you need some extra setup to perform it, so i skip it.

--
Uladzislau Rezki
