Return-Path: <linux-kernel+bounces-91555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE556871399
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2ABB1C21100
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE4182B3;
	Tue,  5 Mar 2024 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="GUErl1RZ"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F711733;
	Tue,  5 Mar 2024 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605637; cv=none; b=sFHeVRCMrXkBUU+oguPU5Td6u4BuK/yfJ9au8DriZgCLqMvZk5b8acZ+NkSObJn6Iyv66gCTllf83e03D+rdaieVkZbyHP8emig545GS/3vV2h0Nz8/U4bEI+/Icoi6mq1vnDgIkgNJatqC7xBGZs7CWCv73hKrsuNMz45l/UJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605637; c=relaxed/simple;
	bh=skGJsVcVlkEfIF1lrULSJ5OhJCOw1O581tRjrCeHB1U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jNY6t1ejw9LdicBb5YWhYt59tnT5NY54sbXvw8gLREw2k6zUVmCSMRi/7R64H9nk2yAkyNvi9Oqe59ZDxTdLMbCJEDG8YHPvpKkPx97JP/BTrSXViovmLj/UOgcIH4n11RW4LrKaLmGt2bGLHDf8es7nbxf2UIBZzrb6+tJZClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=GUErl1RZ; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 76D0A9C422B;
	Mon,  4 Mar 2024 21:27:06 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id LGf-g4yRHTxB; Mon,  4 Mar 2024 21:27:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0BB709C49D5;
	Mon,  4 Mar 2024 21:27:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0BB709C49D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1709605625; bh=RkpXqE9XRyAqX18Vp/lUDrOt5pgpgCQl2D2nYPx3pu4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=GUErl1RZTHwnh1cCXYyrTLnOG7pBh5dYSOokQmPBXjcA/NVfrnrbE+5ZSB7nuK8xH
	 14D8RdtDRK6SXg1S2fx6LN8DwDJq4+9MlDH12kt2TMMR+wsIuEirC78hHW7CjQZF08
	 mF7B6CyC8F6pLng4IplU5fdHqn9tBO8/ZM1J403rrFm0eAjWG08NZOgPVsQD+VAJUs
	 7yRXIIDQLPk1qNWuGmWezon2kJKuEGuTWiNqyGkiquzuxuGUXS3mmMfziC/kSpV1lD
	 VV5QVAbP0zw80BMaJ/XGsOC4R9mGVtwcj/G78b9IRUPFN8KaE89WBmXsOEu3jWohfV
	 /5SqLMWVCv7lA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LOzQ1csyfsyJ; Mon,  4 Mar 2024 21:27:04 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C232B9C422B;
	Mon,  4 Mar 2024 21:27:04 -0500 (EST)
Date: Mon, 4 Mar 2024 21:27:04 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	yilun xu <yilun.xu@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, mdf <mdf@kernel.org>, 
	Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <23887452.1534761.1709605624728.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <d377f0ea-2df2-4d4e-b1bc-8a4ca55eec15@linaro.org>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com> <20240221195058.1281973-3-charles.perry@savoirfairelinux.com> <4a9f0eef-590b-45df-92bc-b63ad9282e18@linaro.org> <1012793477.1508198.1709486517581.JavaMail.zimbra@savoirfairelinux.com> <cb51aadd-c350-42e2-9684-ac4f7dbf864c@linaro.org> <d377f0ea-2df2-4d4e-b1bc-8a4ca55eec15@linaro.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF123 (Linux)/8.8.15_GA_4581)
Thread-Topic: dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
Thread-Index: rJyWbF4Dp/Vu1Z8peWGRMOSlsVPpnQ==



On Mar 4, 2024, at 12:31 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:

> On 04/03/2024 08:30, Krzysztof Kozlowski wrote:
>> On 03/03/2024 18:21, Charles Perry wrote:
>>> On Feb 27, 2024, at 3:10 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org
>>> wrote:
>>>
>>>> On 21/02/2024 20:50, Charles Perry wrote:
>>>>> Document the SelectMAP interface of Xilinx 7 series FPGA.
>>>>>
>>>>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>>>>> ---
>>>>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
>>>>>  1 file changed, 86 insertions(+)
>>>>>  create mode 100644
>>>>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>> new file mode 100644
>>>>> index 0000000000000..08a5e92781657
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>> @@ -0,0 +1,86 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Xilinx SelectMAP FPGA interface
>>>>> +
>>>>> +maintainers:
>>>>> +  - Charles Perry <charles.perry@savoirfairelinux.com>
>>>>> +
>>>>> +description: |
>>>>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>>>>> +  parallel port named the SelectMAP interface in the documentation. Only
>>>>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
>>>>> +  the clock, with the MSB of each byte presented to the D0 pin.
>>>>> +
>>>>> +  Datasheets:
>>>>> +
>>>>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - xlnx,fpga-xc7s-selectmap
>>>>> +      - xlnx,fpga-xc7a-selectmap
>>>>> +      - xlnx,fpga-xc7k-selectmap
>>>>> +      - xlnx,fpga-xc7v-selectmap
>>>>> +
>>>>> +  reg:
>>>>> +    description:
>>>>> +      At least 1 byte of memory mapped IO
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  prog_b-gpios:
>>>>
>>>> I commented on this and still see underscore. Nothing in commit msg
>>>> explains why this should have underscore. Changelog is also vague -
>>>> describes that you brought back underscores, instead of explaining why
>>>> you did it.
>>>>
>>>> So the same comments as usual:
>>>>
>>>> No underscores in names.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Hello Krzysztof,
>>>
>>> Yes, I've gone full circle on that issue. Here's what I tried so far:
>> 
>> And what part of the commit description allows me to understand this?
>> 

I have a changelog in the cover letter:
https://lore.kernel.org/all/20240221195058.1281973-1-charles.perry@savoirfairelinux.com/

>>>
>>>  1) Reuse the same gpio names: Duplicates errors of the past, Krzysztof
>>>     doesn't like it.
>>>  2) Different gpio names for new driver only: Makes the driver code
>>>     overly complicated, Yilun doesn't like it.
>> 
>> That's a new driver, right? So what is complicated here? You have new
>> code and you take prog-b or prog_b?
>> 
>>>  3) Change gpio names for both drivers, deprecate the old names: Makes
>>>     the DT binding and the driver code overly complicated, Rob doesn't
>>>     like it.
>> 
>> I don't think I proposed changing existing bindings.
>> 
>>>
>>> I think that while the driver code shouldn't be the driving force for
>>> the DT spec, it can be a good indication that the spec is unpractical to
>>> implement.
>> 
>> What is impractical in implementing this? You just pass either A or B to
>> function requesting GPIO. Just choose proper name.
>>

It's not complicated but it requires more code than if "prog_b" had been
used. 
 
>>>
>>> In this case, there are two interfaces on a chip that uses the same GPIO
>>> protocol, it would only make sense that they use the same names, this
>>> discards solution #2.
>> 
>> I don't understand this. You have devm_gpiod_get() in your new code. Why
>> is it difficult to use different name?

Yilun asked to avoid changing the names between the two drivers.
First comment in this mail:
https://lore.kernel.org/all/Zb9GkY6cMtR+4xOX@yilunxu-OptiPlex-7050/

Yilun, let me know if this is something you'd accept as this is a concern
for the device tree maintainers.

> 
> And I forgot to emphasize: none of these is mentioned in commit msg, so
> for v5 you will get exactly the same complains. And for every other
> patch which repeats the same and does not clarify caveats or exceptions.
> 
> Best regards,
> Krzysztof

Should I keep my changelog in the individual commits? I thought the norm
was to put this the cover letter.

Regards,
Charles

