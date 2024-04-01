Return-Path: <linux-kernel+bounces-126965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF59889450D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91128B2198A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929651C2C;
	Mon,  1 Apr 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vwRjbn/t"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F750249
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997733; cv=none; b=MlyoUrOUQpaHLqRBASkElXV7N368UJyt+xVC8nKbJevulQjcM+OLwvWfuAEhQQ0x/j04r0VEuMUwVHlTXDzaGoMIqgZnXfIwm5N1O2YZDRFGmwxOjKPKQgL+IVJLsYmJ1yvCN/PcQfktnczamAZkeb0zmO7oz2XUha5YCKr6A1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997733; c=relaxed/simple;
	bh=4SaZuBFazkBBKNpoTWiW8ROSSgI2jLrGDikbbq1uaH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pg8DMrhexHNgFOHY3FHeOEeyGQA80gjB1iDy+OQ03/QYoyAJIxrExWI8RrXrFQE4oacovDjj/kNaXg1EB1Yb63d5S+CaZBYovgdT/52P4/FOCBmvWznyqDcAu/RiBCktkbOEt5NY9fXhiNpBO46DcjVIEMGAFQztpl33WXojRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vwRjbn/t; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ee098ec-a46f-44fa-8719-049331c4c206@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711997729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwaXuGDQ6zaSeml1dtFpJh0djt9NWcXU/UO1873hCxE=;
	b=vwRjbn/tgF4l7bk4tGLN6N7m/NhuxHgXdkJr2khWniTxEi9ZMgQ3wRvo2Dld1NlGVN98xx
	wtNL+XWC4XC/jCZjfi98ZDMDc16DzKXFdHWdXUdXsOgEawqPsgQ48Pn7GCndRC8Xu5Gyh8
	CmAkFwHJHFPJ1iuCBLnAEhqFTXYds1A=
Date: Mon, 1 Apr 2024 11:55:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
Content-Language: en-GB
To: syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f9ce6d061494e694@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <000000000000f9ce6d061494e694@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/26/24 12:00 PM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    4f55aa85a874 Merge tag 'fbdev-for-6.9-rc1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a8dc6e180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
> dashboard link: https://syzkaller.appspot.com/bug?extid=603bcd9b0bf1d94dbb9b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/991fcbce770a/disk-4f55aa85.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bd716e5d2c3c/vmlinux-4f55aa85.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bf1151dbf5fc/bzImage-4f55aa85.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com
>
> =====================================================
> BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448

Unrelated to the bug itself, with KMSAN is enabled, qemu cannot boot my vm
any more. Anything special I need to do in order to boot a KMSAN kernel?


