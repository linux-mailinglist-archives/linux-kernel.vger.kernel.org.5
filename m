Return-Path: <linux-kernel+bounces-109732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4757F8854FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AD4B214C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7FC58AC4;
	Thu, 21 Mar 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NyxM9DY+"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEEC153;
	Thu, 21 Mar 2024 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711006606; cv=none; b=c4Cbrr+wqI3YAbfbveQ+14w3s5kAcUs/N4HnM7a1KPclWmvZaLwoBu+c7+DJUbi3IgvDMdLdntgpP//7Opf8NtL4Dyic80J5btGVNToQ2MzPuNYt976RyhFoSoJ3CYm1Mp4N2xuW+r0BHqGuJVszlpFYV1yutfToQTwA5ELrFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711006606; c=relaxed/simple;
	bh=4wKdMcmeIxxwMjUiVEOwaobzxEYi+ENpyHnS61pvJRE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=P8HO25hxlSqj2Bmz/ZixgdOGabPmaHJgp7gbt8SV0o9DwrSiMSVC7tu1mPYAmJ4UWfIlQTZGAnmXW5sqgSRH494nBxwe61R0QN3YRzSEGLEpPuKsJ6cbpvtyG2Pmb3/ynig//jHfGmqYewAdJrLGtaqTyB0azQNWpup0bPxySGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NyxM9DY+; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711006296; bh=8u8GJnikIVLt9o3AKQrprbA51XrwMm6d9t0CFH0aJ0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NyxM9DY+sJxECP+WTwq+O6+F8ZJuOm0c7+ELmnSsMTSeAZXM37qZQFdBDOGwxPzg1
	 E1CpnCnXDDw+nJjRdiy8VJcH+IqFrDIjEfJCk23jDblqHQJjDDRVVvMh9ZsVSddwYA
	 pDBXH8VE7+XdOvnWbgjmysY0Y/Pc+oFti74jYrtg=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 7E094A93; Thu, 21 Mar 2024 15:31:32 +0800
X-QQ-mid: xmsmtpt1711006292tid191y1d
Message-ID: <tencent_7225DC0D859205DD8BDDAE191CCFBF0D8907@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No0+H8hKNnPjt0TZNFWjDY8EcRXtW68WG0QS11aImSoO+tEj7xyB
	 pxhW3UzKbTu9PmbiRlY9xedW5tDLwSCN+4ZNRsEfFXa+oii4HRiEKV6/y4kUWbFQvP9uXAG+zgt8
	 X0/rFAt2GaD2IKJ/P7SifY8U2ZWU/gFGblLfGZbwWWbV1dDzOTpG6Cq0cB6rYgeHTveZIYyNddpd
	 0vl5APARmC0HpogWNFreP/05ExkTw1u8AX7k+mYSL8w+apYvfaeoz8X83gtDQT4qzLPD/ByM7OHB
	 nUmmuGELQrA+3+RlNjEaV7/CZ7eowFJoobDkPeIeROPIHWUovcb8SqPH3r7dQlRl++oCQWgk13R+
	 gdYjP/ODaVeAfnZHCdpaOUgZ2gVKnT0wva7F84pIEm1kCQ8EWRRrFpeuziWyMQ/iJruwDd67f285
	 kvzb35+WA4d4TLJZWAwROtunnmjM2+03xnI7W66jJQp0c2lYVKDOiyF3n6yjdUszcpvomu74zuam
	 KpHkPglwkOQTYIPOWbabuE2nU1RfTUIwQ6Hxjxhzet/RT+f7RCwA7JZyS71kzpezx1wJOb1JTbpj
	 KYbFQT3+BKlnft3gVYvGwsSzNMx973Pquu4ofv83RNUm8mELYNtCiUfJ9+lOBlDIKGwkXIl0msbV
	 GE2UH8Pwp1KKgkmqLuX2RdvNMkV6mij69ecvXCMLmtuqbV4vKOt63U0bdmts0HRetigpZ4SPgoG6
	 GRP5Q9upeuCiZK2UnaGpi3m74UCOMu78Msk4md6dON0y+ztybHLI+Lv6xRbPBgp6EUi0CrRHH+2p
	 +KrUNKTQQfAu6VybRFpgLDh/XI4vcG4Sd4BeymsATRxGiQ/2TTZuvo/QmJGCrOMn4r2cYtjT5QTQ
	 xG/fCXo7cUTPKEL8je4vS4IJGe8gEQZskkRXP1dmpnnQEtaifcpv3gCycgpUPF5kCaoK7X9OEzZR
	 mzwhzY5b4=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	toke@toke.dk
Subject: [PATCH usb] wifi: ath9k: fix oob in htc_issue_send
Date: Thu, 21 Mar 2024 15:31:33 +0800
X-OQ-MSGID: <20240321073132.2181617-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004e41110614187d35@google.com>
References: <0000000000004e41110614187d35@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syzbot reported]
usb 1-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
ath9k_htc 1-1:1.0: ath9k_htc: HTC initialized with 33 credits
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:51
index 255 is out of range for type 'htc_endpoint [22]'
CPU: 1 PID: 2494 Comm: kworker/1:2 Not tainted 6.8.0-rc6-syzkaller-00190-ga788e53c05ae #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:347
 htc_issue_send.constprop.0+0x209/0x230 drivers/net/wireless/ath/ath9k/htc_hst.c:26
 ath9k_wmi_cmd_issue drivers/net/wireless/ath/ath9k/wmi.c:305 [inline]
 ath9k_wmi_cmd+0x424/0x630 drivers/net/wireless/ath/ath9k/wmi.c:342
 ath9k_regread+0xdb/0x160 drivers/net/wireless/ath/ath9k/htc_drv_init.c:242
 ath9k_hw_read_revisions drivers/net/wireless/ath/ath9k/hw.c:287 [inline]
 __ath9k_hw_init drivers/net/wireless/ath/ath9k/hw.c:572 [inline]
 ath9k_hw_init+0xf02/0x2b30 drivers/net/wireless/ath/ath9k/hw.c:700
 ath9k_init_priv drivers/net/wireless/ath/ath9k/htc_drv_init.c:662 [inline]
 ath9k_init_device drivers/net/wireless/ath/ath9k/htc_drv_init.c:839 [inline]
 ath9k_htc_probe_device+0xb37/0x25f0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:963
 ath9k_htc_hw_init+0x33/0x70 drivers/net/wireless/ath/ath9k/htc_hst.c:529
 ath9k_hif_usb_firmware_cb+0x272/0x620 drivers/net/wireless/ath/ath9k/hif_usb.c:1273
 request_firmware_work_func+0x13a/0x240 drivers/base/firmware_loader/main.c:1163
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243
 </TASK>
---[ end trace ]---
[Fix]
If the target does not return a valid end point id during the device connection
process, returns a failure.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Reported-and-tested-by: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index eb631fd3336d..0d1115d1cc29 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -295,6 +295,9 @@ int htc_connect_service(struct htc_target *target,
 	}
 
 	*conn_rsp_epid = target->conn_rsp_epid;
+	if (*conn_rsp_epid < 0 || *conn_rsp_epid > ENDPOINT_MAX)
+		return -EINVAL;
+
 	return 0;
 err:
 	kfree_skb(skb);
-- 
2.43.0


