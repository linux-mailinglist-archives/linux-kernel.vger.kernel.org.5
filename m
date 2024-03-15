Return-Path: <linux-kernel+bounces-103939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18087C6CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9249228289A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4F1361;
	Fri, 15 Mar 2024 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OMUB6LE6"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5119F;
	Fri, 15 Mar 2024 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710463082; cv=none; b=J3PrUCRVxKH7eUiXQGIekGKe+OuX7LIdOrxBpuipJLNopOd+q/IXm22FYFUHzcscOmMocVt8QhcXb7NT7gf8sM6yqdIlF69bTy7QWooakvuwySeotiKCiiCU5I+OBgcPtdUWJzsVV25O95UTs1ybxaejmsDVYMBmFkm2MYgz3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710463082; c=relaxed/simple;
	bh=O+aJPqb8PVSPpsoY82kSTGSpQw4eZ44xl2CPE2dgCSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQq3pLnGavTq1ppNFqBtTp0pgCtGA5JseUDswGSte4fbuiYhizPkcvXtITYf/vr0crhkyP1VcH8ev7v9o/16uGRxmGAJmiQNPddJICJADUHbAgT2qhtOrGsLBZRd/3659uzNPJsHcKdWmbjZejlUuHoGCSEr9ClMPQoVkMq0MYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OMUB6LE6; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710463076; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8AwO9e/7WeeN+DMgRNE/AH1+WurQAlcji4grBC4mXDY=;
	b=OMUB6LE6spFhHhqBu8clIh+gWOaXvI7tTLdwPmK40cFGqKC+ckUOP8uJD4UVE+2J92AVbUTlD8EnOdhp9nF5l4w07dvXl7AeMyArIULBgsc6uG0Ap2v+TH4SFNjSW1Y1jFbDCctQRVH0DM8Jv+SYNFupMfZlkBDtULP5KOGqT6I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2U6Nu._1710463074;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W2U6Nu._1710463074)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 08:37:55 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next v2] ACPI: Add kernel-doc comments for ACPI suspend and hibernation functions
Date: Fri, 15 Mar 2024 08:37:53 +0800
Message-Id: <20240315003753.96173-1-yang.lee@linux.alibaba.com>
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

change in v2:
--According to Randy's suggestion, use a space between '*'
  and function names, function parameters.

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
+ * acpi_suspend_begin - Set the target system sleep state to the state
+ *	associated with given @pm_state, if supported.
+ * @pm_state: The target system power management state.
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
+ * acpi_suspend_begin_old - Set the target system sleep state to the
+ *	state associated with given @pm_state, if supported, and
+ *	execute the _PTS control method.  This function is used if the
+ *	pre-ACPI 2.0 suspend ordering has been requested.
+ * @pm_state: The target suspend state for the system.
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
+ * acpi_hibernation_begin_old - Set the target system sleep state to
+ *	ACPI_STATE_S4 and execute the _PTS control method.  This
+ *	function is used if the pre-ACPI 2.0 suspend ordering has been
+ *	requested.
+ * @stage: The power management event message.
  */
 static int acpi_hibernation_begin_old(pm_message_t stage)
 {
-- 
2.20.1.7.g153144c


