Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046867BFE35
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjJJNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjJJNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:42:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C413A10FE;
        Tue, 10 Oct 2023 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696945225; x=1728481225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XgsVgCZAuytkZmmW6oOHBDJJnZdufzsQiRpSM2n44YE=;
  b=gs4NceA2E1yjZfx0fHjDB26/Obbz+BdCu49jnypjjVCY+62qBzT9374e
   fqyC7jM66WYQeEDQQgd3ZwyqAfcv6vwvKL4M9/PRcr1n3HJaK+iCZDecq
   PKlX07n7y+kkT8JJ22n/t/MEgVbrdOowHsyUZMLDEdCxQsQjf9jZN8J/J
   oxSXVEJ3DjvmIfyjZYvmgipEYNt2c/DrHxJ9NHAwhHEhAkyDCIUEBvWMW
   HRw82qcY3moqINq4AUv47IMqnson5QAHikRJi2U11paYbt714lLEZe3oZ
   sRJOrvDqF6AGDZMzpyioY1XvLRDP9iU14xuIuorlowg0o7r4J1tZD+p9H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387232371"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="387232371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:40:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="819235562"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="819235562"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 10 Oct 2023 06:40:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B621B35A; Tue, 10 Oct 2023 16:40:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v5 1/1] platform/x86: asus-wireless: Replace open coded acpi_match_acpi_device()
Date:   Tue, 10 Oct 2023 16:40:19 +0300
Message-Id: <20231010134019.3892062-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded acpi_match_acpi_device() in asus_wireless_add().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v5: updated subject (Ilpo)
v4: used proper API, added tag (Hans)
v3: rewrote error path logic (Hans)
v2: fixed compilation error

 drivers/platform/x86/asus-wireless.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index abf01e00b799..41227bf95878 100644
--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -148,16 +148,12 @@ static int asus_wireless_add(struct acpi_device *adev)
 	if (err)
 		return err;
 
-	for (id = device_ids; id->id[0]; id++) {
-		if (!strcmp((char *) id->id, acpi_device_hid(adev))) {
-			data->hswc_params =
-				(const struct hswc_params *)id->driver_data;
-			break;
-		}
-	}
-	if (!data->hswc_params)
+	id = acpi_match_acpi_device(device_ids, adev);
+	if (!id)
 		return 0;
 
+	data->hswc_params = (const struct hswc_params *)id->driver_data;
+
 	data->wq = create_singlethread_workqueue("asus_wireless_workqueue");
 	if (!data->wq)
 		return -ENOMEM;
-- 
2.40.0.1.gaa8946217a0b

