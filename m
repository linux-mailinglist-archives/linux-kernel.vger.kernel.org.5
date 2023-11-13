Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545FC7E9D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjKMNnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjKMNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:42:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E32D53;
        Mon, 13 Nov 2023 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699882975; x=1731418975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzzD/0+ZYLR2IjlJENS/3cfv3WT3931bgroIdQuIApA=;
  b=ShXopCs+Ww6VmQrPmEMruiUaEvdNFOu8I8mRMxiWNzEcwKYKr4FLdE/6
   8wfzb+JSkFss24b2zjDzuNWzMvjMm/VeCulgJIgdH2hA08gLuK76Yiid0
   PvpWTzdNu2hI70sDd4CJ0uVywgmIXKJyIKMRXuzq0eySMuRYLIdPV20Ns
   hq+mVr9777GqH3Nr1B0aIbVQxi3qM1E9ZlQ2X0EbgH2MJq7NOss3LoGds
   LY7J2CBJLLLMiLuq2ufytQSJm+Sp8bVLDJry7nbhH1Z6yMH6sVEN/pLeV
   3F3v+cS7abdpwiSzRnqViouk7tceJ8BefsjosVsZdYN42/DdOzblcp0F/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375463751"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375463751"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="767923056"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="767923056"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 13 Nov 2023 05:42:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E9A231A6; Mon, 13 Nov 2023 15:42:51 +0200 (EET)
Date:   Mon, 13 Nov 2023 15:42:51 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1] pinctrl: intel: allow independent COMPILE_TEST
Message-ID: <20231113134251.GR17433@black.fi.intel.com>
References: <20231113125534.4993-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113125534.4993-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 06:25:34PM +0530, Raag Jadav wrote:
> Now that we have completed the transition to standard ACPI helpers for the
> entire Intel pinctrl tree, we can detach COMPILE_TEST from ACPI dependency.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
