Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9777E7915CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351418AbjIDKnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjIDKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:43:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5954191;
        Mon,  4 Sep 2023 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693824179; x=1725360179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KG2QeDOlI8MHwoCPiPd6JfLSLSr0kBD/fqXSBY4+KyQ=;
  b=Uk6LKvYlA+UvUUUOjLLbyzwrv4wCfCtCkSLV3131fj9GmXa6V2Nz9UAq
   bwhQTiZPBsbpmmet5J1ulq7H0mT/n6RlEvBjaMEOIoEdy6iEz4Bf06pdk
   HIfRhChwvoDjoEv85vBOG38+ngdVAuyl583iFCeFVrV0bvTRO81InUgoO
   g8VFlvMZivQV3x2W+7vC2xetPV+P/MLsX8ZymjOy9aHoY6i/FIpUBTzeX
   St1rGEdxCgYDMF9Egvz6t4ON0FfexsaJg9DnXRfbDD5DGYgxcW70iCgla
   6WhR8JKqmGeSvwaYkgOIi/y88p+HIuUYcDpxCKLnc3hhM2od8loocl/jp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="407570314"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="407570314"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="855567438"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="855567438"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2023 03:40:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0ED14892; Mon,  4 Sep 2023 13:40:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] device property: Clarify usage scope of some struct fwnode_handle members
Date:   Mon,  4 Sep 2023 13:40:46 +0300
Message-Id: <20230904104046.1682875-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the struct fwnode_handle members are for exclusive use with
device links framework. Clarify this by adding a respective comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/fwnode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 5700451b300f..2a72f55d26eb 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -41,6 +41,8 @@ struct device;
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
 	const struct fwnode_operations *ops;
+
+	/* The below is used solely by device links, don't use otherwise */
 	struct device *dev;
 	struct list_head suppliers;
 	struct list_head consumers;
-- 
2.40.0.1.gaa8946217a0b

