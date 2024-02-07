Return-Path: <linux-kernel+bounces-56797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6C84CF4D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785F3B27860
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234EC823AF;
	Wed,  7 Feb 2024 16:55:59 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBE446C8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324958; cv=none; b=bq9s6uyZ6G7iKdjlAI3EeCSQjAfB0ctvD8FdOQsqVE5y1CcJLexYir972V521v5Ylc6aTMTkHL83on7SDjPIOeYbkTTRXZ8ceSZQqMxEI9ijG/TzPOGyoL/hw7omZ2e6zJUnDnuyWkNPmXO6QZrLx2iHCsmUbizhTFASvQvN+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324958; c=relaxed/simple;
	bh=G1nyEGKFSLJqeuc/L/imI5qGuNgH+kWkWa6rxnpIlb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iE721rvj2m0/id7yYXcqzUVDSRx0n17D/NVCZ65bWYnNcIc9hQENcH49dB4DVxdW91RdBiv8x1MsEPszh9ShwPF0JM8Iu5adOegc49zjuoIhXJjXLTua0doYxUznkegmt+6NYkO48VQP8sNlQSZT+hQZH9dUx6tIXi8NVV4H42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0ce2222a6so5327381fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324955; x=1707929755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i5FrcnSrEoPjLtJnNgRwolqrsX+z2Vjc1zQhPcrCKo=;
        b=jN1LDxBD/I8rLWnJOE+t83VP8NmzewhW71Xpm+eXLllz5z19L3HCr8P7hzgmSgLe1y
         ghqlSB2ow4SDiy5/m0RFHZO9xe58/qIrOLCDjR6QaY5Ec3Uc4iQlvjqJ9AU28u9Z+cNN
         Wjw4PxldKBl14OrzYNxzuVIPMNJJoyQ7dQEK8oajUnHrh9+BPhKS96FuVTLByIHWsMb9
         8wejHwHfkMWpoIa2M04dR28yi3J5JONsFJPqfAvLWacilyolSDOrfleH/zZjK2Jx+3dE
         ReWIg6FK2pCZQRx3Q6nLBVuj6/8wSNQA2LbWCJIeS55i4tB2o/pwpXoGqi6jgTGg9P0s
         hEew==
X-Forwarded-Encrypted: i=1; AJvYcCUlp+dksgj5c9wV6Ng1fWIG6ecmOXpfluAWJjEegI/ZcLZ6dpn3mTCjhugqZEEyyznjT8/XKyuLjijOJBoxZt99Ji1948GmeEZn2BDL
X-Gm-Message-State: AOJu0YzvGQcwdaYIU810F19nSPoSOYVP8iBnCUEjulkpPrWaK3DfQ3Pv
	07hBJuh41sLK+A1mxXJQr89MkQhx8BkauqBIF1L9xxu0PYHl5eHG94WgzrYvfUR58Q==
X-Google-Smtp-Source: AGHT+IGAgdqexUo+0F4bRyXa5tvbH3YJZzijetuhTAEZkooVNq/c3GcuHvq3Ne63GBlsgbKZMx2Elg==
X-Received: by 2002:a2e:8610:0:b0:2d0:a47c:d544 with SMTP id a16-20020a2e8610000000b002d0a47cd544mr4466321lji.53.1707324954662;
        Wed, 07 Feb 2024 08:55:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDJMRoi7sXdJilXSn2awq0qUfUfEA5pUO3W7NuldfmTbahExz1E57QDT6SZQLGVc08ieUo+YLiEhupK4KFRcp1mhEAA6QBlvK366pQevt0ptK+5JpemaxoFnCcT4Y1oMnfdSr1geZa5+dDbMpqODM9sV00nQ0av3iFW2ZQ2G7fbRZTqeavJ/zehk/fEhxn6vxt6nLSkKaDLATcabFyuQkwxv86AVttzBHfn1blBUtTQbtkI/MX6VY3tLUIcgpyufRCnT32NdsUBX57p/Rmq2qbkdiVVbE7WWwbr5ERymjJUfipHmk=
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id f3-20020a05640214c300b00560556fe9b7sm829107edx.78.2024.02.07.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:55:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: leit@meta.com,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] x86/nmi: Fix "in NMI handler" check
Date: Wed,  7 Feb 2024 08:52:35 -0800
Message-Id: <20240207165237.1048837-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are
ignored") creates a super nice framework to diagnose NMIs.

Every time nmi_exc() is called, it increments a per_cpu counter
(nsp->idt_nmi_seq). At its exit, it also increments the same counter.
Looking at this counter, you can see how many times that function was
called (dividing by 2), and, if the function is still being executed, by
checking the idt_nmi_seq's last bit.

On the check side (nmi_backtrace_stall_check()), that variable is
queried to check if the NMI is still being executed, but, there is a
mistake in the bitwise operation. That code wants to check if the last
bit of the idt_nmi_seq is set or not, but, does the opposite, and check
for all the other bits, which will always be true after the first
exc_nmi() executed successfully.

This appends the misleading string to the dump "(CPU currently in NMI
handler function)"

Fix it by checking the last bit, and if it is set, append the string.

Fixes: 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are ignored")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 17e955ab69fe..6e738ad474dc 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -639,7 +639,7 @@ void nmi_backtrace_stall_check(const struct cpumask *btp)
 			msgp = nmi_check_stall_msg[idx];
 			if (nsp->idt_ignored_snap != READ_ONCE(nsp->idt_ignored) && (idx & 0x1))
 				modp = ", but OK because ignore_nmis was set";
-			if (nmi_seq & ~0x1)
+			if (nmi_seq & 0x1)
 				msghp = " (CPU currently in NMI handler function)";
 			else if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
 				msghp = " (CPU exited one NMI handler function)";
-- 
2.39.3


