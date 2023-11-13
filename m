Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968CD7EA10F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjKMQPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjKMQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:15:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7551984;
        Mon, 13 Nov 2023 08:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699892110; x=1731428110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8rY+BuPATDdFllS11rT6X+vOd362jahNzwQrfoDc4Ns=;
  b=BmSxUhdAsyU+7gjq/sp2AsG7pqR6vvXxIj1z3zo/5WKUazjonzLRkDp0
   4xycMd85/N95CMSVPfSbjWJ+a/hIhKcwtd+qoT5jMW3AXhyMBlTWglIbo
   oyIEN0AfkScJs7xojyh6nnFp2LwTAm1OIs2aFGhWAZ1lys2/2BuLdLBdD
   IjIxcjuPSCn+RrYWbHYgkHO6iSzgFKKmauYf7MCCZFoAskXMkpnUzxZwa
   bSp/0VrPwgW3PjZa6NGouvEWPcktaTc3FtoPI6SrmV2AwSfoKXYlRKo1Z
   YSqTr7nuYWcO5NVILfxfbOxmG1W8YFUsqvQ08qS5epq3v9ZxNL/zDnjch
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394365802"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="394365802"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="714266736"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="714266736"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:15:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2ZaX-0000000DbOz-1Zn1;
        Mon, 13 Nov 2023 18:15:01 +0200
Date:   Mon, 13 Nov 2023 18:15:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        AVKrasnov@sberdevices.ru, r.czerwinski@pengutronix.de,
        jaimeliao.tw@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand
 controller response
Message-ID: <ZVJLhbvXSbmnEfwb@smile.fi.intel.com>
References: <20231113131634.614467-1-debug.penguin32@gmail.com>
 <20231113160751.620810-1-debug.penguin32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113160751.620810-1-debug.penguin32@gmail.com>
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

On Tue, Nov 14, 2023 at 02:07:49AM +1000, Ronald Monthero wrote:

I'm not sure if it's a dup email of the previously sent v2. In any case I have
commented on v1 and v2, please consider addressing them.

-- 
With Best Regards,
Andy Shevchenko


