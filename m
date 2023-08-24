Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9BD787A46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbjHXVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbjHXVUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:20:30 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3411BCA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:20:27 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id ca18e2360f4ac-7919f80dfdcso18923839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692912027; x=1693516827;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qO86SOrNt/Bus6yH3RZ6NHIh4L/C2H1jWp27agE0X8s=;
        b=Ud1e4lee/lxT+08WYmce+U1f94X2hKZ0HS3A0+OxkZ7NXboubNooWRMqoD0m5yuo9H
         HYEsu26TDjpHvMDfhrE42aPPIW9vrSAJ9/sPDtqI66ame/EthBMqEfESEBgGlLnA3qrl
         wc7d+IwCQhNJrAo0FQB5D/Tna1B/xpeQe9rWCUp9soPLu9e7j7jp+Yy+gA2T5bCIlx4R
         zp03rmLoyEyCij+Ecmai4PIad/Guo5lffiBvHe1EbuQVCT+y1vaysTsJFCIuk3OBj0yr
         WKA6XWy3/EeBKAEdpVXKF/pR/e1yi/POUtpYHDTukA9l4TFS5OTg5eiF+kQk3rTjGTa3
         h1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692912027; x=1693516827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qO86SOrNt/Bus6yH3RZ6NHIh4L/C2H1jWp27agE0X8s=;
        b=QtnwWMkiuP+VNpxoO0/jiBkCLcgZ8vUYoqOlp8lOPgNO7p9lns6GETJ+6h4PTj1d9C
         CP/cWma7vZhm9f2o9t4MMJI57XAT9icLIzVM9sc0tVE//K1fyggoQmqvstc5ntlHKCE0
         ac43y4Nzm16GniRp/uOMWnBokATQ4XK3ZFV1cU2zjIS0vTpI79sMUAxSZXIeGv9Uovgv
         ov4jm5FMzKE8VV6IXPilKec9TYoHSCHsBxzJNXPQ3sGO1lZreuk4qFuC5OTcjVBSTzBp
         opQgUpU+7ZGaTR+cjtdhCQfqt2Be4fSbARTB/MVzsoe1XU80N3iyjoaKz2Pp7580xejf
         iGnw==
X-Gm-Message-State: AOJu0YxZB/RC78FVyWJeXQzuK+esO1hoqhDtzAQBUq8rdXxsDkDFCO6X
        9w+6g4SuCq66C80QTAbX7LYBH1TvXKQ3/waTXA==
X-Google-Smtp-Source: AGHT+IER5ha2fWgJx6lHSS1eoto3h/i/OL3lIrASF3/xMjRQF+CTaCsKAgjz7aGWy6TWGngI3zbT5T4ggIRf5+9BHQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:22d3:b0:790:9888:6b8a with
 SMTP id e19-20020a05660222d300b0079098886b8amr236241ioe.4.1692912026928; Thu,
 24 Aug 2023 14:20:26 -0700 (PDT)
Date:   Thu, 24 Aug 2023 21:20:25 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJjJ52QC/x2NQQrCQAwAv1JyNrDGQotfESklzbYRuy6JLkrp3
 116GZjLzAYupuJwbTYwKer6SlXOpwZ4GdMsqFN1oECX0FOL/rbE+YeTaRFzHJnliVry58Dw8HV YfUZGaoliF0OI3EPtZZOo3+N1u+/7H6RxfiZ7AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692912025; l=2174;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=AkY1ltlLajShBH5pypIENQRn4HwO9IAiC6FwdpbjE4c=; b=7ry4KgM79Noq+rsm/cUIU9XVmCBwNnZFpC9eJg6Jte1Mi2Xvm1SKa1tam2ISeNU/RF86ycBzl
 emvqg/t+wTLBAHxB6wuhSDqf8OrORVQzNxH26jATasQWUbSNs2Y8qCs
X-Mailer: b4 0.12.3
Message-ID: <20230824-strncpy-drivers-accel-ivpu-ivpu_jsm_msg-c-v1-1-12d9b52d2dff@google.com>
Subject: [PATCH] accel/ivpu: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

Also remove extraneous if-statement as it can never be entered. The
return value from `strncpy` is it's first argument. In this case,
`...dyndbg_cmd` is an array:
| 	char dyndbg_cmd[VPU_DYNDBG_CMD_MAX_LEN];
             ^^^^^^^^^^
This can never be NULL which means `strncpy`'s return value cannot be
NULL here. Just use `strscpy` which is more robust and results in
simpler and less ambiguous code.

Moreover, remove needless `... - 1` as `strscpy`'s implementation
ensures NUL-termination and we do not need to carefully dance around
ending boundaries with a "- 1" anymore.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/accel/ivpu/ivpu_jsm_msg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index 831bfd2b2d39..bdddef2c59ee 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -118,8 +118,7 @@ int ivpu_jsm_dyndbg_control(struct ivpu_device *vdev, char *command, size_t size
 	struct vpu_jsm_msg resp;
 	int ret;
 
-	if (!strncpy(req.payload.dyndbg_control.dyndbg_cmd, command, VPU_DYNDBG_CMD_MAX_LEN - 1))
-		return -ENOMEM;
+	strscpy(req.payload.dyndbg_control.dyndbg_cmd, command, VPU_DYNDBG_CMD_MAX_LEN);
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_DYNDBG_CONTROL_RSP, &resp,
 				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);

---
base-commit: f9604036a3fb6149badf346994b46b03f9292db7
change-id: 20230824-strncpy-drivers-accel-ivpu-ivpu_jsm_msg-c-2422f7f00fc8

Best regards,
--
Justin Stitt <justinstitt@google.com>

