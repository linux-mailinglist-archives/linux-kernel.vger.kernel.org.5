Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5AA7EFE1C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 07:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjKRGaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 01:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKRGaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 01:30:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF29D57;
        Fri, 17 Nov 2023 22:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700289014; x=1731825014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NJlCzxx4fg7oaPT+y5aC4GdbEcDuTAQAQV3iOEeBygM=;
  b=YIRpL4y94nP1OwpmsdkUACPGBgMljhdv1nCq44CCI79WbcZ4ExypDifU
   YU5K5/QqEtvZhMgLlYOLaZw3c9Slhg3u+6v3geVyimYm1OG9d69iaiuHM
   Ad2woz5cR0xSzfqf8Bre5S9DwAVqr0BeNq3Cp8EKwXe4YSw+6gw06pl5Z
   /Jzfv1N/kYtb9VyOvX0A4+T7IBM/PIA6YPaK0a/vtpbF0tCffTkPM7fx6
   30VKxSsL6wFFgjZ94RZ87hpf2D7T9Ye41dem2mKZM27q1NYlL7YlvKTEm
   +B9/jzjSCFoqujRzKlN+A0FbKRrN3ZgT6/26Q7/Gknfdszn693F/q4KOa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="4494165"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="4494165"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 22:30:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="715738438"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="715738438"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2023 22:30:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5CD6620B; Sat, 18 Nov 2023 08:30:10 +0200 (EET)
Date:   Sat, 18 Nov 2023 08:30:10 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] spi: intel: make mem_ops comparison unique to opcode
 match
Message-ID: <20231118063010.GJ17433@black.fi.intel.com>
References: <20231117144053.24005-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231117144053.24005-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 08:10:53PM +0530, Raag Jadav wrote:
> Instead of comparing parameters for every supported mem_ops, only compare
> on opcode match, which is relatively more efficient.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
