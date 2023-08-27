Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DED78A020
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjH0QKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjH0QKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89552AC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693152562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/aA/sAJj622xq8w4n2wEvNEATx/O6cZWJ9oyiVIzjk=;
        b=UHqZvE3KiM/5Cm6jR3Qikfzn0EXJjYIOgQDrqBOAwq7t4n12NyxCkPQEtEWoZdCtNk3NzC
        lziq/4Ve1TjOBX/Wkwk/O2Y2LOA6ghKnxE954U9tjrvqOzTRCkwHK4qaT3LuXhJkpMJrRz
        TrOl3SO1X0hBRzYTTAB9MKzGGWjhjJY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-_mmULSrtMMOHxpfIT3mqVQ-1; Sun, 27 Aug 2023 12:09:18 -0400
X-MC-Unique: _mmULSrtMMOHxpfIT3mqVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9B7829AB3E8;
        Sun, 27 Aug 2023 16:09:17 +0000 (UTC)
Received: from [10.22.16.2] (unknown [10.22.16.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B6422166B25;
        Sun, 27 Aug 2023 16:09:17 +0000 (UTC)
Message-ID: <731c0ca3-d9db-cbcd-ab64-876a5e689054@redhat.com>
Date:   Sun, 27 Aug 2023 12:09:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [linux-next][mainline/master] [IPR] [Function could be =
 "__mutex_lock_slowpath(lock)"]OOPs kernel crash while performing IPR test
Content-Language: en-US
To:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, abdhalee@linux.vnet.ibm.com,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
References: <67f349e2-33f1-30a3-f92c-3c0a68d6d22f@linux.vnet.ibm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <67f349e2-33f1-30a3-f92c-3c0a68d6d22f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/27/23 04:26, Tasmiya Nalatwad wrote:
> Greetings,
>
> [linux-next][mainline/master] [IPR] [Function could be = 
> "__mutex_lock_slowpath(lock)"]OOPs kernel crash while performing IPR test
>
> --- Traces ---
>
> --- Traces ---
> [65818.211823] Kernel attempted to read user page (380) - exploit 
> attempt? (uid: 0)
> [65818.211836] BUG: Kernel NULL pointer dereference on read at 0x00000380
> [65818.211840] Faulting instruction address: 0xc000000000f5f2e4
> [65818.211844] Oops: Kernel access of bad area, sig: 11 [#1]
> [65818.211846] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
> [65818.211850] Modules linked in: rpadlpar_io rpaphp nfnetlink 
> xsk_diag bonding tls rfkill sunrpc ses enclosure scsi_transport_sas 
> vmx_crypto pseries_rng binfmt_misc ip_tables ext4 mbcache jbd2 
> dm_service_time sd_mod t10_pi crc64_rocksoft crc64 sg ibmvfc 
> scsi_transport_fc ibmveth ipr dm_multipath dm_mirror dm_region_hash 
> dm_log dm_mod fuse
> [65818.211879] CPU: 16 PID: 613 Comm: kworker/16:3 Kdump: loaded Not 
> tainted 6.5.0-rc7-next-20230824-auto #1
> [65818.211883] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 
> 0xf000006 of:IBM,FW1030.30 (NH1030_062) hv:phyp pSeries
> [65818.211887] Workqueue: events sg_remove_sfp_usercontext [sg]
> [65818.211894] NIP:  c000000000f5f2e4 LR: c000000000f5f2d8 CTR: 
> c00000000032df70
> [65818.211897] REGS: c0000000081c7a10 TRAP: 0300   Not tainted 
> (6.5.0-rc7-next-20230824-auto)
> [65818.211900] MSR:  800000000280b033 
> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28000882  XER: 20040000
> [65818.211909] CFAR: c000000000f5b0a4 DAR: 0000000000000380 DSISR: 
> 40000000 IRQMASK: 0
> [65818.211909] GPR00: c000000000f5f2d8 c0000000081c7cb0 
> c000000001451300 0000000000000000
> [65818.211909] GPR04: 00000000000000c0 00000000c0000000 
> c000000006c5a298 98a2c506000000c0
> [65818.211909] GPR08: c00000006408ab00 c0000000022a3515 
> 0000000000000000 c008000000327d60
> [65818.211909] GPR12: c00000000032df70 c000000c1bc93f00 
> c000000000197cc8 c000000008797500
> [65818.211909] GPR16: 0000000000000000 0000000000000000 
> 0000000000000000 c000000003071ab0
> [65818.211909] GPR20: c000000003494c05 c000000c11340040 
> 0000000000000000 c0000000b9bb4030
> [65818.211909] GPR24: c0000000b9bb4000 c00000005e8627c0 
> 0000000000000000 c000000c19b91e00
> [65818.211909] GPR28: c0000000b9bb5328 c00000005e8627c0 
> 0000000000000380 0000000000000380
> [65818.211946] NIP [c000000000f5f2e4] mutex_lock+0x34/0x90
> [65818.211953] LR [c000000000f5f2d8] mutex_lock+0x28/0x90
> [65818.211957] Call Trace:
> [65818.211959] [c0000000081c7cb0] [c000000000f5f2d8] 
> mutex_lock+0x28/0x90 (unreliable)
> [65818.211966] [c0000000081c7ce0] [c00000000032df9c] 
> blk_trace_remove+0x2c/0x80
> [65818.211971] [c0000000081c7d10] [c0080000003205fc] 
> sg_device_destroy+0x44/0x110 [sg]
> [65818.211976] [c0000000081c7d90] [c008000000322988] 
> sg_remove_sfp_usercontext+0x1d0/0x2c0 [sg]
> [65818.211981] [c0000000081c7e40] [c000000000188010] 
> process_scheduled_works+0x230/0x4f0
> [65818.211987] [c0000000081c7f10] [c00000000018b044] 
> worker_thread+0x1e4/0x500
> [65818.211992] [c0000000081c7f90] [c000000000197df8] kthread+0x138/0x140
> [65818.211996] [c0000000081c7fe0] [c00000000000df98] 
> start_kernel_thread+0x14/0x18 

The panic happens when a device is being removed. Maybe it is a 
use-after-free problem. The mutex lock itself seems to be in an area 
that is no longer accessible. It is not a problem in the locking code 
itself.

Cheers,
Longman

