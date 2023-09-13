Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6FD79F2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjIMUXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIMUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:23:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2581BC8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:23:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b52554914so2971297b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694636583; x=1695241383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XLVs+6bnfHlUZtqtSLrfEVAUEdElqt9QJcV0k0rrN6k=;
        b=Y6tP84ERqkDKcGxAVmZeOsN/6uvjKSNey2wMz4IBgzyXgZnA6NqK3yiBSY1fvjrT3q
         lfRhCUMp6QUwQulGXeuOfctXBwaAK+ATBzSFvzR5f7N5ZRINgNOf2yooIho7Ruv1mMUs
         G3ROcRsoupfRYWqIjbp5Wq2D7X3u/wkAu6tXkogBjEsAtOEsgS5qc34Q15qD2bkalbjo
         nKEKkcZ2trK8dDXJmwQVJ1p2/95e0frU+k0KrXCzSwM3t3U4JlhhkGAaQimlDd/3kdV4
         rBOZbQkns4oSbMcC7PxIDd4nuZzrWACFSBB8+wFg1Qb+wgpu1irK997WubD2WUVC5RoR
         yKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694636583; x=1695241383;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLVs+6bnfHlUZtqtSLrfEVAUEdElqt9QJcV0k0rrN6k=;
        b=w0L+WJkRohLrIRR6/buqVqzDTvOovF3soikjfO85RlF+FQd6tx3ehfHzHRBCmIUlmM
         fSmLkQNwk9KzOdIrvxoiPP22mMUBOYfhD1/H3BEV9D5fBXQNoPyZNG/F9D9Jqfbd44T7
         EsLXL2JRv+aXRRBLVAVK7RrcSlSh4hdx66OrrQSKdzXAYmArbZy+dkF/+LhUK6YjIUq3
         WWY47inW3Fx9zwetaA2StnvAl6APBPp0SQ83ap29zm2mz25lo7w0cVFFpl3iZlYYZZLJ
         EdTCpWWW7zJ61KMpVijx3NN99G4lxI7lqOdDPEBEruwMiYPnRGDaaZbHXTZ3oyjhKnNF
         rxxQ==
X-Gm-Message-State: AOJu0Yy82eNbxoxqgVBgqZS53ZUhJgC/ucAg0I+Ha8pU2IqL1ge79CAk
        Oe+nrvY6kqQEZNwAwVfpNDaA1ddRqz6b/4n0Qg==
X-Google-Smtp-Source: AGHT+IH6PBuI/9PEyPLMURyvaLd2wWJ5nq4Nq4LzMK+VjpjvcMFoH6Veim3KBZowhXINgmUEpT7BsE4SUJC+BkTBkw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:3108:b0:59b:e97e:f7d7 with
 SMTP id fb8-20020a05690c310800b0059be97ef7d7mr10791ywb.1.1694636583064; Wed,
 13 Sep 2023 13:23:03 -0700 (PDT)
Date:   Wed, 13 Sep 2023 20:23:02 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACUaAmUC/x3NywrCQAxG4VcpWRvozJR6eRURKWlG/4VjSUpVS
 t/doctvc85KrgZ1ujQrmS5wvEtFODQkz6E8lDFWU2xjas8hsc9WZPrxaFjUnDPs9RlMecbdBSw cY98fu5AknDLVzmSa8d0f19u2/QEyILlDcwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694636581; l=1662;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=SaJSLsGfiwN8Z9qDzVTnJDfBIIvce2p/HX14tKRLMrc=; b=isyfhr2IybzgbSgYpUiLNvFNLLapon+q44khS63C6lQdJpD07Owf7rFKWlnZSjXr/pvfX+d9M
 0S8wXWPqEHHC6Q4LPImWcaxPhpnnxPUrHci8d0JQRBWvVp9SeWxgjZZ
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-firmware-ti_sci-c-v1-1-740db471110d@google.com>
Subject: [PATCH] firmware: ti_sci: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer.

It does not seem like `ver->firmware_description` requires NUL-padding
(which is a behavior that strncpy provides) but if it does let's opt for
`strscpy_pad()`.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/firmware/ti_sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 26a37f47f4ca..ce546f391959 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -485,7 +485,7 @@ static int ti_sci_cmd_get_revision(struct ti_sci_info *info)
 	ver->abi_major = rev_info->abi_major;
 	ver->abi_minor = rev_info->abi_minor;
 	ver->firmware_revision = rev_info->firmware_revision;
-	strncpy(ver->firmware_description, rev_info->firmware_description,
+	strscpy(ver->firmware_description, rev_info->firmware_description,
 		sizeof(ver->firmware_description));
 
 fail:

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230913-strncpy-drivers-firmware-ti_sci-c-22667413c18f

Best regards,
--
Justin Stitt <justinstitt@google.com>

