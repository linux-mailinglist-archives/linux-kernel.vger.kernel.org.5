Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C820765087
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjG0KFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjG0KFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:05:33 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B19136
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690452332; x=1721988332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uLYtJp05o3eSfAexrJ/TLDiwSRmOIJTOCrkB9GzIAwo=;
  b=MhxKGsL14u33ZLdMn+FHUx6K2Q+4K3kde+pcOMZ0/zubkh9R0zwiOb26
   Zu7ifKRPmgIDcG/dtetut/vGwi/Us/t9NfADCYQaEH1FmgHSKX4rtUyf5
   RU6EJ5aMY/rDLoHO6I5IEw3TNlGQ58dc5DpmxtReXk7GnF0bfc967FZ6y
   jIA33lnD6RTauHqH39NYCRo2oLHsk1Ie0o4eKqL2rET8UG1Iur95tMMjp
   vmb20WskQ3C/f6qtWPkGlE/YcdJJYN5oXavnGipBsMRAic5FJnlkM+ddZ
   NjyAVnxwj4/m9RpxjsNtHIbO0LK9QHM++gMcI3qoIAmfexU73goYnss1L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="432065490"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="432065490"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 03:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756593036"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="756593036"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 03:05:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOxs9-00GSXf-2J;
        Thu, 27 Jul 2023 13:05:29 +0300
Date:   Thu, 27 Jul 2023 13:05:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 4/6] bitmap: replace _reg_op(REG_OP_ISFREE) with
 find_next_bit()
Message-ID: <ZMJBaczSQgpLx5Wr@smile.fi.intel.com>
References: <20230727020207.36314-1-yury.norov@gmail.com>
 <20230727020207.36314-5-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727020207.36314-5-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:02:05PM -0700, Yury Norov wrote:
> _reg_op(REG_OP_ISFREE) can be trivially replaced with find_next_bit().
> Drop it.

The verb here is incorrect, you don't drop it, you replaced it.

Same for the other patches.

-- 
With Best Regards,
Andy Shevchenko


