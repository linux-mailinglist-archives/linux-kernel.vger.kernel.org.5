Return-Path: <linux-kernel+bounces-137586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B948189E44A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44062B22074
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22219158205;
	Tue,  9 Apr 2024 20:21:03 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B952770C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694062; cv=none; b=CqgmI2tavugbYZUaH8BlEPEsU5aMCwyQ1y9k8LsZaHlVD0+NYLszln+fbP/lQIsy2GhyBJuOQgxTw14zXQwzrbfzHwckVxX+V1eh00AHRGXe+upZMDQtJtwS6uMQqO/q6IauyBVs55YmeGHC7YS3zur5HuHWLsEYrfTPZyIHsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694062; c=relaxed/simple;
	bh=GNpOiMu5hZbOwN8H7l3gt0aUIAcdwQoMsbK2Mat4wlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgfXpIiJcsCzj9f4C/Y6zI7MOgrdclSnzAb3qzpEFUPYuUaYObvU5YMwXFThWiGBhV0hXfMc5Gtb8h+FitrAO2/eYLdhtrFtO5NN32CO0JT7GVwbJqGNnsSJTA+4UcBDEEJyVp9cb2cRd2LG/56w9kVss5WLFnXr/AspfIcVZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34602c11302so229375f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694059; x=1713298859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lULEqVs4tWshiKYsjKkDxlfPSKjepcgNdZDCa3C6hZk=;
        b=u8AmsVlZk0QzZwNQftWWPA/Gzen7DOfBru3iHnwLvDPsHY145coUtU1rcNvPmmTrbL
         P/NZwdowS60t/inDaV+CJYEswiswj3ySPX/umgXKjOQYp+TTWz8Qa3UoKL1/Buo+hMau
         R76QYt1ab0FUp65l/2cV/0d24J3CI/BlieFAz/yF4sZOO4sXO4+hcTrv5aR84uZZOpCe
         SaNaustlTyyNr3E0fCxJGpvAcPrilGoJ1o8uhndvZzJmwNGYd/X2lPW85cEjp+GfnkiX
         Uq1sGR2mQ1YDVpPxowP+JZzVEtQnEGXjo8ydaix1FZKvYmp40EyJhavy83okXk8pl7mQ
         wxyw==
X-Forwarded-Encrypted: i=1; AJvYcCWQRUZ6TyDvDPEtx3RUpnNEKlcmjfnDxqz24lIgFnnqKV4Q/vdDp0iUHjOOH6+Yz/x1EhRVVaCYylpPedaO+5KFmqy80GzQXHSXIR2V
X-Gm-Message-State: AOJu0YyWytXi4ZA/ml+5HMqWkCdUGTTc5/5+pt5AmOTTDJ18T54ux5UW
	h/9wMUKX794zZ1MRda6DzqhI7poHNAhGkstF3LbWPXTVzdFkYAQQ
X-Google-Smtp-Source: AGHT+IG6MNaAyXXodTjWqghpCkWIqtkZEu+r8y5gb0akf8pgLPLriB5ARN54fPl8PnsCGmXRXU2QBQ==
X-Received: by 2002:a5d:4a4e:0:b0:343:c3b0:ee39 with SMTP id v14-20020a5d4a4e000000b00343c3b0ee39mr439936wrs.5.1712694058954;
        Tue, 09 Apr 2024 13:20:58 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d4e88000000b003438cc1d2b4sm12253228wru.59.2024.04.09.13.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:20:58 -0700 (PDT)
Message-ID: <e73b73af-a8c6-49f2-b47a-126fab4836b2@grimberg.me>
Date: Tue, 9 Apr 2024 23:20:57 +0300
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
> + * Evaluate the status information returned by the LLDD in order to
> + * decided if a reconnect attempt should be scheduled.
> + *
> + * There are two cases where no reconnect attempt should be attempted:
> + *
> + * 1) The LLDD reports an negative status. There was an error (e.g. no
> + *    memory) on the host side and thus abort the operation.
> + *    Note, there are exception such as ENOTCONN which is
> + *    not an internal driver error, thus we filter these errors
> + *    out and retry later.
> + * 2) The DNR bit is set and the specification states no further
> + *    connect attempts with the same set of paramenters should be
> + *    attempted.
> + */
> +static inline bool nvme_ctrl_reconnect(int status)
> +{
> +	if (status < 0 && status != -ENOTCONN)
> +		return false;

So if the host failed to allocate a buffer it will never attempt
another reconnect? doesn't sound right to me..,

