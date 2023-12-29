Return-Path: <linux-kernel+bounces-13263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87535820238
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274501F22E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE9114AA3;
	Fri, 29 Dec 2023 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOJSc5MV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E614F61;
	Fri, 29 Dec 2023 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33686649b72so7254238f8f.3;
        Fri, 29 Dec 2023 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703889736; x=1704494536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96Hd5IFgkK/TcrBu0MMVF5Mj+dQO1oOnTc+wyle0UDM=;
        b=eOJSc5MVPYvFH0VxFK8IyUfeELDWSstJnQINHKxEMFB5Rgob3xAzoLpBP33CRL31BF
         ihTooz0zXQDQLH2QBTkige45vXI5PZVopjyNCtK9uOk5VMrTeUuEoolgcODNkQenTLTJ
         7rIu5kcrDgiBRZV/rBuQFhNOR23xJfO0spKt9Z5IJz2oILpYN5GgT7EwTnXobMAfPBk9
         dLNyQki3GaNoYLDjgetIlLUUDDO7gKQvvIkmruyGHB0G2TmqiaAevqi6bCaSSrbXNfgx
         7u2npBNFe+HagY+utz6APauLxq7Ehhj5Lhe1W2ktgQ8VeMgdzOuZbwyz8v7cPcF0RtAN
         LICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703889736; x=1704494536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96Hd5IFgkK/TcrBu0MMVF5Mj+dQO1oOnTc+wyle0UDM=;
        b=o0i7LwmsgUAaJ3vTJ3ZYb7SVQeVUuuOJRzYgpXIDrBlxtk6JA8lCcj9g4olqqBWD1b
         wn24R0PI+g+z1kHAeimrTqxPfo3J+1oVDF/AXne5Y45tDbymisiN+x/GNRf6S52xCC32
         C9sX17q7wPevDbbkQe77rInByGfIBs6p7tRa05P/CYbKa4HFJV7UWNKW1sKgQFl8IQFn
         RQLY8tZdYAey9ceJyxSpPm/xxD3i1XyTz+rk+z+n77kN+La2kY6D9WGQiKe5WH6iqSQe
         gCR7MzGSqnsQQnOZEfDKm96lSYaYFtV6H4K9Jf16VWGqdnHEmB+9MjnXpEVrHUjyBQyI
         vNsw==
X-Gm-Message-State: AOJu0Yx7NM094T0jHviqNOAI+w2jZliG+FfpHvfuh+i/ophw1KFXD6Gr
	gA9ZO6SwNr/9DQWENlck+G8=
X-Google-Smtp-Source: AGHT+IGs2sPUXR2Yzv7R5GGm3bHf8UgL5eF4/tABd1NZieCdZ6DQh+uyjpH/MQ8fIqXw1gkeSnHZGg==
X-Received: by 2002:adf:d1c8:0:b0:336:f20b:4b45 with SMTP id b8-20020adfd1c8000000b00336f20b4b45mr3829021wrd.40.1703889735597;
        Fri, 29 Dec 2023 14:42:15 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id o10-20020adfeaca000000b0033677a4e0d6sm20078775wrn.13.2023.12.29.14.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 14:42:15 -0800 (PST)
Message-ID: <33a556e3-a7ac-47a3-a621-4db12dbac208@gmail.com>
Date: Fri, 29 Dec 2023 23:42:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] platform/surface: aggregator_registry: add entry
 for fan speed
To: Ivor Wanders <ivor@iwanders.net>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231228003444.5580-1-ivor@iwanders.net>
 <20231228003444.5580-3-ivor@iwanders.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231228003444.5580-3-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/28/23 01:34, Ivor Wanders wrote:
> Add an entry for the fan speed function.
> Add this new entry to the Surface Pro 9 group.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/144
> ---
> Changes in v2:
>    - No changes in this patch.
> ---
>   drivers/platform/surface/surface_aggregator_registry.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index 530db4db7..b0db25886 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -74,6 +74,12 @@ static const struct software_node ssam_node_tmp_pprof = {
>   	.parent = &ssam_node_root,
>   };
>   
> +/* Fan speed function. */
> +static const struct software_node ssam_node_fan_speed = {
> +	.name = "ssam:01:05:01:01:01",
> +	.parent = &ssam_node_root,
> +};

I would prefer if we could keep the subsystem prefix for node names. So
something like `ssam_node_tmp_fan_speed`.

Otherwise, this looks good to me. With that changed:

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> +
>   /* Tablet-mode switch via KIP subsystem. */
>   static const struct software_node ssam_node_kip_tablet_switch = {
>   	.name = "ssam:01:0e:01:00:01",
> @@ -319,6 +325,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
>   	&ssam_node_bat_ac,
>   	&ssam_node_bat_main,
>   	&ssam_node_tmp_pprof,
> +	&ssam_node_fan_speed,
>   	&ssam_node_pos_tablet_switch,
>   	&ssam_node_hid_kip_keyboard,
>   	&ssam_node_hid_kip_penstash,

