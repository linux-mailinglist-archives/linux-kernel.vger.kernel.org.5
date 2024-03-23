Return-Path: <linux-kernel+bounces-112444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FAC8879ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D6FB2147D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F225676E;
	Sat, 23 Mar 2024 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="eiaz3UiV"
Received: from mail-m17246.xmail.ntesmail.com (mail-m17246.xmail.ntesmail.com [45.195.17.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611B1DFEF
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711218505; cv=none; b=tabZmcOfKgmaCDyQE8jqrsycTMOFRTNn9/mlrE8GnZZHkGRMhgUCCO4k5fqf9KpkNc8s23gWu6zpQkip3ceXQOEq7KJyC+WzlBdhxvhKpDvqHhreA8+cnehvGMr+MsC2CmEZf6jzGOmbgCpvt1tj/UJ2P+ByQeHcb/DC3TeZbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711218505; c=relaxed/simple;
	bh=b6q8S2cZfPurAsVPSWf/U16BmSrf9f4r1gF9UH2M7kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKEpZPripvnYrw5mSg08kIS7ok1MaFxbD/vBtHJulVZ22Vi24NJuLXg3v/5sHpVWfvSFs7En9CJvl4WWSCyMobZBwypjkBgLd/lEq8LfDaVEAQYraA1oFoEm6rarmu8GgNgPLRI7u9XjmkjFgjKFzIk3iOkKvHV8NBj3TU0hT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=eiaz3UiV; arc=none smtp.client-ip=45.195.17.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=eiaz3UiV0uPVF2QFBinLXWWWvz2WaL40BQXlEdwQrk7Q6yHgnLRWJnPTMAynR0C6BcmSXnBxv6ublAjKBN5I1Yyz8/PdCga067rseDQQTELTkIAzb98hELqkyHWPeDf3DAbDNRXfST+X6BMOTspz4eOj9iC4vmjoFMr6Dkihoow=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=F4JueNQpmRpoZ37/dDuh/QnjrtryA6hyAuvn6ICYLVY=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1CDA884017E;
	Sat, 23 Mar 2024 18:10:35 +0800 (CST)
Message-ID: <38d576a3-0f4e-4410-aa9b-74e06e1fceb1@rock-chips.com>
Date: Sat, 23 Mar 2024 18:10:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: vop2: Remove AR30 and AB30 format support
To: Heiko Stuebner <heiko@sntech.de>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: heiko@sntech.de, hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20240304100952.3592984-1-andyshrk@163.com>
 <ZeWlAWLvlW3NdKS_@pengutronix.de>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <ZeWlAWLvlW3NdKS_@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5OSFYZSkIaShodGBlJGE5VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
	kG
X-HM-Tid: 0a8e6aca6f4c03a4kunm1cda884017e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6Ghw4HjMVEgg*Ii5OUSlI
	Ci4aFBVVSlVKTEpKSkNDTUhOTENNVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSU1OSzcG

Hi Heiko,

Could you please  to take a look at this patch?

On 3/4/24 18:40, Sascha Hauer wrote:
> On Mon, Mar 04, 2024 at 06:09:52PM +0800, Andy Yan wrote:
>> From: Andy Yan <andy.yan@rock-chips.com>
>>
>> The Alpha blending for 30 bit RGB/BGR are not
>> functioning properly for rk3568/rk3588, so remove
>> it from the format list.
>>
>> Fixes: bfd8a5c228fa ("drm/rockchip: vop2: Add more supported 10bit formats")
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Sascha
> 
>>
>>   drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
>> index 48170694ac6b..18efb3fe1c00 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
>> @@ -17,9 +17,7 @@
>>   
>>   static const uint32_t formats_cluster[] = {
>>   	DRM_FORMAT_XRGB2101010,
>> -	DRM_FORMAT_ARGB2101010,
>>   	DRM_FORMAT_XBGR2101010,
>> -	DRM_FORMAT_ABGR2101010,
>>   	DRM_FORMAT_XRGB8888,
>>   	DRM_FORMAT_ARGB8888,
>>   	DRM_FORMAT_XBGR8888,
>> -- 
>> 2.34.1
>>
>>
> 

