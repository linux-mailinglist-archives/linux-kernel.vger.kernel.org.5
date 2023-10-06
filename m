Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E297BB563
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjJFKis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjJFKir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:38:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78ED83;
        Fri,  6 Oct 2023 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696588725; x=1728124725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1wC2a/+ny+Btcy3idVKwSXLJwGecTEFvzDjxFi9sdlc=;
  b=bcVLAHhDB+Pvj5SOvJ250XXKJgWXRB+1HG4v46iQXI3cS/BPxWIE6f7/
   0cX8RcHRvVA3kDabssKMSYZ6g5wEvF3er/fqNkMNL0u/FSBIWj5y7R8+D
   e5nNdqw0wVSefT3U2mzbMV9uiligbG3L4Cwy1SSMFbtlomEefAMiZqylg
   TF2cT5gNeH4P6UsK3FOtP0ntFRKIgcGJq8yaFvP1sAjVMADlG9dIoa9Ir
   eiXrZDErJONLgnxB1ZKWq4hXfDNzhO/kuZAlY0KVFtbKIbVVzTZ6qhMd8
   Bp76hHcEduIkOwLuZ/WsEsovmZ4m9Zpa3HBv1mLSPT8L7CR+/XCldcoHG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="382593107"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382593107"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999290466"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999290466"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:38:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qoiED-00000003Gh6-2EDF;
        Fri, 06 Oct 2023 13:38:41 +0300
Date:   Fri, 6 Oct 2023 13:38:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 1/2] pinctrl: cherryview: Avoid duplicated I/O
Message-ID: <ZR/jsZrNQRO378dX@smile.fi.intel.com>
References: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
 <20231006102412.GY3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006102412.GY3208943@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:24:12PM +0300, Mika Westerberg wrote:
> On Fri, Oct 06, 2023 at 12:40:32PM +0300, Andy Shevchenko wrote:

...

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


