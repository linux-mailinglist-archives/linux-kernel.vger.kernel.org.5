Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4077C9A54
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjJOR3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOR3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:29:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A639A1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 10:29:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9bca1d96cso24307785ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697390948; x=1697995748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vAQk8jHlo6qihQAGhtGMq0EcFI2VhaDfpD+f3tlG7rc=;
        b=ThJvj7Hb4h2RdWI5QwDYkFXe+jW4XmXC0Ov0Y0F9Ei2Lg3IXR9EVlhqw6es2a0d4GF
         AQK2GM1INglQX3BCgMXK4JRr8YvGh56LYuM5wNJpvowyWoUWj3pL+jdtHbX8sfuPemqZ
         VxMdgHpHl5ILZiAx+jyLjIQHlzCdVdA/jTHcb44oF2y1NzaAAQhj57QZSYzdRQdj8WcU
         qU+ow7WwGroGn6BLqiBGY7hWU7SJ6cyiNfj0orRW4c8B232zLbJDLY7nT4383HkWEbpr
         6U6wSBS8iYb0Wb/FSPBNWAuQryCmDydevM7zpqiiTlYb/hTL60nk0cJSEEiAY2+FJmpN
         5tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697390948; x=1697995748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAQk8jHlo6qihQAGhtGMq0EcFI2VhaDfpD+f3tlG7rc=;
        b=J/KvkZuYOYtrHirMpjMRueWce2Iq/WUX8PAU5tVI+B7mrnnn2cJWKYrHwNbxYbE59y
         eIhCrTr7mysbfZljkkqj1tEsL+Pdojx3T80MhPm2L3LRIiWJLUbN9t1YvB1Qu2gp5rGm
         91e3by/qtUfpAW8BH7SZqSyYq3xWEVq1o2n4jMF7NOkaJgw7eA3J2dVrW7RJvV4rCJjV
         iIlfgW/aDaswMJ7XQzin2UBZd/Mweh9Ib7x+ojCovuMEBcexys2fvODggAiS6xtZGaJK
         wZjdLYWnfRMZqo5tcOixf8J23EelROvsoq8rMdEPizOPuEXFNuuel64RzA1tYHjJFWaw
         v9xg==
X-Gm-Message-State: AOJu0Yy6DyXFwJ3+QpUuKg7sElzB4+y7h3peQiureC5b2AJpLO0fzqs5
        IOj6vbF358emKv1KfF0d1t9ZxbUqDok04g==
X-Google-Smtp-Source: AGHT+IHIJoFxkyoyQf+ABTRyoL7rWQoL57Nyqp0YObgIO0uCwzLRIHL0zD+np4P+w0uHZ9FUJCYYcw==
X-Received: by 2002:a17:903:2103:b0:1c9:fa50:fb8e with SMTP id o3-20020a170903210300b001c9fa50fb8emr3810880ple.3.1697390947753;
        Sun, 15 Oct 2023 10:29:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b2:f182:ece3:38de:3ac4:3149:fe7b])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001c73d829fb7sm6984118plg.15.2023.10.15.10.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 10:29:07 -0700 (PDT)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     phil@philpotter.co.uk
Cc:     linux-kernel@vger.kernel.org, edson.drosdeck@gmail.com
Subject: [PATCH] cdrom: Missing a blank line after declarations
Date:   Sun, 15 Oct 2023 14:28:46 -0300
Message-Id: <20231015172846.7275-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script. Adding blank line after declarations.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/cdrom/cdrom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index cc2839805983..ae30390731bf 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -985,6 +985,7 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	struct cdrom_tochdr header;
 	struct cdrom_tocentry entry;
 	int ret, i;
+
 	tracks->data = 0;
 	tracks->audio = 0;
 	tracks->cdi = 0;
@@ -1038,6 +1039,7 @@ int open_for_data(struct cdrom_device_info *cdi)
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	tracktype tracks;
+
 	cd_dbg(CD_OPEN, "entering open_for_data\n");
 	/* Check if the driver can report drive status.  If it can, we
 	   can do clever things.  If it can't, well, we at least tried! */
@@ -1202,6 +1204,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 {
         int ret;
 	tracktype tracks;
+
 	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
@@ -3038,6 +3041,7 @@ static noinline int mmc_ioctl_cdrom_subchannel(struct cdrom_device_info *cdi,
 	int ret;
 	struct cdrom_subchnl q;
 	u_char requested, back;
+
 	if (copy_from_user(&q, (struct cdrom_subchnl __user *)arg, sizeof(q)))
 		return -EFAULT;
 	requested = q.cdsc_format;
@@ -3063,6 +3067,7 @@ static noinline int mmc_ioctl_cdrom_play_msf(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_msf msf;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
 	if (copy_from_user(&msf, (struct cdrom_msf __user *)arg, sizeof(msf)))
 		return -EFAULT;
@@ -3083,6 +3088,7 @@ static noinline int mmc_ioctl_cdrom_play_blk(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_blk blk;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYBLK\n");
 	if (copy_from_user(&blk, (struct cdrom_blk __user *)arg, sizeof(blk)))
 		return -EFAULT;
@@ -3177,6 +3183,7 @@ static noinline int mmc_ioctl_cdrom_start_stop(struct cdrom_device_info *cdi,
 					       int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMSTART/CDROMSTOP\n");
 	cgc->cmd[0] = GPCMD_START_STOP_UNIT;
 	cgc->cmd[1] = 1;
@@ -3190,6 +3197,7 @@ static noinline int mmc_ioctl_cdrom_pause_resume(struct cdrom_device_info *cdi,
 						 int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPAUSE/CDROMRESUME\n");
 	cgc->cmd[0] = GPCMD_PAUSE_RESUME;
 	cgc->cmd[8] = (cmd == CDROMRESUME) ? 1 : 0;
@@ -3230,6 +3238,7 @@ static noinline int mmc_ioctl_dvd_auth(struct cdrom_device_info *cdi,
 {
 	int ret;
 	dvd_authinfo ai;
+
 	if (!CDROM_CAN(CDC_DVD))
 		return -ENOSYS;
 	cd_dbg(CD_DO_IOCTL, "entering DVD_AUTH\n");
@@ -3248,6 +3257,7 @@ static noinline int mmc_ioctl_cdrom_next_writable(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long next = 0;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n");
 	ret = cdrom_get_next_writable(cdi, &next);
 	if (ret)
@@ -3262,6 +3272,7 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long last = 0;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROM_LAST_WRITTEN\n");
 	ret = cdrom_get_last_written(cdi, &last);
 	if (ret)
-- 
2.39.2

