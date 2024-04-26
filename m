Return-Path: <linux-kernel+bounces-160003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE708B378C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D24C1C21704
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0704145B0D;
	Fri, 26 Apr 2024 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="aJ1kbKMr"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF613E88A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136086; cv=none; b=SPHARv28wqXV9YppFhv/+pIBj0qQO3KV4BXgmRRzdooysBcIxEwLCEyyp/lKhmnmpe8Vj7zeWB8PRywaeP0zQ8lfoNynvHlx0qm5qeiA+7YvwM1aTSEIT0jeFOsESxDwa5XScrm1Xlvlsi0E7bHvfTcZoKEj76nP/0XcCwP3mN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136086; c=relaxed/simple;
	bh=kxF2Dn/2+RT2PyPXlDva2okUem+fGodZnf9w7kPdU/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YTk3qFNwfW6S9kNx+wLPT4tZNtXKGBaV0DbSDOfNYzqjxyEHyAx/SiNGLF5yVXo+2BW9oZeU8lFHDTRfQVQ06cddE2isHCILEyZYx2h8BobND+ASAoHjXeODxzSPhrMN+8UUTnqVIk5wVh7Oc/yFZhIdGXsxqsmrIzgbO5lwFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=aJ1kbKMr; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1714136075; x=1716728075;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kxF2Dn/2+RT2PyPXlDva2okUem+fGodZnf9w7kPdU/o=;
	b=aJ1kbKMrzRn0Dzm9x3Q8jzjUxdi3gsqCkuCJRNFBhl2dA9p0F3GrCqKJOLmMf/xK
	n/Sdt8FDQ8f5QKzqUK1w60W3MWpyDJw22j13sNVf++9uuILyMv4mw8mtuGuUZWge
	IKIRm5HauH4dQ2EVfcyxgCstID/SDNTQW8WivEGbXP4=;
X-AuditID: ac14000a-fbefe7000000290d-af-662ba40bcf64
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B6.13.10509.B04AB266; Fri, 26 Apr 2024 14:54:35 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 26 Apr
 2024 14:54:33 +0200
Message-ID: <1b87b00f-9fc2-47b2-9e81-4a391458f031@phytec.de>
Date: Fri, 26 Apr 2024 14:54:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add USB-C
To: Garrett Giordano <ggiordano@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240425152558.485763-1-ggiordano@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240425152558.485763-1-ggiordano@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWyRpKBR5d7iXaawe39EhZr9p5jsph/5Byr
	xfotv9ksln+ezW7xctY9NotNj6+xWlzeNYfN4s2Ps0wW//fsYLfofqdu8f/sB3YHbo9NqzrZ
	PDYvqffo725h9fhz8R2rx/Eb25k8Pm+SC2CL4rJJSc3JLEst0rdL4MrYvX4PY8FP3orGnlfs
	DYxPuLoYOTgkBEwkOm+wdTFycQgJLGGSOPr7NTuEc5dR4t+/Y0xdjJwcvAI2Ek9vL2cBsVkE
	VCVav95ihYgLSpyc+QQsLiogL3H/1gx2EFtYwEti1ofFYINEBJYwSkzqXAi2glmgjVHiycMD
	zCCrhQSsJC4eNwBpYBYQl7j1ZD7YMjYBdYk7G76BLeAUsJaY29DPDFFjIbH4zUF2CFteYvvb
	OWBxISD7xSWI4ySA7GnnXjND2KESRzatZprAKDwLya2zkKybhWTsLCRjFzCyrGIUys1Mzk4t
	yszWK8ioLElN1ktJ3cQIijcRBq4djH1zPA4xMnEwHmKU4GBWEuHdNEc7TYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU1ILUIpgsEwenVAPj1kd3y7Osnkqd566zj7pm+ILz
	760Fu7hdf2xnPPXoQZX7tQvFi7b9Pn95ge35I+dvMDkfvSW1K3ydVZe67rnyVS1bU89+r9Ms
	a9Zan18ZsJJpy9WNWW0Mab9ntQkxXtCpdOCbx7tsF+Old8ItN5dunP/0oOXrcxKCXYwSnWUv
	dTae/B4kpC7DpcRSnJFoqMVcVJwIAHSER+elAgAA

Hi Garrett,

thanks for sending!

It seems like this patch completes the board's support. Every 
interface/component is now fully supported.

Am 25.04.24 um 17:25 schrieb Garrett Giordano:
> The USB-C PD manages plug orientation, power delivery, and our endpoint
> for the USB interface. Add this node and include its endpoint.
> 
> Configure USB0 for role-switching and wire it to our USB-C PD endpoint.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 26 ++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> index dfc78995d30a..fb3bc914a018 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> @@ -348,6 +348,24 @@ gpio_exp: gpio-expander@21 {
>   				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
>   	};
>   
> +	usb-pd@22 {
> +		compatible = "ti,tps6598x";
> +		reg = <0x22>;
> +
> +		connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			self-powered;
> +			data-role = "dual";
> +			power-role = "sink";
> +			port {
> +				usb_con_hs: endpoint {
> +					remote-endpoint = <&typec_hs>;
> +				};
> +			};
> +		};
> +	};
> +
>   	sii9022: bridge-hdmi@39 {
>   		compatible = "sil,sii9022";
>   		reg = <0x39>;
> @@ -449,7 +467,13 @@ &usbss1 {
>   };
>   
>   &usb0 {
> -	dr_mode = "peripheral";
> +	usb-role-switch;
> +
> +	port {
> +		typec_hs: endpoint {
> +			remote-endpoint = <&usb_con_hs>;
> +		};
> +	};
>   };
>   
>   &usb1 {

