Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5CA78F158
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346234AbjHaQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbjHaQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:33:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6310122
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693499619; x=1725035619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/Gw4DUlNHwr/bZrExBN33IugwaucLLJkZA7bic1tLwI=;
  b=TihZ/GAFPMDw1c0Lrnrov3v0+/ofWJjmC+PYsmhR/kdXw2jms6/B/mKl
   5StNOKr8Hh8BeZwtgU/gwNsF4aaz7dojX3wah6j5WFoghqNeoTpXXiFdW
   FkQ7bu8HqylPK2WtDhXRLqEmCK5VVAtjQrVwjtz+b4xq+1KmN3MFymJxl
   rCF0qK1gRR4I4TYPKHIn9IpkscBqyZVOF0LXq1WnsoNaaz74947J/lTRh
   E5kiHqubkOJpGdSpbVvHcbYluoBARiPTh/iaMciaU7wOp0hwNWnK19Qwu
   a0p1MS6X8pi+SO5wVMhna98t7VxWJcefhL8snTgvSmQH8f0Nbri0DyQVe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="439979589"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="439979589"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:33:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="742781985"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="742781985"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:33:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbkbm-005R3q-0N;
        Thu, 31 Aug 2023 19:33:26 +0300
Date:   Thu, 31 Aug 2023 19:33:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in
 netdev_register_kobject
Message-ID: <ZPDA1Z8Hwq3jdvgh@smile.fi.intel.com>
References: <ZPCfeaBrzF433cWE@smile.fi.intel.com>
 <000000000000c5ab74060438a6f8@google.com>
 <CANp29Y5GFuGe9=kBp-xmTb8tesLY4oAjewZ5c_31jmf8+AocBQ@mail.gmail.com>
 <ZPC0GTe3yc9Kl8uh@smile.fi.intel.com>
 <CANp29Y62czRE-U=a0=ak0AkUv7vKZSECY9pnm74jEAuHRL1sxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y62czRE-U=a0=ak0AkUv7vKZSECY9pnm74jEAuHRL1sxA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:53:29PM +0200, Aleksandr Nogikh wrote:
> On Thu, Aug 31, 2023 at 5:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Aug 31, 2023 at 04:15:23PM +0200, Aleksandr Nogikh wrote:
> > > #syz dup: general protection fault in nfc_register_device
> >
> > Thanks!
> >
> > Maybe you can improve it to
> > 1) drop those prefixes by itself;
> 
> Yeah, I've just thought about it too when I was correcting the command.
> 
> > 2) explain better in the quick help below what "exact" means.
> >
> > Also is it possible to test just patches without repository?
> > Can you add this feature when you simply submit a message ID
> > to it and it uses lore.kernel.org for the patch or series?
> 
> Thanks, these are good suggestions!
> The first one is easy to do (we actually already support that
> internally, so only a small change is needed), the second one is a bit
> trickier, but I'll look into that.

JFYI:
20230828145824.3895288-1-andriy.shevchenko@linux.intel.com

Can be used for testing.
So I like to write

#syz test patch: 20230828145824.3895288-1-andriy.shevchenko@linux.intel.com

The responses can be (among others?):
1/ tested and test results;
2/ not found.

-- 
With Best Regards,
Andy Shevchenko


