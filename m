Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E0C7DDFC6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjKAKvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKAKvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:51:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF64F7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:51:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7A141F74A;
        Wed,  1 Nov 2023 10:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698835858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WLYzeh478WlPUyItQ97pqNBnGoje4ZiZDp2mbbnW3Q=;
        b=Qkldod7gecfbRLLe4lpkeRbl21VPREQfaK6Qz+xDw1m64H6ty7iOSNevjQdeOtDeUr5Fa5
        Wx3n/puZkgbr4exjZZyoNeFI9COJsTvnWF1etXD/74TMwkoPSC7EqzWIYRTg+HdJHYMFv+
        QmH9UrcnXlSzRHlN3bZmAON9RNIL1WQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698835858;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WLYzeh478WlPUyItQ97pqNBnGoje4ZiZDp2mbbnW3Q=;
        b=A43mMo88s6kGUn3b1cVszwYijMyCkdydlYHoalCq8etVQX9k8wK9y31uviW+JNqcIVM5y3
        +exDGptR0Nic3WCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEEEB1348D;
        Wed,  1 Nov 2023 10:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fBzLMZItQmWEKgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 01 Nov 2023 10:50:58 +0000
Message-ID: <9811a9a1-dffb-443f-62b1-07de04723a8a@suse.cz>
Date:   Wed, 1 Nov 2023 11:50:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: kernel/fork.c:1647:9: sparse: sparse: incorrect type in argument
 1 (different address spaces)
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>
References: <202310312340.LW2o2xTj-lkp@intel.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202310312340.LW2o2xTj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/23 16:09, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5a6a09e97199d6600d31383055f9d43fbbcbe86f
> commit: e240e53ae0abb0896e0f399bdfef41c69cec3123 mm, slub: add CONFIG_SLUB_TINY

Hello,

I don't see how that commit could possibly cause the memcpy warning().
Something wrong with the evaluation?

Vlastimil

> date:   11 months ago
> config: x86_64-randconfig-a013-20230614 (https://download.01.org/0day-ci/archive/20231031/202310312340.LW2o2xTj-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310312340.LW2o2xTj-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310312340.LW2o2xTj-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    kernel/fork.c:1096:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *owner @@     got struct task_struct *p @@
>    kernel/fork.c:1096:19: sparse:     expected struct task_struct [noderef] __rcu *owner
>    kernel/fork.c:1096:19: sparse:     got struct task_struct *p
>    kernel/fork.c:1310:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *new_exe_file @@
>    kernel/fork.c:1310:24: sparse:     expected struct file [noderef] __rcu *__ret
>    kernel/fork.c:1310:24: sparse:     got struct file *new_exe_file
>    kernel/fork.c:1310:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
>    kernel/fork.c:1310:22: sparse:     expected struct file *[assigned] old_exe_file
>    kernel/fork.c:1310:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
>    kernel/fork.c:1637:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
>    kernel/fork.c:1637:38: sparse:     expected struct refcount_struct [usertype] *r
>    kernel/fork.c:1637:38: sparse:     got struct refcount_struct [noderef] __rcu *
>    kernel/fork.c:1646:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/fork.c:1646:31: sparse:     expected struct spinlock [usertype] *lock
>    kernel/fork.c:1646:31: sparse:     got struct spinlock [noderef] __rcu *
>>> kernel/fork.c:1647:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
>    kernel/fork.c:1647:9: sparse:     expected void const *
>    kernel/fork.c:1647:9: sparse:     got struct k_sigaction [noderef] __rcu *
>>> kernel/fork.c:1647:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
>    kernel/fork.c:1647:9: sparse:     expected void const *
>    kernel/fork.c:1647:9: sparse:     got struct k_sigaction [noderef] __rcu *
>    kernel/fork.c:1647:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
>    kernel/fork.c:1647:9: sparse:     expected void const *
>    kernel/fork.c:1647:9: sparse:     got struct k_sigaction [noderef] __rcu *
>    kernel/fork.c:1648:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/fork.c:1648:33: sparse:     expected struct spinlock [usertype] *lock
>    kernel/fork.c:1648:33: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/fork.c:2074:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/fork.c:2074:31: sparse:     expected struct spinlock [usertype] *lock
>    kernel/fork.c:2074:31: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/fork.c:2078:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/fork.c:2078:33: sparse:     expected struct spinlock [usertype] *lock
>    kernel/fork.c:2078:33: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/fork.c:2398:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
>    kernel/fork.c:2398:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
>    kernel/fork.c:2398:32: sparse:     got struct task_struct *
>    kernel/fork.c:2407:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/fork.c:2407:27: sparse:     expected struct spinlock [usertype] *lock
>    kernel/fork.c:2407:27: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/fork.c:2454:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
>    kernel/fork.c:2454:54: sparse:     expected struct list_head *head
>    kernel/fork.c:2454:54: sparse:     got struct list_head [noderef] __rcu *
>    kernel/fork.c:2476:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/fork.c:2476:29: sparse:     expected struct spinlock [usertype] *lock
>    kernel/fork.c:2476:29: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/fork.c:2497:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/fork.c:2497:29: sparse:     expected struct spinlock [usertype] *lock
>    kernel/fork.c:2497:29: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/fork.c:2524:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
>    kernel/fork.c:2524:28: sparse:     expected struct sighand_struct *sighand
>    kernel/fork.c:2524:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>    kernel/fork.c:2553:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/fork.c:2553:31: sparse:     expected struct spinlock [usertype] *lock
>    kernel/fork.c:2553:31: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/fork.c:2555:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    kernel/fork.c:2555:33: sparse:     expected struct spinlock [usertype] *lock
>    kernel/fork.c:2555:33: sparse:     got struct spinlock [noderef] __rcu *
>    kernel/fork.c:2998:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
>    kernel/fork.c:2998:24: sparse:     expected struct task_struct *[assigned] parent
>    kernel/fork.c:2998:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
>    kernel/fork.c:3079:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
>    kernel/fork.c:3079:43: sparse:     expected struct refcount_struct const [usertype] *r
>    kernel/fork.c:3079:43: sparse:     got struct refcount_struct [noderef] __rcu *
>    kernel/fork.c:1742:9: sparse: sparse: dereference of noderef expression
>    kernel/fork.c:2119:22: sparse: sparse: dereference of noderef expression
>    kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
>    include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
>    include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
>    include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
>    include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
>    include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
>    include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
>    kernel/fork.c:2452:59: sparse: sparse: dereference of noderef expression
>    kernel/fork.c:2453:59: sparse: sparse: dereference of noderef expression
>    kernel/fork.c:1088:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/fork.c:1088:23: sparse:    struct task_struct [noderef] __rcu *
>    kernel/fork.c:1088:23: sparse:    struct task_struct *
> --
>>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void *
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>    drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>    drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>    drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>    drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>    drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>    drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>    drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void *
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>    drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
>    drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
> --
>>> drivers/video/fbdev/cirrusfb.c:1853:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
>    drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     expected void const *
>    drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     got char [noderef] __iomem *screen_base
>>> drivers/video/fbdev/cirrusfb.c:1853:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
>    drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     expected void const *
>    drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     got char [noderef] __iomem *screen_base
>>> drivers/video/fbdev/cirrusfb.c:1853:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
>    drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     expected void const *
>    drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     got char [noderef] __iomem *screen_base
>>> drivers/video/fbdev/cirrusfb.c:1853:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
>    drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     expected void *
>    drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     got char [noderef] __iomem *screen_base
> --
>    drivers/gpu/drm/gma500/opregion.c:294:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct opregion_header *header @@
>    drivers/gpu/drm/gma500/opregion.c:294:25: sparse:     expected void volatile [noderef] __iomem *addr
>    drivers/gpu/drm/gma500/opregion.c:294:25: sparse:     got struct opregion_header *header
>>> drivers/gpu/drm/gma500/opregion.c:324:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __iomem *[assigned] base @@
>    drivers/gpu/drm/gma500/opregion.c:324:20: sparse:     expected void const *const p
>    drivers/gpu/drm/gma500/opregion.c:324:20: sparse:     got void [noderef] __iomem *[assigned] base
>    drivers/gpu/drm/gma500/opregion.c:330:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct opregion_header *header @@     got void [noderef] __iomem *[assigned] base @@
>    drivers/gpu/drm/gma500/opregion.c:330:26: sparse:     expected struct opregion_header *header
>    drivers/gpu/drm/gma500/opregion.c:330:26: sparse:     got void [noderef] __iomem *[assigned] base
>    drivers/gpu/drm/gma500/opregion.c:331:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *vbt @@     got void [noderef] __iomem * @@
>    drivers/gpu/drm/gma500/opregion.c:331:23: sparse:     expected void *vbt
>    drivers/gpu/drm/gma500/opregion.c:331:23: sparse:     got void [noderef] __iomem *
>    drivers/gpu/drm/gma500/opregion.c:338:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct opregion_acpi *acpi @@     got void [noderef] __iomem * @@
>    drivers/gpu/drm/gma500/opregion.c:338:32: sparse:     expected struct opregion_acpi *acpi
>    drivers/gpu/drm/gma500/opregion.c:338:32: sparse:     got void [noderef] __iomem *
>    drivers/gpu/drm/gma500/opregion.c:343:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct opregion_asle *asle @@     got void [noderef] __iomem * @@
>    drivers/gpu/drm/gma500/opregion.c:343:32: sparse:     expected struct opregion_asle *asle
>    drivers/gpu/drm/gma500/opregion.c:343:32: sparse:     got void [noderef] __iomem *
> --
>>> drivers/gpu/drm/gma500/intel_bios.c:548:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem * @@
>    drivers/gpu/drm/gma500/intel_bios.c:548:42: sparse:     expected void const *const p
>    drivers/gpu/drm/gma500/intel_bios.c:548:42: sparse:     got unsigned char [noderef] [usertype] __iomem *
>    drivers/gpu/drm/gma500/intel_bios.c:549:40: sparse: sparse: cast removes address space '__iomem' of expression
>    drivers/gpu/drm/gma500/intel_bios.c:559:24: sparse: sparse: cast removes address space '__iomem' of expression
> 
> vim +1647 kernel/fork.c
> 
> a016f3389c0660 JANAK DESAI        2006-02-07  1631  
> a39bc51691a0c8 Alexey Dobriyan    2007-10-18  1632  static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1633  {
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1634  	struct sighand_struct *sig;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1635  
> 60348802e9cb13 Zhaolei            2009-01-06  1636  	if (clone_flags & CLONE_SIGHAND) {
> d036bda7d0e726 Elena Reshetova    2019-01-18  1637  		refcount_inc(&current->sighand->count);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1638  		return 0;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1639  	}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1640  	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
> 0c282b068eb26d Madhuparna Bhowmik 2020-01-27  1641  	RCU_INIT_POINTER(tsk->sighand, sig);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1642  	if (!sig)
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1643  		return -ENOMEM;
> 9d7fb04276481c Peter Zijlstra     2015-06-30  1644  
> d036bda7d0e726 Elena Reshetova    2019-01-18  1645  	refcount_set(&sig->count, 1);
> 06e62a46bbba20 Jann Horn          2018-08-21  1646  	spin_lock_irq(&current->sighand->siglock);
> ^1da177e4c3f41 Linus Torvalds     2005-04-16 @1647  	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
> 06e62a46bbba20 Jann Horn          2018-08-21  1648  	spin_unlock_irq(&current->sighand->siglock);
> b612e5df4587c9 Christian Brauner  2019-10-14  1649  
> b612e5df4587c9 Christian Brauner  2019-10-14  1650  	/* Reset all signal handler not set to SIG_IGN to SIG_DFL. */
> b612e5df4587c9 Christian Brauner  2019-10-14  1651  	if (clone_flags & CLONE_CLEAR_SIGHAND)
> b612e5df4587c9 Christian Brauner  2019-10-14  1652  		flush_signal_handlers(tsk, 0);
> b612e5df4587c9 Christian Brauner  2019-10-14  1653  
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1654  	return 0;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1655  }
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1656  
> 
> :::::: The code at line 1647 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
