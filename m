Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEC37CB0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjJPRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjJPRFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:05:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F80B30D2;
        Mon, 16 Oct 2023 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697475710; x=1729011710;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yKww6SjCEG/wpwZG3DM33NqeeIEdYlnk1Zx568Ludko=;
  b=TXZqeHl2u9skQJfihU3Qa8vQkh9qa11a2/omh9KZrh7/8lzGOqu75vCt
   niItsHXfaZr49swNR+/SrxA+0XzZsD2q15Dm3sMIIzjG0J1LhpwlBxgl4
   VNflmiAZ3haBDTsqxBbbpSPK5QC/VoTAkYA/maEHOYFzezNvlR/HbCR1m
   l0LAICYrKV/m4xkRseJCH3jx+sn6ztdQJFYZOYduScu+n6UZsPNgJmQmw
   1qchPP7G4W7L5Mw+YjRlrL87mCBKrp2QHh6dxj/wKu5KSOxhDUgu0nZU9
   qwW7RtYtyU3ky8Wkv1CXG67vg2aavcYC1nr4NqKxny5qJ6Vu53gmAaKn3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="385427222"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="385427222"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087133794"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087133794"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:33 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 0/3] Replace acpi_driver with platform_driver
Date:   Mon, 16 Oct 2023 20:01:22 +0300
Message-ID: <20231016170125.576159-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

[1] - https://lore.kernel.org/linux-acpi/20231011083334.3987477-1-michal.wilczynski@intel.com/T/#t

Michal Wilczynski (3):
  ACPI: acpi_pad: Replace acpi_driver with platform_driver
  ACPI: acpi_pad: Use dev groups for sysfs
  ACPI: acpi_pad: Rename ACPI device from device to adev

 drivers/acpi/acpi_pad.c | 93 +++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 55 deletions(-)

-- 
2.41.0

