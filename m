Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A076E789
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjHCL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjHCL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:58:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8845134;
        Thu,  3 Aug 2023 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691063914; x=1722599914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pZ4ZPmvSDy8cgfHE33t4fOkzIy0L7uqmxemDhUrl+uc=;
  b=m8R/q0qYordoirYdlX+qCoHm2g4KqZDjjmwHEQSjPnUo5lGqfPwPljq5
   G6HVxBk7ArjuxJmfOICRNKqZhEJRPGvmVzC+NON52+10wZFE5yo/dWSkL
   hCaeCcY1s6sKnoClRJws4BFGw5EYmcCtYf7A6NiJTC3+/LdKzCZx19hiE
   NGHPbdADK3PraWGdlO6p9vCVQnDV3/weYDe/XKJWmqOOUZ6TxY2rudIW+
   rhX13fIicRyb11a2K711clQH26XNVmt9IJqiWLaSOmq1q0wLMdV0wqJ6c
   MITCyu3vXZ7LZLN9v0ssvsX/kwZ0xHFKpVcmeCQCpSNlTBFjk/D3okWv9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="354770096"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="354770096"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="843570211"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="843570211"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 03 Aug 2023 04:58:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRWyN-00BBt3-0B;
        Thu, 03 Aug 2023 14:58:31 +0300
Date:   Thu, 3 Aug 2023 14:58:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] 8250_men_mcb: Fix unsigned comparison with less than zero
Message-ID: <ZMuWZulcClgyFxR3@smile.fi.intel.com>
References: <20230803084753.51253-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803084753.51253-1-jiapeng.chong@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:47:53PM +0800, Jiapeng Chong wrote:
> The data->line[i] is defined as unsigned int type, if(data->line[i] < 0)
> is invalid, so replace data->line[i] with res.
> 
> ./drivers/tty/serial/8250/8250_men_mcb.c:223:6-19: WARNING: Unsigned expression compared with zero: data->line[i] < 0.

Having

 WARNING: Unsigned expression compared with zero: data->line[i] < 0.

is enough.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


