Return-Path: <linux-kernel+bounces-70703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA818859B57
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20416281434
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BEACA42;
	Mon, 19 Feb 2024 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jNsKtCE7"
Received: from mail-m92235.xmail.ntesmail.com (mail-m92235.xmail.ntesmail.com [103.126.92.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F837BE4F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316464; cv=none; b=MXn/JCm1TLbNeqOzv9GNHpTiEg+o66tknwKCQBFrtvkyG1B53cjEPwKBHRGumJtNUNTw4+ATWK9COEgaRTNIDuecYThCKEfFpjKuDHRCkVceE9LOTXZFrDdfgk1eK0wBm+O9FIz5+FcRMJAdqiAmUSI1AZMDVybOaGXGWcbQDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316464; c=relaxed/simple;
	bh=T99ERiuAfnmtdq3AswGFNiUx+sHeqCY/LrHRQoP52K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cdnTzy9QRt1enovH3fj2vuoXL1uPtjsxCoJpy2/4lmXzSTBn39Bd4EO7Ss9do2sdK/jbuPxSJ0Lm8bgEWlqxW6C16WV2QgxFEu+oXRL/elh2SkJUIDFd+RCKdLfXMyDNMZRbvQRyVkifqwG7CJPUiIFOfkoI3Xzpv0/9FKAkt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jNsKtCE7; arc=none smtp.client-ip=103.126.92.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=jNsKtCE73R/JZ9xhOG+WMX8R9JBxmqVyOifq7RiuPhu2NPICr2dzFx/p2RIQKR+TGD6uHU6Ey6eiN4JrcRCisQ64HatnSxTXrIKPnuVTMn+hyNbXsTqIMOkNdIGkH2tvcMDB5FwRsXJP3WeN8xSOsYDmEnGRIa3yLTBDYtt02FY=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ItVOHciXZ967WGvoKRiUzWpTZmpIIqBqMDAT5mMGgL0=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 874CC8401EC;
	Mon, 19 Feb 2024 11:02:01 +0800 (CST)
Message-ID: <7044f324-5a45-4a4c-a15e-86614e53acf0@rock-chips.com>
Date: Mon, 19 Feb 2024 11:02:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: rockchip: Don't require MIPI DSI device when it's
 used for ISP
Content-Language: en-US
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVERS FOR ROCKCHIP" <dri-devel@lists.freedesktop.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
References: <20240217183941.1752463-1-megi@xff.cz>
 <4c66c084-5af6-43fb-a256-4746b2e00192@rock-chips.com>
 <bsc3lpdxvhy3ss2uja4do3jwvj43zbs7zhx4bzs2tryrakn7be@pt2qsyvryk73>
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <bsc3lpdxvhy3ss2uja4do3jwvj43zbs7zhx4bzs2tryrakn7be@pt2qsyvryk73>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0ofGlZKH0hPQkpOT0MYSUxVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
	kG
X-HM-Tid: 0a8dbf5038be03a4kunm874cc8401ec
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6ISo6AzMNAy0SSzFDSC9K
	OC0aCxNVSlVKTEtDSEpKTElJQ01MVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBTUJOSTcG

Hi Ondrej:

On 2/18/24 23:17, Ondřej Jirman wrote:
> Hi Andy,
> 
> On Sun, Feb 18, 2024 at 07:14:56PM +0800, Andy Yan wrote:
>> Hi,
>>
>> On 2/18/24 02:39, Ondřej Jirman wrote:
>>> From: Ondrej Jirman <megi@xff.cz>
>>>
>>> On RK3399 one MIPI DSI device can be alternatively used with the ISP1,
>>> to provide RX DPHY. When this is the case (ISP1 is enabled in device
>>> tree), probe success of DRM is tied to probe success of ISP1 connected
>>> camera sensor. This can fail if the user is able to killswitch the camera
>>> power, like on Pinephone Pro.
>>>
>>> Detect use of MIPI DSI controller by ISP, and don't include it in
>>> component match list in that case.
>>>
>>
>> Isn't this supposed to be taken care of within the dts?
>> Since DPHY1 should exclusively used by MIPI DSI1 and ISP1, then if
>> a device want to use ISP1, the DSI1 should be disabled in dts.
> 
> DSI1 can't be disabled, because it provides PHY device for ISP1 in this
> scenario.
> 
> The problem is that in this scenario DRM keeps waiting for DSI1 device,
> despite it just being used for PHY for ISP1 and not as a component for
> rockchip DRM driver.


Oh, get it.
With a quick look, seems that Heiko has already take this scenario into consideration
when add PHY function in the dsi drivers[0]
Does this mean the current drivers does not work as expected?

[0]https://patchwork.freedesktop.org/patch/420386/
> 
> See:
> 
>          isp1: isp1@ff920000 {
>                  compatible = "rockchip,rk3399-cif-isp";
>                  reg = <0x0 0xff920000 0x0 0x4000>;
>                  interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
>                  clocks = <&cru SCLK_ISP1>,
>                           <&cru ACLK_ISP1_WRAPPER>,
>                           <&cru HCLK_ISP1_WRAPPER>;
>                  clock-names = "isp", "aclk", "hclk";
>                  iommus = <&isp1_mmu>;
>                  phys = <&mipi_dsi1>;  <---------
>                  phy-names = "dphy";
>                  power-domains = <&power RK3399_PD_ISP1>;
>                  status = "disabled";
> 
> If mipi_dsi1 is disabled, isp1 will never probe.
> 
> It's a consequence of this special dual use of mipi_dsi1.
> 
> kind regards,
> 	o.
> 
>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>> ---
>>>    drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 47 +++++++++++++++++++++
>>>    1 file changed, 47 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>>> index ab55d7132550..f47de94ad576 100644
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>>> @@ -354,6 +354,43 @@ static void rockchip_drm_match_remove(struct device *dev)
>>>    		device_link_del(link);
>>>    }
>>> +/*
>>> + * Check if ISP block linked to a mipi-dsi device via phys phandle is
>>> + * enabled in device tree.
>>> + */
>>> +static bool rockchip_drm_is_mipi1_and_used_by_isp(struct device *dev)
>>> +{
>>> +	struct device_node *np = NULL, *phy_np;
>>> +
>>> +	if (!of_device_is_compatible(dev->of_node, "rockchip,rk3399-mipi-dsi"))
>>> +		return false;
>>> +
>>> +	while (true) {
>>> +		np = of_find_compatible_node(np, NULL, "rockchip,rk3399-cif-isp");
>>> +		if (!np)
>>> +			break;
>>> +
>>> +		if (!of_device_is_available(np)) {
>>> +			of_node_put(np);
>>> +			continue;
>>> +		}
>>> +
>>> +		phy_np = of_parse_phandle(np, "phys", 0);
>>> +		if (!phy_np) {
>>> +			of_node_put(np);
>>> +			continue;
>>> +		}
>>> +
>>> +		of_node_put(phy_np);
>>> +		of_node_put(np);
>>> +
>>> +		if (phy_np == dev->of_node)
>>> +			return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>>    static struct component_match *rockchip_drm_match_add(struct device *dev)
>>>    {
>>>    	struct component_match *match = NULL;
>>> @@ -371,6 +408,16 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
>>>    			if (!d)
>>>    				break;
>>> +			/*
>>> +			 * If mipi1 is connected to ISP, we don't want to wait for mipi1 component,
>>> +			 * because it will not be used by DRM anyway, to not tie success of camera
>>> +			 * driver probe to display pipeline initialization.
>>> +			 */
>>> +			if (rockchip_drm_is_mipi1_and_used_by_isp(d)) {
>>> +				dev_info(d, "used by ISP1, skipping from DRM\n");
>>> +				continue;
>>> +			}
>>> +
>>>    			device_link_add(dev, d, DL_FLAG_STATELESS);
>>>    			component_match_add(dev, &match, component_compare_dev, d);
>>>    		} while (true);

