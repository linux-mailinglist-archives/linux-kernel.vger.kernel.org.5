Return-Path: <linux-kernel+bounces-43056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3AE840AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F315289613
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8615531D;
	Mon, 29 Jan 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2J4Lu2e"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17426155311;
	Mon, 29 Jan 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544513; cv=none; b=nM/EujPkf9MhvYBQLgjKx68xWFRz/zy6naCWb3Ti7UawYez3cAAqhjsb9Ce3iWXlmslY6j2oYo6QCjLZmLJs6X4j+tLt2CU15HdaV5qtVlPu7jsWWFGQSVPrOKRgmHEyLQFHEn3/Hv8e4SXyoE5B9PZ2p+royG1tIw30ALMXOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544513; c=relaxed/simple;
	bh=Zic+oX3yqD1CJjUDGlwLTM3d/nTVRYRCevjMM6Nu7VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cjhd5pf/KHkHp3AU7KwRAP4CeUxKGoAL9m+xoZu2yh3DfNzYsnUWOKWi2PPDVTUAmbECpOSQrReWtOD02NXHYYvi/zS/UdMi/YQbjR5ZGy2TFPt4ILcHpHBjYOMRvH78Fjj0NiZyApekd5QTUBt2kAUJzJSVyu91amTPefJzDmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2J4Lu2e; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7393de183so12356025ad.3;
        Mon, 29 Jan 2024 08:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544510; x=1707149310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqL1iBqUFGyl9Akm7glWLlVu6v5YJtW6MX+6smEFkKA=;
        b=i2J4Lu2ec0GaMsbWi8b/Ib7gfqQ3YGJvLgpTlvxtkct16TSCY2COyXavyDPn4lZf4t
         8xiIqJgxfnU71i0J8LRazZ7y159fXjYniJfabmV9sBntr0msFndkdtxlSRYbfJDRwL5K
         4OqgJO8KIAnU0Bg6BKuGAwyNsymU4qlwamBZHCBaFG3PUQuWLY+y3UP/aGhxZafkKE8C
         tqL7omcnU9scKFeSJ9dyUPYrMX4PybwcQUnuSG0NdaP7QcjxZeWbcuoz4wfq/ajqtmmG
         BDAkdcnOGv4OUwTaDrrGgd2xe8h0sp3hGRfuTKg7ycvm8izQvvPTHkp0IfoWWRaOZmRY
         9wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544510; x=1707149310;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqL1iBqUFGyl9Akm7glWLlVu6v5YJtW6MX+6smEFkKA=;
        b=G7ffp3mb4h7U9DvkDxSCtOGSWSoxZxCGNKKIswM6dNR5bHesjEKuj0bcnz+wkoQNT6
         1e4C/ynGksSAbD0azjqXQ+Des08awPJ1JBr0Dk0qaej4NpTpiqXc4qnmGFYcQhaUlR+1
         uQEcxHxQVHncoYz0THnJhAr9QyR+puqP8ksR/WoXY5QxBgP8k+PeyhGKYh94jT0Re6M1
         KyLIa8Ip1qkazEgFBVkT5U1lQUi3m2GaI4po6TZJA2BOCMg9VsBsSyKJc7FE3akg6IZP
         ZtzQyKEv5GZOASqew7qtIKQrTzd2wSeiS6QY2oHyWeWezS+a7BO8hiRTIJ1C0ISYYoGx
         w/fQ==
X-Gm-Message-State: AOJu0YwjXc8PFPXsIxx4jpJx9mD219eYdOO6ScPnfWVrL3OVscPAmXSV
	h4WfNXN6xbm37YmBV796y02tywODIPxsA9rtCVbIFxDA12hvdsuJ
X-Google-Smtp-Source: AGHT+IE02CBciOHp9QL252fnnF+EgIuvEYDeGzEY3xXv9vb2eg7D0d5AiqrqhGSBEmfW4kYUdLGC9Q==
X-Received: by 2002:a17:903:2290:b0:1d8:edd0:97d4 with SMTP id b16-20020a170903229000b001d8edd097d4mr1376647plh.43.1706544510271;
        Mon, 29 Jan 2024 08:08:30 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:8853:5abd:d9f3:2a01? ([2600:8802:b00:ba1:8853:5abd:d9f3:2a01])
        by smtp.gmail.com with ESMTPSA id kr12-20020a170903080c00b001d8f82c61cdsm850632plb.231.2024.01.29.08.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:08:29 -0800 (PST)
Message-ID: <120646e5-bd05-48bd-a308-e0e8685633e9@gmail.com>
Date: Mon, 29 Jan 2024 08:08:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: remove OF-based MDIO bus registration
 from DSA core
Content-Language: en-US
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <ALSI@bang-olufsen.dk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122053348.6589-1-arinc.unal@arinc9.com>
 <20240123154431.gwhufnatxjppnm64@skbuf>
 <d32d17ed-87b5-4032-b310-f387cea72837@arinc9.com>
 <CAJq09z6pidHvtv=3F_yKHDdY89kzYSF+xh89pzg1raAiQPMyMg@mail.gmail.com>
 <20240129145632.d2mu6vbwcqhjpyty@skbuf>
 <816442dc-b420-4413-a29f-c73b95f1026b@arinc9.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <816442dc-b420-4413-a29f-c73b95f1026b@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/29/2024 7:53 AM, Arınç ÜNAL wrote:
> On 29.01.2024 17:56, Vladimir Oltean wrote:
>> On Sat, Jan 27, 2024 at 11:23:33PM -0300, Luiz Angelo Daros de Luca 
>> wrote:
>>>>> IIUC, Luiz made the original patch for the realtek switches. Shouldn't
>>>>> we wait until realtek registers ds->user_mii_bus on its own, before
>>>>> reverting? Otherwise, you're basically saying that Luiz made the DSA
>>>>> core patch without needing it.
>>>>
>>>> My findings point to that. Luiz made the patch to optionally 
>>>> register the
>>>> MDIO bus of the MDIO controlled Realtek switches OF-based. So it's not
>>>> necessary to wait.
>>>
>>> Back in the time when I wrote that code, with the phy_read/write in
>>> dsa_switch_ops, the OF node was only required to associate IRQ to each
>>> port. Until my patch to register its own mdiobus driver lands (I hope
>>> that happens before the next version), the port status will fall back
>>> to polling. I don't think it is a critical feature but I'll let the
>>> maintainers decide. ACK for me.
>>>
>>> Regards,
>>>
>>> Luiz
>>
>> It isn't really great that this loses IRQ support for Realtek internal 
>> PHYs,
>> especially since Arınç's commit message did not estimate this would 
>> happen.
>>
>> I don't see why this patch could not wait until you resubmit the realtek
>> consolidation set and it gets accepted.
> 
> I agree. I didn't anticipate that realtek-mdio didn't set IRQs on PHYs for
> the MDIO bus registered non-OF-based. I'd much rather wait and then send v2
> with the mention to realtek-mdio removed.

Sounds good, thanks!
-- 
Florian

