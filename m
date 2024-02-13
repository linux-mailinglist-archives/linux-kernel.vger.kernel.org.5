Return-Path: <linux-kernel+bounces-63727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300318533B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BF11F2BD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAEB5DF2D;
	Tue, 13 Feb 2024 14:54:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D9558AB4;
	Tue, 13 Feb 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836071; cv=none; b=bJxbUfNO/q7I8l03zNRSa0QqsS7xetKKbeQbKZxW7XC1mgYg1XcgCLmGCkieMcqT5R4ov4hokyhQJoOBDV5P2nBjHq9w1UsnRkreAdKrAdTG7qkH/WDWdE7u5a/H8Hl3H9uidA+RIwDzobL9p2Q7LKQI/G9uzpqk265Fp/Awjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836071; c=relaxed/simple;
	bh=n0RduTBwmy+CHrwggpLTiv2Q4pY8AuF40ODIySrlxAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESOzG8hwSeQkdrvOcNTh2LvrPcKqtodgPpFanaVABCUBKZqGGruIpkBxD7CzUjbpMsLZ6skh+spmiOxD2+f3mKLU9+f42bFDzkXYdCYtnmoXNuSv+SmTLJdpyXyX1kOcxjnBBMqx1TppVAYzx9wHtUH3jB4Au3hOX/nWAezonrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A941DA7;
	Tue, 13 Feb 2024 06:55:09 -0800 (PST)
Received: from mango.localdomain (TVHN20WD9G.budapest.arm.com [10.45.25.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B79C33F7B4;
	Tue, 13 Feb 2024 06:54:26 -0800 (PST)
From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: jens.wiklander@linaro.org,
	sumit.garg@linaro.org,
	corbet@lwn.net,
	balint.dobszay@arm.com,
	sudeep.holla@arm.com,
	gyorgy.szing@arm.com
Subject: [PATCH 3/3] Documentation: tee: Add TS-TEE driver
Date: Tue, 13 Feb 2024 15:52:39 +0100
Message-Id: <20240213145239.379875-4-balint.dobszay@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213145239.379875-1-balint.dobszay@arm.com>
References: <20240213145239.379875-1-balint.dobszay@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the Trusted Services TEE driver.

Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
---
 Documentation/tee/index.rst  |  1 +
 Documentation/tee/ts-tee.rst | 70 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/tee/ts-tee.rst

diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
index a23bd08847e5..4be6e69d7837 100644
--- a/Documentation/tee/index.rst
+++ b/Documentation/tee/index.rst
@@ -10,6 +10,7 @@ TEE Subsystem
    tee
    op-tee
    amd-tee
+   ts-tee
 
 .. only::  subproject and html
 
diff --git a/Documentation/tee/ts-tee.rst b/Documentation/tee/ts-tee.rst
new file mode 100644
index 000000000000..e121ebbbfab7
--- /dev/null
+++ b/Documentation/tee/ts-tee.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+TS-TEE (Trusted Services project)
+=================================
+
+This driver provides access to secure services implemented by Trusted Services.
+
+Trusted Services [1] is a TrustedFirmware.org project that provides a framework
+for developing and deploying device Root of Trust services in FF-A [2] S-EL0
+Secure Partitions. The project hosts the reference implementation of the Arm
+Platform Security Architecture [3] for Arm A-profile devices.
+
+The FF-A Secure Partitions (SP) are accessible through the FF-A driver [4] which
+provides the low level communication for this driver. On top of that the Trusted
+Services RPC protocol is used [5]. To use the driver from user space a reference
+implementation is provided at [6], which is part of the Trusted Services client
+library called libts [7].
+
+All Trusted Services (TS) SPs have the same FF-A UUID, it identifies the TS RPC
+protocol. A TS SP can host one or more services (e.g. PSA Crypto, PSA ITS, etc).
+A service is identified by its service UUID, the same type of service cannot be
+present twice in the same SP. During SP boot each service in the SP is assigned
+an "interface ID", this is just a short ID to simplify message addressing.
+
+The generic TEE design is to share memory at once with the TEE implementation,
+which can then be reused to communicate with multiple TAs. However, in case of
+FF-A, memory sharing works on an endpoint level, i.e. memory is shared with a
+specific SP. User space has to be able to separately share memory with each SP
+based on its endpoint ID, therefore a separate TEE device is registered for each
+discovered TS SP. Opening the SP corresponds to opening the TEE device and
+creating a TEE context. A TS SP hosts one or more services, opening a service
+corresponds to opening a session in the given tee_context.
+
+Overview of a system with Trusted Services components::
+
+   User space                  Kernel space                   Secure world
+   ~~~~~~~~~~                  ~~~~~~~~~~~~                   ~~~~~~~~~~~~
+   +--------+                                               +-------------+
+   | Client |                                               | Trusted     |
+   +--------+                                               | Services SP |
+      /\                                                    +-------------+
+      ||                                                          /\
+      ||                                                          ||
+      ||                                                          ||
+      \/                                                          \/
+   +-------+                +----------+--------+           +-------------+
+   | libts |                |  TEE     | TS-TEE |           |  FF-A SPMC  |
+   |       |                |  subsys  | driver |           |   + SPMD    |
+   +-------+----------------+----+-----+--------+-----------+-------------+
+   |      Generic TEE API        |     |  FF-A  |     TS RPC protocol     |
+   |      IOCTL (TEE_IOC_*)      |     | driver |        over FF-A        |
+   +-----------------------------+     +--------+-------------------------+
+
+References
+==========
+
+[1] https://www.trustedfirmware.org/projects/trusted-services/
+
+[2] https://developer.arm.com/documentation/den0077/
+
+[3] https://www.arm.com/architecture/security-features/platform-security
+
+[4] drivers/firmware/arm_ffa/
+
+[5] https://trusted-services.readthedocs.io/en/v1.0.0/developer/service-access-protocols.html#abi
+
+[6] https://git.trustedfirmware.org/TS/trusted-services.git/tree/components/rpc/ts_rpc/caller/linux/ts_rpc_caller_linux.c?h=v1.0.0
+
+[7] https://git.trustedfirmware.org/TS/trusted-services.git/tree/deployments/libts/arm-linux/CMakeLists.txt?h=v1.0.0
-- 
2.34.1


