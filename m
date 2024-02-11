Return-Path: <linux-kernel+bounces-60831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C5850A00
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A16B21220
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA05B684;
	Sun, 11 Feb 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="gOLYHkM3"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D92AE74;
	Sun, 11 Feb 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707665601; cv=none; b=dI0P8ob+ls8yLgb17uqOSZti1CnzmqWWLUOwEL+gksulXePNrEqfPfihDbBA0Q5cDZ/Jyp8k+NAYLLYqbvkJ3q5mZytWLXJsSqQXc0a0B/lAfKbbaSaW1x137uslmxfO+e1x+T2/Re18b1cnehGHyFvSA1HicD2p0x6vfJItAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707665601; c=relaxed/simple;
	bh=KvxrA8HLA+5Te2kk8N9iNiNctxBs5xVzeJBiZZr1CIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rz33cKGg1mC23UOJg6YUUMoANNo4CKUvTYi9IDBA+SZBjNICV6Yx4QfCWOlPKWTgSodPnI78UngeNUh9lmunSTLP5MjDgce1vfz/bvkWeVxxlJGV9nI1ZIk+oxdhzDiZJBYmsxiJtUCfRAzdCsuWu1YNE2IYpKy6dhpuyL6ZNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=gOLYHkM3; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-363a76d0c71so13490275ab.1;
        Sun, 11 Feb 2024 07:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707665599; x=1708270399;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuHOlvWESTbD0pP+Ok8CQCa3586fwbCX3IMl1v1eng8=;
        b=uwptsQza39T8ALrZzESwaFWGC3iZk2H+OOWsBM5tEoZ+CsMvU17gVIVmmz2AaRKojE
         m4GRa4ZLXIE9tRdFdDJSV+2T2xb0XrV2QRZPM5M0pbA7oq4/0eN4stkGm5+nbJEYpgPq
         yA6xhdIxqoLKbRf6xqaxEuklcLurDm3iAcvtqw93lVQUpDPq2ONel6bMsTH45KauztYG
         fjSaLNZc7now46Bnzg+8Ce9rbTv1Qpq8cRLYC9nN8W6M9m5ZHeFd5WNNVex8C7fCHABy
         VIvARYmDqg94b7mpMFsIPBaIu/HSGw97pMzhaCaxXx0j/BpVwjiNIlPapqSi5a3mkpEF
         TN9A==
X-Gm-Message-State: AOJu0YxC6HD6vcnzS6QinXF5WjEvoph7OREJ8L/bL+LwE9ArDz9TfNlr
	Xpzw8oB2rUh/WzzMD5g2OBWRdo5YXTu/HIqKRyXlc7HHZSS+cmJZ
X-Google-Smtp-Source: AGHT+IGC0FHQGK4yybfJt684xZE+YxS2A8dkndraXw/D15fNRYB89f5zm3oxVgnfniWR9zb5Slgf4A==
X-Received: by 2002:a92:d3d1:0:b0:363:b33e:c8f2 with SMTP id c17-20020a92d3d1000000b00363b33ec8f2mr5353872ilh.11.1707665598707;
        Sun, 11 Feb 2024 07:33:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKkRej9xN/v32H1uMhpj9K+QD8Gj6clUcOcBRNWnK5HqhyHy9XMZmy305JQAS8gcpts+4lOdk9sghcWJkS/Rk8nkKejjfg/8o+pxTReZCR3B6p5M7EYfPTYayjQ8mPiFRJ/vqqbmIUqsx8u+LKw1bTBa99BWCNqs9fHPVcDFHP/edg6to=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id dq16-20020a056a020f9000b005cfb6e7b0c7sm4584921pgb.39.2024.02.11.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:33:17 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707665596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VuHOlvWESTbD0pP+Ok8CQCa3586fwbCX3IMl1v1eng8=;
	b=gOLYHkM3G7pr1zv9f1ih6dmQ4w1kSRIwgnUCqqL4u6nyXhAIcEo6NseVqU+fUS5qA9RZNG
	FVcl77V6SAHP7u3bWQJ9OpEbbSGArlW0CE1BB8KkTIQKdPWfD7TMsbZYR/YGTT2PpxrhA2
	1HmibY9G5HGkcTX2whZAR1c8jrzFi+psTf2/a2MUhFcRSVKNbGYuF864XOARuzlOgGlxzk
	Q/xo7JJ0BYVrRHk+0YQ9hlBZDsFrr0VHxUSt2OzR1FZ6TJ+FjQt3fWsyVXVUZGpJ0H2ahh
	wlGgRHzNtGm+WeRzKbfrSC3s9VtoxrWfIoW3E3kDBRO/jbvtnL/JiIA+B5vcwQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 11 Feb 2024 12:33:50 -0300
Subject: [PATCH] scsi: Make scsi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-bus_cleanup-scsi2-v1-1-dd04ee82e6b0@marliere.net>
X-B4-Tracking: v=1; b=H4sIAN3oyGUC/x3M0QpAQBBA0V/RPNsyS4pfkbQ7ZpnS0k6k5N9tH
 s/DvQ8oJ2GFvngg8SUqe8zAsgBaXVzYyJwNtrJNZRGNP3WijV08D6OkYg22VFPwrkMXIHdH4iD
 3/xzG9/0AtFXKx2MAAAA=
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=KvxrA8HLA+5Te2kk8N9iNiNctxBs5xVzeJBiZZr1CIY=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyOjeDETcFp6Nwe9OCSDwLeUvf1IbdCP6wRf9v
 6p+MTtnOICJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjo3gAKCRDJC4p8Y4ZY
 pg7hEACOFzhma3WS68vSY7kljVwRHpwqfXr+sGA1SyljXObGrn6i/7s5oMr2OcGhCBivVUzPITI
 mJ53hfo2fCx3lp8nTI4ChHzbGjVN4d7yk2jmifTqaU3Ax23gMtTl7520pAYJjhfL11a5Z19Xfhz
 qh+fyGeB21TPeQsZmN0i42hU/76slT/zbFk99ysFLTw1yTPgK9rNBC8vAd8FKupV2ZP/TvEvkRm
 JVWCaEffvaRAdBowbDrr13u//2Os+5/MDMgJD8bj2DWIRqzq1DK7WrCv3moUoOJ6Kix7S4KymRD
 9yPQIKJjKZ149wMJVSg+Rtn9C0lgPGo+4BqXeolTUP/1oS286Uc8lL/gJEaRa8Us3k+tkczWDnl
 HM0Pcj1wLx2tj9uPAKQoxH9IGTyTiQK0jNqT5nADlp1vbUX7g2eBnsdhNpZ3Cuoa5bGDL/dlu/Z
 zQa4F2BuOWmS6wBVeqrK7d/nc5S4LWLXsue9+DthptIPIha+INPuQzPCiGjZYB6bpVujJVXAy8l
 B/NBrj6DPv3TQRkeVkdwuT+9gNjZ5fHN0NqflyrapfmtG3XhPyBJcoGkoNQfNMhS3hNDp5NUecL
 NktruQqSB9Cl7JvUcgmnTmQOl+MBJj0CiTyIs6OAbFccoSyGAuO9NDJ446EVW1Vxt1wnUW9brOs
 Q51cjnc7qjcGtGQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the scsi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Remove some extraneous whitespace.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/scsi_priv.h  | 6 +++---
 drivers/scsi/scsi_sysfs.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 1fbfe1b52c9f..6a02114776b3 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -54,7 +54,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd);
 void scsi_log_send(struct scsi_cmnd *cmd);
 void scsi_log_completion(struct scsi_cmnd *cmd, int disposition);
 #else
-static inline void scsi_log_send(struct scsi_cmnd *cmd) 
+static inline void scsi_log_send(struct scsi_cmnd *cmd)
 	{ };
 static inline void scsi_log_completion(struct scsi_cmnd *cmd, int disposition)
 	{ };
@@ -156,7 +156,7 @@ extern void scsi_sysfs_device_initialize(struct scsi_device *);
 extern struct scsi_transport_template blank_transport_template;
 extern void __scsi_remove_device(struct scsi_device *);
 
-extern struct bus_type scsi_bus_type;
+extern const struct bus_type scsi_bus_type;
 extern const struct attribute_group *scsi_shost_groups[];
 
 /* scsi_netlink.c */
@@ -197,7 +197,7 @@ struct bsg_device *scsi_bsg_register_queue(struct scsi_device *sdev);
 
 extern int scsi_device_max_queue_depth(struct scsi_device *sdev);
 
-/* 
+/*
  * internal scsi timeout functions: for use by mid-layer and transport
  * classes.
  */
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 24f6eefb6803..7f1fede8ef5d 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -549,7 +549,7 @@ static int scsi_bus_uevent(const struct device *dev, struct kobj_uevent_env *env
 	return 0;
 }
 
-struct bus_type scsi_bus_type = {
+const struct bus_type scsi_bus_type = {
         .name		= "scsi",
         .match		= scsi_bus_match,
 	.uevent		= scsi_bus_uevent,
@@ -656,7 +656,7 @@ static int scsi_sdev_check_buf_bit(const char *buf)
 			return 1;
 		else if (buf[0] == '0')
 			return 0;
-		else 
+		else
 			return -EINVAL;
 	} else
 		return -EINVAL;
@@ -881,7 +881,7 @@ store_queue_type_field(struct device *dev, struct device_attribute *attr,
 
 	if (!sdev->tagged_supported)
 		return -EINVAL;
-		
+
 	sdev_printk(KERN_INFO, sdev,
 		    "ignoring write to deprecated queue_type attribute");
 	return count;

---
base-commit: 59828c7b5975f442ad5bb74a031fe388341f323e
change-id: 20240211-bus_cleanup-scsi2-16c3cfba91af

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


