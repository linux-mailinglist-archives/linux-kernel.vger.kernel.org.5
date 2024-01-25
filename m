Return-Path: <linux-kernel+bounces-38538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AEC83C132
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1151F288F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2335F32182;
	Thu, 25 Jan 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vewYOVwJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C82C68E;
	Thu, 25 Jan 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182922; cv=none; b=MgRubXibIaMoJes7WdCYlmIm1MJcsbBTldOYiUpdYLwJu4XS9K5jg17bppmoqBabzMrpzfyjbkZosJnk4ZMGGI/Ea6oR+tLNxiizxHz53Atiw5kqNxDrZtMhW1ftThQHdkk75vVyWrQ1H2SMeHydLy018uunsOl1nc6cx/TAjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182922; c=relaxed/simple;
	bh=lIMClxazBCbbP0kSsel6jlB5mJrKwckFwpLWr68KnQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctefA71HLbGGq2HI1ix+k11gi1pwrkHRP2l7yqAgQBamN7h8WD3ubsazcuhYjzpfFDpDFQhdPrXnh4N9aWT+kRG/H9T2MQZxe68MOgOi8GzNxuz+KGQyojMyz+Ox3bzUbgWcwQabQqBtdk9Q8dVUliWnlpzmOYz5M+i5MJH9xQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vewYOVwJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706182919;
	bh=lIMClxazBCbbP0kSsel6jlB5mJrKwckFwpLWr68KnQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vewYOVwJUEiqmlgjNKNPbZKIVEvx1wPn8xyneTSefKDDOj+Zh1gYQtubBg06SAM75
	 Yj7ndipccxrzQtscnWa4d7x7nETGOvom4Km7rspA1Rmh9jOLXtnXAd19kIFlQYhUGh
	 1wss5MkNQg/8zVW/HHCaak2qUqh0+oxPi2sIn7KIBVqUb7oEPyL+OQ1U3hFY6q9Ai+
	 E7A6s26M+Tae8n2PIaeDYzcwlaXFHqmQDs9NcXPDDlaq6bCb8lxPYCbrITb4hA2DXP
	 ZE+xjAkqaQ1KkKKVAWtgq9na+sJiMccfCTDzkGsWiwWuuF0T7YD2MaDOFdjUpQ1oth
	 Cg5LK8OuDO3kw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3A0303781182;
	Thu, 25 Jan 2024 11:41:58 +0000 (UTC)
Message-ID: <abbc1135-6d32-421a-baea-123a9f761362@collabora.com>
Date: Thu, 25 Jan 2024 12:41:57 +0100
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
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
 <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>
 <dc9773aa-690f-47b5-b60a-a79c1e2dbaf2@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <dc9773aa-690f-47b5-b60a-a79c1e2dbaf2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/01/24 11:32, Krzysztof Kozlowski ha scritto:
> On 24/01/2024 09:48, AngeloGioacchino Del Regno wrote:
>> Il 23/01/24 18:14, Conor Dooley ha scritto:
>>> On Mon, Jan 22, 2024 at 11:32:30AM +0100, AngeloGioacchino Del Regno wrote:
>>>> Il 19/01/24 17:32, Conor Dooley ha scritto:
>>>>> On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino Del Regno wrote:
>>>>>> This IP has only one interrupt, hence interrupt-names is not necessary
>>>>>> to have.
>>>>>> Since there is no user yet, simply remove interrupt-names.
>>>>>
>>>>> I'm a bit confused chief. Patch 2 in this series removes a user of this
>>>>> property from a driver, so can you explain how this statement is true?
>>>>>
>>>>> Maybe I need to drink a few cans of Monster and revisit this patchset?
>>>>>
>>>>
>>>> What I mean with "there is no user" is that there's no device tree with any
>>>> mt6360-tcpc node upstream yet, so there is no meaningful ABI breakage.
>>>> Different story would be if there was a device tree using this already, in
>>>> which case, you can make a required property optional but not remove it.
>>>
>>> Not every devicetree lives within the kernel.. If the driver is using
>>> it, I'm not inclined to agree that it should be removed.
>>
>> I get the point, but as far as I remember, it's not the first time that this
>> kind of change is upstreamed.
>>
>> I'm fine with keeping things as they are but, since my intention is to actually
>> introduce an actual user of this binding upstream, and that actually depends on
>> if this change is accepted or not (as I have to know whether I can omit adding
>> the interrupt-names property or not)....
>>
>> ....may I ask for more feedback/opinions from Rob and/or Krzk?
> 
> Driver is the user and this is an old binding (released!), thus there
> can be out-of-kernel users already.
> 
> Minor cleanup is not really a reason to affect ABI. You could deprecate
> it, though. Driver change is fine.
> 

Thanks for the clarification. If USB maintainers want to take the driver part only
without me resending this, I'd appreciate that.

The interrupt-names is not a required property in this binding anyway... :-)

Thanks again,
Angelo


