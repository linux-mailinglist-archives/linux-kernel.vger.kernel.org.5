Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F02759C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGSRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGSRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:21:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2561F189;
        Wed, 19 Jul 2023 10:21:18 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="351395026"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="351395026"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 10:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794128236"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="794128236"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2023 10:21:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qMArQ-002Uz0-1V;
        Wed, 19 Jul 2023 20:21:12 +0300
Date:   Wed, 19 Jul 2023 20:21:12 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/4] gpio: sifive: Get the parent IRQ's domain from
 its irq_data
Message-ID: <ZLgbiIMVqYoe/OcN@smile.fi.intel.com>
References: <20230719163446.1398961-1-samuel.holland@sifive.com>
 <20230719163446.1398961-4-samuel.holland@sifive.com>
 <ZLgVPv7zdoaiUCU6@smile.fi.intel.com>
 <a3c4f1c6-444b-b3a2-c952-bdd5b0463f95@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c4f1c6-444b-b3a2-c952-bdd5b0463f95@sifive.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:03:46PM -0500, Samuel Holland wrote:
> On 2023-07-19 11:54 AM, Andy Shevchenko wrote:
> > On Wed, Jul 19, 2023 at 09:34:44AM -0700, Samuel Holland wrote:

...

> > Also, can irq_get_irq_data() return NULL? Needs a comment on top
> > of that assignment or an additional check.
> 
> No, the earlier loop already verified the IRQ number was valid. I don't think it
> can later become invalid. In any case, we already dereference the result of
> irq_get_irq_data(irq_number[foo]) in sifive_gpio_child_to_parent_hwirq().

Thanks for explanation, just add a comment.

-- 
With Best Regards,
Andy Shevchenko


