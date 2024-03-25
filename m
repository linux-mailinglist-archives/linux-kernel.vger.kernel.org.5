Return-Path: <linux-kernel+bounces-117341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472088AA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141691F3D902
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282D2147C6B;
	Mon, 25 Mar 2024 15:12:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D013959B;
	Mon, 25 Mar 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379526; cv=none; b=oeqY2gSvkjCtJHavF9dVMXSvGcfOfJwHpnmMKBhHUQ2ZOQHVAQrLxbLfpLOXZ5owCjqVW8Tmz4lOe2VxDQCdhSkyxfygDW0JWWCLCyU/iZCvv2M4sS/1xcgcbSU3XyFdtM0hZc4oHTRaSK5RY3Kir8Y6ilgnYeDJE11zccr8oFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379526; c=relaxed/simple;
	bh=jnFHsCyhPhyF2e+8XJT8LKEJmIgfkwsTjB+a99F32iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jg/CGFCJnyuC4qHNv09ZRlvJltP0PquOLIrfXID4zAU9xkDdNct9WkaRASeGkXZnuITyavo0gROfXV0G52RAbzxziKTse2O7d3mht+TJ/DW2Fufv857Z24TyvMzt6vVpREb9de/Fuw8Dqfi0dxKWq7UR2QNu5C8JOV625Irn7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 180361576;
	Mon, 25 Mar 2024 08:12:38 -0700 (PDT)
Received: from mango.localdomain (unknown [10.57.15.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B91E3F64C;
	Mon, 25 Mar 2024 08:12:02 -0700 (PDT)
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
	rdunlap@infradead.org,
	krzk@kernel.org,
	gyorgy.szing@arm.com
Subject: [PATCH v4 5/5] MAINTAINERS: tee: tstee: Add entry
Date: Mon, 25 Mar 2024 16:11:05 +0100
Message-Id: <20240325151105.135667-6-balint.dobszay@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325151105.135667-1-balint.dobszay@arm.com>
References: <20240325151105.135667-1-balint.dobszay@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an entry for the newly added Trusted Services TEE driver, with
Sudeep and myself as maintainers.

Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd221a7d4d1c..eaa89feabd25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22470,6 +22470,15 @@ F:	Documentation/ABI/testing/configfs-tsm
 F:	drivers/virt/coco/tsm.c
 F:	include/linux/tsm.h
 
+TRUSTED SERVICES TEE DRIVER
+M:	Balint Dobszay <balint.dobszay@arm.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	trusted-services@lists.trustedfirmware.org
+S:	Maintained
+F:	Documentation/tee/ts-tee.rst
+F:	drivers/tee/tstee/
+
 TTY LAYER AND SERIAL DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
-- 
2.34.1


