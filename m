Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A517F24C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 05:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjKUELZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 23:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUELW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 23:11:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18755BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 20:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=y8LL43v3Y+DX+Vw5t/cwc0KvLM9c/sxcrpxQCDtDD7w=; b=IoqSZhlnXecmJR94WXbEKxPsUw
        5+HNI8C2BnVNWPSTsSx6hHnYMXmcC6yBjx+CDktPLmb4w9ARSpZREvRx3l2GWF9T7Ds4A6FJVmuoM
        dmpJIWYdZ/cwdmQPwxtmUeLZ7YX/Lr2xloNGVWYCLeN96zA8dxHUEKGiXVa7KQn0NNtSBcyUnUVr6
        mdK99apJ8x/gWb6rWMjPYbK/dt+klvomGYS90xnmp5GcIj8T/dmm32IBBx56iaL3lFu8Dlx7fnFD8
        R/RpDokbFES8b63Pbr6qEU7lIAnMSu1TbhCoyKiDMsiWstIwDvV7XbNEsIneJtgX0RxPG1GukLvl4
        j3QczTsw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r5I6P-00FZZf-0O;
        Tue, 21 Nov 2023 04:11:09 +0000
Message-ID: <2a4813ff-54a7-49b0-8d18-4cb54621e637@infradead.org>
Date:   Mon, 20 Nov 2023 20:11:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: kernel/cgroup/debug.c:1: warning: no structured comments found
To:     Waiman Long <longman@redhat.com>, kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
References: <202311211005.Qwt1FHrO-lkp@intel.com>
 <569119a8-f6f2-4e00-bfcc-5b804447320f@redhat.com>
Content-Language: en-US
In-Reply-To: <569119a8-f6f2-4e00-bfcc-5b804447320f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/20/23 19:04, Waiman Long wrote:
> 
> On 11/20/23 21:32, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
>> commit: a28f8f5e995fe5964ae304444913536058f26e37 cgroup: Move debug cgroup to its own file
>> date:   6 years ago
>> config: i386-buildonly-randconfig-005-20231120 (https://download.01.org/0day-ci/archive/20231121/202311211005.Qwt1FHrO-lkp@intel.com/config)
>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211005.Qwt1FHrO-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311211005.Qwt1FHrO-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> kernel/cgroup/debug.c:1: warning: no structured comments found
>>
>> vim +1 kernel/cgroup/debug.c
>>
>>     > 1    #include <linux/ctype.h>
>>       2    #include <linux/mm.h>
>>       3    #include <linux/slab.h>
>>       4   
> 
> Yes, there is no function in this file with structure comments. This debug controller is used for debugging only and is not supposed to be used on production systems anyway. Its interface is unstable and so I don't see a need to properly document its interface.
> 
> I will leave this file as it is for now.

Yes :)


This warning usually happens when some file is referenced in the
Documentation/ tree while building 'make htmldocs', e.g.

But this source file is not used in Documentation/ at all,
so this report seems to have some kind of a problem.
Also, I could not reproduce the warning.

-- 
~Randy
