Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93BC7B3F94
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjI3JDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjI3JDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:03:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386971A4;
        Sat, 30 Sep 2023 02:03:17 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bffdf50212so233293441fa.1;
        Sat, 30 Sep 2023 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696064595; x=1696669395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYSzdY55+CxrxbH3Om6zQQD6TqvfL34vFHdKYeG2ZYA=;
        b=L9e+6JSJ3Qy6n4kefbNhpoauNqCMWaXKvtUlOA8M4IUCONTj4IabNIMCHvqGdG466K
         Y8S2kxkw4nFW9kdmGUfgwok0PpJ5FnTrxBDJuVHRLyRW3vg+O9yUS+FxccaJUKC+Lj2y
         HqtWksUSROhlkjnT3ovfFF+OsD1AGqtG+IdQdgU/cvG6dJYsU1hafskVTd+LhtZWm9VT
         D4RkSdL8rCJF7VDkPgKZHeWrcbVcp7FXz+edwOOK4G66qzsPe3KPf+nUxf9dTuTHUB4h
         eD51IoQI+YJOAvFBfSunyx+Reak28BNrB7jX4yqFgOruKEZnlOUgtDRrOauxUaj7aVYx
         Clow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696064595; x=1696669395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYSzdY55+CxrxbH3Om6zQQD6TqvfL34vFHdKYeG2ZYA=;
        b=YGywBykB7URCC/zE+uqKTKQZRUVhg5ds9m0o9w5nUYMVaMnMedZdTSjyxzpopZkOAz
         9TWyrq88UTTPCFazs38gkYZThCFkHwcV7a6qP7RpAwVkcCB0ZQPPfRLGKNqGoMrCZz3p
         0/9oUbCzvUuEmImPIDTEFAY5OA8ID1isQUNmOP6MzG+00Bzp1NRq1mS381bkLtriIV4c
         2+J9Oyws5WDkcA7D7xU04rWP44VPkcK4Cj6mz5i3DNoRj4rPsxXknunWtBRCmxH8XBFL
         bO0DnmLiYSww9Xkjcdf6YDZ7BbVLWMLeHzeA4B6AOMxGaMc3PS+lx9xu2Qh/hOxAhq7k
         Dp8A==
X-Gm-Message-State: AOJu0Ywq5BhqF474ogZISuVvALqxuX6tGAV8FORB9mRBdDaLj4ZqRcPj
        Rao+d+W42x/BRd2syTZvIo2G7eVQ3SABR8ze
X-Google-Smtp-Source: AGHT+IHSdH0luyWoKJ4bUEHxt9DqzqMz/aYF1XYSTUy4+HNiFlIp0VCpJLte5ID5dl3YfSnwnrynVQ==
X-Received: by 2002:a2e:9cc2:0:b0:2bf:fae2:f97 with SMTP id g2-20020a2e9cc2000000b002bffae20f97mr6101486ljj.12.1696064595135;
        Sat, 30 Sep 2023 02:03:15 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002bcbae4c21fsm4319794ljz.50.2023.09.30.02.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 02:03:14 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/3] drivers: acpi: Fix pointer declarations in parameter lists which included whitespace spuriously
Date:   Sat, 30 Sep 2023 11:02:48 +0200
Message-Id: <20230930090248.34759-1-bergh.jonathan@gmail.com>
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

Fixed issues where pointer declarations in parameter lists included
whitespace before the parameter names and should not.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/acpi/osl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f725813d0cce..29e0005c30aa 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -493,7 +493,7 @@ EXPORT_SYMBOL(acpi_os_unmap_generic_address);
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status
-acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
+acpi_os_get_physical_address(void *virt, acpi_physical_address *phys)
 {
 	if (!phys || !virt)
 		return AE_BAD_PARAMETER;
@@ -784,7 +784,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 
 #ifdef CONFIG_PCI
 acpi_status
-acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
+acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
 			       u64 *value, u32 width)
 {
 	int result, size;
@@ -816,7 +816,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 }
 
 acpi_status
-acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
+acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
 				u64 value, u32 width)
 {
 	int result, size;
@@ -1197,7 +1197,7 @@ bool acpi_queue_hotplug_work(struct work_struct *work)
 }
 
 acpi_status
-acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
+acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle *handle)
 {
 	struct semaphore *sem = NULL;
 
@@ -1554,7 +1554,7 @@ void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
  ******************************************************************************/
 
 acpi_status
-acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
+acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t **cache)
 {
 	*cache = kmem_cache_create(name, size, 0, 0, NULL);
 	if (*cache == NULL)
@@ -1575,7 +1575,7 @@ acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
  *
  ******************************************************************************/
 
-acpi_status acpi_os_purge_cache(acpi_cache_t * cache)
+acpi_status acpi_os_purge_cache(acpi_cache_t *cache)
 {
 	kmem_cache_shrink(cache);
 	return (AE_OK);
@@ -1594,7 +1594,7 @@ acpi_status acpi_os_purge_cache(acpi_cache_t * cache)
  *
  ******************************************************************************/
 
-acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
+acpi_status acpi_os_delete_cache(acpi_cache_t *cache)
 {
 	kmem_cache_destroy(cache);
 	return (AE_OK);
@@ -1614,7 +1614,7 @@ acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
  *
  ******************************************************************************/
 
-acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
+acpi_status acpi_os_release_object(acpi_cache_t *cache, void *object)
 {
 	kmem_cache_free(cache, object);
 	return (AE_OK);
-- 
2.34.1

