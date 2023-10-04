Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF08D7B7B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbjJDJIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjJDJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:08:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2EB4;
        Wed,  4 Oct 2023 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696410515; x=1727946515;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ufSEi72McfBG10jBFbrYihcM2lnJxa1t2+fyBqK80VU=;
  b=ig8LJuV+SyCtj2QYw1spu4BPPq/9A5egwm3/05oUMDVSlmKqovWfzARO
   1eiGSxah27/u4xbpACEjm2bxNrFKdUHpDk9mHkEjpXkpPMhYC41AsGSZk
   ZgnG8RQJ/JaZaHwTJl4y8x9XHhyRW9kMyqqHxUL7xPgMxDQR0Y9Em3Y6d
   Y0qrOzP1Dkj8gvtLqAWChGWrKn/J0PluoZKUvexHE7eQQA4YfEqh5+AHX
   7dDCkL7pMwB1u4HDs+9IwcF08aGAKqkxYIxSZ2adtvknAwoyqWhl9NDDn
   M1Q8Vo2+iba2y7mGAyh7tw0YuXrw0ZV/3EmyuTZzaafmu0ouj47/H6lhR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="368164297"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="368164297"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:08:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="998377553"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="998377553"
Received: from tkloeffe-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.41.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:08:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
References: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 0/3] TPMI feature major/minor version check
Message-Id: <169641050707.4049.17079388644585337417.b4-ty@linux.intel.com>
Date:   Wed, 04 Oct 2023 12:08:27 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 11:49:13 -0700, Srinivas Pandruvada wrote:

> Changes for core and feature drivers to check major minor version.
> 
> v2
> - commit description changes
> - Log level change
> 
> Srinivas Pandruvada (3):
>   platform/x86/intel/tpmi: Add defines to get version information
>   platform/x86: ISST: Ignore minor version change
>   platform/x86/intel-uncore-freq: Process hardware version
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

Once I've run some tests on the review-ilpo branch the patches
there will be added to the platform-drivers-x86/for-next branch
and eventually will be included in the pdx86 pull-request to
Linus for the next merge-window.

The list of commits applied:
[1/3] platform/x86/intel/tpmi: Add defines to get version information
      commit: 8874e414fe78718d0f2861fe511cecbd1cd73f4d
[2/3] platform/x86: ISST: Ignore minor version change
      commit: 07510a59b316445311775ee53adf10448140607a
[3/3] platform/x86/intel-uncore-freq: Ignore minor version change
      commit: 4b0d9c8f8f55562ed5346723e66eec64f22887f4

--
 i.

