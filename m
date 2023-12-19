Return-Path: <linux-kernel+bounces-5168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F72F81877B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F741F2278A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41418022;
	Tue, 19 Dec 2023 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Vg1fVehV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com [45.254.49.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7917999;
	Tue, 19 Dec 2023 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=Vg1fVehVqgufqVZ0tVxwDfwc+NOpTp13wuBuQ3k4r9nofHqsGcOY/zRQxw00lc90WgNXOWNnHkKl16DXjSfwDu+rvsQ5hLqLmffoyXtDwjtKV0rsvEIWFQdJ5mzGPgTYihEqMl9o4bYRQY72eu1364+NpmeKQlKtFg38lK1F6vU=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wxJCuegR00+qTeucqcxGWtpk2IAIp1Qkyb7anTpwc00=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.69] (unknown [58.22.7.114])
	by mail-m11877.qiye.163.com (Hmail) with ESMTPA id EE7D6400543;
	Tue, 19 Dec 2023 18:01:23 +0800 (CST)
Message-ID: <31198bf2-54c4-4483-ac31-449e5576cff8@rock-chips.com>
Date: Tue, 19 Dec 2023 18:01:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, zhengxing@rock-chips.com,
 Andy Yan <andy.yan@rock-chips.com>, heiko@sntech.de
Subject: Re: [PATCH v2 3/3] ARM: dts: rockchip: Remove
 rockchip,default-sample-phase from rk3036.dtsi
Content-Language: en-GB
To: Andy Yan <andyshrk@163.com>
References: <20231218105523.2478315-1-andyshrk@163.com>
 <20231218105523.2478315-4-andyshrk@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20231218105523.2478315-4-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwdSFYdTxgfGhkZSRhJSB5VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
	kG
X-HM-Tid: 0a8c8185e2342eb3kusnee7d6400543
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46Ejo*TTw4Ny48CC9PCQMp
	DEoKFDVVSlVKTEtJQkNLS0NPQ0lNVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhNQko3Bg++


On 2023/12/18 18:55, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> This should be a per board property, should not be put in
> a soc core dtsi.
> 
> And when this property convert from default-sample-phase
> in linux-5.7 by commit 8a385eb57296 ("ARM: dts: rockchip: fix
> rockchip,default-sample-phase property names"), the emmc
> on rk3036 kylin board get a initialising error:
> 
> [    4.512797] Freeing unused kernel memory: 8192K
> [    4.519500] mmc_host mmc1: Bus speed (slot 0) = 37125000Hz (slot req 37500000Hz, actual 37125000HZ div = 0)
> [    4.530971] mmc1: error -84 whilst initialising MMC card
> [    4.537277] Run /init as init process
> [    4.550932] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
> [    4.664717] mmc_host mmc1: Bus speed (slot 0) = 37125000Hz (slot req 37500000Hz, actual 37125000HZ div = 0)
> [    4.676156] mmc1: error -84 whilst initialising MMC card
> 
> I think the reason why the emmc on rk3036 kylin board was able
> to work before linux-5.7 was that the illegal property was not
> correctly identified by the rockchip dw_mmc driver.
> 
> Fixes: faea098e1808 ("ARM: dts: rockchip: add core rk3036 dtsi")
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> (no changes since v1)
> 
>   arch/arm/boot/dts/rockchip/rk3036.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
> index 5344803442a1..466952bf9db4 100644
> --- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
> @@ -287,7 +287,6 @@ emmc: mmc@1021c000 {
>   		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
>   			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
>   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> -		rockchip,default-sample-phase = <158>;
>   		disable-wp;
>   		dmas = <&pdma 12>;
>   		dma-names = "rx-tx";

