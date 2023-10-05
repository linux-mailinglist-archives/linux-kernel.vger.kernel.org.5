Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4722F7BA2F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjJEPtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjJEPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:48:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19112D0E5;
        Thu,  5 Oct 2023 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696516084; x=1728052084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SDeb7YmRLIhyOt5mdezD+r6CjwII/UQjdTpJruaMM58=;
  b=G5PazHthCWoyc0RZTNbZd2vRdL3RGKanHlPeUxKMoMQ0QvnryhvyV0+0
   z+2fcMqFQUga1Cqt8v88D4+dOYk3iEXeP9EXBPCZN6Bejmpb0p9+jzb6s
   FSS9O4vc9YsMcwyOm8jd0HUSTTcI6WJSNtU5tR6TSNAzxE8C4LBR4gpzl
   Mn+XbXiuUZRspPSJaZtjQLJSA1Vos2OyXf9klc7HSn31+F2X+VY+G3Wt5
   JW4ou3uytXjXmvtTgrtoFhQRNBTscdweuUTC8FS4BtOCDFGYV49Q0xCho
   PNXYROmB0nJ9ZCjs/CMZ3W6LO7A+O7P2Gx1jEOTUcja2OfkSUTx7rNCw1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2115655"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2115655"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 07:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="822132308"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="822132308"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2023 07:17:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7C1DA345; Thu,  5 Oct 2023 17:17:28 +0300 (EEST)
Date:   Thu, 5 Oct 2023 17:17:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v1 1/1] pinctrl: broxton: Replace MODULE_ALIAS() with
 MODULE_DEVICE_TABLE()
Message-ID: <20231005141728.GU3208943@black.fi.intel.com>
References: <20231005133949.3613943-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231005133949.3613943-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:39:49PM +0300, Andy Shevchenko wrote:
> As Krzysztof pointed out the better is to use MODULE_DEVICE_TABLE()
> as it will be consistent with the content of the real ID table of
> the platform devices.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
