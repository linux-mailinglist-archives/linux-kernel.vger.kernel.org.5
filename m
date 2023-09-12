Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6F79DC41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjILWwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjILWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:52:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB7010F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:52:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e4d2b7d16so72923227b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694559125; x=1695163925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TF/ZOoMeRdt3mIBCTUA9c4c1ylLEIjuiWAktYofcXzg=;
        b=g5FTolfZpjiRsEo6cV5ccyXIO8eTwXPUBoSIDV6/KanqUrlENDfAmsnJhDG9rxjjlW
         m3aqElm1ZHpJ4ghcNHzeVdoJCbzreRuCCL3DLhWiycJovZasyOkD7KBFT8VJYVIubi7D
         t3MyoH4YnoMckrZH8eHifzsI9jDCjbigqGPBaoSnBKGH907GBbLWkh1jDj/FXu2leKNW
         J3jdi2oofarN+oLJNuOc2ZEcGRgtxUTKE9eBTAVMIjZuAylJUy7Vk3bgfXn73W+079N/
         cbBnR7Bx2fKKHknn+ogEeZc0IvV9xD7w4/FJKVcDao8xovN6cw9FNBBRnb+1NwazaLP3
         mcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694559125; x=1695163925;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TF/ZOoMeRdt3mIBCTUA9c4c1ylLEIjuiWAktYofcXzg=;
        b=feW5/nQk2/5wcNbJDM8ZGNy3BVXuJACfiLUZt7gJnZKJOK783nXQtDtpJAB3J8u+U9
         wMLbn8QjFjmtBkFIX/7+/oojUqve3NjDbqpEhjl7RYCW9NRxOcgC2Xn+BZTkYmR8AebY
         UiCrdQaVyjYwIqaQAIxA5hpXwz7qBkRYBrsOtoQHAB27AjQxqEAU9hcXRxruDwNPvRov
         KfyHYIz9tYOyI+MWG9rN+N+iM6qHovHbeMwHKVOWByA80vNFNV0SAkrs9w+nMcUwaPQQ
         nSy1wRQS/RPoC1kZXm+COBlUqLUJXRFleJZBbczahOngn2hITbSAgAVJ7M8K0L+F55ih
         OWxg==
X-Gm-Message-State: AOJu0Yzh/6ot5f2gqMMwQzuQCZBlcuJEMjbMLrWjclHLh+s1vPH475hY
        jn8houHPB2X2haWlgIgEnDljUR5ijNK086jC/A==
X-Google-Smtp-Source: AGHT+IFxptkOduun5HvMxIpAGwDFry0giLXElOB0rBRO5TAsdKAt+kfSy1Xr3O778RlmDzs77ghhbc4Msg+ndglFYg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:26c4:0:b0:d47:5cc3:9917 with SMTP
 id m187-20020a2526c4000000b00d475cc39917mr16986ybm.9.1694559125382; Tue, 12
 Sep 2023 15:52:05 -0700 (PDT)
Date:   Tue, 12 Sep 2023 22:52:04 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJPrAGUC/x3NQQrCMBBG4auUWftDk4JGryIu7GSqAxrDTC1K6
 d0NLr/Neyu5mIrTqVvJZFHXV2kIu474fi03geZmin0c+mOI8NkK1y+y6SLmGN+OyR94MnI1BmP kQ04hDWkvTK1TTSb9/B/ny7b9AIbKy5JzAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694559124; l=2952;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=kEANMmK+bqZl13+G6AqIwN3Hu49jxSBc0yPr/PwkKEQ=; b=jSu183lSNeuj5MYdOyW/+gQyJOHAxs/+AcQuooSNWAo1F4W0rMFvV1rIX91/bUegAMCJBQqWB
 m3DPFzgjlSwBYpwnjgJXFtyLIDDOsNPp2gYCmCPHJzDJvSrhOd/k2Sg
X-Mailer: b4 0.12.3
Message-ID: <20230912-strncpy-drivers-bus-fsl-mc-dprc-c-v1-1-cdb56aa3f4f4@google.com>
Subject: [PATCH] bus: fsl-mc: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We need to prefer more robust and less ambiguous string interfaces.

`obj_desc->(type|label)` are expected to be NUL-terminated strings as
per "include/linux/fsl/mc.h +143"
| ...
|  * struct fsl_mc_obj_desc - Object descriptor
|  * @type: Type of object: NULL terminated string
| ...

It seems `cmd_params->obj_type` is also expected to be a NUL-terminated string.

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees NUL-termination on the destination buffer whilst keeping the
NUL-padding behavior that `strncpy` provides.

Padding may not strictly be necessary but let's opt to keep it as this
ensures no functional change.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/bus/fsl-mc/dprc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index d129338b8bc0..dd1b5c0fb7e2 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -450,10 +450,8 @@ int dprc_get_obj(struct fsl_mc_io *mc_io,
 	obj_desc->ver_major = le16_to_cpu(rsp_params->version_major);
 	obj_desc->ver_minor = le16_to_cpu(rsp_params->version_minor);
 	obj_desc->flags = le16_to_cpu(rsp_params->flags);
-	strncpy(obj_desc->type, rsp_params->type, 16);
-	obj_desc->type[15] = '\0';
-	strncpy(obj_desc->label, rsp_params->label, 16);
-	obj_desc->label[15] = '\0';
+	strscpy_pad(obj_desc->type, rsp_params->type, 16);
+	strscpy_pad(obj_desc->label, rsp_params->label, 16);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dprc_get_obj);
@@ -491,8 +489,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
 	cmd_params->irq_addr = cpu_to_le64(irq_cfg->paddr);
 	cmd_params->irq_num = cpu_to_le32(irq_cfg->irq_num);
 	cmd_params->obj_id = cpu_to_le32(obj_id);
-	strncpy(cmd_params->obj_type, obj_type, 16);
-	cmd_params->obj_type[15] = '\0';
+	strscpy_pad(cmd_params->obj_type, obj_type, 16);
 
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
@@ -564,8 +561,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	cmd_params = (struct dprc_cmd_get_obj_region *)cmd.params;
 	cmd_params->obj_id = cpu_to_le32(obj_id);
 	cmd_params->region_index = region_index;
-	strncpy(cmd_params->obj_type, obj_type, 16);
-	cmd_params->obj_type[15] = '\0';
+	strscpy_pad(cmd_params->obj_type, obj_type, 16);
 
 	/* send command to mc*/
 	err = mc_send_command(mc_io, &cmd);

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230912-strncpy-drivers-bus-fsl-mc-dprc-c-bc7d818386ec

Best regards,
--
Justin Stitt <justinstitt@google.com>

