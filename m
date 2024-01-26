Return-Path: <linux-kernel+bounces-39903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A283D737
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE30B1F249A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD114AA2;
	Fri, 26 Jan 2024 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="foaka/db"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DCBE5D;
	Fri, 26 Jan 2024 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260559; cv=none; b=fFDEDtRGTuv61WnQVUe1Jb4JZzDpy/WFfKf31brxbKsDQL2OA7RQO/DHmcN7gTNtNIj9t9uZFLC56mUG1STcb2RPQ4RF3v4Rp4PLEu+3wN82kw6UojJ2GEgchhYTwEi4KG3GLY1yrtYMu3IGPPiF2HjgHdnPr7vpVgSt/3kajxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260559; c=relaxed/simple;
	bh=cTOqvscxgkEm+jjAOeB+HwCjWsvKYRV/3IERaIp2Z6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkRMt4iORtUItc/9nMSB4AJAuz4Tpqo5BjVC629aDN5FfHKlAnQ3yJ2anqAK9VsRZwNQJ1gtSvCVPvq37Mb/oPxPoufe/c6hF3bQrEXZxylXfZhZCAaXepbcuGzeXTBWY4HMgLwczwE2UUwYh45baPTclQnU+V+lqHDybT+Quss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=foaka/db; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706260555;
	bh=cTOqvscxgkEm+jjAOeB+HwCjWsvKYRV/3IERaIp2Z6U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=foaka/dbwOa4i+lCE/UY7QdaFni+nQr1DuUfGOXRTNuj4XoYTBLYYKMkQh43oJ+ln
	 5n9aZCTQb83jJXciEP2u2YGDy1QhECpdMOo1jtFaFQVucKiV6KgOP/N6wTfRaIlpy/
	 XNLe4PtzWHZG4zItC6MonC/glxP+ohhL7ONRYZypQhahrGbfUTNZYlgKcggJ+oA9I3
	 m5vmrg/2JqlACOZSUut9MqQz0IXqQcT+2F2zSOVk6DX2nDSeOiLzS1BOdCIArKbgVo
	 RYD82NiT/pxafRn6Fsq4TmvK7EL3PgE2QZV7jmlk6QqJic5YgE23GoPHo+LxiNY448
	 JN33/1GOqfw8A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D6C8A378107C;
	Fri, 26 Jan 2024 09:15:54 +0000 (UTC)
Message-ID: <27070454-09e6-422b-95f0-5d674735426b@collabora.com>
Date: Fri, 26 Jan 2024 10:15:54 +0100
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
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, chunfeng.yun@mediatek.com,
 gregkh@linuxfoundation.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 linux@roeck-us.net, heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
 <20240119-eldest-discharge-e2d3812be0a9@spud>
 <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>
 <20240123-procurer-jumbo-ebbec485505d@spud>
 <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>
 <dc9773aa-690f-47b5-b60a-a79c1e2dbaf2@linaro.org>
 <abbc1135-6d32-421a-baea-123a9f761362@collabora.com>
 <20240125-disdain-delivery-ff3bf246bbe1@spud>
 <20240125-elective-sermon-32dc2cba79be@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240125-elective-sermon-32dc2cba79be@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/01/24 18:02, Conor Dooley ha scritto:
> On Thu, Jan 25, 2024 at 04:57:33PM +0000, Conor Dooley wrote:
>> On Thu, Jan 25, 2024 at 12:41:57PM +0100, AngeloGioacchino Del Regno wrote:
>>> Il 25/01/24 11:32, Krzysztof Kozlowski ha scritto:
>>>> On 24/01/2024 09:48, AngeloGioacchino Del Regno wrote:
>>>>> Il 23/01/24 18:14, Conor Dooley ha scritto:
>>>>>> On Mon, Jan 22, 2024 at 11:32:30AM +0100, AngeloGioacchino Del Regno wrote:
>>>>>>> Il 19/01/24 17:32, Conor Dooley ha scritto:
>>>>>>>> On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino Del Regno wrote:
>>>>>>>>> This IP has only one interrupt, hence interrupt-names is not necessary
>>>>>>>>> to have.
>>>>>>>>> Since there is no user yet, simply remove interrupt-names.
>>>>>>>>
>>>>>>>> I'm a bit confused chief. Patch 2 in this series removes a user of this
>>>>>>>> property from a driver, so can you explain how this statement is true?
>>>>>>>>
>>>>>>>> Maybe I need to drink a few cans of Monster and revisit this patchset?
>>>>>>>>
>>>>>>>
>>>>>>> What I mean with "there is no user" is that there's no device tree with any
>>>>>>> mt6360-tcpc node upstream yet, so there is no meaningful ABI breakage.
>>>>>>> Different story would be if there was a device tree using this already, in
>>>>>>> which case, you can make a required property optional but not remove it.
>>>>>>
>>>>>> Not every devicetree lives within the kernel.. If the driver is using
>>>>>> it, I'm not inclined to agree that it should be removed.
>>>>>
>>>>> I get the point, but as far as I remember, it's not the first time that this
>>>>> kind of change is upstreamed.
>>>>>
>>>>> I'm fine with keeping things as they are but, since my intention is to actually
>>>>> introduce an actual user of this binding upstream, and that actually depends on
>>>>> if this change is accepted or not (as I have to know whether I can omit adding
>>>>> the interrupt-names property or not)....
>>>>>
>>>>> ....may I ask for more feedback/opinions from Rob and/or Krzk?
>>>>
>>>> Driver is the user and this is an old binding (released!), thus there
>>>> can be out-of-kernel users already.
>>>>
>>>> Minor cleanup is not really a reason to affect ABI. You could deprecate
>>>> it, though. Driver change is fine.
>>>>
>>>
>>> Thanks for the clarification. If USB maintainers want to take the driver part only
>>> without me resending this, I'd appreciate that.
>>>
>>
>>> The interrupt-names is not a required property in this binding anyway... :-)
>>
>> Having -names properties that are not required when the base property is
>> always seem so pointless to me, except in cases where they're not
>> required for the case where there's one item but required when there are
>> more than one. Ultimately they're pointless if not required since they
>> can't be relied on. I think dropping it from the driver is required for
>> correctness.
> 
> Actually, looking at the binding again:
> 
> | required:
> |   - compatible
> |   - interrupts
> |   - interrupt-names
> 
> It looks like it is a required property after all!

Apparently my brain's binding had

required:
   - blindness

:-P

Yeah, I have no idea why I didn't see that, sorry!

Cheers,
Angelo

