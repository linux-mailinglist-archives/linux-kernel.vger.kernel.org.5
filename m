Return-Path: <linux-kernel+bounces-158155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338F38B1C43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01CD2865A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6616EB40;
	Thu, 25 Apr 2024 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTFLni9e"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32A6D1B0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031578; cv=none; b=Fj4L7/rUNfmme8LnX9fGhTjsrjZPye/MViif1OMUaDZxjZji2PkEb0/sHto2zLxmL4ynPgED4zT1B/L6L9n4E9DpBIjF3t8jyVFMk7Xq+mQkqYcqhrjm/ynFtjqV0UFyKnVsCdpDRD9twx2THaptMEsI3Uuls9NpQ0osa2BaEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031578; c=relaxed/simple;
	bh=iqcU0wl8XLsCrSPqSSxHQIoKIH4GwM1u2GuiqgLi3XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqE5NnLNnjUBGckFWdZW8fEvWlAaGB57pNM0vWPufcB44d2ER1PTsZnKZf146ZcLocjM2wLbw59V7dvau5X/U5QRGcJaO+RyGkTzpg01ztBX3ZlLtkxxadNu3r70pQlyC8pHRFKCMZ+JjSTM5SVRoVHKUzcqhE3mG01cSSGoWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gTFLni9e; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343b7c015a8so549131f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714031576; x=1714636376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ6dakPzF37vXQVxSVDUoInS9Z2Cueqb/qk7m8i8nrg=;
        b=gTFLni9evbdoxZ0Ebv9yZB0IOndbs8RlUCP709oRcDU5CMyS/84A1yIm2boqQVYePL
         XSRaIgwR9AKuyNg+eugQVDNMxjQuNRXt0p0/XeyYDsXCh/2n8VCkHYauDOAlfxuMuqQt
         2gfMV2SYmSxCCOwfTLE5TneLSrkUzxtAC0szzvVFr9VevJftvzevjr7CX9THOIFq/q6j
         kx0BgTphjJiuFbWPdcfVvwtZcLa+VdziBnjEMl6jdBTMCWE8VPEGFCpwN/PGQQGG71zc
         thTXMFXkY77otvozvasgdpR1+TKMR/CKhMpL+I6C0F3sPmwXLiHaavaXyTYW0p/qK47e
         +wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714031576; x=1714636376;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ6dakPzF37vXQVxSVDUoInS9Z2Cueqb/qk7m8i8nrg=;
        b=Ag8wCiuh3Fqkefo1lipKoPWcKZQx3wsGhujZn/ip2G5N4Qzm9toNMq33j9vZEFmCYR
         vEBxtAbvPu7/HZdgnWdH8NVy3Go6fcyL35umOs9ACn2H08wpi/kiRg2fOVEgNotC4jff
         j5QHMricMkaD9+tHREWFxAixMo81OwqJ4mjYX+ER5tziHInYPYjZg+AjGQS0uHDOW+fD
         oz7wRbPRy6MJayaQppKsUvMd4O/tnPyjpUrk9sa5mKGaBgUhLu0RtF+gqmYNPcxHv8EE
         NntzQQKdOZe4AhFwgvJWTzJpf7O9xgzuuAKHMhVTElIqcLDWrI2m4VXMZHQlh8Valn8d
         oI9A==
X-Forwarded-Encrypted: i=1; AJvYcCWOQ6Oa7T2qoodWz1SddAThhwjlKGD8nLsWllRIaZNb+eLRVqOSYdmDzBZKb2brorH0LBBiClZNj5eIF5TQylvdmcYS9+VAg+6DdDsr
X-Gm-Message-State: AOJu0YyEGVKWKrpt7mAtlmgRepoCmLko0tRqvucf1Q04/KtXZuugC/mT
	vw6z0dAyXCir7SGeOxNWkhub5iTc9b5M1PtQvMtoU3VPZZQYbHaqcqj55xUdPy8=
X-Google-Smtp-Source: AGHT+IHAWA8qIs+1LRJE6OkOV05b7ubwls3wd0MdT0C/MOGq56MiQqQuSAmDQ+1W+Ib212aGpGRI0Q==
X-Received: by 2002:adf:e505:0:b0:347:d352:d5c0 with SMTP id j5-20020adfe505000000b00347d352d5c0mr3862703wrm.54.1714031575644;
        Thu, 25 Apr 2024 00:52:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m18-20020adff392000000b00345920fcb45sm19228877wro.13.2024.04.25.00.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:52:55 -0700 (PDT)
Message-ID: <951cdadb-263e-47ac-8521-f9aaab7b1be2@linaro.org>
Date: Thu, 25 Apr 2024 09:52:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/2] dt-bindings: make sid and broadcast reg optional
To: Sumit Gupta <sumitg@nvidia.com>, robh@kernel.org, conor+dt@kernel.org,
 maz@kernel.org, mark.rutland@arm.com, treding@nvidia.com,
 jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, amhetre@nvidia.com, bbasu@nvidia.com
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-2-sumitg@nvidia.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240412130540.28447-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 15:05, Sumit Gupta wrote:
> MC SID and Broadbast channel register access is restricted for Guest VM.
> Make both the regions as optional for SoC's from Tegra186 onwards.
> Tegra MC driver will skip access to the restricted registers from Guest
> if the respective regions are not present in the memory-controller node
> of Guest DT.
> 
> Suggested-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---

One more thing:

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

The current prefix is just terrible... are you changing all bindings in
entire kernel repository?

Best regards,
Krzysztof


