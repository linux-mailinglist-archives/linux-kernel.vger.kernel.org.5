Return-Path: <linux-kernel+bounces-721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A6981451F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8942C1F232E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7609518C28;
	Fri, 15 Dec 2023 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="b058VRax"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387A18C18
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c4846847eso5228785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702634693; x=1703239493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzGSueYgjKpbem4qFtdP7rmchtFZgQq3JUglNkOvT3w=;
        b=b058VRaxYdMSQpRbtrh0q3q5oZ4tKhQbn71OdKk9BWgTNVB9gguNmKiRj9g04VCP//
         nj7tdGpe/yLGFfpODe0oGU4BSKPIpt5fFehHo7o6FxcwcygZEtkMukZSh9e6n51e1v43
         AAtJ+JllomTSvQ9gO1d3/GiiDMeGDr5CIe3XsOR/IJTk/NIdQhZNxw0Nt9FbSWjOXEcT
         Z3TMpT3iJxIkWFtCSVNmc7e44GH0SuDotCE8v5CV7KjA6A6E8x7jXWhxdkLQxVU74TCE
         pxakNl+tMPl+GGa2c75uJ9Yqus6bzmRiCPW5VwC+oKi2/olmYAI/jQgmBnTWarFX4/A7
         XwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702634693; x=1703239493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzGSueYgjKpbem4qFtdP7rmchtFZgQq3JUglNkOvT3w=;
        b=g7yaWkhdB5C3GMElTLgo97bma5Q/uaKW2wIIFsk/qbltYHh7aPA1daRGzB7tt/dwkj
         oXTenKpAAlOdmvp3l9umPljmvW1WtsAYfLPmmbEm01AJv61k/HYvGanoofkmPDNfLWZn
         EYwyiAzL3/dv07eDsRMlzWW6PaHTX6/9oh5pMu5ldsRoz4vuPrb9b2oblRID/ySHQLiM
         xQpmuiXFqR0QD3tunzp0nn8AMsmjKN5LdEJG+GLfdw5Z11/nO8aKkMhL7HNh/c+nrFBV
         Q9b+zt/Speu3DIRaE4sbttMjxaoUjdPkWFNdPzvfitR+guFVuaozZNFydrCTDORAs1p0
         pkqg==
X-Gm-Message-State: AOJu0YzcCA6MXsjzRklsGEMUtVBkmK0RcB/ylXXDAZmoEbKimrCuxXGE
	5G9bllkmUYW3spNHdzAIeDinGA==
X-Google-Smtp-Source: AGHT+IG23H+vbNwlWVjRO6JupU3b8UJgJiD5gNauO7Z+S0ticxIdE6x+9ZzaZ14GJJx4kxaE5DNpug==
X-Received: by 2002:a7b:cd11:0:b0:40c:909:4402 with SMTP id f17-20020a7bcd11000000b0040c09094402mr5528160wmj.133.1702634693136;
        Fri, 15 Dec 2023 02:04:53 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b0040c411da99csm22891968wmq.48.2023.12.15.02.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 02:04:52 -0800 (PST)
Message-ID: <0b807496-f387-4aef-8650-a43a9249468f@tuxon.dev>
Date: Fri, 15 Dec 2023 12:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ravb: Wait for operation mode to be applied
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 claudiu.beznea.uj@bp.renesas.com, yoshihiro.shimoda.uh@renesas.com,
 wsa+renesas@sang-engineering.com, niklas.soderlund+renesas@ragnatech.se,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 mitsuhiro.kimura.kc@renesas.com, geert+renesas@glider.be
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214113137.2450292-2-claudiu.beznea.uj@bp.renesas.com>
 <d08dbbd4-2e63-c436-6935-df68c291bf75@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <d08dbbd4-2e63-c436-6935-df68c291bf75@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.12.2023 21:41, Sergey Shtylyov wrote:
> resetOn 12/14/23 2:31 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> CSR.OPS bits specify the current operating mode and (according to
>> documentation) they are updated when the operating mode change request
>> is processed. Thus, check CSR.OPS before proceeding.
> 
>    The manuals I have indeed say we need to check CSR.OPS... But we only
> need to wait iff we transfer from the operation mode to the config mode...

RZ/G3S manual say about CSR.OPS "These bits are updated when an operating
mode changes is processed". From this I get we need to check it for any mode.

Also, on configuration procedure (of RZ/G3S) it say CSR.OPS need to be
checked when switching from reset -> config.

> 
>> Fixes: 568b3ce7a8ef ("ravb: factor out register bit twiddling code")
>> Fixes: 0184165b2f42 ("ravb: add sleep PM suspend/resume support")
>> Fixes: 7e09a052dc4e ("ravb: Exclude gPTP feature support for RZ/G2L")
>> Fixes: 3e3d647715d4 ("ravb: add wake-on-lan support via magic packet")
>> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> 
>    Hm, that long list does look weird...

OK, then I'll limit it to only c156633f1353 ("Renesas Ethernet AVB driver
proper"). Niklas also suggested this.

> 
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb_main.c | 47 ++++++++++++++++++++----
>>  1 file changed, 39 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 9178f6d60e74..ce95eb5af354 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -683,8 +683,11 @@ static int ravb_dmac_init(struct net_device *ndev)
>>  
>>  	/* Setting the control will start the AVB-DMAC process. */
>>  	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
>> +	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_OPERATION);
>> +	if (error)
>> +		netdev_err(ndev, "failed to switch device to operation mode\n");
> 
>    It doesn't look like ravb_wait() is needed here...
>    And besides, this pattern seems repetitive and worth factoring out into
> a single function.

In the final version of the driver proposed by RPM series it is gone. I
tried to keep the fixes simple. I'll update it as Niklas also suggested this.

> 
> [...]
>> @@ -1744,6 +1747,18 @@ static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
>>  	return error;
>>  }
>>  
>> +static int ravb_set_reset_mode(struct net_device *ndev)
>> +{
>> +	int error;
>> +
>> +	ravb_write(ndev, CCC_OPC_RESET, CCC);
>> +	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_RESET);
>> +	if (error)
>> +		netdev_err(ndev, "failed to switch device to reset mode\n");
>> +
>> +	return error;
>> +}
>> +
> 
>    Again, ravb_wait() call doesn't seem necessary here...

Ok. I followed the guideline from the description of CSR.OPS. Let me know
if you want to keep it or not. I think I haven't saw any issues w/o this.

> 
> [...]
> 
> MBR, Sergey

