Return-Path: <linux-kernel+bounces-133667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BAF89A71F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F02282F44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2217555E;
	Fri,  5 Apr 2024 22:25:18 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B758174ECA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355918; cv=none; b=ihsLvx1eSyGMW79WXDvJyAT1C/FjmMylwdtAgx81yznBKuuq1tgwYDVvvmZdidmJFUbiNijuOvEcxXaTpU4tkRXWnq5vo/s9I8Xg0xnX8eyNvcUZAlvJhdHA9uQ/K3eza+K6GXR8ZoBpeDRB/mW9l2ynPpNxU1g6AtiNHiEcsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355918; c=relaxed/simple;
	bh=9hz1CacEtBqBR2tMlHhXU8XFj54Ot+LLOeUrP6Vf7yY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phI2rpEROxcCOQ0qwnqegUlVIhBkB07E3fw4kRMbmEABAaRPrM2RwqP+xZzUX2mu3KP/oibtUdzIDvLCC0u2PEcqh9bTaGIynQweUlULrHiAGmKqS03rwRgDNtIJI54KQQrT2byrZ6Sg10YBB2zLVmj82ucmw5oBZv0qXsGqDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 5ade748f-f39b-11ee-b972-005056bdfda7;
	Sat, 06 Apr 2024 01:25:06 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 6 Apr 2024 01:25:06 +0300
To: syzbot <syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] general protection fault in
 serial8250_tx_chars
Message-ID: <ZhB6Qt48rkC3zMUb@surfacebook.localdomain>
References: <0000000000009e2dd805ffc595a3@google.com>
 <000000000000706b5c0601125945@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000706b5c0601125945@google.com>

Sat, Jul 22, 2023 at 05:16:21AM -0700, syzbot kirjoitti:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    d192f5382581 Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d03ff4a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
> dashboard link: https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e4fe52a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/517e5a5be15c/disk-d192f538.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/59d41b43c30c/vmlinux-d192f538.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/99ed26179ccf/bzImage-d192f538.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com

#syz test git@bitbucket.org:andy-shev/linux.git test-8250-pm

-- 
With Best Regards,
Andy Shevchenko



