Return-Path: <linux-kernel+bounces-92272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12BC871DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA5428B177
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCB55A11B;
	Tue,  5 Mar 2024 11:27:24 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C25917C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638043; cv=none; b=MejBIdSZUJEHDLxHsTSarY9Yk6ZkahFF75sVLCSYuHUdmF329UlzohSCH+hS/yji+tQDCwhyC2TaxWObwnPVtFK2ybQ9svFIxxn48zBm7kkvyiEupewjCKMK2KRa6bq38JMhgolNrjn89PgrjmvyfIzV0ouwqxfwwsAtCRms7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638043; c=relaxed/simple;
	bh=EZAs+7yDmUmEfCChBu8JZgtnvW4sn/MdtQUYDU61rfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Uj7IzXECHOAGd7u5g5Lr1fFTEE/C1zuSPnLF0OO9De+ucFBdMBoy9YYvQx4G+IUG7WFRxotc1arVd7vo6ZIeodEBp1G4U9kh1/j1PLRpReIuH9FHJVit+bmgVz7NyxnDAvCihXk9Ue+JATkZtyJItytu73Ss3hOveyjwKfuIljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 425BR7U0098036;
	Tue, 5 Mar 2024 20:27:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Tue, 05 Mar 2024 20:27:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 425BR79p098033
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 5 Mar 2024 20:27:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
Date: Tue, 5 Mar 2024 20:27:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Content-Language: en-US
To: Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <0000000000004cf5c205faf1c7f3@google.com>
Cc: syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000004cf5c205faf1c7f3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.

syzbot is reporting kernel memory overwrite attempt at fpa_set().
I guessed that the amount to copy from/to should be sizeof(union fp_state)
than sizeof(struct user_fp), for arch_ptrace(PTRACE_[SG]ETFPREGS) for arm
is using offset == 0 and size == sizeof(union fp_state). But my guess did not
solve the issue ( https://syzkaller.appspot.com/x/patch.diff?x=11e46dbc180000 ).

On 2023/05/05 21:53, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    457391b03803 Linux 6.3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=105b8bb0280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=385e197a58ca4afe
> dashboard link: https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm

#syz set subsystems: arm


