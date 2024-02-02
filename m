Return-Path: <linux-kernel+bounces-49795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C474F846F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4515B28841
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4172913DB9F;
	Fri,  2 Feb 2024 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2+/1dcw"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8113D506
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874794; cv=none; b=aGn3NzWFYbkhIADRwsNhoEUV7J6agrpSM2XCI43QK7qGRVzZH0EkVZIH3f5zSvqKtRXdq6dvOMNInvz4t40s7TAmb3XHeF/sgteTDJ7s43nz0tqpCj5e/lmGKRwMMz3OsoOzvlLUDKG8HwfruJAhbTMmnbvr3bWCmfAK/0aU1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874794; c=relaxed/simple;
	bh=n6JtaFEP2tyKk/5MIfBw1Ls0utZbcjt06vqrpTqqByk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwW9IZCPZuWzcgEo+bQZ/MIX5epfmncNPyhT5xqD6nhkd+FLdxb4POlSflJ4JE1aayRv7SKqteHsscWurvscs4B5v9z2D5krgezhXjEMmIqwe0cV6JP8yEjWz4duaucWauVbP7XCyaSizVuH/9yMDMO7fzrMTyy0/pJOMwa2tII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F2+/1dcw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55c33773c0aso2733311a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706874791; x=1707479591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=roZsoLEvVzs0KyE8UN+10qmIx/OPs886cpDftSyVhUo=;
        b=F2+/1dcwk1qGv94hZdsyqSNjgJo62g+7VgJ6Stv0RyaSO2Eykdud4d2vW3H+uJRO2C
         8UAAJ3amF4c7aY4oa5ne2rtOiXA3AP6aNKAc2oyG/eBfWsM735e+tUKp/q1CtGM2EI+G
         eUxZggaIajb5J8MbhcV7K+dtWXwb3WA1TZzbM7pyN0kGxo2EuBT1Tik5Xee2pMysJU/1
         VyIU48IkJdYMkeB3LH+JvVgH0w0nI+tzpBgFaZVcCIzGgOfdzDMGiLbnVEMTv1vcAire
         aKpToZAikKiwnqqWKbWw1vvsyGRtUi5jKvBLOvde7bfUSoxM7IWZg0O/oYym4OlaKSK0
         23tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874791; x=1707479591;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roZsoLEvVzs0KyE8UN+10qmIx/OPs886cpDftSyVhUo=;
        b=H4mH6PkscRHe2mV9sMqJm/IkwgfvmqjTyZhcr//dvW5S54aQx26qqDl3TPiyS/am2P
         BCod3WE+1BAhadKdbNka1tY44pFENlUGjICJL3fI/32S6PYZSHJttJJ9anVpvzStF2pW
         RcviNpFoEj3WRh6UAcfxyzJfMCNoSuIODcvlxLWS2r9nOuWBQwTRKSTsFC9dpFoYJ/eL
         +VkoKw1r1II8J+M6NfzHAp2Jzj7fIX9VjHT5jVuHjBjFLDcD57rWgdGyQ4l0EaKWf2YX
         OO0fWn5D2rzTjDbTYz9LkaWghbWFxaKoIgqG9U+OvxF7Vb5Jq3RmWMRnq23U/sGIt6FV
         QqXQ==
X-Gm-Message-State: AOJu0Yy4U0sqoHWttR5dfAavTENIHwHGlbj4wpGmnd5q2l/HBs9KIYO6
	i+44cEpTPXIaLIbs40CpsFqVobQtVN5E9BZHYGdQEFC4MslhRwRCGEk7Nipt5+o=
X-Google-Smtp-Source: AGHT+IHVErU8wGw9zR02zQa38tD37/I5gO5Krfb2rglKMYGkA2JB+MqF/QgrvDnsnGdnLlCHD/PMyQ==
X-Received: by 2002:a05:6402:26d1:b0:55f:a309:172f with SMTP id x17-20020a05640226d100b0055fa309172fmr5665398edd.15.1706874790763;
        Fri, 02 Feb 2024 03:53:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW6619RC2NntByOd8xB1BqUFRMlRKv8rKLBgq1Ri4E4AFQavIctFLfHjRXGmUOvYOCC3plwkU+nfK2TRx11nJh96o8ws7viY/QuNExIbtUXKS3atGY+1Fj1ndNFhGm8UNW39V9690lMkvacYFipUpl14gSiaaIatqBb/TtybUh8RMVuSyxIEJL15R3DmR12cqF2UYPNYOLiLDY46Zv/VZqHbxqA7n8L5fn3S7v4aVyZAiFuByQXHR9SWBP9FuE=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402091200b0055ff4a88936sm443243edz.41.2024.02.02.03.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 03:53:10 -0800 (PST)
Message-ID: <5dc251d7-a6cd-4b96-9392-b3f99505fc4c@linaro.org>
Date: Fri, 2 Feb 2024 12:53:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/4] MAINTAINERS: Add maintainers for ZynqMP NVMEM
 driver
To: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
 srinivas.kandagatla@linaro.org, michal.simek@amd.com, kalyani.akula@amd.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20240202113843.17999-1-praveen.teja.kundanala@amd.com>
 <20240202113843.17999-5-praveen.teja.kundanala@amd.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240202113843.17999-5-praveen.teja.kundanala@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 12:38, Praveen Teja Kundanala wrote:
> Add maintainers for ZynqMP NVMEM driver and driver document.
> 
> Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..b3103e03015e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24233,6 +24233,14 @@ M:	Harsha <harsha.harsha@amd.com>
>  S:	Maintained
>  F:	drivers/crypto/xilinx/zynqmp-sha.c
>  
> +XILINX ZYNQMP NVMEM DRIVER

Are you sure you are not causing another Electric Boogaloo? To me, N
looks like before S...

Please read carefully entire top introduction for this file.

Best regards,
Krzysztof


