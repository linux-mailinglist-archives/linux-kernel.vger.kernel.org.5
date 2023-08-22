Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A27E784434
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbjHVOaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbjHVOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:30:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A7AD7;
        Tue, 22 Aug 2023 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692714612; x=1724250612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xv76k+IpImzi2GS5574RwvcckYfvvKf4MGgWTpEnZNY=;
  b=OxtsHr/L3fjXfWqawvIQMKIBLrUh3ncgWQ3MwNp2NbbyAWXskxD8yay1
   w6g1Nq/oH2E1JovybXynuJ/hsPsjM3vYd6ZZnySnfwSlr+BD4ocDnmvAv
   zZFQFH2K0AWdeUtzNKn+/xvr6uqw2M2HRv2MDtfO2FSuHSouq65dWUe2I
   0rKm/zRVuvr342mVH6By7w4e5RqNHvbzN1npqYRYrrM8RSsSwbua2F8QI
   Rij2MCf9vCOONkUO3r1qMXHIhq83bjIvHbiZKNwtKTYraIrttTtJMUj4s
   CTLeYEwV81kog/q0nl+b7593sGEoy1q3mDROnYjDZC4LFUjW3N0dprTiS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373876385"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="373876385"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 07:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="910098004"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="910098004"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2023 07:30:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYSOV-00EJFL-1r;
        Tue, 22 Aug 2023 17:30:07 +0300
Date:   Tue, 22 Aug 2023 17:30:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] usbip: Use platform_device_register_full()
Message-ID: <ZOTGb7lNypG0DjV2@smile.fi.intel.com>
References: <20230817121300.501637-1-andriy.shevchenko@linux.intel.com>
 <2726b488-5cca-50c0-ea09-92fb38ba2356@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2726b488-5cca-50c0-ea09-92fb38ba2356@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 08:11:19AM -0600, Shuah Khan wrote:
> On 8/17/23 06:13, Andy Shevchenko wrote:

...

> Please address the following problem and send v2.
> 
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

Yep, I am aware of this, just haven't had time to look into.

-- 
With Best Regards,
Andy Shevchenko


