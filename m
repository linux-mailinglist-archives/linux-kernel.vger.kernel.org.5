Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6127825B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjHUImQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjHUImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:42:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76CBF;
        Mon, 21 Aug 2023 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692607327; x=1724143327;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=oPuGl3iS1xeG1kSvRa52XvCa2jmPA+5mjTiuSiaiXoo=;
  b=EeaKewTYNTlanvTMtj+e3M6kfchE+kzImKKUDGJQKaL9ck4bP0G7DBCz
   mplmQi/HF8GTDUd+0oQVc2DZbHBRhdTDMTPsmC41pjHrQP4BVWRezJiuD
   MTkzUs4LRUbmLbr3Ock2Pf+azpdfvtFF+6CCBzxhSPnJQ2qG9dPy6pg0N
   6W5vY0Cy/khr5U9JT1ea8auWA6eTpVesvouu9np/brJKzumYL7r91X9yU
   dJcerCc5ZbISWFxuL3xvT9Q9fLP5gD/ln5zm2Cs/5fU1dgNhdAkLv04Lj
   O88fkgesM33029zHgYEnObx4xGH4OMjsUfzaFBH6cmrHFA4tzc6D2DDvy
   A==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="167439281"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2023 01:42:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 21 Aug 2023 01:42:06 -0700
Received: from [10.159.245.205] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 21 Aug 2023 01:42:03 -0700
Message-ID: <adeed0b2-e09b-78cf-ebfd-08d3949ca9ea@microchip.com>
Date:   Mon, 21 Aug 2023 10:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        <Varshini.Rajendran@microchip.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230728102442.265820-1-varshini.rajendran@microchip.com>
 <09bd1388-02aa-32c7-319e-d7150a0f3e9c@linaro.org>
 <1ec901d0-44c2-1d28-5976-d93abfffee67@microchip.com>
 <37782447-43c7-50f9-b9b4-5fbca94ce8c6@linaro.org>
 <96033a59-a2ea-c906-a033-84119c5783d7@linaro.org>
Content-Language: en-US, fr-FR
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <96033a59-a2ea-c906-a033-84119c5783d7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor, all,

On 19/08/2023 at 16:34, Krzysztof Kozlowski wrote:
> On 10/08/2023 09:22, Tudor Ambarus wrote:
>>
>> On 8/10/23 06:38, Varshini.Rajendran@microchip.com wrote:
>>>> On 7/28/23 11:24, Varshini Rajendran wrote:
>>>>> Add DT bindings for atmel TDES.
>>>> NACK. The atmel crypto drivers check the version at runtime and
>>>> fill a capabilities structure based on the version identified.
>>>> There's a single compatible regardless of the version of the IP
>>>> used until now, why do you want to change it?
>>>>
>>> Hi Tudor,
>>
>> Hi,
>>
>>> I am aware that there is no change in the crypto IP used. This patch is

Actually, recent history showed us that it's not only the IP itself but 
its integration into final product that could have an influence on the 
behavior.

>>> to add a SoC specific compatible as expected by writing-bindings
>>> guideline. Maybe a bit more explanation in the commit description might
>>> do the trick.
>>>
>>
>> So you add a compatible that will never be used just to comply with
>> the writing bindings guideline?
> 
> How do you know that it is never going to be used? The guideline asks
> for this on purpose, so any future quirks or incompatibilities can be
> easily addressed.

In this recent case, having a an adapted compatibility string is an 
added value.

And yes, I changed my mind and would like to be systematic now with 
at91/microchip DT compatibility strings. Our long history and big legacy 
in arm-soc is sometimes difficult to handle, but we're moving little by 
little to comply with guidelines.

My conclusion is that Varshini's addition is the way to go.

Best regards,
   Nicolas
