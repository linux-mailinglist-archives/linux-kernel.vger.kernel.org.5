Return-Path: <linux-kernel+bounces-88331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C93E86E01A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C711628278E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD36CBE2;
	Fri,  1 Mar 2024 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK25Cl2s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1A6BFC9;
	Fri,  1 Mar 2024 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292137; cv=none; b=AkJ2Scn2c++GNzmmXITSgbLTiRNqky0Dqcn7ngBuH4uxafBNKJGLJrDFVI0BNCJWw119xi/h2cS7riwwzPCLKWlW/CjFNzKscIJC7GOYLPeqKFm1E0z6ZtuAP18NfuZIEaKghmkE608LGIfyyujk1zf9WCwKTQ64h0ex3iWQIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292137; c=relaxed/simple;
	bh=NXVBa7Fp4Tdl6hTdg8sQl4YDyiDbHC+b/d8yO36MsaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h/jHhIjTjHPW52ggMQzWaAj3XGnxuVObS4KMtJ7mebqqKBaszmSyhsPpV0bA9ZixD7pMF4Hu3UC0ijDA2KPdF6c58gOnyC5ipPTANHWSz1Lt3deqxeQ4ZfGpjbRQy9qJHLKTUDAgBlCM5eib/y/OQOD/E7MZ3lKT8HZP+I9y/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK25Cl2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A1BC433F1;
	Fri,  1 Mar 2024 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709292136;
	bh=NXVBa7Fp4Tdl6hTdg8sQl4YDyiDbHC+b/d8yO36MsaQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=bK25Cl2sUuRoVzWih8tUNCpVVQNGmbHG0PVum15/L8x0pQjECYc4tEjp9AN5tjHYD
	 sZ2H+yuZnGPgdGKUgNz0rnsibn28qZXh9pBuH8c6k/PepbBtZ/ViYXKuNdqLizARRo
	 2mvvUmjLzYc4RXnL2isBSjWVCG9gJ0Uudvb7SRhIGz2DG9BHaPlKBXxNnumDHC9RMj
	 7gvOWJfeec2S705pFqmA6Grhp/CBVVfFe8rUkr3/YiDR78wB7icDGePJst7xryReJx
	 6K2AiHVeSiRS3xqdIlurxTl159xIl+lBi8NSNtYQYrSIoWAct6Ko/TTnyu/aVmZwQC
	 1We7ZI3NQTGmQ==
Message-ID: <f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
Date: Fri, 1 Mar 2024 13:22:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: omap-gpmc: fixup wrongly hierarchy of the
 sub-devices
To: "Brock.Zheng" <yzheng@techyauld.com>, Tony Lindgren <tony@atomide.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the patch but can you please re-send the patch in plain text format?
Please refer to this article for more details.

https://subspace.kernel.org/etiquette.html

On 01/03/2024 01:52, Brock.Zheng wrote:
> On TI-AM335x，my FPGA under GPMC local-bus can not work on 6.x kernel.
> 
> GPMC <--> FPGA  <--> sub-devices....
> 
> I found that the platform sub-devices is in wrongly organized
> hierarchy.  The grandchildren are now under the GPMC device
> directly, not under it's father(FPGA).> 
> Signed-off-by: Brock.Zheng <yzheng@techyauld.com>
> ---
>  drivers/memory/omap-gpmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 80d038884207..1f2568e43086 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -2175,6 +2175,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
> 	int ret, cs;
> 	u32 val;
> 	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
> +	struct platform_device *child_pdev = NULL;
>  
> 	if (of_property_read_u32(child, "reg", &cs) < 0) {
> 		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
> @@ -2330,11 +2331,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  no_timings:
>  
> 	/* create platform device, NULL on error or when disabled */
> -	if (!of_platform_device_create(child, NULL, &pdev->dev))
> +	child_pdev = of_platform_device_create(child, NULL, &pdev->dev);
> +	if (!child_pdev)
> 		goto err_child_fail;
>  
> 	/* create children and other common bus children */
> -	if (of_platform_default_populate(child, NULL, &pdev->dev))
> +	if (of_platform_default_populate(child, NULL, &child_pdev->dev))
> 		goto err_child_fail;
>  
> 	return 0;

-- 
cheers,
-roger

