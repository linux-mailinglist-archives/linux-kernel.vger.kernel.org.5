Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0276AA8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjHAIJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjHAIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:09:57 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069DB1AC;
        Tue,  1 Aug 2023 01:09:53 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=6591581bf9=fe@dev.tdt.de>)
        id 1qQkS0-00B9XJ-2b; Tue, 01 Aug 2023 10:09:52 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qQkRz-009Bil-Ku; Tue, 01 Aug 2023 10:09:51 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 36FF4240049;
        Tue,  1 Aug 2023 10:09:51 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id DD65A240040;
        Tue,  1 Aug 2023 10:09:50 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 7358431526;
        Tue,  1 Aug 2023 10:09:50 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Aug 2023 10:09:50 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, yzhu@maxlinear.com,
        rtanwar@maxlinear.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH 2/2] dt-bindings: clock: intel,cgu-lgm: add
 mxl,control-gate option
In-Reply-To: <75cbeeed-84c9-7637-b2a7-b37d87f5872e@linaro.org>
References: <20230731100349.184553-1-fe@dev.tdt.de>
 <20230731100349.184553-3-fe@dev.tdt.de>
 <780aa090-3a97-abab-271f-59790df29cc4@linaro.org>
 <11386dd27487075a9a0b1a2aa7794951@dev.tdt.de>
 <75cbeeed-84c9-7637-b2a7-b37d87f5872e@linaro.org>
Message-ID: <2053f32f262911061e3e56540e4b51d4@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1690877392-E1EB7653-5A2FF43C/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

>>> You described the desired Linux feature or behavior, not the actual
>>> hardware. The bindings are about the latter, so instead you need to
>>> rephrase the property and its description to match actual hardware
>>> capabilities/features/configuration etc.
>> 
>> You have correctly identified that this is not a hardware 
>> configuration,
>> but a driver configuration. Currently, the driver is configured so 
>> that
>> the gates cannot be switched via the clk subsystem callbacks. When
>> registering the data structures from the driver, I have to pass a flag
>> GATE_CLK_HW so that the gate is managed by the driver.
>> 
>> I didn't want to always change the source of the driver when it has to
>> take
>> care of the GATE, so I wanted to map this via the dts.
>> 
>> I have a board support package from Maxlinear for the Lightning 
>> Mountain
>> Soc
>> with other drivers that are not upstream now. Some of them use the
>> clock framework some of them does not.
>> 
>> Due to missing documents it is not possible to send these drivers
>> upstream.
> 
> So when you upstream them, the binding becomes wrong or not needed?
> Sorry, bindings are entirely independent of OS, so using this as an
> argument is clear no-go.

Yes, that would probably be the case, as the maxlinear drivers are at
an early stage and are not yet upstreamable in my opinion. If I had the
documents, I would take a closer look. But they are developing behind
closed doors. Nothing can be contributed. Not until the drivers are
hopefully upstream at some point as the cgu-lgm.

>> Strictly speaking, this is about the gptc and the watchdog.
>> 
>> Since it is a buildin_platform driver, it can also not work via
>> module parameters.
> 
> None of this explains any hardware related part of this binding. You
> created now policy for one specific OS. Devicetree, which is OS
> independent, is not for such purposes.

Yes this would be the case. Maybe I need to patch the cgu-lgm.c [1]
and send it upstream to restore the old behavior.
Because the following commit has changed the behaviour [2].
Unfortunately, it is also included in 5.15 stable branch.
Which in my opinion should not have happened!

Best regards,
Florian

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/x86/clk-lgm.c?h=v6.5-rc4
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/clk/x86/clk-cgu.c?h=v5.15.123&id=a0583edea4fdb7b5b87a077263dddab476e9f138
