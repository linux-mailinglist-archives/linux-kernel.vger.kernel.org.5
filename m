Return-Path: <linux-kernel+bounces-105503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6787DF68
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC631C20916
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858A1DA32;
	Sun, 17 Mar 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoV5SjsJ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23751D551
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701706; cv=none; b=qhN2u2aOkwILwoAM2J6Ca5Ys3VnsbirU1AqUXU8zB7LLb/O5yggbvr7TDDUExPqD277/xrZ2GzfT2MrAMW4+v6yJRgGpDcp88kOZ/m2Ec5Q7XWTWb2eKdeGqfUfoJIpqGh4uyiWMAOEjzadKgrwsYGSfSRuTLsLbtlPIzqjrKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701706; c=relaxed/simple;
	bh=2Xy9ZyoIUnmBKgxo1xmsPG8oHaIcb8lxmxyk7KJ0h0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCs16qoIAJCad9FaVQxQHIO+/Ecn8haSCV4wfUj5rKPl90rTITkImVLm1m/xc+VI7rbJWkGyGC6b9pgYQ5Xa/2m0lCAMXn3WKuKj91LEWOlVvJL4VRSnr6p9ebOMcRzY5HXQuzieXZMR/I+egfLkt4YNPywFd1e0CCJQUenhmtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zoV5SjsJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4675aaa2e8so407104066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710701703; x=1711306503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRHG64ehdYr777M90Q2L8vb6DZOoH4ILszuVOY+EHqk=;
        b=zoV5SjsJlg9MD5Y9f62f33rFNug6SzPO0V+ms/pYMMNIZrHIMweKKro3E+aBXqWTuA
         rRc/2sSU8sSp6ti/Zo927KsRXzwoSKGt+K8E2vnY0nXk4ALorgoY7ylY/QZg2IUIi8+t
         U5brfABDbt9vZpnoEv4fgsjbp9iSfTx2LRQJ2NOaMKHeIlGHKk3KyAdgI/U3f5jTYdo+
         +LD01WLDG+CUoxvLK53noY4lSpd7c7AuaZiSZeb0VSDUlS54wWSfbV/zSDt8wIvEPBCC
         cBNTwesBK4OsTDOSW3Ag/6WHpjviYh22vs9vwv9hVtWo3Tnk8L34sKtz8uU0urPGxE/K
         JJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710701703; x=1711306503;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRHG64ehdYr777M90Q2L8vb6DZOoH4ILszuVOY+EHqk=;
        b=PTIAuPzG25kI0xs4TwSHgvclJe8x+qkB3Xzk5B/C36kJCOqlmwegQRyg1fSUV3mmP8
         CEIFAE5AOu6PK6cFbm8PvX+5YNIf/jUGV9QENgl4nKeyLbd+AuK+b/hw3mEYio2CJ/i/
         QXH9DsAYAKpe2zmmjOCnuwlJxsaanZThNIaCc9SNlMOwGadmRFg4gqVpXyusMn3HN7pG
         px8UDrW9joNKCfHVsO0dc5mxOe0OPmKVAtlxtxIT4vjvLb8JuHjYxGqASwSBLxmKQmn+
         BxLM7oYEO7vDjehYzkAvJMHILDfLPr6+8wkxNMvoFv5qXEHO5/DKxYYHhALhks0X0wVR
         R7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtFk4KHAPg+t+k7/lWF/a7s0wrqYJ28SfuxmwtpTfaq+i87rA9PFeRrxqgw+9Tm15DE3IanxSI8cxFKCHLNXKDadSD2sJJaCd2O2Nw
X-Gm-Message-State: AOJu0Yz4K0SZqznpg71RBfOiUpGYAJ5QQIbYR3EKIVV07t2WANDMajdG
	rMC51LrGpYW0aVd9Or0QLRsZMskwpMoyXaSu2QLT0ozHeoogYaVzZJbKmmfwNd4=
X-Google-Smtp-Source: AGHT+IHQ8pGbdZZ2bgMxMo1V5d9jZyq9ImqiOS9bbZB660Rx+BC1MRyHsofGAYzBs8xd5INg2jqUgA==
X-Received: by 2002:a17:906:ee8e:b0:a46:bdd8:64ef with SMTP id wt14-20020a170906ee8e00b00a46bdd864efmr783037ejb.19.1710701702995;
        Sun, 17 Mar 2024 11:55:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709067fd100b00a466782e438sm4004900ejs.139.2024.03.17.11.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 11:55:02 -0700 (PDT)
Message-ID: <db6f16af-e715-4ff5-84d6-2d85d62d7c0c@linaro.org>
Date: Sun, 17 Mar 2024 19:55:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drivers: remoteproc: add Versal and Versal-NET
 support
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-4-tanmay.shah@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240315211533.1996543-4-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 22:15, Tanmay Shah wrote:
> AMD-Xilinx Versal and Versal-NET are successor of ZynqMP platform. ZynqMP
> remoteproc driver is mostly compatible with new platforms except few
> platform specific differences.
> 
> Versal has same IP of cortex-R5 cores hence maintained compatible string
> same as ZynqMP platform. However, hardcode TCM addresses are not
> supported for new platforms and must be provided in device-tree as per
> new bindings. This makes TCM representation data-driven and easy to
> maintain. This check is provided in the driver.
> 
> For Versal-NET platform, TCM doesn't need to be configured in lockstep
> mode or split mode. Hence that call to PMC firmware is avoided in the
> driver for Versal-NET platform.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index d4a22caebaad..193bc159d1b4 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -323,9 +323,12 @@ static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
>  		return ret;
>  	}
>  
> -	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
> -	if (ret < 0)
> -		dev_err(r5_core->dev, "failed to configure TCM\n");
> +	/* TCM configuration is not needed in versal-net */
> +	if (device_is_compatible(r5_core->dev, "xlnx,zynqmp-r5f")) {
> +		ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
> +		if (ret < 0)
> +			dev_err(r5_core->dev, "failed to configure TCM\n");
> +	}
>  
>  	return ret;
>  }
> @@ -933,10 +936,17 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  	int ret, i;
>  
>  	r5_core = cluster->r5_cores[0];
> +
> +	/*
> +	 * New platforms must use device tree for TCM parsing.
> +	 * Only ZynqMP uses hardcode TCM.
> +	 */
>  	if (of_find_property(r5_core->np, "reg", NULL))
>  		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> -	else
> +	else if (of_machine_is_compatible("xlnx,zynqmp"))
>  		ret = zynqmp_r5_get_tcm_node(cluster);

That's poor code. Your drivers should not depend on platform. I don't
understand why you need to do this and how is even related to this patch.


Best regards,
Krzysztof


