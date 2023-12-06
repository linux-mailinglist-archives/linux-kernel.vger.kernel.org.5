Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F83807767
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378263AbjLFSSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjLFSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:18:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C0C122;
        Wed,  6 Dec 2023 10:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701886741; x=1733422741;
  h=message-id:from:to:cc:date:subject:mime-version:
   content-transfer-encoding;
  bh=AjWaynjB6BwzY7AYH7vrj+BELK9rrS3DfBe8Dk50PP8=;
  b=RLdHk6hHCN26dgxygYcDYhYCplNTcPFamaK3JMgRYv/W0gv1Ws1SwlWT
   9tAavhIEiUuzfB1ywstccNZcWmKOVN/OLwcUbtnOoaGYVPoGee+KFfdnJ
   pMFZA8dBH7U2cwF0mngLkblqb1my1DdwvBJD+lcQwE3kKe4YIBkUIqvTC
   7AVDIkL8Dl/yQSW9M+p/cgGmL4eSQf0Ov+i+yq1HEhKGwwKSDrgtJpfrf
   T818YxFDbL0Gtsjv34R/UrJxd+34neyOOBTz1HQYBTjyA1fWD8SpdM4MC
   rr+Cutg8OchE+GP1XV/Zl3RA7Dp/NzfPns1lGBuHbYWbhDDMpo6bBSRSi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7453633"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="7453633"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 10:19:00 -0800
Message-Id: <8536f9$c6m0b@orviesa002-auth.jf.intel.com>
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="12802059"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.211])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 10:18:56 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        PDx86 <platform-drivers-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Date:   Wed, 06 Dec 2023 20:16:52 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.7-3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a fixes PR for platform-drivers-x86 for v6.7.

Highlights:
- asus-wmi:	    Solve i8042 filter resource handling, input, and
		    suspend issues
- wmi:		    Skip zero instance WMI blocks to avoid issues with
		    some laptops
- mlxbf-bootctl:    Differentiate dev/production keys
- platform/surface: Correct serdev related return value to avoid
		    leaking errno into userspace
- Error checking fixes

Regards, i.


The following changes since commit a6584711e64d9d12ab79a450ec3628fd35e4f476:

  platform/x86: intel_telemetry: Fix kernel doc descriptions (2023-11-21 10:09:04 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-3

for you to fetch changes up to 3494a594315b56516988afb6854d75dee5b501db:

  platform/mellanox: Check devm_hwmon_device_register_with_groups() return value (2023-12-04 15:01:46 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.7-3

Highlights:
- asus-wmi:	    Solve i8042 filter resource handling, input, and
		    suspend issues
- wmi:		    Skip zero instance WMI blocks to avoid issues with
		    some laptops
- mlxbf-bootctl:    Differentiate dev/production keys
- platform/surface: Correct serdev related return value to avoid
		    leaking errno into userspace
- Error checking fixes

The following is an automated shortlog grouped by driver:

asus-wmi:
 -  Change q500a_i8042_filter() into a generic i8042-filter
 -  disable USB0 hub on ROG Ally before suspend
 -  Filter Volume key presses if also reported via atkbd
 -  Move i8042 filter install to shared asus-wmi code

mellanox:
 -  Add null pointer checks for devm_kasprintf()
 -  Check devm_hwmon_device_register_with_groups() return value

mlxbf-bootctl:
 -  correctly identify secure boot with development keys

surface: aggregator:
 -  fix recv_buf() return value

wmi:
 -  Skip blocks with zero instances

----------------------------------------------------------------
Armin Wolf (1):
      platform/x86: wmi: Skip blocks with zero instances

David Thompson (1):
      mlxbf-bootctl: correctly identify secure boot with development keys

Francesco Dolcini (1):
      platform/surface: aggregator: fix recv_buf() return value

Hans de Goede (3):
      platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code
      platform/x86: asus-wmi: Change q500a_i8042_filter() into a generic i8042-filter
      platform/x86: asus-wmi: Filter Volume key presses if also reported via atkbd

Kunwu Chan (2):
      platform/mellanox: Add null pointer checks for devm_kasprintf()
      platform/mellanox: Check devm_hwmon_device_register_with_groups() return value

Luke D. Jones (1):
      platform/x86: asus-wmi: disable USB0 hub on ROG Ally before suspend

 drivers/platform/mellanox/mlxbf-bootctl.c  | 39 ++++++++++++-------
 drivers/platform/mellanox/mlxbf-pmc.c      | 14 +++++++
 drivers/platform/surface/aggregator/core.c |  5 ++-
 drivers/platform/x86/Kconfig               |  2 +-
 drivers/platform/x86/asus-nb-wmi.c         | 61 +++++++++++++++++++-----------
 drivers/platform/x86/asus-wmi.c            | 58 ++++++++++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |  7 ++--
 drivers/platform/x86/wmi.c                 |  5 +++
 include/linux/platform_data/x86/asus-wmi.h |  3 ++
 9 files changed, 153 insertions(+), 41 deletions(-)
