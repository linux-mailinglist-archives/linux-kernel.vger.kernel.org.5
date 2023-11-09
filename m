Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8C17E737C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbjKIVUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:20:48 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5BCD68;
        Thu,  9 Nov 2023 13:20:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bde026c1e1so149076a12.1;
        Thu, 09 Nov 2023 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699564845; x=1700169645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsvShR7q5/4puO4BbnmQ13+xfWAhOYuyw8hfh0n1j6s=;
        b=hr0ngwDKtuLG3BwGzpPLDWUj17ttk0oML/34OSK2P5U/RYr6WJowESlh9cVU60c6mQ
         JweRIIwD4/x6hFZrFZ7xZnBpnNkrXw+i0cqFEC4z3+3ucNurFHtDLsELEIBB5TeST5dk
         TwNDrk/CgoOZdf3VISI/LbRMTNnW97IRfE4zPNOK+09xi2le0laXHwI0pjNRWaLSXYKG
         MxrQ+877TzBmcqRSnq3qz5LMG4HPM43fTDJLiwlUj8CBc9MHLU/Jt3dWntemO+Rc4yNi
         H2AzSVw1hQOINQqKUPkt7KqdK3mjQa8bZdaYAwZ8KljwLW5KJB6bQICdGrHGiLov7XHc
         6b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564845; x=1700169645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsvShR7q5/4puO4BbnmQ13+xfWAhOYuyw8hfh0n1j6s=;
        b=dKWHxQZU5w1btNSQ7qV5IC/uxhbVwxtiToQO4RRuzKqOBQ8IwfqDgQBiCkg78jG30I
         wf+sbGOo03iPEU/DB3zZxaq9pejZmJ42TJUkvNrY9ppxOceiVgQwcG2/TEN1pENcmo30
         xxyKTz1jwNBESI6w7Key3Wd5LIqS9jaeWtejYJ3ft1SGfQdxnG4gGwd5t1KtxvlIRi9W
         CR9o+jy11UgIhpUpm3vCJx3S0Rn6wOW6v9vePdVs6q8CEdVLLsiPcK2JdSB9+yN5ws0c
         T44H/FoAAndtAeWSIdF7FI9gO+MEjs/ZhaCzpEbt7XdqBdNWEM6XMFBnjDuANe3GvkmE
         GS/w==
X-Gm-Message-State: AOJu0YzO/Zpw/8CehvGhErlCPZ7qH3eALMDA4mIpA2m0vCT9mWkdPXjL
        G6lGwUDk7AYAn/5t5hQwuk3GsSUb/N0=
X-Google-Smtp-Source: AGHT+IFgm9s5BJ8A4WmpafDzV+inKywWIDHS3J5XE0Fqk/WXMqrelwI8cWkN8XKAAxeEdnzeibTwJg==
X-Received: by 2002:a05:6a20:431a:b0:13d:fff1:c672 with SMTP id h26-20020a056a20431a00b0013dfff1c672mr6814252pzk.4.1699564845270;
        Thu, 09 Nov 2023 13:20:45 -0800 (PST)
Received: from abhinav.. ([2402:3a80:196c:ea3:aee5:8832:917a:55b9])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a8b8a00b0026b3f76a063sm213769pjn.44.2023.11.09.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:20:44 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     tony.luck@intel.com, qiuxu.zhuo@intel.com, bp@alien8.de,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] driver : edac Fix warning using plain integer as NULL
Date:   Fri, 10 Nov 2023 02:50:29 +0530
Message-Id: <20231109212029.1454684-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse static analysis tools generate a warning with this message
"Using plain integer as NULL pointer". In this case this warning is
being shown because we are trying to initialize  pointer to NULL using
integer value 0.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
 drivers/edac/i7core_edac.c |  2 +-
 drivers/edac/sb_edac.c     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 23d25724bae4..08bf20c60111 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -376,7 +376,7 @@ static const struct pci_id_table pci_dev_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_nehalem),
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_lynnfield),
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_westmere),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /*
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 0c779a0326b6..a3f50a66de33 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -439,7 +439,7 @@ static const struct pci_id_descr pci_dev_descr_sbridge[] = {
 
 static const struct pci_id_table pci_dev_descr_sbridge_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_sbridge, ARRAY_SIZE(pci_dev_descr_sbridge), 1, SANDY_BRIDGE),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /* This changes depending if 1HA or 2HA:
@@ -505,7 +505,7 @@ static const struct pci_id_descr pci_dev_descr_ibridge[] = {
 
 static const struct pci_id_table pci_dev_descr_ibridge_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_ibridge, 12, 2, IVY_BRIDGE),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /* Haswell support */
@@ -576,7 +576,7 @@ static const struct pci_id_descr pci_dev_descr_haswell[] = {
 
 static const struct pci_id_table pci_dev_descr_haswell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_haswell, 13, 2, HASWELL),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /* Knight's Landing Support */
@@ -620,7 +620,7 @@ static const struct pci_id_descr pci_dev_descr_knl[] = {
 
 static const struct pci_id_table pci_dev_descr_knl_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_knl, ARRAY_SIZE(pci_dev_descr_knl), 1, KNIGHTS_LANDING),
-	{0,}
+	{NULL,}
 };
 
 /*
@@ -686,7 +686,7 @@ static const struct pci_id_descr pci_dev_descr_broadwell[] = {
 
 static const struct pci_id_table pci_dev_descr_broadwell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_broadwell, 10, 2, BROADWELL),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 
-- 
2.39.2

