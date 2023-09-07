Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5492F79788F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbjIGQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbjIGQs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:48:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C03DF1BFD;
        Thu,  7 Sep 2023 09:48:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECB891042;
        Thu,  7 Sep 2023 09:48:17 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2540E3F67D;
        Thu,  7 Sep 2023 09:47:38 -0700 (PDT)
Message-ID: <b34a6196-6c24-a664-611b-6055480880ee@arm.com>
Date:   Thu, 7 Sep 2023 17:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: rockchip: Add io domain
 properties
Content-Language: en-GB
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-3-s.hauer@pengutronix.de>
 <b4017947-9e16-7d97-a7b1-3e6964a1f7a9@arm.com>
 <5166ca75-5454-8f64-4f61-fcc0f7a4c235@theobroma-systems.com>
 <20230906101909.GB492117@pengutronix.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230906101909.GB492117@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 11:19 am, Sascha Hauer wrote:
> On Wed, Sep 06, 2023 at 10:20:26AM +0200, Quentin Schulz wrote:
>> Sascha, Robin,
>>
>> On 9/5/23 11:03, Robin Murphy wrote:
>>> [You don't often get email from robin.murphy@arm.com. Learn why this is
>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>>> +ï¿œï¿œï¿œï¿œï¿œï¿œï¿œ type: boolean
>>>> +ï¿œï¿œï¿œï¿œï¿œï¿œï¿œ description:
>>>> +ï¿œï¿œï¿œï¿œï¿œï¿œï¿œï¿œï¿œ If true assume that the io domain needed for this pin
>>>> group has been
>>>> +ï¿œï¿œï¿œï¿œï¿œï¿œï¿œï¿œï¿œ configured correctly by the bootloader. This is needed to
>>>> break cyclic
>>>> +ï¿œï¿œï¿œï¿œï¿œï¿œï¿œï¿œï¿œ dependencies introduced when a io domain needs a
>>>> regulator that can be
>>>> +ï¿œï¿œï¿œï¿œï¿œï¿œï¿œï¿œï¿œ accessed through pins configured here.
>>>
>>> This is describing a Linux implementation detail, not the binding
>>> itself. There's no technical reason a DT consumer couldn't already
>>> figure this much out from the existing topology (by observing that the
>>> pinctrl consumer is a grandparent of the I/O domain's supply).
>>>
>>
>> I am guessing you're suggesting to have some complex handling in the driver
>> to detect those cyclic dependencies and ignore the IO domain dependency for
>> the pinctrl pins where this happens?
> 
> I haven't read this as a suggestion, but only as an argument to make it
> clear that I should describe the binding rather than anticipating
> how it should be used.
> 
> I may have misunderstood it though.

Indeed it was more about the definition itself - an extra property isn't 
*needed* to break the cycle since the cycle is already fully described 
in DT, so anyone who can parse parents and phandles already has 
sufficient information to detect it and break it at any point they 
choose. However, as mentioned subsequently, breaking the cycle alone 
isn't enough to guarantee that things will actually work in general.

AFAICS what we fundamentally need to know is the initial voltage of the 
supply regulator, to be able to short-circuit requiring the I/O domain 
in order to query it from the regulator itself, and instead just 
initialise the I/O domain directly. However that would still represent a 
bunch of fiddly extra DT parsing, so for practical purposes it seems 
reasonable to then short-cut that into directly describing the initial 
setting of the I/O domain on the node itself, such that the consumer of 
the binding can easily handle it all in a self-contained manner.

Cheers,
Robin

>> One of the issues we're having here too is that we lose granularity. There
>> are multiple domains inside an IO domain device and here we make the whole
>> pinctrl device depend on all domains from one IO domain device (there can be
>> multiple ones) while it is factually (on the HW level) only dependent on one
>> domain. Considering (if I remember correctly) Heiko highly suggested we
>> think about adding child nodes to the IO domain devices to have a DT node
>> per domain in the IO domain device, how would this work with the suggested
>> DT binding?
> 
> I started implementing that. I have moved the IO domains into subnodes
> of the IO domain controller and started adding phandles from the pin
> groups in rk3568-pinctrl.dtsi to the corresponding IO domains. After a
> couple of hours I had phandles for around a quarter of the existing
> groups of only one SoC, so doing this for all SoCs would really be a
> cumbersome job.
> 
> In the end I realized this doesn't solve any problem. Also adding the
> properties I suggested doesn't prevent us from adding the more specific
> dependencies from the pins to their actual IO domains later.
> 
> Sascha
> 
