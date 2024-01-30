Return-Path: <linux-kernel+bounces-44901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0A8428D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BED1F29F35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7354C86AC9;
	Tue, 30 Jan 2024 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7SgwyRX"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F8605A6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630954; cv=none; b=UFUoUvLxHebd/GSBE0+rKKBBgc27mridu7wB9apdZJaKy+WUxKJ70mO+5FbVdQeclh80G9S3woCm8uakaQOQ+HY7Z0QBXB5m4kix4h1f9wP47P1oOOm1GTGtWXVyNojIi8fw9v9ID4sntMrNzfdPtD6hYFQGQK5ecRlf3h745hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630954; c=relaxed/simple;
	bh=XL3vQnpbYTlHEIia1p72Dxk+/Pv7y5c3/EuxSugjJns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOsydVk6BZfcOf+bdtjDnWFbWglVWWkwhkI7b8JvGf6weZh+Hv7ymBjaH0eYmMFnMcnVCcpxzJhYwdT1dbqVLIYWoVGblHXLdqdlvxoKTMB8SUXaUSMvMshyhD3icIkge08o7/39tRFn9F+Nc8BGwIDPzboN6O+cCNeC5EfvhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7SgwyRX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so4204103a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706630951; x=1707235751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sV5Z5NkseIugmJChnfpVQKK4FrMg6qPR+jRzi0C4ec=;
        b=o7SgwyRXRPLk65PDHaldkFNMEV/ZJO2Nhn0N6G3lXQNC1UM914eZ4W6kmJ5JFAWGN7
         pXkVm9DWLbVxvu6M8uMpg/nOHdQRWmLQme6jKxZ0UWvDDOa5uUJbC8+9lGOSAEOl3K5c
         lrORpDNz9aCj1+VqP50re2c8CodZJ7oZTxGF1j4J/y9TwlJIh2kYI+f3zFYNdp2uRxtd
         ZUIuf2gB/EcZM9GSSC+N5aEdnLK5AW+iLocmmrMvXQgy7Xwl3gbGQfRWLamtxv2VhZGR
         IRCpIQ8RYPOeg5QOhJpDZyzCePqoG2c3QGK6vlWyu7daj2SoV6pzx/vRRTiLIUuzuSsp
         /SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630951; x=1707235751;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sV5Z5NkseIugmJChnfpVQKK4FrMg6qPR+jRzi0C4ec=;
        b=mDcucWpK4LP+1zByZKPSqjfT8RY7/3/y9vcS+KphMXByz1NWhGNduHu1Tjb2HCxwhS
         Py3R6hEgUpFwyTXL3PxLqrmjsK0GnSH1WV1oiKTJ0d9JlRTA31vR+y0bUDPc4vqc8pEg
         HQ8AbFgbGZ3f3eQU1Nj781nOjwa70r3pJJ7kOe4opkEhTSDO6+1Y0aOiVmMZQScMPIb5
         bvomQE3fNbNaN+X54s9CVJxue4tR/tdt3u33OGqubefyR7fu1p1s0RngRr8Ks9dYyzqu
         i7p5eaYQJtx/sVjnobuZqVQqnAwPEgTvCz0Avcp9/diqK3yxRrlNGD3A/8BFKhbKNFRh
         7clw==
X-Gm-Message-State: AOJu0YzwXemAlwBQpn7J5qxA1aSOL9GH4qEDL3yJCuX8in71SuFFTebM
	0A2gyZoy7wSeTqa/tDEJX0ibshTseM2fDIyU0Jih+3l1M7GL8ep7u1WeYVNCsPM=
X-Google-Smtp-Source: AGHT+IG32zAykB2w2M5SNxicGdKq0vPl2xbms+AJ8dBhfx7ycQgibKojhX/9r+bWyY3DdFJ2QMCk+A==
X-Received: by 2002:a05:6402:3594:b0:55d:2ecf:eb1b with SMTP id y20-20020a056402359400b0055d2ecfeb1bmr7271257edc.1.1706630951236;
        Tue, 30 Jan 2024 08:09:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXT52O/6SYqanaIQA8bDs7wERtGDZ3J/0WYQ9+EkYPIiwR/yC8K5SBAvjIdfLkt8LbkogQnkDB+7bQaEgcSUP3r7Q3nCiNzkpeUdvX+La+JHKrZ6PcjpVd30PKUUJy+691laGJEUZZnfn2QxYpblqy/FaQ/T65ZThWlesrGn7innE4la5GUUTBjV/dNqd7zFW3JzVfz1TG2G06T2DI6iRUpV3TlxDJGUAozvpK6EaGH6Boq4vUDD5plY0olefADxE0wb9Hme1EZtbH4Qxu4jzJnh9n69U9X5VYVVddJjm0RTqKa9nFTdmPMivavSM2HybgFDkCUauuQ/aYOPdeVgNB7X1Ku4S5ZJOas65cEfd8KErDWZSkYYqB6ItxF3qepD3s6RvwY+o0=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id h1-20020a0564020e0100b0055d312732dbsm5002208edh.5.2024.01.30.08.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:09:10 -0800 (PST)
Message-ID: <9b0680b6-1952-41d3-82f4-88c60469dc3a@linaro.org>
Date: Tue, 30 Jan 2024 17:09:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT
 schema
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>, mdf@kernel.org,
 "michal.simek@amd.com" <michal.simek@amd.com>
Cc: hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 krzysztof.kozlowski+dt@linaro.org, bcody@markem-imaje.com,
 avandiver@markem-imaje.com, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 23:56, Charles Perry wrote:
> Document the slave SelectMAP interface of Xilinx 7 series FPGA.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
>  .../fpga/xlnx,fpga-slave-selectmap.yaml       | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
> new file mode 100644
> index 0000000000000..20cea24e3e39a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-slave-selectmap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Slave SelectMAP FPGA

https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/process/coding-style.rst#L338

Everywhere: compatible, title, filename, descriptions.

> +
> +description: |
> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
> +  parallel port named the slave SelectMAP interface in the documentation. Only
> +  the x8 mode is supported where data is loaded at one byte per rising edge of
> +  the clock, with the MSB of each byte presented to the D0 pin.
> +
> +  Datasheets:
> +    https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf

I am surprised that AMD/Xilinx still did not update the document to
modern naming (slave->secondary).

+Cc Michal,
Maybe that's something you could push it.

Best regards,
Krzysztof


