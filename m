Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92837B3F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjI3JFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjI3JE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:04:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08BE1A7;
        Sat, 30 Sep 2023 02:04:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50325ce89e9so24006819e87.0;
        Sat, 30 Sep 2023 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696064696; x=1696669496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xeGbiFzFYK1tREaSWy6nrxTkbPQlphBhH17z/+R52n4=;
        b=R7POgiQfijlPptE0XKY9gH+g79bLPnXq9ECgwY8b/Hm8bmfSA6Can6fe9l1soSPPff
         RGEGsZ8Ck6Lzb89YwQsyu4Ze8tRqe7Wl3DzA24lVrPDIdn8CugR2Sy/W/udL1jWZnypa
         hgQuIL67FRDnSzNziGHTMz1oysebVWyoTB3Js39CasQs01j9XxhDnQ94BOF1yH3qZyv/
         wVCLEbXjoOE8r76FVueWHLtXN4YKJUWNXJV6Fm6YrU19W8tD0XMSAGqRDWXKbWItHs5P
         +3hitpkL1R6VRJlui5505xKV2Y5YiAss7UDKyaZIQ3ZY9XrdMrX84+XXVZltXnCBhnE+
         U6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696064696; x=1696669496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeGbiFzFYK1tREaSWy6nrxTkbPQlphBhH17z/+R52n4=;
        b=CCIRpMf330V2vjpy6CtOtnIbsMIjg5w2fV3vTTAXUu4NkHwBRLqdM079SGXK9JYkJs
         ARAFkel4wCbzoX6ugTcS22mu4nYawBG80KdCKh3NSBa7Sbbzc3hkAT+9Rf8ogTBWggs8
         rlJh0d/yBdysMKwQemhtHaPDwpc0wVvLuieN7N6jlyQbbYQrR1u84SAf1ueXhQ+pSEgw
         hdoIdt3BHdwZXmWX/XIpuXJpdwncZbmYk5qJImA3nWi0POK2JcyH1LNIa0uAKkX05RJu
         abzpQ8Dg8Q0DNp3sbbzPKN7nghtDnPj5EeWLylqGRraQHEaz8SI6hLX6UIxhGPOIl2Rc
         KQyQ==
X-Gm-Message-State: AOJu0Yy+Hyf9HZSjxZCzBZhInhahweaPzePrJ2OIU/NOSd4O5gT9Y2vi
        vGPwKlu+jsYIf9LV80uRdzk=
X-Google-Smtp-Source: AGHT+IGn+nHzoTYiaz/RWNzHb7S15bcM3hpPDOmyfCnU/j2V8HjHf6SKdEBgmZ8fINa26a9TRYjd4w==
X-Received: by 2002:a05:6512:370a:b0:503:985:92c5 with SMTP id z10-20020a056512370a00b00503098592c5mr4791360lfr.42.1696064695892;
        Sat, 30 Sep 2023 02:04:55 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id u26-20020ac248ba000000b004fbb011c9bcsm3818321lfg.161.2023.09.30.02.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 02:04:55 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 3/3] drivers: acpi: Fix missing newline after declarations
Date:   Sat, 30 Sep 2023 11:04:36 +0200
Message-Id: <20230930090436.35851-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed various instances where missing newlines after variable
declarations were causing checkpatch warnings.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/acpi/osl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index dbbccb612277..18a25429274c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1067,6 +1067,7 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
 	int ret;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
@@ -1522,6 +1523,7 @@ acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock lockp)
 	__acquires(lockp)
 {
 	acpi_cpu_flags flags;
+
 	spin_lock_irqsave(lockp, flags);
 	return flags;
 }
@@ -1708,6 +1710,7 @@ acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 pm1a_control,
 				  u32 pm1b_control)
 {
 	int rc = 0;
+
 	if (__acpi_os_prepare_sleep)
 		rc = __acpi_os_prepare_sleep(sleep_state,
 					     pm1a_control, pm1b_control);
@@ -1730,6 +1733,7 @@ acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state, u32 val_a,
 				  u32 val_b)
 {
 	int rc = 0;
+
 	if (__acpi_os_prepare_extended_sleep)
 		rc = __acpi_os_prepare_extended_sleep(sleep_state,
 					     val_a, val_b);
-- 
2.34.1

