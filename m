Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD596758E78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGSHNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGSHNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:13:17 -0400
Received: from smtpng3.i.mail.ru (smtpng3.i.mail.ru [94.100.177.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEE5A4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=fH++TWJtjIxjGX5EhbifPIIL4W8rrEuOP0ikLJnLDss=;
        t=1689750795;x=1689840795; 
        b=UHfSeATaic6pXPtZdNVVp8S3ZldG3mEWFb5t4jZ9uFL8rS30ITunyO84gCfr91KDu92opIi0UOhXrr2Tcms+FrDSzk1myhai8dTc8hMmuyVMPs9igzj5ArwOcgK5dydlz3eh0/ULxhnJ4sqiAZRYdZ5vHjN0kL3CQNNs9wvyD7H9WlbUTyOqRHQaZyiBzF0CPVh9WsvmiOV50eLQ2KJqIeCnkM0AFD5C2+LCxCVB05QfPCv33khxl1o75ras6RdbGRAFaTMR7oO9XpQmr7kUPTjN1ICPv4PMEBY7SiWTymfJlu+roy71lmzE6Qj7aoOjcdbjdBWZ3epYo+FNUAxFxQ==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qM1Mz-0006vr-AQ; Wed, 19 Jul 2023 10:13:10 +0300
Message-ID: <78fdef90-6841-b7c6-198b-5902cdc06298@inbox.ru>
Date:   Wed, 19 Jul 2023 10:13:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ASoC: dt-bindings: simple-card: add triggers
 properties
To:     Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230715083046.108674-1-fido_max@inbox.ru>
 <20230715083046.108674-3-fido_max@inbox.ru>
 <20230718220843.GA1944897-robh@kernel.org>
Content-Language: en-US
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20230718220843.GA1944897-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9260BFC270D398E26256A1388358BCC2ABA9A4E6A75BB68CE182A05F5380850404C228DA9ACA6FE2760339751B026D2C514D29B42FC712A19F66A526C91EEE5FEF0631C29E6E4FBBB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D950999244A4B2E6EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637976142D429C486548638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D82BD5945AB679A852F55F44EC11A897846F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE74A95F4E53E8DCE969FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD182CC0D3CB04F14752D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BA2C6A0109559C168A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C468D16C903838CAB43847C11F186F3C59DAA53EE0834AAEE
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5CE618E196A538662FA342655A6BBEC0F492C14056082EDCBF87CCE6106E1FC07E67D4AC08A07B9B0B355ED1E20F5346ACB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF8B78B62552CEFB988F7579A3A6137389BB8945F48FC4F62BB28AC2747C34186B182FB9261F6240E87A512D943FCE53BFB310A82119D837DB70531D70938160D56A5887467130CEBC4C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojg78zLelqjbYh46SMB2AQ2A==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B0E58DE3008AEF620C23C1C26EEFFDDBF98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.07.2023 01:08, Rob Herring wrote:
> On Sat, Jul 15, 2023 at 11:30:43AM +0300, Maxim Kochetkov wrote:
>> The trigger-start/stop properties allows to specify DAI link
>> trigger ordering method.
> 
> Obviously. Why do you need these? What problem does it solve?

It allows using simple card for some DMA-based CPU component which 
requires different start/stop sequence (stop DMA before CPU component, 
start DMA after CPU component).
There are a lot of boards which have no audio codec on board. It has 
only I2S/TDM/etc... and you can attach any external codec on its pins. 
It looks like simple audio card is enough for this cases. It is much 
better than to copy-paste simple audio card code to the new custom 
driver with new combination of CPU/codec.

> 
> I don't think these belong in simple-card. What's next? What if you need
> delays between each step? This is the problem with 'simple' or 'generic'
> bindings. It's a never ending addition of properties which are not well
> thought out.

Can you please suggest the better way to specify start/stop trigger 
order via DT?

>> +  trigger-start:
>> +    description: |-
>> +      Start trigger ordering method:
>> +      default: Link->Component->DAI
>> +      ldc: Link->DAI->Component
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    items:
>> +      enum:
>> +        - default
> 
> Why do you need a value of 'default'? What's the default when the
> property is not present?
It comes from
enum snd_soc_trigger_order {
	SND_SOC_TRIGGER_ORDER_DEFAULT	= 0,	
	SND_SOC_TRIGGER_ORDER_LDC,		
	SND_SOC_TRIGGER_ORDER_MAX,
};
default value is 0 (SND_SOC_TRIGGER_ORDER_DEFAULT)

>>     format:
>>       description: audio format.
>>       items:
>> @@ -210,6 +232,10 @@ properties:
>>       maxItems: 1
>>     simple-audio-card,mic-det-gpio:
>>       maxItems: 1
>> +  simple-audio-card,trigger-start:
>> +    $ref: "#/definitions/trigger-start"
>> +  simple-audio-card,trigger-stop:
>> +    $ref: "#/definitions/trigger-stop"
> 
> Don't continue this 'simple-audio-card,' prefix pattern. With it, no
> other binding can use these properties.

Ok.

> 
>>   
>>   patternProperties:
>>     "^simple-audio-card,cpu(@[0-9a-f]+)?$":
>> @@ -259,6 +285,11 @@ patternProperties:
>>           maxItems: 1
>>         mic-det-gpio:
>>           maxItems: 1
>> +      trigger-start:
>> +        $ref: "#/definitions/trigger-start"
>> +      trigger-stop:
>> +        $ref: "#/definitions/trigger-stop"
>> +

Should I keep only this section?

