Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995837CC838
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbjJQP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344254AbjJQP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:56:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74713F0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697558184; x=1729094184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u4j92HrXmAcw2zRG3xmVf9ZY+rDUmk1h+5IoENU8/ak=;
  b=Pr4xrbBwckQOTqYQeuQFLAJJ6Gx8D6aYbjGtZlZeGj7/srJOrFTSlw2N
   Fk1Q0gb5kh1pM1Si5HbFLsaqF5mYuZ3neTlypj1KitZMtW/LUHaeT8ao5
   A9YTWFA+cwPHyMQ8TAb0XO6WxgB9LBdS7fGAIkINj+sJEBU6OBnSXbZw7
   hQNBeAAwD0qkvbNxfuV/+9HMVLNnIBN1+d4yO0RAfeZPdTTWiDJMarxh4
   S+6QrMhjwF0bO8HSDMfmNxU+V2UyuldwlqJIX9mbuEQNzo5UimMT+akry
   FTcQqbjfCpDYelXbEiM9h7iNkQspaxWceTs7mHXgDETEsVFvMmaAWTK/r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="376181735"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="376181735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:56:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826493452"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="826493452"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:56:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsmQT-00000006L9r-2MU8;
        Tue, 17 Oct 2023 18:56:09 +0300
Date:   Tue, 17 Oct 2023 18:56:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+410a8e33c6a740b40d51@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, ricardo@marliere.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in hci_register_dev
Message-ID: <ZS6umTVPGqY8Yycs@smile.fi.intel.com>
References: <0000000000002683d00604c6bafe@google.com>
 <0000000000000e34f70607eb86f5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000e34f70607eb86f5@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:53:28AM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Mon Aug 28 14:58:24 2023 +0000
> 
>     driver core: return an error when dev_set_name() hasn't happened
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17925039680000
> start commit:   92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=410a8e33c6a740b40d51
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14df7104680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125a5357a80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: driver core: return an error when dev_set_name() hasn't happened

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
With Best Regards,
Andy Shevchenko


