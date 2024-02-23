Return-Path: <linux-kernel+bounces-78287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322CF861168
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3A41F23A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2837A7BAF1;
	Fri, 23 Feb 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVFSwK4P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BD7AE7F;
	Fri, 23 Feb 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691004; cv=none; b=LQvs8mEJb4lyuWpZnTYOuM4Rqyh2kpecwPg2UzHPilPs3pxr3zYGXytGvXu5Y+XquPnYmZP2zqURjIVo3Uh2trFK50LocAps3gL0IrvPS+9tBHneGn8xnYwg9nbHVIXeHcEQxI7/uFibwUofUZe1wM6mRiH+eLGcYOwUf1VZxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691004; c=relaxed/simple;
	bh=jBv4wd3ZvW6WVr4TLRl9Rw72Hhuloc/Mhh9BlEV2V7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7DPHGmSKioV9/2fUZJsq71fAGXLI+qRDMn2RSpnAE1nX6yq3eEgKGi2etGRzCqEtV0QJ7bsPISeEHV3fktqtnM1A1CVLf8Y/TmwMl94rV5Gef78FVZdnc22H8GmRlGPMUQe+pQio5fiEkaq6lS8w9oN1NFZvTx1Lf4YuvgX3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVFSwK4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAB6C433C7;
	Fri, 23 Feb 2024 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708691003;
	bh=jBv4wd3ZvW6WVr4TLRl9Rw72Hhuloc/Mhh9BlEV2V7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KVFSwK4PQXDajVINno8VmeoO/EBzorQfgFT13T5ERCXdjAe6hBhxh0qo1xeQe8j9S
	 r8jsWo3CNVMH6GePwGCGHG7TJIMzMbzJxy3q7Tqwg9ahxXn6R16p2FdkQgFlY87OOh
	 IKWfHeI+tu4l6yiz96HG7auJ1LBlz4DUlg7K2uyz5ChSTvjwnyq+0B2NYenJC/RIxS
	 y1RR3wBUWVD+bURBvUsGQ2KTmbHEPY5TEL34xjRRjbWd2hYM+sIuvveYeGmwK1RhHl
	 9KQNffAcgyvrs+8jpbVkt5MybZDQ6I+DOUktk1Wfbo6z5C/REuUySTFCoaKmIN9Pv0
	 rC/cnG90h6Anw==
Message-ID: <5b65da27-c1c9-4d91-87d4-08073ff220d7@kernel.org>
Date: Fri, 23 Feb 2024 14:23:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl
 compatible
To: Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com
Cc: afd@ti.com, kristo@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
 r-gunasekaran@ti.com, b-liu@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>
References: <20240205135908.54656-1-rogerq@kernel.org>
 <20240205135908.54656-2-rogerq@kernel.org>
 <8a1efca0-9a63-472a-8c0f-0aeb3efa2baa@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <8a1efca0-9a63-472a-8c0f-0aeb3efa2baa@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vignesh,

On 22/02/2024 10:51, Vignesh Raghavendra wrote:
> Hi Roger,
> 
> On 05/02/24 19:29, Roger Quadros wrote:
>> Add the compatible for TI AM62 USB PHY Control register. This
>> register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
>> is used to indicate the USB PHY PLL reference clock rate and
>> core voltage level to the USB controller.
>>
>> [1] - https://www.ti.com/lit/pdf/spruiv7
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>
>> Notes:
>>     Changelog:
>>     
>>     v4 - no change. Added Rob's Acked-by
>>     
>>     v3 - add compatibles in alphabetical order
>>     https://lore.kernel.org/all/20240201120332.4811-2-rogerq@kernel.org/
>>     
>>     v2 - New patch
>>
>>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> 
> You don't have right maintainer in CC for this file.

I'll resend this series with Acks and updated CC list.

> 
>> index 084b5c2a2a3c..9437705af92f 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> @@ -72,6 +72,7 @@ properties:
>>                - rockchip,rk3588-qos
>>                - rockchip,rv1126-qos
>>                - starfive,jh7100-sysmain
>> +              - ti,am62-usb-phy-ctrl
>>                - ti,am654-dss-oldi-io-ctrl
>>  
>>            - const: syscon
> 

-- 
cheers,
-roger

