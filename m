Return-Path: <linux-kernel+bounces-110573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91478860C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666751F232D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D19D134404;
	Thu, 21 Mar 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="X/53hI3D"
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DBA8BE7;
	Thu, 21 Mar 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047139; cv=none; b=LjaVKUy/hi+/8MhqDvkcfYE7w1kXnigLTYi1p71/+gqqg+PerG+MrKmPTaVyhjFZNKTinKW+ZXlD8Dgd02v6vTHa2Tx1PBgJvzAm3bwsZoK9plk2S6eShjX5wyrAfh5jhd2vqujmN9/SF/oRr4QqdgdxL4qPP+uaCZyxC6qyVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047139; c=relaxed/simple;
	bh=QtbUvtXiAXkDkzVt6KWS9DcJFxTw7uEEyc5dWQXE38E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RdZCg9x31+DxdHv64vDxCOgOXs7hb2FvX6GRErVwrxu5zcvT4QsGg+VcfLunFM0iPlzgrFe/va/bQ3mw0Ri6W/CNaQQNuZDPCVBk5RBDVwQvRsmC77/ud/vAmJRElMwQoYMCajuvqKP8GCPKrjDn464Gnnn05rz8GnC0zDpnnQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=X/53hI3D; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1711047135; bh=QtbUvtXiAXkDkzVt6KWS9DcJFxTw7uEEyc5dWQXE38E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X/53hI3DyMr/wdMm7LgaD4MnXHFKR94gOgDZx6I8LsYSn1f+oLIDbpJM+5HiBTMqV
	 jYc1vGBqp4dobMqhoTCnWvaulidCUK8uUDyp0A/t4VPrFlcwJr6xP5JmB9WQPQ1jNn
	 hkWZpKbpVT+Y8iX8aRurqW49yriY3x28wfoEcTAn0wGDOCpo9z5cD8/Fc+hmYQWZiv
	 snzZ7uR6ezqg511BKuCb3VUQzv3Ihz45V1C9kBq2IOBzSel6NqK1vS30Cw9GnFhKUD
	 6THY2Fwl9BarMSVjS6N3o1RjFdsPPrXfKTTcc3frlkhK5QYXYJsRGzI9jFcH2Hq4WL
	 3D5RBuIX7Bbbg==
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH usb] wifi: ath9k: fix oob in htc_issue_send
In-Reply-To: <tencent_7225DC0D859205DD8BDDAE191CCFBF0D8907@qq.com>
References: <0000000000004e41110614187d35@google.com>
 <tencent_7225DC0D859205DD8BDDAE191CCFBF0D8907@qq.com>
Date: Thu, 21 Mar 2024 19:52:15 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wmpvfme8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Edward Adam Davis <eadavis@qq.com> writes:

> [syzbot reported]
> usb 1-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
> ath9k_htc 1-1:1.0: ath9k_htc: HTC initialized with 33 credits
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:51
> index 255 is out of range for type 'htc_endpoint [22]'
> CPU: 1 PID: 2494 Comm: kworker/1:2 Not tainted 6.8.0-rc6-syzkaller-00190-ga788e53c05ae #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Workqueue: events request_firmware_work_func
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:347
>  htc_issue_send.constprop.0+0x209/0x230 drivers/net/wireless/ath/ath9k/htc_hst.c:26
>  ath9k_wmi_cmd_issue drivers/net/wireless/ath/ath9k/wmi.c:305 [inline]
>  ath9k_wmi_cmd+0x424/0x630 drivers/net/wireless/ath/ath9k/wmi.c:342
>  ath9k_regread+0xdb/0x160 drivers/net/wireless/ath/ath9k/htc_drv_init.c:242
>  ath9k_hw_read_revisions drivers/net/wireless/ath/ath9k/hw.c:287 [inline]
>  __ath9k_hw_init drivers/net/wireless/ath/ath9k/hw.c:572 [inline]
>  ath9k_hw_init+0xf02/0x2b30 drivers/net/wireless/ath/ath9k/hw.c:700
>  ath9k_init_priv drivers/net/wireless/ath/ath9k/htc_drv_init.c:662 [inline]
>  ath9k_init_device drivers/net/wireless/ath/ath9k/htc_drv_init.c:839 [inline]
>  ath9k_htc_probe_device+0xb37/0x25f0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:963
>  ath9k_htc_hw_init+0x33/0x70 drivers/net/wireless/ath/ath9k/htc_hst.c:529
>  ath9k_hif_usb_firmware_cb+0x272/0x620 drivers/net/wireless/ath/ath9k/hif_usb.c:1273
>  request_firmware_work_func+0x13a/0x240 drivers/base/firmware_loader/main.c:1163
>  process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243
>  </TASK>
> ---[ end trace ]---
> [Fix]
> If the target does not return a valid end point id during the device connection
> process, returns a failure.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Reported-and-tested-by: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/net/wireless/ath/ath9k/htc_hst.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
> index eb631fd3336d..0d1115d1cc29 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_hst.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
> @@ -295,6 +295,9 @@ int htc_connect_service(struct htc_target *target,
>  	}
>  
>  	*conn_rsp_epid = target->conn_rsp_epid;
> +	if (*conn_rsp_epid < 0 || *conn_rsp_epid > ENDPOINT_MAX)
> +		return -EINVAL;
> +

Hmm, there's an off-by-one error here: the arrays in question are
defined as var[ENDPOINT_MAX], so a value of ENDPOINT_MAX is going to
overflow.

IOW, this should be:

 +	if (*conn_rsp_epid < 0 || *conn_rsp_epid >= ENDPOINT_MAX)
 +		return -EINVAL;
 +


-Toke

