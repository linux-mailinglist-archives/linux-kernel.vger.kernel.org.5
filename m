Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82747B7B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjJDJIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbjJDJIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:08:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E098;
        Wed,  4 Oct 2023 02:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696410525; x=1727946525;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=9uOCWkCPRcoeWlmBFUiRfNxLkF1oU94gSvWl0hIiJDY=;
  b=ih0R3PUtPW828g5WMr2e5O3a8VNQWjnkCCe6WEB252vcFXZSQrPZRQDu
   4SKHzXXaCOzS152B4Bp8MPePC0uDDyWb3l4L5XySQt93DsWxUURgWof2q
   5C8rt54PuW+nEVRDOjuaY3Cp/tcIkzlJGApGNBc2EhhoygP4pfFpdhz+3
   Gs8yHNbonbKHK6+7EE9znR/bktqioOR8qCKweALnpBGcxwBdfIpaelVel
   26jOnWD6TronW1yTmO5sLENlhGiuVSDEm4OvY6vaTZSK02z0H4YRxak18
   W+61PplV4vUghf5TTIYjXY+18CBLrJMFTmIJZyL7hzminFGuB5lTabxnJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386974930"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="386974930"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="754813762"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="754813762"
Received: from tkloeffe-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.41.8])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:08:40 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230925194219.966602-1-srinivas.pandruvada@linux.intel.com>
References: <20230925194219.966602-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel/tpmi: Add debugfs support for
 read/write blocked
Message-Id: <169641051464.4049.3489638663488197766.b4-ty@linux.intel.com>
Date:   Wed, 04 Oct 2023 12:08:34 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 12:42:19 -0700, Srinivas Pandruvada wrote:

> Display read and write blocked status of each TPMI feature in addition
> to disabled and locked status.
> 
> This will require reading of read/write blocked state from the hardware.
> Currently tpmi_read_feature_status(), doesn't provide this state.
> 
> Define TPMI feature state as defined in the TPMI spec. Modify the function
> tpmi_read_feature_status() to update full feature state instead of just
> disabled and locked state.
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
[1/1] platform/x86/intel/tpmi: Add debugfs support for read/write blocked
      commit: 8df012a7f513141412b3c35af204ccdb810fcc81

--
 i.

