Return-Path: <linux-kernel+bounces-155294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A8E8AE85A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9A71F21343
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79F913699E;
	Tue, 23 Apr 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gIYXTO+9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA9134CFE;
	Tue, 23 Apr 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879494; cv=none; b=DDtBSI4noJ3GjsUMem4ICWTxu8KlZ52+SO5Nc+P7MZdgZ3sZNhG+tqnnRfUHI2JbtQqEb2Irdltt2YlWMUaqZVS/dR8exnKKVppHoT2yNmn4j20vfACtIay5VHRkWnQJdzXCyhljjMtxuhkvypsqUCy1rg4pPqbD0k1DJKONMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879494; c=relaxed/simple;
	bh=R37CrBrSZbw0FfGw18EfnNQE6N9d3UBGkfxO1/LRxts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bikWsvOOjiLdap4sADbpKFGfjpFL1SVwGLkUgCNsEmTiS41qvEapQ9KWikuUiXJBc2whxHesnlQ1pb2aer+fBvRFf46TQPldlV9EfBCpVAyWqyVnhQ8vF4jaTc+v/t40sSpQc9g3amlB1GLicdhTiwWWqBB7/T1NYLOvBGS8/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gIYXTO+9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713879490;
	bh=R37CrBrSZbw0FfGw18EfnNQE6N9d3UBGkfxO1/LRxts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gIYXTO+9y4i4W0WgLhT9Paj+W5pzGT1LnrmP4o6+cSJxoCNmCaTVYoWgvs8TLh5GO
	 yNPr1hX9MiHT/8aLw3Bxhh1Eof9AC5DeXPfIlHTfQGsVq2MX/B9VFAB/8qgjNMUrGF
	 iEika5igy2qtKd5V41ek2RCKcSiR3i6fSyUoaIbt8+txxYKOj24YhNOYkCPsgBwtU5
	 lsKoT1AP2mOzLltygOrAwAFrr/3qVGDebPNsdAE7FWftSFO22c+sI4VmK7sCwGUy2G
	 w8oP54GafMSPAe/9LIUjjZ9Blt8Wl9TaX3ztAovlpNiWOLClZMewXosEhAt7xmGgx0
	 imIIfuRnfyY/Q==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3C8F73782136;
	Tue, 23 Apr 2024 13:38:10 +0000 (UTC)
Message-ID: <3b2417a6-2b25-4a43-928b-926649a48571@collabora.com>
Date: Tue, 23 Apr 2024 15:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] media: i2c: add MAX96717 driver
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org, mchehab@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-4-julien.massot@collabora.com>
 <ZhkZp9KKrRy7smLn@valkosipuli.retiisi.eu>
Content-Language: en-US
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <ZhkZp9KKrRy7smLn@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 4/12/24 13:23, Sakari Ailus wrote:
> Hi Julien,
> 
> Thanks for the update.
> 
> Could you also cc me to the possible further updates, please?
> 
> On Mon, Mar 25, 2024 at 02:16:33PM +0100, Julien Massot wrote:
>> This driver handles the MAX96717 serializer in tunnel mode.
>> All incoming CSI traffic will be tunneled through the GMSL2
>> link.
>>
>> The MAX96717 driver can handle MAX96717 and MAX96717F variants
>> with the same "maxim,max96717f" compatible.
>>
>> Signed-off-by: Julien Massot <julien.massot@collabora.com>
>> ---
>> Change since v5:
>>   - set the driver compatible back to MAX96717F that can be used as a fallback for MAX96717
>>
>> Change since v4:
>>   - make the driver compatible with MAX96717 instead of MAX96717F
>>   - Add the device id for the MAX96717
>>   - remove hw_data structure for now, it can be usefull later for handling different serializers e.g max9295
>>
>> Change since v3:
>>   - Maintainers: align to the new binding path
>>   - Kconfig: better describe the symbol
>>   - store the v4l2_mbus_config_mipi_csi2 structure instead of the full endpoint in the driver private structure
>>   - use MAX96717_PAD_SINK/SOURCE instead of 0/1 for pad intialization
>>   - Removed incorrect call to fwnode_handle_put(priv->sd.fwnode)
>>   - Use unsigned int instead of u8
>>   - Allocate clk name out of the clk struct initialization
>>   - fixed multiline comment
>>   - Removed one unnecessary goto at the end of the probe function
>>
>> Change since v2:
>>   - Use CCI helpers instead of recoding register access
>>   - add missing bitfield header
>> ---
>>   MAINTAINERS                  |   7 +
>>   drivers/media/i2c/Kconfig    |  14 +
>>   drivers/media/i2c/Makefile   |   1 +
>>   drivers/media/i2c/max96717.c | 934 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 956 insertions(+)
>>   create mode 100644 drivers/media/i2c/max96717.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b43102ca365d..c43088157f6d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13277,6 +13277,13 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/media/i2c/maxim,max96712.yaml
>>   F:	drivers/staging/media/max96712/max96712.c
>>   
>> +MAX96717 GMSL2 SERIALIZER DRIVER
>> +M:	Julien Massot <julien.massot@collabora.com>
>> +L:	linux-media@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
>> +F:	drivers/media/i2c/max96717.c
>> +
>>   MAX9860 MONO AUDIO VOICE CODEC DRIVER
>>   M:	Peter Rosin <peda@axentia.se>
>>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
>> index 56f276b920ab..1a99396edbcf 100644
>> --- a/drivers/media/i2c/Kconfig
>> +++ b/drivers/media/i2c/Kconfig
>> @@ -1573,6 +1573,20 @@ config VIDEO_DS90UB960
>>   	  Device driver for the Texas Instruments DS90UB960
>>   	  FPD-Link III Deserializer and DS90UB9702 FPD-Link IV Deserializer.
>>   
>> +config VIDEO_MAX96717
>> +	tristate "Maxim MAX96717 GMSL2 Serializer support"
>> +	depends on OF && I2C && VIDEO_DEV && COMMON_CLK
>> +	select I2C_MUX
>> +	select GPIOLIB
>> +	select V4L2_CCI_I2C
> 
> I think you'll also need MEDIA_CONTROLLER, VIDEO_V4L2_SUBDEV_API and
> V4L2_FWNODE.

You are right, will be fixed in v7.

> 
>> +	help
>> +	  Device driver for the Maxim MAX96717 GMSL2 Serializer.
>> +	  MAX96717 serializers convert video on a MIPI CSI-2
>> +	  input to a GMSL2 output.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called max96717.
>> +
>>   endmenu
>>   
>>   endif # VIDEO_DEV
> 

-- 
Julien Massot
Senior Software Engineer
Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

