Return-Path: <linux-kernel+bounces-92111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F0871B49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882001F222C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9A858218;
	Tue,  5 Mar 2024 10:17:49 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E458127
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633869; cv=none; b=dpriSfL4ATrpToauEdo7dHWalmW2oPRqsP1deXZFJPSXfMeQ/1Fv6nczSoB8g8Qk0J9FlV6QSL5cbKHTQZY3NbKrhiBgwKFaAnfnf/zTz+1XwDfzQf3Sf2FFn6H34AVLF8h6e7x9FV44yz7zJcpjhFJc+bwQnAz4EJINdKNREdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633869; c=relaxed/simple;
	bh=b43DucxfSrZNmb7coHs1dYCGziXHL65Zh3a/pU2ENRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E1oT08GFtOp6wXzeqhFv1LQ7x88POdi3RFHGh8ev8YH36G1AQKPb0sBF13nDp9zj/qfz1m0K1klp2D14L5Xi3T+uEv51a6zo9CcOZehOVh1BExDR1fLvd2jjm6NwkOHvlHOKpxtSvlWQ48AGUQVV4N247zbz4OOXK+NoHnDYvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 425AHZ4Z080546;
	Tue, 5 Mar 2024 19:17:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Tue, 05 Mar 2024 19:17:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 425AHZg5080543
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 5 Mar 2024 19:17:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1fec6a8b-7083-4b08-858a-0793f996ed52@I-love.SAKURA.ne.jp>
Date: Tue, 5 Mar 2024 19:17:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Content-Language: en-US
To: syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000004cf5c205faf1c7f3@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000004cf5c205faf1c7f3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index c421a899fc84..29b28961637c 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -573,8 +573,10 @@ static int fpa_get(struct task_struct *target,
 		   const struct user_regset *regset,
 		   struct membuf to)
 {
-	return membuf_write(&to, &task_thread_info(target)->fpstate,
-				 sizeof(struct user_fp));
+	struct thread_info *thread = task_thread_info(target);
+
+	return membuf_write(&to, &thread->fpstate,
+				 sizeof(thread->fpstate));
 }
 
 static int fpa_set(struct task_struct *target,
@@ -586,7 +588,7 @@ static int fpa_set(struct task_struct *target,
 
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 		&thread->fpstate,
-		0, sizeof(struct user_fp));
+		0, sizeof(thread->fpstate));
 }
 
 #ifdef CONFIG_VFP


