Return-Path: <linux-kernel+bounces-5987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB3819288
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AAB1F25C75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3B53D0CC;
	Tue, 19 Dec 2023 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b="BkpbLRBz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483563D0A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 40763 invoked from network); 19 Dec 2023 22:50:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1703022648; bh=0amMdWjUpen9/zmPVXqRfCdWmAPHzf48RFVu8X0ALS8=;
          h=Subject:To:Cc:From;
          b=BkpbLRBzdxWYPZlvhy5Xg1Dcorh08oN58NfjCtpmu4OJy6HUwiruSi1euwHJGBSnd
           e/iMW7SjYrRhSXlvui23mfIZLd0GIyt7frCwm26WSXKKpbehYwQgih+Wm046ajZi5M
           5fweeBBnKcEoDeW1hYVeM75ERLsRZzO62Ky5lFt4=
Received: from aafb137.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.131.137])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 19 Dec 2023 22:50:48 +0100
Message-ID: <84185211-4ab9-4250-be77-32d73ffe1653@o2.pl>
Date: Tue, 19 Dec 2023 22:50:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] debugfs warnings when resuming from suspend on
 6.7-rc5
Content-Language: en-GB
To: Johannes Berg <johannes@sipsolutions.net>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>,
 linux-wireless@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <da91e776-b192-4e2b-9157-e83a5a2659b1@o2.pl>
 <d8aef271-418c-4644-a3fd-72ee5f1959b7@o2.pl>
 <798e32d457e3ea029fecd423fdb2b1317016e02f.camel@sipsolutions.net>
From: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Autocrypt: addr=mat.jonczyk@o2.pl; keydata=
 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
 TANkZ3QqXNX2
In-Reply-To: <798e32d457e3ea029fecd423fdb2b1317016e02f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 863e2298960fbba9c83e85354c0918ce
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [EZM0]                               

W dniu 19.12.2023 o 13:03, Johannes Berg pisze:
> On Thu, 2023-12-14 at 22:49 +0100, Mateusz Jończyk wrote:
>> W dniu 14.12.2023 o 22:45, Mateusz Jończyk pisze:
>>> Hello,
>>>
>>> Since upgrading to 6.7-rc kernels, I have been getting the following error
>>> message in dmesg
>>> while resuming from suspend:
>>>
>>> [   83.302944] debugfs: Directory 'iwlmvm' with parent 'netdev:wlp2s0' already
>>> present!
>>> [   83.302963] iwlwifi 0000:02:00.0: Failed to create debugfs directory under
>>> netdev:wlp2s0
>>>
>> OK, now I see
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20231211085121.88a950f43e16.Id71181780994649219685887c0fcad33d387cc78@changeid/
>>
>> ("wifi: mac80211: don't re-add debugfs during reconfig")
>>
>> Will see if this fixes the issue.
>>
> Did that work? I think we need
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20231220043149.ddd48c66ec6b.Ia81080d92129ceecf462eceb4966bab80df12060@changeid/
>
> in addition ...
>
> johannes

Unfortunately, these two patches together do not fix the issue.

I have tested them on top of 6.7.0-rc6, together with a patch that adds
a dump_stack() to start_creating() in fs/debugfs/inode.c in case of error.

Hardware:

02:00.0 Network controller [0280]: Intel Corporation Wireless 7265 [8086:095a]
(rev 61)
        Subsystem: Intel Corporation Dual Band Wireless-AC 7265 [8086:5010]

Old AMD AM2+ motherboard (MSI KA780G) from around 2010.

Greetings,

Mateusz

------------------------------

[   55.188244] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[   55.266033] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[   55.269004] iwlwifi 0000:02:00.0: FW already configured (0) - re-configuring
[   55.273661] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   55.273673] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   55.273678] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   55.273682] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   55.273686] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   55.273689] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   55.273693] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   55.274768] debugfs: Directory 'iwlmvm' with parent 'netdev:wlp2s0' already
present!
[   55.274776] CPU: 2 PID: 1327 Comm: NetworkManager Not tainted
6.7.0-rc6unif32-00003-g955274890fe4 #433
[   55.274779] Hardware name: MICRO-STAR INTERNATIONAL CO.,LTD MS-7551/KA780G
(MS-7551), BIOS V16.7 08/05/2010
[   55.274782] Call Trace:
[   55.274784]  <TASK>
[   55.274788]  dump_stack_lvl+0x37/0x50
[   55.274795]  dump_stack+0x10/0x20
[   55.274797]  start_creating+0xfa/0x1a0
[   55.274804]  debugfs_create_dir+0x1b/0x170
[   55.274809]  iwl_mvm_vif_add_debugfs+0x2b/0x220 [iwlmvm]
[   55.274860]  drv_add_interface+0x25f/0x280 [mac80211]
[   55.274979]  ieee80211_do_open+0x4d6/0x710 [mac80211]
[   55.275054]  ? ieee80211_check_concurrent_iface+0x180/0x230 [mac80211]
[   55.275128]  ieee80211_open+0x69/0x90 [mac80211]
[   55.275204]  __dev_open+0xf0/0x1a0
[   55.275209]  __dev_change_flags+0x190/0x200
[   55.275211]  ? skb_queue_tail+0x48/0x60
[   55.275215]  dev_change_flags+0x26/0x70
[   55.275217]  do_setlink+0x867/0x11e0
[   55.275220]  ? rtnl_getlink+0x390/0x420
[   55.275223]  ? __nla_validate_parse+0x5d/0xf90
[   55.275229]  __rtnl_newlink+0x523/0xaa0
[   55.275232]  ? rtnl_newlink+0x30/0x70
[   55.275235]  rtnl_newlink+0x49/0x70
[   55.275237]  rtnetlink_rcv_msg+0x16f/0x440
[   55.275239]  ? _raw_write_unlock_bh+0x1a/0x20
[   55.275243]  ? fib6_walker_unlink+0x49/0x60
[   55.275247]  ? fib6_walk+0x8b/0xa0
[   55.275249]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   55.275252]  netlink_rcv_skb+0x5b/0x110
[   55.275256]  rtnetlink_rcv+0x15/0x20
[   55.275259]  netlink_unicast+0x1b5/0x260
[   55.275262]  netlink_sendmsg+0x250/0x4d0
[   55.275265]  __sock_sendmsg+0xba/0xc0
[   55.275269]  ____sys_sendmsg+0x236/0x340
[   55.275273]  ___sys_sendmsg+0x81/0xc0
[   55.275276]  ? _copy_from_iter+0xb7/0x5d0
[   55.275279]  ? kfree+0x76/0x110
[   55.275283]  ? proc_sys_call_handler+0xb8/0x250
[   55.275287]  ? __fget_light+0xd1/0x130
[   55.275291]  __sys_sendmsg+0x65/0xc0
[   55.275295]  __x64_sys_sendmsg+0x1f/0x30
[   55.275297]  do_syscall_64+0x41/0xf0
[   55.275301]  entry_SYSCALL_64_after_hwframe+0x56/0x5e
[   55.275306] RIP: 0033:0x7f5a8c97418d
[   55.275309] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ca ee ff ff 8b
54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0
ff ff 77 2f 44 89 c7 48 89 44 24 08 e8 fe ee ff ff 48
[   55.275312] RSP: 002b:00007fff2c7b74e0 EFLAGS: 00000293 ORIG_RAX:
000000000000002e
[   55.275315] RAX: ffffffffffffffda RBX: 000055d5ddbf8c00 RCX: 00007f5a8c97418d
[   55.275317] RDX: 0000000000000000 RSI: 00007fff2c7b7530 RDI: 000000000000000c
[   55.275319] RBP: 00007fff2c7b7530 R08: 0000000000000000 R09: 0000000000000000
[   55.275320] R10: 000055d5ddb95010 R11: 0000000000000293 R12: 000055d5ddbf8c00
[   55.275322] R13: 00007fff2c7b76e8 R14: 00007fff2c7b76dc R15: 0000000000000000
[   55.275324]  </TASK>
[   55.275328] iwlwifi 0000:02:00.0: Failed to create debugfs directory under
netdev:wlp2s0
[   58.899942] wlp2s0: 80 MHz not supported, disabling VHT
[   58.906183] wlp2s0: authenticate with 50:c7:bf:2c:a9:32 (local
address=b8:9a:2a:5a:b8:56)
[   58.906808] wlp2s0: send auth to 50:c7:bf:2c:a9:32 (try 1/3)
[   58.908969] wlp2s0: authenticated
[   58.909602] wlp2s0: associate with 50:c7:bf:2c:a9:32 (try 1/3)
[   58.911326] wlp2s0: RX AssocResp from 50:c7:bf:2c:a9:32 (capab=0x431 status=0
aid=5)
[   58.913643] wlp2s0: associated


