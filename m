Return-Path: <linux-kernel+bounces-129289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136B896869
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F50CB298C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5071272BA;
	Wed,  3 Apr 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMtmPVFm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB686AC2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131764; cv=none; b=AHsT+HaMbToD/1PdCajXF0S+XmXjzgj0RN6QSDW/4W8vn6THmFwgjyPQhzKxqV/LaW1j90ZQ/KBHJN3XAioxgsoawtiknsOBjGWP1ijlD4UVBj85+Ljb9EaQYUrSHHn96IecQukT++lNjoQSocx+u5SP22OLL1QnPlLHWm//7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131764; c=relaxed/simple;
	bh=QeEJdvI21yAX1pv6uUc4i2mUyj5I2+1g2fdUe9NpeWc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YF/nV49qTWmUhcBS4VvJ0dYgq19O1SNSOdYalDGDRekRrrS7Cpjm4i1o5QNPZv91M+Dkbyy+LdqwvDkLcwjVmQlsCg/AwT6dWsppLgFMvd4J9krE5VLwKboTs4HQlEMAqjWKKS15l4J36Wf+PlT2xc6u/u3B5n3fRN8f2lxFY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMtmPVFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601FCC433F1;
	Wed,  3 Apr 2024 08:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131763;
	bh=QeEJdvI21yAX1pv6uUc4i2mUyj5I2+1g2fdUe9NpeWc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eMtmPVFmPizrqsBphoKu1/BzEzjGFayQ7UB8noWwp1J76h7pCtjvjsUc4u68NlEII
	 fFxdk9JIHpnJ9a+MBe8gitYe1aV4pXYgUPzat0Vi9V7GbEGP1W+4y6JQcw13YeymzV
	 gp4KwHKcAp2UZR8R4Cw3QqA7HCWnDfhPuutixGkurExu1HdUXGcDUyBoN5wRLc74MW
	 iw6vHOAW1lA8qbWMsbSmXatDN1ZsI4B1yhIMmZ2VFxlUEFE8/YMKn3kczPMxVets5M
	 ZJv+8QYKN2cPYciQhSdtqx199BYJ3D2NWTnIFbu6ltNx8E7nruUNjBy7iTkvb300/u
	 0AhtPE0vGDaYQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 12/34] apm-emulation: hide an unused variable
Date: Wed,  3 Apr 2024 10:06:30 +0200
Message-Id: <20240403080702.3509288-13-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver_version variable is only used inside of an #ifdef block, which
leads to a W=1 warning:

drivers/char/apm-emulation.c:144:19: error: 'driver_version' defined but not used [-Werror=unused-const-variable=]

Move this into the function using it.

Fixes: 7726942fb15e ("[APM] Add shared version of APM emulation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/apm-emulation.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/apm-emulation.c b/drivers/char/apm-emulation.c
index e795390b070f..53ce352f7197 100644
--- a/drivers/char/apm-emulation.c
+++ b/drivers/char/apm-emulation.c
@@ -141,9 +141,6 @@ static struct apm_queue kapmd_queue;
 
 static DEFINE_MUTEX(state_lock);
 
-static const char driver_version[] = "1.13";	/* no spaces */
-
-
 
 /*
  * Compatibility cruft until the IPAQ people move over to the new
@@ -435,6 +432,8 @@ static struct miscdevice apm_device = {
  */
 static int proc_apm_show(struct seq_file *m, void *v)
 {
+	static const char driver_version[] = "1.13";	/* no spaces */
+
 	struct apm_power_info info;
 	char *units;
 
-- 
2.39.2


