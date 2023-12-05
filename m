Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674D280618A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346575AbjLEWP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346458AbjLEWP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:15:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE51B8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3bsHSMmQfyz+csHYq4RIEPn25hKRIp0mkKn6dPHakG8=; b=ika0qEa4YGJ9Qb92RacjZYCYtc
        PYSuO1PCZCew1Bgsif3fcgyj1opbqeD3LFwo/6oLpd4wacj7PjeSVA/7HelzAC7Q3d5KtS9iyRt9J
        W4iiXcoWgLDIsUCjiWmWNJBSlIHaJWkzNq2OZ4lX7CThiKIRj73J+hZQutzeAPx5ud37+lSNXQ4eg
        BcVDoGme/Azu2Dd1jDqyKU/IvZShSjITUVHt5voSYIvOdRJ5JOHOVxnKme/SrKD6f+ml93MnKxoSf
        PNge2S7+MqEzqMz9MtuVqo/h8KusR6QCCoAsGoi5pfReezH0lxJEe5r8mfnHQ3eMohxuT1RKPmRsf
        LNKc402g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAdhr-008Urg-0M;
        Tue, 05 Dec 2023 22:15:55 +0000
Message-ID: <fb36c8ea-02d7-408a-8354-f35712cdd510@infradead.org>
Date:   Tue, 5 Dec 2023 14:15:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel/context_tracking.c:80: warning: Function parameter or
 member 'state' not described in '__ct_user_enter'
Content-Language: en-US
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
References: <202312041922.YZCcEPYD-lkp@intel.com>
 <8e26257d-2809-4965-9f7d-aadbbb3def6f@paulmck-laptop>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8e26257d-2809-4965-9f7d-aadbbb3def6f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 20:38, Paul E. McKenney wrote:
> On Mon, Dec 04, 2023 at 08:02:33PM +0800, kernel test robot wrote:
>> Hi Frederic,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
>> commit: e67198cc05b8ecbb7b8e2d8ef9fb5c8d26821873 context_tracking: Take idle eqs entrypoints over RCU
>> date:   1 year, 5 months ago
>> config: x86_64-buildonly-randconfig-006-20230906 (https://download.01.org/0day-ci/archive/20231204/202312041922.YZCcEPYD-lkp@intel.com/config)
>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312041922.YZCcEPYD-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202312041922.YZCcEPYD-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> kernel/context_tracking.c:80: warning: Function parameter or member 'state' not described in '__ct_user_enter'
>>>> kernel/context_tracking.c:184: warning: Function parameter or member 'state' not described in '__ct_user_exit'
> 
> Does the patch below help?

Yes. Thanks.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 9d879548a8cc89e5fdb0d806fc20887d67991c10
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon Dec 4 20:34:58 2023 -0800
> 
>     context_tracking: Fix kerneldoc headers for __ct_user_{enter,exit}()
>     
>     Document the "state" parameter of both of these functions.
>     
>     Reported-by: kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202312041922.YZCcEPYD-lkp@intel.com/
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Frederic Weisbecker <frederic@kernel.org>
> 
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 6ef0b35fc28c..70ae70d03823 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -458,6 +458,8 @@ static __always_inline void context_tracking_recursion_exit(void)
>   * __ct_user_enter - Inform the context tracking that the CPU is going
>   *		     to enter user or guest space mode.
>   *
> + * @state: userspace context-tracking state to enter.
> + *
>   * This function must be called right before we switch from the kernel
>   * to user or guest space, when it's guaranteed the remaining kernel
>   * instructions to execute won't use any RCU read side critical section
> @@ -595,6 +597,8 @@ NOKPROBE_SYMBOL(user_enter_callable);
>   * __ct_user_exit - Inform the context tracking that the CPU is
>   *		    exiting user or guest mode and entering the kernel.
>   *
> + * @state: userspace context-tracking state being exited from.
> + *
>   * This function must be called after we entered the kernel from user or
>   * guest space before any use of RCU read side critical section. This
>   * potentially include any high level kernel code like syscalls, exceptions,

-- 
~Randy
