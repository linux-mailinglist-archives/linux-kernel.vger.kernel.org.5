Return-Path: <linux-kernel+bounces-44079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118CE841D11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD80E282798
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0354668;
	Tue, 30 Jan 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jabtirok"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBBF53E29
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601367; cv=none; b=aEuxO6NtAmYaDSS11x9pbrfmPXmhQjyj8CcyVh9lywN1U3q2bnQ+5pjGoZecdPR1uG7ad6FNzGdLagxlmyTT2IpHLitJBdfQGThSB/TOcWnPKq+pc1x1CK5H5FDMwzFjhDfulLfrPjp4y6ewVh1HlTar/uP1A/E1zQFvr2MdhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601367; c=relaxed/simple;
	bh=wHR2CwdXVam+dMxen82xzir/2gKlgyfk9KNbt22I+O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUNXJK2RzEsAJ80h4+Ph+/RrcyPXW8Go3KM8xKgaQdze/+8a84Y5yOOOaAmzOhmnfZc/P46AFVuH9UHffIaV8TkVZ78cypZFhveFhnIiQFAd4vv+JHv04FUufHnZecmuH2sQNUFUCyL9l2zyOPoQQWvjrzH/XvjwR2+T6ww8iig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jabtirok; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so3705147a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706601363; x=1707206163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ngybv8O9iGjxqt6rcpROCs4pkncSLIQiKAAur4B+yfo=;
        b=jabtirokNvFgtX1HOVMrgGHwJH+0S7lxe9NZTn1DjRFO4gecjR3R2pZSYoHJPloYNU
         CdyGlgaPWP6eqQ4sRNSrfysD3OA3RR9pvA3GAbuq1yC9+da4/ZNImwEozpXd1wjaHEpV
         WdLyCrJmy4bn6tyngxgS0DTuVv6GhyoeRuSJ4DwVTWBdmjRAKWq8/RLuik5nflLPXUuB
         llEpwZetew2YJ0YlsgTYTdvMpciTxFH7tW5OqYVkSY1slDkskcJUQEQqGcNhxLDFimZs
         S4dg3urJafwTRY4jbxLaTFLlanzNYTv1kLRHI9Sy2//51chJ/ZT1iUWxgae7UmiAM5+x
         zTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706601363; x=1707206163;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngybv8O9iGjxqt6rcpROCs4pkncSLIQiKAAur4B+yfo=;
        b=PpBQZqPQt10VAUJHU5qxymZClu8C1XVgrip5SCqrTTmRqc4egCvvo2Q0bJOJluBxLz
         4XB/yKBmuFtHzfvYgzjpwiKHGE9qgDAPgPllel7HIU0DTID5hatChL1kwtwesgFL1v4r
         g/epGE8RMj+imigZ8JwpR64EutAaypbMkwO+4LxUevbErY8niCWAIjrRtkFUjFBA6jHO
         qMjSKIHOYHGQ0qduh9MGAScEM7FcGdp4d/CmsnMPmKj5Rb4i0vpq2l7Smj+b6Zc+kpfV
         S7avlmz/+Vlh44Ptk8+ZjthXEgzfeE7xrnqQ8AVQbyTJiqFRl8+jmMrZHuZnuzNicgjK
         suiA==
X-Gm-Message-State: AOJu0YyqQzYLnR+Klo+0kx3dvl9sIgyf4nRNcufl4e1CbefzfQgCQUaZ
	80+XB3lmgXKNAzpmJ87Nx0pHQKqaYPpE9Euj8hRsWXvxcsnUgJQ4D77aDt4znyA=
X-Google-Smtp-Source: AGHT+IE46CauFpE6SAwlaWiivSPbB1RSG4Kax6PdpZuyNZjKAXh2tKtWGWtZ6rkn7MrohhkAUxxV+Q==
X-Received: by 2002:a05:6402:17ce:b0:55f:1ae8:2f1d with SMTP id s14-20020a05640217ce00b0055f1ae82f1dmr2044451edy.11.1706601363429;
        Mon, 29 Jan 2024 23:56:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402000f00b0055f1af929c2sm1205360edu.28.2024.01.29.23.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 23:56:03 -0800 (PST)
Message-ID: <4c6a7898-d300-468c-9e2f-13f639ca4407@linaro.org>
Date: Tue, 30 Jan 2024 08:56:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fpga: xilinx-selectmap: add new driver
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>, mdf@kernel.org
Cc: hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 krzysztof.kozlowski+dt@linaro.org, bcody@markem-imaje.com,
 avandiver@markem-imaje.com, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240129225602.3832449-3-charles.perry@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240129225602.3832449-3-charles.perry@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 23:56, Charles Perry wrote:
> Xilinx 7 series FPGA can be programmed using a slave parallel port named
> the SelectMAP interface in the datasheet. This slave interface is
> compatible with the i.MX6 EIM bus controller but other types of external
> memory mapped parallel bus might work.
> 
> xilinx-selectmap currently only supports the x8 mode where data is loaded
> at one byte per rising edge of the clock, with the MSb of each byte
> presented to the D0 pin.
> 
> The following DT fragment shows a valid configuration on a custom i.MX6
> board (pinctrl not shown for readability):
> 
> &weim {
>     status = "okay";
>     ranges = <0 0 0x08000000 0x04000000>;
> 
>     fpga_mgr: fpga_programmer@0,0 {
>         compatible = "xlnx,fpga-slave-selectmap";
>         reg = <0 0 0x4000000>;
>         fsl,weim-cs-timing = <0x00070031 0x00000142
>                               0x00020000 0x00000000
>                               0x0c000645 0x00000000>;
>         prog_b-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
>         init-b-gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
>         done-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;
>         csi-b-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
>         rdwr-b-gpios = <&gpio3 10 GPIO_ACTIVE_LOW>;
>     };
> };

Drop that example. First, it is not correct. Second, a correct one in
bindings is enough.

> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---

..

> +static int xilinx_selectmap_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_selectmap_conf *conf;
> +	struct resource *r;
> +	void __iomem *base;
> +
> +	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
> +	if (IS_ERR(base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(base), "ioremap error\n");
> +	conf->base = base;
> +
> +	/* CSI_B is active low */
> +	conf->csi_b = devm_gpiod_get_optional(&pdev->dev, "csi-b", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->csi_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
> +				     "Failed to get CSI_B gpio\n");
> +
> +	/* RDWR_B is active low */
> +	conf->rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr-b", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->rdwr_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
> +				     "Failed to get RDWR_B gpio\n");
> +
> +	return xilinx_core_probe(&conf->core, &pdev->dev,
> +							xilinx_selectmap_write,
> +							xilinx_selectmap_apply_padding);

Totally messed indentation. Please run scripts/checkpatch.pl and fix
reported warnings. Some warnings can be ignored, but the code here looks
like it needs a fix. Feel free to get in touch if the warning is not clear.

> +}
> +
> +static const struct of_device_id xlnx_selectmap_of_match[] = {
> +		{ .compatible = "xlnx,fpga-slave-selectmap", },
> +		{}
> +};
> +MODULE_DEVICE_TABLE(of, xlnx_selectmap_of_match);
> +
> +static struct platform_driver xilinx_slave_selectmap_driver = {
> +	.driver = {
> +		.name = "xilinx-slave-selectmap",
> +		.of_match_table = of_match_ptr(xlnx_selectmap_of_match),

Drop of_match_ptr, it leads to warnings.

> +	},
> +	.probe  = xilinx_selectmap_probe,
> +};

Best regards,
Krzysztof


