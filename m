Return-Path: <linux-kernel+bounces-97713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B6B876E52
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5051F22692
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964115B1;
	Sat,  9 Mar 2024 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLg6qpQG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2AA29;
	Sat,  9 Mar 2024 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709945929; cv=none; b=GIsDdJrMFrTm/HZiUvOi0X9UPoA5AAaKOdzXUqiAK547w2clC4/0C3fgqQWCv7FA6H+ftlfVvMplNf6ivzS3f0ae4lyTiEsmwZ23Ps6aFffsGAcHwxK3c3GP+gNqcVpsUDKctA42L+aw+88HpJ7Xg5TviwwMw1Q1zmsEfS32Cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709945929; c=relaxed/simple;
	bh=zJ6Nw5yeQAp6df7eL+ihHG2GLLuX2YiQLwEPcFBAKB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aCqrOoK6CwBCMYWxDvfQShaKe54PpSwXWCOEDH+Xaoe8GxdExL/IPDMWBjvx4OXzwe77HaF7MqjpZxAs2DWiHq9b5PRGNJLxJM97ItTRWfzn0V7oVNXe/JVa/Cz2vAbUd9r0x/5oWOOZjs7pgfIENm0XUmOs/5l1GyMH3898bM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLg6qpQG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412e68b8594so19382235e9.1;
        Fri, 08 Mar 2024 16:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709945926; x=1710550726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDWvfMdJ3k4o8SXiIRC+47pnVYnjH2gTOg0JuB9vFCg=;
        b=dLg6qpQGSlWaCFlSXCCRrg8+a4n0b+0TBXcw8HDJy8Xu2QldfBbz6qQkNzUdEzVv0v
         /TKenoeZbugD/c/llUIh6afgOD2b1CLOPmJ5xAKV0hgkcHpLHDbUkEKurNSSHwu+qz9Y
         Scj6/ETyU+fizQ2CfbpqEJbZmfFblyQqTNnNb/uqaxLnXM2d3otrEyzFuX5G5HIP3oNo
         raUJ9uea/6GAe1eT0U/1nX5fBFNZhzYQcN8KaJwg25nMvFPMIoYpvJdpQqCKrDQWkRU+
         i5yaxbLr9FiqW4sgrs3qHoP9KllsLV5NUH7FVAeo14Nrir2pZFJJcf+rp+j4c2QsK8wD
         8CkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709945926; x=1710550726;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDWvfMdJ3k4o8SXiIRC+47pnVYnjH2gTOg0JuB9vFCg=;
        b=hE2tuogyYZuzmnohBjXs9UDhkwcKAzh0DZFX6Oh3mUuNGRRkhOtPa40A6pHVkfXQ/7
         wsCRfUa1f7rQfY4PuAiExMEqesXGbAEpbxrTOWnovMSPEuh1kV9m4+6pL+K4XphseGuX
         dDPAboqVg2aTtE3Xg5R/RIlGtYPuKYZnxLhg4RTyIYJBuFLy26kUf5a4QNIoPh5PZxBn
         r3rFEW5ipU4KkPV7QV0H0UoAraSNz7x+lmjixkofUVF6qnV0sIxBMnD10OD0jVMD8Mh1
         I57vtiaflDFHpk6Gc6iTRAT15f5x6/5zEclAc82ItwjhCDZCHMVVNm7QtYiTRIsUhhoE
         E6lw==
X-Forwarded-Encrypted: i=1; AJvYcCXufc7G6N+Z5e6nOgOrA4Vb1hL7cgHSS3SK14xbfV8I1SfakBh2ke56bVgqXqjG9ts9Nl/2zzXHHbSLD78KU8bhHKKek05bPdnER7btxuVkcXL1gM/tLKCAIu0N+pvTxm/qcAu1odBm5WJbvyVd2vJgkQ==
X-Gm-Message-State: AOJu0YweQ/HnVioDK2MuXEjZqnrS1TZ/FxNTBcF6o3MXnnotVCtvAFWb
	sY/00GYjGEQI35FBla6FNvMz4xbaZg9CS+2X4ngDdz3NSgb0TarH
X-Google-Smtp-Source: AGHT+IHDujLlN7fngRaFiZef4a2pu9jQcu5EPzoGII5C4xS3woQ3KEsvlDzbG3yUkWDNUSDDhY4PmA==
X-Received: by 2002:a05:600c:4f47:b0:413:812:ce7b with SMTP id m7-20020a05600c4f4700b004130812ce7bmr532458wmq.24.1709945926069;
        Fri, 08 Mar 2024 16:58:46 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id q17-20020adffed1000000b0033cf5094fcesm639665wrs.36.2024.03.08.16.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 16:58:45 -0800 (PST)
Message-ID: <c4982eed-f3f0-4adc-aba0-1aa2b1631762@gmail.com>
Date: Sat, 9 Mar 2024 01:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] platform/surface: platform_profile: add fan profile
 switching
Content-Language: en-US
To: Ivor Wanders <ivor@iwanders.net>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240302170147.13026-1-ivor@iwanders.net>
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240302170147.13026-1-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/24 18:01, Ivor Wanders wrote:
> This patch adds functionality that switches the fan profile when the
> platform profile is switched on the Microsoft Surface Pro 9.
> 
> Previously, the fan profile was not changed and that results in poor
> thermal performance. This makes the behaviour and functionality identical
> to what the Windows drivers do.
> 
> A plot of the different responses to system load, as well as recordings
> from the SSAM bus can be found at [1]. Based on discussions with
> Maximilian Luz there this patch proposes the following changes:
> 
> In surface_aggregator_registry:
> - Rename ssam_node_tmp_pprof to ssam_node_tmp_perf_profile for clarity.
> - Introduce ssam_node_tmp_perf_profile_with_fan that has the has_fan
>    boolean property set.
> - Use the new ssam_node_tmp_perf_profile_with_fan for the Surface Pro 9.
> 
> In the platform profile module:
> - Rename ssam_tmp_profile_device to ssam_platform_profile_device to make it
>    clear it handles more than just the TMP subsystem.
> - Rename the enum conversion method to make distinction between TMP and FAN
>    clear.
> - Add enum and set function & request for the fan profile.
> - Ensure that if the module's has_fan boolean is true, the fan profile is
>    switched whenever the platform profile changes.
> 
> 
> [1]: https://github.com/linux-surface/kernel/pull/145
> 
> Ivor Wanders (1):
>    platform/surface: platform_profile: add fan profile switching
> 
>   .../surface/surface_aggregator_registry.c     | 36 +++++---
>   .../surface/surface_platform_profile.c        | 86 ++++++++++++++++---
>   2 files changed, 99 insertions(+), 23 deletions(-)
> 

Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

