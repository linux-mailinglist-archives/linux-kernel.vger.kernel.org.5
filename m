Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A679D8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjILSiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjILSiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:38:18 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D710EF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:38:14 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id g8GzqaTAidUSag8GzqmwHQ; Tue, 12 Sep 2023 20:38:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694543893;
        bh=gJjWjCvzjTWsQueLFBTaq3Sqnmya67aAWoGNbP8Czo4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fXyzuGJL535OOgG/gUoUYvhGpJSjMxj5+Ed+yyVpThO6lTRpKH7k1KKANGGSHVZA/
         imnCaeFq7So19OjQawTGRRm8vjh6/mf4sqM6TqCHj5V/RrBIw1QxaTYHycwXsY5Akz
         sbsmOPjfAMI54vFSppT7Y0lSuG1z4VazGb/t2VKy6XZF7DsFW2qiguOeZgbz/9r6kc
         Z2OpymZVceBmy1ZHBtqUbR6m32LOnMggNcY97/ClnvD67ABlYqMlO7Nzjyv96DyWDt
         Xrz0FPgG+7GKlNqUxo9AzNvxujyD0DZusSH8r815NVZ4X/UCbHl5tMNFoR/w/ChjM2
         wcRrvSqhCkDPw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Sep 2023 20:38:13 +0200
X-ME-IP: 86.243.2.178
Message-ID: <35c1c9ee-357f-4ba5-dd47-95d4c064e69b@wanadoo.fr>
Date:   Tue, 12 Sep 2023 20:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: Add drive strength
 configuration
Content-Language: fr
To:     Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
References: <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
 <20230912113553.fselyj2v5ynddme2@skbuf>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230912113553.fselyj2v5ynddme2@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/09/2023 à 13:35, Vladimir Oltean a écrit :
> On Tue, Sep 12, 2023 at 06:54:59AM +0200, Oleksij Rempel wrote:
>> Add device tree based drive strength configuration support. It is needed to
>> pass EMI validation on our hardware.
>>
>> Configuration values are based on the vendor's reference driver.
>>
>> Tested on KSZ9563R.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---


>> +	if (!found)
>> +		return 0;
> 
> Maybe "have_any_prop" would be a better name to avoid Christophe's confusion?

Not sure it worth it.

Christophe should learn to read code or avoid some quick feed-back 
before morning coffee :)

'found' looks good enough.

CJ


