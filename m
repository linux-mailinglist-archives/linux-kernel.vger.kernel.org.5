Return-Path: <linux-kernel+bounces-96574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A72875E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51494283EC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8A4EB4F;
	Fri,  8 Mar 2024 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rDb2+2zg"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE34EB41;
	Fri,  8 Mar 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882441; cv=none; b=l7fkRj1weyS1Fywl2CJhi7UbVnza16SX55ftMPeZNbbCvvZv1m/DZU0IjGrYBy6Gf+iv+8H8BdllJLmLI0l+lZoTbZD1xOmc0GSgpxcjYbyWTPsm/X3sy60oUyQwdfGtHPmrXXpMy2qNK8e9Gz4zyOHUTi6ugBpYBUZJBwhZAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882441; c=relaxed/simple;
	bh=1rMp09pt+DJziaOPTfngoZfnVNRH/uQtUHw0I3KJEa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jg5avUgTo2PFHTRe61/AwtLlsLvFX7xxv9IP2abck9gM2yOuc0O/9Le0yzRynjsx/Lvhs7hENDXbERj7hfL5YfZzkMpNuzMuZnkmpDyIf4B1HmrGQa3SdTkmTaYkFuLo/elu3uOxdZ3VQn4/Y10d9vI4IeycMpGBcunrYHdSpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rDb2+2zg; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709882435; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sore9SltRzniIBmsB1VRaVO6lEzW9PUjGtyywAUpNBM=;
	b=rDb2+2zgQAmUdjXIrDp7UZ09F7qHo1hPD6/TTjad+fDzNE+8ZzpmDeGQJrzsK63Jf3BokZi8/8Ckit3zO7v9uQ6MBIpFDemkvdNFp6ipA6GXpoSCHS+7mZzM5MjHFaBtjOKgdF4ZxlyM19xQnRBlrQiDKaZxyoxE6z1qLgMUK80=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W21q8eo_1709882434;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W21q8eo_1709882434)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 15:20:34 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ACPI: Add kernel-doc comments for ACPI suspend and hibernation functions
Date: Fri,  8 Mar 2024 15:20:33 +0800
Message-Id: <20240308072033.116556-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances the documentation for the ACPI power management
functions related to system suspend and hibernation. This includes the
use of kernel-doc style comments which provide developers with clearer
guidance on the usage and expectations of these functions.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/acpi/sleep.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 728acfeb774d..5bc61f40c189 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -502,6 +502,7 @@ static void acpi_pm_finish(void)
 
 /**
  * acpi_pm_start - Start system PM transition.
+ * @acpi_state: The target ACPI power state to transition to.
  */
 static void acpi_pm_start(u32 acpi_state)
 {
@@ -540,8 +541,9 @@ static u32 acpi_suspend_states[] = {
 };
 
 /**
- *	acpi_suspend_begin - Set the target system sleep state to the state
- *		associated with given @pm_state, if supported.
+ *acpi_suspend_begin - Set the target system sleep state to the state
+ *	associated with given @pm_state, if supported.
+ *@pm_state: The target system power management state.
  */
 static int acpi_suspend_begin(suspend_state_t pm_state)
 {
@@ -671,10 +673,11 @@ static const struct platform_suspend_ops acpi_suspend_ops = {
 };
 
 /**
- *	acpi_suspend_begin_old - Set the target system sleep state to the
- *		state associated with given @pm_state, if supported, and
- *		execute the _PTS control method.  This function is used if the
- *		pre-ACPI 2.0 suspend ordering has been requested.
+ *acpi_suspend_begin_old - Set the target system sleep state to the
+ *	state associated with given @pm_state, if supported, and
+ *	execute the _PTS control method.  This function is used if the
+ *	pre-ACPI 2.0 suspend ordering has been requested.
+ *@pm_state: The target suspend state for the system.
  */
 static int acpi_suspend_begin_old(suspend_state_t pm_state)
 {
@@ -967,10 +970,11 @@ static const struct platform_hibernation_ops acpi_hibernation_ops = {
 };
 
 /**
- *	acpi_hibernation_begin_old - Set the target system sleep state to
- *		ACPI_STATE_S4 and execute the _PTS control method.  This
- *		function is used if the pre-ACPI 2.0 suspend ordering has been
- *		requested.
+ *acpi_hibernation_begin_old - Set the target system sleep state to
+ *	ACPI_STATE_S4 and execute the _PTS control method.  This
+ *	function is used if the pre-ACPI 2.0 suspend ordering has been
+ *	requested.
+ *@stage: The power management event message.
  */
 static int acpi_hibernation_begin_old(pm_message_t stage)
 {
-- 
2.20.1.7.g153144c


