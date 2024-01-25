Return-Path: <linux-kernel+bounces-38718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C5C83C49E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D4C1C233BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85426341C;
	Thu, 25 Jan 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6XKEDD6"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE55C60D;
	Thu, 25 Jan 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192706; cv=none; b=OxjJ2NHhTDCatywo/Nw4eslkzo8boiJVty03q1eDWW2qYURJTPdIlCai4Kyiw+u/I/OFdQNJrJ7T+sBDbRw/ZAPG9SR+kd0PFRZvcL4wZy0s5XOyUObvE07WMFBqEMcfr2ghg/mX1ujeEADVEheM9Yp+XFOd8yBBGh703FLd4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192706; c=relaxed/simple;
	bh=KGLAirHlxaxNLl6c+ud0BFq34jV/liCx9KkdTcoUurY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzNg03MLdVXanoaCTq45UCXu0128WFraSeFejL2fpDwY93eSVVJ6rZCJ5DlO6LqPza/NgParQ8Pty+r9CmLSrZpxkuSVHN9cG8+32Jgg/HZpx9/gbYgBB21cEiUsO7rfmlbBvo/RRvEjIgZWDu/zEzOaPmi4BOD0/Ez5C+GXB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6XKEDD6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so1502995b3a.1;
        Thu, 25 Jan 2024 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706192703; x=1706797503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zpqP5sER0oQ1ctnx/TCuLAJ16oYKTBCC8iIqh3prnGc=;
        b=b6XKEDD69SN67Hed2HexlOwC9ZTKO96o6dB340v2gmV/BHCYH6zEHPposV3UuqN8zK
         2Pt0aOU0ytvdqGWa0Udi3FzdsCLAiP5ljifQORgVAc7m7shtSBEJYweeHV8NBl0azQSX
         oDIk71yjR9R/Gt5DB1HlIvMllFDD71YwYIpqm048TYvHvE98q6G4k3rxOGfv+GoaWc7e
         FwpHzjLn3ZkPmx1KexdMxQn2dmsndfXQ3LQQDaFEZIFZHMCIrh0YKIOXJiGPqiT8UU1U
         WA6Tp1iGKNeUFn7kWSXcP7rH1DSzwLAd28OgUUcssaBJneK7yBjhgzngWKn0N7nHhFa6
         c+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192703; x=1706797503;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpqP5sER0oQ1ctnx/TCuLAJ16oYKTBCC8iIqh3prnGc=;
        b=AXE+0sCyXemPD6SObnBcmGqcsTIODPe6XT8PiAyV6mrRqrMHUyV0ntiCUXxPEUyps5
         SiwoSYN50IeI6dUP2pIgSKUqFvRCjUCJn0a+aCPZSjA9W7gI+HkfrxA0A+cgkKOcGUA7
         m4XtdeEu3KmRw+TyEx8Bl846Bc46Bh7mYYBsbk7Be3OXSoi2Whb5Ql4Syhkw94iX3Nx0
         MfH5wnsFXZXYO/bYfLq7Pa837089aa1fX/VSCkU1YhNdWLfnAE9SN8B2ZaaOWrPM+fVi
         egcYNqoBSRb85BAu8KPtjgEdsco4CgUrBEYOdbZtg04MAEkVwQXHrH0lQfmW+pH5ohC2
         Doag==
X-Gm-Message-State: AOJu0Yz9dZtoNei1iQlXKYw55Ji55vBCF1fmyAnfplgBU4lid/Yw4bEt
	6NpyaNCnFrUQbw+IhdeSnJGLIhNfluurZC1KKCbfC5oKQ4/zdVtFLu/Whb4V
X-Google-Smtp-Source: AGHT+IF/68mbdJO/IZ0tml4XE/SslwpBXN78B4UBKY5cRn1R2pxb7M8PCh4uzsOol7JddvlO0S+mUw==
X-Received: by 2002:a05:6a20:43a1:b0:19a:55a8:c04a with SMTP id i33-20020a056a2043a100b0019a55a8c04amr1397836pzl.78.1706192703287;
        Thu, 25 Jan 2024 06:25:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b006dabe67bb85sm15856033pfj.216.2024.01.25.06.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 06:25:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <540cf4b3-ebf6-4a85-84c4-c012a69db416@roeck-us.net>
Date: Thu, 25 Jan 2024 06:25:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for thermal
 zones
Content-Language: en-US
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "groeck7@gmail.com" <groeck7@gmail.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240125064422.347002-1-peng.fan@oss.nxp.com>
 <b839f83f-c8c7-4fa8-8597-bdde1b40168a@roeck-us.net>
 <DU0PR04MB9417DAD2DBB8820344FEFB07887A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <DU0PR04MB9417DAD2DBB8820344FEFB07887A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/24 23:06, Peng Fan wrote:
> Hi Guenter,
> 
>> Subject: Re: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for
>> thermal zones
>>
>> On 1/24/24 22:44, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> The thermal sensors maybe disabled before kernel boot, so add
>>> change_mode for thermal zones to support configuring the thermal
>>> sensor to enabled state. If reading the temperature when the sensor is
>>> disabled, there will be error reported.
>>>
>>> The cost is an extra config_get all to SCMI firmware to get the status
>>> of the thermal sensor. No function level impact.
>>>
>>> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>
>>> V3:
>>>    Update commit log to show it only applys to thermal
>>>    Add comments in code
>>>    Add R-b from Cristian
>>>
>>
>> You didn't address my question regarding the behavior of hwmon attributes if
>> a sensor is disabled.
> 
> Would you please share a bit more on what attributes?
> You mean the files under /sys/class/hwmon/hwmon0?
> 
> If the sensor is disabled, when cat temp[x]_input, it will
> report:
> root@imx95-19x19-lpddr5-evk:/sys/class/hwmon/hwmon0# cat temp3_input
> cat: temp3_input: Protocol error
> 
> For enabled, it will report value:
> root@imx95-19x19-lpddr5-evk:/sys/class/hwmon/hwmon0# cat temp1_input
> 31900
> 

This is wrong. If the sensor is disabled, there should either be no
sensor attribute (if the condition is permanent), or there should be
tempX_enable attribute(s) which return the sensor status (and, if
appropriate, permit it to be enabled). If the condition is not
permanent, attempts to read the sensor value should return -ENODATA.

Overall, hwmon functionality is orthogonal to thermal subsystem use.
It is not appropriate for the thermal subsystem to disable any
temperature sensors in the hwmon subsystem because the user might
expect to be able to read temperatures from hwmon devices even
if sensors are not in use by the thermal subsystem.

Thanks,
Guenter


