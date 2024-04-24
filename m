Return-Path: <linux-kernel+bounces-157349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D627C8B102A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9941F2349C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B7116C6B7;
	Wed, 24 Apr 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyZpoNb3"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EE7494;
	Wed, 24 Apr 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977311; cv=none; b=rdv8tlKSJou8CGuOoiyyOYjzPeJi/mQeFLpIDxF4Tt8MErIwHdlt8LzlF3o2cCLutkkzb6jrwZVYuvdm40B/+SJVLXIxCBf5dnmhNA0lGNclUSphP60ytTUD0mXrsHGZ0fKA+W4Bf/A/PXomGTExQM+aItLjgX/UOmxWORRHdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977311; c=relaxed/simple;
	bh=zOSzBjNbqpKKJGaJjaSg5lYq8xgAQ2xfJnLP9D4Zu/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG2UsOxnFQs3V6Xklc7ew2vCjl74PCuNJQPMCVu9Gy6G3abxNi0twD60pIZUq+0i1rMBQkAM/0V3hJo5QeO3oX8qCzOdi3b0xK4lhuzPTxgCItKLIFb5rl2PRrqw3hU3djtD0DhlepHI404QdM5Ssis0VMXUW13XTB0zNdE3rvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyZpoNb3; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69cb4a046dfso700336d6.2;
        Wed, 24 Apr 2024 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713977309; x=1714582109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6D8AoNY8RQ4twnQs7Z+UeuhoCUv9hZc+0BQDBwTCIlA=;
        b=IyZpoNb3Z21+d3JoruiCl5d2ZkUxhI5ScJW6UuBfVc8IUNWiMBKyd/cm+sRNlmniTH
         4ypikcg6bs/WMb+zm7GUz+ujzqOQ8RupDCPNpeG4Yv/KajTRiM3d4WoLNsKOdJjBr4fZ
         t/mD/EnN1kPdoPBl5jvKWWFr0BQqlrU2WREZvcZS4mo60H3zX9PoQO0K2RAwP7Dff7GO
         oMjeTLMBjzLVZURjTqkO7WRKT9EpwWvAASYu2ck1dwA/MjtSeNWg+HZhW8wkV+JFipUx
         4LS2hGf8aGPS7K5bG+GGoPFp2yZXafbVx5kQAvb1aOfDx/JsHLzNZ6K32dlw+x403vgY
         OHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713977309; x=1714582109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6D8AoNY8RQ4twnQs7Z+UeuhoCUv9hZc+0BQDBwTCIlA=;
        b=mGWMAFFN4u4rKtwTEX7u5/h0BKo1QLMZlG4/6tD4141/QQNQjQRTKecCHTpD1eq7bD
         z8CzsyFkO7GEsIHaFuY26Ag+dq2tadTi4TCpAVVe9Rxg1ncccGazVz6fBCv7kQo16n3y
         uVz6gEeROC6s+gjCvwc2OtbU0HJ6GAXSwcTcwxhL5bi52Mch2qYFZKZ5ojT+trUptuZv
         WFU1PMiZc7wZVonQrbnM08hqTcbIckrjPKMY6nTAg9mfhUxW7o27YsH+WdB8hWx0yn2H
         0OthtgNnc2c6akYLu8fbfnni3Oo3ERIsj2FjGel1d1qZ8oyQXyvOGfbL+WJzEA/0/REr
         yBow==
X-Forwarded-Encrypted: i=1; AJvYcCUcojzo2isj4hOv7HGNJ2U7XioYKpgO5V2lziHy0qrryPTA7CqpKgNaBHX5uh6G6Is6LLHnU2OYRJxWFOuc+bnTcpMCXNRRAxAgvVqCiSF1Aa9HagV2Qll6iz0e/4+9eqDBg1mlPNLF
X-Gm-Message-State: AOJu0Yz4MXZ5Zq7p1F+FQ89L8YXJfGjrFa6DeaToYemo8ig3RPeeAJmk
	RnC2g7hWLwbuBarA74apVQCq3KOvDAT8DFdkIQfX8Gs6GFTG59Ri
X-Google-Smtp-Source: AGHT+IHFRCqkLe2/RHeWufyO6GN+CUjvipzIcFSPFdlvxmxehZEO+Lrl3BTYk57VG1f+cDDVNsyH0g==
X-Received: by 2002:ad4:52e8:0:b0:6a0:8d25:7bb0 with SMTP id p8-20020ad452e8000000b006a08d257bb0mr3028907qvu.33.1713977308598;
        Wed, 24 Apr 2024 09:48:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l1-20020a0cac01000000b0069b439190c8sm6203460qvb.64.2024.04.24.09.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:48:27 -0700 (PDT)
Message-ID: <ff636aea-5680-4271-8c57-795d51b22e5a@gmail.com>
Date: Wed, 24 Apr 2024 09:48:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: core: check R1_STATUS for erase/trim/discard
To: Kamal Dasu <kamal.dasu@broadcom.com>, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ludovic.barre@st.com
Cc: bcm-kernel-feedback-list@broadcom.com
References: <20240423200234.21480-1-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240423200234.21480-1-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 13:02, Kamal Dasu wrote:
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
> 
> Fix skips the card->busy() and uses MMC_SEND_STATUS and R1_STATUS
> check for MMC_ERASE_BUSY busy_cmd case in the mmc_busy_cb() function.
> 
> Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard")
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks!
-- 
Florian


