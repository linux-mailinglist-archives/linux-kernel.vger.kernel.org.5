Return-Path: <linux-kernel+bounces-70218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02FA8594F6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39F81C21142
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C8D63D0;
	Sun, 18 Feb 2024 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XuRurxUj"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03215673;
	Sun, 18 Feb 2024 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237391; cv=none; b=UXdxUc1Dh1a42jmX41SFjesL8ef1yZQ/ITAFLTICSV20mp9QqBO9haBqUSslYcwv82sw9Ezc16/gwP1YFCXBuj1GooCUAdjrbyzFys2mUlLrptYTTzmSHcRmHjecr6imesqdNCS/Xu7WWgB+rOsidQmPADvT9H1JlE4MBgv/dvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237391; c=relaxed/simple;
	bh=TpNmMKu6WpziuYbuJj9ICNiDX2B0lv7+wTrPai/vhQ8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lUtjKlhnERTtVYj9WxAYoWQ488u3F4GZTmlAEiT+2IqEtrDu4IWUs6vBN9xFdBPeSb9xry6KCazt2+gJARqJv8HWcKPz5GJtN/rszIoOkNcxQ1icwGxURVELqMJG1Lyigo60ISv1Pg/t+YZlekmH5Qa/1MUPJc2BHpk9X02HA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XuRurxUj; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708237377; bh=gi2NcGCCj6PfFOIK2hkne1naRKBj6Q9hH3RQxbNAwco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XuRurxUjTBjoayvJgkymXHdpDJDFeivn+sqlDQt82qXK5nJN0GJEjPBVvk9FZYVSr
	 9XmCYIKdnQExrjviyOKRSgOddSuS6oMVKBhySRxkmVbkIBX2omceElCtuN9oAkms0H
	 5yokKijQ0MIU1lBJwMZTK2yi67ydJlJRzyo/hL1s=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5B5B06A1; Sun, 18 Feb 2024 14:22:53 +0800
X-QQ-mid: xmsmtpt1708237373t67boyyzw
Message-ID: <tencent_8665C99F2EF26EFF0CAF67DF86C592E74606@qq.com>
X-QQ-XMAILINFO: MOpJcPT3Yy24wX/PWmzIjsZ2p88WhJoar8OjDsb57NIXVmM231PGujqEA5GSG4
	 UJ37+zIeeQKSm/mamnZMI2kpbtMTGUww+JG6xsg+3fLRGe4B8WyEH43BsQD1nWf0M2A8oq+OHvS3
	 V2r7TL9m2qNcNPrAE3q+ix3wEgEC9n3fS6+GmSpIpr0ZWm7UxYysTDdYY5ChCsmRM7fyOHjhRPHK
	 bkgJBbR2TutT5iIO97LJqBAB7aAlniThYY0JzO54B8VpQpn+L5E8Bf7h+hIv57FZ4l+c6UDq1sK8
	 hNpYO9PX1X+7jU2Kfz4fdtOPvIum+y7rMA1yZGwJkJnceeOTnt6GTEZo18wy4qGiJinAKobzOw4P
	 lxPvqAUCB2GrD9HdjYzzga3k1/edxGYpF/qSK403qjJhvaeAjNvvQBwJOZla/TSioNPNJrYazSXU
	 0MMG3Q1zFSFgK9SjNp0Nd/LZYX9ZkP9JKyQ7hvFCNGAuZz3SB5Chi/g8AZ15XU33wzrb6i5f+1fQ
	 dtr32vCIF17/JhqAKvQa06fbLE9ELcmFX2pWLJETkncCINy76+BkVTrXoDXEC75e/pTC2GX3ST2c
	 2/6XP8W4bz/cNGzLxu2nkarrBIZ/qFlb8xmFdVwqLyoJtKwkeyud3p3vNCt1ldlz06LLCtmj10QW
	 P+ck/G0CWR4VrDQHXoOKGo+eR1dJyZHb/old3BL8PQ3jNONGtxYnCsQNsGSMm67mfP4qy6GJL2PV
	 sHGby0w2zCcMMf9br913dFW1URF8Bto65UttSJz1wD6LorZg04SFNuj7SL7P+ROKmOVNNjSzhTvH
	 AcP80QaITTUwB1eIFfuK31D8HTZx42rv3oSblBJmCK0CPsfQlJ2eszBDEPFYGwABoTYnPtp/sYrJ
	 7OMLjDcOpU9xXiKem52/6Tap9YhQR5CfeCJ/o1QjBoxUJzbaGvvQUlDdRTB8Y5dhtRGx1ZazY95h
	 L9Hadj9CJ6TxqfcHZRqQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: greg@kroah.com
Cc: eadavis@qq.com,
	isely@pobox.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	pvrusb2-owner@isely.net,
	pvrusb2@isely.net,
	syzbot+ce750e124675d4599449@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH usb] media/pvrusb2: fix uaf in pvr2_context_set_notify
Date: Sun, 18 Feb 2024 14:22:54 +0800
X-OQ-MSGID: <20240218062253.101675-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021716-accent-islamist-6a87@gregkh>
References: <2024021716-accent-islamist-6a87@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 17 Feb 2024 08:41:33 +0100, Greg KH wrote:
> On Fri, Feb 16, 2024 at 03:30:47PM +0800, Edward Adam Davis wrote:
> > [Syzbot reported]
> > BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
> > Read of size 4 at addr ffff888113aeb0d8 by task kworker/1:1/26
> > 
> > CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.8.0-rc1-syzkaller-00046-gf1a27f081c1f #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0xc4/0x620 mm/kasan/report.c:488
> >  kasan_report+0xda/0x110 mm/kasan/report.c:601
> >  pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
> >  pvr2_context_notify drivers/media/usb/pvrusb2/pvrusb2-context.c:95 [inline]
> >  pvr2_context_disconnect+0x94/0xb0 drivers/media/usb/pvrusb2/pvrusb2-context.c:272
> > 
> > Freed by task 906:
> > kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
> > kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> > kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
> > poison_slab_object mm/kasan/common.c:241 [inline]
> > __kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
> > kasan_slab_free include/linux/kasan.h:184 [inline]
> > slab_free_hook mm/slub.c:2121 [inline]
> > slab_free mm/slub.c:4299 [inline]
> > kfree+0x105/0x340 mm/slub.c:4409
> > pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
> > pvr2_context_thread_func+0x69d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
> > 
> > [Analyze]
> > Task A set disconnect_flag = !0, which resulted in Task B's condition being met
> > and releasing mp, leading to this issue.
> > 
> > [Fix]
> > Place the disconnect_flag assignment operation after all code in pvr2_context_disconnect()
> > to avoid this issue.
> > 
> > Reported-and-tested-by: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> What commit id does this fix?
e5be15c63804 ("V4L/DVB (7711): pvrusb2: Fix race on module unload")
> 
> And should it be cc: stable as well?
I checked the stable git tree and it introduced e5be15c63804. I think we need to
cc stable.

thanks,
edward


