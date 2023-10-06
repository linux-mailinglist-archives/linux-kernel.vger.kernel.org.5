Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016A07BB767
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjJFMP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjJFMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:15:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECF3C6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696594553; x=1728130553;
  h=from:to:cc:subject:date:message-id;
  bh=NdTc3/DUxfAV3N4tPE4vGkhnkzQ8RRiJjrrmEKPFfSI=;
  b=Hi2zS3a8oPVlEyxYGSgnsfKEBk7ohsPQQbLwA/IW6/0vQAn2jvwPOvES
   ftSwVLHJg3Niz3B6mS6tNmd4MG96OrPJv/IRRagGVwHD2IIcMxYEYFInD
   jXqI5eEz/XlqSLXoOZcBDewacRrm2sCOh+Hdg8ctFgl8IbpgDHUV9Erc1
   0jXvAu64tbQdag9hIEKl5d1cEwKf3yYA2OXwViVH9hHTOv98nwZ+J0FG8
   qZUdQaT70ozVHH5U7uubNX+IFRWXMcvCVc9V41M3DRbMSSCryK1eUkp9N
   3o3DuH1++LLrq4cbXhO/VPNfSaaGNMwxe+T0zAJ6FX78UuzO2PeTQdZQr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386560892"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="386560892"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 05:15:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="781638826"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="781638826"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2023 05:15:32 -0700
From:   lakshmi.sowjanya.d@intel.com
To:     linux-kernel@vger.kernel.org, giometti@enneenne.com
Cc:     andriy.shevchenko@linux.intel.com, pandith.n@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: [PATCH v1] Documentation: driver-api: pps: Update PPS generator documentation
Date:   Fri,  6 Oct 2023 17:45:31 +0530
Message-Id: <20231006121531.22450-1-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

PPS documentation has a generalized section for generators. Update the
section so any new generator documentation can be appended.

Signed-off-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 Documentation/driver-api/pps.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 2d6b99766ee8..78dded03e5d8 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -200,11 +200,17 @@ Generators
 
 Sometimes one needs to be able not only to catch PPS signals but to produce
 them also. For example, running a distributed simulation, which requires
-computers' clock to be synchronized very tightly. One way to do this is to
-invent some complicated hardware solutions but it may be neither necessary
-nor affordable. The cheap way is to load a PPS generator on one of the
-computers (master) and PPS clients on others (slaves), and use very simple
-cables to deliver signals using parallel ports, for example.
+computers' clock to be synchronized very tightly.
+
+
+Parallel port generator
+------------------------
+
+One way to do this is to invent some complicated hardware solutions but it
+may be neither necessary nor affordable. The cheap way is to load a PPS
+generator on one of the computers (master) and PPS clients on others
+(slaves), and use very simple cables to deliver signals using parallel
+ports, for example.
 
 Parallel port cable pinout::
 
-- 
2.17.1

