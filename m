Return-Path: <linux-kernel+bounces-111072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCBD886793
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA506283FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207112E73;
	Fri, 22 Mar 2024 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="ntplgsJt"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271E6FB0;
	Fri, 22 Mar 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093154; cv=none; b=vFYIEUP5G00dEZ409BrhyvW0/SdtOM7m6GLIPahgbYdiWw2v+/ho16M3oO1nkbTe8iSC7huBOm5hMA2OQWlbXGATNcJ5n2Zodc1rmLUOjnruCzw5SrAYReru1Hy0D543Mc+w7lD3sd2J+A+F1dpzFEPWbX5GjKKQU+kUw+8SAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093154; c=relaxed/simple;
	bh=74IY4W2ReJ+EBD6XqkKEfxqxu9pBcnlGD0ss0VXKhTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaxTvPumt0lZr4qdd49l3FTfCmA1KyEtTCIndDc4YfEEOSrEzNQ46NKTqB7w2jXVzPnyxW/fpAGIojC/ThJpv5H8z1LH08unGKymrNlT5kjwyb9H1Zt934mGRWPw34phlLKqoERqd9cho35wW3tkuXA8Hz9h/UOsMj6iy7i7A+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=ntplgsJt; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XmDDFMU/4E1etv5sIVB4WfwFGi7VCAGsEJBu9uRrii4=; b=ntplgsJtLpus/vc2992ovayXVr
	xY1h7gl0F9U4X7qnD9MaEwn3gzMxCaBv+BE0Ew/TFtNB1JxSD60Mj9yDNW3SP9AMBEQMRneN367ff
	F4gZ7pKaaPdB4xtX0OZ37aS5zwe8qbY4CH110T5xAOYHvLUKElqzQuAnXr7J9+5kuz3cEHSpmWnCj
	AECN7w7n+GLIYFfRPhwS/AnY/E9DIWaMZDTiffyWnxvdprQbrv94BoZurPD+F7TRSLRtbDe0FXfbH
	MDmq6ytMd+SaaPh8AeImdbmWqu28kvm3rORB01SIRvaRIf0sZ3nUJ8HloT0yxwX3Oa5BZHqOf47wX
	OQB5UT7Q==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:55020 helo=[192.168.69.84])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1rnZUV-00EHuV-2e;
	Fri, 22 Mar 2024 08:39:02 +0100
Message-ID: <40e08a5e-e7e9-47c7-9102-24a2bbba67cf@norik.com>
Date: Fri, 22 Mar 2024 08:39:01 +0100
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
From: Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <7e58bf96-3c38-467f-86b6-06ff5feedb31@linaro.org>
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

On 20. 03. 24 13:15, Krzysztof Kozlowski wrote:
> On 20/03/2024 13:05, Andrej Picej wrote:
>> Hi Krzysztof,
>>
>> On 20. 03. 24 11:26, Krzysztof Kozlowski wrote:
>>> On 20/03/2024 11:04, Andrej Picej wrote:
>>>> Document calibration properties and how to set them.
>>>
>>> Bindings are before users.
>>
>> will change patch order when I send a v2.
>>
>>>
>>> Please use subject prefixes matching the subsystem. You can get them for
>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>> your patch is touching.
>>> There is no file extension in prefixes.
>>
>> So: dt-bindings: iio/adc: nxp,imx93-adc: Add calibration properties?
> 
> Did you run the command I proposed? I don't see much of "/", but except
> that looks good.

Ok noted.

> 
>>
>>>
>>>>
>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>>> ---
>>>>    .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>> index dacc526dc695..64958be62a6a 100644
>>>> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>> @@ -46,6 +46,21 @@ properties:
>>>>      "#io-channel-cells":
>>>>        const: 1
>>>>    
>>>> +  nxp,calib-avg-en:
>>>> +    description:
>>>> +      Enable or disable averaging of calibration time.
>>>> +    enum: [ 0, 1 ]
>>>> +
>>>> +  nxp,calib-nr-samples:
>>>> +    description:
>>>> +      Selects the number of averaging samples to be used during calibration.
>>>> +    enum: [ 16, 32, 128, 512 ]
>>>> +
>>>> +  nxp,calib-t-samples:
>>>> +    description:
>>>> +      Specifies the sample time of calibration conversions.
>>>> +    enum: [ 8, 16, 22, 32 ]
>>>
>>> No, use existing, generic properties. Open other bindings for this.
>>
>> You mean I should use generic properties for the ADC calibration
>> settings? Is there already something in place? Because as I understand
>> it, these calib-* values only effect the calibration process of the ADC.
> 
> Please take a look at other devices and dtschema. We already have some
> properties for this... but maybe they cannot be used?
> 

I did look into other ADC devices, grep across iio/adc, adc bindings 
folders and couldn't find anything closely related to what we are 
looking for. Could you please point me to the properties that you think 
should be used for this?

Thank you.
Andrej

> 
> Best regards,
> Krzysztof
> 

