Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4737F78FCDD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbjIAMDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjIAMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:03:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00B291
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693569779; x=1725105779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HybZOJ8Ii22+kDRhOxxVJCBV6TlVqulUPHRZO5bqzc8=;
  b=ac4vCMvS9Jwx/k5vy7I2tNjcbUYfZDsSxA/HPCpPG28ILqTKAqG3ae4l
   px/HtR/IG6HmNUcyDk9vavNYTl4ml0H9wbfCva9HP7GTG82TzUJoiQOmz
   Ut5J8e3cNt+MRtbjb6YZPKw8qOG5n5fDwSxUqxk6TU16SDeBilhSTfSfh
   5PMgJphWb+KXyAXHAXb1cSC3s9GCS7fnB8iqS0Mygsayvr+UdvAuQREqR
   YKsopF+WoXJ+MxPdUJh9bH7ezAtvwVJ/6KhQR6Ib9g1mGhqQauCM5tPlK
   osF+Zag4f48T63EEPpTngrfCBKigiuhofWH5Yg8/VddGJchE5E95kKKCm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="378931562"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="378931562"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="830101970"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="830101970"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:02:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qc2rI-005fBZ-2V;
        Fri, 01 Sep 2023 15:02:40 +0300
Date:   Fri, 1 Sep 2023 15:02:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in
 netdev_register_kobject
Message-ID: <ZPHS4Ps3dszk/5m0@smile.fi.intel.com>
References: <ZPCfeaBrzF433cWE@smile.fi.intel.com>
 <000000000000c5ab74060438a6f8@google.com>
 <CANp29Y5GFuGe9=kBp-xmTb8tesLY4oAjewZ5c_31jmf8+AocBQ@mail.gmail.com>
 <ZPC0GTe3yc9Kl8uh@smile.fi.intel.com>
 <CANp29Y62czRE-U=a0=ak0AkUv7vKZSECY9pnm74jEAuHRL1sxA@mail.gmail.com>
 <ZPDA1Z8Hwq3jdvgh@smile.fi.intel.com>
 <CANp29Y5Bq1fo8pFWGxKT9NTNW_-C6vf=A_hUKG2BJey5JRrO1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y5Bq1fo8pFWGxKT9NTNW_-C6vf=A_hUKG2BJey5JRrO1g@mail.gmail.com>
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

On Fri, Sep 01, 2023 at 01:07:20PM +0200, Aleksandr Nogikh wrote:
> On Thu, Aug 31, 2023 at 6:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Aug 31, 2023 at 05:53:29PM +0200, Aleksandr Nogikh wrote:

...

> > JFYI:
> > 20230828145824.3895288-1-andriy.shevchenko@linux.intel.com
> >
> > Can be used for testing.
> > So I like to write
> >
> > #syz test patch: 20230828145824.3895288-1-andriy.shevchenko@linux.intel.com
> 
> Thanks for the idea!
> I've filed https://github.com/google/syzkaller/issues/4182
> 
> The biggest problem is to figure out the command syntax that'd also
> let us specify the tree on which to apply the patch. Or to restrict
> the patch testing to either apply the patch from lore on top of the
> fuzzed tree or to accept repo/branch/patch explicitly.

Ah, that's easy to solve. I've commented there.

-- 
With Best Regards,
Andy Shevchenko


