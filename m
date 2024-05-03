Return-Path: <linux-kernel+bounces-168424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366268BB869
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368DC1C209E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A88584E05;
	Fri,  3 May 2024 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="MDk0wUrs"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1B50297;
	Fri,  3 May 2024 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779867; cv=none; b=i8d0OwJT7DVbqRYfji2QFQNKRlbZOK0FRB+NyVht/tubsURCyI4Rc/9XKn0uBt5zKgexpBu3AAJHpA+PBgUPw2Z5kaVWQQhsssXZiM8Hn62m1SWLwsyPmowWRB1l6PX9DcV0Sli6yi/Ry1ivn1KOJaakJa7IZoke49UQ+Zmjo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779867; c=relaxed/simple;
	bh=NnH6zpgiTkRp8PJYZU2PtE0agswv9Uy9KLeTWwaiB4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nig1PANtdt1UfPa2q20ok88VH3lZawlPZmKXSv1UCABQsTVkPtRgCN7DL6DLND+qaKLkdCzqFoxshu8LhZ47fonQOwT60QmyUvRpvhkDbvPYtDebs2mj4B1lBKwUHAyUoHa39YZVcGDB5NILBIVMif0jJHzuIgpAIxhv76+UhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=MDk0wUrs; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=p5MqCzRCn0HtdyuwMCkaHIuoEH8d+Lh/dc16q0rM13M=; b=MDk0wUrs+OyFAvCQ
	rGeNFdtr2h54Se6f17Wd+8Lzkv5ZdVIOtkyLUdXQfz8nmG2XLJ2T7NMMbx94XQQmjXALc6MwaBhZq
	tKnBLjZsJfu5gbt3FOeqoDA8XInvNRbUsQZPEzYoQBocCJXkieT4cOT2CowNZ/xuM4QM5qAC2mU4R
	3kWmpEE5I4F47Sn9H9wf7DCWtOTEu8JqkVcp4ic6uehJcmbkDfOXc19va87eE/6JIDYGqxsCw0EeK
	GYhOkJLNUHE1WyKz1EjanXf7DRrFdM93EwRj/8n5UtKlc5yr0PbpMESULf3KqztV7rBULVcV0TZjB
	kDyVuZBnGGeQ/U+ajw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s32Zi-004eB9-0A;
	Fri, 03 May 2024 23:44:22 +0000
From: linux@treblig.org
To: martin.petersen@oracle.com,
	michael.christie@oracle.com
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] target: Remove unused list 'device_list'
Date: Sat,  4 May 2024 00:44:19 +0100
Message-ID: <20240503234419.171823-1-linux@treblig.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit be50f538e9a5 ("target: remove g_device_list")
made 'g_device_list' local as 'device_list' but also
removed the last use of it, the code that added the device
to it.

Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/target/target_core_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 7a85e6477e465..bf4892544cfdb 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -37,7 +37,6 @@
 #include "target_core_ua.h"
 
 static DEFINE_MUTEX(device_mutex);
-static LIST_HEAD(device_list);
 static DEFINE_IDR(devices_idr);
 
 static struct se_hba *lun0_hba;
-- 
2.44.0


