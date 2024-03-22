Return-Path: <linux-kernel+bounces-111260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3008869D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF44A1C2255F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC40282FE;
	Fri, 22 Mar 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="DBX7q0i8"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1D39854;
	Fri, 22 Mar 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101543; cv=none; b=O1prgql9nkdtWpZU8+6gjhcEEM8NVfiyPKSa1LP3EmH7DrNz5o9jT0IDhGcPz7z54YSzDZg6lx3kyWssUY6qM9OG9fVaeQguzZc0Dw4XM5TzRT9cKWaW6WUQfEElMIdi5mcQOVaBv/eqB+5h+lojUuVVkv6szdOmXCqMB1ppKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101543; c=relaxed/simple;
	bh=snSfJ5AEfJHDPAVmOuKibdE9ybjzZy8eOI7cRfFLAgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8S78l6c18tuFgudDNaS7ielehWLHwm37xIJbFnIu/2w1JGuHvIXauYZeZHF6JyTSu0jlCb7Q4NbDEGtQjXzDcXteFz0xDzifMDRZkdIH1ZQHKMT07BJGs/iXSvUF21VMXB4LUSvnxDGsKmhShl+5mVXSDwzx6CtYVojzVUFnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=DBX7q0i8; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yzXvXf84t5xedKkjpoUQe3At33UjMGBnjxJCS2m3Aho=; b=DBX7q0i8YZtNwO6PSSaLlw49o1
	V1an/mgH+UuZNViR2IPATvhExnpVYVBCaTstrG8ousCWpKY8LVQxP4iA0pWCLU7mlCmZkWtW8KsW7
	ArSqZtTY7hJwqKo828YNyXtEFQdybQPr56E6vs69If8RCNLIu0/pCv4UAq5/AljNpWZ5d6gt1V0ZT
	dUBO9tnaV0GX1LevYNBFaqQW5nOLi2tBhxb9L/ky1JhB2ZgUCz2PJ9lDZcdxnOgtKpdttkbcxLe2H
	JGG5ZdSA8d/9iXyY9IMuu/1o4VKYmubbqXGiiZxRYsx2R8YnpTlyiTN+IYhEOaWMrI7qwJFSf0A6X
	mgdAEDQA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:44576 helo=[192.168.69.84])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1rnbfu-00Ev5q-2H;
	Fri, 22 Mar 2024 10:58:57 +0100
Message-ID: <1bbd4fdf-59c5-42b2-8698-95f402645c67@norik.com>
Date: Fri, 22 Mar 2024 10:58:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add
 calibration properties
Content-Language: en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, haibo.chen@nxp.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 upstream@lists.phytec.de
References: <20240320100407.1639082-1-andrej.picej@norik.com>
 <20240320100407.1639082-3-andrej.picej@norik.com>
 <38637621-1611-4268-ae79-7ac93a72c5ee@linaro.org>
 <e994b756-7f4e-4be3-b8f3-310988174b44@norik.com>
 <7e58bf96-3c38-467f-86b6-06ff5feedb31@linaro.org>
 <40e08a5e-e7e9-47c7-9102-24a2bbba67cf@norik.com>
 <a1b173c0-5120-40f6-9708-cd810b4a2406@linaro.org>
From: Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <a1b173c0-5120-40f6-9708-cd810b4a2406@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 22. 03. 24 09:14, Krzysztof Kozlowski wrote:
> On 22/03/2024 08:39, Andrej Picej wrote:
>> On 20. 03. 24 13:15, Krzysztof Kozlowski wrote:
>>> On 20/03/2024 13:05, Andrej Picej wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 20. 03. 24 11:26, Krzysztof Kozlowski wrote:
>>>>> On 20/03/2024 11:04, Andrej Picej wrote:
>>>>>> Document calibration properties and how to set them.
>>>>>
>>>>> Bindings are before users.
>>>>
>>>> will change patch order when I send a v2.
>>>>
>>>>>
>>>>> Please use subject prefixes matching the subsystem. You can get them for
>>>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>>>> your patch is touching.
>>>>> There is no file extension in prefixes.
>>>>
>>>> So: dt-bindings: iio/adc: nxp,imx93-adc: Add calibration properties?
>>>
>>> Did you run the command I proposed? I don't see much of "/", but except
>>> that looks good.
>>
>> Ok noted.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>>>>> ---
>>>>>>     .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
>>>>>>     1 file changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>>> index dacc526dc695..64958be62a6a 100644
>>>>>> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>>> @@ -46,6 +46,21 @@ properties:
>>>>>>       "#io-channel-cells":
>>>>>>         const: 1
>>>>>>     
>>>>>> +  nxp,calib-avg-en:
>>>>>> +    description:
>>>>>> +      Enable or disable averaging of calibration time.
>>>>>> +    enum: [ 0, 1 ]
>>>>>> +
>>>>>> +  nxp,calib-nr-samples:
>>>>>> +    description:
>>>>>> +      Selects the number of averaging samples to be used during calibration.
>>>>>> +    enum: [ 16, 32, 128, 512 ]
>>>>>> +
>>>>>> +  nxp,calib-t-samples:
>>>>>> +    description:
>>>>>> +      Specifies the sample time of calibration conversions.
>>>>>> +    enum: [ 8, 16, 22, 32 ]
>>>>>
>>>>> No, use existing, generic properties. Open other bindings for this.
>>>>
>>>> You mean I should use generic properties for the ADC calibration
>>>> settings? Is there already something in place? Because as I understand
>>>> it, these calib-* values only effect the calibration process of the ADC.
>>>
>>> Please take a look at other devices and dtschema. We already have some
>>> properties for this... but maybe they cannot be used?
>>>
>>
>> I did look into other ADC devices, grep across iio/adc, adc bindings
>> folders and couldn't find anything closely related to what we are
>> looking for. Could you please point me to the properties that you think
>> should be used for this?
> 
> Indeed, there are few device specific like qcom,avg-samples. We have
> though oversampling-ratio, settling-time-us and min-sample-time (which
> is not that good because does not use unit suffix).

Ok, these are examples but I think I should not use them, since these 
are i.MX93 ADC specific settings, which are used for configuration of 
calibration process, and are not related to the standard conversion 
process during runtime. Calibration process is the first step that 
should be done after every power-on reset.

> 
> Then follow up questions:
>   - nxp,calib-avg-en: Why is it a board-level decision? I would assume
> this depends on user choice and what kind of input you have (which could
> be board dependent or could be runtime decision).

Not really sure I get your question, so please elaborate if I missed the 
point.
This is a user choice, to enable or disable the averaging function in 
calibration, but this is a board-level decision, probably relates on 
external ADC regulators and input connections. The same options are used 
for every ADC channel and this can not be a runtime decision, since 
calibration is done before the ADC is even registered.

>   - nxp,calib-t-samples: what does it mean? Time is expressed in time
> units, but there is nothing about units in the property name.
> 

You are right, basically this is "time" in cycles of AD_CLK. I should at 
least add that to the property description.

Best regards,
Andrej Picej

