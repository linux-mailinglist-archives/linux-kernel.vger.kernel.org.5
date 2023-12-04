Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB038041D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjLDWqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjLDWqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:46:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E009B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1SvhhogXKYPRX45z1KqNA56S/+FRW1MivpZ9wWcaoxw=; b=kpP98aY7s6WDXYPI2nX5SHAdAS
        RHYgMOYMafV75SVtyBASxGo/27LmR+bD8xV/nlv6ir/Ofw8ZyA7HW7p5F1tSkQkhGzu2gyOYFGhS4
        rPPV0JzEeZ9SAxPp4ifTBxfhb3eZ8nT4REp/oF2vkLER+NIf9bGBanhzYgJPxcAIcgKcTVrGXYLi9
        ZH8sx8rFBbK4P2t9EAgAqv/Hx4F+0Nc821cCaQZijkAxh9f5KjbIpS497Kq/6lSO2I0RhFsbk2qQN
        ZNlIC/S/2NXyGIoIzaxyO5glmEKTLJ+xp3cVDA9qZ0/fYaYKOn9f+9byFBIAOA1h8jg7j6VB+4pE5
        5BjCkmhw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAHi6-005jdv-1L;
        Mon, 04 Dec 2023 22:46:42 +0000
Message-ID: <61f2de49-131f-4619-b62e-dfe2f5b6bf3c@infradead.org>
Date:   Mon, 4 Dec 2023 14:46:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/usb/gadget/function/f_uac1_legacy.c:1: warning: no
 structured comments found
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
References: <202311211052.RsFuk4Gr-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202311211052.RsFuk4Gr-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ktr,

On 11/20/23 18:31, kernel test robot wrote:
> Hi Ruslan,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
> commit: d355339eecd986648420e05f8c958fbc78dbb382 usb: gadget: function: make current f_uac1 implementation legacy
> date:   6 years ago
> config: i386-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231121/202311211052.RsFuk4Gr-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211052.RsFuk4Gr-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311211052.RsFuk4Gr-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 

I can't reproduce any of these warnings.

I think that you should reevaluate something here.


>>> drivers/usb/gadget/function/f_uac1_legacy.c:1: warning: no structured comments found
> --
>>> drivers/usb/gadget/function/u_uac1_legacy.c:33: warning: No description found for parameter 'i'
>>> drivers/usb/gadget/function/u_uac1_legacy.c:33: warning: No description found for parameter 'val'
>>> drivers/usb/gadget/function/u_uac1_legacy.c:96: warning: No description found for parameter 'snd'
>>> drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'card'
>>> drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'buf'
>>> drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'count'
>    drivers/usb/gadget/function/u_uac1_legacy.c:205: warning: No description found for parameter 'card'
>>> drivers/usb/gadget/function/u_uac1_legacy.c:265: warning: No description found for parameter 'gau'
>    drivers/usb/gadget/function/u_uac1_legacy.c:294: warning: No description found for parameter 'card'
>>> drivers/usb/gadget/function/u_uac1_legacy.c:311: warning: No description found for parameter 'the_card'
> 
> 
> vim +1 drivers/usb/gadget/function/f_uac1_legacy.c
> 
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03  @1  /*
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   2   * f_audio.c -- USB Audio class function driver
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   3    *
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   4   * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   5   * Copyright (C) 2008 Analog Devices, Inc
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   6   *
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   7   * Enter bugs at http://blackfin.uclinux.org/
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   8   *
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   9   * Licensed under the GPL-2 or later.
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03  10   */
> c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03  11  
> 
> :::::: The code at line 1 was first introduced by commit
> :::::: c6994e6f067cf0fc4c6cca3d164018b1150916f8 USB: gadget: add USB Audio Gadget driver
> 
> :::::: TO: Bryan Wu <cooloney@kernel.org>
> :::::: CC: Greg Kroah-Hartman <gregkh@suse.de>
> 

-- 
~Randy
