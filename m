Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECAE7B543F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbjJBNql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbjJBNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:46:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388EDB4;
        Mon,  2 Oct 2023 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254395; x=1727790395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fKsmYxDNJP3z4B97CHI1LWKlpncnoj+xMxMwB4r88HA=;
  b=gNq37D21mMZdN4RE1zDjmNEnpEYgzlnitBZKj+kWiaxotQVWBWZ2NfvX
   9XzbsKCmR0pPO3FCF5vjc0KAb7xkFNjL74WhlLfuNhFznHnrR06VjK9m5
   0p/HDwXDiSKaZtbaYMm5bqvsxSDD4W9JOtCS22ocMNTLUzb1A9fhuTawd
   /cxZ5n/c8HmLHZdoV9lXiPaaY3WYwECm2x0GGqGbiJV+jEQWaXMlLLkF3
   C8uyHI04zs5ffV5IhPn7+SVUxcs11zxTW9IFJkHMwpblBd+LVPhI11J7d
   IO0hk4B8w9/9AFzCkNBzvPlFuHOQgCg5x+9PgoZRttOOeTWcOzlgXR9+l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382551430"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382551430"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997622359"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997622359"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Oct 2023 06:46:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C196B65; Mon,  2 Oct 2023 16:46:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/2] ACPI: property: Document the _DSD data buffer GUID
Date:   Mon,  2 Oct 2023 16:46:30 +0300
Message-Id: <20231002134630.2601294-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231002134630.2601294-1-andriy.shevchenko@linux.intel.com>
References: <20231002134630.2601294-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the rest of the GUIDs document one for _DSD data buffer
so it will be eaisier to search for on internet or documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 06550d8c619d..92f017cc897a 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -55,6 +55,7 @@ static const guid_t ads_guid =
 	GUID_INIT(0xdbb8e3e6, 0x5886, 0x4ba6,
 		  0x87, 0x95, 0x13, 0x19, 0xf5, 0x2a, 0x96, 0x6b);
 
+/* ACPI _DSD data buffer GUID: edb12dd0-363d-4085-a3d2-49522ca160c4 */
 static const guid_t buffer_prop_guid =
 	GUID_INIT(0xedb12dd0, 0x363d, 0x4085,
 		  0xa3, 0xd2, 0x49, 0x52, 0x2c, 0xa1, 0x60, 0xc4);
-- 
2.40.0.1.gaa8946217a0b

