Return-Path: <linux-kernel+bounces-52293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C4E849665
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52EF1C2254E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FEB12B99;
	Mon,  5 Feb 2024 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiYS8Wnh"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533E125CD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125154; cv=none; b=R2CLbJnIEhO4HihVFtzniq7wCsHE+CBI6uvsyha0U2xb5XXb1pzT/brb4pN6QDQhe7XQGaPygBGB4QZkRdjAx27QqS/elQQubwlftcU3VX0q48Pw3wP1Nk58iQrKOODiOUda3PXMl4+cUHMYwYhRXfUb4+NaYHAw0N1udhAlKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125154; c=relaxed/simple;
	bh=r8g+eHSgjiF9g0nmTgJ4mQPRVegtLVu4y9NnuyDYMr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRfqwgXfMzQwUg2HLWJmgj2PLGV8pWXWH+R5/lcMpCdIypGR+7vA9s8v11DhNhLc7yOMsUTCvchJ9yQ299bMdBocKrBDzWGk/uZsCT0a5wktcFSuJ5ifgjVPMV+iiOhBh3fqcJ5VvP1NeKPIbJ8reMD41ju2IeQJGgN1+q5I+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iiYS8Wnh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a372a3773a5so222942266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707125150; x=1707729950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QV+XeC6ubFiQQJ74+6ol4pUfjV2yc7chI3YNp7Olo8=;
        b=iiYS8WnhjBnz0FwZNXl+K3PprBbOC3mR71HUDOc1N0sAPbFKQ5D+N0M6JWY5adXcdU
         dL46/RHYMIpgaZlCyT20xLwa7nKQiCw1uAj3iE15y8Uh2lNBY6qN1ORtVUXh2Hqfph2X
         bchBpw/G69TivfZvzOrwCal8dgSoRogxd97nV/J0QOPz6wpozKHP0nc2U8eUBXQU4JYq
         PpyoSWYwI3iwSElgxPUHBerHOs2UYUIj7sz207Lqd0hg888j5zadEdoNtjKRaP2u3Wsf
         e8c+koA/EDmA/ZcD5DuwKZYl+/SBeZDL+qsKmlGcBojyMwpWRSpW+xy2hNM5/AtYvrjg
         JRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125150; x=1707729950;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QV+XeC6ubFiQQJ74+6ol4pUfjV2yc7chI3YNp7Olo8=;
        b=RZuQZ2xgNX3eaCC9CBJkoGMmr9382Oj/J0Dy8LXwubeq5sroiEDZX/sX3NKYzrm3xG
         rLlcWc9gNKil+jNurTn35rGdWw016nUVHHtFbvEKFxr0hQfO4IyGVpNJ+sPx+ZsA5V81
         IO4EW/J0YrwnUyXV//7SQW6OLYV3wwldsSuuF65/XaI6j4CIKHPwWNwOJH9IgznUmAvt
         QU2QwuliYnjw2+35vzVInguPiiXLTEXEGA+xo4WCLXQGc0loU3tY4Q+yzYIlniZSpfsL
         DTj4a+ZhxxTaPwENX+M114Uc+9dpx+6oDt5qNrOTx396uHd3JmwXFgz5KE5Zxn6Pq3fT
         50oA==
X-Gm-Message-State: AOJu0YyFzqbc55wJQXRx8eexE6UJFkq5I1gf9gKHjrzirnmDvH3QLvyX
	x8ngzAN1YI/BPAwDRvRNu4C5OiAckgipkilMl/LLV/pSX+qKI6za7sLdjS9dfHo=
X-Google-Smtp-Source: AGHT+IE2MQhoAt89scFHj/wrtjFO4zJ9cQnhg7w0vM91XGipr+7PW8DTnaFfV0jSE7oJzGm8lG0Tzw==
X-Received: by 2002:a17:906:2811:b0:a35:8596:cdc7 with SMTP id r17-20020a170906281100b00a358596cdc7mr6875088ejc.31.1707125149973;
        Mon, 05 Feb 2024 01:25:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDFi3Cn/azmODAVzhSKcUV6kDomsUgIBuf8gO8Idw7Ox6Y2wDURHVe9d5J9J+yu4RbzHMumjoeFtuEazZc3aF6SxYHB3wqPnin26XVRJwiDPqzhHjoi2RTGER37STwrtpBvesvDK0qMKzzBsGzV2auSyLuR709eJR6hKcurbm/CXerHokrD2+rodCqCgWFtBHogXSiKiZKc9aSXY/5ghC/YTHD9F3QizreGk34IJvuWX04nwmpK0IzsuPRi0Cw0OHdEcLsBbXuVlD/NZwMI5nrRB6/2xvBYCy1fURaaFOo09lNcqErgps2jjgumv9P0G4kcKqnF6DdX+lT3xZTs6G12CEr9GeUBOxD1b8U4NlszpyeN9JrfJdPz+uUtQSZ84KF1UYHTPKLInygcLv127xvVjVAw1b8YoUMpZukMRcQtHzC53ouV3YTIIFNaCOQolmMznovEy+oK72cx/Rfyt0gVycTeukcEmkbivTggdpsFtENPa5s5FBg95QabD3PsBq+UoZ5mzuEUukaL6PQuHoGx1stdBilgUsLC+mg/4cvfYVkHc9mtJLEplAehDk0TmyW7DXmAcOnrksEeYowSJvvFIEr4bb38MxTrBJ16ex45ZCGYw3nWI2UgkX8aItJxijXfOMJJpfdInQL/h5ECRIjJ9BrAwwHGH84ZbVXhYCXzRmPRFcNfPq30NsuFA41EhRo8p6mwHNVTnOL
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id tj13-20020a170907c24d00b00a370ea0ab84sm3780825ejc.124.2024.02.05.01.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:25:49 -0800 (PST)
Message-ID: <65097032-74d4-4617-8ef6-e1f76b41cce6@linaro.org>
Date: Mon, 5 Feb 2024 10:25:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add 8qm SMMU information
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, imx@lists.linux.dev
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240202110511.135d26b7@kernel.org>
 <Zb1sijexWGLG5gcH@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zb1sijexWGLG5gcH@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 23:28, Frank Li wrote:
> On Fri, Feb 02, 2024 at 11:05:11AM -0800, Jakub Kicinski wrote:
>> On Thu, 01 Feb 2024 15:22:40 -0500 Frank Li wrote:
>>>       dt-bindings: mmc: fsl-imx-esdhc: add iommus property
>>>       dt-bindings: net: fec: add iommus property
>>>       arm64: dts: imx8qm: add smmu node
>>>       arm64: dts: imx8qm: add smmu stream id information
>>>
>>>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  3 ++
>>>  Documentation/devicetree/bindings/net/fsl,fec.yaml |  3 ++
>>>  arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi  |  6 ++++
>>>  arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 41 ++++++++++++++++++++++
>>
>> Any preference on whether all these go via a platform tree,
>> or should we pick up the net patch to netdev? I guess taking
>> the DTB via netdev would be the usual way to handle this?
> 
> Supposed dt-bindings go through netdev tree.
> 
> without dt-bindings, just DTB_CHECK warning. No strict dependence
> relationship between dt-bindings doc and dts file. 

Please make it easier for maintainers and sent entirely independent
patches for different subsystems in SEPARATE patchsets.

There is no dependency here between anything. Combining it, OTOH, brings
the questions about such dependency and makes it a bit more difficult to
apply for each maintainer.

Best regards,
Krzysztof


