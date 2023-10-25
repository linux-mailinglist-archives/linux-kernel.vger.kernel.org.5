Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117D17D69DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJYLSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjJYLSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:18:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A13128;
        Wed, 25 Oct 2023 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232714; x=1729768714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OZVkAUofT4Hs3fiP8QhnOHXLA4XmUAOuacC4kM7ypAQ=;
  b=DYHD0J1gPKhNl72hYwAQNHnPHbBAh3KN5c1ffLUD3IrTXW/kD1GNEUBS
   Beq0T8mBmkJ8wVPuzlN8BiAhsR5eEuFEaJ/LUVgoJG9zFGKAUiZY5FC7B
   NFZu0Sx6sv05EaMLyDezaw/vlFtBrHH92rKFq0McMz+44CsskzGdXMmlR
   itVrux8IjfS7tcZW0SlPHBCFyrJXOb5j4/4dffRVmaiWCrzX19P+TTwmP
   rqiieHO/5ahi0TPSPmlgUm0yB69TaK+8X/sVuAhTj0lOz6ApCbMFVUsRN
   4sKNndjbNcyYKDDG7cPfMWXr6cIiLVnbMiABPm8lZTsYJTBbSuqAD4Kwm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154604"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154604"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425060"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425060"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:14 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 0/6] Replace acpi_driver with platform_driver
Date:   Wed, 25 Oct 2023 14:18:00 +0300
Message-ID: <20231025111806.2416524-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a continuation of efforts from [1] aiming to replace
acpi_driver with platform_driver. To ease up review effort I'm sending
miniseries per driver, with a replacement patch + various improvements
that were noticed by me, or during internal review.

This mini-series takes care of acpi_video driver.

[1] - https://lore.kernel.org/linux-acpi/20231011083334.3987477-1-michal.wilczynski@intel.com/T/#t

Michal Wilczynski (6):
  ACPI: acpi_video: Remove unnecessary checks
  ACPI: acpi_video: Use yes_or_no helper instead of ternary operator
  ACPI: acpi_video: Remove unnecessary driver_data clear
  ACPI: acpi_video: Replace acpi_driver with platform_driver
  ACPI: acpi_video: Rename ACPI device instances from device to adev
  ACPI: acpi_video: Fix holes in acpi_video_bus

 drivers/acpi/acpi_video.c | 101 +++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 55 deletions(-)

-- 
2.41.0

