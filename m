Return-Path: <linux-kernel+bounces-138806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A089FA93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1956F1F30D39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F45177993;
	Wed, 10 Apr 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fuzoyrPG"
Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com [220.197.31.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252E174ED5;
	Wed, 10 Apr 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760427; cv=none; b=UwGT9SvZPqQK3nPbQ3EtFyJtWy5LpzG/mx3unAuun7W0SYlSDdxaLRzhOF9gN+o2Ma0/bCeVDBNPcjv1Un2wwJ0Jfm905bfC64ENSODNsT2tlgPeFdxgYJmQutof+Q65qmMyUnVaHfRD4+W6vWl6K3gnbfSecyg2lzhKugKD/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760427; c=relaxed/simple;
	bh=wKDkH+37tJ3xsdWBf9SWS/MYhpapMqcyf4lJkhkSO9I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hkCa5ZpjgCgoeaTuVU0nUu50DeYRt91oriXN82opAwXRx/kyqbfiuig+/dClGP8kPFs35IocGbGxVEUgpvEE+sSgvqbnF8atU2euqgeGm+PYr4YHRswR0vopRt+ForBdyUZj2oTo0epK+HKgxzZsk6y4O9sji9l7bT+UInqYg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fuzoyrPG; arc=none smtp.client-ip=220.197.31.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=fuzoyrPGx8fUdZlpdp3unmisLPz6WB0BLKButewC27WNIhv4xGsS26ly9usLHFO6RDvJAs5w4u9LC0OF9PclhGZiSeD1xLJ17wzSFN1O25knPyKJjm9zOqujpFTxCKKNcRsrLnAgsv0F/bjPLaztSFw8czESdeVD5J6JP7DUL88=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=2DiFiEPKTIb4dIbL4HzejQd26iq2642UkcYkMtQkGes=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.69] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id CC4D44605A2;
	Wed, 10 Apr 2024 14:30:15 +0800 (CST)
Message-ID: <432000a6-1de9-4452-beb7-6954677e34c8@rock-chips.com>
Date: Wed, 10 Apr 2024 14:30:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de,
 sfr@canb.auug.org.au, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove startup-delay-us from
 vcc3v3_pcie2x1l0 on rock-5b
Content-Language: en-GB
To: Jianfeng Liu <liujianfeng1994@gmail.com>
References: <20240401081302.942742-1-liujianfeng1994@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20240401081302.942742-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJOGlZOT0lNHkIeSU1KSk1VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8ec6b3367703aekunmcc4d44605a2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogg6Pgw4DjMJLx9NSzwPUTdD
	Aw0KFDpVSlVKTEpJTEhLTUpMQkxJVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9PTEM3Bg++

Hi Jianfeng,

On 2024/4/1 16:13, Jianfeng Liu wrote:
> Property startup-delay-us is copied from vendor dts and it will
> make kernel not detect pcie wifi device. If I run command:
> "echo 1 > /sys/bus/pci/rescan", pcie wifi device is detected, but
> my wifi device RTL8822CE failed to load driver. Another device
> RTL8723BE can load driver but no wifi signal is detected.
> 
> Removing this property will fix issues above.
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

startup-delay-us just make sure the power rail is stable before
any action is taken to start the link, preventing the device from
unable to work stably. So it shouldn't be the root cause I think.

Could you help try this patch to checkout if it works for you?

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c 
b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index d684214..df30127 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -167,7 +167,7 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
         struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);

         /* Reset device */
-       gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
+       //gpiod_set_value_cansleep(rockchip->rst_gpio, 0);

         rockchip_pcie_enable_ltssm(rockchip);

@@ -180,7 +180,7 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
          * We need more extra time as before, rather than setting just
          * 100us as we don't know how long should the device need to reset.
          */
-       msleep(100);
+       msleep(300);
         gpiod_set_value_cansleep(rockchip->rst_gpio, 1);

         return 0;
@@ -311,6 +311,8 @@ static int rockchip_pcie_probe(struct 
platform_device *pdev)
         if (ret)
                 return ret;

+       gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
+
         /* DON'T MOVE ME: must be enable before PHY init */
         rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");



> ---
>   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index d6bf2ee07..a9af654a0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -76,7 +76,6 @@ vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
>   		regulator-boot-on;
>   		regulator-min-microvolt = <3300000>;
>   		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <50000>;
>   		vin-supply = <&vcc5v0_sys>;
>   	};
> 
> --
> 2.34.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

