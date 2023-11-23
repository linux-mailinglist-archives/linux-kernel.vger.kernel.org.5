Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D419B7F6506
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbjKWRP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjKWRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:15:53 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EAD1AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:15:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00191363c1so158185466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700759757; x=1701364557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AlOeG1V4fof3GaM7TJQggSbjeoyMaHYc+8wIfct87w=;
        b=bS6qspTDSejpT2G/4CG4nMWQZ+Tk2SOq/VXZq88748fG8Inl94HyznUEQtbCUh3F7C
         Pa9fG6iWlUFD7kCrtt+A5dqFjZdL891ajAwfo3lpayB487/f5C36isgvgAUSJMILQKzw
         yor5FBUuiTiO6UTJhrDMWQT+BQihUIzjOFRdIMzIELkoxG+L3ES0tngcg3yUTKCnJDKe
         tJaxebxDulwVN5SiwG/0bwUzn9yFRO9TER63rAWVq8qZ7kFXsfGmb8gJXxR8p4uE7rfU
         NawwuVVFbZrxQYVWyZJDaxMU0Z6+hq6m7zAJ7VG3ibdgO2mvO/bC25B4L2NGByemsVI2
         aW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759757; x=1701364557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AlOeG1V4fof3GaM7TJQggSbjeoyMaHYc+8wIfct87w=;
        b=wpO7CGYSnEmLncilRjFFDSQFy7+Gdh6g3kuj/fVXnbM8W/BYFlOQw/EDn9imWOJkQ8
         LIcULLdNiabrsl2jhmBn0obvARhpAnberFhHlhONvHlx4JLZhX2sDxmnqkh4dbtfPYid
         GAveGJfCr2z11peZs0TbIzPmfPzyA01JBF9MdzpFhBSIN77Gff0Q6aMFgxvNW4Z62fb4
         6aki3tVTrxmP2A9uaP96DfpqMFnkGkqHKfwN8WcbwJz0AgFT89lrdzWILdVmihgmwNDZ
         sPP5iyOSS4HqT7bXv36krZd4mS1iC+icEdoBl0A4zPHHdnHFlHp8T9IOrFYIsx2uZpzY
         foWQ==
X-Gm-Message-State: AOJu0YyiZISRgw1rFomaE+Pi21KFWmQMca4aaqsCvE0EmpCiVu7oRZgV
        F901Lz5cV6zBnD/6Qf/MiRtCZg==
X-Google-Smtp-Source: AGHT+IEdPqsAqHVC2TQVJ/e+kH5KzH8hkoYdNlMSzh0yUfezaEo/7dsd2lp/P0VpN3robwEScqBYcA==
X-Received: by 2002:a17:906:46d9:b0:9cf:35a7:9ea5 with SMTP id k25-20020a17090646d900b009cf35a79ea5mr4095308ejs.74.1700759757476;
        Thu, 23 Nov 2023 09:15:57 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.3])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709064e4f00b009b9f87b34b6sm1010562ejw.189.2023.11.23.09.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 09:15:57 -0800 (PST)
Message-ID: <199ae595-5097-4ec6-bbff-86a3e2260b23@tuxon.dev>
Date:   Thu, 23 Nov 2023 19:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] net: ravb: Let IP specific receive function to
 interrogate descriptors
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-7-claudiu.beznea.uj@bp.renesas.com>
 <b626455a-f7a4-2684-725c-c679dd75a515@omp.ru>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b626455a-f7a4-2684-725c-c679dd75a515@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 18:37, Sergey Shtylyov wrote:
> On 11/20/23 11:45 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> ravb_poll() initial code used to interrogate the first descriptor of the
>> RX queue in case gptp is false to know if ravb_rx() should be called.
>> This is done for non GPTP IPs. For GPTP IPs the driver PTP specific
> 
>    It's called gPTP, AFAIK.
> 
>> information was used to know if receive function should be called. As
>> every IP has it's own receive function that interrogates the RX descriptor
> 
>    Its own.
> 
>> list in the same way the ravb_poll() was doing there is no need to double
>> check this in ravb_poll(). Removing the code form ravb_poll() and
> 
>    From ravb_poll().
> 
>> adjusting ravb_rx_gbeth() leads to a cleaner code.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb_main.c | 18 ++++++------------
>>  1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 588e3be692d3..0fc9810c5e78 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -771,12 +771,15 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
>>  	int limit;
>>  
>>  	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
>> +	desc = &priv->gbeth_rx_ring[entry];
>> +	if (desc->die_dt == DT_FEMPTY)
>> +		return false;
>> +
> 
>    I don't understand what this buys us, the following *while* loop will
> be skipped anyway, and the *for* loop as well, I think... And ravb_rx_rcar()

Yes, I kept it because of the for loop and the update of the *quota.

As commit specifies the code has been moved in IP specific RX function
keeping the initial functionality.

> doesn't have that anyway...


> 
>> @@ -1279,25 +1282,16 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>>  	struct net_device *ndev = napi->dev;
>>  	struct ravb_private *priv = netdev_priv(ndev);
>>  	const struct ravb_hw_info *info = priv->info;
>> -	bool gptp = info->gptp || info->ccc_gac;
>> -	struct ravb_rx_desc *desc;
>>  	unsigned long flags;
>>  	int q = napi - priv->napi;
>>  	int mask = BIT(q);
>>  	int quota = budget;
>> -	unsigned int entry;
>>  
>> -	if (!gptp) {
>> -		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
>> -		desc = &priv->gbeth_rx_ring[entry];
>> -	}
>>  	/* Processing RX Descriptor Ring */
>>  	/* Clear RX interrupt */
>>  	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
>> -	if (gptp || desc->die_dt != DT_FEMPTY) {
>> -		if (ravb_rx(ndev, &quota, q))
>> -			goto out;
>> -	}
> 
>   I don't really understand this code (despite I've AKCed it)...
> Biju, could you explain this (well, you tried already but I don't
> buy it anymore)?
> 
>> +	if (ravb_rx(ndev, &quota, q))
>> +		goto out;
> 
>    This restores the behavior before:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d4e37df882b0f4f28b7223a42492650b71252c5
> 
>    So does look correct. :-)
> 
> MBR, Sergey
