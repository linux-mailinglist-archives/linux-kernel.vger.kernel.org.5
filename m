Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1525F7CA0E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjJPHlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjJPHlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:41:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409CEAD;
        Mon, 16 Oct 2023 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697442060; x=1728978060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cXk7IOrYIs9yyZP0hZ4HH3hgWJTW2AdXUQs840kpZ7w=;
  b=RYdKZDQTZPDSCcF32eF3pOoTZsI69+PT71URe0Vy6gRdn2DnBj0DwjAH
   F15KkwtFcUSw0ZrcDl/IlIF3sZvMhr5W+IhBO5fWhNHkBgvMgJPZoANOx
   v/d4ry18fitPRR1gtRyCjUTLKwWYCsYZsp4H3P7U1msC/iBqz+8vksgkJ
   pQg2TvXxNIIhCDUT+4roFC628vQQNJ8s4sNvskvjN6n4JIyVFbgToINm2
   yxolJ+l0iAwh9fTXAJmlb89HyW1k5q/GDO7246bxty/9GaLP3hYHUtRwr
   aOHnvfV5Bubv4g8xAM+aKmeKgSAULStF+EvBgds1sg5Z/WfFGH/Agoqud
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="449675195"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="449675195"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 00:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1086989309"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="1086989309"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 00:40:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsIDd-00000005x2J-0Lr0;
        Mon, 16 Oct 2023 10:40:53 +0300
Date:   Mon, 16 Oct 2023 10:40:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+c063a4e176681d2e0380@syzkaller.appspotmail.com>
Cc:     christophe.jaillet@wanadoo.fr, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, raychi@google.com, royluo@google.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
Subject: Re: [syzbot] [kernel?] general protection fault in
 usb_hub_create_port_device
Message-ID: <ZSzpBLL0D/wF7DHw@smile.fi.intel.com>
References: <000000000000d04ea90604a6efcc@google.com>
 <000000000000a7d2820607bb49c2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a7d2820607bb49c2@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 11:20:36PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Mon Aug 28 14:58:24 2023 +0000
> 
>     driver core: return an error when dev_set_name() hasn't happened
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148e8a9d680000
> start commit:   7733171926cc Merge tag 'mailbox-v6.6' of git://git.linaro...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b273cdfbc13e9a4b
> dashboard link: https://syzkaller.appspot.com/bug?extid=c063a4e176681d2e0380
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a4ca00680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bed168680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: driver core: return an error when dev_set_name() hasn't happened

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
With Best Regards,
Andy Shevchenko


