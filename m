Return-Path: <linux-kernel+bounces-4951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B093818445
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B442D1F251F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A913FED;
	Tue, 19 Dec 2023 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBxYGEcj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F913ADA;
	Tue, 19 Dec 2023 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ca04b1cc37so41912721fa.1;
        Tue, 19 Dec 2023 01:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702977678; x=1703582478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwNJbSFpIsu9ypRnPjAlwKfx3kawFr8ncqgoti6mISc=;
        b=GBxYGEcjS+HBlpnB8ke3+Zan8wxKUKh+hCsHA2EuqbePKnx/KXqNef3SQRrJc4gnNQ
         Y0L869kP8bJMiRYhBKvhbi31Sl8lAn/db7GtzqIpjcRsH9i/FD2SjcNUAaWrfuJfmQx9
         7KKmq3te+kT9wVmTJzEBUnTNMWSYmLeoXh4P3nM4urhce8fnlODM4AIFQjAVcxts3w2L
         co2bLdxalCKwuZzMP+bVpgcIgOtSGATTvzlQWB15GtzdmlwE8W2KR92BBdbysvzWJ67R
         cdUaNXUxEWxuAr4kSI/lF39fqWZPiqT/sgGaL5278z3BDwpZbLQ9+Kmjt9m0N8QGmQYB
         9kVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702977678; x=1703582478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwNJbSFpIsu9ypRnPjAlwKfx3kawFr8ncqgoti6mISc=;
        b=UysCKjepxNRjvQV7g7D9xeS1fwdOmWpkFFFMRxEMGzFkCK/EB6l8HblH3fr+u//auj
         7PCELW/zWWBUqmb7KCnFWSDxAJR4AqEllcfctmUvYaV+bIGSZBy0sBXTsL2ukjn1Trcy
         6OppvTmUMlG7rN5fUJwkqJoPVnUaVlVv29jytoJy3eo/kze8vJfArBYFYbYVvUigopUf
         4pHRXm0dEk3PR6PZgvuAePIGyJNG8hDPeEpj5jXJYFfPAvoxsCfHo0YOhcjAC3Ps7DUE
         OZkiis4KXCHDO1pvHphGgpXNzHwGfR3rlRqNbBLzosnJWXDyR5sLE0jldCGi1S7Gc568
         FpWg==
X-Gm-Message-State: AOJu0YxTanDDEdMYYGh6H1sVLf7liHUZj0I3NvLQMF+CCAlyyhruBl93
	tN6+4asxS6IHKnEduK+hK57fphrkjqf1EWA4eSM=
X-Google-Smtp-Source: AGHT+IGENMzpnbZf7E5l70A1oi/hFP8KPT7cupvbx9W7YXUVt8yrFgLV3OUaHIZ5jVst4YeCSiXkyA==
X-Received: by 2002:a2e:780e:0:b0:2cc:68b2:c4de with SMTP id t14-20020a2e780e000000b002cc68b2c4demr472794ljc.24.1702977677653;
        Tue, 19 Dec 2023 01:21:17 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id j5-20020a2e8245000000b002c9fc3dab0asm3766295ljh.5.2023.12.19.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:21:17 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Hannes Reinecke <hare@suse.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] [SCSI] aic7xxx: Remove ahd_acquire_seeprom and ahd_release_seeprom due to redundant implementation
Date: Tue, 19 Dec 2023 12:20:56 +0300
Message-Id: <20231219092056.52919-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We removed the ahd_acquire_seeprom and ahd_release_seeprom functions
because both lacked meaningful implementations. The SEEPROM acquisition
and release logic they provided were unused and had been commented out,
making them redundant and non-functional. In addition to some style
fixes.
This change simplifies the codebase and improves code clarity by
eliminating unnecessary code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/scsi/aic7xxx/aic79xx.h      |  2 -
 drivers/scsi/aic7xxx/aic79xx_core.c | 29 ----------
 drivers/scsi/aic7xxx/aic79xx_pci.c  | 89 ++++++++++++++---------------
 drivers/scsi/aic7xxx/aic79xx_proc.c | 36 +++++-------
 4 files changed, 56 insertions(+), 100 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx.h b/drivers/scsi/aic7xxx/aic79xx.h
index 9a515551641c..e8a7b16a6861 100644
--- a/drivers/scsi/aic7xxx/aic79xx.h
+++ b/drivers/scsi/aic7xxx/aic79xx.h
@@ -962,8 +962,6 @@ int		ahd_read_seeprom(struct ahd_softc *ahd, uint16_t *buf,
 int		ahd_write_seeprom(struct ahd_softc *ahd, uint16_t *buf,
 				  u_int start_addr, u_int count);
 int		ahd_verify_cksum(struct seeprom_config *sc);
-int		ahd_acquire_seeprom(struct ahd_softc *ahd);
-void		ahd_release_seeprom(struct ahd_softc *ahd);
 
 /****************************  Message Buffer *********************************/
 typedef enum {
diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 4c790fe28f73..7d639b98e9aa 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -10089,35 +10089,6 @@ ahd_verify_cksum(struct seeprom_config *sc)
 	}
 }
 
-int
-ahd_acquire_seeprom(struct ahd_softc *ahd)
-{
-	/*
-	 * We should be able to determine the SEEPROM type
-	 * from the flexport logic, but unfortunately not
-	 * all implementations have this logic and there is
-	 * no programatic method for determining if the logic
-	 * is present.
-	 */
-	return (1);
-#if 0
-	uint8_t	seetype;
-	int	error;
-
-	error = ahd_read_flexport(ahd, FLXADDR_ROMSTAT_CURSENSECTL, &seetype);
-	if (error != 0
-         || ((seetype & FLX_ROMSTAT_SEECFG) == FLX_ROMSTAT_SEE_NONE))
-		return (0);
-	return (1);
-#endif
-}
-
-void
-ahd_release_seeprom(struct ahd_softc *ahd)
-{
-	/* Currently a no-op */
-}
-
 /*
  * Wait at most 2 seconds for flexport arbitration to succeed.
  */
diff --git a/drivers/scsi/aic7xxx/aic79xx_pci.c b/drivers/scsi/aic7xxx/aic79xx_pci.c
index 8397ae93f7dd..a25d193eb3ad 100644
--- a/drivers/scsi/aic7xxx/aic79xx_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_pci.c
@@ -507,60 +507,55 @@ ahd_check_extport(struct ahd_softc *ahd)
 {
 	struct	vpd_config vpd;
 	struct	seeprom_config *sc;
-	u_int	adapter_control;
-	int	have_seeprom;
+	u_int	adapter_control, start_addr;
+	int	have_seeprom = 1;
 	int	error;
 
 	sc = ahd->seep_config;
-	have_seeprom = ahd_acquire_seeprom(ahd);
-	if (have_seeprom) {
-		u_int start_addr;
 
-		/*
-		 * Fetch VPD for this function and parse it.
-		 */
-		if (bootverbose) 
-			printk("%s: Reading VPD from SEEPROM...",
-			       ahd_name(ahd));
+	/*
+	 * Fetch VPD for this function and parse it.
+	 */
+	if (bootverbose)
+		printk("%s: Reading VPD from SEEPROM...",
+		       ahd_name(ahd));
 
-		/* Address is always in units of 16bit words */
-		start_addr = ((2 * sizeof(*sc))
-			    + (sizeof(vpd) * (ahd->channel - 'A'))) / 2;
-
-		error = ahd_read_seeprom(ahd, (uint16_t *)&vpd,
-					 start_addr, sizeof(vpd)/2,
-					 /*bytestream*/TRUE);
-		if (error == 0)
-			error = ahd_parse_vpddata(ahd, &vpd);
-		if (bootverbose) 
-			printk("%s: VPD parsing %s\n",
-			       ahd_name(ahd),
-			       error == 0 ? "successful" : "failed");
-
-		if (bootverbose) 
-			printk("%s: Reading SEEPROM...", ahd_name(ahd));
-
-		/* Address is always in units of 16bit words */
-		start_addr = (sizeof(*sc) / 2) * (ahd->channel - 'A');
-
-		error = ahd_read_seeprom(ahd, (uint16_t *)sc,
-					 start_addr, sizeof(*sc)/2,
-					 /*bytestream*/FALSE);
-
-		if (error != 0) {
-			printk("Unable to read SEEPROM\n");
-			have_seeprom = 0;
-		} else {
-			have_seeprom = ahd_verify_cksum(sc);
+	/* Address is always in units of 16bit words */
+	start_addr = ((2 * sizeof(*sc))
+		      + (sizeof(vpd) * (ahd->channel - 'A'))) / 2;
 
-			if (bootverbose) {
-				if (have_seeprom == 0)
-					printk ("checksum error\n");
-				else
-					printk ("done.\n");
-			}
+	error = ahd_read_seeprom(ahd, (uint16_t *)&vpd,
+				 start_addr, sizeof(vpd)/2,
+				 /*bytestream*/TRUE);
+	if (error == 0)
+		error = ahd_parse_vpddata(ahd, &vpd);
+	if (bootverbose)
+		printk("%s: VPD parsing %s\n",
+		       ahd_name(ahd),
+		       error == 0 ? "successful" : "failed");
+
+	if (bootverbose)
+		printk("%s: Reading SEEPROM...", ahd_name(ahd));
+
+	/* Address is always in units of 16bit words */
+	start_addr = (sizeof(*sc) / 2) * (ahd->channel - 'A');
+
+	error = ahd_read_seeprom(ahd, (uint16_t *)sc,
+				 start_addr, sizeof(*sc)/2,
+				 /*bytestream*/FALSE);
+
+	if (error != 0) {
+		printk("Unable to read SEEPROM\n");
+		have_seeprom = 0;
+	} else {
+		have_seeprom = ahd_verify_cksum(sc);
+
+		if (bootverbose) {
+			if (have_seeprom == 0)
+				printk("checksum error\n");
+			else
+				printk("done.\n");
 		}
-		ahd_release_seeprom(ahd);
 	}
 
 	if (!have_seeprom) {
diff --git a/drivers/scsi/aic7xxx/aic79xx_proc.c b/drivers/scsi/aic7xxx/aic79xx_proc.c
index add2da581d66..8a4a1c5601d1 100644
--- a/drivers/scsi/aic7xxx/aic79xx_proc.c
+++ b/drivers/scsi/aic7xxx/aic79xx_proc.c
@@ -213,6 +213,7 @@ ahd_proc_write_seeprom(struct Scsi_Host *shost, char *buffer, int length)
 	u_long s;
 	int paused;
 	int written;
+	u_int start_addr;
 
 	/* Default to failure. */
 	written = -EINVAL;
@@ -234,31 +235,22 @@ ahd_proc_write_seeprom(struct Scsi_Host *shost, char *buffer, int length)
 		goto done;
 	}
 
-	have_seeprom = ahd_acquire_seeprom(ahd);
-	if (!have_seeprom) {
-		printk("ahd_proc_write_seeprom: No Serial EEPROM\n");
-		goto done;
-	} else {
-		u_int start_addr;
-
+	if (ahd->seep_config == NULL) {
+		ahd->seep_config = kmalloc(sizeof(*ahd->seep_config), GFP_ATOMIC);
 		if (ahd->seep_config == NULL) {
-			ahd->seep_config = kmalloc(sizeof(*ahd->seep_config), GFP_ATOMIC);
-			if (ahd->seep_config == NULL) {
-				printk("aic79xx: Unable to allocate serial "
-				       "eeprom buffer.  Write failing\n");
-				goto done;
-			}
+			printk("aic79xx: Unable to allocate serial "
+			       "eeprom buffer.  Write failing\n");
+			goto done;
 		}
-		printk("aic79xx: Writing Serial EEPROM\n");
-		start_addr = 32 * (ahd->channel - 'A');
-		ahd_write_seeprom(ahd, (u_int16_t *)buffer, start_addr,
-				  sizeof(struct seeprom_config)/2);
-		ahd_read_seeprom(ahd, (uint16_t *)ahd->seep_config,
-				 start_addr, sizeof(struct seeprom_config)/2,
-				 /*ByteStream*/FALSE);
-		ahd_release_seeprom(ahd);
-		written = length;
 	}
+	printk("aic79xx: Writing Serial EEPROM\n");
+	start_addr = 32 * (ahd->channel - 'A');
+	ahd_write_seeprom(ahd, (u_int16_t *)buffer, start_addr,
+			  sizeof(struct seeprom_config)/2);
+	ahd_read_seeprom(ahd, (uint16_t *)ahd->seep_config,
+			 start_addr, sizeof(struct seeprom_config)/2,
+			 /*ByteStream*/FALSE);
+	written = length;
 
 done:
 	ahd_restore_modes(ahd, saved_modes);
-- 
2.34.1


