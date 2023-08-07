Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0069771B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjHGHOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHGHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:14:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E5E78;
        Mon,  7 Aug 2023 00:14:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so19402095e9.1;
        Mon, 07 Aug 2023 00:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691392484; x=1691997284;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/q7KrvUsuo+6OfYFpsl2TwzIR1F7EEM+glRfJ969Fs=;
        b=ooI8pLA5WbikDzEsTrpi5Adh45gbEe1YJFPIFnc1c8h4DVHLb1qGl/f/2UITnC0dAU
         cMz4bz10wnA5fLHVYBoPTH2iY+AzRllM8KHMB4NzKgegRnhO88hEc4qF7B8OckcVq61/
         W7N9fyRbFYwgrS7003b9wTRCUwGa+bVyONUNxUVj7hNgkkSj8QzOLkA8tyW1f3fY1L/c
         SEa/yx8A8uQwydLTLJbEo3z/M1lubuGcdVv0w6tHvLXN8JhTijFUeFxSTzDdcGJiv9Z8
         O7ueVQq57zS3z0vV6zD9NYV38Bz3z4Y8PjBcYrz3cxhshc8bGePvp1WH/hDAy7HwmTbK
         ONtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392484; x=1691997284;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/q7KrvUsuo+6OfYFpsl2TwzIR1F7EEM+glRfJ969Fs=;
        b=D6HqWPu1+KzkG0kTTLtAyHe/+GR9EHUndZIsBudCiC3w5qQylgSW6h/wOf4/1nJ1a8
         pX7RhGx1x94kgBWQBHqaj9CNmZIReR23JeAxy2VYnSYNAaWGTcS3yNRpVYugXpVdVBwL
         EOvXabJDFieUz0wPpHEf21HIcNDenqvs4LJNXBndghhIiwPe7AwV5lejku7wJMyzJl6k
         3i8An9yLHKVDv67IsxyfuLwtGLV7IevJk+OLJbiHUkD/4IqeE5fdeimWKefwpqRU9Rkk
         mZiviAjqPCPYsY77309P3+Q2kmfFpJwZOKXwTT9w92V1zIvgrJv5dtWHyf3EfE8M1GRM
         K7DA==
X-Gm-Message-State: AOJu0Yz15LVkPZUULZ8AjNAGgLFi3fknnG4ZrxpoMdEM1iRTZ+nbSjiB
        j+95L6IqD5xyjae4sij4qekkKoernVkG+w==
X-Google-Smtp-Source: AGHT+IGFQpVxRgW0c9Dee3AMkALeVXE44WfOlwAa9nbqNsWfDhwzFaUjYrgaiCLLh0CfNuUdjQAgGQ==
X-Received: by 2002:a5d:400f:0:b0:317:7255:6ca1 with SMTP id n15-20020a5d400f000000b0031772556ca1mr4688746wrp.31.1691392484112;
        Mon, 07 Aug 2023 00:14:44 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id q14-20020adfcd8e000000b00314329f7d8asm9544888wrj.29.2023.08.07.00.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:14:43 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:14:40 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        ztarkhani@microsoft.com, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] lsm: add comment block for security_sk_classify_flow()
 LSM hook
Message-ID: <ZNCZ4KL7TRDE9vIC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

security_sk_classify_flow() LSM hook has no comment block. Add a comment
block with a brief description of LSM hook and its function parameters.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
Changed in v2:
 - Add parenthesis with security_sk_calssify_flow to refer to it as a
   function in commit message and commit log. 
 - Remove an extra space in the comment block.

security/security.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..b76fb27a1dc6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4396,6 +4396,13 @@ void security_sk_clone(const struct sock *sk, struct sock *newsk)
 }
 EXPORT_SYMBOL(security_sk_clone);
 
+/**
+ * security_sk_classify_flow() - Set a flow's secid based on socket
+ * @sk: original socket
+ * @flic: target flow
+ *
+ * Set the target flow's secid to socket's secid.
+ */
 void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
 {
 	call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
-- 
2.34.1

