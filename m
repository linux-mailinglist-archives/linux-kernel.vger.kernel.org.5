Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC37FACB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjK0VmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjK0VmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:42:03 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12791B8;
        Mon, 27 Nov 2023 13:42:09 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cbccd8e35eso1198013b3a.1;
        Mon, 27 Nov 2023 13:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701121329; x=1701726129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myrpZavS/ZIQlzexaWPRFCPa0NXMX6v/A+LHtFffEwM=;
        b=EmvdYx8y0hHTeDeyk78Cu0LzdJRXscp9G+5QD1xkk0mluMR0iEg9j6YoU7yGhyzCwZ
         dDo6W4CSFy6aQRJgeRNFLGSRFWqXfonCQUU/JEb38rQBaZcqYfAPcfE2wdkde7fdqqO2
         /+hW3RSXhhFujQH2WdXtdBkJ0pLT3gvEZgQDNq4cJth9ke0NrWUltaoSPFkt/OCRLWwI
         PMcyPWaoOWBmy684TC0aJ3KSIwxjqiAK+7i1sEf8ZUl+DaQLLkXganc77vR0BU82mPhd
         5EyZc5nYsyJB0NmW1DcOC2+YeQ8kdzPMPQUpGbn1gV/VMgh4JMfX5B3NGK1kKzsepNkt
         7Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701121329; x=1701726129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myrpZavS/ZIQlzexaWPRFCPa0NXMX6v/A+LHtFffEwM=;
        b=ErfDw6Cr8BXf98Wp+dQ/YwF3gP1LzTTGrXq/YHIYdSV9r8CbbsDxoXfjOx5e3MtOdN
         9dloVTPI5aPpucITRYGkCg1rVsJQjJ0ffBmtpAIJFAxugahsYlivb+lel2AkVgoLaNO0
         sNlUhTCHdZxf6+khekUOxtUpOzVBWfaLAnG9zUMoXySY+bJKmBVmlTyJzKXJ2mmUaVbw
         hHjK0ynX43BfE2DxKD3RyJMvBk1J4hFgpJq//h9Wgi1CoTQHIzq/wxPAoYni2qM0xFvi
         bU3wxyhoARL/K/ceGRAtDwZxZ9n/iOyRPFm1OqGiuhjZ7N2IHAYJtpTw8q28hJRYedPE
         X8fA==
X-Gm-Message-State: AOJu0YxH0OUHY220LJHrKmKoBcYP3+MOSf1ekSc2QgvRfuAVzfD9Lb2S
        zhXTHKl0zrrq4OiLkJKAX6s=
X-Google-Smtp-Source: AGHT+IG4FcBRubObIdbxx1j8SLDN83CYW50zmjGMM8K5Ac2bHqz0ogsU0YmmRfKNIZ6pC3ltIDmdMw==
X-Received: by 2002:a05:6a00:3a04:b0:6bc:67ca:671d with SMTP id fj4-20020a056a003a0400b006bc67ca671dmr16117092pfb.1.1701121329177;
        Mon, 27 Nov 2023 13:42:09 -0800 (PST)
Received: from abhinav.. ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b00686b649cdd0sm7680206pfa.86.2023.11.27.13.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:42:08 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, qiuxu.zhuo@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v2] driver : edac : Fix warning using plain integer as NULL
Date:   Tue, 28 Nov 2023 03:11:56 +0530
Message-Id: <20231127214156.432669-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127202906.GIZWT8EgKxGzLQTRtw@fat_crate.local>
References: <20231127202906.GIZWT8EgKxGzLQTRtw@fat_crate.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse static analysis tools generate a warning with this message
"Using plain integer as NULL pointer". In this case this warning is
being shown because we are trying to initialize  pointer to NULL using
integer value 0.

The reason for this change is that use of numeric 0 for a null pointer is 
unacceptable. See this link for the long description why:
Link: https://www.spinics.net/lists/linux-sparse/msg10066.html

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
v1 -> v2: 1. Fixed the comment section descrbing the current code.
	  2. Added a reason for why this change is required.

 drivers/edac/i7core_edac.c | 4 ++--
 drivers/edac/sb_edac.c     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 08bf20c60111..4c76d0f180ec 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -376,7 +376,7 @@ static const struct pci_id_table pci_dev_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_nehalem),
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_lynnfield),
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_westmere),
-	{NULL,}			/* 0 terminated list. */
+	{NULL,}			/* NULL terminated list. */
 };
 
 /*
@@ -385,7 +385,7 @@ static const struct pci_id_table pci_dev_table[] = {
 static const struct pci_device_id i7core_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_X58_HUB_MGMT)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LYNNFIELD_QPI_LINK0)},
-	{0,}			/* 0 terminated list. */
+	{0,}			/* NULL terminated list. */
 };
 
 /****************************************************************************
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index a3f50a66de33..5d9a2963dc54 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -439,7 +439,7 @@ static const struct pci_id_descr pci_dev_descr_sbridge[] = {
 
 static const struct pci_id_table pci_dev_descr_sbridge_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_sbridge, ARRAY_SIZE(pci_dev_descr_sbridge), 1, SANDY_BRIDGE),
-	{NULL,}			/* 0 terminated list. */
+	{NULL,}			/* NULL terminated list. */
 };
 
 /* This changes depending if 1HA or 2HA:
@@ -576,7 +576,7 @@ static const struct pci_id_descr pci_dev_descr_haswell[] = {
 
 static const struct pci_id_table pci_dev_descr_haswell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_haswell, 13, 2, HASWELL),
-	{NULL,}			/* 0 terminated list. */
+	{NULL,}			/* NULL terminated list. */
 };
 
 /* Knight's Landing Support */
@@ -686,7 +686,7 @@ static const struct pci_id_descr pci_dev_descr_broadwell[] = {
 
 static const struct pci_id_table pci_dev_descr_broadwell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_broadwell, 10, 2, BROADWELL),
-	{NULL,}			/* 0 terminated list. */
+	{NULL,}			/* NULL terminated list. */
 };
 
 
-- 
2.39.2

