Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EEC7EF812
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjKQTys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQTyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:54:46 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41161D68;
        Fri, 17 Nov 2023 11:54:43 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHJs73J096323;
        Fri, 17 Nov 2023 13:54:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700250847;
        bh=CeIy/ch5gJ/McU8RJ7Fu7NwiLQ2c6HnNvty9IQh48PY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=SWLt8tH1B2k1MCfSrYx2aDfMTy7h0Thw9n9F0aCYBCZhfx5LTRFFUNxD+lYf98z0c
         9N56nTFgXzt8vYNMsc7GYOwVbTVLJ1/VbU98Lc4AVbK1bzHPwnqQYcubsJUa7EHLUN
         HQUPWV2W3upIYN5DIX9o3X02wDsjj5FoL9oGJevU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHJs7GX083774
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 13:54:07 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 13:54:06 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 13:54:06 -0600
Received: from [10.250.36.5] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHJs5nt002279;
        Fri, 17 Nov 2023 13:54:05 -0600
Message-ID: <50eadab2-0f0a-480c-a77c-ca731c5d75cf@ti.com>
Date:   Fri, 17 Nov 2023 13:54:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
 <7592981.EvYhyI6sBW@phil> <2cb3f992-f214-4cdf-8443-9e14ab864a66@ti.com>
 <4289147.1BCLMh4Saa@diego>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <4289147.1BCLMh4Saa@diego>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/23 1:38 PM, Heiko Stübner wrote:
> Am Freitag, 17. November 2023, 15:03:38 CET schrieb Andrew Davis:
>> On 11/16/23 2:33 PM, Heiko Stuebner wrote:
>>> Am Donnerstag, 16. November 2023, 21:23:20 CET schrieb Krzysztof Kozlowski:
>>>> On 16/11/2023 21:03, Heiko Stuebner wrote:
>>> going with the vcc5v0_host regulator of the rk3588-quartzpro64 and
>>>
>>> +1. compatible
>>> +2. reg
>>> +3. ranges
>>> +4. All properties with values
>>> +5. Boolean properties
>>> +6. status (if applicable)
>>> +7. Child nodes
>>>
>>> we'd end up with
>>>
>>>           vcc5v0_host: vcc5v0-host-regulator {
>>> /* 1. */        compatible = "regulator-fixed";
>>> /* 4. */        gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
>>>                   pinctrl-names = "default";
>>>                   pinctrl-0 = <&vcc5v0_host_en>;
>>>                   regulator-min-microvolt = <5000000>;
>>>                   regulator-max-microvolt = <5000000>;
>>>                   regulator-name = "vcc5v0_host";
>>>                   vin-supply = <&vcc5v0_usb>;
>>> /* 5. */        enable-active-high;
>>>                   regulator-always-on;
>>>                   regulator-boot-on;
>>>           };
>>>
>>
>> How about grouping like properties (defined in the same schema),
>> then sorting within that group. Would also allow for defining
>> where to add spacing.
>>
>> 1. compatible
>> 2. reg
>> 3. ranges
>> 4. All property groups
>>     4.1 Properties with values
>>     4.2 Boolean properties
>>     4.3 Separating space
>> 6. status (if applicable)
>> 7. Child nodes
>>
>> Your node then would look like we expect:
>>
>> vcc5v0_host: vcc5v0-host-regulator {
>> /* 1   */   compatible = "regulator-fixed";
>>
>> /* 4.1 */   pinctrl-names = "default";
>> /* 4.1 */   pinctrl-0 = <&vcc5v0_host_en>;
>> /* 4.3 */
>> /* 4.1 */   regulator-min-microvolt = <5000000>;
>> /* 4.1 */   regulator-max-microvolt = <5000000>;
>> /* 4.1 */   regulator-name = "vcc5v0_host";
>> /* 4.2 */   regulator-always-on;
>> /* 4.2 */   regulator-boot-on;
>> /* 4.2 */   enable-active-high;
>> /* 4.3 */
>> /* 4.1 */   gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
>> ...
>> };
> 
> I'm really not sure about adding big sets of rules.
> In the above example you'd also need to define which schema has a higher
> priority? ;-)
> 
> 
> When I started with Rockchip stuff, I also had some fancy way of sorting
> elements in mind that was really intuitive to myself :-) .
> Over time I realized that it was quite complex - especially when I had to
> explain it to people.
> 
> There are definite advantages for having compatible + reg + status in
> fixed positions, as it helps going over a whole dt to spot the huge
> mistakes (accidentially disabled, wrong address), but for the rest a
> simple alphabetical sorting is easiest to explain to people :-) .
> 
> And alphabetic elements are also easier on my eyes.
> 

+1 for starting with compatible/reg/status that we would like to see
in the same spot in each node.

Not so sure on plain alphabetical. That has the same issue you pointed out
with splitting value vs boolean properties, related properties would end up
not grouped. Some like regulator- with the same prefix will, but think -gpios
that is a postfix, they would be scattered about.

How about just enforcing ordering on the couple common property we care about
seeing and everything else left free-hand as it today?

Andrew

> 
> I just think having a short clean set of rules like Krzysztof proposed,
> is easier to follow and "enforce" and also most likely doesn't deter
> people from contributing, if mainline work is not their main occupation.
> 
> 
> Heiko
> 
> 
> 
