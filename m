Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5D7DC208
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjJ3Vnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjJ3Vnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:43:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A66FA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:43:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da07b5e6f75so5167991276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698702208; x=1699307008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e0/kVkiQLU+xIRwt52fqnoXoD0xR1x3vYThaNEUFKi4=;
        b=fUFX6S1FHiL4JEaW/hEsZKmn6RQRRxqm29qviKpUAA9k7GTUgJ1a0/v2rwnhqKaOph
         wfTsjdrhFNK5yTofrEIyb8YInqbIHYWCc11ykvkIi9dgvmATf4xiqdsruBoSTF0E1UIv
         Guxmt97LV/78/CdsuRxH3B9Jn2T2umjDV7ildiux+tzlWSXdNqHGs3goMHLEValVZsrU
         eVk1syHgeEIm4tTRCuQH8x7yOx3dlPanhd6cYya182BSZd1ixaVbXtfAdvzc7gvAiFtb
         uLHXvloSKqP3B95fOW2Du8vCTgtVTdWRnPqI1QH8o3DibQz93biK3WooGjwS80R8DtHI
         nzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702208; x=1699307008;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0/kVkiQLU+xIRwt52fqnoXoD0xR1x3vYThaNEUFKi4=;
        b=t/S5wXEfit5EiRygpqCfzbe9lXga9dzQHWZAH3lwNpec31S6jIA9uQyXiXtOvgwSQ7
         ECyLgtdHef5MdpPM1X3gK8aAEJ3uHucedYBwdIASwKbGNatQDlpretIeXyOw6iGmTH02
         RndeBX5ovNrk0i1w0L0/Yj1vIN8bkJ7v18xWlgjFloIEr1+KwWqaLPn9DYvAqel/3auM
         M34NI2FpQoODJFHo184aKQwiYBeenQjmLeLpM6pQHoWEQVEdKD2RktvdLdrotEiZee82
         2SrKNio2iIAJmTA4FyNM36W4/BwGJdXZevv657iyFh2JJHSd0rwOvB0pP6+r4f3JA8tC
         XrkA==
X-Gm-Message-State: AOJu0YyTYthwA+xR7kb1SGdy7jE4Gz9545xm5LvBeLVKE38jxKYEnDKV
        XIAR4QjassLYKbxMHDWHaO3p170yyvFGif+1nQ==
X-Google-Smtp-Source: AGHT+IEXUXlPzoW8LU7PFVYlU3cL9csxmvgRBQ/QbNnZhZiLmayN6jB8H6VklsO7nx8Pl+1pBBHGDfMzZVfBBEi4PQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:a526:0:b0:da0:c924:4fdc with SMTP
 id h35-20020a25a526000000b00da0c9244fdcmr19773ybi.6.1698702208605; Mon, 30
 Oct 2023 14:43:28 -0700 (PDT)
Date:   Mon, 30 Oct 2023 21:43:20 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHcjQGUC/1XNQQ6CMBCF4auQWTNJAW2EqxBiSjviLChkpmk0h
 Ltb3bl73+b9BygJk8JQHSCUWXmLBU1dgX+6uBByKIbWtF1jOoOaJPr9jUE4kyiqV0ae1/wd97S kf3i8uX4Ohq4Xay2U213owa9fcpzO8wNyWWNnggAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698702207; l=3953;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=kOlkCIhi5msaDl4tWCdp680vEgZukUJWPpGc5Vel+XE=; b=Vh/XP+Dr4/JhN7ikIfweMhlTgzvJG5U7crnDcmM2QYApm4PKVv1/jXqzKmK5mqk409uzLD1Wg
 qe8yhsqwFwAAyBXiU35NozThSakmhUB28vdSQY/kuqTvIo/g0b8V3UV
X-Mailer: b4 0.12.3
Message-ID: <20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v1-1-859b5ce257fd@google.com>
Subject: [PATCH] scsi: ibmvscsi_tgt: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Michael Cyr <mikecyr@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

We don't need the NUL-padding behavior that strncpy() provides as vscsi
is NUL-allocated in ibmvscsis_probe() which proceeds to call
ibmvscsis_adapter_info():
|       vscsi = kzalloc(sizeof(*vscsi), GFP_KERNEL);

ibmvscsis_probe() -> ibmvscsis_handle_crq() -> ibmvscsis_parse_command()
-> ibmvscsis_mad() -> ibmvscsis_process_mad() -> ibmvscsis_adapter_info()

Following the same idea, `partition_name` is defiend as:
|       static char partition_name[PARTITION_NAMELEN] = "UNKNOWN";

... which is NUL-padded already, meaning strscpy() is the best option.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

However, for cap->name let's use strscpy_pad as cap is allocated via
dma_alloc_coherent():
|       cap = dma_alloc_coherent(&vscsi->dma_dev->dev, olen, &token,
|                                GFP_ATOMIC);

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 385f812b8793..cd223ef696e5 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -1551,17 +1551,17 @@ static long ibmvscsis_adapter_info(struct scsi_info *vscsi,
 	if (vscsi->client_data.partition_number == 0)
 		vscsi->client_data.partition_number =
 			be32_to_cpu(info->partition_number);
-	strncpy(vscsi->client_data.srp_version, info->srp_version,
+	strscpy(vscsi->client_data.srp_version, info->srp_version,
 		sizeof(vscsi->client_data.srp_version));
-	strncpy(vscsi->client_data.partition_name, info->partition_name,
+	strscpy(vscsi->client_data.partition_name, info->partition_name,
 		sizeof(vscsi->client_data.partition_name));
 	vscsi->client_data.mad_version = be32_to_cpu(info->mad_version);
 	vscsi->client_data.os_type = be32_to_cpu(info->os_type);
 
 	/* Copy our info */
-	strncpy(info->srp_version, SRP_VERSION,
+	strscpy(info->srp_version, SRP_VERSION,
 		sizeof(info->srp_version));
-	strncpy(info->partition_name, vscsi->dds.partition_name,
+	strscpy(info->partition_name, vscsi->dds.partition_name,
 		sizeof(info->partition_name));
 	info->partition_number = cpu_to_be32(vscsi->dds.partition_num);
 	info->mad_version = cpu_to_be32(MAD_VERSION_1);
@@ -1645,8 +1645,8 @@ static int ibmvscsis_cap_mad(struct scsi_info *vscsi, struct iu_entry *iue)
 			 be64_to_cpu(mad->buffer),
 			 vscsi->dds.window[LOCAL].liobn, token);
 	if (rc == H_SUCCESS) {
-		strncpy(cap->name, dev_name(&vscsi->dma_dev->dev),
-			SRP_MAX_LOC_LEN);
+		strscpy_pad(cap->name, dev_name(&vscsi->dma_dev->dev),
+			sizeof(cap->name));
 
 		len = olen - min_len;
 		status = VIOSRP_MAD_SUCCESS;
@@ -3650,7 +3650,7 @@ static int ibmvscsis_get_system_info(void)
 
 	name = of_get_property(rootdn, "ibm,partition-name", NULL);
 	if (name)
-		strncpy(partition_name, name, sizeof(partition_name));
+		strscpy(partition_name, name, sizeof(partition_name));
 
 	num = of_get_property(rootdn, "ibm,partition-no", NULL);
 	if (num)

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-8a9bd0e54666

Best regards,
--
Justin Stitt <justinstitt@google.com>

