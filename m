Return-Path: <linux-kernel+bounces-137608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C889E493
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA602831DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32F1158878;
	Tue,  9 Apr 2024 20:40:09 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530515884B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695209; cv=none; b=muCmZs6BaSYSnZJXVwSQnDDdKOwhoC3OLYIecA+w87zx8fUlihapv+0bZFC91ekZXuVvnTXaDWYFrv5MuZsdoxNNCAbnfksx1Id7AF0z+YKmksXqqPzwYxFy+YzMyiYC8IsvftRM42ilC/a4ssT9rZuVcQfeNlcQcG2vwal2Xz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695209; c=relaxed/simple;
	bh=YySLk/SphSaJniQbpa6Q/Z3YnjxMt2WcvbQDXmC9i2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxQHt5UZIbdaD1uSyx099Lpl1E4pwQE300GOmfxopAIl1cWxM6RCKNI5kQlJd3yMTBKCzIegmOFC00e4PYN8w8Hph4z/xi8Zn0EitQjDUjqA6Lbg7lxh0wxBC6cPSR65JZUpIYR4N2yzg6s0Bpie6DwOgLT6d6De02XP9PCYseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346407b8c9aso298125f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695205; x=1713300005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyv+Sgdpe/tURPZFPrQf1DpSV+fJ2iL3YgdlrzErjvE=;
        b=SblBk1EuixLDYLyBRolPqqUK50vPGd4KrWMA5IUqcSetTc/ABFV5zQ2TRnSnT35Bpx
         VsP2LOHns6zbn3PB1ffAunC8uDLGyvXds8TP3sVOTPaGtOvMvHZGaNiqo66SN+mf0BSJ
         Migsg7811xlgi6N8NWn0riIHLz1JCun0JR4JLojRyOSJlt2oorIDemGTIo7yLC+/hpCY
         /UeqwXZ/s/ysQ09ZrBhrj7rP2LIe/1EwsAEwwswJUdVbi+9SD4Lp8eWg+z0DxwgIWaYv
         KaK+gBVugSSvbEMErdpCfX+5s6Qaobmx4lu4/V4saTuRzuaESQjY2fDhv6zIMgxxf3ze
         7XMA==
X-Forwarded-Encrypted: i=1; AJvYcCUdjPKgugSo5zSPTV/vVt0SbDmmfoZpqUpZ4sbBu7qDZGh4ITwJWotFbJIErZ1i3VP+4Z6N9COcPwifV6e+ox5CX0wqzHC5MMStMa7i
X-Gm-Message-State: AOJu0YxtcsJKIOdo0Kj3RiQC1/LzFaNkH5iBMcO5rHPx28jkRP+jHifS
	L5b/aNwDgbhQepPNxzxQwUp0FaeuD27+t9IsOZ+kaSCnfsG4KSv8y3JkP1MS
X-Google-Smtp-Source: AGHT+IGEPQeWWJ1gb55WKa4X7BOEKHCw4H0e29oACi5yCfUTHDaZG3IsGW3B3dIZWTe1nSDN2UNqfQ==
X-Received: by 2002:a5d:64e3:0:b0:343:ba58:1297 with SMTP id g3-20020a5d64e3000000b00343ba581297mr654216wri.3.1712695205394;
        Tue, 09 Apr 2024 13:40:05 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0041668770f37sm44916wms.17.2024.04.09.13.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:40:05 -0700 (PDT)
Message-ID: <91c49412-4251-4e13-80df-9148208aeac7@grimberg.me>
Date: Tue, 9 Apr 2024 23:40:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] nvme-tcp: short-circuit reconnect retries
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-4-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2024 12:35, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Returning an nvme status from nvme_tcp_setup_ctrl() indicates that the
> association was established and we have received a status from the
> controller; consequently we should honour the DNR bit. If not any future
> reconnect attempts will just return the same error, so we can
> short-circuit the reconnect attempts and fail the connection directly.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [dwagner: add helper to decide to reconnect]
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/nvme.h | 24 ++++++++++++++++++++++++
>   drivers/nvme/host/tcp.c  | 23 +++++++++++++++--------
>   2 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9b8904a476b8..dfe103283a3d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -701,6 +701,30 @@ static inline bool nvme_is_path_error(u16 status)
>   	return (status & 0x700) == 0x300;
>   }
>   
> +/*
> + * Evaluate the status information returned by the LLDD

We usually say transport, less so LLDD.

>   in order to
> + * decided if a reconnect attempt should be scheduled.
> + *
> + * There are two cases where no reconnect attempt should be attempted:
> + *
> + * 1) The LLDD reports an negative status. There was an error (e.g. no
> + *    memory) on the host side and thus abort the operation.
> + *    Note, there are exception such as ENOTCONN which is
> + *    not an internal driver error, thus we filter these errors
> + *    out and retry later.

What is this ENOTCONN here? From what I see its just a random
escape value to bypass the status check. I think that 0 would do the same
wouldn't it?

> + * 2) The DNR bit is set and the specification states no further
> + *    connect attempts with the same set of paramenters should be
> + *    attempted.
> + */
> +static inline bool nvme_ctrl_reconnect(int status)
> +{
> +	if (status < 0 && status != -ENOTCONN)
> +		return false;
> +	else if (status > 0 && (status & NVME_SC_DNR))
> +		return false;
> +	return true;
> +}
> +
>   /*
>    * Fill in the status and result information from the CQE, and then figure out
>    * if blk-mq will need to use IPI magic to complete the request, and if yes do
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index fdbcdcedcee9..7e25a96e9870 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2155,9 +2155,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   	nvme_tcp_destroy_io_queues(ctrl, remove);
>   }
>   
> -static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> +static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
> +		int status)
>   {
>   	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
> +	bool recon = nvme_ctrl_reconnect(status);
>   
>   	/* If we are resetting/deleting then do nothing */
>   	if (state != NVME_CTRL_CONNECTING) {
> @@ -2165,13 +2167,14 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   		return;
>   	}
>   
> -	if (nvmf_should_reconnect(ctrl)) {
> +	if (recon && nvmf_should_reconnect(ctrl)) {

its weird to have a condition that checks _and_ condition
of two different "should reconnect" conditions.

Why don't we simply pass the status to nvmf_should_reconnect()
and evaluate there?

>   		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
>   			ctrl->opts->reconnect_delay);
>   		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
>   				ctrl->opts->reconnect_delay * HZ);
>   	} else {
> -		dev_info(ctrl->device, "Removing controller...\n");
> +		dev_info(ctrl->device, "Removing controller (%d)...\n",
> +			 status);
>   		nvme_delete_ctrl(ctrl);
>   	}
>   }
> @@ -2252,10 +2255,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
>   			struct nvme_tcp_ctrl, connect_work);
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> +	int ret;
>   
>   	++ctrl->nr_reconnects;
>   
> -	if (nvme_tcp_setup_ctrl(ctrl, false))
> +	ret = nvme_tcp_setup_ctrl(ctrl, false);
> +	if (ret)
>   		goto requeue;
>   
>   	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
> @@ -2268,7 +2273,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   requeue:
>   	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
>   			ctrl->nr_reconnects);
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
>   static void nvme_tcp_error_recovery_work(struct work_struct *work)
> @@ -2295,7 +2300,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);
>   }
>   
>   static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
> @@ -2315,6 +2320,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   {
>   	struct nvme_ctrl *ctrl =
>   		container_of(work, struct nvme_ctrl, reset_work);
> +	int ret;
>   
>   	nvme_stop_ctrl(ctrl);
>   	nvme_tcp_teardown_ctrl(ctrl, false);
> @@ -2328,14 +2334,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	if (nvme_tcp_setup_ctrl(ctrl, false))
> +	ret = nvme_tcp_setup_ctrl(ctrl, false);
> +	if (ret)
>   		goto out_fail;
>   
>   	return;
>   
>   out_fail:
>   	++ctrl->nr_reconnects;
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
>   static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)


