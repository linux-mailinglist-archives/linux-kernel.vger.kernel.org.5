Return-Path: <linux-kernel+bounces-145893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8708D8A5C74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C0B1F22569
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE62615696F;
	Mon, 15 Apr 2024 20:51:24 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B97F7FF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214284; cv=none; b=R77d7/ROKRvMHtstkmM+AjBkYIF+u8j0omKa2D/VCHLMa86sPcm0epJvVBCpYvoognExxToh1Ahy3rgJd6xPrqsc/Mz/VK53V3H2FVwzAm5VOcQM6hWCQkGdkv1NTOM6nOHj0jSF9Q1eQMU+a6P7+4Pton6Gie4pjQodkquT92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214284; c=relaxed/simple;
	bh=h5yR2ToXNmI+hGEQoWbQjkFb3fZNqCClbanXCKw6KzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQMoB0j7n1XpN53Tl5xCaot6/ntVmQkGK5cYOM4XCba8XbGNFxqM35YRNYzIuEXuT7yzkl0PJqoJl8fG/tjCvVCy11X8mw7gSWZeaqxKCntp6AMAPVMb+freMtuDWnTh/KXbX9Ksg+vfH85BkhvTQOn3EAaUdQP/a6DV4KW4gBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34801b1bc4aso234081f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713214281; x=1713819081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCI08UxRqRdgLWPnXTXShrMmNNIATJiipTj4VitlO2E=;
        b=tjxAhvPcUQHoZYFqlKA7pG/Cb0KOY/m6liKCJZIT5F7umzz2YujxQLC6kc20N2Sd/s
         ZHUUYNPG/zPbwef2oYetCtlH8BJQGHW3eNkGbfLqT+IB9aIr4UFgWTWFIlWMRoFrxhVi
         frNQzPu1459YR0pTM3U9R25bdOlt+YgNadUmL8y2Jz8uYHTzJIsp3FjfhT9FkKiwAcj9
         Fz+R0oa7s5ocqdsArEOY3nwrImAOKF5hcyIiZZf8PgwS1Ee/nrF7MSRE7P1YfSkyf6Ox
         KAlaaHyH3sXNXGiqYYRo5nrgMfkuUDcjfuDs6My6l4M2G2QLVLH89CUO+fQutpYNpN/H
         N2aw==
X-Forwarded-Encrypted: i=1; AJvYcCXqYBRv+tO/lSqeSkSvMDROUefNZFkR4RDcN5y02sq6ToCpZQKKs1/lvJ2rTC4sbGpFdOm19YkijOFOduyyoU0YEIfk2Awh+aONUD3+
X-Gm-Message-State: AOJu0YxJGKLn4addfWmKjGR96XdpiYe3Uq/mzA7uG76FeC2MuNfdqWVl
	8Y2fPi5H42X8qNFR6HkFwf+JvL8oK1UlOFzk1PbFn4TpPfJysDW5
X-Google-Smtp-Source: AGHT+IFp2XnntHk5/TpHOO8CICGNW8DAnwJCnDWmkKC+18C1Zh/Yf7xngo58Dk9V63seawpyjxLA9A==
X-Received: by 2002:a5d:598c:0:b0:346:408d:4341 with SMTP id n12-20020a5d598c000000b00346408d4341mr8556311wri.1.1713214280910;
        Mon, 15 Apr 2024 13:51:20 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d5409000000b00343dc6a0019sm12943563wrv.68.2024.04.15.13.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:51:20 -0700 (PDT)
Message-ID: <51fc1a3f-7166-49cf-9652-a95bdc5d2119@grimberg.me>
Date: Mon, 15 Apr 2024 23:51:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] nvme-fabrics: handle transient auth failures
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240415124220.5433-1-dwagner@suse.de>
 <20240415124220.5433-6-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240415124220.5433-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/04/2024 15:42, Daniel Wagner wrote:
> Retry authentication a couple of times to avoid error out on transient
> errors. E.g. if a new key is deployed on the host and the target. At the
> same time the connection drops. The host might use the wrong key to
> reconnect.
>
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/auth.c    |  4 ++--
>   drivers/nvme/host/fabrics.c | 10 +++++++++-
>   drivers/nvme/host/fc.c      |  2 ++
>   drivers/nvme/host/nvme.h    |  1 +
>   drivers/nvme/host/rdma.c    |  1 +
>   drivers/nvme/host/tcp.c     |  1 +
>   6 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a264b3ae078b..368dcc6ee11b 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -797,7 +797,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
>   	if (ret) {
>   		chap->status = ret;
> -		chap->error = -ECONNREFUSED;
> +		chap->error = -EKEYREJECTED;
>   		return;
>   	}
>   
> @@ -818,7 +818,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
>   	if (ret) {
>   		/* Controller authentication failed */
> -		chap->error = -ECONNREFUSED;
> +		chap->error = -EKEYREJECTED;
>   		goto fail2;
>   	}
>   
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index d9a73b1b41c4..6dfa45dce232 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -573,8 +573,16 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
>    */
>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl, int status)
>   {
> -	if (status < 0)
> +	if (status < 0) {
> +		/*
> +		 * authentication errors can be transient, thus retry a couple
> +		 * of times before giving up.
> +		 */
> +		if (status == -EKEYREJECTED &&
> +		    ++ctrl->nr_auth_retries < 3)
> +			return true;

I did not suggest nr_auth_retries. Where is the 3 coming from? The 
controller already
has a number of reconnects before it gives up, no reason to add another one.

Just don't return false based on the status if it is a transient 
authentication error.

The patch just needs to be modified from:
     if (status < 0)
to
     if (status < 0 && status != -EKEYREJECTED Plus a comment that 
explains it.

