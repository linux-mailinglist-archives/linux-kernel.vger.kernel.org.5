Return-Path: <linux-kernel+bounces-29044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4209F830779
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA0E1C2161A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE5120312;
	Wed, 17 Jan 2024 14:04:20 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0120305
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500259; cv=none; b=RtHZh1dWSaUJM4PEor9UWRhvV0uaFXKWZodVrnVqBA9YBi0FGTwBCd0tVsmyV4JzVeXZ0kcSbqgpsV4SmOn97Ohe979gZqkj+piRFktTJPf7areOOnaDJdWVna9DY2zizA/UHFzW5VJRwX6SVMxvNFsTufvjtmfqagWH2JobYfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500259; c=relaxed/simple;
	bh=jyPEFw2sL4/9gXQxuMbPvLvliYmYJJHayaIrC5kOWwM=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=R5CoFSJ5+IXTDrz55f9RadE8xkjsux3Zme0EFZm/umaiWJvycrT2hz+OkiqcQKM66OCGZTIqjnykWv2FRaRLVCjNPJV3xxH9Y1YdnC74KTDAwkKsLkiE2wb5mYlZvFt6QGLyq6RusTwItC7j5afRXHdx7inXe34zLlPRoAnCHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2057f388b2dso2272762fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705500257; x=1706105057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/tSjeLHwcNNY1qIrnbAwCawBMgNGPX58hQ4TkI4XNU=;
        b=BEnTXWpXAj/h93LGexMGP6Fa2J7pdXFC8axJaRscaGOh3xX0DinnmahH9PB/CtqrJ3
         Pyy8aooPIvL9inge26kHNRJ1Boy4mSuPNEOf5DEqp/htTR1S7b7TdTVW2dIfoM2APwyo
         GZzo+WrAhuRbEWI2K61U9C/aWInrRhExEyiHs7jB9ovx70NVGHe2yyHcKxDaTxZf1sO6
         I2haQDRjXBi6/4VMlcI18xeJEUo05HG8qjc8QGXFukt8v2IcxTqFWThAUZMBuPa/Q6sz
         Cqm8BPSpQW6QM8QLLp5ktiL1Wgbxw3eV1HufSPzFOMMSyulNtpKBECiWV51ukXkDB293
         eAZg==
X-Gm-Message-State: AOJu0Yzc0X4FcnNZG5OxBoziSznI3SiKNjGtQJvvtyvDb70w/GPlz1E7
	7KqEpHnlSx4KXEkLQwm822Y=
X-Google-Smtp-Source: AGHT+IESwHVgixBmlf9Abx2wRLMf7HL7e5pF8TVqXlGhE4J+mSylzs+bSAC6iVltbBu4A7zpOCrbmA==
X-Received: by 2002:a05:6870:fb88:b0:210:9e85:edc6 with SMTP id kv8-20020a056870fb8800b002109e85edc6mr1769721oab.5.1705500257045;
        Wed, 17 Jan 2024 06:04:17 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id pa25-20020a0568701d1900b002069e3bcbb5sm3537404oab.18.2024.01.17.06.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:04:16 -0800 (PST)
Message-ID: <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
Date: Wed, 17 Jan 2024 16:04:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: en-US
To: mengfanhui <mengfanhui@kylinos.cn>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240117065043.79192-1-mengfanhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/17/24 08:50, mengfanhui wrote:
> From: Sagi Grimberg <sagi@grimberg.me>
> 
> The mpath disk node takes a reference on the request mpath
> request queue when adding live path to the mpath gendisk.
> However if we connected to an inaccessible path device_add_disk
> is not called, so if we disconnect and remove the mpath gendisk
> we endup putting an reference on the request queue that was
> never taken [1].
> 
> Fix that to check if we ever added a live path (using
> NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
> reference.
> 
> [1]:
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 1372 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
> CPU: 1 PID: 1372 Comm: nvme Tainted: G           O      5.7.0-rc2+ #3
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1 04/01/2014
> RIP: 0010:refcount_warn_saturate+0xa6/0xf0
> RSP: 0018:ffffb29e8053bdc0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8b7a2f4fc060 RCX: 0000000000000007
> RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff8b7a3ec99980
> RBP: ffff8b7a2f4fc000 R08: 00000000000002e1 R09: 0000000000000004
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: fffffffffffffff2 R14: ffffb29e8053bf08 R15: ffff8b7a320e2da0
> FS:  00007f135d4ca800(0000) GS:ffff8b7a3ec80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005651178c0c30 CR3: 000000003b650005 CR4: 0000000000360ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   disk_release+0xa2/0xc0
>   device_release+0x28/0x80
>   kobject_put+0xa5/0x1b0
>   nvme_put_ns_head+0x26/0x70 [nvme_core]
>   nvme_put_ns+0x30/0x60 [nvme_core]
>   nvme_remove_namespaces+0x9b/0xe0 [nvme_core]
>   nvme_do_delete_ctrl+0x43/0x5c [nvme_core]
>   nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
>   kernfs_fop_write+0xc1/0x1a0
>   vfs_write+0xb6/0x1a0
>   ksys_write+0x5f/0xe0
>   do_syscall_64+0x52/0x1a0
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
> ---
>   drivers/nvme/host/multipath.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 2dd4137a08b2..3e579e49579c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -895,6 +895,14 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>   	/* make sure all pending bios are cleaned up */
>   	kblockd_schedule_work(&head->requeue_work);
>   	flush_work(&head->requeue_work);
> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +		/*
> +		* if device_add_disk wasn't called, prevent
> +                * disk release to put a bogus reference on the
> +                * request queue
> +                */
> +		head->disk->queue = NULL;
> +	}
>   	put_disk(head->disk);
>   }
>   

How did you see this? disk->queue is allocated in blk_alloc_disk called
in nvme_mpath_alloc_disk... I don't understand how you saw the same
dereference that was addressed by this commit.

