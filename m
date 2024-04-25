Return-Path: <linux-kernel+bounces-158881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A14708B2631
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D0E1F238D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151014C581;
	Thu, 25 Apr 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o79iJOP6"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FD14D2AA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061948; cv=none; b=gs068tVOYeSM4EtaXKcvcmnRqgWvrVEUUTcZ1hjIGnZ5VM8pJG6YxfrsiKxrmuMXbtvoAEtuHMtLl5knpHZCqibMxMPEiyI6RHW/mKFYnOsq6lyMUAAV/Gn5sH3CXE214qzXnzP+3yrRPRksI9mML7JH/kPdV9ITpHHKg+8u0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061948; c=relaxed/simple;
	bh=EgyZj3aBfYfNaDWanxnneaI1mNImgpynJTcCnngx//I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRs99V3DS5gvlwVlUUm1whgOI2d17UFksQADx3lilkY6I2RF86fYnaDMG1Q/lI8RWTWgo8+Nl1TMZ23JZl1q3h/vVbigOomKUr5xuWYTMqUOqXwUgTqMlbQcvfmuoBel/ifYM0/nH+XT4gGiMPbrm39mNO9KlTmjnZLttEL1nQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o79iJOP6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1279543276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714061945; x=1714666745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8z0q8mIvifH3C42ApHD6waFmd6qh9hC9jh6KXdsJmXw=;
        b=o79iJOP6+sTZoh9Xr4MliDZg4lYAleiFQEXDB8eaian7C/Cvg+OP/fPL48qscRFFMO
         naXNP5vmGSRZxb9ktpT5TcSbmFOFy0fWA7btHYboGhoU6ZgxMMxR6reU67f+RIb615vz
         voROTbQ/6eyuiWJsL6dnkPu3WG5WCY9PAinV6khj89RBOdYIbKiO1LwUTt3s+YYKy9HW
         LFjxk+IcPIXqCOv2GrDc9zldNzKTyeUxayymSPT0SW6raRUsLPOyeZ9Ym4QofcTyF7iI
         lv9MeGg5VSgvQ9+C8+qm6eomdtuI5eMUiHvn5dzJ2ITO35qlzybXfO6RxGAjgqFwnADq
         lTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061945; x=1714666745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8z0q8mIvifH3C42ApHD6waFmd6qh9hC9jh6KXdsJmXw=;
        b=S52pGARopQLze+7Hqj0YvHzha+kMAdnPdhibyPcTGcwMyZyJCcTcFpJB91O9LxcT21
         TdXwb+P6OHpw/Z7IeoeC1sotGx5cJzERkOf9DrykfwLdQ6XtSDXGjIt9cbhCqxBLg1GO
         9VKVC7W5EIEpyHuW7a7AxcpT6MPtUxUXcs+k2/N5p2gtS+OwnBbs9GimWkDfZIxOUDsp
         msK1rFCgugHCEc8TKhjuJxzkGgi7r161b5EM45lVfr7gBlHSeRNODAJwFA5ELWs3OMZP
         DCd2322p7VIXhuUi1WfX9CZQ1rIximBfo19EPuPybVPoQaEM9QtxR08f/2dvt0W9eBd7
         NyRA==
X-Gm-Message-State: AOJu0Yx2go595Z9OFH0czXal9w3VV1nF2mrtqhUjpkbzx7hJeiZEQEr9
	rPIaeF5hmEkg/ds5xDXw7OyaIm1htApHCPALkuB1igEycGEoUBW4dkqyW0dEPakHa8ByCabwsrF
	mb0KikPFjQhCeYIXW682zo1+h8rNbO55Ae6ehGg==
X-Google-Smtp-Source: AGHT+IHClPFipV6dbakb7PT4dxjuTSB5dRykOr2Z828W2wE1uQV5lKTgHH5rXaVt+Bj1NgGztCRPoTA6BIqw/4uYK5U=
X-Received: by 2002:a05:6902:2413:b0:dcc:2f09:4742 with SMTP id
 dr19-20020a056902241300b00dcc2f094742mr88397ybb.51.1714061945033; Thu, 25 Apr
 2024 09:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423200234.21480-1-kamal.dasu@broadcom.com>
In-Reply-To: <20240423200234.21480-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:18:28 +0200
Message-ID: <CAPDyKFqLqbRx3gWCqT4G6mUVeMDWyA_f8T2_iYt07r_Ffqaaow@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: core: check R1_STATUS for erase/trim/discard
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ludovic.barre@st.com, f.fainelli@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

+ Wolfram, Adrian (to see if they have some input)

On Tue, 23 Apr 2024 at 22:02, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> When erase/trim/discard completion was converted to mmc_poll_for_busy(),
> optional ->card_busy() host ops support was added. sdhci card->busy()
> could return busy for long periods to cause mmc_do_erase() to block during
> discard operation as shown below during mkfs.f2fs :
>
> Info: [/dev/mmcblk1p9] Discarding device
> [   39.597258] sysrq: Show Blocked State
> [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  tgid:1561  ppid:1542   flags:0x0000000d
> [   39.610609] Call trace:
> [   39.613098]  __switch_to+0xd8/0xf4
> [   39.616582]  __schedule+0x440/0x4f4
> [   39.620137]  schedule+0x2c/0x48
> [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
> [   39.628562]  schedule_hrtimeout_range+0x10/0x18
> [   39.633169]  usleep_range_state+0x5c/0x90
> [   39.637253]  __mmc_poll_for_busy+0xec/0x128
> [   39.641514]  mmc_poll_for_busy+0x48/0x70
> [   39.645511]  mmc_do_erase+0x1ec/0x210
> [   39.649237]  mmc_erase+0x1b4/0x1d4
> [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
> [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
> [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
> [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
> [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
> [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
> [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
> [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
> [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
> [   39.693539]  __submit_bio+0x1c/0x80
> [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
> [   39.701875]  submit_bio_noacct+0x1b0/0x22c
> [   39.706042]  submit_bio+0xac/0xe8
> [   39.709424]  blk_next_bio+0x4c/0x5c
> [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
> [   39.717835]  blkdev_common_ioctl+0x374/0x728
> [   39.722175]  blkdev_ioctl+0x8c/0x2b0
> [   39.725816]  vfs_ioctl+0x24/0x40
> [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
> [   39.733114]  invoke_syscall+0x68/0xec
> [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
> [   39.741609]  do_el0_svc+0x18/0x20
> [   39.744981]  el0_svc+0x68/0x94
> [   39.748107]  el0t_64_sync_handler+0x88/0x124
> [   39.752455]  el0t_64_sync+0x168/0x16c

Thanks for the detailed log!

>
> Fix skips the card->busy() and uses MMC_SEND_STATUS and R1_STATUS
> check for MMC_ERASE_BUSY busy_cmd case in the mmc_busy_cb() function.
>
> Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard")
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>  drivers/mmc/core/mmc_ops.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 3b3adbddf664..603fbd78c342 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -464,7 +464,8 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
>         u32 status = 0;
>         int err;
>
> -       if (data->busy_cmd != MMC_BUSY_IO && host->ops->card_busy) {
> +       if (data->busy_cmd != MMC_BUSY_IO &&
> +           data->busy_cmd != MMC_BUSY_ERASE && host->ops->card_busy) {
>                 *busy = host->ops->card_busy(host);
>                 return 0;
>         }

So it seems like the ->card_busy() callback is broken in for your mmc
host-driver and platform. Can you perhaps provide the information
about what HW/driver you are using?

The point with using the ->card_busy() callback, is to avoid sending
the CMD13. Ideally it should be cheaper/faster and in most cases it
translates to a read of a register. For larger erases, we would
probably end up sending the CMD13 periodically every 32-64 ms, which
shouldn't be a problem. However, for smaller erases and discards, we
may want the benefit the ->card_busy() callback provides us.

I would suggest that we first try to fix the implementation of the
->card_busy() callback for your HW. If that isn't possible or fails,
then let's consider the approach you have taken in the $subject patch.

Kind regards
Uffe

