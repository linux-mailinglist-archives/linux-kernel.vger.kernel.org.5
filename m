Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A826776D048
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjHBOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjHBOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:40:06 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4810FB;
        Wed,  2 Aug 2023 07:40:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372EdmaR009457;
        Wed, 2 Aug 2023 09:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690987188;
        bh=fMKK42wAH8Nnsvw63GKfzyP6R9L7nXqVg3xURLy8OK4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DzngAnTH9zKrAGnE/DM4ePAfcPfTZSGU+16bl3VimKR7DVl5IQ1m3MAOuLjAWkGK6
         5CJNOSUL6iqqqILXnnISEAy7GK2rqPUhjzy2QcHtqgKOqjUXgNwBVOfHcU7VmYQFOb
         xdWAzKwO/kFwev2IGF8ayMGnq4ruMGsk4TP/e+Jo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372EdmVW118309
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 09:39:48 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 09:39:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 09:39:48 -0500
Received: from [172.24.227.6] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372EdiEH024344;
        Wed, 2 Aug 2023 09:39:44 -0500
Message-ID: <e3fb55e2-b8e2-1b68-2b33-874d80eac302@ti.com>
Date:   Wed, 2 Aug 2023 20:09:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
 <20230731-mcasp_am62a-v1-4-8bd137ffa8f1@ti.com>
 <aa8d2aa6-a121-51e6-77de-0e1c8bdac043@ti.com>
 <52pbbqnp46h33gymoydnjtxoo3dsb6wnytvjnmomtjdtwck536@ewhb2rngomr2>
 <20230802133502.zjvf7sslmcuayg5z@defog>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230802133502.zjvf7sslmcuayg5z@defog>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai, Nishant,

On 02/08/23 19:05, Nishanth Menon wrote:
> On 17:10-20230802, Jai Luthra wrote:
>> Hi Devarsh,
>>
>> On Aug 02, 2023 at 16:15:12 +0530, Devarsh Thakkar wrote:
>>> Hi Jai,
>>>
>>> Thanks for the patch.
>>>
>>> On 31/07/23 18:14, Jai Luthra wrote:
>>>> Add nodes for audio codec and sound card, enable the audio serializer
>>>> (McASP1) under use and update pinmux.
>>>>
>>>> Link: https://www.ti.com/lit/zip/sprr459
>>>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>>>> Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 77 +++++++++++++++++++++++++++++++++
>>>>  1 file changed, 77 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>>> index 752c2f640f63..5f68d2eefe0f 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>>> @@ -125,6 +125,41 @@ led-0 {
>>>>  			default-state = "off";
>>>>  		};
>>>>  	};
>>>> +
>>>> +	tlv320_mclk: clk-0 {
>>>> +		#clock-cells = <0>;
>>>> +		compatible = "fixed-clock";
>>>> +		clock-frequency = <12288000>;
>>>> +	};
>>>> +
>>>> +	codec_audio: sound {
>>>> +		compatible = "simple-audio-card";
>>>> +		simple-audio-card,name = "AM62Ax-SKEVM";
>>>
>>> In my opinion better to give the codec name instead of board name here.
>>
>> I agree, maybe calling it "sk-am62a-tlv320aic3106" would be the most 
>> clear option.
>>
>> Running a quick ripgrep on next tree:
>>
>> $ rg "simple-audio-card,name" arch/*/boot/dts/
>>
>> I see a healthy mix of using both board and/or codec name here - with TI 
>> almost always using the board name. Maybe we can change the convention, 
>> but it would be a good idea to at least update SK-AM62 as well to use 
>> the new convention.
>>
>> Is it okay with you if it is handled as a separate series?
> 

Yes agreed, the naming can be taken care of as separate series as it also
applies to other TI board (AM62x), we can brainstorm on the naming separately
and not block this patch.

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

> Will this cleanup of existing board break any userspace? If so, NO and
> follow existing "board" convention - I'd like to maintain consistency,
> even if that is not exactly clean! If not, cleanup in a later series
> is fine, but please make sure to follow through this week - with this
> patch following the convention of choice.
> 


