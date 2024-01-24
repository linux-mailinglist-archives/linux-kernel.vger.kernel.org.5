Return-Path: <linux-kernel+bounces-36657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DCF83A486
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607A9284DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697CB17BC7;
	Wed, 24 Jan 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BCoTd5gM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27B17BB5;
	Wed, 24 Jan 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086108; cv=none; b=upEJ5zVTjszlINGgmqB0MqKWb9wupxxv00SaG4Umcep3A5X2mm7HpGfLbMeyOiSvBpGhp3heucAlA+0DGT882MbowKGSRHzvmqlOL8k2iFyhQhRbQVGRUcWHS5bwm1FJOcra2CVUSDfDOb+wSsCn3qQtTpWA/EbVn495QcAgAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086108; c=relaxed/simple;
	bh=ekyS4ZOSSZIbtYGGpgL9knQnsxr3+M0NajqbJuU+F1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJ2bLyvJhThRYnxDLtap87eu7LG2vprKn/Mw+5rEa2olS9kFbmr4RfcQLN7lLAbf+hB5uiuLV351z8P5iG7PD7WDY8EK1mrH6EKgcpAjU4C1WTdTQKXX/02b2O4QCLuxOT0nvIWPBU7qTGdhIokWBHXjl2AJLaWbDptNYEe/1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BCoTd5gM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706086105;
	bh=ekyS4ZOSSZIbtYGGpgL9knQnsxr3+M0NajqbJuU+F1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BCoTd5gMIKJXbmId+RePuOy78x9TNjz+IVtfVvT8aMoOvt6GFXUMFfiK2evKiYXvb
	 oZyO0AEFs4Dmavi4mJMbhG5F4NI7ioouzVKGC/NVwuEFsJeVkc0nhffNOnErG725n+
	 VtKyB0hhyArbCln7dl/FSvP+0nKz/P6X/YkzIwnVFCR4mxTUoH1ucl9082Tsyqo2HN
	 ICc7ksvioMRnWFs40WWbkN7ey5nw81o90DtxhGOwuLlF5S8LU17lSrTx0Hkk1mH8XR
	 FvrHj7IpUcE8EFEQjdNOisxGchNMHFqBOSa4cbtHks5G06EP+uMMFJttyKdkxUEagA
	 lchYKYqg7tOzA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 89EB137820B7;
	Wed, 24 Jan 2024 08:48:24 +0000 (UTC)
Message-ID: <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>
Date: Wed, 24 Jan 2024 09:48:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, linux@roeck-us.net,
 heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
 <20240119-eldest-discharge-e2d3812be0a9@spud>
 <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>
 <20240123-procurer-jumbo-ebbec485505d@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240123-procurer-jumbo-ebbec485505d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/01/24 18:14, Conor Dooley ha scritto:
> On Mon, Jan 22, 2024 at 11:32:30AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 19/01/24 17:32, Conor Dooley ha scritto:
>>> On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino Del Regno wrote:
>>>> This IP has only one interrupt, hence interrupt-names is not necessary
>>>> to have.
>>>> Since there is no user yet, simply remove interrupt-names.
>>>
>>> I'm a bit confused chief. Patch 2 in this series removes a user of this
>>> property from a driver, so can you explain how this statement is true?
>>>
>>> Maybe I need to drink a few cans of Monster and revisit this patchset?
>>>
>>
>> What I mean with "there is no user" is that there's no device tree with any
>> mt6360-tcpc node upstream yet, so there is no meaningful ABI breakage.
>> Different story would be if there was a device tree using this already, in
>> which case, you can make a required property optional but not remove it.
> 
> Not every devicetree lives within the kernel.. If the driver is using
> it, I'm not inclined to agree that it should be removed.

I get the point, but as far as I remember, it's not the first time that this
kind of change is upstreamed.

I'm fine with keeping things as they are but, since my intention is to actually
introduce an actual user of this binding upstream, and that actually depends on
if this change is accepted or not (as I have to know whether I can omit adding
the interrupt-names property or not)....

...may I ask for more feedback/opinions from Rob and/or Krzk?

Thanks,
Angelo

