Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA27611D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjGYK4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjGYK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:56:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C394C11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690282438; x=1721818438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/H0O+FjMd/lC8BGzzURnOxli8yTXPYTsmbjFZggdkZ8=;
  b=cxXFCWRP8YyaoRq47bis5D795XpCp80YgbJtApERhJoTtXegAQwmp0GM
   Vgkj+9NJcP8PiVVnBbcDNqWcu/Jqz0rVJbJW0MaJRKCQqOwnbr1gyEfa4
   zknlBp5U8gaCwsWawh7QGOftQTOpF/R02ZIcxnvUX1Se8q3wuYojUj5Pt
   jh+2RvRt33yIGc+N31yZm2XQsUvGMABjyZYQvQlhCdQDHYoGiDakVGalu
   wUMVFQlFD3Rh9VC90h8LD03j6E/fUBK2e4a5kH6hHLgb8eXKA0R+p9dZ4
   XoVOtNzJU6sQSrdbu4WDGW84EicP7xR4cJRkdPdJfzP+0VJP2I8Z2RKSQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="352585078"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="352585078"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="972625202"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972625202"
Received: from grdarcy-mobl1.ger.corp.intel.com (HELO [10.213.228.4]) ([10.213.228.4])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:53:32 -0700
Message-ID: <ef712b76-ef8a-9c01-08e3-13a1ee5b00b4@linux.intel.com>
Date:   Tue, 25 Jul 2023 11:53:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Intel-gfx] Regression in linux-next
Content-Language: en-US
To:     "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>
Cc:     "Nikula, Jani" <jani.nikula@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
        "Yedireswarapu, SaiX Nandan" <saix.nandan.yedireswarapu@intel.com>
References: <SJ1PR11MB6129592BDF5D06949F99816CB95B9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB6129A7F5C08E2C47748F2BA5B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612980562220A376CA90E105B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB61296D265E3407D447188EF6B903A@SJ1PR11MB6129.namprd11.prod.outlook.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <SJ1PR11MB61296D265E3407D447188EF6B903A@SJ1PR11MB6129.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/07/2023 07:42, Borah, Chaitanya Kumar wrote:
> Hello Alistair,
> 
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
>   
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next
> repository.
>   
> On next-20230720 [2], we are seeing the following error
> 
> <4>[   76.189375] Hardware name: Intel Corporation Meteor Lake Client Platform/MTL-P DDR5 SODIMM SBS RVP, BIOS MTLPFWI1.R00.3271.D81.2307101805 07/10/2023
> <4>[   76.202534] RIP: 0010:__mmu_notifier_register+0x40/0x210
> <4>[   76.207804] Code: 1a 71 5a 01 85 c0 0f 85 ec 00 00 00 48 8b 85 30 01 00 00 48 85 c0 0f 84 04 01 00 00 8b 85 cc 00 00 00 85 c0 0f 8e bb 01 00 00 <49> 8b 44 24 10 48 83 78 38 00 74 1a 48 83 78 28 00 74 0c 0f 0b b8
> <4>[   76.226368] RSP: 0018:ffffc900019d7ca8 EFLAGS: 00010202
> <4>[   76.231549] RAX: 0000000000000001 RBX: 0000000000001000 RCX: 0000000000000001
> <4>[   76.238613] RDX: 0000000000000000 RSI: ffffffff823ceb7b RDI: ffffffff823ee12d
> <4>[   76.245680] RBP: ffff888102ec9b40 R08: 00000000ffffffff R09: 0000000000000001
> <4>[   76.252747] R10: 0000000000000001 R11: ffff8881157cd2c0 R12: 0000000000000000
> <4>[   76.259811] R13: ffff888102ec9c70 R14: ffffffffa07de500 R15: ffff888102ec9ce0
> <4>[   76.266875] FS:  00007fbcabe11c00(0000) GS:ffff88846ec00000(0000) knlGS:0000000000000000
> <4>[   76.274884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   76.280578] CR2: 0000000000000010 CR3: 000000010d4c2005 CR4: 0000000000f70ee0
> <4>[   76.287643] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> <4>[   76.294711] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> <4>[   76.301775] PKRU: 55555554
> <4>[   76.304463] Call Trace:
> <4>[   76.306893]  <TASK>
> <4>[   76.308983]  ? __die_body+0x1a/0x60
> <4>[   76.312444]  ? page_fault_oops+0x156/0x450
> <4>[   76.316510]  ? do_user_addr_fault+0x65/0x980
> <4>[   76.320747]  ? exc_page_fault+0x68/0x1a0
> <4>[   76.324643]  ? asm_exc_page_fault+0x26/0x30
> <4>[   76.328796]  ? __mmu_notifier_register+0x40/0x210
> <4>[   76.333460]  ? __mmu_notifier_register+0x11c/0x210
> <4>[   76.338206]  ? preempt_count_add+0x4c/0xa0
> <4>[   76.342273]  mmu_notifier_register+0x30/0xe0
> <4>[   76.346509]  mmu_interval_notifier_insert+0x74/0xb0
> <4>[   76.351344]  i915_gem_userptr_ioctl+0x21a/0x320 [i915]
> <4>[   76.356565]  ? __pfx_i915_gem_userptr_ioctl+0x10/0x10 [i915]
> <4>[   76.362271]  drm_ioctl_kernel+0xb4/0x150
> <4>[   76.366159]  drm_ioctl+0x21d/0x420
> <4>[   76.369537]  ? __pfx_i915_gem_userptr_ioctl+0x10/0x10 [i915]
> <4>[   76.375242]  ? find_held_lock+0x2b/0x80
> <4>[   76.379046]  __x64_sys_ioctl+0x79/0xb0
> <4>[   76.382766]  do_syscall_64+0x3c/0x90
> <4>[   76.386312]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> <4>[   76.391317] RIP: 0033:0x7fbcae63f3ab
> 
> Details log can be found in [3].
> 
> After bisecting the tree, the following patch seems to be causing the
> regression.
> 
> commit 828fe4085cae77acb3abf7dd3d25b3ed6c560edf
> Author: Alistair Popple apopple@nvidia.com
> Date:   Wed Jul 19 22:18:46 2023 +1000
> 
>      mmu_notifiers: rename invalidate_range notifier
> 
>      There are two main use cases for mmu notifiers.  One is by KVM which uses
>      mmu_notifier_invalidate_range_start()/end() to manage a software TLB.
> 
>      The other is to manage hardware TLBs which need to use the
>      invalidate_range() callback because HW can establish new TLB entries at
>      any time.  Hence using start/end() can lead to memory corruption as these
>      callbacks happen too soon/late during page unmap.
> 
>      mmu notifier users should therefore either use the start()/end() callbacks
>      or the invalidate_range() callbacks.  To make this usage clearer rename
>      the invalidate_range() callback to arch_invalidate_secondary_tlbs() and
>      update documention.
> 
>      Link: https://lkml.kernel.org/r/9a02dde2f8ddaad2db31e54706a80c12d1817aaf.1689768831.git-series.apopple@nvidia.com
> 
> 
> We also verified by reverting the patch in the tree.
> 
> Could you please check why this patch causes the regression and if we can find
> a solution for it soon?

Without checking out the whole tree but only looking at this patch in isolation, it could be that it is not considering NULL subscription can be passed to mmu_notifier_register. For instance from mmu_interval_notifier_insert, which i915 is calling. So the check patch added to __mmu_notifier_register causes a null pointer dereference:

@@ -616,6 +617,15 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
         mmap_assert_write_locked(mm);
         BUG_ON(atomic_read(&mm->mm_users) <= 0);
  
+       /*
+        * Subsystems should only register for invalidate_secondary_tlbs() or
+        * invalidate_range_start()/end() callbacks, not both.
+        */
+       if (WARN_ON_ONCE(subscription->ops->arch_invalidate_secondary_tlbs &&

---> subscription is NULL here <---

+                               (subscription->ops->invalidate_range_start ||
+                               subscription->ops->invalidate_range_end)))
+               return -EINVAL;
+

Regards,

Tvrtko

> 
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230720
> [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20230720/bat-mtlp-6/dmesg0.txt
