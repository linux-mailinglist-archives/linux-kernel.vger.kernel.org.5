Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5737D7A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJZBrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjJZBrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:47:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A27CE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:47:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so310538276.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698284854; x=1698889654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Js4XprMdTI6hSlDAn2ukBGBbLII8ZoL1rfyHAKO62Tw=;
        b=gMbUAE6VJ9LRevEU2cEMY9Ai+3kRndvKKTV7f9LaPUUaeoLQ+Fei03yU1jF4uGxN9m
         F7bHh0R32hd81V4x5X+OuvqqPhZ2LF3f6ehaCeXGYaxa/J28zYwgtW2IxTE28l7P59CC
         JJUINJT+5pMm9vtlst6uay5/xog+9ovwNObg7+BW6u9dnD8KOYzspK0BiUvgD3k3oWog
         ueW7RwJYUI28ExiGVHqXqXEyTlP5+n/v8QU0zWKrxj1/wMUkURRfe/ek+Kr4DdqN77fu
         zMePyouhQluf50aQKODKpVwp8M96MQin7OYq95JV7CTbln2xouuZ0ad6pJXaaJpRloDY
         cRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698284854; x=1698889654;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Js4XprMdTI6hSlDAn2ukBGBbLII8ZoL1rfyHAKO62Tw=;
        b=gWtFLt231r2lei1LkcaV0wUvxRdRbuOEZCEhcPBFxUUx0YuTrHVgOlvvxKwRMZevDY
         GxxeneervvYbSR1muwqvLaPlLO/71xW0eYB+Om8aed8W6JL+eoMk0z3EwQkTuyG+clo/
         JH0uUsQlza1Ck2YFJrMsWNixFbEYUMyyXdBK5n6irYCjfmpEuRAybhqEWqTtXON9lUSy
         L9rCfw81qDz1dCH6K1sckzZA+a5McIUoAHHDw7vBh0LvgpIs4uhzZqryUR5vw2jsBvXw
         bf8Exjxv56ipI2ruETKr5LTUMrKLYF+RoNky2m1yjrIT2FuWgFtBtRPABKPEUF9YCzkS
         CaMA==
X-Gm-Message-State: AOJu0YwfZhFmLLLxQcBtwJ1OOLBSbGZdP3VVHe5AawqU933HxmrcIq/4
        BfRKy/vii8Urhi1N/VF7IpGRxt+21pg+Is4Tig==
X-Google-Smtp-Source: AGHT+IH/jjucq3mK5/RG1QvlV2wevNMUr5W6d0xM2J/lYpgC6Ebxs2KJJbuAVcz7lyjK9pygZZGjxa04MoN07qHUqQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:243:0:b0:d9a:5e8f:1562 with SMTP
 id 64-20020a250243000000b00d9a5e8f1562mr316938ybc.6.1698284853737; Wed, 25
 Oct 2023 18:47:33 -0700 (PDT)
Date:   Thu, 26 Oct 2023 01:47:32 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADTFOWUC/x3MQQqEMAwAwK9Izga0ysr6FfHQpnHNpZZERBH/b
 tnjXOYGYxU2GKsblA8x2VJBW1dAq08/RonF4BrXtY37oO2aKF8YVQ5WQyMTXLN5JOwpDCH2/A3 DAmXIyouc/32an+cFmqrP/20AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698284852; l=5190;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=AKejiU2rH/fybS/397SBwIybgBTb+KL0HploXuRamMk=; b=tA3DghjZOpNWy8m2pqqzyD5dpHovEGZXzhUoYwF0HmXrNd6rndmettjevOZlgbejRYFU2U60l
 m/ukhhYipVaAbeMBjkysS1X1e+HWqFD14bCU1Jhm3unSKXjRn5hhdpT
X-Mailer: b4 0.12.3
Message-ID: <20231026-strncpy-drivers-scsi-hpsa-c-v1-1-75519d7a191b@google.com>
Subject: [PATCH] scsi: hpsa: replace deprecated strncpy with strscpy/kmemdup_nul
From:   Justin Stitt <justinstitt@google.com>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

This whole process of 1) determining smaller length so we don't overread
the buffer and 2) manually NUL-terminating our buffer so we can use in
string APIs is handled implicitly by strscpy().

Therefore, a suitable replacement is `strscpy` [2] due to the fact that
it guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

For the last two strncpy() use cases in init_driver_version(), we can
actually drop this function entirely.

Firstly, we are kmalloc()'ing driver_version. Then, we are calling
init_driver_version() which memset's it to 0 followed by a strncpy().
This pattern of 1) allocating memory for a string, 2) setting all bytes
to NUL, 3) copy bytes from another string + ensure NUL-padded
destination is just an open-coded kmemdup_nul().

The last case involves swapping kmalloc_array() for kcalloc() to give us
a zero-filled two-element array for both old_driver_version and
driver_version without needing the memset from init_driver_version().

Now this code is easier to read and less fragile (no more ... - 1's) or
min length checks and now we have guaranteed NUL-termination everywhere!

Although perhaps there should be a macro for:

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/hpsa.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..3376d4614fe5 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -452,16 +452,15 @@ static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	int status, len;
+	int status;
 	struct ctlr_info *h;
 	struct Scsi_Host *shost = class_to_shost(dev);
 	char tmpbuf[10];
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
-	strncpy(tmpbuf, buf, len);
-	tmpbuf[len] = '\0';
+	strscpy(tmpbuf, buf, count);
+
 	if (sscanf(tmpbuf, "%d", &status) != 1)
 		return -EINVAL;
 	h = shost_to_hba(shost);
@@ -476,16 +475,15 @@ static ssize_t host_store_raid_offload_debug(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	int debug_level, len;
+	int debug_level;
 	struct ctlr_info *h;
 	struct Scsi_Host *shost = class_to_shost(dev);
 	char tmpbuf[10];
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
-	strncpy(tmpbuf, buf, len);
-	tmpbuf[len] = '\0';
+	strscpy(tmpbuf, buf, count);
+
 	if (sscanf(tmpbuf, "%d", &debug_level) != 1)
 		return -EINVAL;
 	if (debug_level < 0)
@@ -7234,24 +7232,19 @@ static int hpsa_controller_hard_reset(struct pci_dev *pdev,
 	return 0;
 }
 
-static void init_driver_version(char *driver_version, int len)
-{
-	memset(driver_version, 0, len);
-	strncpy(driver_version, HPSA " " HPSA_DRIVER_VERSION, len - 1);
-}
-
 static int write_driver_ver_to_cfgtable(struct CfgTable __iomem *cfgtable)
 {
 	char *driver_version;
 	int i, size = sizeof(cfgtable->driver_version);
 
-	driver_version = kmalloc(size, GFP_KERNEL);
+	driver_version = kmemdup_nul(HPSA " " HPSA_DRIVER_VERSION, size,
+				     GFP_KERNEL);
 	if (!driver_version)
 		return -ENOMEM;
 
-	init_driver_version(driver_version, size);
 	for (i = 0; i < size; i++)
 		writeb(driver_version[i], &cfgtable->driver_version[i]);
+
 	kfree(driver_version);
 	return 0;
 }
@@ -7271,7 +7264,7 @@ static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
 	char *driver_ver, *old_driver_ver;
 	int rc, size = sizeof(cfgtable->driver_version);
 
-	old_driver_ver = kmalloc_array(2, size, GFP_KERNEL);
+	old_driver_ver = kcalloc(2, size, GFP_KERNEL);
 	if (!old_driver_ver)
 		return -ENOMEM;
 	driver_ver = old_driver_ver + size;
@@ -7279,7 +7272,7 @@ static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
 	/* After a reset, the 32 bytes of "driver version" in the cfgtable
 	 * should have been changed, otherwise we know the reset failed.
 	 */
-	init_driver_version(old_driver_ver, size);
+	strscpy(old_driver_ver, HPSA " " HPSA_DRIVER_VERSION, size);
 	read_driver_ver_from_cfgtable(cfgtable, driver_ver);
 	rc = !memcmp(driver_ver, old_driver_ver, size);
 	kfree(old_driver_ver);

---
base-commit: d88520ad73b79e71e3ddf08de335b8520ae41c5c
change-id: 20231026-strncpy-drivers-scsi-hpsa-c-4cb7bd4e9b7f

Best regards,
--
Justin Stitt <justinstitt@google.com>

