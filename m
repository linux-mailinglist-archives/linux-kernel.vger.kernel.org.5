Return-Path: <linux-kernel+bounces-21233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08730828C59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952DB28A5F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC3D3D3A5;
	Tue,  9 Jan 2024 18:17:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16F23C062
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C8EBDA7;
	Tue,  9 Jan 2024 10:18:21 -0800 (PST)
Received: from pluto.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C44993F5A1;
	Tue,  9 Jan 2024 10:17:34 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH-next] firmware: arm_scmi: Fix Clock protocol supported version
Date: Tue,  9 Jan 2024 18:17:16 +0000
Message-ID: <20240109181716.2338636-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rollback currently supported Clock protocol version to v2.0 since some of
the latest v3.0 features are indeed still not supported.

Fixes: b5efc28a754d ("firmware: arm_scmi: Add protocol versioning checks")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index c22b974a3e90..3f1d49d5d709 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -13,7 +13,7 @@
 #include "notify.h"
 
 /* Must be updated only after ALL new features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20001
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
 
 enum scmi_clock_protocol_cmd {
 	CLOCK_ATTRIBUTES = 0x3,
-- 
2.43.0


