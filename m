Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC48F80E0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345671AbjLLBUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345638AbjLLBUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:20:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA3BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:20:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so5405494276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702344021; x=1702948821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1zDhsNUVn4yIMFjkCDRNEin0bHQri3D2G8bRroxp6Us=;
        b=MZkSx2ZLeyolCz4tPy38TJrR4a+Ag4brz0y7/00ZxtexQDrnHg83AFWT9Li9v1I/Da
         mtTd8OWVcx+DKpYfpT6o8vTrxDj10swKS9vFr0N/fnCFtf+2qIk7zX1NFPiBSi0lFtJG
         JbgQY0BzI0am5IlRM4vztZIjcVDd+DY5otYDPH4ukmSp9Cb4TBon6nDdQkB57EWs3PB8
         duDYTeGUSu3XnIqDPUmxrerrKTuOh4Z3FnMmV85pCvxbwivVjAr937sX0PxEVXWpZulo
         6t804Rs+mUVB49kLWJupGRKFLQmCt9VChHSMERrqAk2BArA2NnIkfoPxYfT9VwwPkxue
         8EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702344021; x=1702948821;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1zDhsNUVn4yIMFjkCDRNEin0bHQri3D2G8bRroxp6Us=;
        b=po9sAUnafpbtWrblFF5qVEhYZIvoOaZxP92a5acXdBqmXL/3jhzfxor1+h2MhKwxZK
         U3t8KkD/5ay5DylRKccmBiTPsbqbgDc0JecuZBZ6CF7CJquQq9sPmRzDra38vGPHxZTo
         pZ0WtFc9Ky8so2M/SHiO1ngTYUmeXkVtEPq2I9MzHtXHqmzKZEwt3+JiFX/Rm7YGM5xT
         dKZWAmGYXzh9SDGXGuLuEQdXFutJhez2df+9afgPL7ezgLbMmjcWulSi6HeG6V7ilCb5
         qPCC8JVsNzRWZwQg6IJzQBPC1NlVGJ0Fqypvsek6KEWuE9tIMIrTLcqH+9SbMc1wx7ZE
         TNUQ==
X-Gm-Message-State: AOJu0Yw7nCOSUjQkoUVCSWA2+B80tSFGlq/3m74NYm76VBqkzlPqXD/E
        LG1qwn/79Q/rX/sOHhZfXstFds+REGHjkabY/Q==
X-Google-Smtp-Source: AGHT+IGCZ/3Hm1oGZDJVqOZYRs9LPHOqFGAgnB5x2qnhyF/MXbWlUssASTcKwx82JlkzLEzUYKLzUY5/EHQX7bbR4Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:52f:b0:db5:48c5:302e with
 SMTP id y15-20020a056902052f00b00db548c5302emr45864ybs.4.1702344021701; Mon,
 11 Dec 2023 17:20:21 -0800 (PST)
Date:   Tue, 12 Dec 2023 01:20:20 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFS1d2UC/6WOQQ6CMBREr2K6tqYtFsGV9zDEQPspPxFK+ptGQ
 ri7hZ1rd/NmMW9WRhAQiN1PKwuQkNBPGdT5xMzQTg442sxMCVVIUQhOMUxmXrgNmCAQJ0PIsRv
 THl7RxV8wvGrrzgrQ17IsWZ6dA/T4OZTPJvOAFH1YjgdJ7u0fsiS55JWuO21A6VtvH85794aL8 SNrtm37AnDg44XxAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702344020; l=4467;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9iNx/XHoAbZspBn0RbR1EutQz4ViuX602P3R/36GQ8c=; b=ACnHEmP9avRU458e42EgHVuaVBoRcXII5xatNVn8cssXGucBR8pasyE0oiyg7hd0qGAmlVZEb
 WJGm7jNqDLeDk/nFXjOFe7SEQg4jBctpuaST44ZAsyJIZoqPwCiEGIb
X-Mailer: b4 0.12.3
Message-ID: <20231212-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v2-1-bdb9a7cd96c8@google.com>
Subject: [PATCH v2] scsi: ibmvscsi_tgt: replace deprecated strncpy with strscpy
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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

However, for cap->name and info let's use strscpy_pad as they are
allocated via dma_alloc_coherent():
|       cap = dma_alloc_coherent(&vscsi->dma_dev->dev, olen, &token,
|                                GFP_ATOMIC);
&
|       info = dma_alloc_coherent(&vscsi->dma_dev->dev, sizeof(*info), &token,
|                                 GFP_ATOMIC);

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use strscpy_pad for info->partition_name (thanks Kees)
- rebase onto mainline bee0e7762ad2c602
- Link to v1: https://lore.kernel.org/r/20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v1-1-859b5ce257fd@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 4dc411a58107..6b16020b1f59 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -1551,18 +1551,18 @@ static long ibmvscsis_adapter_info(struct scsi_info *vscsi,
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
-		sizeof(info->srp_version));
-	strncpy(info->partition_name, vscsi->dds.partition_name,
-		sizeof(info->partition_name));
+	strscpy_pad(info->srp_version, SRP_VERSION,
+		    sizeof(info->srp_version));
+	strscpy_pad(info->partition_name, vscsi->dds.partition_name,
+		    sizeof(info->partition_name));
 	info->partition_number = cpu_to_be32(vscsi->dds.partition_num);
 	info->mad_version = cpu_to_be32(MAD_VERSION_1);
 	info->os_type = cpu_to_be32(LINUX);
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
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-8a9bd0e54666

Best regards,
--
Justin Stitt <justinstitt@google.com>

