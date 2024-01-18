Return-Path: <linux-kernel+bounces-30189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF7A831B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BBB1F25538
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2CE25772;
	Thu, 18 Jan 2024 14:19:06 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311525614
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587545; cv=none; b=GPDWitTa7zRX0Q1JGu2zXGfNIXaPmyaa5oiIxM8VUI9XhIl59OmqW2S2PIW4FykowcY41rEXGhYlbY1sTF2mM/VGzL0WQZ9Qb6fWFodwsc9NDG0/6lGkJe524j7LB3/rQkeJXQKs087MD4nCq4A7DeES6nEdKKTkX94JJwO3LYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587545; c=relaxed/simple;
	bh=T4ORLdKNOVj3bjZZf6OYBnNg7tHoYxxzKwXKSXCqwaA=;
	h=Received:Received:X-Virus-Status:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:Cc:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=khkC+S82MLsc3mvw5n1b0GrDHIru6OohTXaO+0KW4CjUZ2J1fDAv5Nbin9AFcIbiEohEKymxFOyHZFKl+Zbt2GxcFIHb3y28L2jIGHRySvxlDz2lcngxrAWRNxFjmlrlaeAED9NzdT27U66OWhunW8mj2kULAT/dgiH1Gvfku/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40IEI4Vt090994;
	Thu, 18 Jan 2024 23:18:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Thu, 18 Jan 2024 23:18:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40IEI33U090989
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 18 Jan 2024 23:18:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
Date: Thu, 18 Jan 2024 23:18:03 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [dri?] BUG: scheduling while atomic in
 drm_atomic_helper_wait_for_flip_done
Content-Language: en-US
To: syzbot <syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        linux-serial <linux-serial@vger.kernel.org>
References: <00000000000039f237060f354ef7@google.com>
Cc: linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000039f237060f354ef7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz set subsystems: serial

include/linux/tty_ldisc.h says "struct tty_ldisc_ops"->write is allowed to sleep.

include/linux/tty_driver.h says "struct tty_operations"->write is not allowed to sleep.

drivers/tty/vt/vt.c implements do_con_write() from con_write() sleeping, violating what
include/linux/tty_driver.h says. But how to fix?

-	if (in_interrupt())
+	if (in_interrupt() || in_atomic())
 		return count;

in do_con_write() and con_flush_chars() ? But include/linux/preempt.h says
in_atomic() cannot know about held spinlocks in non-preemptible kernels.

Is there a way to detect spin_lock_irqsave(&gsm->tx_lock, flags) from gsmld_write() ?
Something like whether irq is disabled?

On 2024/01/18 18:51, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1b1934dbbdcf Merge tag 'docs-6.8-2' of git://git.lwn.net/l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1029adbde80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=68ea41b98043e6e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=06fa1063cca8163ea541
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64


