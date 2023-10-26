Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4600A7D7A81
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjJZBxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJZBxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:53:17 -0400
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A80115
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:53:14 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id 5614622812f47-3b2e7a8fbbdso521864b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698285194; x=1698889994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pjp8stIHwO7L4r2Xgqzk9PeiKrAFnh4U0H3mDy43hbM=;
        b=FU7kMCetNBRUX2ViP60iRRv7EMg/QKvhCXlqlcSGbZQwahaxG7jXoOPTjLDdB9MlV1
         gHghRUCtdqcKVTHlOUCPZFg0sFGk4HIWwxuydgvkDVept8v6vm99PolMiJnqdzA6dSkh
         /hT2c3tBtEuxMyAcBtyYnLe5TjuJZpe9+/uBDbQA44StYMgq9HvhS+lmJhnngbEr/igT
         AOIh/f8k6Kcl+0jCpSYqHTTe48NN9C69KVM5iqD3N16zbN0CFK4nLU/RBBfCD91PrFbt
         KRmidBf+P4K9hEJC6aS8HB5aSdOxDUMlBWT24SOvI/vH8K6DYE6wfUQZHxh1I6OHjyOJ
         8+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698285194; x=1698889994;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pjp8stIHwO7L4r2Xgqzk9PeiKrAFnh4U0H3mDy43hbM=;
        b=Q7zC7u4xvMyoeu1Xiejo2MF8ZXK5MCenKwwOuC3wkobCrX/ypfF9q7o4hAmwwiCyfX
         eBo3//QFg/qjgaOj8/Xmz3yQiuH4KgtVMH9c9XrwVGNrNtDylVJRuMjaFlEPfbkFfL/C
         AvABBcl+WOVJakKvzhDpZu6rnbS+zlu/X5XcKX3CzPZWfMo+4+JF/edaAKOZS+YNULBP
         JpkyMnsrrErdn3cPxpZYv4LVKERKOMQfq6hr05WriYe3YbTMbSBsgBvkzXDSzR539cc3
         JYZo8C1wRjJFyq94I14ju05u8TUo1S14f62w47URsqU8b7A9pQs7KIZdr7tsPVECtxbf
         Xq8g==
X-Gm-Message-State: AOJu0Yza5tixOca12v/1Xg5tVk4Wn7GMXtluFLRPJ2iurosB9MxqYu0r
        OBqEWHn3XlEbTmsEWmIA1ngiylI9gkQneg03sA==
X-Google-Smtp-Source: AGHT+IFR8bdTL15YcnhEGV4KArX2GQqck0DFHJVoxlAoubcCaDkQCxdYWrb57IiYGlWJBc9htP5vldakHxwGrWPN5Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:182a:b0:3ae:1691:c59f with
 SMTP id bh42-20020a056808182a00b003ae1691c59fmr7079317oib.1.1698285193848;
 Wed, 25 Oct 2023 18:53:13 -0700 (PDT)
Date:   Thu, 26 Oct 2023 01:53:13 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIjGOWUC/52NQQqDMBBFryKz7pRGqdGuvEeR0sRRB2wiGQmKe
 PemHqGL/+H9xX87CAUmgUe2Q6DIwt4lyC8Z2PHtBkLuEkN+ywuVgrIEZ+cNu8CRgqBYYaRpxYk
 N9RZTXs53hCNaY3p9L1StjYZ0OAfqeT1lzzbxyLL4sJ3uqH7rX5qoUGFlyrLSqXVdNoP3w0RX6 z/QHsfxBYPjGdzlAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698285193; l=2296;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=WD63y2GNp2EK1VTsmPzRbEGCPxluZOXKFCe7l0K3vCw=; b=/x030tgpsz2o7BLKx2T1XvytucXzMZiEPEPMDSyVAqw/VZ8hj5twcwH9avRjfmp3Bb6jWTx/j
 o6vcxZN394aBBS+mMtBem2lDMBgTTeqfzkGfYlPyS5SzrfDpS+TFexB
X-Mailer: b4 0.12.3
Message-ID: <20231026-strncpy-drivers-scsi-elx-libefc-efc_node-h-v2-1-5c083d0c13f4@google.com>
Subject: [PATCH v2] scsi: elx: libefc: replace deprecated strncpy with strscpy_pad/memcpy
From:   Justin Stitt <justinstitt@google.com>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

To keep node->current_state_name and node->prev_state_name NUL-padded
and NUL-terminated let's use strscpy_pad() as this implicitly provides
both.

For the swap between the two, a simple memcpy will suffice.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use strscpy_pad (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20231023-strncpy-drivers-scsi-elx-libefc-efc_node-h-v1-1-8b66878b6796@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/elx/libefc/efc_node.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/elx/libefc/efc_node.h b/drivers/scsi/elx/libefc/efc_node.h
index e9c600ac45d5..e57579988ba4 100644
--- a/drivers/scsi/elx/libefc/efc_node.h
+++ b/drivers/scsi/elx/libefc/efc_node.h
@@ -26,13 +26,13 @@ efc_node_evt_set(struct efc_sm_ctx *ctx, enum efc_sm_event evt,
 	struct efc_node *node = ctx->app;
 
 	if (evt == EFC_EVT_ENTER) {
-		strncpy(node->current_state_name, handler,
-			sizeof(node->current_state_name));
+		strscpy_pad(node->current_state_name, handler,
+			    sizeof(node->current_state_name));
 	} else if (evt == EFC_EVT_EXIT) {
-		strncpy(node->prev_state_name, node->current_state_name,
-			sizeof(node->prev_state_name));
-		strncpy(node->current_state_name, "invalid",
-			sizeof(node->current_state_name));
+		memcpy(node->prev_state_name, node->current_state_name,
+		       sizeof(node->prev_state_name));
+		strscpy_pad(node->current_state_name, "invalid",
+			    sizeof(node->current_state_name));
 	}
 	node->prev_evt = node->current_evt;
 	node->current_evt = evt;

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231023-strncpy-drivers-scsi-elx-libefc-efc_node-h-cbbf753197b7

Best regards,
--
Justin Stitt <justinstitt@google.com>

