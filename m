Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B381A7D6155
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJYFx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJYFxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:53:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF212F;
        Tue, 24 Oct 2023 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698213230; x=1729749230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HwH0M2LYNs3h6RybhoZxicRYHe1UvwfOm5z68Z9w+DY=;
  b=kwzmUegbBdLzxykT4ymFT7wLqMVHL7uarlGeBWXVB31SxL02Z19B1Zdn
   83Y8D+ePy+83T1MOaVASyRlEe51pPLhCYoy0unKVuTeZuqo8ziBImCOeh
   AeWR6jjQkN2mGA5caKnBpF+JHdLW8Vx3ckojPKTxfXVwDwTGgVowJmWD8
   eGQnJWtu+elkB8TC3IJ6sjHX3Qn8gXSUQADNVhp1sqJAnvZtmfBY55ABC
   y3oUQ4asCEhAQ8SBa6UyR5ogDrQ5gpSBb3Pp/noz6hG0JwQCkpCAgChV9
   TNTzkPWaeoW0AWIOPN+ZtqqgSRtF73afEnwVrVND98U5jY4h78Km21pbl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5857096"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="5857096"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 22:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902449784"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="902449784"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2023 22:51:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C8F13125; Wed, 25 Oct 2023 08:53:45 +0300 (EEST)
Date:   Wed, 25 Oct 2023 08:53:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <20231025055345.GI3208943@black.fi.intel.com>
References: <20231025053833.16014-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025053833.16014-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:
> Use acpi_dev_uid_match() for matching _UID instead of treating it
> as an integer.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
