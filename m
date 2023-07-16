Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711C1754D95
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 09:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGPHF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 03:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPHFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 03:05:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2FB10E6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 00:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689491153; x=1721027153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2beqYwD+TQZ5BadpuhT7EafWDOxBDuJT6/rgBzXqHXE=;
  b=JNCyKbpnJzA7mumPS1VsSphLuC8sd5BeWoHfLis9lDFUi9qrA6G6hIx7
   WJZC871nlXJ6NRPrRnSidAmK9nFXwxcMqEpanYIAVGrOrLOnIkqHTNQLi
   LiwQZuCTJjfPBIOlkFaytbxXgZLpUW1eMybtWN3rKtRFDMWjgmCot7If5
   XZu4MhxgdrWiasMDWG5kdWPuMhhI9X3O/ZYuWDpn7Zws3HFL6GJ1fOddU
   mHqKxIOQyYmyP/26RttW7RV6/agsvqRaGq0g9nbzqXCuNP1rXct4R1Xfk
   VkvrZ1bUA5DG828BIpYYDevxsVBY5djGf3ft0HSHQaJaHw1d6a/9VLo5G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="363196414"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="363196414"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 00:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="788273358"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="788273358"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jul 2023 00:05:51 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH 0/2] Query the RSU SPT table offset to determine RSU page size
Date:   Sun, 16 Jul 2023 15:04:33 +0800
Message-Id: <cover.1689490408.git.kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Hi,
This patchset is to add the generic mailbox command in the svc driver
to enable the rsu driver to query spt address.
SPT0 address - lower range & SPT1 address - upper range address will be
queried in order to determine the page size of RSU, whether it is
32kB or 64kB that is supported.

Thanks,
KJ

changelog v2:
-Update the comment on svc COMMAND_MBOX_SEND_CMD
-Update the rsu mailbox cmd ret_val to use already defined ret

Radu Bacrau (1):
  firmware: stratix10-rsu: query spt addresses

Teh Wen Ping (1):
  firmware: stratix10-svc: Generic Mailbox Command

 drivers/firmware/stratix10-rsu.c              | 100 +++++++++++++++++-
 drivers/firmware/stratix10-svc.c              |  18 ++++
 include/linux/firmware/intel/stratix10-smc.h  |  25 +++++
 .../firmware/intel/stratix10-svc-client.h     |   5 +
 4 files changed, 147 insertions(+), 1 deletion(-)


base-commit: 5133c9e51de41bfa902153888e11add3342ede18
-- 
2.25.1

