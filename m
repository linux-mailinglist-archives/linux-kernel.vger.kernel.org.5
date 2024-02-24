Return-Path: <linux-kernel+bounces-79478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5FA8622C4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7ACB232CC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84637171D4;
	Sat, 24 Feb 2024 05:53:27 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D372905
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754007; cv=none; b=OY5DPd8hWVLBkn2e8cxWY6kzo75RNPhNlbHwIoBQoIsgRfREQJhQZ/nC5yQyj1KM/WA3z3BmRHuDQa7JffwImkLHBhRkya7rT65qfJIxiJ3P9W9PzuZoFe7WOcQE1mnA9jau11/zBxvQFixeDiUu0BZEz2s3nMdRQAceZj1F/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754007; c=relaxed/simple;
	bh=bsoRPzLUJOa1E29oA0qi9ZMadxedF0bqYf74YK12X0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZgD2jq8liHU0yhGTE8rwrFeHDcvp6jQc0Dy8+IPkRn1T8D8aSvf0NRJUI+XFpvUJM/Zppa+H2ILAeiER0S/ReJP/OfaaGrYJu0X7puRkVwtwlqMowODbDe14aFj1oXbSrX+44OhfjLdxMWmsaNaCuLt+jX8/v9dElp5H6yFtzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 41O5rHQC080238;
	Sat, 24 Feb 2024 14:53:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sat, 24 Feb 2024 14:53:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 41O5rHJP080228
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 24 Feb 2024 14:53:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <be634ab4-58aa-40e4-8ab0-0e2685537525@I-love.SAKURA.ne.jp>
Date: Sat, 24 Feb 2024 14:53:16 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add
 (4)
Content-Language: en-US
To: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000fd588e060de27ef4@google.com>
Cc: linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..f13bba3a9dab 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -58,7 +58,16 @@ static inline void clear_page(void *page)
 			   : "cc", "memory", "rax", "rcx");
 }
 
+#ifdef CONFIG_KMSAN
+/* Use of non-instrumented assembly version confuses KMSAN. */
+void *memcpy(void *to, const void *from, __kernel_size_t len);
+static inline void copy_page(void *to, void *from)
+{
+	memcpy(to, from, PAGE_SIZE);
+}
+#else
 void copy_page(void *to, void *from);
+#endif
 
 #ifdef CONFIG_X86_5LEVEL
 /*
-- 
2.34.1


