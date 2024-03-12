Return-Path: <linux-kernel+bounces-100505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B60B8798D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207C91F22000
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D9F7D419;
	Tue, 12 Mar 2024 16:21:41 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B97E11F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260500; cv=none; b=L3yI2BtJTeuv/z16ZeMd+c8e0g+Rxk97f6wu6HqfHY3d8EXfGoVM9K/v00rha0CA2vfWpJKmcGMBwPez0/ExhgcDkMoR6B158glJwJTfkYiRnQd0MtsQtVd1vdHGT3UvVVE/sJe48p5xRu3k7ZYtx9gP9S6rjzrMZz+GPrMmyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260500; c=relaxed/simple;
	bh=50eYY7syBfoEwxVPYan4n/6y+gz5q6VYg8y0DY7CJ24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkFwmwJvhc7bRA9LpDKiuRpnsLg99xHm+Y3OHsusjUBWrIZwfpMULA0Kxrl8mIaqlzPaTkQm0CzA+i7C+I2rzoZ+P0MAu6R7V3RitML1joz1MKEHBzT3hZxr05BNzbsNrND/yHPOyUj51iMl/k2iJ/DdWDa5Wn+A7PkzN9PiJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.molgen.mpg.de (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1C5C461E5FE0A;
	Tue, 12 Mar 2024 17:20:39 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/fred: Add missing *it* to Kconfig description
Date: Tue, 12 Mar 2024 17:19:58 +0100
Message-ID: <20240312161958.102927-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sentence is incomplete, so add the missing *it*.

Fixes: 2cce95918d63 ("x86/fred: Add Kconfig option for FRED (CONFIG_X86_FRED)")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
As a casual user, I wouldn’t know how to figure out, what is required
from my system to support FRED.

 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8f7271d9f1d7..5fc9fdb84f46 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -504,7 +504,7 @@ config X86_FRED
 	  When enabled, try to use Flexible Return and Event Delivery
 	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
 	  ring transitions and exception/interrupt handling if the
-	  system supports.
+	  system supports it.
 
 if X86_32
 config X86_BIGSMP
-- 
2.43.0


