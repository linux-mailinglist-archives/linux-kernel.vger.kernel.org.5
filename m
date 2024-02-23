Return-Path: <linux-kernel+bounces-79253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5828D861F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F121F2440C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5C14F9E7;
	Fri, 23 Feb 2024 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="w/4r3HqZ"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C914EFF4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727001; cv=none; b=cvk7CzCNqxitX1IQF/F1ya+8VGowi3ICbG1gvP6BtPGMBSjpPV+VnYIfLhSrzcxFrzrfnerRPpLEyXopyYPrca7wi35hoLrk/pYTJnzXx5qy70SwCcYYeDgYdghaYP3rBSX22OEkPx8Z2PyzExHTQgM/gx5BYC0ba7tL6zdI2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727001; c=relaxed/simple;
	bh=WF4YQR2do5qiSJ+c+a/EQGFlQbp7QPiiZHKMoUv9VsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hq8HD14k1Nt3sgBk1dQQex1tauKRBdbV5Z4dGKYQRr4D6eHLaawEw6lKJSPpwxIPWt6m3FJ7acpsbiufAIOpN928UQL1q4Drtrkxr/2A0i3Qwc8AROGnxpR1FCOJbIqVrtZ5Rh4HaGIDhh69fbbTwHFowigoEUppgDdEdFsoR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/4r3HqZ; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7c78573f2e9so146869839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708726998; x=1709331798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqyHhzC9daBDvkR/24wgxdtuzxCV8dlt+swbmuCVoBo=;
        b=w/4r3HqZea/Ggg3k3zre3IFLIx5U9sX8T3ar6G91LXt7EmlX43OKTUpltvwHpN183i
         uIjkFhMmB/Auw/eSdCT0050MbTEznDctdCiy/0K/BKozt1UNMTadfJPOaJgA8BqEFNi6
         +QaDvpy6zKKkAUAxnP+J1N3kIdyItAtaELqHSf7NPWgEyKuPyWZYU9TTWDN6sXL+8Hl3
         SwBVzQROW2z+oehmek1kTm2IrVf6tlZ5q4pN2huZGonCkfonVJqEiPfUcReoH7JM5MVg
         f5VfswhpzuCGutVoaqUJOVlvorEnBAv4A2fcMPerJ21IbeDjHCxQcWT2Dv4v/DIBFd1m
         +keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726998; x=1709331798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqyHhzC9daBDvkR/24wgxdtuzxCV8dlt+swbmuCVoBo=;
        b=aYBjrpZm6i3YM8rJzGUwzdpt/9hzb3sLs+ir3ebK5Eip3V5Sj7rmTQQy0hR6k8pzEr
         +Xbou52xuYER+4pl8T2D6d7w5P04Qqvwi+Y6dTcRbxsXbhlQnx2nhJV/z1Kbx4hLMlAo
         bJziOP+xm1ZJdjBJBYD9VngCRDSKD87+tkdDirlNWTiaLkL7vcs34gxhe9A5fn06eNv/
         2aDF83KagUCLDYlfLjO970JXPZn7GwH0QE7m2lmMpqmlh+qC9IQ+KVS8+26zX5zmgd4w
         seo62NapXusdeGkSItsZvrwTBCgzidsWJT48HAkU/AsFIoRbGnROrQhM9ryJDrn/+ENv
         Vz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFtUlYMX80M2imrpEuyim+ctVMxOcbS5sSYW+JM70OQ0bZxbSG4rZfjQZh8aIKtqfPW622op6opgL/FAGz8Vqd1R2F5OiW2b7R4/YO
X-Gm-Message-State: AOJu0YwbA3y+IbOxybj7ghOQfw70HnQc5l2Pw3sIxhx+ZafqzA7KbHoM
	OBOsqmEmOy/aEpXVrnIkcp3ey80nnqddxrD030KyADdbXB29PeY0gKJhPpPi+DOrq19laGeQnkG
	hTqi4dScX+4KVIbdL75WAVQ==
X-Google-Smtp-Source: AGHT+IG9bEbDCtSYBKr1QFepBtlGpTZ52Xw0zxoEYws65fZjkCcYrQ/UQ2i00nADdIPErNshE5QCnGmvE8Y1AIkkLg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:6303:b0:474:6adc:5f92 with
 SMTP id fi3-20020a056638630300b004746adc5f92mr40697jab.0.1708726998275; Fri,
 23 Feb 2024 14:23:18 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:09 +0000
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726991; l=6776;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=WF4YQR2do5qiSJ+c+a/EQGFlQbp7QPiiZHKMoUv9VsI=; b=/yNT/Wd2Or8hedmBbbmlAKYQUpvDWDklet1WshJOSGBbRqPJUeq/48kkl/A2QKYISPVd9xjri
 g7imq5CQ8LJD5g0LvGhmpKYf0RirP+HsYK0LQ4MPE/ZVOJPuIfGbVbM
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-4-9cd3882f0700@google.com>
Subject: [PATCH 4/7] scsi: qla4xxx: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Replace 3 instances of strncpy in ql4_mbx.c

No bugs exist in the current implementation as some care was taken to
ensure the write length was decreased by one to leave some space for a
NUL-byte. However, instead of using strncpy(dest, src, LEN-1) we can opt
for strscpy(dest, src, sizeof(dest)) which will result in
NUL-termination as well. It should be noted that the entire chap_table
is zero-allocated so the NUL-padding provided by strncpy is not needed.

While here, I noticed that MIN_CHAP_SECRET_LEN was not used anywhere.
Since strscpy gives us the number of bytes copied into the destination
buffer (or an -E2BIG) we can check both for an error during copying and
also for a non-length compliant secret. Add a new jump label so we can
properly clean up our chap_table should we have to abort due to bad
secret.

The third instance in this file involves some more peculiar handling of
strings:
|	uint32_t mbox_cmd[MBOX_REG_COUNT];
|	...
|	memset(&mbox_cmd, 0, sizeof(mbox_cmd));
|	...
|	mbox_cmd[0] = MBOX_CMD_SET_PARAM;
|	if (param == SET_DRVR_VERSION) {
|		mbox_cmd[1] = SET_DRVR_VERSION;
|		strncpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
|			MAX_DRVR_VER_LEN - 1);

mbox_cmd has a size of 8:
|	#define MBOX_REG_COUNT 8
.. and its type width is 4 bytes. Hence, we have 32 bytes to work with
here. The first 4 bytes are used as a flag for the MBOX_CMD_SET_PARAM.
The next 4 bytes are used for SET_DRVR_VERSION. We now have 32-8=24
bytes remaining -- which thankfully is what MAX_DRVR_VER_LEN is equal to
|	#define MAX_DRVR_VER_LEN                    24

.. and the thing we're copying into this pseudo-string buffer is
|	#define QLA4XXX_DRIVER_VERSION        "5.04.00-k6"

.. which is great because its less than 24 bytes (therefore we aren't
truncating the source).

All to say, there's no bug in the existing implementation (yay!) but we
can clean the code up a bit by using strscpy().

In ql4_os.c, there aren't any strncpy() uses to replace but there are
some existing strscpy() calls that could be made more idiomatic. Where
possible, use strscpy(dest, src, sizeof(dest)). Note that
chap_rec->password has a size of ISCSI_CHAP_AUTH_SECRET_MAX_LEN
|	#define ISCSI_CHAP_AUTH_SECRET_MAX_LEN	256
.. while the current strscpy usage uses QL4_CHAP_MAX_SECRET_LEN
|	#define QL4_CHAP_MAX_SECRET_LEN 100
.. however since chap_table->secret was set and bounded properly in its
string assignment its probably safe here to switch over to sizeof().

|	struct iscsi_chap_rec {
	...
|		char username[ISCSI_CHAP_AUTH_NAME_MAX_LEN];
|		uint8_t password[ISCSI_CHAP_AUTH_SECRET_MAX_LEN];
	...
|	};

|	strscpy(chap_rec->password, chap_table->secret,
|		QL4_CHAP_MAX_SECRET_LEN);

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/qla4xxx/ql4_mbx.c | 17 ++++++++++++-----
 drivers/scsi/qla4xxx/ql4_os.c  | 14 +++++++-------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index 249f1d7021d4..75125d2021f5 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -1641,6 +1641,7 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
 	struct ql4_chap_table *chap_table;
 	uint32_t chap_size = 0;
 	dma_addr_t chap_dma;
+	ssize_t secret_len;
 
 	chap_table = dma_pool_zalloc(ha->chap_dma_pool, GFP_KERNEL, &chap_dma);
 	if (chap_table == NULL) {
@@ -1652,9 +1653,13 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
 		chap_table->flags |= BIT_6; /* peer */
 	else
 		chap_table->flags |= BIT_7; /* local */
-	chap_table->secret_len = strlen(password);
-	strncpy(chap_table->secret, password, MAX_CHAP_SECRET_LEN - 1);
-	strncpy(chap_table->name, username, MAX_CHAP_NAME_LEN - 1);
+
+	secret_len = strscpy(chap_table->secret, password,
+			     sizeof(chap_table->secret));
+	if (secret_len < MIN_CHAP_SECRET_LEN)
+		goto cleanup_chap_table;
+	chap_table->secret_len = (uint8_t)secret_len;
+	strscpy(chap_table->name, username, sizeof(chap_table->name));
 	chap_table->cookie = cpu_to_le16(CHAP_VALID_COOKIE);
 
 	if (is_qla40XX(ha)) {
@@ -1679,6 +1684,8 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
 		memcpy((struct ql4_chap_table *)ha->chap_list + idx,
 		       chap_table, sizeof(struct ql4_chap_table));
 	}
+
+cleanup_chap_table:
 	dma_pool_free(ha->chap_dma_pool, chap_table, chap_dma);
 	if (rval != QLA_SUCCESS)
 		ret =  -EINVAL;
@@ -2281,8 +2288,8 @@ int qla4_8xxx_set_param(struct scsi_qla_host *ha, int param)
 	mbox_cmd[0] = MBOX_CMD_SET_PARAM;
 	if (param == SET_DRVR_VERSION) {
 		mbox_cmd[1] = SET_DRVR_VERSION;
-		strncpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
-			MAX_DRVR_VER_LEN - 1);
+		strscpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
+			MAX_DRVR_VER_LEN);
 	} else {
 		ql4_printk(KERN_ERR, ha, "%s: invalid parameter 0x%x\n",
 			   __func__, param);
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 675332e49a7b..17cccd14765f 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -799,10 +799,10 @@ static int qla4xxx_get_chap_list(struct Scsi_Host *shost, uint16_t chap_tbl_idx,
 
 		chap_rec->chap_tbl_idx = i;
 		strscpy(chap_rec->username, chap_table->name,
-			ISCSI_CHAP_AUTH_NAME_MAX_LEN);
-		strscpy(chap_rec->password, chap_table->secret,
-			QL4_CHAP_MAX_SECRET_LEN);
-		chap_rec->password_length = chap_table->secret_len;
+			sizeof(chap_rec->username));
+		chap_rec->password_length = strscpy(chap_rec->password,
+						    chap_table->secret,
+						    sizeof(chap_rec->password));
 
 		if (chap_table->flags & BIT_7) /* local */
 			chap_rec->chap_type = CHAP_TYPE_OUT;
@@ -6291,8 +6291,8 @@ static void qla4xxx_get_param_ddb(struct ddb_entry *ddb_entry,
 
 	tddb->tpgt = sess->tpgt;
 	tddb->port = conn->persistent_port;
-	strscpy(tddb->iscsi_name, sess->targetname, ISCSI_NAME_SIZE);
-	strscpy(tddb->ip_addr, conn->persistent_address, DDB_IPADDR_LEN);
+	strscpy(tddb->iscsi_name, sess->targetname, sizeof(tddb->iscsi_name));
+	strscpy(tddb->ip_addr, conn->persistent_address, sizeof(tddb->ip_addr));
 }
 
 static void qla4xxx_convert_param_ddb(struct dev_db_entry *fw_ddb_entry,
@@ -7792,7 +7792,7 @@ static int qla4xxx_sysfs_ddb_logout(struct iscsi_bus_flash_session *fnode_sess,
 	}
 
 	strscpy(flash_tddb->iscsi_name, fnode_sess->targetname,
-		ISCSI_NAME_SIZE);
+		sizeof(flash_tddb->iscsi_name));
 
 	if (!strncmp(fnode_sess->portal_type, PORTAL_TYPE_IPV6, 4))
 		sprintf(flash_tddb->ip_addr, "%pI6", fnode_conn->ipaddress);

-- 
2.44.0.rc0.258.g7320e95886-goog


