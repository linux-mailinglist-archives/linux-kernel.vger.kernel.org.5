Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5507DC034
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjJ3TEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJ3TEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:04:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF25C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:04:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa77f9a33so37456857b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698692674; x=1699297474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VzjnyJquTGOFDWRTCwIsnRPKQd4yoRAbd2BHiNTCYPE=;
        b=EEJKJlI3j02hbDoFlIPRQJC5wSuF3SlQNHQ4XVNv2VVn8dB1YtDyWRHgh9s7e4j136
         Ms+iUGkcFpCRkMUtcrvXpdTm1pgmINLMif64cGkftgnd+6NseVTOSrJ8IhtPaG4IwRc/
         ItTCD4RcQ28Hw/JqhAFEoXnlXx54c0pDZ3d5aJpS5KXN79UREtGnQh4r4sCXUpOKo0sJ
         rIqNjHVEh/QF47YL39bP9uckW1fRfYz0PTPsEvZWPRI7fnkGVfiJds4ikx4fu8UwEHwd
         ec6tJ3dIhvm+wGv/zem5nzmH2ymJ1vzwW4da165MsLED0w3BqkEAuwmlJBG8V/H6uB5e
         p1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692674; x=1699297474;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzjnyJquTGOFDWRTCwIsnRPKQd4yoRAbd2BHiNTCYPE=;
        b=t8z7Bi/eZ/DecQBOvTbmamp7r+lkVFe5VvWPxDRHOmIwnyXCgKqGpsZYcbe6mNVOu5
         Z5piDaNsAq47ZIDXPikwwLnqRvcxlCYMSDyiukTno3ZdJNreVLQ255oRMeMNoYjjwqWD
         xLtW4fqYMsBZkdAD1okmkMHaogE14kgZjdEZwGB6OxkFgkt9UEpiSgM3YlQ3pVmSXWEu
         YvUo6taoK6RR3qYq5A71uoRe2BQR5Eey7JBaPNivHAypLkDDXASZv1bsQ87FkX50dRNX
         ehJcMFAQKIBHh6k7CEtHruDFYAn7WleZnbUFdYfe6pOqsf0M+kFtm1/AfdipPg7wziaZ
         h5QQ==
X-Gm-Message-State: AOJu0YxtKrI19yv5b6d6BKvjoeAzrkJaErBf8IrRyuEUllJw5S/ZFnmZ
        KKtbDfS4A2J74Xv/qY9E+4ISrhpr3rTulxp9Gw==
X-Google-Smtp-Source: AGHT+IGs9hKG8tQnq+Kf3PiCNiCsBtpBmbVL7oN4YtYcjhYgkAwIvgGyw0USxYueImjqREofzsC5LZCxvaMlUQpNyQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:2d24:0:b0:d9a:4e29:6353 with SMTP
 id t36-20020a252d24000000b00d9a4e296353mr218208ybt.0.1698692674494; Mon, 30
 Oct 2023 12:04:34 -0700 (PDT)
Date:   Mon, 30 Oct 2023 19:04:33 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAED+P2UC/z2NQQqDMBBFryKzdiAmBKRXKS7qZKKzaCozEiri3
 Ru6kLf5b/PfCcYqbPDoTlCuYvIpTYa+A1pfZWGU1By882FwwaHtWmg7MKlUVkMjE5T5Xe+RCRu UiYOPMcUR2tmmnOX7Dz2n6/oBR6DxKHgAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698692673; l=3539;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=72GgGEwj5Ps4pN3RPFU4tntY2mPxjof123VGlstKADQ=; b=zhou5EtC7CO55iMzjZDC3sTtF8LQi9QWb7YsZHwNRpQImsTgbFvjV9qobc8UJI22pNUZTB22k
 UiJOp9DK74sDASAGgsMQXEHSs+ldJdpEAf29LQBBGDrJByfvj0X0ISh
X-Mailer: b4 0.12.3
Message-ID: <20231030-strncpy-drivers-scsi-ibmvscsi-ibmvfc-c-v1-1-5a4909688435@google.com>
Subject: [PATCH] scsi: ibmvfc: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect these fields to be NUL-terminated as the property names from
which they are derived are also NUL-terminated.

Moreover, NUL-padding is not required as our destination buffers are
already NUL-allocated and any future NUL-byte assignments are redundant
(like the ones that strncpy() does).
ibmvfc_probe() ->
|       struct ibmvfc_host *vhost;
|       struct Scsi_Host *shost;
...
| 	shost = scsi_host_alloc(&driver_template, sizeof(*vhost));
... **side note: is this a bug? Looks like a type to me   ^^^^^**
...
|	vhost = shost_priv(shost);

... where shost_priv() is:
|       static inline void *shost_priv(struct Scsi_Host *shost)
|       {
|       	return (void *)shost->hostdata;
|       }

.. and:
scsi_host_alloc() ->
| 	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);

And for login_info->..., NUL-padding is also not required as it is
explicitly memset to 0:
|	memset(login_info, 0, sizeof(*login_info));

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index ce9eb00e2ca0..e73a39b1c832 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1455,7 +1455,7 @@ static void ibmvfc_gather_partition_info(struct ibmvfc_host *vhost)
 
 	name = of_get_property(rootdn, "ibm,partition-name", NULL);
 	if (name)
-		strncpy(vhost->partition_name, name, sizeof(vhost->partition_name));
+		strscpy(vhost->partition_name, name, sizeof(vhost->partition_name));
 	num = of_get_property(rootdn, "ibm,partition-no", NULL);
 	if (num)
 		vhost->partition_number = *num;
@@ -1498,13 +1498,15 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 	login_info->async.va = cpu_to_be64(vhost->async_crq.msg_token);
 	login_info->async.len = cpu_to_be32(async_crq->size *
 					    sizeof(*async_crq->msgs.async));
-	strncpy(login_info->partition_name, vhost->partition_name, IBMVFC_MAX_NAME);
-	strncpy(login_info->device_name,
-		dev_name(&vhost->host->shost_gendev), IBMVFC_MAX_NAME);
+	strscpy(login_info->partition_name, vhost->partition_name,
+		sizeof(login_info->partition_name));
+
+	strscpy(login_info->device_name,
+		dev_name(&vhost->host->shost_gendev), sizeof(login_info->device_name));
 
 	location = of_get_property(of_node, "ibm,loc-code", NULL);
 	location = location ? location : dev_name(vhost->dev);
-	strncpy(login_info->drc_name, location, IBMVFC_MAX_NAME);
+	strscpy(login_info->drc_name, location, sizeof(login_info->drc_name));
 }
 
 /**

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231030-strncpy-drivers-scsi-ibmvscsi-ibmvfc-c-ccfce3255d58

Best regards,
--
Justin Stitt <justinstitt@google.com>

