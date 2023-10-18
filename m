Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8A7CE766
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjJRTKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjJRTKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:10:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BD811F;
        Wed, 18 Oct 2023 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697656208; x=1729192208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AZUecB5QU3YRVFjpA+BfFj4FQml103oMvulQUPI1rBM=;
  b=gPApd0Jy1TrXP18KDEj+R7n/EBmHi9C3RTjMiUmglUQgaiu63vjK+D/X
   MhB3/pJHuORHVctiBVh8vHyKUTuGyPaxKTVYxa6rcrhqxaDmQeHiO9UpP
   MWGQACgzHDpjsEhF2NuFi8T/3yMYG+IYdEP7Ir/umEsg1AIjehA9T2Sdg
   5p4CqN6csNz3FshRDOGm3NNir2QKjOlajrxmh7Foha2eqvU0/XiFrVLjN
   WFSm5yKUaD2msA9/NgOyPm729ql1EcZ0Vn4qixLv8ywss8IsxqSRV9H68
   5pTMeWkkGbRRg77WdVdmszEhbFCUJpby4vF/5P7HFRXyFN3lmHe4sJ2UU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472323309"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472323309"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733277256"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="733277256"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:05 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 0/3] Replace acpi_driver with platform_driver
Date:   Wed, 18 Oct 2023 22:09:42 +0300
Message-ID: <20231018190945.252428-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

This mini-series takes care of acpi_pad driver.

v2:
 - removed all the unnecessary whitespace changes from first commit
 - removed changes to acpi_pad_notify(), and installer/removal handlers

[1] - https://lore.kernel.org/linux-acpi/20231011083334.3987477-1-michal.wilczynski@intel.com/T/#t

Michal Wilczynski (3):
  ACPI: acpi_pad: Replace acpi_driver with platform_driver
  ACPI: acpi_pad: Use dev groups for sysfs
  ACPI: acpi_pad: Rename ACPI device from device to adev

 drivers/acpi/acpi_pad.c | 82 ++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 51 deletions(-)

-- 
2.41.0

