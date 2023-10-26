Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3D7D8C15
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjJZXNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjJZXNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:13:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF43C1AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:13:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a45e7e0f9so1116443276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698362023; x=1698966823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HFiYbHBnckwihvKNnIEzm/rfvH9bcBh1GF02ZnqdljM=;
        b=bN4zFCBY2JVStE89J87k/8Jm1cMxIQfefsBJ2xunT7VToOgjuBzdx73ZAraKPT+5z6
         TKJM1KmHKnajoOgoq5vajdS7vSqgVkf6GldMKRnEAw20OY3ehqBY6SbBi3HvH4iD4FtX
         MyAacJfkCKC99gAJ4PZ/tI55WUTx5r9e7vh9yC3tzYGkQLmIlYG10A6+aSp2T/8irdhT
         BB1lgMKQGFbU6SQckwaXNT81ClFlogDsvLEpeiz6naIY5onKQZPhFXsKZ9UacR7is1vZ
         icRC+g3zVYnVsotB+rpSWJ4Qwz9Em8sa7WfS+vXe75ZEo50uGENyT7/8+nnxe8dP2P3F
         p6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698362023; x=1698966823;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFiYbHBnckwihvKNnIEzm/rfvH9bcBh1GF02ZnqdljM=;
        b=RJctQGz3cazscXLMB7plm1Sy+50OEvLzIKgSypL0vNLDjOMOz/UkZvdw/OeSt6afqy
         js4zTg2RcYcVaDaN6CZmYodVOikgjYcmg6l2wTBrN3XKHSp6OFH74+L0taHuvBqqH69u
         zAOf7LNWwUINfcai9gVc964Sqg/fQlRhnaqZMhaWsU8cAnL0uz8sI1fWBpilwAMmXdGp
         2LcedKAJ+b8XFyCZ8yym3GBdt6uix0j+Zi5Z/5Oq2dh18isd30IILZedql9keJ2q5Hf4
         gvkB8+MZLFvtTT71tXb6gk1TarUatN0wTWrZlJ8eVT5A+38Tl6cx5yoxVKDVNWUqsSnE
         VnTg==
X-Gm-Message-State: AOJu0YyK8UI2iS93hnd8ktnCqx2G/mn/Z2/MRfVhkhZdXM8PScmuPLt8
        3Avle+zW76zyi3t3PBymznTiqzkunXSEZ9ZJYw==
X-Google-Smtp-Source: AGHT+IEbj/4BJ8b1hPqD/NX25gwqtVhAmHTTpu9NZP2j6GhL2fKwNIRSfM1OPid7YKbd48tyWmUJ9qcmHeD3xmsLjw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:5509:0:b0:da0:5e08:5c71 with SMTP
 id j9-20020a255509000000b00da05e085c71mr18091ybb.5.1698362023143; Thu, 26 Oct
 2023 16:13:43 -0700 (PDT)
Date:   Thu, 26 Oct 2023 23:13:41 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKTyOmUC/43NQQ6CMBCF4auQrh1DK9jginsYFrQdYBKlZIY0E
 sLdrZzA5fcW/9uVIBOKehS7YkwkFOcMcymUn/p5RKCQrUxpbro0d5CVZ79sEJgSsoB4IZgW6cF
 D5Z11ocLG2UHlwsI40OesP7vsiWSNvJ1nSf/W/7pJgwZb17oJtteNdu0Y4/jCq49v1R3H8QWR1 dYsxwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698362022; l=5530;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=vKXzL31/mEChO1m4jkNSZ9EryWsuWIfXEfMiSRto9RY=; b=O7JSLUVSbnMyjX4uJV6/3PWg9N26ln+o7xUz1QBQ0rsWPyyaDVCnMLpxqNtKs+loM0rh85JmI
 8o0Q1uLmrjWA9dTB+40R6NqrT19NPe2bOO62sl4f+BLOoIbCnMfBZz3
X-Mailer: b4 0.12.3
Message-ID: <20231026-strncpy-drivers-scsi-hpsa-c-v2-1-2fe2d05122fd@google.com>
Subject: [PATCH v2] scsi: hpsa: replace deprecated strncpy
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Instances of strncpy()'ing a string into a buffer and manually
NUL-terminating followed by sccanf with just "%d" as the format
specifier can be accomplished by strscpy() and kstrtoint().

strscpy() guarantees NUL-termination on the destination buffer and
kstrtoint is better way of getting strings turned into ints.

For the last two strncpy() use cases in init_driver_version(), we can
actually drop this function entirely.

Firstly, we are kmalloc()'ing driver_version. Then, we are calling
init_driver_version() which memset's it to 0 followed by a strncpy().
The pattern is 1) allocating memory for a string, 2) setting all bytes
to NUL, 3) copy bytes from another string + ensure NUL-padded.

For these, we can just stack allocate driver_version and
old_driver_version. This simplifies the code greatly as we don't have
any malloc/free or strncpy's.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use stack for buffers (thanks Kees)
- use kstrtoint (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20231026-strncpy-drivers-scsi-hpsa-c-v1-1-75519d7a191b@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/hpsa.c | 53 ++++++++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..4d42fbb071cf 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -452,18 +452,18 @@ static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
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
-	if (sscanf(tmpbuf, "%d", &status) != 1)
+
+	strscpy(tmpbuf, buf, sizeof(tmpbuf));
+	if (kstrtoint(tmpbuf, 0, &status))
 		return -EINVAL;
+
 	h = shost_to_hba(shost);
 	h->acciopath_status = !!status;
 	dev_warn(&h->pdev->dev,
@@ -476,18 +476,18 @@ static ssize_t host_store_raid_offload_debug(struct device *dev,
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
-	if (sscanf(tmpbuf, "%d", &debug_level) != 1)
+
+	strscpy(tmpbuf, buf, sizeof(tmpbuf));
+	if (kstrtoint(tmpbuf, 0, &debug_level))
 		return -EINVAL;
+
 	if (debug_level < 0)
 		debug_level = 0;
 	h = shost_to_hba(shost);
@@ -7234,25 +7234,15 @@ static int hpsa_controller_hard_reset(struct pci_dev *pdev,
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
-	char *driver_version;
 	int i, size = sizeof(cfgtable->driver_version);
+	char driver_version[sizeof(cfgtable->driver_version)] =
+						HPSA " " HPSA_DRIVER_VERSION;
 
-	driver_version = kmalloc(size, GFP_KERNEL);
-	if (!driver_version)
-		return -ENOMEM;
-
-	init_driver_version(driver_version, size);
 	for (i = 0; i < size; i++)
 		writeb(driver_version[i], &cfgtable->driver_version[i]);
-	kfree(driver_version);
+
 	return 0;
 }
 
@@ -7268,21 +7258,18 @@ static void read_driver_ver_from_cfgtable(struct CfgTable __iomem *cfgtable,
 static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
 {
 
-	char *driver_ver, *old_driver_ver;
-	int rc, size = sizeof(cfgtable->driver_version);
-
-	old_driver_ver = kmalloc_array(2, size, GFP_KERNEL);
-	if (!old_driver_ver)
-		return -ENOMEM;
-	driver_ver = old_driver_ver + size;
+	char driver_ver[sizeof(cfgtable->driver_version)] = "";
+	char old_driver_ver[sizeof(cfgtable->driver_version)] =
+						HPSA " " HPSA_DRIVER_VERSION;
+	int rc;
 
 	/* After a reset, the 32 bytes of "driver version" in the cfgtable
 	 * should have been changed, otherwise we know the reset failed.
 	 */
-	init_driver_version(old_driver_ver, size);
 	read_driver_ver_from_cfgtable(cfgtable, driver_ver);
-	rc = !memcmp(driver_ver, old_driver_ver, size);
-	kfree(old_driver_ver);
+	rc = !memcmp(driver_ver, old_driver_ver,
+		     sizeof(cfgtable->driver_version));
+
 	return rc;
 }
 /* This does a hard reset of the controller using PCI power management

---
base-commit: d88520ad73b79e71e3ddf08de335b8520ae41c5c
change-id: 20231026-strncpy-drivers-scsi-hpsa-c-4cb7bd4e9b7f

Best regards,
--
Justin Stitt <justinstitt@google.com>

