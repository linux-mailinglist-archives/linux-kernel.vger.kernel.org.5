Return-Path: <linux-kernel+bounces-65809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB4855220
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8C21F29F98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C5912C53B;
	Wed, 14 Feb 2024 18:30:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1912D745
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935442; cv=none; b=hB0vQgERZdAjKngUgfzUubZ0JS9tCy51khsEt1HkqgdLIXPPxbVM5PDIJmQBDOt3sL8KQGP11rHijKt9/MK7PLYKewgAoY40DMwrPKYVA65Dz8bLf90/cvFWLc3iEfmp4cmCFDm+OSVWmFdX8vf1bljTwAhGqsxMk8FrU2tWuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935442; c=relaxed/simple;
	bh=seWpBFlFjy02oiaHbxmblsXfECvB/RvpFemRUNdrD54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9or2f7vJrP57lEWVZ51ffR+4/jATFtMVx7vGD9U7tmazx+IYYsnYaLye3apgUSYvuFpIUoVszNItumfM22pogxp4X1yY+26o59uc9cLQdu0pk0pQFSUS4enhwcM11v7q9tNboHKA2lt/uKv6jVgGSr/QYcruGtdmxOMWRsacaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87A5A1476;
	Wed, 14 Feb 2024 10:31:21 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5F563F7B4;
	Wed, 14 Feb 2024 10:30:38 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 5/7] firmware: arm_scmi: Update supported Clock protocol version
Date: Wed, 14 Feb 2024 18:30:04 +0000
Message-ID: <20240214183006.3403207-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214183006.3403207-1-cristian.marussi@arm.com>
References: <20240214183006.3403207-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update supported Clock protocol version to v3.2 (0x30000)

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 4e7f072142b9..ca1729fd42cf 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -13,7 +13,7 @@
 #include "notify.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
 
 enum scmi_clock_protocol_cmd {
 	CLOCK_ATTRIBUTES = 0x3,
-- 
2.43.0


