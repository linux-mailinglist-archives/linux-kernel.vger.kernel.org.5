Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC25756913
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGQQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGQQ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:28:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F36191
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689611304; x=1721147304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S64kiYgG/Z09ntg7VE00Lr9XPMpWeSdAqtctkgnb3CM=;
  b=nl+1uEgQplUQXtuXNbDQiEcVg5iI4O5rUSz4/OsXhWYWowBGnVPWLGE1
   x63+dPBtEemy4h5T+CO4pGJuqDfh0c/jzD+KifIJBAmnG8l56oECGHAvz
   XSgh5CQWpYPPTw7B+U5bflotxBizrvDhBQHxjsrnBWhty2VLTk5WETuaH
   f8uQKU+OafOD3zUSx90NlTY61EtBgin5F7OJpV7dsHNr79Fadoawkr16j
   tGv17CtQyMn7bH1YRSwcSFbD2TESJEpVhMOKhPN6PzC+0M369E8xXPZEY
   3goPt9hf2xKcuZiPEmX18LtuVKHPWrUqMFltKN+fJhUHmeSbtO8rF79G/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="346279180"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="346279180"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 09:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866789322"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2023 09:28:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLR58-0055uU-3C;
        Mon, 17 Jul 2023 19:28:19 +0300
Date:   Mon, 17 Jul 2023 19:28:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v3 2/5] lib/test_bitmap: add tests for
 bitmap_{set,get}_value()
Message-ID: <ZLVsIlWH1TxcZCaG@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-3-glider@google.com>
 <ZLVoRkmy5IZYbjUV@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVoRkmy5IZYbjUV@yury-ThinkPad>
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

On Mon, Jul 17, 2023 at 09:11:50AM -0700, Yury Norov wrote:
> On Mon, Jul 17, 2023 at 01:37:05PM +0200, Alexander Potapenko wrote:

...

>                 if (val & BIT(j - start))
>                         __set_bit(j, orig);
>                 else
>                         __clear_bit(j, orig);

JFYI: __asign_bit() can be used here.

-- 
With Best Regards,
Andy Shevchenko


