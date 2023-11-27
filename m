Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3015F7F9900
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjK0F7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjK0F7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:59:17 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF1135;
        Sun, 26 Nov 2023 21:59:23 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso2740616a12.0;
        Sun, 26 Nov 2023 21:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701064763; x=1701669563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+lkPxpcGV4ulENWtL8UIKN/+j2CNZhdMfJlWPRbNbU=;
        b=duYudwbbeqcH+XWtSQ8mUZK/37sVW4InUWrAVTGMKUMECoWmFOIgn7JMyOOuX4qQ7z
         gEiCRMqBKJr9Ed3FTU+cmLvsvoS2ycl50RlFEyNqniiI42I7jX+lBQKirLvmbgI6XD4X
         5qd5x4rq3gM7GkRK0ItmNzGL2Nc9dWIi8nSP5igxtU0kUeN9gpK2/PndnY+WRd4HGxBA
         fwX+7xIe5GNb6Agpj4x1nk1iuwf3VxWYESxOWJsoFGRlyyAaOiYLp7gfwDd+5ybx7fsJ
         hGBqSgj64cTi648BzCd1RgpDMN3x5WFVTADLTFVSIhWOHCQcTnXaRX3N9T5EaDXHOLOz
         r7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701064763; x=1701669563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+lkPxpcGV4ulENWtL8UIKN/+j2CNZhdMfJlWPRbNbU=;
        b=hCbmxNGxKbjOC5FDxNcHBfoaVLv2X8em1o0PWCGWGThlAwN8kuJ8eSmcj6CtojXDrA
         rWS1RwlagHkIC1pJWMu6dUE+GA91D9NTQfBpV5gHGCcLowaAeEkak8/a9+9pQAb7eOvJ
         m+M3iUid3IiLUuxShrfUcnm2vsEZj/cUvEsh2jh2H6DQSvv/BhH1dQ1RwEjit8wpdeya
         0Uk5wWpCU4geR777peRCWr/VIsmbHmMlKodN958L8j+EZFEXXods9d59S8nN3+FjbpOf
         FVtEnD7dVOeUzbMxsppxuO1mdA9KDEDsJbj5HGeqtT1do6RYXg6JTRbeHVmTxmj8uGIL
         /6RA==
X-Gm-Message-State: AOJu0Yw8BYT7Vp2vVD/ChZ/D5EXPxK816/vEoTUaPLa+h8nC0ee2PGrT
        zdNH2a+cF178UHgXeAca5tlWTdCzIfY=
X-Google-Smtp-Source: AGHT+IGHtZK0Vns6BWzZHgVZD1B5+jmOlfvtT8e9meE4tDaoDr2RuIg/boyy2Iqn/QGqgmbdATfAiA==
X-Received: by 2002:a17:90a:1904:b0:27d:1f9f:a57f with SMTP id 4-20020a17090a190400b0027d1f9fa57fmr13232816pjg.32.1701064763065;
        Sun, 26 Nov 2023 21:59:23 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id gm3-20020a17090b100300b0026f39c90111sm6599692pjb.20.2023.11.26.21.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:59:22 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] ACPICA: Remove unused struct field and incorrect comments
Date:   Mon, 27 Nov 2023 13:58:58 +0800
Message-ID: <20231127055858.41004-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return_object_type field in `struct acpi_evaluate_info` is unused,
so remove it.

There are also some issues in the comments of acpi_ps_execute_method().
First, the parameter_type field has already been removed from
`struct acpi_evaluate_info`, so the corresponding field description in
the comments should also be removed. Second, the return_object field
description in the comments is duplicated. Remove these incorrect comments.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 drivers/acpi/acpica/acstruct.h | 1 -
 drivers/acpi/acpica/psxface.c  | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index f8fee94ba708..fe57c3a16e59 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -169,7 +169,6 @@ struct acpi_evaluate_info {
 	u16 param_count;	/* Count of the input argument list */
 	u16 node_flags;		/* Same as Node->Flags */
 	u8 pass_number;		/* Parser pass number */
-	u8 return_object_type;	/* Object type of the returned object */
 	u8 flags;		/* General flags */
 };
 
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 6f4eace0ba69..df5679bbc510 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -70,9 +70,6 @@ acpi_debug_trace(const char *name, u32 debug_level, u32 debug_layer, u32 flags)
  *                                    NULL if no parameters are being passed.
  *                  return_object   - Where to put method's return value (if
  *                                    any). If NULL, no value is returned.
- *                  parameter_type  - Type of Parameter list
- *                  return_object   - Where to put method's return value (if
- *                                    any). If NULL, no value is returned.
  *                  pass_number     - Parse or execute pass
  *
  * RETURN:      Status
-- 
2.43.0

