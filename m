Return-Path: <linux-kernel+bounces-131121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBA898353
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD1128A2DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F937175D;
	Thu,  4 Apr 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+WbSUfJ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F686027D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220212; cv=none; b=uZGYciAajBe0M1NcGiVPSdwqs55VNzq2oND60KvvzX4/kfzZ2kI4G6NYh6nTkaNOHAjzIQaBvWg6V7QMwvkm3Wwj38Zmzpn/8r5saalOStyRzX3p1HGFNhMW+yWUZkpEx6+50H5hSUHtxul3hZlV4qrKwMTNRUf2XigJ7JJ86ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220212; c=relaxed/simple;
	bh=Iac66xVtNYHXo8go2JKEoVRF+t+iIvpH4kE7QbHrewQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K95PcRs5pQiGWG4i5++UO1kkU34OIWKs+rECYzgnT+89MNHd/bTkHjkLCkeRQ2BgqwBLfqZ3/97aIEPdJO8lVWBmWZpzVlF45Qu9y3oQM7nEGD5dviqpeeUf30K3VLk1fy5Ueo29UCBpTig/Jt34u3tL8f1xVT2w0ZE1zv942Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+WbSUfJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4156a29ff70so5130065e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712220209; x=1712825009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=19jGzhVrD+fzZqYJDEGSgNzPhjsllfP6NWI7lu8VmF0=;
        b=W+WbSUfJJk7IeMVXi9AushNm0fxpvzvOD8KTLJ06w4QowxK+jNLpm8RKAKhyK7k/oG
         xitR9RTDz++hK+SwI59y02Cy9N/DyL1uZkFhSJawNhkEX/4aSh66Nt+eeCu/VvuBFWdX
         B7UVakmGyMWabVVc0rMaIdyKNHcSQfWu/sIN7Z3uyRC3OynrbLW1l+5xlLK5+BAsslKA
         iEhh7JGd4GC5UQggWQ/NOh0O4RsVRwRCZMx4kjsq/4JCHJ3qeh7T1CwHCSHUDyomSoUW
         Nm4Uf6cQQmMdUgjNQ8JlDAJPUPLAMIT7HfjIBBDQ3UjQSBPaK6VbFEiB+OFI3mzDcc8W
         yO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712220209; x=1712825009;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19jGzhVrD+fzZqYJDEGSgNzPhjsllfP6NWI7lu8VmF0=;
        b=lzFerHURHp58Qjtz7GZww2XGWk1EewE30SzIrhsnK4idYjzoyMoW6Dodz1+GRfmiWC
         mNTIjEQbRcSTgu2dCfUVN9BK6onUHHB7mK3kcFYK07ClOqAXwomQkuazGAYKeVXNU/YK
         R6l6T+yl+MGiDxZ2/qC3RYtDWPkWLkdwGTEU4PWtTXMDNwmmnPPHYum8vJsFBULU++3+
         GKTrr7Wf94cfwK0+ieIs9CMT5IgSRXg09xzeH6HRmM6hsdCgQ+0PGvLK++lWpgIlPOsq
         9ZZr7IezhA8oqvekeHgbab7xG8VlHtT+uinSHdingM+jk+Jg5rNusskdWLEOMWL0p9Bo
         W12A==
X-Forwarded-Encrypted: i=1; AJvYcCVyuoRCndaYmvoFPODyLXiDPMCJHAAiJwyUaIB/e1bj0hPlhDLfBhDurlA4JYAO6kQ2IZnCHHngqU0LOig8S8BACK2ZjiWR02/n1int
X-Gm-Message-State: AOJu0YwBjnhfrr8D7Klob9Hz5ZrEW+bYUdp79woXGloW+uGhYtdn6DA6
	wtdxc0JoIjgA7WcFLRx0m60uO1F5mznNXx9uSkE9kAoo83/lz5bOukR+g+vs+2XyWuu3sBu4Bkw
	q
X-Google-Smtp-Source: AGHT+IFRW8UR0zBXWn0krYERSz7rUcxepm1DXmUHuJ+GnlPyVRpAzvYtJ5ldONSjqRJnwWdEZWACuQ==
X-Received: by 2002:a17:906:6a25:b0:a4e:7c40:d0f7 with SMTP id qw37-20020a1709066a2500b00a4e7c40d0f7mr1290804ejc.25.1712220186871;
        Thu, 04 Apr 2024 01:43:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ag12-20020a1709069a8c00b00a4e222225ebsm8829782ejc.15.2024.04.04.01.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 01:43:06 -0700 (PDT)
Message-ID: <18eb0e55-38ad-44f9-90b7-1917d8c0d5bb@linaro.org>
Date: Thu, 4 Apr 2024 10:43:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62p: use eFuse MAC Address for
 CPSW3G Port 1
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240404081845.622707-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240404081845.622707-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 10:18, Siddharth Vadapalli wrote:
> Add the "cpsw-mac-efuse" node within "wkup_conf" node corresponding to the
> CTRLMMR_MAC_IDx registers within the CTRL_MMR space. Assign the compatible
> "ti,am62p-cpsw-mac-efuse" to enable "syscon_regmap" operations on these
> registers. The MAC Address programmed in the eFuse is accessible through
> the CTRLMMR_MAC_IDx registers. The "ti,syscon-efuse" device-tree property
> points to the CTRLMMR_MAC_IDx registers, allowing the CPSW driver to fetch
> the MAC Address and assign it to the network interface associated with
> CPSW3G MAC Port 1.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> This patch is based on linux-next tagged next-20240404.
> Patch depends on:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
> for the newly added "ti,am62p-cpsw-mac-efuse" compatible.
> 
> v1:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402094200.4036076-1-s-vadapalli@ti.com/
> Changes since v1:
> - Since "wkup_conf" is modelled as a "simple-bus" rather than being

And maybe the hardware representation is not correct? What bus is it?

>   modelled as a System Controller node with the "syscon" compatible,
>   directly passing the reference to the "wkup_conf" node using the
>   "ti,syscon-efuse" device-tree property will not work.
>   Therefore, I posted the patch at:
>   https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
>   in order to add a new compatible to be used for modelling the
>   CTRLMMR_MAC_IDx registers as System Controller nodes, thereby
>   allowing the existing "ti,syscon-efuse" property to be used.
>   Now, "ti,syscon-efuse" points to the "cpsw_mac_efuse" node within
>   "wkup_conf" node, with "cpsw_mac_efuse" being a "syscon" node.
> 
> Logs verifying that the CPSW driver assigns the MAC Address from the
> eFuse based on the CTRLMMR_MAC_IDx registers at 0x43000200 and 0x43000204
> to the interface eth0 corresponding to CPSW3G MAC Port 1:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/9982c6f13bf9b8cfaf97e8517e7dea13
> 
> Regards,
> Siddharth.
> 
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 1 +
>  arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 7337a9e13535..848ca454a411 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -696,6 +696,7 @@ cpsw_port1: port@1 {
>  				label = "port1";
>  				phys = <&phy_gmii_sel 1>;
>  				mac-address = [00 00 00 00 00 00];
> +				ti,syscon-efuse = <&cpsw_mac_efuse 0x0>;

Why this is not nvmem cell, like or efuses?

>  			};
>  
>  			cpsw_port2: port@2 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> index a84756c336d0..df9d40f64e3b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> @@ -18,6 +18,11 @@ chipid: chipid@14 {
>  			reg = <0x14 0x4>;
>  			bootph-all;
>  		};
> +
> +		cpsw_mac_efuse: cpsw-mac-efuse@200 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
> +			reg = <0x200 0x8>;
> +		};
>  	};
>  
>  	wkup_uart0: serial@2b300000 {

Best regards,
Krzysztof


