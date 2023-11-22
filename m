Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54517F4FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbjKVSjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjKVSjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:39:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5941D42;
        Wed, 22 Nov 2023 10:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700678362; x=1732214362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L82wvl6+ZajZ0SLS81iX3EOXwVKSlwZPColeDzRka9o=;
  b=mLiNPTINkEkkoMiehMo5ufSF9rI716iIhZTV72P4/NtAMDHfuXdbF4oB
   gMs01jU4cDcHJaOcSliyCvUo3JrtROLPOak13Zg/QJo8x3+fxricwdqew
   xfzPg3MyxgNAEkAtW4lqI945ZWWDbJx83uOCNPdXA+WMdsVp83prWMLzf
   7Xs6ZFLAINplZlvFbsfY+PUcglJt3PknHUZIWOB/GxhC75aZOXulrQmRo
   eqs2B4kKwWr/QQABb5QK6iI0Srrtxq+OGkiQxZWT0S7m0i33zeoTzys5y
   uOtJ+6O/8midXEVEsv35HmOIFb/3CiswjPUQC9gBv8W7JGLS+E9yTtFCV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377150470"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="377150470"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP; 22 Nov 2023 10:38:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801852030"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="801852030"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 03:26:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r5lCu-0000000G4Yq-2QaI;
        Wed, 22 Nov 2023 13:15:48 +0200
Date:   Wed, 22 Nov 2023 13:15:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kieran Levin <ktl@frame.work>
Subject: Re: Fwd: [Framework Laptop] High power consumption when i2c hid
 touchpad is in use
Message-ID: <ZV3i5AoTHXop7hbf@smile.fi.intel.com>
References: <ac04e6da-2fc8-493a-9a51-69cc729da1fd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac04e6da-2fc8-493a-9a51-69cc729da1fd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 09:03:52AM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I notice an interesting bug report on Bugzilla [1]. Quoting from it:

Thanks, let's continue there.

-- 
With Best Regards,
Andy Shevchenko


