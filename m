Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF01F7B6825
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbjJCLlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjJCLlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:41:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D289E;
        Tue,  3 Oct 2023 04:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696333267; x=1727869267;
  h=from:to:cc:subject:date:message-id;
  bh=iYtGi3g9SpfQNJLD1PWbsIV5l/YhBnRKJ30F72JkouU=;
  b=NQZxaomu6ljZyyCmZMYFkCVmBvUsd4spgnsQB/fboyeXRFPNpMWFEeER
   UzPZ/mWOOvr6vdscN9y/crqIH/JkbubOpmiWiL12kj3XjZspDQcpdKATO
   +e3dR8SOHwJLe8S/LIAuRqVKFwrOJI8B7mSaQfFw7faKyLwgIsLAnLzh9
   7lN2EvUwCepuwipzrZTRjDTLRd3X3vF1BKoJoO3AK8LJ+Xk7yZEnROrO0
   pRJ9rKdwg9HqZGzVzpLUkAhIk/4Y4hjggZ8vEg0MG+2amLhApE/U0dS1M
   kU9+IvTGBR24zvHE3HuAkLUrg7k4EWTsVKViuMYrflCWmBa686TYDQ11q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1444100"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1444100"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 04:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="786070218"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="786070218"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2023 04:40:50 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/2] Drop runtime PM support for Baytrail and Lynxpoint pinctrl
Date:   Tue,  3 Oct 2023 17:10:34 +0530
Message-Id: <20231003114036.27674-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes runtime PM support for the devices that are not
explicitly attached to acpi_lpss_pm_domain as it is dead code anyway.

This has no functional impact and helps reduce their code and memory
footprint.

bloat-o-meter:
==============

Baytrail:
add/remove: 2/4 grow/shrink: 0/3 up/down: 49/-103 (-54)
Total: Before=16104, After=16050, chg -0.34%

Lynxpoint:
add/remove: 7/10 grow/shrink: 1/3 up/down: 152/-223 (-71)
Total: Before=7506, After=7435, chg -0.95%

Changes since v1:
- Add missing pm.h

Raag Jadav (2):
  pinctrl: baytrail: drop runtime PM support
  pinctrl: lynxpoint: drop runtime PM support

 drivers/pinctrl/intel/pinctrl-baytrail.c  | 19 ++------------
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 32 +++--------------------
 2 files changed, 5 insertions(+), 46 deletions(-)

-- 
2.17.1

