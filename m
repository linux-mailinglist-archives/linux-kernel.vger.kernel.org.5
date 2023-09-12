Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF379D864
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbjILSJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbjILSJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:09:36 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D31AE59;
        Tue, 12 Sep 2023 11:09:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C195860003;
        Tue, 12 Sep 2023 18:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694542170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebct1hV/RgqEi3G8NEb85BwUFcGmivlVqkSEYtB7E84=;
        b=bLDN1UcL4lDbDZC7UtcXdfNNI2aazGi4BK5dwc8jUl8hHQKfsBufLYWWkQ8XuEfvVfwEMX
        JxeSJ5bxnE3LwxC+IUOaeimN504A2Mg+d2k9DIi5aUwuCFodceuQuPOogiVoXbDEJLdNn2
        hF03LR1k8ZDfrm9y6zYqPCtOEG38s3cSN/bDXEMSdCvmNZb2rgwAKxQjRpu2XtGQC2JK89
        7aYvdOK4tn/WwjD4X7Z8FU7QA4F7hRPo6I6tedcbjFu4N0EnP8pzW3WzMJ66F9p/Yh80jx
        3cxayY4bfeZ6FEkpd9rQI85yxm4MS9L5Oqsi9HkyIHgqOkYJXnLfRi3ctWN+1Q==
Message-ID: <c2eb0222-2503-4d55-80f7-80ec7122b6ba@arinc9.com>
Date:   Tue, 12 Sep 2023 21:09:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <20230814143601.mnpxtcm2zybnbvoh@skbuf>
 <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <71f7c475-e111-4e4b-9e8f-4c8a6bf6bc34@lunn.ch>
Content-Language: en-US
In-Reply-To: <71f7c475-e111-4e4b-9e8f-4c8a6bf6bc34@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.09.2023 00:16, Andrew Lunn wrote:
> Please trim the text when replying.
> 
> 
>> I'm writing below as a mix of patch log and discussion.
>>
>> Phylink bindings are required for ports that are controlled by OF-based
>> buses. DSA, like any other driver utilising the Linux MDIO infrastructure,
>> can register a bus. If I understand correctly, non-OF-based registration of
>> OpenFirmware MDIO buses is a feature specific to DSA which certain DSA
>> subdrivers make use of.
> 
> This is not really DSA specific. Any MAC driver, or MDIO driver, can
> call mdiobus_regsiter(), or of_mdiobus_register() and pass a NULL
> pointer if there is no OF node available. It then requires that the
> MAC driver uses an function like phy_find_first(), or knows via other
> means what address the PHY uses on the bus. For DSA, that other means
> is assuming a 1:1 mapping between port number and bus address.

Understood. At least a phy-handle on the DSA user port for each PHY 
controlled by non-DSA drivers is always needed correct? Otherwise DSA 
wouldn't know which PHY to map the DSA switch port?

And that means DSA requires OF-based buses to map the ports controlled 
by non-DSA driver buses to PHYs?

I'm trying to understand if phylink bindings for DSA user ports that are 
controlled by non-DSA driver buses are always necessary.

Would this also apply to MAC drivers that control switches?

Arınç
