Return-Path: <linux-kernel+bounces-137598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0B889E474
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF1D1F22641
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5D1586E0;
	Tue,  9 Apr 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAEDhfQG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AB370
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694770; cv=none; b=rcYUWiDe3LDWcUEIy13XZsyotcLqIAGNCUskgSEQLzzR9f/eCrfRoY15jAcMNawaD1YF/2zTRDtKPa6SSBAUWCeF6BnXKzoL8VznQlXWCfkyZvSHq/YVC5IHnoToAKPB4s3nDFWS+vrxfxs9/Avm27tv5RL+6m53RU/XpeeMhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694770; c=relaxed/simple;
	bh=kmHV4U/BEzxQ+lrhHC4olPfkvrmi6WCwlO9+ERY7hng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMcf0pn+M1sSqcI1VNu2sgGdfdCqfpjZiEIv1oz+LQudJ4vH1UsuIdF+xs5AohuC8Tu8FfbX8ymJuQmeGCdApEMEDYfCB0uQru3X88LALXfLAJXyr/o4PoBn4EGzFZBeMwevQ6gE//8Yulx/zE580Bo7gouWjRi2OWjAEENNj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAEDhfQG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33edbc5932bso4475801f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712694767; x=1713299567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sypkh7TCCe7sFz/IInyFq1x3msEmoodNj3uhceq6ixM=;
        b=JAEDhfQG53DeoGy0jS1ruEIAjA67f78yDRhEfwxqhSOcH9W3syC165qypDqJXAe8sx
         zMN7Ij8ok2If83RH8l0o4DIwICfO4wcG1XwEW1JUT7MWl1MURDX3ApB2X7grJ32kB8JC
         ENSq+cfoAVoLwONS3ZHKFjLVF/+hNNVPZoUm+2PhNjRd+ObjxA++DyEjrKYXQRPxPyFe
         t8A5nDUTsmjkRVD8cp5xZmfq9XD5UOL+A/Cd3jhR2f3ATJy6YvcgLsPF+tj5ghJQrYdD
         uRMxF+AMrKfDYEucqodoMvHRBgPt0BhXzb6O7YWOLOUWYxM8K1mEeCnbfqugbe4Gy7FE
         z66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694767; x=1713299567;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sypkh7TCCe7sFz/IInyFq1x3msEmoodNj3uhceq6ixM=;
        b=uUBa782RLa2U6ho0RkO+jqOKfvOrSY98XasJOKTYZVWVxLFj+YUTpEczjshQpB/c2J
         Bi6XpFmCG7c/AZi/a7sFlrZUcofMX9fkkTSNgADKGH8PW3xzyPqHQLGIsoEWx5xOlKdU
         emPXQI363+1nChw3HFfV2vsTl5R8sNYraSROUPtRGkNEt40DkDhJkh8glucw4d6h/rGu
         gTnCziT1I/sZss0/3IaL6Nhz9a0+uIygZc+3UaY9q4tEuyo7PXWHqyXvrYyuJDjHiR4K
         tYgnOTYpqXCHjTXAaHtbeYMnuZ6UBhijxR5P71Inxuw/JW963VV5yDPzFy40RU9SleQN
         qJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUMuONmGbjfYdYY+k3yo32g2M1JVwJ1+lya4C/rOGGuEVz/ykGwMXVC5WCPXJREh9IaYl0vw2BfKC0mdMVG89FYpKpyzJnTYiwLSTp8
X-Gm-Message-State: AOJu0Yw8dI21W5LVHl/rA/WREQZ3ws5v4W3gv426We+JFPLYkH6nkadQ
	plWRCmm1OPOPylNDvxd6pK/grmw+tHNuAyNKCEY7m8+oiPRc0VgYm5C/Zo5IUyo=
X-Google-Smtp-Source: AGHT+IGypC8X3VssPB1Zxes3RYodGg7gjq0wYrxRftiNHHC6jRUrujcAV5yWUC9GDuSyLxrx04sOyQ==
X-Received: by 2002:a5d:604d:0:b0:33e:7aff:a3a0 with SMTP id j13-20020a5d604d000000b0033e7affa3a0mr402528wrt.71.1712694767068;
        Tue, 09 Apr 2024 13:32:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m16-20020adffe50000000b0033e45930f35sm12370524wrs.6.2024.04.09.13.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:32:46 -0700 (PDT)
Message-ID: <d9c5524c-afd6-40bc-bf63-10df87bcd952@linaro.org>
Date: Tue, 9 Apr 2024 22:32:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: ufs: exynos: Support module autoloading
To: Will McVicker <willmcvicker@google.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, andre.draszik@linaro.org,
 tudor.ambarus@linaro.org, kernel-team@android.com,
 linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409202203.1308163-1-willmcvicker@google.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240409202203.1308163-1-willmcvicker@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 22:22, Will McVicker wrote:
> Export the module alias information using the MODULE_DEVICE_TABLE()
> macro in order to support auto-loading this module for devices that
> support it.
> 
> $ modinfo -F alias out/linux/drivers/ufs/host/ufs-exynos.ko
> of:N*T*Ctesla,fsd-ufsC*
> of:N*T*Ctesla,fsd-ufs
> of:N*T*Csamsung,exynosautov9-ufs-vhC*
> of:N*T*Csamsung,exynosautov9-ufs-vh
> of:N*T*Csamsung,exynosautov9-ufsC*
> of:N*T*Csamsung,exynosautov9-ufs
> of:N*T*Csamsung,exynos7-ufsC*
> of:N*T*Csamsung,exynos7-ufs

That part is redundant, you just copied result of of_device_id. No need
to resend just for this.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


