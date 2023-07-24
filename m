Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F367D75EDA4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjGXIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGXIak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:30:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ACA1AD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690187437; x=1721723437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I+7ZJBTyINxTgdRGb0ljCHg6K/ZZstKslMZLFH9uXhU=;
  b=UeecHnYURB93p484KUc2i3zuPmyi1RV8Th4iKfIz6busIatsQcQD9VhK
   znioBBY+23R6Gt/Rhxa4xcBlt/MEvt0jDnLFizzfgnq9Os7FNI9vZGzDk
   S2Ez2OvhBvjaP4lFx39RiHUzRB3goJAtOzfl831uhHsGqKK/19V5PHLvD
   EKSf1LTkqsS80a+SWDSrNul+WCP2wL6Ffwpw0psI+TpFO+hWKggBC1wgQ
   5zlt0wMzWMc8Uhk8F2HfvzUKRDDxKxcvsPxC7EThCfupQy3bxHnQg/scx
   ItCwSNnJIZc1O/fCBUrB6rDwdKPN0cWSgT0X4fZwafhdxkv+vYqPfyHTp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="453759911"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="453759911"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="719583712"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="719583712"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2023 01:30:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNqxd-004UiL-00;
        Mon, 24 Jul 2023 11:30:33 +0300
Date:   Mon, 24 Jul 2023 11:30:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] cpumask: fix typos and kernel-doc warnings in cpumask.h
Message-ID: <ZL42qItwNebssuBN@smile.fi.intel.com>
References: <20230724023403.24869-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724023403.24869-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 07:34:03PM -0700, Randy Dunlap wrote:
> Fix some punctuation (plural vs. possessive).
> Fix some abbreviations (ie. -> i.e., id -> ID).
> 
> Fix 35 warnings like this:
> include/linux/cpumask.h:161: warning: No description found for return value of 'cpumask_first'

I wouldn't explicitly change Returns -> Return, but since the latter is one
mentioned in the documentation and we have no actual Return section anyway
(means we need to touch those lines), I'm fine with that.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you!

P.S. For out of curiosity the command line to check this is like

	scripts/kernel-doc -v -none -Wall ...

but I have no idea which one Randy used.

-- 
With Best Regards,
Andy Shevchenko


