Return-Path: <linux-kernel+bounces-161321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C858B4AA9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C504E2818AE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9202652F6C;
	Sun, 28 Apr 2024 08:10:49 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404F5026C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714291849; cv=none; b=tHhLMMW/iLukkzN72s64VuN03v59SFRLPJKzr9AjOUNlHFf0qnYF0/SUWHVrnpFM4TUkyunQd7ihWr11e3gww9UY53B9oOXSyaDjmLVa96wBloSJFH8TQbK862Uk8kvWEAkckHExQxgWIzahg/ZWsAMJmXxyW7IRo72EKdZ1OUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714291849; c=relaxed/simple;
	bh=kwS8pE3FrbwrTn+vbG85/0brGnvYbxlN3/Wb83ErNwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rd8zMgqXGoy/qhgDV5QWkBKvvV4igFy7h4TajfuLkQxV1mNHz/HrMMJOtobCiQoHMUeigr6skvZfmAnz9kv7kL3pfHd8bViDOPGqMwBfoYm3UI6JgHC7SYRM5TXfmM0Muz8RyBGo++fCEEZhfFe0reQjMntwSLo1O6knfXlSqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34aa836b948so560284f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714291846; x=1714896646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSsj5LAoQ32PBl1G57MXIm3HfE7QVXhj2MFLYvYJyaM=;
        b=K8Gxc7s7Nb3pWWE3qed2bQLXtc60LUEUpsFxhosmaKwo2S1q63306EiJ4QW8OdC6Y6
         z4Nc/QV8mEfIv1VDl0g1uCVEtQzJENcnwa+KgrutH/3UQJEA1ziT/TurlbuZiFqjDZuc
         UBLXsx1IbA0mFyN58sAkLM7kAGR2wWHgCNSP4dzJUt34Y4009yXLxV4tToIPjlX0e4u1
         MBOXNzgdWWHNC8Vw3DgO+9We9XnQHEZPDb5Xbm/kJ11eKCfCFhMtpFvX9Q2CUZamg6WP
         RzT4osRQaZPTAFbxEEsJUmeXjufP3+e78Lq2XUvFNIeWpEn617twt57FUFMhAxXoEluJ
         3xEA==
X-Forwarded-Encrypted: i=1; AJvYcCXva8NhvsLUzBr8mA+Zbj1ZAuh8p7kmtGGWQlEF2gK+AIrZ7ZWATNrNk+OdrOcGrkPl/q0ChnvwmHU48U5QcndYaeZjkOpGKlbVAE+j
X-Gm-Message-State: AOJu0YzX8tTUU6iRSzodPUbeG9UquNw2+K6ZIYpodI2l0lTj94jOAC04
	kKdQAi9CSrtsoYEKLbc2q2wsRnocY0x3q2EUxDKHJOgsHBULjR3Q
X-Google-Smtp-Source: AGHT+IGP4m8pWKjjEduL1pHCrqGLJrYhz2+AVqhsRQtW4q+UW/nhK9upYyNDD7iRIJaedhqYRalo8g==
X-Received: by 2002:adf:a412:0:b0:346:500f:9297 with SMTP id d18-20020adfa412000000b00346500f9297mr4939177wra.2.1714291845438;
        Sun, 28 Apr 2024 01:10:45 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b003456c693fa4sm26429616wrz.93.2024.04.28.01.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 01:10:45 -0700 (PDT)
Message-ID: <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
Date: Sun, 28 Apr 2024 11:10:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme connect deadlock in allocating tag
To: kwb <wangbing.kuang@shopee.com>, james.smart@broadcom.com,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: chunguang.xu@shopee.com
References: <20240428063147.88058-1-wangbing.kuang@shopee.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240428063147.88058-1-wangbing.kuang@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/04/2024 9:31, kwb wrote:
> Hi,
> We found nvme connect will dealock when it cannot alloc tag in admin queue. So we reproduce it and find a way to work around. The solution is to utilize reserve tag for connecting.
> Here is the deadlock environment:
> 1. the process [kworker/u129:1+nvme-wq] want to connect wait for geting tag, but tag is used up:
> [<0>] blk_mq_get_tag+0x11d/0x2d0
> [<0>] __blk_mq_alloc_request+0x92/0x180
> [<0>] blk_mq_alloc_request+0x7c/0xc0
> [<0>] nvme_alloc_request+0x28/0x100 [nvme_core]
> [<0>] __nvme_submit_sync_cmd+0x1ea/0x230 [nvme_core]
> [<0>] nvmf_reg_read64+0x62/0xa0 [nvme_fabrics]
> [<0>] nvme_enable_ctrl+0x25/0xb0 [nvme_core]
> [<0>] nvme_tcp_setup_ctrl+0x257/0x340 [nvme_tcp]
> [<0>] nvme_tcp_reconnect_ctrl_work+0x24/0x40 [nvme_tcp]
> [<0>] process_one_work+0x228/0x3d0
> [<0>] worker_thread+0x4d/0x3f0
> [<0>] kthread+0x127/0x150
> [<0>] ret_from_fork+0x1f/0x30
> 2. many processes (here is nvme list) is waiting for connecting:
> [<0>] blk_execute_rq+0x8d/0x110
> [<0>] nvme_execute_passthru_rq+0x60/0x1f0 [nvme_core]
> [<0>] nvme_submit_user_cmd+0x23e/0x400 [nvme_core]
> [<0>] nvme_user_cmd+0x163/0x1d0 [nvme_core]
> [<0>] nvme_ctrl_ioctl+0x2e/0x40 [nvme_core]
> [<0>] __nvme_ioctl+0x78/0xc0 [nvme_core]
> [<0>] nvme_ioctl+0x1e/0x20 [nvme_core]
> [<0>] blkdev_ioctl+0x126/0x260
> [<0>] block_ioctl+0x4a/0x60
> [<0>] __x64_sys_ioctl+0x91/0xc0
> [<0>] do_syscall_64+0x59/0xc0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Reproduce method is very eazy:
> 1. call many nvme list
> 2. make nvme io timeout to recover connection
> 3. trick is to make reconnect-delay much time, eg:30s
>
> The solution is the appending patch. it is tested and also consider keepalive and reset/showdown tag reserve.

The error_recovery work should unquiesce the admin_q, which should fail 
fast all pending admin commands,
so it is unclear to me how the connect process gets stuck.

What is step (2) - make nvme io timeout to recover the connection?

Is this reproducing with upstream nvme? or is this some distro kernel 
where this happens?
Do you have the below patch applied?
de105068fead ("nvme: fix reconnection fail due to reserved tag allocation")

