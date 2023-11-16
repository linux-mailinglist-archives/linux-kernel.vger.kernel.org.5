Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865ED7ED9A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbjKPCj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjKPCj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:39:27 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F05D199;
        Wed, 15 Nov 2023 18:39:23 -0800 (PST)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id C667442AF;
        Wed, 15 Nov 2023 18:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1700102363;
        bh=4q1q7lhezpq/0nWCFgR7MsiQUEeQlSbd2dM5jhV/qog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcnoulhtqbhUn5EZOFj7D+/JbKkpUwqvwcZxEHvD6aC/mZ341nKINT4OE0Eixip+T
         xZZNg47oC1rErtlZogQ5oequAzUi4qRH86nRuOsULxM+SxfE/sAaz6W88cBOxU9qzN
         iWBacofijjfo1Idm+DA2u1CNr2a6U9pT77cZ0KlA=
Date:   Wed, 15 Nov 2023 18:39:21 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
Message-ID: <1e1c1493-d3f5-4c96-b85f-158d720b2ab5@hatter.bewilderbeest.net>
References: <20231114112722.28506-4-zev@bewilderbeest.net>
 <20231114112722.28506-6-zev@bewilderbeest.net>
 <cde26249-1d47-496f-b198-a0c4c02bed5c@linaro.org>
 <e766e663-0985-4a2e-8023-26ad0228157d@hatter.bewilderbeest.net>
 <863a0fe2-c258-47d9-8563-6f12bb55b4ad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <863a0fe2-c258-47d9-8563-6f12bb55b4ad@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 04:13:29AM PST, Krzysztof Kozlowski wrote:
>On 14/11/2023 23:37, Zev Weiss wrote:
>
>>
>>>> +	};
>>>> +
>>>> +	memory@80000000 {
>>>> +		reg = <0x80000000 0x20000000>;
>>>> +	};
>>>> +
>>>> +	leds {
>>>> +		compatible = "gpio-leds";
>>>> +
>>>> +		heartbeat {
>>>
>>> It does not look like you tested the DTS against bindings. Please run
>>> `make dtbs_check W=1` (see
>>> Documentation/devicetree/bindings/writing-schema.rst or
>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>> for instructions).
>
>The node names are clearly wrong and you got output. It's easy to spot
>if your patch worked in the first place:
>
> fatal error: dt-bindings/watchdog/aspeed-wdt.h: No such file or directory
>

The patch series was based on Linus's tree at the time I sent it; that 
file was added in commit 9931be2cfca3 ("dt-bindings: watchdog: 
aspeed-wdt: Add aspeed,reset-mask property"), which was included in the 
6.7-rc1 tag, FWIW.

After some debugging I discovered that the reason I wasn't getting any 
output from dtbs_check was that I had neglected to specify ARCH=arm when 
invoking it, and when that defaulted to x86 it silently did a whole 
bunch of nothing.  It might be nice if something emitted some sort of 
warning when invoked with nonsensical parameters (especially if I've 
explicitly specified a dtstree=... argument pointing to arch/arm/...), 
but oh well.

After re-running it with ARCH=arm, it produced a fairly voluminous spew 
of output, though after combing through it all as best I can tell only 
one or two lines of it actually pertain to the .dts in question itself 
(the vast majority being from a .dtsi it #includes).  I've fixed the one 
remaining issue it reported (missing #address-cells and #size-cells on 
the FRU eeprom node) and will post a v2 in the next few days (and 
likewise on the spc621d8hm3 series).


Zev

