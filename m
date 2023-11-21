Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857917F2843
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjKUJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjKUJBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:01:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5DFA2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700557275; x=1732093275;
  h=message-id:from:to:cc:date:subject:mime-version:
   content-transfer-encoding;
  bh=WtMnoPQw8jmr+KVFHgX5oIwyIKOjwli1L11stu8h5u0=;
  b=Diafj5shm4we4CKM+gEJAmPKdie6VFAOpJrmimXWtQ2SgKlZb0LAj498
   Xbqn1QcoibP6vSgy6cPDTNfmP9HyPMOVOfnVBt+NxMp82VTTXgzHJV1lA
   f5ej/wP648wzyMus0OXOC0YsvCiYL0zOQucpMIgn1UtK5eBiHS4rKya2k
   BwAT1btpbTvBd1nGFx+R1uGvXsiQDoKkYKQqA9boeVRwn0nC2LuAy4wnx
   yeJ2HrMn+V2WwdVx3JkSlK38QldynkzicK+e2ZYk9kVMcWIOCDmxGdjX/
   PpOD6c2cZyPJnWqOxV//6/dOHQobV0OA3jyhd6Frmxv9s37U3/Lz4b8WD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4923496"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4923496"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:01:14 -0800
Message-Id: <cdf76a$dogiv@smtpauth.intel.com>
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14434911"
Received: from wpastern-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.57.17])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:01:12 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Date:   Tue, 21 Nov 2023 10:56:09 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.7-2
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

Just a few fixes (one with two non-fix deps) plus tidying up MAINTAINERS.

Regards, i.


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-2

for you to fetch changes up to a6584711e64d9d12ab79a450ec3628fd35e4f476:

  platform/x86: intel_telemetry: Fix kernel doc descriptions (2023-11-21 10:09:04 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.7-2


The following is an automated shortlog grouped by driver:

amd/pmc:
 -  adjust getting DRAM size behavior

hp-bioscfg:
 -  Fix error handling in hp_add_other_attributes()
 -  move mutex_lock() down in hp_add_other_attributes()
 -  Remove unused obj in hp_add_other_attributes()
 -  Simplify return check in hp_add_other_attributes()

ideapad-laptop:
 -  Set max_brightness before using it

intel_telemetry:
 -  Fix kernel doc descriptions

MAINTAINERS:
 -  Drop Mark Gross as maintainer for x86 platform drivers
 -  Remove stale entry for SBL platform driver

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/x86: intel_telemetry: Fix kernel doc descriptions

Hans de Goede (1):
      MAINTAINERS: Drop Mark Gross as maintainer for x86 platform drivers

Harshit Mogalapalli (4):
      platform/x86: hp-bioscfg: Simplify return check in hp_add_other_attributes()
      platform/x86: hp-bioscfg: move mutex_lock() down in hp_add_other_attributes()
      platform/x86: hp-bioscfg: Fix error handling in hp_add_other_attributes()
      platform/x86: hp-bioscfg: Remove unused obj in hp_add_other_attributes()

Jithu Joseph (1):
      MAINTAINERS: Remove stale entry for SBL platform driver

Shyam Sundar S K (1):
      platform/x86/amd/pmc: adjust getting DRAM size behavior

Stuart Hayhurst (1):
      platform/x86: ideapad-laptop: Set max_brightness before using it

 MAINTAINERS                                  |  4 ----
 drivers/platform/x86/amd/pmc/pmc.c           | 31 ++--------------------------
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 26 ++++++++++-------------
 drivers/platform/x86/ideapad-laptop.c        | 11 +++++-----
 drivers/platform/x86/intel/telemetry/core.c  |  4 ++--
 5 files changed, 20 insertions(+), 56 deletions(-)
