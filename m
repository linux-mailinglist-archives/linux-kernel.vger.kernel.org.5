Return-Path: <linux-kernel+bounces-52358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601EB849719
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44A61F2388A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B63134AE;
	Mon,  5 Feb 2024 09:56:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24DD12E75;
	Mon,  5 Feb 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126976; cv=none; b=c0/3whFlzsQzqix64aGkIrp9HLp32k2LYyU/NrPmDuk5eu8aVLsve8E1mp5smb0puBgpHpQX9157hiOLNLxgXCT2bGlfEytT3EaajIAikxEbdKf8yMbkk3cgKJl6Vtdx8LSSt7AZhOCKvBj3CkPwy5AzyhTt7W4m+09jXS1BWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126976; c=relaxed/simple;
	bh=u3UHw68fN7+IkE23kchq6FnkTdKNYPKXZ66IvYNi2es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gn9s3D+XX4Z4yygFl0ETI/q66K9kFin7E/HpjwM8jJnH1WiXfjZvoZGWgYX75VIYzY3lc2RPaRXoPWKH9Wo0+nDvdF7eXlA5oudVK2lJzjSXRaqZi5xvKkVdmCgzlrlsRZI9Xf9nq9JCJO5vwnBgKdnYFF78bxWvlpR1wcI2zAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B14C433F1;
	Mon,  5 Feb 2024 09:56:15 +0000 (UTC)
Message-ID: <cffd5052-9314-424d-872c-07796feb7ce9@xs4all.nl>
Date: Mon, 5 Feb 2024 10:56:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: usb: hackrf: add null ptr check in hackrf_ctrl_msg
Content-Language: en-US, nl
To: Mingxuan Xiang <mx_xiang@hust.edu.cn>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240122112210.424698-1-mx_xiang@hust.edu.cn>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240122112210.424698-1-mx_xiang@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 12:22, Mingxuan Xiang wrote:
> If the user yanks out the cable before closing the file,
> dev->udev would be set to NULL therefore causing a null-ptr-deref
> in hackrf_ctrl_msg issued by hackrf_stop_streaming.
> 
> This patch adds a check in hackrf_ctrl_msg before using
> dev->udev.
> 
> Found by modified syzkaller.
> 
> BUG: KASAN: null-ptr-deref in hackrf_ctrl_msg+0x6d/0x180 drivers/media/usb/hackrf/hackrf.c:195
> Read of size 4 at addr 0000000000000000 by task syz-executor/579
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x5e/0x7c lib/dump_stack.c:106
>  print_report.cold+0x49a/0x6bb mm/kasan/report.c:436
>  kasan_report+0xa8/0x130 mm/kasan/report.c:495
>  hackrf_ctrl_msg+0x6d/0x180 drivers/media/usb/hackrf/hackrf.c:195
>  hackrf_stop_streaming+0x45/0x140 drivers/media/usb/hackrf/hackrf.c:869
>  __vb2_queue_cancel+0x5c/0x550 drivers/media/common/videobuf2/videobuf2-core.c:1992
>  vb2_core_streamoff+0x2f/0xb0 drivers/media/common/videobuf2/videobuf2-core.c:2149
>  __vb2_cleanup_fileio+0x3e/0xa0 drivers/media/common/videobuf2/videobuf2-core.c:2710
>  vb2_core_queue_release+0x1a/0x50 drivers/media/common/videobuf2/videobuf2-core.c:2430
>  vb2_queue_release drivers/media/common/videobuf2/videobuf2-v4l2.c:947 [inline]
>  _vb2_fop_release+0x110/0x140 drivers/media/common/videobuf2/videobuf2-v4l2.c:1132
>  v4l2_release+0x1b9/0x1e0 drivers/media/v4l2-core/v4l2-dev.c:459
>  __fput+0x12d/0x4b0 fs/file_table.c:320
>  task_work_run+0xa8/0xf0 kernel/task_work.c:177
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
>  exit_to_user_mode_prepare+0x123/0x130 kernel/entry/common.c:201
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
>  syscall_exit_to_user_mode+0x22/0x50 kernel/entry/common.c:294
>  do_syscall_64+0x48/0x90 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
> ---
>  drivers/media/usb/hackrf/hackrf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/usb/hackrf/hackrf.c b/drivers/media/usb/hackrf/hackrf.c
> index 9c0ecd5f056c..9588b8aa6e98 100644
> --- a/drivers/media/usb/hackrf/hackrf.c
> +++ b/drivers/media/usb/hackrf/hackrf.c
> @@ -186,6 +186,11 @@ static int hackrf_ctrl_msg(struct hackrf_dev *dev, u8 request, u16 value,
>  	unsigned int pipe;
>  	u8 requesttype;
>  
> +	if (!dev->udev) {
> +		pr_err("udev is null in %s\n", __func__);
> +		ret = -EINVAL;
> +		goto err;
> +	}

Just replace this with:

	if (!dev->udev)
		return -ENODEV;

-ENODEV is the correct error code for this situation, and the error
message is overkill here, I think.

Regards,

	Hans

>  	switch (request) {
>  	case CMD_SET_TRANSCEIVER_MODE:
>  	case CMD_SET_FREQ:


