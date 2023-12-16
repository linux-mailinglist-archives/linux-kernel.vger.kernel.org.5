Return-Path: <linux-kernel+bounces-1968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18BA815680
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7012826B9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B231125D9;
	Sat, 16 Dec 2023 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4wma9jM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F910A02
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702694932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hn8CgzEBvGrODzIhyk4DxistahM/2O886gCo7SPf5oA=;
	b=S4wma9jMnPuCBA2BSGYB1FGOlOS+xQ9MEuaFIh/mHtX5NQgIdh7WEe7r87Z00oysIJ+Sv/
	q3Qk40h2wTaIUS2L4eZcYQOPjR+76qbPPBc+vo4zL3C2rToHR+mvHMjiuJwzxnAUnyAxe0
	zMBaqwyyIPXirXUqKU4X4kidM+olhFM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 05/50] x86/include/asm/paravirt_types.h: fix missing include
Date: Fri, 15 Dec 2023 21:47:46 -0500
Message-ID: <20231216024834.3510073-6-kent.overstreet@linux.dev>
In-Reply-To: <20231216024834.3510073-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 arch/x86/include/asm/paravirt_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 772d03487520..3cfcd5db083b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -3,6 +3,8 @@
 #define _ASM_X86_PARAVIRT_TYPES_H
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
+
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch_site {
 	u8 *instr;		/* original instructions */
-- 
2.43.0


