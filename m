Return-Path: <linux-kernel+bounces-144878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611BC8A4C17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1AEB2232E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218144597D;
	Mon, 15 Apr 2024 09:58:55 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E0C4D9E5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175134; cv=none; b=Byk+VdyHcg/l6UWH8xdA5Il5stWAdgPWPdFHN1pRbx4sHsDfdjbYmvupUp6CuHKOYGKTqmwVvuEabNPxRipooZDl6+hTgX9iH3mgxqakczsuWUIR9An1yaIFVO/iW6ADgZllo0ZGoqmITsJZv4RJa/K1VMIniV+RX66yyk0N5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175134; c=relaxed/simple;
	bh=YEylZOmwmPaJuUMD5Rwz8peT9YSG5cuo3z8gAuHuq60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1RprzVrqgNY+5nBKFBxO9i268NXFw7z2VIfohPcxKy+wIdtOepNXbQ+WiFgBnJvUe6FQHMDG/M1vjNG076GBxpBfAD6e9QmQlgZb7PvGeUas0qPX/LbGBS3k1gYtQwiYb5tbuGDHFS+u7TErX03BYgwDYLfGKFD8RjZzhzkLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43F9wWlu013407;
	Mon, 15 Apr 2024 18:58:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Mon, 15 Apr 2024 18:58:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43F9wVQk013402
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Apr 2024 18:58:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2ab55fd1-7eb0-488e-93ea-660fa05ee43a@I-love.SAKURA.ne.jp>
Date: Mon, 15 Apr 2024 18:58:30 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000004cf5c205faf1c7f3@google.com>
 <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
 <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk> <ZhztQ9CvDm3UPgE9@FVFF77S0Q05N>
 <c5a3598d-16dd-4aeb-904e-2084fafef9fe@I-love.SAKURA.ne.jp>
 <Zhz3EEsnGSOgnYWA@shell.armlinux.org.uk>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Zhz3EEsnGSOgnYWA@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/15 18:44, Russell King (Oracle) wrote:
> On Mon, Apr 15, 2024 at 06:38:33PM +0900, Tetsuo Handa wrote:
>> On 2024/04/15 18:02, Mark Rutland wrote:
>>>   08626a6056aad824 ("arm: Implement thread_struct whitelist for hardened usercopy")
>>>
>>> That commit says that all accesses are bounce-buffered and bypass the check,
>>> but AFAICT the fpa_set() code hasn't changed since then, so either that was
>>> wrong or the user_regset_copyin() code has changed.
>>
>> Then, can we go with https://lkml.kernel.org/r/0b49d91b-511f-449e-b7c3-93b2ccce6c49@I-love.SAKURA.ne.jp ?
> 
> Have you visited that URL? It doesn't point to an email containing a
> patch, so sorry, I don't know what patch you're referring to.
> 

Containing a link to a diff. ;-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index c421a899fc84..347611ae762f 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -583,10 +583,15 @@ static int fpa_set(struct task_struct *target,
 		   const void *kbuf, const void __user *ubuf)
 {
 	struct thread_info *thread = task_thread_info(target);
+	const unsigned int pos0 = pos;
+	char buf[sizeof(struct user_fp)];
+	int ret;
 
-	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-		&thread->fpstate,
-		0, sizeof(struct user_fp));
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 buf, 0, sizeof(struct user_fp));
+	if (!ret)
+		memcpy(&thread->fpstate, buf, pos - pos0);
+	return ret;
 }
 
 #ifdef CONFIG_VFP


