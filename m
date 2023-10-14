Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD37C937E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjJNIgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 04:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJNIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 04:36:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0F2BB;
        Sat, 14 Oct 2023 01:36:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-503056c8195so3792254e87.1;
        Sat, 14 Oct 2023 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697272574; x=1697877374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W9Daja05OoueSFXSKgaA2RDObCdOKO/kxeq5hi1gOh8=;
        b=GcYdKXPK98KFaRNNlG5TEgGedPcpsDazv23fsEOg0LCwb57UwX9t5cPrQNKiEz6zhL
         +7CnxpkhiTh5sVlu8Rll+iLXEczpcsnuncof88FhljdVgqmZdz3ZLQ4D5C+qqlEdQmmw
         UxTRdBhFH/rJgSFxk201WC/M5NradisxXWt1mIYQnrNoqkH7ml7RbspRKdOZhc3jqAU3
         usXjV/S80q14vx7jCMmnOzZwY7YbjsdGh/PphCcUafjCzteYgykUoUxQnQDsIRallk3b
         wfDAxxmw+9QMAzKkBJ7yuozG52Z8CqeV0jiGDT5cVLYa0lw4Pcj/GYxAyLiInb5aMEnL
         eqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697272574; x=1697877374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9Daja05OoueSFXSKgaA2RDObCdOKO/kxeq5hi1gOh8=;
        b=F+hyIyqFel0ezzfT0cn3pn55XnzgSG2TJAi0HMPfkQulGkSzW/UkedKoTJNVYtDFmx
         dqU2HKQFqCfme1sFzR8G8S/F3tERRj1/myA+RLrcuyyyNBDFAbwWePZcZqNDT06nIEN8
         VIznquUaQCweZp3EShX8BGe4LPxykLlRa5MZsqCaJotW7nQWKZG85Bp6FMZxwNWEnddl
         VAQE/rl0asvC2K/S6ADwz5RjreAhspwDSfaJ5TdES4xDGxUZzbpZlZ2BLFKHgvfl+Gaj
         /pVNZaU9h+jWRRw6T3WzquuTyQdcfLu2RrxheNZDCZM5Bg0G6SP8uRwNkX+5BQW0+BOb
         YbMQ==
X-Gm-Message-State: AOJu0Yw4ZQlxAYjHOb0gPEbdBZZJKYyHcwvFDgodn8d8NnTz012Qteh3
        OPhkO0tMJ9rbohhOMrsFhUayxGROY1EJqPmB
X-Google-Smtp-Source: AGHT+IGvLscpO9yWdAIJJ13Cw6iCySJGJ4wD4sXRZaN/KqdyAi/3XNVRnoXWFffILua0zQVXuSAVHg==
X-Received: by 2002:a05:6512:328f:b0:503:1c07:f7f9 with SMTP id p15-20020a056512328f00b005031c07f7f9mr21864177lfe.29.1697272574265;
        Sat, 14 Oct 2023 01:36:14 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id s8-20020ac25fa8000000b0050482b29ac9sm3700940lfe.212.2023.10.14.01.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 01:36:13 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     hdegoede@redhat.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] staging: media: atomisp: Removed duplicate comment and fixed comment format
Date:   Sat, 14 Oct 2023 10:35:45 +0200
Message-Id: <20231014083545.173238-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the following issues:
 * Removed a duplicate comment
 * Fixed up minor comment format issue

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/i2c/gc2235.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/gc2235.h b/drivers/staging/media/atomisp/i2c/gc2235.h
index 55ea422291ba..ade28950db73 100644
--- a/drivers/staging/media/atomisp/i2c/gc2235.h
+++ b/drivers/staging/media/atomisp/i2c/gc2235.h
@@ -74,9 +74,6 @@
 #define GC2235_COARSE_INTG_TIME_MIN 1
 #define GC2235_COARSE_INTG_TIME_MAX_MARGIN 6
 
-/*
- * GC2235 System control registers
- */
 /*
  * GC2235 System control registers
  */
@@ -167,7 +164,7 @@ enum gc2235_tok_type {
 	GC2235_TOK_MASK = 0xfff0
 };
 
-/**
+/*
  * struct gc2235_reg - MI sensor  register format
  * @type: type of the register
  * @reg: 8-bit offset to register
-- 
2.34.1

