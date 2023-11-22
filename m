Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577F27F4FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbjKVSeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344163AbjKVSeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:34:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E61D7D;
        Wed, 22 Nov 2023 10:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700678055; x=1732214055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y1RQ+f1Q5efZzIZfRLadFxuw8IiQKXJxuGko9Zmlt9s=;
  b=VpkuOZ0ul6O19xFzfCE0Rn+dWZAUA7bjbjYbTWxBrT+7MnRZ0ZiM/TBG
   5/ks7tfvOUEp4mQaqM3he1/7VOiF6SsOloTsQrgkL/mDjcO/4Y+bn6x5r
   59YyRycVX6ghsSKgXkQQwRYbvQB/Ok/gHT9MhSNt1jRmmOx0EUAMB+02V
   VQL61i+7quuo1b5SjzqK83ljiXrTZUvtv6BMzkO7de7Cu4uxwdMGI88oM
   S9kEg78mrNT0Oj2KZoPeE835ZlXMV/qgBehL2PVXB+3eFupTddXr4Yxas
   HxqMG2MX7fU42jvS0HYC3QxQyQwHgo7yMPqJzS2IkTOVFKKxVNojuUcqL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13672024"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="13672024"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP; 22 Nov 2023 10:33:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743344455"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="743344455"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:51:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r5kmC-0000000G49b-3FaF;
        Wed, 22 Nov 2023 12:48:12 +0200
Date:   Wed, 22 Nov 2023 12:48:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kunwu.chan@hotmail.com,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: aspeed: Check return value of kasprintf in
 ast_vhub_alloc_epn
Message-ID: <ZV3cbH-i09AQelaB@smile.fi.intel.com>
References: <20231122014212.304254-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122014212.304254-1-chentao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:42:12AM +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.

OK.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


