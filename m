Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08447CA529
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjJPKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJPKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:19:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3407B4;
        Mon, 16 Oct 2023 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697451596; x=1728987596;
  h=from:to:cc:subject:date:message-id;
  bh=QREbj1c18eNe5Kf8EeCr5BxaKxdLOo747K7h+2jlT1M=;
  b=ClAYZ8NpTxSKq4YXtJRHlz6CnCi9oa/rXTzBpfgzROkQEBGRQcpfmcHP
   6RKlYSq2Jo6xyjl55COClh7n9Aqp6yvVOjIgZw6m4bnJKJviYtFIaiqie
   gmM64XDipirCXHhzpq6lmalu7h2YBumttsbIIs8HJR1P3hmYQrbGEwqLA
   fu91y3cAiy1Ezsi1IJVDzxHaSRV4pVy4vO5nfu0XtrnbazIHiAWMkItZk
   oLRdaAmjfDgnDV9vqid/aRCWPJ6qub2ZBG88DevHuWPZOpZkN4DOOCy4i
   92vCtxp1s9spvc5IHMkbUvdOn6rv7L6CL3F941WVp1GEBUVRlZlZq53vE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365750296"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="365750296"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 03:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="846343306"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="846343306"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2023 03:19:54 -0700
From:   lakshmi.sowjanya.d@intel.com
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     giometti@enneenne.com, corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, pandith.n@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: [PATCH v1] Documentation: driver-api: pps: Update PPS generator documentation
Date:   Mon, 16 Oct 2023 15:49:53 +0530
Message-Id: <20231016101953.27308-1-lakshmi.sowjanya.d@intel.com>
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

From: Pandith N <pandith.n@intel.com>

PPS documentation has a generalized section for generators. Update the
section so any new generator documentation can be appended.

Signed-off-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
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

