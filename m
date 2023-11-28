Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935D07FBA31
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344660AbjK1Me5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbjK1Me4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:34:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1245ED4B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701174903; x=1732710903;
  h=from:to:cc:subject:date:message-id;
  bh=wGqGjWnAXZbXb3fYquhsZNbFE3HpVMDhn3OXEVqBg0A=;
  b=QecQFnZiyT7RLfVTOZLT7omZ15FPowgWxcpqMbcS2oPLbFe4NjfQ3czA
   J1y3JSl/CUikbdk+ihCmxphaY+NKQXiVj5Vjbb+djp0B7W8tvYaC5RO6B
   1gPGqjfTt/IOOEngem8Q7gdSjjGrjrBZZdiVdd4nml+H1uLMHLQC6vwRG
   UUa52vHYQitGKL89EIlZkL7IQgLdW3R1jrFE6VkJI96+DpNIrExai1mBE
   oMoWkYIkDI7JkaTqQc5eQR9mVAmOrXkBbiH29Ln2M/05nWmX0frmFFTP5
   Jv4O7eWir4oBCTYh8XdFvTe1/Of0TsH6QT5vQ6eSy7gU/nnDBxnhDsh9u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="373086831"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="373086831"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="9935639"
Received: from shsensorbuild2.sh.intel.com ([10.239.134.197])
  by orviesa002.jf.intel.com with ESMTP; 28 Nov 2023 04:35:00 -0800
From:   Wentong Wu <wentong.wu@intel.com>
To:     gregkh@linuxfoundation.org, tomas.winkler@intel.com,
        hdegoede@redhat.com
Cc:     andriy.shevchenko@linux.intel.com, sakari.ailus@linux.intel.com,
        alexander.usyskin@intel.com, zhifeng.wang@intel.com,
        linux-kernel@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH 0/2] mei: Add support for IVSC device
Date:   Tue, 28 Nov 2023 20:34:04 +0800
Message-Id: <1701174846-16316-1-git-send-email-wentong.wu@intel.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel visual sensing controller (IVSC) device is designed to
control the camera sharing between host IPU for media usage and
IVSC for context sensing (face detection).

IVSC is exposed to host as a SPI device and the protocol used for
communicating with host is MEI. This driver implements the transport
protocol and MEI hardware interfaces for the IVSC device.

The firmware downloading for IVSC device is implemented as well.

Wentong Wu (2):
  mei: Add transport driver for IVSC device
  mei: Add MEI hardware support for IVSC device

 drivers/misc/mei/Kconfig         |  24 ++
 drivers/misc/mei/Makefile        |   7 +
 drivers/misc/mei/platform-vsc.c  | 442 +++++++++++++++++++++
 drivers/misc/mei/vsc-fw-loader.c | 822 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/vsc-tp.c        | 555 ++++++++++++++++++++++++++
 drivers/misc/mei/vsc-tp.h        |  50 +++
 6 files changed, 1900 insertions(+)
 create mode 100644 drivers/misc/mei/platform-vsc.c
 create mode 100644 drivers/misc/mei/vsc-fw-loader.c
 create mode 100644 drivers/misc/mei/vsc-tp.c
 create mode 100644 drivers/misc/mei/vsc-tp.h

-- 
2.7.4

