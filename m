Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0989078AEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjH1Lf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjH1Lf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:35:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C78AB3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693222526; x=1724758526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ayMi+uWGlM49FFzQulVYsUCBXRDs/IPEeYPCF7xTBD4=;
  b=SQElDMC3PEKIdPq+8K0UV6K20arim6fEr5pJLpzUujTMHQrln4OEMqoZ
   i92HuyYEGqlfgYCGD9oxDhCLZHFz4IgHsVLBO3NyyMBWfmOlz2JLuPcTO
   hGTeKoOk3qZ/7PSrlCSZ6cjyc6LqdrYq9as/6i4KQppYYVIZxvEPtN8eK
   GV+9KEGl5libNKh8vEQISPoN9nAA+Er85QzJo/5E7g29OuMCL9WEPaa/R
   0HXxh2FrV29NWQROgHV80Abe6MUYuXGX2vFmCcDsoQrwuBDPFCTdQv3gg
   wk0iHYt5EjN6H32bMzGVYDhEPchn4eS5yvRWTFaGh5Ti1otpl2pbYm+5x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="441425902"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="441425902"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 04:35:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="773240495"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="773240495"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2023 04:35:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qaaWg-00GP2z-0h;
        Mon, 28 Aug 2023 14:35:22 +0300
Date:   Mon, 28 Aug 2023 14:35:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+bdfb03b1ec8b342c12cb@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in
 nfc_register_device
Message-ID: <ZOyGeUk89gwLAKPJ@smile.fi.intel.com>
References: <0000000000001b6a0c0603f8ab85@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001b6a0c0603f8ab85@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:53:37AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:

Thanks! Will work on it ASAP.

-- 
With Best Regards,
Andy Shevchenko


