Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC47BB50E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjJFKYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjJFKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:24:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBD8AD;
        Fri,  6 Oct 2023 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696587856; x=1728123856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D0CG8r/O+j+/5iBn0jzImLh0rPun5dUaiLwzZqYYmMA=;
  b=X4MxN8UU99GU3Q9Nm/7UxB0IDTzMDrXxo1yOQbFwJklcld0xIkeGBPmE
   sGv99JBU1kERSYs3cA39z5BkwSjqXt3uF2X/q57bgqCj2h/4E3KyaQEeb
   8mCSPVhNyjZzWHeteVcTto+99HrpAfa7hvXkvrV6AiCz6IgFgM0mnoryZ
   Ee2VKTYCofCpPj6L/hBjAauqqoHRrKqYz+8MF9qg8sEwusFMhlo8+qJP0
   at5J+Fn3GFxP8qioRJ/MvD3bNs3VniQM4+/+y4Dx+iAg/zwKttkl3QQaG
   qJqG/RQGNB7lpp3BXXwTiWXdcYrj4cBmre6n6UKctNOclUNEoQwbzexHc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447910956"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="447910956"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="745829176"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="745829176"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Oct 2023 03:24:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CC52E4F4; Fri,  6 Oct 2023 13:24:12 +0300 (EEST)
Date:   Fri, 6 Oct 2023 13:24:12 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 1/2] pinctrl: cherryview: Avoid duplicated I/O
Message-ID: <20231006102412.GY3208943@black.fi.intel.com>
References: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 12:40:32PM +0300, Andy Shevchenko wrote:
> In some cases we already read the value from the register followed
> by a reading of it again for other purposes, but the both reads
> are under the lock and bits we are insterested in are not going
> to change (they are not volatile from HW perspective). Hence, no
> need to read the same registeer twice.

Typo "registeer" -> "register"

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
