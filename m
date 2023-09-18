Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146377A4077
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbjIRF3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbjIRF3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:29:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9445122;
        Sun, 17 Sep 2023 22:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695014951; x=1726550951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7w/IL8NIihi9+H4a9k/xqpL9VbUcHnAUJRNdz0CiPE=;
  b=EyIJqtQGxoddfrayM8PHtiSkbD7DeHl5+DOU+Mr+adaYMndaA8vcneXG
   CIyW8111THeFM3gd53mgO+CTM2b6FL1gnCof7Gl6PBHKPH7sf0vVvkuQM
   PXVWN+sWyf8NDRyBgakfgsPeHQgFKTHBUMXuqm8rmsiJHrMwt6kYIMvvA
   ST4QXmuo3Hy+3HOdHrS3Te1cDpNStlPP1mW1gqVBZJXZM+Dj1K/x3CsrH
   tsF5vGIitGUZ3UYa4+ruzbRlvCtd9Ba6lr2Dv3E3Cdklg95Ums4asj2XN
   ASONaj2QsSg0qc0SEQOi8GebHd3vrPbEgeMt1QFj8f+ijhpjaL8Srm4C7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="465913815"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="465913815"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 22:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="738992690"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="738992690"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Sep 2023 22:29:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 69AEB18E; Mon, 18 Sep 2023 08:29:07 +0300 (EEST)
Date:   Mon, 18 Sep 2023 08:29:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 09/11] gpio: acpi: replace gpiochip_find() with
 gpio_device_find()
Message-ID: <20230918052907.GR1599918@black.fi.intel.com>
References: <20230915150327.81918-1-brgl@bgdev.pl>
 <20230915150327.81918-10-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915150327.81918-10-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:03:24PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the ACPI GPIO code.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
