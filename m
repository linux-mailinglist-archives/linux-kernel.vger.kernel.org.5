Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4046D7F3E88
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjKVHDz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 02:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:03:54 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE7712A;
        Tue, 21 Nov 2023 23:03:46 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 81E6B8132;
        Wed, 22 Nov 2023 15:03:38 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Nov
 2023 15:03:38 +0800
Received: from [192.168.120.47] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Nov
 2023 15:03:37 +0800
Message-ID: <1ba3e8d1-ed89-4aab-ae27-d8d31ee2f150@starfivetech.com>
Date:   Wed, 22 Nov 2023 15:03:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] dt-bindings: pwm: Add OpenCores PWM module
To:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231110062039.103339-1-william.qiu@starfivetech.com>
 <20231110062039.103339-2-william.qiu@starfivetech.com>
 <afce202d-6234-4c5f-9018-facd9a56b5eb@linaro.org>
 <f4551a7a-61e6-4d97-94c2-da2e4e9e8cb3@starfivetech.com>
 <824cee7b-e4d3-461a-8bfb-4ad095c240fd@linaro.org>
 <20231113-sprung-tantrum-94659009b9d4@squawk>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20231113-sprung-tantrum-94659009b9d4@squawk>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/14 4:17, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 09:07:15PM +0100, Krzysztof Kozlowski wrote:
>> On 13/11/2023 10:42, William Qiu wrote:
>> > Will update.
>> >>> +
>> >>> +allOf:
>> >>> +  - $ref: pwm.yaml#
>> >>> +
>> >>> +properties:
>> >>> +  compatible:
>> >>> +    oneOf:
>> >>> +      - items:
>> >>> +          - enum:
>> >>> +              - starfive,jh7100-pwm
>> >>> +              - starfive,jh7110-pwm
>> >>> +          - const: opencores,pwm
>> >>
>> >> That's a very, very generic compatible. Are you sure, 100% sure, that
>> >> all designs from OpenCores from now till next 100 years will be 100%
>> >> compatible?
>> >>
>> > My description is not accurate enough, this is OpenCores PTC IP, and PWM
>> > is one of those modes, so it might be better to replace compatible with
>> > "opencores, ptc-pwm"
>> > 
>> > What do you think?
>> 
>> Sorry, maybe this answers maybe doesn't. What is "PTC"?
> 
> "pwm timer counter". AFAIU, the IP can be configured to provide all 3.
> I think that William pointed out on an earlier revision that they have
> only implemented the pwm on their hardware.
> I don't think putting in "ptc" is a sufficient differentiator though, as
> clearly there could be several different versions of "ptc-pwm" that have
> the same concern about "all designs from OpenCores for now till the next
> 100 years" being compatible.
> 
> Cheers.
> Conor.

Hi，Conor and Krzysztof,

After discussion and review of materials, we plan to use "opencores,ptc-pwm-v1"
as this version of compatible, so that it can also be compatible in the future.

What do you think?


Best regards,
William
