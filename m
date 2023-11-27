Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC697F9919
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjK0GLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK0GLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:11:16 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79F6E4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 22:11:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9e1021dbd28so514539966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 22:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701065479; x=1701670279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHtEQi8g8hzQmGEKqbL9kvJSOxbU+L25q3WrEMfx6eQ=;
        b=Uh1l1gXPo7uM8iGaJofaS8/4NydXffpDdIQmWcgijf7grcElrxTzECzpDTQawXa/oI
         m1fK4P03WRWJydU808yf9q1hOn5AB1LJA8ownmlo9Wvy4rIkruhdOEg6I4fUlbqUHWkW
         iEfYFznnlUlvkcISwAQus/jYl3gqEP8XdwUpEfC7bysajtxxUfDu0Jh+wUCLiMUF3sGK
         0o4eeAL0enBGO4c87vfPqmt0HWF76WBAzDgA0AMNGuuFH6hctNsXJNLTPEtr5QuNfWna
         3RAU3HhgNM98WYp327BTbCb6wZ4dKrI7zSkYnyPLufEeDdEJxoKsN3OPEskD1iPXfJqC
         2I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701065479; x=1701670279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHtEQi8g8hzQmGEKqbL9kvJSOxbU+L25q3WrEMfx6eQ=;
        b=hcmQXxcsesb9evV/5R7SGRhOLP3zcgPZLTRPSIExVyY1cSzGcVT4uEcR/ZmjeV/XvN
         zIO590+TIczazCdEaGC6kIOhq19uv2yuNoBuXQJAhWeS/4diiS8RW0yYJLtL3H756zId
         9rBJoVmFw8awpoPUBaqYMIa7q6ahUZ2CFgzf4fUzZkjTzjXqy12M+pdCb+95LOs+/QSh
         ljDIoU7Vodx6g3tfxGHSnMwWdbt9l+yeVcP/Pkd0P7qI+eVHYvyB7KYTZo8sfvZPFcLB
         W4bpmdee5l3wVnvB/TvvH0BJRIJ/MOnJqDGmHnYsg9Rm0/svk2XM+vB5b5Rex3+G+6Lw
         pgow==
X-Gm-Message-State: AOJu0YyWscP52uQFXkHfT15i0louIVLMTzvcLzqo1IJdrsW6YT5UBhQ7
        pRAY2vd5LAnT51dEETSntuZTKQ==
X-Google-Smtp-Source: AGHT+IHDT8N++R7ZLkzcyLrDWB71eEFcl94wuhPsn7nZeHq/4nGrhvFaJXjkUFoAUv4VU1TMjwiX9g==
X-Received: by 2002:a17:907:1255:b0:9de:32bb:fa95 with SMTP id wc21-20020a170907125500b009de32bbfa95mr5686417ejb.35.1701065479311;
        Sun, 26 Nov 2023 22:11:19 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906319400b00a097c5162b0sm3840401ejy.87.2023.11.26.22.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 22:11:18 -0800 (PST)
Message-ID: <7ea4c3fe-a911-4161-af13-7f1d55def7e3@tuxon.dev>
Date:   Mon, 27 Nov 2023 08:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: macb: Unregister nedev before MDIO bus in remove
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk, jgarzik@pobox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
 <20231126141046.3505343-3-claudiu.beznea@tuxon.dev>
 <086fc661-0974-4bb6-a8ae-daa9d53361d9@lunn.ch>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <086fc661-0974-4bb6-a8ae-daa9d53361d9@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.11.2023 19:13, Andrew Lunn wrote:
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index cebae0f418f2..73d041af3de1 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -5165,11 +5165,11 @@ static void macb_remove(struct platform_device *pdev)
>>  
>>  	if (dev) {
>>  		bp = netdev_priv(dev);
>> +		unregister_netdev(dev);
>>  		phy_exit(bp->sgmii_phy);
>>  		mdiobus_unregister(bp->mii_bus);
>>  		mdiobus_free(bp->mii_bus);
>>  
>> -		unregister_netdev(dev);
>>  		tasklet_kill(&bp->hresp_err_tasklet);
> 
> 
> I don't know this driver...
> 
> What does this tasklet do? 

It handles bus errors that my happens while DMA fetches data from system
memory. It re-initializes the TX/RX, DMA buffers, clear interrupts,
stop/start all tx queues.

> Is it safe for it to run after the netdev
> is unregistered, and the PHY and the mdio bus is gone? 

Not really, as it accesses netdev specific data.

> Maybe this
> tasklet_kill should be after the interrupt is disabled, but before the
> netdev is unregistered?

That would be a better place, indeed.

Thank you,
Claudiu Beznea

> 
> If you have one bug here, there might be others.
> 
> 	Andrew
