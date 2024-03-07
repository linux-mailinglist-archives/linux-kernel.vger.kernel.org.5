Return-Path: <linux-kernel+bounces-95728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7518751CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D13F1F2190C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9359C12F380;
	Thu,  7 Mar 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aBX6yySh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rTGOQtpC"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6D12F36F;
	Thu,  7 Mar 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821508; cv=none; b=qu8Yt2DeJaITztO6evQPh4bw4PYgcCFUOJ8UlSGqhbqO7ad6mjB3gGj3EGHoQ1Ms7ngQiGuAuulK0eI8Uqiw8AiB9s/4eu3k6z0no/AQCi0um/dXOSQwNY6gG7qIhrwi0N8iI8QCD7iOhv+VAYqUYPh8UWHnhMI01eKHpuPKG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821508; c=relaxed/simple;
	bh=s3fat3rCD43RsuIuLpGtydaSQZZ20Jgs6Z/8t/y2LoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P+/kZyuclBycih0mKOFC7wcL040xtTXsUKZt2uGeC7ch5OtZMNAnbXhq88/enF5bbMe6IICyd7m7SeAhEEaM6fT8fcemRNlHqefqZ3ywYWAGEMYjAu+8dyrNnKRKZ6+orlDG/Q5oRFfPybXME2mb43lspd9P6vYSkJr2Dgk1IbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=aBX6yySh; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rTGOQtpC reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709821505; x=1741357505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WhASmGAxo/32YXdlY314I+/8f90iYMLkteylf+FTynU=;
  b=aBX6yyShHSjJGu0MvxzDbTzFJaW0qqDecdLFEjPGcZdZV/oJzCHfcE9x
   IqfuJDNfcExqlPQgyEMVLVoUiEDpQIwVOzHSsxEvSw9DG5Ih3VNrJ97qS
   1RvGzNea9UmBEdyeV9PxFNJqnWkh13OVPz95D8ezFnavS+Q89j+iHVQ0P
   inZoRA3zpaIpSigsPJIi3IDA8/N/W5PKwuIIvSdRfHCaHFw4ECyzkoXX6
   cvQ9x7JcipIOl3RwC/Xmwt2G7ZSKOmd7NL0bFwGseLUq7//c60xT31NL7
   vjBe4z/cDJA4mRU7Vvd9wZaECplxRFb0f9INVCr6iGdD1cwV+y1Kk3/Qy
   w==;
X-IronPort-AV: E=Sophos;i="6.07,211,1708383600"; 
   d="scan'208";a="35791097"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Mar 2024 15:25:00 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5835C16F436;
	Thu,  7 Mar 2024 15:24:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709821496; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WhASmGAxo/32YXdlY314I+/8f90iYMLkteylf+FTynU=;
	b=rTGOQtpCiyfZF8XFayT10F8dvDItFfWYxvPcs8dwmLcVfKv/Y19/eAQzOtDqrqc+iFHTFk
	i52QWBE1tm90Chg6C5n+m3UjLx8+nHYSFzl/YE4lz8eBozoHsgfHz08iddoOTJbXGxYgux
	ha1S3gnT9OQwPNbav9DtgBXt4OVMWw9kdHOYOyp3/b7y5UP0cx7aqC6yinP5FtBjn2NSq2
	UdFwHYcKzEFOs0ksxwkehwoVVJEvUNgvXzrp0vWAs03X5xWncCJuhcNa4WIasjBI3TOlyq
	6eBG+CzYmkAZgu/OPGEPS63P6imAi5742OveIhoJ53DZHHXbFVmf47+EwDOguQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] media: v4l: async: Fix notifier list entry init
Date: Thu,  7 Mar 2024 15:24:51 +0100
Message-Id: <20240307142452.3685103-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

struct v4l2_async_notifier has several list_head members, but only
waiting_list and done_list are initialized. notifier_entry was kept
'zeroed' leading to an uninitialized list_head.
This results in a NULL-pointer dereference if csi2_async_register() fails,
e.g. node for remote endpoint is disabled, and returns -ENOTCONN.
The following calls to v4l2_async_nf_unregister() results in a NULL
pointer dereference.
Add the missing list head initializer.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Due to all the renames over time, it's hard to find a proper
Fixes tag. If I see it correctly it was missing from the initial commit
e9e310491bdbc ("[media] V4L2: support asynchronous subdevice registration").

The backtrace is left outside of commit message due to size.
Note: Needs CONFIG_DEBUG_LIST to be enabled.

------------[ cut here ]------------
WARNING: CPU: 1 PID: 133 at lib/list_debug.c:52 __list_del_entry_valid_or_report+0x7c/0x148
list_del corruption, c33b9558->next is NULL
Modules linked in: imx6_mipi_csi2(C+) v4l2_fwnode snd_soc_imx_audmux snd_soc_tlv320aic32x4_i2c ci_hdrc_imx(+) coda_vpu snd_soc_tlv320aic32x4 imx6_media(C) ci_hdrc snd_soc_fsl_ssi snd_soc_fsl_asrc imx_pcm_dma v4l2_jpeg imx_media_common(C) videobuf2_vmalloc udc_core snd_soc_core videobuf2_dma_contig roles dw_hdmi_imx imx_vdoa videobuf2_memops dw_hdmi caam usbmisc_imx v4l2_mem2mem imx_sdma drm_display_helper error videobuf2_v4l2 snd_pcm_dmaengine virt_dma video_mux imxdrm videobuf2_common snd_pcm v4l2_async mux_mmio drm_dma_helper mux_core videodev drm_kms_helper snd_timer snd etnaviv mc soundcore imx_ipu_v3 gpu_sched gpio_keys gpio_beeper drm drm_panel_orientation_quirks configfs
CPU: 1 PID: 133 Comm: systemd-udevd Tainted: G        WC         6.8.0-rc7-next-20240307+ #438
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Call trace: 
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x50/0x64
 dump_stack_lvl from __warn+0x98/0xc4
 __warn from warn_slowpath_fmt+0x11c/0x1b4
 warn_slowpath_fmt from __list_del_entry_valid_or_report+0x7c/0x148
 __list_del_entry_valid_or_report from __v4l2_async_nf_unregister.part.0+0x38/0x78 [v4l2_async]
 __v4l2_async_nf_unregister.part.0 [v4l2_async] from v4l2_async_nf_unregister+0x44/0x4c [v4l2_async]
 v4l2_async_nf_unregister [v4l2_async] from csi2_probe+0x20c/0x2b4 [imx6_mipi_csi2]
 csi2_probe [imx6_mipi_csi2] from platform_probe+0x5c/0xb0
 platform_probe from really_probe+0xd0/0x3cc
 really_probe from __driver_probe_device+0x8c/0x120
 __driver_probe_device from driver_probe_device+0x30/0xc0
 driver_probe_device from __driver_attach+0xd8/0x1b0
 __driver_attach from bus_for_each_dev+0x70/0xc0
 bus_for_each_dev from bus_add_driver+0xf0/0x1f4
 bus_add_driver from driver_register+0x7c/0x118
 driver_register from do_one_initcall+0x44/0x174
 do_one_initcall from do_init_module+0xa4/0x2a8
 do_init_module from init_module_from_file+0x94/0x134
 init_module_from_file from idempotent_init_module+0xec/0x240
 idempotent_init_module from sys_finit_module+0x64/0xc4
 sys_finit_module from ret_fast_syscall+0x0/0x1c
Exception stack(0xf0d45fa8 to 0xf0d45ff0)
5fa0:                   00000000 00000000 0000000f b6cfb624 00000000 00020000
5fc0: 00000000 00000000 00000000 0000017b 00000000 b6eaff5b 00000000 0239e688
5fe0: bea33658 bea33648 b6cf65ab b6c2b112
---[ end trace 0000000000000000 ]---

 drivers/media/v4l2-core/v4l2-async.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 3ec323bd528b1..6a7dcf43d7125 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -563,6 +563,7 @@ void v4l2_async_nf_init(struct v4l2_async_notifier *notifier,
 {
 	INIT_LIST_HEAD(&notifier->waiting_list);
 	INIT_LIST_HEAD(&notifier->done_list);
+	INIT_LIST_HEAD(&notifier->notifier_entry);
 	notifier->v4l2_dev = v4l2_dev;
 }
 EXPORT_SYMBOL(v4l2_async_nf_init);
@@ -572,6 +573,7 @@ void v4l2_async_subdev_nf_init(struct v4l2_async_notifier *notifier,
 {
 	INIT_LIST_HEAD(&notifier->waiting_list);
 	INIT_LIST_HEAD(&notifier->done_list);
+	INIT_LIST_HEAD(&notifier->notifier_entry);
 	notifier->sd = sd;
 }
 EXPORT_SYMBOL_GPL(v4l2_async_subdev_nf_init);
-- 
2.34.1


