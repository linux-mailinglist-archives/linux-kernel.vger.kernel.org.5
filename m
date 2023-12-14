Return-Path: <linux-kernel+bounces-166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9E813CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599741F2271A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEA32C68A;
	Thu, 14 Dec 2023 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b="NVv+CRCF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315092C69D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 26350 invoked from network); 14 Dec 2023 22:45:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1702590335; bh=7EkbqXzJulL0qIo4NQZvIDOhqIMpiQuBQw7hVugbnjk=;
          h=To:Cc:From:Subject;
          b=NVv+CRCFHVMmH1dXhfDJNuwjri0QFZLmwvRpBfVHTKkRDreWhSUiZsVRSalK5f1no
           dVbbRUUt/GHo7FcBQ1z9hdHFPXXImBTjbwLckXmMJynT9K6wyU7hXyNKFL6Tsse6C1
           gEa6ovyVOATFUccbYGEIStU3ysIWzv6ehxXDHow4=
Received: from aaep161.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.119.161])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <miriam.rachel.korenblit@intel.com>; 14 Dec 2023 22:45:35 +0100
Message-ID: <da91e776-b192-4e2b-9157-e83a5a2659b1@o2.pl>
Date: Thu, 14 Dec 2023 22:45:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>,
 linux-wireless@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Subject: [Regression] debugfs warnings when resuming from suspend on 6.7-rc5
Autocrypt: addr=mat.jonczyk@o2.pl; keydata=
 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
 TANkZ3QqXNX2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: ee0a7f3a7e275e6a5657cfb69c59c089
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [UdOE]                               

Hello,

Since upgrading to 6.7-rc kernels, I have been getting the following error
message in dmesg
while resuming from suspend:

[   83.302944] debugfs: Directory 'iwlmvm' with parent 'netdev:wlp2s0' already
present!
[   83.302963] iwlwifi 0000:02:00.0: Failed to create debugfs directory under
netdev:wlp2s0

I have placed a dump_stack() in a respective debugfs function and obtained a
stack trace (see below).

This may be connected with recent commits by Miri and Johannes:

commit c36235acb34fb ("wifi: iwlwifi: mvm: rework debugfs handling")

commit e9dd25550770a ("wifi: iwlwifi: mvm: add a per-link debugfs")

I am ready to test any patches and to investigate further.

Hardware:

02:00.0 Network controller [0280]: Intel Corporation Wireless 7265 [8086:095a]
(rev 61)
        Subsystem: Intel Corporation Dual Band Wireless-AC 7265 [8086:5010]

Old AMD AM2+ motherboard (MSI KA780G) from around 2010.

Greetings,

Mateusz

--------------------------------------------

[   48.624560] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[   48.702116] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[   48.704281] iwlwifi 0000:02:00.0: FW already configured (0) - re-configuring
[   48.706863] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   48.706872] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   48.706876] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   48.706879] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   48.706882] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   48.706884] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   48.706887] ACPI: \: failed to evaluate _DSM
bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[   48.708274] debugfs: Directory 'iwlmvm' with parent 'netdev:wlp2s0' already
present!
[   48.708283] CPU: 1 PID: 1331 Comm: NetworkManager Not tainted
6.7.0-rc5unif32-gf3e457d6f075 #430
[   48.708287] Hardware name: MICRO-STAR INTERNATIONAL CO.,LTD MS-7551/KA780G
(MS-7551), BIOS V16.7 08/05/2010
[   48.708290] Call Trace:
[   48.708293]  <TASK>
[   48.708297]  dump_stack_lvl+0x37/0x50
[   48.708305]  dump_stack+0x10/0x20
[   48.708308]  start_creating+0xfa/0x1a0
[   48.708317]  debugfs_create_dir+0x1b/0x170
[   48.708323]  iwl_mvm_vif_add_debugfs+0x2b/0x220 [iwlmvm]
[   48.708388]  drv_add_interface+0x240/0x270 [mac80211]
[   48.708533]  ieee80211_do_open+0x4d6/0x710 [mac80211]
[   48.708633]  ? ieee80211_check_concurrent_iface+0x180/0x230 [mac80211]
[   48.708732]  ieee80211_open+0x69/0x90 [mac80211]
[   48.708832]  __dev_open+0xf0/0x1a0
[   48.708839]  __dev_change_flags+0x190/0x200
[   48.708842]  ? skb_queue_tail+0x48/0x60
[   48.708847]  dev_change_flags+0x26/0x70
[   48.708850]  do_setlink+0x867/0x11e0
[   48.708854]  ? rtnl_getlink+0x390/0x420
[   48.708857]  ? __nla_validate_parse+0x5d/0xf90
[   48.708865]  __rtnl_newlink+0x523/0xaa0
[   48.708869]  ? rtnl_newlink+0x30/0x70
[   48.708873]  rtnl_newlink+0x49/0x70
[   48.708876]  rtnetlink_rcv_msg+0x16f/0x440
[   48.708879]  ? _raw_write_unlock_bh+0x1a/0x20
[   48.708884]  ? fib6_walker_unlink+0x49/0x60
[   48.708889]  ? fib6_walk+0x8b/0xa0
[   48.708893]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   48.708896]  netlink_rcv_skb+0x5b/0x110
[   48.708901]  rtnetlink_rcv+0x15/0x20
[   48.708906]  netlink_unicast+0x1b5/0x260
[   48.708909]  netlink_sendmsg+0x250/0x4d0
[   48.708913]  __sock_sendmsg+0xba/0xc0
[   48.708918]  ____sys_sendmsg+0x236/0x340
[   48.708923]  ___sys_sendmsg+0x81/0xc0
[   48.708927]  ? _copy_from_iter+0xb7/0x5d0
[   48.708932]  ? kfree+0x76/0x110
[   48.708936]  ? proc_sys_call_handler+0xb8/0x250
[   48.708942]  ? __fget_light+0xd1/0x130
[   48.708947]  __sys_sendmsg+0x65/0xc0
[   48.708951]  __x64_sys_sendmsg+0x1f/0x30
[   48.708954]  do_syscall_64+0x41/0xf0
[   48.708959]  entry_SYSCALL_64_after_hwframe+0x56/0x5e
[   48.708965] RIP: 0033:0x7feceb7cb18d
[   48.708970] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ca ee ff ff 8b
54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0
ff ff 77 2f 44 89 c7 48 89 44 24 08 e8 fe ee ff ff 48
[   48.708974] RSP: 002b:00007ffecdd37c60 EFLAGS: 00000293 ORIG_RAX:
000000000000002e
[   48.708978] RAX: ffffffffffffffda RBX: 00005638fb6c1c00 RCX: 00007feceb7cb18d
[   48.708981] RDX: 0000000000000000 RSI: 00007ffecdd37cb0 RDI: 000000000000000c
[   48.708983] RBP: 00007ffecdd37cb0 R08: 0000000000000000 R09: 0000000000000000
[   48.708985] R10: 0000000000000001 R11: 0000000000000293 R12: 00005638fb6c1c00
[   48.708987] R13: 00007ffecdd37e68 R14: 00007ffecdd37e5c R15: 0000000000000000
[   48.708991]  </TASK>
[   48.709032] iwlwifi 0000:02:00.0: Failed to create debugfs directory under
netdev:wlp2s0
[   52.403523] wlp2s0: authenticate with 50:c7:bf:2c:a9:31 (local
address=b8:9a:2a:5a:b8:56)
[   52.404492] wlp2s0: send auth to 50:c7:bf:2c:a9:31 (try 1/3)
[   52.406824] wlp2s0: authenticated
[   52.408269] wlp2s0: associate with 50:c7:bf:2c:a9:31 (try 1/3)
[   52.410136] wlp2s0: RX AssocResp from 50:c7:bf:2c:a9:31 (capab=0x11 status=0
aid=3)
[   52.412299] wlp2s0: associated


