Return-Path: <linux-kernel+bounces-101292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAB87A528
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8216280A54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84822EE3;
	Wed, 13 Mar 2024 09:47:22 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1F22615
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323241; cv=none; b=ATNFBcxjhpgf2sP5erYEjcIULUl1Kq4hGCMai4UGFtzpnlP0IeT5MPkn4oTYsP4iVSGrzxWv1+ziAWv7VAyull7sgZTUCAgYesNDRkGR5DlK6CbnInz6iWi4zNlCpBTP3TeKdQPVuPIQCi/QLSnyxakusk4Ea87dZJY9VqLx1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323241; c=relaxed/simple;
	bh=v8+bhXLebl9R7Rp6pRLl4govwixttVsHrMopOBzPR84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjoQMm0tGocdlmX1R+03Imxgd9EukIGHXV1LEw0rKDaK5c/bEbbhj9zyYVmjs6MX7VfPoL3GsynhaIEqBlcFak+hK/Gvo8DhtKbwrqYtOv/vpp9CeZF4OjaQHhSbW0mqG2/o86BYVzTQOVUB7ok85eLBSkYBP/1sXvNMzXz2SBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d45c8b056dso4818831fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710323238; x=1710928038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LrhKiFFa243S9pGQsqrFwvvyDwPRCSO43o+8ovrLxA=;
        b=GxEOCnTOb//A9kWQBfwoNVxqDVnUzg9npqkYvYp0jDh6cTYkk0ig4GnI+KbazLsZgn
         xemab3523vJ41xnmMavyVeh5YFECs2316ct0HqaAKCI3pwbr4N2Y7kpMdWq0DrO2g896
         79X+2Db0xhlcK+BxTfHBxtqdB25AGU3e9mDdApiOUKpljjxJtgu4UDcHkI0BlBfX73DX
         ncE4DV2Ad2HxV+/Y7O+g0UY7v3WUmhqXJwaYY05QKHwftlqQTMIpBAb7Yf10UeS/b1sy
         MOGnvTlFEshSPSw+w6dcDsrK5PXed1tr5kD8hyi5PN6jhJ1FFRA1MbgLKD9QIamrk8ip
         s9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWCUsruQj9jZS3aega74vwV1XTUsRG3tPeQjnwXNRtX74qzqjIvvdOCudLy9qBcAroPsZpVOX7h5AYQ4ztTrgjKJZL9suGuUdKqa9fE
X-Gm-Message-State: AOJu0YwnsQ+zDpmhG++ac5ryhrvVV33sE3PL4UVwVBatG0sNwq3MngOb
	N12LasEX0OcCQ4wsfIQH/vfOXA27FdTpVkjdjIVyoPqIUTptLfvGHOyW256r
X-Google-Smtp-Source: AGHT+IEFTZC4JCzPH+tjfdu5yGUCVD+jd3p4/hhDUFeaMkOCSaJjo4yWaw8ik7D3BXtmyXgYfWvWZQ==
X-Received: by 2002:a2e:a405:0:b0:2d2:40cb:54e3 with SMTP id p5-20020a2ea405000000b002d240cb54e3mr856558ljn.2.1710323237726;
        Wed, 13 Mar 2024 02:47:17 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c3b8700b00413ea3db648sm1323839wms.26.2024.03.13.02.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 02:47:17 -0700 (PDT)
Message-ID: <fc352d23-06e0-4f24-b220-fb87a229eec7@grimberg.me>
Date: Wed, 13 Mar 2024 11:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Content-Language: he-IL, en-US
To: Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Anton.Gavriliuk@hpe.ua
References: <20240313085531.617633-1-fengli@smartx.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240313085531.617633-1-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2024 10:55, Li Feng wrote:
> The default nvme_tcp_wq will use all CPUs to process tasks. Sometimes it is
> necessary to set CPU affinity to improve performance.
>
> A new module parameter wq_unbound is added here. If set to true, users can
> configure cpu affinity through
> /sys/devices/virtual/workqueue/nvme_tcp_wq/cpumask.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>   drivers/nvme/host/tcp.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a6d596e05602..5eaa275f436f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -36,6 +36,14 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>   
> +/*
> + * Use the unbound workqueue for nvme_tcp_wq, then we can set the cpu affinity
> + * from sysfs.
> + */
> +static bool wq_unbound;
> +module_param(wq_unbound, bool, 0644);
> +MODULE_PARM_DESC(wq_unbound, "set unbound flag for nvme tcp work queue");

"Use unbound workqueue for nvme-tcp IO context (default false)"

> +
>   /*
>    * TLS handshake timeout
>    */
> @@ -1551,7 +1559,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   	else if (nvme_tcp_poll_queue(queue))
>   		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
>   				ctrl->io_queues[HCTX_TYPE_READ] - 1;
> -	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
> +	if (wq_unbound)
> +		queue->io_cpu = WORK_CPU_UNBOUND;
> +	else
> +		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
>   }
>   
>   static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
> @@ -2790,6 +2801,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   
>   static int __init nvme_tcp_init_module(void)
>   {
> +	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI;
> +
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
> @@ -2799,8 +2812,10 @@ static int __init nvme_tcp_init_module(void)
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
>   
> -	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
> -			WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +	if (wq_unbound)
> +		wq_flags |= WQ_UNBOUND | WQ_SYSFS;

I think we should have WQ_SYSFS exposed always. Add it in a seperate patch
that comes before this.

> +
> +	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
>   	if (!nvme_tcp_wq)
>   		return -ENOMEM;
>   


