Return-Path: <linux-kernel+bounces-60118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D29850018
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B80B2EA0A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806512E3E4;
	Fri,  9 Feb 2024 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmZzmBNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49F2653;
	Fri,  9 Feb 2024 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518139; cv=none; b=dUE1ZO+K0NCRvg2TZZ4hFcnwzviyG0lTmxNdwk/8ZjueX9ADLsnBr6fJh+EI7L3+nXzHHE/t0hNc7ImOR6tHpXrHopXvQ1kNImbYYEXy3uxt/8HRkI86fkIJcb9Wp7C8FnhonDenpGCxJEz3ENVlEOvfFPnAk2xwYR76Z0lP8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518139; c=relaxed/simple;
	bh=kjXXh5krBOhmQQsrRlfzqrDsav15pBXjP6hD7WNn+MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxl/9ZQ/CYj4t3NKqW2JB1ZYZa/JJhMr6gb56X1bjS4zlZSewE3qCEH1wUCX2D0T9dpNHwF2a3zUswYvCtzXGXly0IvqhumZkUVi0ORudmARXTquPd/hZGi3ZrAfsnlW3MyI0fnjP7wGgVclzqURFjY/CuGo+JmwALpMp4EDK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmZzmBNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAD9C433C7;
	Fri,  9 Feb 2024 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707518139;
	bh=kjXXh5krBOhmQQsrRlfzqrDsav15pBXjP6hD7WNn+MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmZzmBNQ9qlholdteTgQ30IWifj3uTC1Fcv0cahrraEfrnV1Icc7PwTKspQRVkVvk
	 roM6kvzR/YUpvDetzeiZ+Mxb/z01PS8VljBdWqt3h/a6O+TCaX0TG+KihdluAmObko
	 luK50TmHl/eD3D9vMtTMCiI8mqs2cYVSS5Lma7Gkxosh/P0HRCHwLv5FvE7ByMknes
	 4jdAU7hxC+N1xzXdyDUfAublB8i8B7cErqN9Cx0DhBZi26uKbioqUM4sYnu2foOK4t
	 5rT0y6MNIfArwHkVxmwTLTrOKep070CKMggYdBaBVEcYjb2WXaOweX102vOzU69Eno
	 W5FuUiWLi5jiA==
Date: Fri, 9 Feb 2024 23:35:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] WARNING in bdev_file_open_by_dev
Message-ID: <20240209-notdienst-watscheln-4ca4930cb089@brauner>
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

#syz test: git@gitlab.com:brauner/linux.git vfs.super

