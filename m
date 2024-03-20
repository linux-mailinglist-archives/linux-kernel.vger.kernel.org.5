Return-Path: <linux-kernel+bounces-108892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1A881175
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AF41F24377
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C0D3FB3E;
	Wed, 20 Mar 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="YBf9YfYa"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E1347B6;
	Wed, 20 Mar 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936340; cv=none; b=cFXWOPNzC3PQX8iHQdGel+shKaVt7dAVKaoljSk5PhlMqLMjMmAHtn9QLjptB/KCPlNS8xm9YGtzOrr+hzWaUGPHFcn4UZPNg0SthDJqjhiUicvjtEQfd06rqOBN7LHmznWCzg8CA5Z9aUBwFnTHwWddFz4TKN+EdnZnn1zzRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936340; c=relaxed/simple;
	bh=Bv0vnDFIE4l1ckdc9yIZADTw7OuOYa398zh7BG+c0nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXvXPLCk/uEc/bWb1fOAnFai2+l6Q+/N8j2RepMBDWGJ3mLJQ4ChL9RRGI1A6bkZoREXirJgAIWgf1dXCodYIsNqVja+tMAb7XmbQsW0IDpzvCafyV10cJWG/7PxYmVfeCK/fwl4dn1cmEppvDQkaJ+I3my5ie4TCpQskg2d5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=YBf9YfYa; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V38z3dXzsoQdcHr/9aA6f+pJAC6EF/1U7YiXTRMIxXU=; b=YBf9YfYaD5mjsz6HfDj0lOx/CH
	nXV3cytfORkWXz5TQdmOvMyeR4Vm97N+ozlYxZuCjIrJjMclEaUoW+dGMjBmVg+IVjEb8eOCgjPgH
	D+F9RRP561uQOl41AdIbH1PkB/d9OqsU8kMznFzVnEDax/yDaAZJh5P1d8HIOxVVqBczvv0cQYNdM
	hZNY1NIDJ6rxbu6LShFZbj8Z9ap47jRep0KpRjzduKJtdW2WIg/rEdsz9ZtnA5tmPkrtDcXMhLVoj
	/+5gRhMa/oMz7DOSGzR4BGGWfkGG6VUQsWMpVDMNFJhUcHabSBVkkDk1o2zSsL4+xZasKDg/FRyAH
	YmPCmdIQ==;
Received: from [89.212.21.243] (port=54340 helo=[192.168.69.84])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1rmuhG-005rRw-0q;
	Wed, 20 Mar 2024 13:05:30 +0100
Message-ID: <e994b756-7f4e-4be3-b8f3-310988174b44@norik.com>
Date: Wed, 20 Mar 2024 13:05:29 +0100
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
From: Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <38637621-1611-4268-ae79-7ac93a72c5ee@linaro.org>
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

Hi Krzysztof,

On 20. 03. 24 11:26, Krzysztof Kozlowski wrote:
> On 20/03/2024 11:04, Andrej Picej wrote:
>> Document calibration properties and how to set them.
> 
> Bindings are before users.

will change patch order when I send a v2.

> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
> There is no file extension in prefixes.

So: dt-bindings: iio/adc: nxp,imx93-adc: Add calibration properties?

> 
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>>   .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>> index dacc526dc695..64958be62a6a 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>> @@ -46,6 +46,21 @@ properties:
>>     "#io-channel-cells":
>>       const: 1
>>   
>> +  nxp,calib-avg-en:
>> +    description:
>> +      Enable or disable averaging of calibration time.
>> +    enum: [ 0, 1 ]
>> +
>> +  nxp,calib-nr-samples:
>> +    description:
>> +      Selects the number of averaging samples to be used during calibration.
>> +    enum: [ 16, 32, 128, 512 ]
>> +
>> +  nxp,calib-t-samples:
>> +    description:
>> +      Specifies the sample time of calibration conversions.
>> +    enum: [ 8, 16, 22, 32 ]
> 
> No, use existing, generic properties. Open other bindings for this.

You mean I should use generic properties for the ADC calibration 
settings? Is there already something in place? Because as I understand 
it, these calib-* values only effect the calibration process of the ADC.

> 
> Also, none of these were tested. I am not going to review such untested
> code.
> 
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.

You are right, I did not run the dt_binding_check, sorry for this, 
forgot that this existed. I see now I have to add the:
> $ref: /schemas/types.yaml#/definitions/uint32

Will fix in v2.

BR,
Andrej

> 
> Best regards,
> Krzysztof
> 

