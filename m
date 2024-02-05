Return-Path: <linux-kernel+bounces-53070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADAB84A054
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E85A1C2118C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A2E446BA;
	Mon,  5 Feb 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fehtOmAd"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6A3A1CF;
	Mon,  5 Feb 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153111; cv=none; b=ETO1qnmZPkyDH21SisU4GaKvd7kqhHykpU1U70sJWfVDbHg3cWTxd6fxMIi6h36JnKJosZFdwG5rmJ3NzBbST/0xRyr7EzbaPq88v/O2rH4X21zr42+T64tJs+cFnTiwtNBhb3wz9RA2GxXu/DuqPtwKxgzlPuicr3rIh5khAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153111; c=relaxed/simple;
	bh=Awte8akpLUNHQe0faNphLZYfif31G1qy7XsQIjEMlxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBzPXC+kFWKJk+xBLpTf/tBQ3DtWkLitXHMg9/RH1zRI7RR/Y3ShNtMA0s2pHUKm0Rtfr/vdzpR/0saC6VJF65h6EZEz8SVH9WqA1Xi0TyWUYd1XKe3rAyuQk+WZCYYEqhDNFt8Rg5xdW93VahmUPzkKURBOpVWglASW75t0H3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fehtOmAd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so3839673a12.1;
        Mon, 05 Feb 2024 09:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153108; x=1707757908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8emTOhOdFKSiQd0VegyBxbgGNUkK/uhZR5gAmWtAzco=;
        b=fehtOmAdfMoxhaXRk9j39VLmHtU1HY12tRtBPwOIxNeGhLPSbenw0/vByyQ4ZFvRrY
         yAtlsq0oq8iQemvr/uU6EgtobueeR/llswTbUK7p1O/Cg84WpNsywDTn35bSMoP3/PJj
         ua6oE9Mgr/1ePK6ZhX9EnEm3SG+cfjRvaD7bTOxRiD8flLXYq9lL1gVNpULyJEVtYw5m
         0+AhEuPaXEvviaPzc1E6QfrydfVVbfEXdTy48hGZbARBVPoyFPSKStx+vOuvBHFUw/HM
         htb8tCad/xNVwrJyM9wAjOcK0KU5MYN+qNDFXPR1Nm49gjpafefVVeRJh+usTgW4rXpD
         669g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153108; x=1707757908;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8emTOhOdFKSiQd0VegyBxbgGNUkK/uhZR5gAmWtAzco=;
        b=jktN0Hw5DC9Tz9/jwV32smq115iDIgqLV2XSs/qpRcti7Qg3QosFkZ3lv9/W6eVwru
         paU2x/wWG65B0JQa4g8v0uqFaLPD3VC5JR/KblXivRfSwbtsfKaI4Tatgwg8kGloi5zE
         +Xd/sB5AtQIoT3B2rVNhWhCXqBMcAGpwm7IES+1/kDEdEiL0BDtVSJ0JWX7ccZf/PrjK
         Xf8y/do7bDG1czvmkUmrekHRFGSrdTvMqqc9noGbXRYjFc1s5NrT46grdTwlzt5H8Jts
         DR3R4f5NZ41rSzQlv0N/D5oK0mYQbEaH2h2OMdEObVhDxw/SNJZNuY6tGcS8ZaJzuAcR
         M5FA==
X-Gm-Message-State: AOJu0YxKQualCLXuvoNG5OGeVu6tUi2pQ7bZgjj4aVIsQPRDFLvt97fJ
	YER50udZ6SUsLu67t/ODPe5sWW/3YpqAZpe32IB/i4p1cReHrgBo
X-Google-Smtp-Source: AGHT+IGLp8gfCwEdCqyBNU57ZNsmuHsUosy+Eo5ZK7DGob8NUOLE5/AdYQNqDjm8AjTWFKrqPbm6ZA==
X-Received: by 2002:a05:6a20:4ba4:b0:19e:4f91:42b2 with SMTP id fu36-20020a056a204ba400b0019e4f9142b2mr110114pzb.18.1707153108388;
        Mon, 05 Feb 2024 09:11:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWfUWuSZj+Z3wSHsVWQ5uujFFqi5BBw31Zvlqnmgq9K9L1ZF+KREFh6fxywZHt7jICMz1idgEffzt0/PmOPMlAjE+d3T2KWHPGUL5UNlXGjB1WjXA67PNZjzYZ3sFL/7jZvpISCBGqlMm8QtISjGH4130yns1GCr/YREMDBfc1GklcZBwVWhyTcnVP4d5ki+Xu1ap1NxmjGxlMk+Hoy8R6TpoZEJaByxefFLDTToB0B6N+400eJgcX8hUeFUz9vCRkClr9YBhH1bm70TuFcU2+7AtN7rOd1QBSGSVwYRS0FdNvw1tTrqCvMIZwpnmZ20pWoYMhedAxQ7n1rh+czWtY15fATDhZ4Jn5cCJ4Lpyodb2BVDd+jYl6EYFc=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006e02eb7fb05sm69298pfv.160.2024.02.05.09.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 09:11:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8cffdf64-d0ee-4e20-8c43-d3010ddf9839@roeck-us.net>
Date: Mon, 5 Feb 2024 09:11:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] usb: typec: tcpci: add support to set connector
 orientation
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20240205164316.805408-1-m.felsch@pengutronix.de>
 <20240205164316.805408-5-m.felsch@pengutronix.de>
 <ZcESKqRTsGNZMMX1@gallifrey> <20240205165420.kyujim2takwswzmw@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240205165420.kyujim2takwswzmw@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/24 08:54, Marco Felsch wrote:
> Hi David,
> 
> On 24-02-05, Dr. David Alan Gilbert wrote:
>> * Marco Felsch (m.felsch@pengutronix.de) wrote:
>>> This add the support to set the optional connector orientation bit which
>>> is part of the optional CONFIG_STANDARD_OUTPUT register 0x18 [1]. This
>>> allows system designers to connect the tcpc orientation pin directly to
>>> the 2:1 ss-mux.
>>>
>>> [1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>>   drivers/usb/typec/tcpm/tcpci.c | 43 ++++++++++++++++++++++++++++++++++
>>>   include/linux/usb/tcpci.h      |  8 +++++++
>>>   2 files changed, 51 insertions(+)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
>>> index 7118551827f6..7ce9d4923bc7 100644
>>> --- a/drivers/usb/typec/tcpm/tcpci.c
>>> +++ b/drivers/usb/typec/tcpm/tcpci.c
>>> @@ -67,6 +67,18 @@ static int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)
>>>   	return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u16));
>>>   }
>>>   
>>> +static bool tcpci_check_std_output_cap(struct regmap *regmap, u8 mask)
>>> +{
>>> +	unsigned int reg;
>>> +	int ret;
>>> +
>>> +	ret = regmap_read(regmap, TCPC_STD_OUTPUT_CAP, &reg);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	return (reg & mask) == mask;
>>> +}
>>> +
>>>   static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
>>>   {
>>>   	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>>> @@ -301,6 +313,27 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
>>>   			   TCPC_TCPC_CTRL_ORIENTATION : 0);
>>>   }
>>>   
>>> +static int tcpci_set_orientation(struct tcpc_dev *tcpc,
>>> +				 enum typec_orientation orientation)
>>> +{
>>> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>>> +	unsigned int reg;
>>> +
>>> +	switch (orientation) {
>>> +	case TYPEC_ORIENTATION_NONE:
>>> +		/* We can't put a single output into high impedance */
>>
>> Is that intended to be a fallthrough? If so I guess it needs
>> marking as such with a
>>                  fallthrough;
> 
> You need to add it if there is code in between. Since there is no code,
> just this comment, it shouldn't be necessary.
> 

Still, I think it would be desirable here to clarify that this
is not a lost return but intentionally sets
TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL.

Guenter

> Regards,
>    Marco
> 
>>
>> Dave
>>
>>> +	case TYPEC_ORIENTATION_NORMAL:
>>> +		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL;
>>> +		break;
>>> +	case TYPEC_ORIENTATION_REVERSE:
>>> +		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED;
>>> +		break;
>>> +	}
>>> +
>>> +	return regmap_update_bits(tcpci->regmap, TCPC_CONFIG_STD_OUTPUT,
>>> +				  TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK, reg);
>>> +}
>>> +
>>>   static void tcpci_set_partner_usb_comm_capable(struct tcpc_dev *tcpc, bool capable)
>>>   {
>>>   	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>>> @@ -808,6 +841,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>>>   	if (tcpci->data->vbus_vsafe0v)
>>>   		tcpci->tcpc.is_vbus_vsafe0v = tcpci_is_vbus_vsafe0v;
>>>   
>>> +	if (tcpci->data->set_orientation)
>>> +		tcpci->tcpc.set_orientation = tcpci_set_orientation;
>>> +
>>>   	err = tcpci_parse_config(tcpci);
>>>   	if (err < 0)
>>>   		return ERR_PTR(err);
>>> @@ -851,6 +887,13 @@ static int tcpci_probe(struct i2c_client *client)
>>>   	if (err < 0)
>>>   		return err;
>>>   
>>> +	err = tcpci_check_std_output_cap(chip->data.regmap,
>>> +					 TCPC_STD_OUTPUT_CAP_ORIENTATION);
>>> +	if (err < 0)
>>> +		return err;
>>> +
>>> +	chip->data.set_orientation = err;
>>> +
>>>   	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
>>>   	if (IS_ERR(chip->tcpci))
>>>   		return PTR_ERR(chip->tcpci);
>>> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
>>> index 467e8045e9f8..f2bfb4250366 100644
>>> --- a/include/linux/usb/tcpci.h
>>> +++ b/include/linux/usb/tcpci.h
>>> @@ -47,6 +47,9 @@
>>>   #define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
>>>   
>>>   #define TCPC_CONFIG_STD_OUTPUT		0x18
>>> +#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK		BIT(0)
>>> +#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL	0
>>> +#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED	1
>>>   
>>>   #define TCPC_TCPC_CTRL			0x19
>>>   #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
>>> @@ -127,6 +130,7 @@
>>>   #define TCPC_DEV_CAP_2			0x26
>>>   #define TCPC_STD_INPUT_CAP		0x28
>>>   #define TCPC_STD_OUTPUT_CAP		0x29
>>> +#define TCPC_STD_OUTPUT_CAP_ORIENTATION	BIT(0)
>>>   
>>>   #define TCPC_MSG_HDR_INFO		0x2e
>>>   #define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
>>> @@ -198,12 +202,16 @@ struct tcpci;
>>>    *		Chip level drivers are expected to check for contaminant and call
>>>    *		tcpm_clean_port when the port is clean to put the port back into
>>>    *		toggling state.
>>> + * @set_orientation:
>>> + *		Optional; Enable setting the connector orientation
>>> + *		CONFIG_STANDARD_OUTPUT (0x18) bit0.
>>>    */
>>>   struct tcpci_data {
>>>   	struct regmap *regmap;
>>>   	unsigned char TX_BUF_BYTE_x_hidden:1;
>>>   	unsigned char auto_discharge_disconnect:1;
>>>   	unsigned char vbus_vsafe0v:1;
>>> +	unsigned char set_orientation:1;
>>>   
>>>   	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>>>   	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
>>> -- 
>>> 2.39.2
>>>
>>>
>> -- 
>>   -----Open up your eyes, open up your mind, open up your code -------
>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>> \        dave @ treblig.org |                               | In Hex /
>>   \ _________________________|_____ http://www.treblig.org   |_______/
>>


