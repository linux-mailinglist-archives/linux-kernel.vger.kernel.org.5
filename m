Return-Path: <linux-kernel+bounces-60115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116585000F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE3286C80
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883A3984B;
	Fri,  9 Feb 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyJHb8uw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224028DDE;
	Fri,  9 Feb 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518055; cv=none; b=Cdofu/oEGM4poXUXsFTSpPBeBJRMJA/Uc/CHi++NFnyttwjdWSwDrJcMTdb3kW1q0nbkt1rJ0t0OBdbHkfyQYabhTBLA1PUjD1ywRjHE4Zr3BT+6Ael8nkVQhAM84sWzG94GrVrry5RP1oV04qw322+T1+Gt+/lEaz+11KB1rr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518055; c=relaxed/simple;
	bh=MJMnfC3Jy9W+p+cWdsxJEhZatZy4o1wyduGBxQD91zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPy7T5RcEye05tGAYj9whu78RS8pqmy+bD3yDwnZ3XzbLjXOZMuCfs5+LpbV0Vc2CeaeezLIvVGcrYhAtBW/rTfzZbu+rc8d8SOOqTE5raGqsazTvouODbiG5ziqfPEkbwE9VBJ3UL4vYNWU1y7toMnIFfdixuUyde1g33WXkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyJHb8uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2C9C433F1;
	Fri,  9 Feb 2024 22:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707518054;
	bh=MJMnfC3Jy9W+p+cWdsxJEhZatZy4o1wyduGBxQD91zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyJHb8uw9dF0TAt6IYEqCnyQJ0x9gOHKRj8qsE2xu0cuCx9I8Wm793wwPKAgTRFXw
	 5tPZFdVZPiWGROi9itR87GBjsJ2jOjcgHBp6Fn5d6I7Xd/zLzFYVpq0mFtZ8s2QVbi
	 0fPfgQM0ax00AHvOFTiHiZ2SJmqtfWlC2Pm7I9S8gCsIeFPBC+hPb8y+fFGAmhyObQ
	 ZIkFAZyn4pURT7+paQ7HwVO+pkwur5/njGn0fH6VLg3a021bQThJEdjXoiMX50TlnI
	 pfr+M1XgXwPVDj/y+BE1zdSZlX2yR8yiHavJC3LAoIbaEbyH1Weaqn2Xh8GgcXVPYM
	 f3ZF9VvY1id0Q==
Date: Fri, 9 Feb 2024 23:34:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] WARNING in bdev_file_open_by_dev
Message-ID: <20240209-dreidimensional-bauordnung-91b85c6f50a3@brauner>
References: <0000000000008ca4ed0610f6d017@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000008ca4ed0610f6d017@google.com>

On Fri, Feb 09, 2024 at 10:08:27AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    445a555e0623 Add linux-next specific files for 20240209
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=147c85b8180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
> dashboard link: https://syzkaller.appspot.com/bug?extid=96f61f1ad84e33cee93e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178b1e20180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143db9f4180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9188bb84c998/disk-445a555e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3ce0c98eabb2/vmlinux-445a555e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ab801b1c1d6d/bzImage-445a555e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5075 at block/bdev.c:930 blk_to_file_flags block/bdev.c:930 [inline]
> WARNING: CPU: 1 PID: 5075 at block/bdev.c:930 bdev_file_open_by_dev+0x112/0x270 block/bdev.c:963
> Modules linked in:
> CPU: 1 PID: 5075 Comm: syz-executor215 Not tainted 6.8.0-rc3-next-20240209-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> RIP: 0010:blk_to_file_flags block/bdev.c:930 [inline]

So, the gist is O_* flags are annoying. The longer story is that you can
open any file with int fd = open("bla", O_RDWR | O_WRONLY). That's
mostly nonsensical. But the VFS layer will record file->f_flags |=
O_RDWR | O_WRONLY. And for the block layer this translates to
BLK_OPEN_WRITE_IOCTL. Which is meaningless except for the floppy driver
from When The West Was One. So we need to account for that nonsense when
we translate block flags bag into O_* flags. Fix pushed.

