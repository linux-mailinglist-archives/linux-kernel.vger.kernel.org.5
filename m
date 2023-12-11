Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9990180DB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjLKUGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:06:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60287D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:06:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbc507311d7so3612562276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702325212; x=1702930012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H/z0Ss5XFyvJoTs661LIBp6cShTF2gRz4qVPuHESwH4=;
        b=Jo1gSyWKpASbLjCcWOztaHALyapm3/+VnyckApDHpgz7xb7A/XrcStCgRaAreOnf3P
         pZDDQPIi2OeVWK7E3TAkFqY/7bgMl6OUx0B14Kh87YF/tMEoIwwE+GiqPvDarjLGeKjU
         +z+eW2EybjrRSE/NBS9BlVuE2dLjII3J/l8e3Z4qnvdIpCYXZZdn65s4hyQTod4oBPIN
         3j9vN+WCM9k/pUZhiV6ZT3XFzJRBGXlnKEZnJ20KcTOa6K7D83HfcfSk8ygUTnijak/a
         5/arALioS+gfgwo6K4zl2cY/p4Qw/RUchGhpz5PIcVOxYeF9w2Jv52wiaxbgeEMhmTho
         LBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702325212; x=1702930012;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/z0Ss5XFyvJoTs661LIBp6cShTF2gRz4qVPuHESwH4=;
        b=pEH2do3BBB6HUO4b3SY2nA1Z/XUP7R44BwRFXG+8k/hX5NZRcTsNeZ2Ku7XDAoqFUY
         UsZns3p49COeHbiCto4nAtc9cz/SUU0BOJvBc+LSIrfIJ+cObpwsyCB7iei4dXu5Nt+J
         YSGY+kfJ8cCF6kvEUwKSV4+1xyASXCYUxvBmA0dzTaCnV6xBFCgM8Y4xw9spWDxTGEWK
         91RZ6IicUYmHwIfxWn5JRK4jT9gvs+EeP9ghFoOG6Egq5qsMUbssD4uy4F3YD2TL2nqV
         MD/714JfnzJwrT6A7vnc9u/viHrIX4ocNu8Prc8+75jxFSc6p/5NFtFJI2p8LTMUQE2y
         uZLQ==
X-Gm-Message-State: AOJu0YxQGERarIADEPIQwyKhYdDw0ru5v656XmFMm9ZuUmp52gWMERbb
        aGY4baARFqpeCYQUzwhcJZmjIei7Gc5RJKtNfA==
X-Google-Smtp-Source: AGHT+IHi7DG+3EuXdHK5kIVsRK1zQwJY0+cr+9QAn+IL/5jWC8TAFEd1H552VSUKLgOSUkaLfOFRXQZzJtR7rQmH7g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:f803:0:b0:db4:868a:7fdd with SMTP
 id u3-20020a25f803000000b00db4868a7fddmr34903ybd.7.1702325212490; Mon, 11 Dec
 2023 12:06:52 -0800 (PST)
Date:   Mon, 11 Dec 2023 20:06:28 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMNrd2UC/5WNUQqDMBBEryL73S1JrEX61XuIlJJsdKE1siuhI
 t69qTcoAwNvPuZtoCRMCrdqA6HMymkqYE8V+PE5DYQcCoMzrrbGXVAXmfy8YhDOJIrqlTH6REc
 9dNWo6NGQDTFS69qmgXI2C0X+HKKuLzyyLknWw5vtb/1bkS2WkDHuSmRqF+5DSsOLzj69od/3/ Qv/yJDj3QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702325211; l=3841;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rZMZkomkudUsfqwyDRixYeQW5ARfhWOfNshuF+j5KFg=; b=Khn6RMul5mGMMQgX2HtgBJxmEdbICK7Jkloq1RCDq5aClSb8YlhOXhAz7X788sUUloB6KKHOb
 M7IWjerhyGaAgjLX9/wWgqCslM9+SytVUD3iI6vuPVwT1wgAbEIEk0V
X-Mailer: b4 0.12.3
Message-ID: <20231211-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-73b942238396@google.com>
Subject: [PATCH] scsi: fcoe: use sysfs_match_string over fcoe_parse_mode
From:   Justin Stitt <justinstitt@google.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of copying @buf into a new buffer and carefully managing its
newline/null-terminating status, we can just use sysfs_match_string()
as it uses sysfs_streq() internally which handles newline/null-term:

|  /**
|   * sysfs_streq - return true if strings are equal, modulo trailing newline
|   * @s1: one string
|   * @s2: another string
|   *
|   * This routine returns true iff two strings are equal, treating both
|   * NUL and newline-then-NUL as equivalent string terminations.  It's
|   * geared for use with sysfs input strings, which generally terminate
|   * with newlines but are compared against values without newlines.
|   */
|  bool sysfs_streq(const char *s1, const char *s2)
|  ...

Then entirely drop the now unused fcoe_parse_mode, being careful to
change if condition from checking for FIP_CONN_TYPE_UNKNOWN to < 0 as
sysfs_match_string can return -EINVAL.

To get the compiler not to complain, make fip_conn_type_names
const char * const. Perhaps, this should also be done for
fcf_state_names.

This also removes an instance of strncpy() which helps [1].

Link: https://github.com/KSPP/linux/issues/90 [1]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Builds upon patch and feedback from [2]:

However, this is different enough to warrant its own patch and not be a
continuation.

[2]: https://lore.kernel.org/all/9f38f4aa-c6b5-4786-a641-d02d8bd92f7f@acm.org/
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index e17957f8085c..f9c5d00f658a 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/etherdevice.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 
 #include <scsi/fcoe_sysfs.h>
 #include <scsi/libfcoe.h>
@@ -214,25 +215,13 @@ static const char *get_fcoe_##title##_name(enum table_type table_key)	\
 	return table[table_key];					\
 }
 
-static char *fip_conn_type_names[] = {
+static const char * const fip_conn_type_names[] = {
 	[ FIP_CONN_TYPE_UNKNOWN ] = "Unknown",
 	[ FIP_CONN_TYPE_FABRIC ]  = "Fabric",
 	[ FIP_CONN_TYPE_VN2VN ]   = "VN2VN",
 };
 fcoe_enum_name_search(ctlr_mode, fip_conn_type, fip_conn_type_names)
 
-static enum fip_conn_type fcoe_parse_mode(const char *buf)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(fip_conn_type_names); i++) {
-		if (strcasecmp(buf, fip_conn_type_names[i]) == 0)
-			return i;
-	}
-
-	return FIP_CONN_TYPE_UNKNOWN;
-}
-
 static char *fcf_state_names[] = {
 	[ FCOE_FCF_STATE_UNKNOWN ]      = "Unknown",
 	[ FCOE_FCF_STATE_DISCONNECTED ] = "Disconnected",
@@ -274,17 +263,10 @@ static ssize_t store_ctlr_mode(struct device *dev,
 			       const char *buf, size_t count)
 {
 	struct fcoe_ctlr_device *ctlr = dev_to_ctlr(dev);
-	char mode[FCOE_MAX_MODENAME_LEN + 1];
 
 	if (count > FCOE_MAX_MODENAME_LEN)
 		return -EINVAL;
 
-	strncpy(mode, buf, count);
-
-	if (mode[count - 1] == '\n')
-		mode[count - 1] = '\0';
-	else
-		mode[count] = '\0';
 
 	switch (ctlr->enabled) {
 	case FCOE_CTLR_ENABLED:
@@ -297,8 +279,8 @@ static ssize_t store_ctlr_mode(struct device *dev,
 			return -ENOTSUPP;
 		}
 
-		ctlr->mode = fcoe_parse_mode(mode);
-		if (ctlr->mode == FIP_CONN_TYPE_UNKNOWN) {
+		ctlr->mode = sysfs_match_string(fip_conn_type_names, buf);
+		if (ctlr->mode < 0) {
 			LIBFCOE_SYSFS_DBG(ctlr, "Unknown mode %s provided.\n",
 					  buf);
 			return -EINVAL;

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231024-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-0e1dffe82855

Best regards,
--
Justin Stitt <justinstitt@google.com>

