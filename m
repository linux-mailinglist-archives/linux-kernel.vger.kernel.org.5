Return-Path: <linux-kernel+bounces-79220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1815861F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175321F27A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235F14A0A9;
	Fri, 23 Feb 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENo7FEAO"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4CA145B1B;
	Fri, 23 Feb 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724372; cv=none; b=pAyHt3TNgWgEbL8PxRzkcUIPUrkSJv17U1QrPR/VGghPyJtka58qp5ruM9Y5jPWQa7aym+5w48ELfEQwCyolhLNjaigq5/OR0Ou8ewRKmRje/tsND/jq8p5tphQ6iFGXWiIWnL/RdEF0twUxGmDjECkVLxNmeb0UrvbI66TdSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724372; c=relaxed/simple;
	bh=mq4SvG7SWA3etLr2nckw6IZrUzeAQQs1+Xf7aQM2F50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oExkVCkvRwH6usz0JiTdAr0HupLTeDpIs4R2Zk+orlEa2O41srQSjr0+T1UkXcLfi/K5ApZKvZyLKpjFxuvXwQ2DvuCT4QN0AzY5vEbehaGg1HZeaaqXufTf3AfZzZo/MSl5m+aW7F0PL9wjC7pfBmeqoyFWzerZLQQqWP9AK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENo7FEAO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512be6fda52so1100916e87.0;
        Fri, 23 Feb 2024 13:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708724369; x=1709329169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6ujNt33DTW/nBjyL7svpOEhORGOnWdQHD+ihLBARuc=;
        b=ENo7FEAOiw5SujziZWfueLNqlNV+VqhqnCq3Huje4sRodxSy2xxf2gYkt/aFCZheCc
         biEny9+07ttUxKxHyuVc5DttrZoZU+NBlgYm6Gyhn6tJMOBhiT1ic5y86B5uN52zhg5S
         GllIY7JxoeZuoFQCg3OK79FOoGqdse0lwjOtFaNPM9bOgmfPOKK/SBl27sWqNWhJlq34
         v37cfgwDRZUGYSszOxpgl9XAIPnHzzvF2Zcx3sNCt0pwX8pAtPclsuLbX4Necr+auPtN
         RW7ATJfGb61Wu5FEdpgSjcEWdeSRyqIBqKnDaKRTfE4u5wSdzsHhCTpJRD92ed5UHYm/
         n7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708724369; x=1709329169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6ujNt33DTW/nBjyL7svpOEhORGOnWdQHD+ihLBARuc=;
        b=qDTP+pdUISDBiVkuLV2C2DUWONURcCiPf7BRnWqr5Xlrdg7s+/+RsxaO8a10pbGv3T
         p4/hB0MkYdVOtqHmNC1JdTwTv+WNu3pfCPAe0/OT7uisjyYU0jbbV5M5C5s3PEhVvH9t
         DghpcvhQCmtajnGc2ii0QV2/XytUt/Gt7ZimYlbrpaoTsobJkGSNBTq5Jflhw0LIKgAK
         RzCzWdjQ2+9q8UYrufJ+pvTL4lVa2gczr1dhkj5qATnjM8kjm0wJNzRZjS4ZISduXY4a
         1+MdqD+6kuDSbk1T3sR9ktBux4Rgz5lsXX/1KeE2plYn+KXRyYRKvKztSQV9EvV2Y2hA
         7TTw==
X-Forwarded-Encrypted: i=1; AJvYcCW0t6HF2ztu6hduXlISLWJTbX9CCIe0yyjqbAwvYFeVeva4/jZZcHF2ljXivdwubpVxfHrQrJr/kzDvrNFOrSAfNO/IsYy78o8EkIcHaUOHnJk9tljDG6bB8awYYaBH1Insk8p3VBbNHw9SO5aj
X-Gm-Message-State: AOJu0Yyud9WO17h0h67lkwnx5SZ9o+JdfP0hsDtC24o1D1AvKzlHdxFz
	nbSNmp0MH85KsfC+iu6IXc63JOIdZNK23GsMMTl/CNbGSVaiC58GYdFStyFMsW8=
X-Google-Smtp-Source: AGHT+IE/jus2VH97rc84MPtCtfaDJv1OQqDINTjfWmlepN0n6jUlYDIvv/ERKNvEZ8opvrKDyUtjTg==
X-Received: by 2002:a05:6512:614:b0:512:e51f:b58 with SMTP id b20-20020a056512061400b00512e51f0b58mr665816lfe.24.1708724368494;
        Fri, 23 Feb 2024 13:39:28 -0800 (PST)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id i1-20020ac25b41000000b005114ee99515sm2584897lfp.220.2024.02.23.13.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:39:27 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Hilda Wu <hildawu@realtek.com>,
	Alex Lu <alex_lu@realsil.com.cn>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH 0/2] Bluetooth: btrtl: fix out of bounds memory access
Date: Sat, 24 Feb 2024 00:37:02 +0300
Message-ID: <20240223213704.290849-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
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

These commits add memory allocation for hci_h5 case.

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

Andrey Skvortsov (2):
  Bluetooth: hci_h5: Add ability to allocate memory for private data
  Bluetooth: btrtl: fix out of bounds memory access

 drivers/bluetooth/hci_h5.c     |  5 ++++-
 drivers/bluetooth/hci_serdev.c |  9 +++++----
 drivers/bluetooth/hci_uart.h   | 12 +++++++++++-
 3 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.43.0


