Return-Path: <linux-kernel+bounces-59737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D408C84FB15
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BB61F228D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9833D7EEE1;
	Fri,  9 Feb 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LMkXoETo"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B97D3ED;
	Fri,  9 Feb 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500018; cv=none; b=tyWf4KI+eTq5cvLP9qj4O8CYEn4jHha5eQjSJOFZWbAicoU670jZQu72fgpjgqs3yuGIy/plevr4ZZNIlj3Dnm4N2F1Y+fntOz9c29XuscSlWJ04Qc+PPl+EP9744MCDILj/URPH6H5b5ol8BRWswx+EJ5UpLOq4VqtwOkwZ5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500018; c=relaxed/simple;
	bh=gRsWK/GkajKhOJJ1Oasekq01cmiA62SI2xSA6/HKzFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/gw49tHhyivgdn6LJjXoZhNIJTcxSVwe8intapONYmgA+ajTkDw7cjJOOuSglshTEAS8l1RC2EP29Rd9vN8pKW5GGycikhlHUhMEZBNPL9aka0nMUwcRes4f86dAWW9GOYp3X+j5Jg+I9+ODyhPapncrDdGaNTFR3lBcJSk2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LMkXoETo; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7715141D30;
	Fri,  9 Feb 2024 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707500003;
	bh=AqfFlASLWtSjOdxvopqeJb6zy1f5u9smqX1GloLEiY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=LMkXoEToh4KFIT1Zz3nwqqske6GdHf0X/2yZy2WbyoUT1Dci19ZIjI3qe2hnPj8JX
	 YyrJtYiCR3EEzt2jU/r3rwyAfeJlf7WlwqVw+yjVeMswAXxqmyU+Nnh00MoXQD752I
	 o/gvrae0on0u9MzjSbPlE400NUrkZDVzcxHaAuGLjlPocuTBQlWFs8WPuR4A1CEDc/
	 b356YmO73UwRL9TiMVY1LCq6+hnyisfMVeoFRCDQUxb7YuN2/IVpPVUrBQHMpmsAT8
	 BhMvbt2bF1wDyaIBjOY+Y7bUTFOodeaWqHBl8GcGWsrEFRScw4CIC+IB5WN+Vw4jbt
	 wzZIHXHVSNS4w==
Message-ID: <4871a305-5d45-47d2-85f2-d718c423db80@canonical.com>
Date: Fri, 9 Feb 2024 09:33:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/9] Nginx refcount scalability issue with Apparmor enabled
 and potential solutions
Content-Language: en-US
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Shukla, Santosh" <Santosh.Shukla@amd.com>,
 "Narayan, Ananth" <Ananth.Narayan@amd.com>,
 raghavendra.kodsarathimmappa@amd.com, koverstreet@google.com,
 paulmck@kernel.org, boqun.feng@gmail.com, vinicius.gomes@intel.com,
 mjguzik@gmail.com
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
 <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/24 20:40, Neeraj Upadhyay wrote:
> Gentle ping.
>   
> John,
> 
> Could you please confirm that:
> 
> a. The AppArmor refcount usage described in the RFC is correct?
> b. Approach taken to fix the scalability issue is valid/correct?
> 

Hi Neeraj,

I know your patchset has been waiting on review for a long time.
Unfortunately I have been very, very busy lately. I will try to
get to it this weekend, but I can't promise that I will be able
to get the review fully done.

john


> 
> On 1/10/2024 4:41 PM, Neeraj Upadhyay wrote:
>> Problem Statement
>> =================
>>
>> Nginx performance testing with Apparmor enabled (with nginx
>> running in unconfined profile), on kernel versions 6.1 and 6.5
>> show significant drop in throughput scalability, when Nginx
>> workers are scaled to higher number of CPUs across various
>> L3 cache domains.
>>
>> Below is one sample data on the throughput scalability loss,
>> based on results on AMD Zen4 system with 96 CPUs with SMT
>> core count 2; so, overall, 192 CPUs:
>>
>> Config      Cache Domains     apparmor=off        apparmor=on
>>                               scaling eff (%)      scaling eff (%)
>> 8C16T          1                  100%             100%
>> 16C32T         2                   95%              94%
>> 24C48T         3                   94%              93%
>> 48C96T         6                   92%              88%
>> 96C192T        12                  85%              68%
>>
>> If we look at above data, there is a significant drop in
>> scaling efficiency, when we move to 96 CPUs/192 SMT threads.
>>
>> Perf tool shows most of the contention coming from below
>> 6.56%     nginx  [kernel.vmlinux]      [k] apparmor_current_getsecid_subj
>> 6.22%     nginx  [kernel.vmlinux]      [k] apparmor_file_open
>>
>> The majority of the CPU cycles is found to be due to memory contention
>> in atomic_fetch_add and atomic_fetch_sub operations from kref_get() and
>> kref_put() operations on label.
>>
>> Commit 2516fde1fa00 ("apparmor: Optimize retrieving current task secid"),
>> from 6.7 alleviates the issue to an extent, but not completely:
>>
>> Config      Cache Domains     apparmor=on        apparmor=on (patched)
>>                               scaling eff (%)      scaling eff (%)
>> 8C16T          1                  100%             100%
>> 16C32T         2                   97%              93%
>> 24C48T         3                   94%              92%
>> 48C96T         6                   88%              88%
>> 96C192T        12                  65%              79%
>>
>> This adverse impact gets more pronounced when we move to >192 CPUs.
>> The memory contention and impact increases with high frequency label
>> update operations and labels are marked stale more frequently.
>>
>>
>> Label Refcount Management
>> =========================
>>
>> Apparmor uses label objects (struct aa_label) to manage refcounts for
>> below set of objects:
>>
>> - Applicable profiles
>> - Namespaces (unconfined profile)
>> - Other non-profile references
>>
>> These label references are acquired on various apparmor lsm hooks,
>> on operations such as file open, task kill operations, socket bind,
>> and other file, socket, misc operations which use current task's cred,
>> when the label for the current cred, has been marked stale. This is
>> done to check these operations against the set of allowed operations
>> for the task performing them.
>>
>> Use Percpu refcount for ref management?
>> =======================================
>>
>> The ref put operations (percpu_ref_put()) in percpu refcount,
>> in active mode, do not check whether ref count has dropped to
>> 0. The users of the percpu_ref need to explicitly invoke
>> a percpu_ref_kill() operation, to drop the initial reference,
>> at shutdown paths. After the percpu_ref_kill() operation, ref
>> switches to atomic mode and any new percpu_ref_put() operation
>> checks for the drop to 0 case and invokes the release operation
>> on that label.
>>
>> Labels are marked stale is situations like profile removal,
>> profile updates. For a namespace, the unconfined label reference
>> is dropped when the namespace is destroyed. These points
>> are potential shutdown points for labels. However, killing
>> the percpu ref from these points has few issues:
>>
>> - The label could still be referenced by tasks, which are
>>    still holding the reference to the now stale label.
>>    Killing the label ref while these operations are in progress
>>    will make all subsequent ref-put operations on the stale label
>>    to be atomic, which would still result in memory contention.
>>    Also, any new reference to the stale label, which is acquired
>>    with the elevated refcount will have atomic op contention.
>>
>> - The label is marked stale using a non-atomic write operation.
>>    It is possible that new operations do not observe this flag
>>    and still reference it for quite some time.
>>
>> - Explicitly tracking the shutdown points might not be maintainable
>>    at a per label granularity, as there can be various paths where
>>    label reference could get dropped, such as, before the label has
>>    gone live - object initialization error paths. Also, tracking
>>    the shutdown points for labels which reference other labels -
>>    subprofiles, merged labels requires careful analysis, and adds
>>    heavy burden on ensuring the memory contention is not introduced
>>    by these ref kill points.
>>
>>
>> Proposed Solution
>> =================
>>
>> One potential solution to the refcount scalability problem is to
>> convert the label refcount to a percpu refcount, and manage
>> the initial reference from kworker context. The kworker
>> keeps an extra reference to the label and periodically scans
>> labels and release them if their refcount drops to 0.
>>
>> Below is the sequence of operations, which shows the refcount
>> management with this approach:
>>
>> 1. During label initialization, the percpu ref is initialized in
>>     atomic mode. This is done to ensure that, for cases where the
>>     label hasn't gone live (->ns isn't assigned), mostly during
>>     initialization error paths.
>>
>> 2. Labels are switched to percpu mode at various points -
>>     when a label is added to labelset tree, when a unconfined profile
>>     has been assigned a namespace.
>>
>> 3. As part of the initial prototype, only the in tree labels
>>     are managed by the kworker. These labels are added to a lockless
>>     list. The unconfined labels invoke a percpu_ref_kill() operation
>>     when the namespace is destroyed.
>>
>> 4. The kworker does a periodic scan of all the labels in the
>>     llist. It does below sequence of operations:
>>
>>     a. Enqueue a dummy node to mark the start of scan. This dummy
>>        node is used as start point of scan and ensures that we
>>        there is no additional synchronization required with new
>>        label node additions to the llist. Any new labels will
>>        be processed in next run of the kworker.
>>
>>                        SCAN START PTR
>>                            |
>>                            v
>>        +----------+     +------+    +------+    +------+
>>        |          |     |      |    |      |    |      |
>>        |   head   ------> dummy|--->|label |--->| label|--->NULL
>>        |          |     | node |    |      |    |      |
>>        +----------+     +------+    +------+    +------+
>>
>>
>>        New label addition:
>>
>>                              SCAN START PTR
>>                                   |
>>                                   v
>>        +----------+  +------+  +------+    +------+    +------+
>>        |          |  |      |  |      |    |      |    |      |
>>        |   head   |--> label|--> dummy|--->|label |--->| label|--->NULL
>>        |          |  |      |  | node |    |      |    |      |
>>        +----------+  +------+  +------+    +------+    +------+
>>
>>      b. Traverse through the llist, starting from dummy->next.
>>         If the node is a dummy node, mark it free.
>>         If the node is a label node, do,
>>
>>         i) Switch the label ref to atomic mode. The ref switch wait
>>            for the existing percpu_ref_get() and percpu_ref_put()
>>            operations to complete, by waiting for a RCU grace period.
>>
>>            Once the switch is complete, from this point onwards, any
>>            percpu_ref_get(), percpu_ref_put() operations use
>>            atomic operations.
>>
>>        ii) Drop the initial reference, which was taken while adding
>>            the label node to the llist.
>>
>>       iii) Use a percpu_ref_tryget() increment operation on the
>>            ref, to see if we dropped the last ref count. if we
>>            dropped the last count, we remove the node from the llist.
>>
>>            All of these operations are done inside a RCU critical
>>            section, to avoid race with the release operations,
>>            which can potentially trigger, as soon as we drop
>>            the initial ref count.
>>
>>        iv) If we didn't drop the last ref, switch back the counter
>>            to percpu mode.
>>
>> Using this approach, to move the atomic refcount manipulation out of the
>> contended paths, there is a significant scalability improvement seen on
>> nginx test, and scalability efficiency is close to apparmor-off case.
>>
>> Config      Cache Domains     apparmor=on (percpuref)
>>                                 scaling eff (%)
>> 8C16T          1                  100%
>> 16C32T         2                   96%
>> 24C48T         3                   94%
>> 48C96T         6                   93%
>> 96C192T        12                  90%
>>
>> Limitations
>> ===========
>>
>> 1. Switching to percpu refcount increases memory size overhead, as
>>     percpu memory is allocated for all labels.
>>
>> 2. Deferring labels reclaim could potentially result in memory
>>     pressure, when there are high frequency of label update operations.
>>
>> 3. Percpu refcount uses call_rcu_hurry() to complete switch operations.
>>     These can impact energy efficiency, due to back to back hurry
>>     callbacks. Using deferrable workqueue partly mitigates this.
>>     However, deferring kworker can delay reclaims.
>>
>> 4. Back to back label switches can delay other percpu users, as
>>     there is a single global switch spinlock used by percpu refcount
>>     lib.
>>
>> 5. Long running kworker can delay other use cases like system suspend.
>>     This is mitigated using freezable workqueue and litming node
>>     scans to a max count.
>>
>> 6. There is a window where label operates is atomic mode, when its
>>     counter is being checked for zero. This can potentially result
>>     in high memory contention, during this window which spans RCU
>>     grace period (plus callback execution). For example, when
>>     scanning label corresponding to unconfined profile, all
>>     applications which use unconfined profile would be using
>>     atomic ref increment and decrement operations.
>>
>>     There are a few apparoaches which were tried to mitigate this issue:
>>
>>     a. At a lower time interval, check if scanned label's counter
>>        has changed since the start of label scan. If there is a change
>>        in count, terminate the switch to atomic mode. Below shows the
>>        apparoch using rcuwait.
>>
>>        static void aa_label_switch_atomic_confirm(struct percpu_ref *label_ref)
>>        {
>>           WRITE_ONCE(aa_atomic_switch_complete, true);
>>           rcuwait_wake_up(&aa_reclaim_rcuwait);
>>        }
>>
>>        rcuwait_init(&aa_reclaim_rcuwait);
>>        percpu_ref_switch_to_atomic(&label->count, aa_label_switch_atomic_confirm);
>>
>>        atomic_count = percpu_ref_count_read(&label->count);
>>        do {
>>          rcuwait_wait_event_timeout(&aa_reclaim_rcuwait,
>>                             (switch_complete = READ_ONCE(aa_atomic_switch_complete)),
>>                             TASK_IDLE,
>>                             msecs_to_jiffies(5));
>>          if (percpu_ref_count_read(&label->count) != atomic_count)
>>                  break;
>>         } while (!READ_ONCE(switch_complete));
>>
>>         However, this approach does not work, as percpu refcount lib does not
>>         allow termination of an ongoing switch operation. Also, the counter
>>         can return to the original value with set of get() and put() operations
>>         before we check the current value.
>>
>>     b. Approaches to notify the reclaim kworker from ref get and put operations
>>        can potentially disturb cache line state between the various CPU
>>        contexts, which are referncing the label, and can potentially impact
>>        scalability again.
>>
>>     c. Swith the label to an immortal percpu ref, while the scan operates
>>        on the current counter.
>>
>>        Below is the sequence of operations to do this:
>>
>>        1. Ensure that both immortal ref and label ref are in percpu mode.
>>           Reinit the immortal ref in percpu mode.
>>
>>           Swap percpu and atomic counters of label refcount and immortal ref
>> 	                          percpu-ref
>>        	                  +-------------------+
>>        +-------+           |  percpu-ctr-addr1 |
>>        | label | --------->|-------------------|    +----------------+
>>        +-------+           |   data            |--->| Atomic counter1|
>>                            +-------------------+    +----------------+
>>        +-------+           +-------------------+
>>        |ImmLbl |---------->|  percpu-ctr-addr2 |    +----------------+
>>        +-------+           |-------------------|--->| Atomic counter2|
>>                            |    data           |    +----------------+
>>                            +-------------------+
>>
>>            label ->percpu-ctr-addr  = percpu-ctr-addr2
>>            ImmLbl ->percpu-ctr-addr = percpu-ctr-addr1
>>            label ->data->count      = Atomic counter2
>>            ImmLbl ->data->count     = Atomic counter1
>>    
>>    
>>        2. Check the counters collected in immortal label, by switch it
>>           to atomic mode.
>>
>>        3. If the count is 0, do,
>>           a. Switch immortal counter to percpu again, giving it an
>>              initial count of 1.
>>           b. Swap the label and immortal counters again. The immortal
>>              ref now has the counter values from new percpu ref get
>>              and get operations on the label ref, from the point
>>              when we did the initial swap operation.
>>           c. Transfer the percpu counts in immortal ref to atomic
>>              counter of label percpu refcount.
>>           d. Kill immortal ref, for reinit on next iteration.
>>           e. Switch label percpu ref to atomic mode.
>>           f. If the counter is 1, drop the initial ref.
>>
>>         4. If the count is not 0, re-swap the counters.
>>            a. Switch immortal counter to percpu again, giving it an
>>               initial count of 1.
>>            b. Swap the label and immortal counters again. The immortal
>>               ref now has the counter values from new percpu ref get
>>               and get operations on the label ref, from the point
>>               when we did the initial swap operation.
>>            c. Transfer the percpu counts in immortal ref to atomic
>>               counter of label percpu refcount.
>>            d. Kill immortal ref, for reinit on next iteration.
>>
>>
>>            Using this approach, we ensure that, label ref users do not switch
>>            to atomic mode, while there are active references on the label.
>>            However, this approach requires multiple percpu ref mode switches
>>            and adds high overhead and complexity to the scanning code.
>>
>> Extended/Future Work
>> ====================
>>
>> 1. Look for ways to fix the limitations, as described in the "Limitations"
>>     section.
>>
>> 2. Generalize the approach to percpu rcuref, which is used for contexts
>>     where release path uses RCU grace period for release operations. Patch
>>     7 creates an initial prototype for this.
>>
>> 3. Explore hazard pointers for scalable refcounting of labels.
>>
>> Highly appreciate any feedback/suggestions on the design approach.
>>
>> The patches of this patchset introduce following changes:
>>
>> 1.      Documentation of Apparmor Refcount management.
>>
>> 2.      Switch labels to percpu refcount in atomic mode.
>>
>>          Use percpu refcount for apparmor labels. Initial patch to init
>>          the percpu ref in atomic mode, to evaluate the potential
>>          impact of percpuref on top of kref based implementation.
>>
>> 3.      Switch unconfined namespaces refcount to percpu mode.
>>
>>          Switch unconfined ns labels to percpu mode, and kill the
>>          initial refcount from namespace destroy path.
>>
>> 4.      Add infrastructure to reclaim percpu labels.
>>
>>          Add a label reclaim infrastructure for labels which are
>>          in percpu mode, for managing their inital refcount.
>>
>> 5.      Switch intree labels to percpu mode.
>>
>>          Use label reclaim infrastruture to manage intree labels.
>>
>> 6.      Initial prototype for optimizing ref switch.
>>
>>          Prototype for reducing the time window when a label
>>          scan switches the label ref to atomic mode.
>>
>> 7.      percpu-rcuref: Add basic infrastructure.
>>
>>          Prototype for Percpu refcounts for objects, which protect
>>          their object reclaims using RCU grace period.
>>
>> 8.      Switch labels to percpu rcurefcount in unmanaged mode.
>>
>>          Use percpu rcuref for labels. Start with unmanaged/atomic
>>          mode.
>>
>> 9.      Switch unconfined and in tree labels to managed ref mode.
>>
>>          Use percpu mode with manager worker for unconfined and intree
>>          labels.
>>
>>
>> ------------------------------------------------------------------------
>>
>>   b/Documentation/admin-guide/LSM/ApparmorRefcount.rst |  351 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   b/Documentation/admin-guide/LSM/index.rst            |    1
>>   b/Documentation/admin-guide/kernel-parameters.txt    |    8 +
>>   b/include/linux/percpu-rcurefcount.h                 |  115 ++++++++++++++++
>>   b/include/linux/percpu-refcount.h                    |    2
>>   b/lib/Makefile                                       |    2
>>   b/lib/percpu-rcurefcount.c                           |  336 +++++++++++++++++++++++++++++++++++++++++++++++
>>   b/lib/percpu-refcount.c                              |   93 +++++++++++++
>>   b/security/apparmor/include/label.h                  |   16 +-
>>   b/security/apparmor/include/policy.h                 |    8 -
>>   b/security/apparmor/include/policy_ns.h              |   24 +++
>>   b/security/apparmor/label.c                          |   11 +
>>   b/security/apparmor/lsm.c                            |  145 ++++++++++++++++++++
>>   b/security/apparmor/policy_ns.c                      |    6
>>   include/linux/percpu-refcount.h                      |    2
>>   lib/percpu-refcount.c                                |   93 -------------
>>   security/apparmor/include/label.h                    |   17 +-
>>   security/apparmor/include/policy.h                   |   56 +++----
>>   security/apparmor/include/policy_ns.h                |   24 ---
>>   security/apparmor/label.c                            |   11 -
>>   security/apparmor/lsm.c                              |  325 ++++++++++++----------------------------------
>>   security/apparmor/policy_ns.c                        |    8 -
>>   22 files changed, 1237 insertions(+), 417 deletions(-)
>>
>> base-commit: ab27740f7665


