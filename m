Return-Path: <linux-kernel+bounces-762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE20E8145AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA551C230F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721E41C292;
	Fri, 15 Dec 2023 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/JAPf3F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783011A711
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so5351435e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702636384; x=1703241184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ES/8p7dj8eOpjaZIO5AxTsTeaONrf5FeKxZa57MxFr4=;
        b=j/JAPf3F4xmeQ5oJrVeBsq40OArbqkwIaWImt6ndiU+9HXUxza+0oHybyLBBWb7iLD
         3LWY+XWh98tkEVHnVepuzJh73KRcUQIThfuG1jguVISHmjigKzIN9AYrWGAwDL68dbpQ
         X8+q2BXkjPu45n1eRxH0aK1tWBPM91QDKCGn/prPQDK+C8tCgUe529aR9uoCsm3ahgTf
         kR2LiCHE35/kcYdFHddwdCvxGSxtHhIElQJJSllyoUV7WVlj2xNH/7bajWKqVWiapJXo
         NVAtu0njUgQoFos2EhqZeTuFf/19ZZs0ouUSWh864RYuy6+NFiawZfQ/sp2O/Hrou1Uw
         XGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702636384; x=1703241184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ES/8p7dj8eOpjaZIO5AxTsTeaONrf5FeKxZa57MxFr4=;
        b=lQStrMIb0OULyQQ0Jegq4XoDFlP+uc/OZD1WkPQ/MjjD93gMN+bpMcqKYwj6W0UK4A
         rnKswq9+v5U18dyTj9KmqDLUqIZdyZ8E0eKgvrors/1mXCCcMRkmCFS8OevH4h7C9T/C
         B/S8nYI9HIFrggrwJzbI3wx7OpIoy/F8zd9BtghoQ8DZP2Fd+EnpaMIH+3+Zh2aKgr4m
         qjINxfQPJvU5nGHQkzSDOsc88jse9BUS01A4Eb+WPe3x4MG+6Pg8TnaFlrgPiV3Sh7zQ
         e+nr9QxS8fc/wUh8+sHd8PmnwvJJ7DYKeGcdXi4PG2I0se/kEdkLkwHzpN6sWWgGg+LA
         lSlg==
X-Gm-Message-State: AOJu0YxhFpov0E8BKFHdy2qRLE/2WH0KcEjGx+Z4kyJsMuQ6rCrGwE26
	1uJ7HriBUZSmiw1Haf9a9GC5Ww==
X-Google-Smtp-Source: AGHT+IHvCqTZH8cLyqj3W3/o6f8ZEmQnes53EWvbWxmoY2pWUTbH0iPJoL/UA8Y2YFnwr+nIL2HHIA==
X-Received: by 2002:a05:600c:221a:b0:40c:3306:c300 with SMTP id z26-20020a05600c221a00b0040c3306c300mr5703334wml.62.1702636383695;
        Fri, 15 Dec 2023 02:33:03 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c34cd00b0040c496c64cfsm18468670wmq.12.2023.12.15.02.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 02:33:03 -0800 (PST)
Message-ID: <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
Date: Fri, 15 Dec 2023 10:33:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
 "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michael@walle.cc" <michael@walle.cc>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/23 10:02, Mahapatra, Amit Kumar wrote:
> Hello Tudor,

Hi,

> 
>> -----Original Message-----
>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Sent: Friday, December 15, 2023 1:40 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>> broonie@kernel.org; pratyush@kernel.org; miquel.raynal@bootlin.com;
>> richard@nod.at; vigneshr@ti.com; sbinding@opensource.cirrus.com;
>> lee@kernel.org; james.schulman@cirrus.com; david.rhodes@cirrus.com;
>> rf@opensource.cirrus.com; perex@perex.cz; tiwai@suse.com
>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> michael@walle.cc; linux-mtd@lists.infradead.org;
>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>; linux-
>> arm-kernel@lists.infradead.org; alsa-devel@alsa-project.org;
>> patches@opensource.cirrus.com; linux-sound@vger.kernel.org; git (AMD-
>> Xilinx) <git@amd.com>; amitrkcian2002@gmail.com
>> Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support
>> in spi-nor
>>
>>
>>
>> On 15.12.2023 09:55, Mahapatra, Amit Kumar wrote:
>>>> Thanks! Can you share with us what flashes you used for testing in
>>>> the stacked and parallel configurations?
>>> I used SPI-NOR QSPI flashes for testing stacked and parallel.
>>
>> I got that, I wanted the flash name or device ID.
> 
> N25Q00A, MX66U2G45G, IS25LP01G & W25H02JV are some of the QSPI flashes on 
> which we tested. Additionally, we conducted tests on over 30 different 
> QSPI flashes from four distinct vendors (Miron, Winbond, Macronix, and ISSI).
> 

Great.

>> What I'm interested is if each flash is in its own package. Are they?
> 
> I'm sorry, but I don't quite understand what you mean by "if each flash in 
> its own package."
> 

There are flashes that are stacked at the physical level. It's a single
flash with multiple dies, that are all under a single physical package.

As I understand, your stacked flash model is at logical level. You have
2 flashes each in its own package. 2 different entities. Is my
understanding correct?

Cheers,
ta

