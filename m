Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52CF787995
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243592AbjHXUtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243596AbjHXUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:49:13 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E126C1989
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:49:11 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id ca18e2360f4ac-791c4ecd5d6so17228739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692910151; x=1693514951;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BpHJy0xtUCv2a8+NkW5PB2F6J+9bq70l3+n1crasXPg=;
        b=4LHD+g3Hs93NzyV+bQ21E+6npsJl1j6DyiILpZfa70xOL04NtrcgcxNja0HiixFg41
         PrTf4UfUdQDU/V8mg2ZFUmRgb2Zuc2OlF7y62wISBC8uCLbBJ4zZqSGeFYa/2SXlIgki
         ExYfzJAfwP3q2slB97qIUwuNJpv1nNtAZQMa0M+MmshbAJsQABzZGYIDI0y6usSMbPMY
         i8rfAcFb3FpVcq9qLYzgBsC0A/7+J+Vrti+dWuRWP0moLpOHVrI/LnzkcV08mqagQXVq
         YoEmujrR1+DBOcTFF+TKf4ZrbsOuHkTinvqyXSDIWx9ImqIm94NhIr5gIvIMDoK5edfs
         BDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692910151; x=1693514951;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpHJy0xtUCv2a8+NkW5PB2F6J+9bq70l3+n1crasXPg=;
        b=RiBQoS7RUduf9ydA8gNWlrv6Gz5kWrGO3QAq+sdGs8pHx+emOd7dIw0m3cbFyJ7YMs
         mkDy2WkJ5mg4+uuFf/UyrEawYG690wSbHTfK1947r9vsrMa0RNsp7o5cIoe8GMSoqnmM
         pbQwM7SW1G5qoSdgKKoc8kIy5f7fSQjw15fREOIy1JSYdzr7YsTVu83og5cE/4aQv+nb
         CwTrbDL3V59n+a2joWZ7inuX+9/HWrGfJBbgqLplSo47a37ZErfx5+2F0kg4azx8XBbA
         Spgi3zSrFScH10mndN7oKhEH5D9aLIhGeXDUMk4r0mXw6JtC6mqNGi5Vnmq90WMf/QJZ
         Gyww==
X-Gm-Message-State: AOJu0YzmyVtDFE2bq0YglsdsNCSzoTFWicRSbC7en+hMWcokmdTg0d4Y
        Qh9kMl03QRQtWEEbYrzSesNAbgDtzVkN7HTuYw==
X-Google-Smtp-Source: AGHT+IGCzg9T12M4d/3pwncQLdGrc6I6tVfup/nIVd1cLf8n14WecMd5Gd812VnV/4jZSw+Sf0ueKAW2eYw3EjxUhw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a02:a155:0:b0:42b:a220:a32d with SMTP
 id m21-20020a02a155000000b0042ba220a32dmr202775jah.2.1692910151324; Thu, 24
 Aug 2023 13:49:11 -0700 (PDT)
Date:   Thu, 24 Aug 2023 20:49:11 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEbC52QC/yWNQQqDQAxFryJZNzBNLZVepXQRY6oBGSUpooh37
 2A3D97i/b9DqJsGPKsdXBcLm3KR66UCGTj3itYVB0p0Sw3VGF/PMm/YuS3qgSyiIw7ccuaR28B +2vgPQeJ0ZyqtPBook7Prx9bz7vU+jh82xQlvfgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692910150; l=1804;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=q9RFqzuzSf+JWcxuWQQn2bXUpH2CiQm1RQ706+wRDyY=; b=JHfQP3Jmi2+KwCdCuR3S3FvUV4fZkP336jFiB4R4SLBE4/A58qQuTS/kDapIjztNdiYDiiYxh
 3SvAzyQcFyJBJyFXWRGaxHRr7ZkcwaenKRdNvQPuN/mBtNP3AXUA0E9
X-Mailer: b4 0.12.3
Message-ID: <20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-v1-1-b81d5639e7a3@google.com>
Subject: [PATCH] habanalabs/goya: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/accel/habanalabs/goya/goya.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/goya/goya.c b/drivers/accel/habanalabs/goya/goya.c
index 7c685e6075f6..d0ac7065f3d7 100644
--- a/drivers/accel/habanalabs/goya/goya.c
+++ b/drivers/accel/habanalabs/goya/goya.c
@@ -466,7 +466,7 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
 
-	strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
+	strscpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
 		CARD_NAME_MAX_LEN);
 
 	prop->max_pending_cs = GOYA_MAX_PENDING_CS;
@@ -5122,7 +5122,7 @@ int goya_cpucp_info_get(struct hl_device *hdev)
 	}
 
 	if (!strlen(prop->cpucp_info.card_name))
-		strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
+		strscpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
 				CARD_NAME_MAX_LEN);
 
 	return 0;

---
base-commit: f9604036a3fb6149badf346994b46b03f9292db7
change-id: 20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-2a05a2202c78

Best regards,
--
Justin Stitt <justinstitt@google.com>

