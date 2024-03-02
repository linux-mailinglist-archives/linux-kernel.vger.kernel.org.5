Return-Path: <linux-kernel+bounces-89452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE97486F090
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E816BB23F5D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248017752;
	Sat,  2 Mar 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5w0AUPY"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485521C16;
	Sat,  2 Mar 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709387557; cv=none; b=Vibw8B8p/hQy6Z3LaP0tINH0aDFFdvdRoSTBRMjAM+OByeSHNflVou3SXRtpKV1/tre7uyGTjsUAruQGidUVL7ZLsBXWoVdDRXoc9tnO69QzajMfgRYqdJ+c+tUZIQG5BZq33GPzc2hFKsaIgBucqZPdrJTL9HSBRfpx7s1KUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709387557; c=relaxed/simple;
	bh=cJltSKSReU3gn2Kq7YwMuZ8+3CkYBmFr8Krv1X0oUk4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IiXJjVZoCRBKQpthGDaVRb4pR/v3uiGkpC7r+6bomDbMPDco/9Wj/7LUL3DlU28vOsCKeC0I/X2X6IYA3oXohEtTL0OSJQaaC+V5Fj5SO02In2DR5yaRac6aHo8Qg0Jwy1CH4pNpQw2DIxx8kdVknHhu80EcNY5lzk3nFHagQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5w0AUPY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso2496417a12.1;
        Sat, 02 Mar 2024 05:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709387555; x=1709992355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FaKf0wjhl0NBGluN/844FZxvFZTkczu/pWwR8w+hej8=;
        b=G5w0AUPYoIqkB2ckMYNo2GNQjmtfX8VOKEwunhbyS/Ra+F0uPXastZgF3izghQv8Gm
         opSHlxUY4X5gee2kb50iu9px5hUnoqNv42FsyLcVeirvRYRO+9f8hLI2tUWsba2Dt41x
         kyTZ9ubFtjNqjVxrcLE+/JmZEF/Sqao7RMwCftBTGGtvcW8Ndi3lc/aLS7qrD9LYkybh
         GX3AhthlarU19lUuiufH+JTTWTwC+clOPLoRST7J5+0gGT+WE7AqudCdoG9kkwB6hJYc
         pmUgK8Z9B2bcY2khAmzo6Rw3xBIqFayBDGCxs5CiYBdAJwX18qu0P5H3sBisGN4YsPGR
         SJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709387555; x=1709992355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaKf0wjhl0NBGluN/844FZxvFZTkczu/pWwR8w+hej8=;
        b=G3scJpC25F/g+KX0nq/tZyp78CVdIMHqqAKxX+XUJn/tcpFgQreZOFdp+JiyqtyXXl
         qph5mj1AlEzhLngDk+TSaACPT2+EQVaOHxpTBzBm5rkzS/1g68/ddJ8UAhY4GdhSGqsR
         Fz0DM+RDXOPKGVQs2tdoE0slOGqBGJoEaBZ/nVnz1faNfjuhA77glvEW9a7x+87sdpbh
         n7cnw3E9QJFAN7ZB6vKj+y1UzUZrGM2MSN3Pov5XfXqlrZiKwvIGB1ejXDL9ms5CgbeG
         HsN+VUjBzaVkm4saL77wfr0Tof2iirQNhb9WpCabSLspc2QlvP8XqEaXbT8EGVKL5asD
         6PnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo4bCQaH/6a32fOUtSePk3c15GByQAp+AwG4iuhIMPKRpBTiP4Nrl36FqIUd1K/OE+LVbh2bq+h8IVItX+Zcx89weI92J8KneI5jut+eLRrbm315k3faRyyf48a88DM67XuS5h
X-Gm-Message-State: AOJu0YxDuPQK37itZ5o6AKyprkD7hB89cu3cvq7CRs4KJE+N6Z9NHRJ5
	DSaPXsMcVUxwl5KzOb4wA5U91xlMcgj7Yv3QFgKLzPeSs/DUjwNkWqFDGhD0cdVeCX2jH52eZV0
	vZJapT5uclabWlRWAnhuJ5wZc0KA=
X-Google-Smtp-Source: AGHT+IE2i7yR4WD9eCjphtnMOsrRUH11VPAXu+fdEZKVG/Q2C/dbTfsxxwQjOS+2KQ8pBZq8vCehRFHs0ad0DYd0XII=
X-Received: by 2002:a05:6a20:a10f:b0:1a1:4b3e:5ef1 with SMTP id
 q15-20020a056a20a10f00b001a14b3e5ef1mr102246pzk.26.1709387555443; Sat, 02 Mar
 2024 05:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Sat, 2 Mar 2024 21:52:24 +0800
Message-ID: <CABOYnLz_7vJ0gpn0kREWjqeZJW9Hr1TZp3d0ZOfh9qtZO+36CQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_port_change_check (2)
To: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I reproduced this bug and comfired in the latest net tree.
However, I can only make sure syzlang reproducer can work, C
reproducer can=E2=80=99t work.
Anyway, I uploaded it here.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

I use the same configuation with syzbot dashboard.
kernel version: net tree 2a770cdc4382b457ca3d43d03f0f0064f905a0d0
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3Def=
f9f3183d0a20dd
with KASAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.4=
0

root@syzkaller:~/linux_amd64# ./syz-execprog -repeat 0 ../repro.txt
[ 6971.160730][T106447] team0: Device veth0_vlan failed to register rx_hand=
ler
[ 6971.239311][T106447]
[ 6971.240256][T106447] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[ 6971.248075][T106447] WARNING: possible recursive locking detected
[ 6971.252130][T106447] 6.8.0-rc5 #1 Not tainted
[ 6971.253807][T106447] --------------------------------------------
[ 6971.258294][T106447] syz-executor/106447 is trying to acquire lock:
[ 6971.262149][T106447] ffff888023bfad00
(team->team_lock_key#6){+.+.}-{3:3}, at: team_port_change_che0
[ 6971.272457][T106447]
[ 6971.272457][T106447] but task is already holding lock:
[ 6971.275722][T106447] ffff888023bfad00
(team->team_lock_key#6){+.+.}-{3:3}, at: team_add_slave+0xb2/0
[ 6971.277391][T106447]
[ 6971.277391][T106447] other info that might help us debug this:
[ 6971.278742][T106447]  Possible unsafe locking scenario:
[ 6971.278742][T106447]
[ 6971.285531][T106447]        CPU0
[ 6971.286119][T106447]        ----
[ 6971.286685][T106447]   lock(team->team_lock_key#6);
[ 6971.294371][T106447]   lock(team->team_lock_key#6);
[ 6971.295269][T106447]
[ 6971.295269][T106447]  *** DEADLOCK ***
[ 6971.295269][T106447]
[ 6971.336594][T106447]  May be due to missing lock nesting notation
[ 6971.336594][T106447]
[ 6971.337974][T106447] 2 locks held by syz-executor/106447:
[ 6971.338906][T106447]  #0: ffffffff8f7759c8
(rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x890/0x0
[ 6971.345377][T106447]  #1: ffff888023bfad00
(team->team_lock_key#6){+.+.}-{3:3}, at: team_add_slave+0
[ 6971.347076][T106447]
[ 6971.347076][T106447] stack backtrace:
[ 6971.358055][T106447] CPU: 1 PID: 106447 Comm: syz-executor Not
tainted 6.8.0-rc5 #1
[ 6971.375491][T106447] Hardware name: QEMU Standard PC (i440FX +
PIIX, 1996), BIOS 1.16.2-debian-1.164
[ 6971.384912][T106447] Call Trace:
[ 6971.386057][T106447]  <TASK>
[ 6971.387087][T106447]  dump_stack_lvl+0x1f4/0x2f0
[ 6971.391295][T106447]  ? __pfx_dump_stack_lvl+0x10/0x10
[ 6971.400249][T106447]  ? print_deadlock_bug+0x479/0x620
[ 6971.402409][T106447]  ? _find_first_zero_bit+0xe1/0x110
[ 6971.404284][T106447]  validate_chain+0x15c0/0x58e0
[ 6971.407870][T106447]  ? mark_lock+0x9a/0x350
[ 6971.410151][T106447]  ? __pfx_validate_chain+0x10/0x10
[ 6971.447513][T106447]  ? __lock_acquire+0x1345/0x1fd0
[ 6971.452451][T106447]  ? mark_lock+0x9a/0x350
[ 6971.453974][T106447]  ? __lock_acquire+0x1345/0x1fd0
[ 6971.459800][T106447]  ? mark_lock+0x9a/0x350
[ 6971.467966][T106447]  __lock_acquire+0x1345/0x1fd0
[ 6971.469667][T106447]  lock_acquire+0x1e3/0x530
[ 6971.471195][T106447]  ? team_port_change_check+0x56/0x200
[ 6971.485003][T106447]  ? __pfx_lock_acquire+0x10/0x10
[ 6971.486723][T106447]  ? lockdep_hardirqs_on+0x98/0x140
[ 6971.495451][T106447]  ? __pfx___might_resched+0x10/0x10
[ 6971.497220][T106447]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[ 6971.510125][T106447]  ? __pfx_cfg80211_netdev_notifier_call+0x10/0x10
[ 6971.516047][T106447]  ? lock_timer_base+0x257/0x270
[ 6971.517711][T106447]  __mutex_lock+0x136/0xd70
[ 6971.524165][T106447]  ? team_port_change_check+0x56/0x200
[ 6971.531180][T106447]  ? bond_netdev_event+0xe6/0xf80
[ 6971.552437][T106447]  ? __timer_delete_sync+0x165/0x320
[ 6971.555487][T106447]  ? team_port_change_check+0x56/0x200
[ 6971.557402][T106447]  ? __pfx___mutex_lock+0x10/0x10
[ 6971.585609][T106447]  ? __asan_memset+0x23/0x50
[ 6971.588329][T106447]  team_port_change_check+0x56/0x200
[ 6971.613558][T106447]  team_device_event+0x172/0x5e0
[ 6971.615307][T106447]  ? notifier_call_chain+0x171/0x3e0
[ 6971.617138][T106447]  notifier_call_chain+0x19c/0x3e0
[ 6971.640031][T106447]  dev_close_many+0x344/0x4d0
[ 6971.663799][T106447]  ? __pfx_dev_close_many+0x10/0x10
[ 6971.665582][T106447]  vlan_device_event+0x1962/0x1e90
[ 6971.667257][T106447]  ? br_device_event+0x151/0x9d0
[ 6971.668865][T106447]  ? __pfx_phonet_device_notify+0x10/0x10
[ 6971.681103][T106447]  ? __pfx_vlan_device_event+0x10/0x10
[ 6971.689708][T106447]  ? __pfx_br_device_event+0x10/0x10
[ 6971.702341][T106447]  ? raw_notifier+0xa6/0x770
[ 6971.703945][T106447]  ? cgw_notifier+0xdd/0x3c0
[ 6971.717620][T106447]  notifier_call_chain+0x19c/0x3e0
[ 6971.719396][T106447]  dev_close_many+0x344/0x4d0
[ 6971.723625][T106447]  ? __pfx_dev_close_many+0x10/0x10
[ 6971.725406][T106447]  dev_close+0x1c9/0x2d0
[ 6971.736927][T106447]  ? __pfx_dev_close+0x10/0x10
[ 6971.741054][T106447]  ? vlan_vids_del_by_dev+0x2b5/0x310
[ 6971.742923][T106447]  team_add_slave+0x1bf3/0x28b0
[ 6971.747342][T106447]  ? __pfx___dev_notify_flags+0x10/0x10
[ 6971.749385][T106447]  ? __dev_change_flags+0x536/0x710
[ 6971.753249][T106447]  ? __pfx_team_add_slave+0x10/0x10
[ 6971.760179][T106447]  ? __pfx___dev_change_flags+0x10/0x10
[ 6971.762084][T106447]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[ 6971.764253][T106447]  ? mutex_is_locked+0x12/0x50
[ 6971.765935][T106447]  do_setlink+0xed1/0x43f0
[ 6971.769819][T106447]  ? __pfx____ratelimit+0x10/0x10
[ 6971.771521][T106447]  ? __pfx_do_setlink+0x10/0x10
[ 6971.779962][T106447]  ? __nla_validate_parse+0x26b1/0x3140
[ 6971.781727][T106447]  ? __pfx___nla_validate_parse+0x10/0x10
[ 6971.783590][T106447]  ? __pfx_validate_chain+0x10/0x10
[ 6971.785386][T106447]  ? __pfx_lock_acquire+0x10/0x10
[ 6971.787128][T106447]  ? is_bpf_text_address+0x2b/0x2d0
[ 6971.788900][T106447]  ? validate_linkmsg+0x75d/0x960
[ 6971.795596][T106447]  rtnl_setlink+0x431/0x5d0
[ 6971.797190][T106447]  ? mark_lock+0x9a/0x350
[ 6971.798632][T106447]  ? __pfx_rtnl_setlink+0x10/0x10
[ 6971.812898][T106447]  ? __kernel_text_address+0xd/0x40
[ 6971.814699][T106447]  ? rcu_read_unlock+0x9b/0xb0
[ 6971.816298][T106447]  ? __pfx___mutex_lock+0x10/0x10
[ 6971.821333][T106447]  ? __pfx_rtnl_setlink+0x10/0x10
[ 6971.835950][T106447]  rtnetlink_rcv_msg+0x8eb/0x10e0
[ 6971.836899][T106447]  ? rtnetlink_rcv_msg+0x227/0x10e0
[ 6971.837816][T106447]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[ 6971.838758][T106447]  ? lockdep_hardirqs_on_prepare+0x43c/0x780
[ 6971.851410][T106447]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[ 6971.852604][T106447]  ? __local_bh_enable_ip+0x168/0x200
[ 6971.853545][T106447]  ? lockdep_hardirqs_on+0x98/0x140
[ 6971.863452][T106447]  ? __local_bh_enable_ip+0x168/0x200
[ 6971.865250][T106447]  ? __dev_queue_xmit+0x2d1/0x3c70
[ 6971.866978][T106447]  ? __pfx___local_bh_enable_ip+0x10/0x10
[ 6971.880602][T106447]  ? __dev_queue_xmit+0x2d1/0x3c70
[ 6971.882349][T106447]  ? __dev_queue_xmit+0x169b/0x3c70
[ 6971.886063][T106447]  ? __dev_queue_xmit+0x2d1/0x3c70
[ 6971.895914][T106447]  ? ref_tracker_free+0x648/0x7e0
[ 6971.897626][T106447]  netlink_rcv_skb+0x1ee/0x450
[ 6971.899256][T106447]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[ 6971.901113][T106447]  ? __pfx_netlink_rcv_skb+0x10/0x10
[ 6971.908171][T106447]  ? netlink_deliver_tap+0x33/0x1c0
[ 6971.915811][T106447]  netlink_unicast+0x80d/0x9b0
[ 6971.916649][T106447]  ? __pfx_netlink_unicast+0x10/0x10
[ 6971.917598][T106447]  ? __virt_addr_valid+0x4a8/0x580
[ 6971.918508][T106447]  ? __phys_addr_symbol+0x36/0x80
[ 6971.927482][T106447]  ? __check_object_size+0x4e2/0xa60
[ 6971.928527][T106447]  ? bpf_lsm_netlink_send+0xe/0x20
[ 6971.929516][T106447]  netlink_sendmsg+0xa63/0xda0
[ 6971.930477][T106447]  ? __pfx_netlink_sendmsg+0x10/0x10
[ 6971.959582][T106447]  ? aa_sock_msg_perm+0x9e/0x160
[ 6971.960633][T106447]  ? bpf_lsm_socket_sendmsg+0xe/0x20
[ 6971.961575][T106447]  ? security_socket_sendmsg+0x92/0xb0
[ 6971.962546][T106447]  ? __pfx_netlink_sendmsg+0x10/0x10
[ 6971.991813][T106447]  __sock_sendmsg+0x230/0x280
[ 6971.993488][T106447]  sock_write_iter+0x2f9/0x420
[ 6971.995138][T106447]  ? __pfx_sock_write_iter+0x10/0x10
[ 6972.001110][T106447]  ? futex_wait_queue+0x156/0x1e0
[ 6972.004680][T106447]  ? futex_unqueue+0xd8/0x100
[ 6972.015657][T106447]  do_iter_readv_writev+0x489/0x660
[ 6972.018731][T106447]  ? __pfx_do_iter_readv_writev+0x10/0x10
[ 6972.022915][T106447]  ? bpf_lsm_file_permission+0xe/0x20
[ 6972.045752][T106447]  ? security_file_permission+0x8a/0xb0
[ 6972.046896][T106447]  ? rw_verify_area+0x1e7/0x5b0
[ 6972.047864][T106447]  vfs_writev+0x3a8/0xbe0
[ 6972.048632][T106447]  ? __pfx_vfs_writev+0x10/0x10
[ 6972.049483][T106447]  ? __fget_files+0x2d/0x4a0
[ 6972.050281][T106447]  ? __fdget_pos+0x1aa/0x340
[ 6972.064863][T106447]  do_writev+0x1bf/0x360
[ 6972.079653][T106447]  ? __pfx_do_writev+0x10/0x10
[ 6972.080726][T106447]  ? do_syscall_64+0x108/0x240
[ 6972.081604][T106447]  ? do_syscall_64+0xb4/0x240
[ 6972.082447][T106447]  do_syscall_64+0xf9/0x240
[ 6972.100393][T106447]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[ 6972.112331][T106447] RIP: 0033:0x7fca8767dde9
[ 6972.114344][T106447] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1
20 00 00 90 48 89 f8 48 89 f7 48 8
[ 6972.146796][T106447] RSP: 002b:00007fca883de0c8 EFLAGS: 00000246
ORIG_RAX: 0000000000000014
[ 6972.175640][T106447] RAX: ffffffffffffffda RBX: 00007fca877abf80
RCX: 00007fca8767dde9
[ 6972.191791][T106447] RDX: 0000000000000001 RSI: 0000000020000400
RDI: 0000000000000003
[ 6972.209957][T106447] RBP: 00007fca876ca47a R08: 0000000000000000
R09: 0000000000000000
[ 6972.211305][T106447] R10: 0000000000000000 R11: 0000000000000246
R12: 0000000000000000
[ 6972.212594][T106447] R13: 000000000000000b R14: 00007fca877abf80
R15: 00007ffddc5cb5f8
[ 6972.213901][T106447]  </TASK>


Remember to run this repro.txt with the command: syz-execprog -repeat
0 ./repro.txt and wait for about 1minus, the bug triggered very
steady.

=3D* repro.txt =3D*
r0 =3D socket$netlink(0x10, 0x3, 0x0)
writev(r0, &(0x7f0000000400)=3D[{&(0x7f0000000580)=3D"3900000013000b4600bb6=
5e1c3e4ffff0100001038000000560000022500000019000a001000000007fd17e5ffff0800=
04000000000000000a",
0x39}], 0x1)
writev(0xffffffffffffffff,
&(0x7f0000000400)=3D[{&(0x7f0000000580)=3D"3900000013000b4600bb65e1c3e4ffff=
0100000936000000560000022500000019000a001000000007fd17e5ffff080004000000000=
000000a",
0x39}], 0x1)

and see also in
https://gist.github.com/xrivendell7/dea2d84fe5efdb17eedcdb3e17297ffe

I hope it helps.
xingwei Lee

