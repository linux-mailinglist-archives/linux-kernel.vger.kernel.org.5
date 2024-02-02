Return-Path: <linux-kernel+bounces-49650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1E846D79
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F291C220C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DA57A70B;
	Fri,  2 Feb 2024 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPW3WRRK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CB5B688;
	Fri,  2 Feb 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868809; cv=none; b=Ur8UKAIHrFK05JIQQ9afdjFvjIUymEiiSwojlz2c+6l47znk0UNPRt0AgvMdpw1O+I9R6qqcM+kg+lGvXlA/3O6IyfExfLnUNKc/QfNC2uqXiaQH7pRwWqz5ldwkJ1QvG5544wapYR01L5LOb+nOjeoQyoNScz5xNgfCx9PUEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868809; c=relaxed/simple;
	bh=CGbUJZWnQ+T87B7ahoNtsvaLKfL68r5YfknAmE8rR+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvOUsyD3kDfcaM0+Q193QiRyPKTPljXw6UUW9uxeseecdjgETZpr8vu2NVvSfyp/QWcz4AGpwYMCe+vxwBH5H4hL9M8xXHRfdcQlbj8fT5uS3uwv5+V+i7MOQaAcjFoRq8UDKKvZnrpvM7qSPvfDqriVbKrov2o5LZIkFHiPMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPW3WRRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D2EC433F1;
	Fri,  2 Feb 2024 10:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706868809;
	bh=CGbUJZWnQ+T87B7ahoNtsvaLKfL68r5YfknAmE8rR+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fPW3WRRKbohdbgUijGU9q9wIU5k5Ls6pi4PVqWZH0Rj/xvZRzxuw2cXz2G00MehkD
	 BkwkRxho+yQg2ppcrx6PxVegT7A/UemJ0vNXU3AhlppqfSZcD8DFMoW6IBXqExKmdQ
	 s0QljsxXtZcnh1x+zgPbvJhvdU9IcuUeqv0NXDViZsQPrlIINAA0kgn/eKgC5+Y54z
	 sybtxGkC0ZEVJhqvZgvVXL+XcEDRRuNq0CCjVZaQOQ3VXxzfZ1B/9TrtWqaIghW4He
	 zmKg53vHMW7C9FDL56mkkNQg+4ZlbH5Du6L0rWymRmjzyT2VmrUlc8ruvCNdiJZDD1
	 NE2B0Ip0PpUSg==
Message-ID: <dc3c93dc-74d9-4b1c-a771-3ee6f67b5dcc@kernel.org>
Date: Fri, 2 Feb 2024 12:13:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Bin Liu <b-liu@ti.com>, nm@ti.com,
 vigneshr@ti.com, afd@ti.com, kristo@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
 r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
 <20240201-violet-chalice-51a73f113e7b@spud>
 <20240201183522.ssj553rwefr2wuqi@iaqt7>
 <20240201-clad-unopposed-ccfdfe53b770@spud>
 <bc3ab60f-539b-41d0-8595-6e0b55f2763d@kernel.org>
 <20240202-unzip-whacky-bb2f151c618b@wendy>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240202-unzip-whacky-bb2f151c618b@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/02/2024 11:53, Conor Dooley wrote:
> On Fri, Feb 02, 2024 at 11:36:55AM +0200, Roger Quadros wrote:
>>
>>
>> On 01/02/2024 21:13, Conor Dooley wrote:
>>> On Thu, Feb 01, 2024 at 12:35:22PM -0600, Bin Liu wrote:
>>>> On Thu, Feb 01, 2024 at 06:18:05PM +0000, Conor Dooley wrote:
>>>>> On Thu, Feb 01, 2024 at 06:15:20PM +0000, Conor Dooley wrote:
>>>>>> On Thu, Feb 01, 2024 at 02:03:31PM +0200, Roger Quadros wrote:
>>>>>>> So far this was not required but due to the newly identified
>>>>>>> Errata i2409 [1] we need to poke this register space.
>>>>>>>
>>>>>>> [1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
>>>>>>>
>>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>>>
>>>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>
>>>>> Actually, where is the user for this that actually pokes the register
>>>>> space?
>>
>> https://lore.kernel.org/all/20240201121220.5523-5-rogerq@kernel.org/
>>
>>>>> You're adding another register region, so I went to check how you were
>>>>> handling that in drivers, but there's no driver patch.
>>>>
>>>> See Roger's another patch set 'Add workaround for Errata i2409' posted
>>>> on 16th.
>>>
>>> This patch should be with that series, not with these dts patches.
>>>
>>
>> Why not? There should be no dependency between DTS and driver implementation.
>>
>> As DTS and driver will be merged by separate maintainers I thought it
>> would be easier for maintainers this way.
> 
> dts and driver might be merged by different people, but dt-bindings and
> drivers are merged by the same people. This is a bindings patch, not a

If we do that then I get a bunch of dtbs_check warnings

dwc3-usb@f900000: reg: [[0, 261095424, 0, 2048], [0, 261128192, 0, 1024]] is too long

> dts patch. Look at what get_maintainer says for this file:
> 	Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
> 	Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> 	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> 	Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> 	Aswath Govindraju <a-govindraju@ti.com> (in file)
> 	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
> 	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> 	linux-kernel@vger.kernel.org (open list)
> Greg and linux-usb are on there, but you have not CCed them.

My bad. Will be more careful next time.

> 
> Being with the driver also allows bindings maintainers to check that you
> don't break backwards compatibility. It also prevents me having to ask
> for the driver patch, then be given just a subject line that I have to
> go and look up myself!
> 

Sorry about that. It took a bit longer but I did point you directly to the
patch on lore.kernel.org.

-- 
cheers,
-roger

