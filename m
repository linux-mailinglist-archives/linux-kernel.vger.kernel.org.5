Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FD07755F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjHII5I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjHII5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:57:00 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E011FD5;
        Wed,  9 Aug 2023 01:56:55 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=659920474f=fe@dev.tdt.de>)
        id 1qTezt-0049NZ-5v; Wed, 09 Aug 2023 10:56:53 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qTezs-0049La-Nb; Wed, 09 Aug 2023 10:56:52 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 46F1E240049;
        Wed,  9 Aug 2023 10:56:52 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id E6661240040;
        Wed,  9 Aug 2023 10:56:51 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 8AA2028A3A;
        Wed,  9 Aug 2023 10:56:50 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date:   Wed, 09 Aug 2023 10:56:50 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Yi xin Zhu <yzhu@maxlinear.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mturquette@baylibre.com, sboyd@kernel.org,
        Rahul Tanwar <rtanwar@maxlinear.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH 2/2] dt-bindings: clock: intel,cgu-lgm: add
 mxl,control-gate option
In-Reply-To: <1f8e054d-6b7f-4e82-17de-e0df3ddacbff@maxlinear.com>
References: <20230731100349.184553-1-fe@dev.tdt.de>
 <20230731100349.184553-3-fe@dev.tdt.de>
 <780aa090-3a97-abab-271f-59790df29cc4@linaro.org>
 <11386dd27487075a9a0b1a2aa7794951@dev.tdt.de>
 <1f8e054d-6b7f-4e82-17de-e0df3ddacbff@maxlinear.com>
Message-ID: <a6a19b15858afcf8d7aa903ccca41d8f@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8BIT
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1691571413-B3C290DF-64CA1DF2/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>> Strictly speaking, this is about the gptc and the watchdog.
>> 
>> Since it is a buildin_platform driver, it can also not work via
>> module parameters.
> 
> Could you please give more details on your target?

We are currently putting our own board with the new Maxlinear URX85x
into operation. From Maxlinear we have received a board support
package BSP named UGW 9.1.45.

Since we not only have Maxlinear devices, but also other SoC from
other manufacturers, we cannot use the BSP. We therefore need to use
OpenWrt vanilla (master, openwrt-23.05) to support all our devices
with the same software stack.

We have therefore picked all the relevant software components
from UGW and ported them to the next openwrt-23.05 stable release.

Due to the last rebasing of the kernel by openwrt to 5.15.123 [1],
this patch [2] has been included. After that change, the gptc and
watchdog drivers can't find the cgu device tree handlers and
stopped working!

> In what kind of condition, you want to change the flag?

Since we don't have access to the latest internal MxL code base,
we don't know what has been changed since then. Therefore we ended
up with reverting your last change [2] to get the gptc and watchdog
driver working again.

> In LGM SoC,  some gate clocks can be covered by EPU (power management
> module).

We have already seen that in your BSP. But this driver is not integrated
upstream and is unfortunately only maintained in the BSP :-(. So no one
knows about that.

> that is the reason clock driver introduced the HW/SW flag definition.

Since we don't have a hardware description, but only your drivers, it
is difficult for us to find out how everything fits together. In 
addition,
not all drivers are upstream, which makes it even more confusing for us.

> However gptc and watchdog are not covered by EPU.  it can only be
> controlled via clock
> driver.   So I'm not quite sure the target to change the flag for these
> two clocks.

So only Maxlinear knows the internals, then this is up to you to make
the right choice.

The major problem is that not all relevant drivers are upstreamed.
Mixing upstreamed and proprietary drivers definitely leads to 
regressions.

By the way, up to now the SoC is not selectable. There are patches 
needed
from your BSP for the kernel to make the SoC URX85x selectable with
'make menuconfig'

Can you *please* integrate them upstream, so that the patches do not 
always have
to be extracted and rebased from the BSP!

We can discuss this in a separate thread.
Thanks for your feedback

Best regards

Florian

[1] 
https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=7efec0acca80b231ab8e69729a4bdaf11ef84541
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/clk/x86/clk-cgu.c?h=linux-5.15.y&id=a0583edea4fdb7b5b87a077263dddab476e9f138

