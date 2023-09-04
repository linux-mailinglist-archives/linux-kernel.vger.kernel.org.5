Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22DA7914A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352650AbjIDJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbjIDJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:21:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3E918D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693819261; x=1725355261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=idnbGjbtFR0f+pbCcZeTM1erFoyvRkKrH/tJ60VN6Z0=;
  b=iFcSiYkBMmDHjCEEtdlxIFdqRGczBg/qG44hDSoPrTxe9Gy1q/PSNODG
   SNVctFUFQ0i7roWEQianmBOUk6JXAFfaeapEG9i+07gdlYJnQ2wGTxmoQ
   uGiv9kGPdxELEYSdBwtjS7R2bw8pVn0AdnfIsKrmI8cOcfuqtBOio7uPk
   CV12/qSfznci7vtld4+aGwJKQGBYDV1BxppYKQQqxArqhz2f8xjGQTRfT
   XaEubyGOnfcCvnyz3NMnyXrIykcx6pX+CICS790Jqc+6Y9HoZEu6ERY45
   TGJF5yVukZMRuLabnvlmwRZBswTYUcXEC1G+P3k/ONUgYXffg7i6k9yPe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="366779750"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="366779750"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="830834487"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="830834487"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:20:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd5lQ-006NrV-2T;
        Mon, 04 Sep 2023 12:20:56 +0300
Date:   Mon, 4 Sep 2023 12:20:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     syzbot <syzbot+24adf36b9fdc6531990f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in loop_add
Message-ID: <ZPWheG8kh076mF5B@smile.fi.intel.com>
References: <000000000000eddce70604837929@google.com>
 <d4d6f407-db6c-4015-be11-a552cc3a7635@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4d6f407-db6c-4015-be11-a552cc3a7635@t-8ch.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:57:05AM +0200, Thomas Weißschuh wrote:
> #syz dup: general protection fault in netdev_register_kobject

Thank you, Thomas, for taking care of marking these dups.

-- 
With Best Regards,
Andy Shevchenko


