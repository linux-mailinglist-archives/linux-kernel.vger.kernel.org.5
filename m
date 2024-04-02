Return-Path: <linux-kernel+bounces-127459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BC894BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6AA91F22CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58E136AEF;
	Tue,  2 Apr 2024 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OXUppOut"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C472D047;
	Tue,  2 Apr 2024 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040575; cv=none; b=SrH0cdX+ug8OkNsK7S60QxrnurSGkv/KpELnQ/AO7a1md0t0zzQVeldS/BHj1ymZFi5JbaKuNHDTlMSM1W+WJLF+6CLV49bbJetparEerMVDZPAHHaBOwBWeBMhqRS2oJQaO3jByg4pimdyCB7vruF9KCZvFdjUqeXWQH6etObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040575; c=relaxed/simple;
	bh=FX1mhRPjrQcVo6/MwRTXpGujzWFlQHWn2tP9zw5Zpo0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XygfKTAKkNjrXVYYm2qEcZ5gD0dC8SooFXzyW4GpDbxydOkqJkbAHmd5U0RzkRgg0DZO2Zhp2nB0DGIBEVH45QKFgY5nvVdBvp0XA4/f6EkZrFfdmjzhBzLOoVV5o3BjFpTCP8teK4Wul4iN64O+6eOXk3hWUpNX2KF99rcJJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OXUppOut; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712040567; bh=oupitrM2yejVC+b6Kh6tNCCOKCcRagrln1bhHAMnUp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OXUppOutvWLamMNAIjpkBJliAyFjht/RG7QLudA9h/id5lDLo6sOf9SG6LbaWsaiw
	 SkLw6SlPxjAWs/64IjQ9uJhHLt810MIh+D+CLY5Sdw7u4bid1IHWeJ2OaWxklW2vO7
	 eAvcNXP7zW+pyvgkBffKaklecquom3nHkcKh2BG4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id BD7246B6; Tue, 02 Apr 2024 14:47:23 +0800
X-QQ-mid: xmsmtpt1712040443t0ex17cyl
Message-ID: <tencent_44291B84257ABAB7BB7B33C49E0E1BC74B08@qq.com>
X-QQ-XMAILINFO: NPwBlS1YPCihBRUi30VSRvMAtQcxCWcrLxmJqxAl64AOrThjPBv8h6ySZkVfVD
	 kluoIhQoxqL2lpQCok1hZGHQlsv/DT354resDxeYv7eJovDlLjojYVbnLBGpKcWbclgxitGx7WUK
	 ExF8mUg56zzntPsJKTCbzdzfJx+zRPg3LNJts3tvunRz8Ij8ZFlNgczNIoONLPKe45Yusuf/s+8z
	 ofxslIuSjNh0gqDUatcIvzhJD4LmJ3Su/k8ZuDvrWmaBMDuB9Qeq8YAWs3dcsHnaVzc9qebQh1WA
	 /A7e7+hGraUDKhErEzGowcGr8phS09b2BoZIPnWwTd7yk1lFjBbgC7Mem4KxUxEhyE4XBXD/Pt72
	 6paaaox8xoUb4Htyu/D5JDBfNERSnj62hJVjM3gtoqAlVFVGH0WThIDVd0qrlkwdFVNs6SuYUejl
	 6EqJrYFpxGQ/BFDOBeKs5p2BzVVTCoKvWzXdKf4T9sfE3frVhcRskTidtFiyYZ/D4lAHNEOE2VwN
	 LFfWCiJ4qgu/M6rwA2L+VUrWLTOejKEuMMTepL4T1bOl/WnDQZ3x5nJSlle0tkI4ToMuh8EaQIm2
	 62Xn2kJXNLeZ86B0ye9qSwvp5pj09Z5VO3egp+TP5NZK8rKqYV2TL7ryy9xEEhEHg6CUDdl3w/zW
	 Pfp1K4sN3KEV8fk6aip63Iz6dTRj7UfbR+UgB94k5DGMs7mqPqu/PtD3SxdJmb+nihV/X566Icjj
	 LW670M6+On9B7EDelcbeUQRPRrHmr27EcsY9ZaaRz5CaR2SHQacaNFFF1oBDBFuWr4wV0UjE5K5z
	 T+q2YnIgBVYVqo6eSXTvr1m4SzY0zsqs6J7IAA4p28aEETJg9dLlQcd0nEUzbpPVZEsExmuwx3Xh
	 V2/afV9xGfKk4V6TZ9kWW4lNgUJsYAgVqeJp8zcu57zPCWFA2NEObW9Fb1G5AR6fnNYKCGlD38jn
	 amuYDmn10=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: [PATCH] ALSA: line6: fix uninit-value in line6_pod_process_message
Date: Tue,  2 Apr 2024 14:47:24 +0800
X-OQ-MSGID: <20240402064723.2153044-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000084b18706150bcca5@google.com>
References: <00000000000084b18706150bcca5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
BUG: KMSAN: uninit-value in line6_pod_process_message+0x72f/0x7b0 sound/usb/line6/pod.c:201
 line6_pod_process_message+0x72f/0x7b0 sound/usb/line6/pod.c:201
 line6_data_received+0x5db/0x7e0 sound/usb/line6/driver.c:317
 __usb_hcd_giveback_urb+0x508/0x770 drivers/usb/core/hcd.c:1648
 usb_hcd_giveback_urb+0x157/0x720 drivers/usb/core/hcd.c:1732
 dummy_timer+0xd93/0x6b10 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x49/0x580 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1844 [inline]
 __run_timers kernel/time/timer.c:2418 [inline]
 __run_timer_base+0x84e/0xe90 kernel/time/timer.c:2429
 run_timer_base kernel/time/timer.c:2438 [inline]
 run_timer_softirq+0x3a/0x70 kernel/time/timer.c:2448
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
 arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
 acpi_safe_halt+0x25/0x30 drivers/acpi/processor_idle.c:112
 acpi_idle_do_entry+0x22/0x40 drivers/acpi/processor_idle.c:573
 acpi_idle_enter+0xa1/0xc0 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0xcb/0x250 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x7f/0xf0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x551/0x750 kernel/sched/idle.c:332
 cpu_startup_entry+0x65/0x80 kernel/sched/idle.c:430
 rest_init+0x1e8/0x260 init/main.c:732
 start_kernel+0x927/0xa70 init/main.c:1074
 x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x98/0xa0 arch/x86/kernel/head64.c:488
 common_startup_64+0x12c/0x137

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmalloc_trace+0x578/0xba0 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 line6_init_cap_control+0x4f1/0x770 sound/usb/line6/driver.c:700
 line6_probe+0xeae/0x1120 sound/usb/line6/driver.c:797
 pod_probe+0x79/0x90 sound/usb/line6/pod.c:522
 usb_probe_interface+0xd6f/0x1350 drivers/usb/core/driver.c:399
 really_probe+0x4db/0xd90 drivers/base/dd.c:656
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:798
 driver_probe_device+0x72/0x890 drivers/base/dd.c:828
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:956
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1028
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1077
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x1475/0x1c90 drivers/base/core.c:3705
 usb_set_configuration+0x31c9/0x38d0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:254
 usb_probe_device+0x3a7/0x690 drivers/usb/core/driver.c:294
 really_probe+0x4db/0xd90 drivers/base/dd.c:656
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:798
 driver_probe_device+0x72/0x890 drivers/base/dd.c:828
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:956
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1028
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1077
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x1475/0x1c90 drivers/base/core.c:3705
 usb_new_device+0x15ff/0x2470 drivers/usb/core/hub.c:2643
 hub_port_connect drivers/usb/core/hub.c:5512 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
 port_event drivers/usb/core/hub.c:5812 [inline]
 hub_event+0x4ff8/0x72d0 drivers/usb/core/hub.c:5894
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
[Fix]
Let's clear all the content of the buffer message during alloc.

Reported-and-tested-by: syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 sound/usb/line6/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b67617b68e50..8fd9d42aa8e2 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -697,7 +697,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 		return -ENOMEM;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
+		line6->buffer_message = kzalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
 		if (!line6->buffer_message)
 			return -ENOMEM;
 
-- 
2.43.0


