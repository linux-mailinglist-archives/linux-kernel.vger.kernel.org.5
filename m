Return-Path: <linux-kernel+bounces-79222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E7F861F22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14395B23ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492814CAD1;
	Fri, 23 Feb 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StnAPt/J"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C514CAD4;
	Fri, 23 Feb 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724384; cv=none; b=iI8jsyHqpMmfmuOyM6XmR9lO/TbXBsXoC9YIKLY9XyPGukbW3z0aditmTDDmvJWqtoIPiwrffC+PPRcL2TVbmaPru79G7kSAnE5qBZvddcfyTSw5KV36+9qzkk4OpgSuvjHEwsRhYEGablJWsRsuV9jTSXF2/xVUKesjOInXK+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724384; c=relaxed/simple;
	bh=nBOvddITUg82vu632V8ageTzObZ2Y1qlwhll/7zZynE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4nswriXA8EqVuznjUrH5f4fz3l9DGPrfacOi0j9Ika/3cRfRD+lEvKLbA1CypRhVlMH0B6RwpwRxZRbsQ+er/Jiy7brXzoUQxzoe4n6arzvMMuxSqHIteQAf+m90rJfcaDDfyPDffdoXJOYO+KMF353b/2r0YYfBuP9s+buKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StnAPt/J; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d208be133bso19104771fa.2;
        Fri, 23 Feb 2024 13:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708724380; x=1709329180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTNDETrdxLPLLj2soCrgwEeiKvA9z73KspOUjnFvWI8=;
        b=StnAPt/Jr9IMl27pAGYLbAyLCQjUHZa28KpRvSXSDpLJOAw3zC7SEaPW1TlNLzq7K2
         I/ESVWLbaBF5PEgV52on45Y23nHlabaiMZJbGjkcRYIieVBOgBfBfwWEcbyAq7lD1+o3
         R+nsZp5Yrur6R0g/KVKJCbxPwWelrkifg+zYn87VYXtQ4u4HSLTqnvNDMyR052PTNT+K
         2DZMmXKzYcF4+SLQRk9DS0JpYAErfdBoDqkICeGDzeYCOpmdeejCRUFbERP7m5GJtlzY
         FTP76IA2DQQ9OA+CY+QTOKwSvnxETdJBjhwggcVZP0D41tc2pfSjq2updJ5EM9YAmkuh
         gAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708724380; x=1709329180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTNDETrdxLPLLj2soCrgwEeiKvA9z73KspOUjnFvWI8=;
        b=xC2aTXY6aQdw8B5eIL8EJz7AhJypWPHWEKXEQYSESa7ssTznZmOHf2TU/onCzGJ+8T
         +rY2CDt3wJ+8s+ROHzJkp5wrY+S7m/Mn9j6Faa4RlAPWJkEixqPG/goefCCY3dUseZOl
         +VInGEzC4YumHG/cA4tbFi9Vnc4DJ4uUXVB0AsvpunKzjfWmcSakLEOG3BSDUriKbL1J
         HJhOWQjxVkuEklchPNU0OlajTVAMO6s87H/rooXErFHuO1KgBrKVj+c4ZqkrqScbiuLv
         O520o8L7FFPn2qs0Ufn+TxXOQe/2xYyziacDpA6ctS3hytzgOrR/9NHsw4LPJfNxkosZ
         zMhw==
X-Forwarded-Encrypted: i=1; AJvYcCW8GdDW2u91tPgJ7cKkc3M6yvXbiAc/FwXPg+xnLjbChVak95y8Yrguzre033t5nZsSqGEI7OtCDffYjo8kbPouTrmOcxLAwpjF16CQXoxz1TNZJnbQYUaDV+vHYXfkqNiMYn+uFumBEMwlCa1/
X-Gm-Message-State: AOJu0Yy3dXqdudcIFdvd+U0xcWl/HJS7Bydhi19SCEAG52GRlHGCoCsr
	eYQfCkySHLNA6fTa6IPS++wh9Fb9XMLav2z5UqCrmFXNyuWPF5Eg
X-Google-Smtp-Source: AGHT+IEoSDljY8Wqb5QFlFCUuS1Q+vXWUwBwQ4GPywRaeJQF/xde9pVXx9WEkP29OH0lvSwBHqmmuQ==
X-Received: by 2002:a05:6512:2212:b0:512:ed25:c447 with SMTP id h18-20020a056512221200b00512ed25c447mr727571lfu.37.1708724380360;
        Fri, 23 Feb 2024 13:39:40 -0800 (PST)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id i1-20020ac25b41000000b005114ee99515sm2584897lfp.220.2024.02.23.13.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:39:40 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Hilda Wu <hildawu@realtek.com>,
	Alex Lu <alex_lu@realsil.com.cn>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH 2/2] Bluetooth: btrtl: fix out of bounds memory access
Date: Sat, 24 Feb 2024 00:37:04 +0300
Message-ID: <20240223213704.290849-3-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223213704.290849-1-andrej.skvortzov@gmail.com>
References: <20240223213704.290849-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The problem is detected by KASAN.
btrtl driver uses private hci data to store 'struct btrealtek_data'.
If btrtl driver is used with btusb, then memory for private hci data
is allocated in btusb. But no private data is allocated after hci_dev,
when btrtl is used with hci_h5.

This commit adds memory allocation for hci_h5 case.

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in btrtl_initialize+0x6cc/0x958 [btrtl]
 Write of size 8 at addr ffff00000f5a5748 by task kworker/u9:0/76

 Hardware name: Pine64 PinePhone (1.2) (DT)
 Workqueue: hci0 hci_power_on [bluetooth]
 Call trace:
  dump_backtrace+0x9c/0x128
  show_stack+0x20/0x38
  dump_stack_lvl+0x48/0x60
  print_report+0xf8/0x5d8
  kasan_report+0x90/0xd0
  __asan_store8+0x9c/0xc0
  	 [btrtl]
  h5_btrtl_setup+0xd0/0x2f8 [hci_uart]
  h5_setup+0x50/0x80 [hci_uart]
  hci_uart_setup+0xd4/0x260 [hci_uart]
  hci_dev_open_sync+0x1cc/0xf68 [bluetooth]
  hci_dev_do_open+0x34/0x90 [bluetooth]
  hci_power_on+0xc4/0x3c8 [bluetooth]
  process_one_work+0x328/0x6f0
  worker_thread+0x410/0x778
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Allocated by task 53:
  kasan_save_stack+0x3c/0x68
  kasan_save_track+0x20/0x40
  kasan_save_alloc_info+0x68/0x78
  __kasan_kmalloc+0xd4/0xd8
  __kmalloc+0x1b4/0x3b0
  hci_alloc_dev_priv+0x28/0xa58 [bluetooth]
  hci_uart_register_device+0x118/0x4f8 [hci_uart]
  h5_serdev_probe+0xf4/0x178 [hci_uart]
  serdev_drv_probe+0x54/0xa0
  really_probe+0x254/0x588
  __driver_probe_device+0xc4/0x210
  driver_probe_device+0x64/0x160
  __driver_attach_async_helper+0x88/0x158
  async_run_entry_fn+0xd0/0x388
  process_one_work+0x328/0x6f0
  worker_thread+0x410/0x778
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Last potentially related work creation:
  kasan_save_stack+0x3c/0x68
  __kasan_record_aux_stack+0xb0/0x150
  kasan_record_aux_stack_noalloc+0x14/0x20
  __queue_work+0x33c/0x960
  queue_work_on+0x98/0xc0
  hci_recv_frame+0xc8/0x1e8 [bluetooth]
  h5_complete_rx_pkt+0x2c8/0x800 [hci_uart]
  h5_rx_payload+0x98/0xb8 [hci_uart]
  h5_recv+0x158/0x3d8 [hci_uart]
  hci_uart_receive_buf+0xa0/0xe8 [hci_uart]
  ttyport_receive_buf+0xac/0x178
  flush_to_ldisc+0x130/0x2c8
  process_one_work+0x328/0x6f0
  worker_thread+0x410/0x778
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Second to last potentially related work creation:
  kasan_save_stack+0x3c/0x68
  __kasan_record_aux_stack+0xb0/0x150
  kasan_record_aux_stack_noalloc+0x14/0x20
  __queue_work+0x788/0x960
  queue_work_on+0x98/0xc0
  __hci_cmd_sync_sk+0x23c/0x7a0 [bluetooth]
  __hci_cmd_sync+0x24/0x38 [bluetooth]
  btrtl_initialize+0x760/0x958 [btrtl]
  h5_btrtl_setup+0xd0/0x2f8 [hci_uart]
  h5_setup+0x50/0x80 [hci_uart]
  hci_uart_setup+0xd4/0x260 [hci_uart]
  hci_dev_open_sync+0x1cc/0xf68 [bluetooth]
  hci_dev_do_open+0x34/0x90 [bluetooth]
  hci_power_on+0xc4/0x3c8 [bluetooth]
  process_one_work+0x328/0x6f0
  worker_thread+0x410/0x778
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20
 ==================================================================

Fixes: 5b355944b190 ("Bluetooth: btrtl: Add btrealtek data struct")
Fixes: 044014ce85a1 ("Bluetooth: btrtl: Add Realtek devcoredump support")
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index b66136348bd6..c0436881a533 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -1072,6 +1072,7 @@ static struct h5_vnd rtl_vnd = {
 	.suspend	= h5_btrtl_suspend,
 	.resume		= h5_btrtl_resume,
 	.acpi_gpio_map	= acpi_btrtl_gpios,
+	.sizeof_priv    = sizeof(struct btrealtek_data),
 };
 
 static const struct h5_device_data h5_data_rtl8822cs = {
-- 
2.43.0


