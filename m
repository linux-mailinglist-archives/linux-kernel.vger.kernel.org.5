Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864AF7AD27D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjIYH60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjIYH6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:58:24 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9AE3;
        Mon, 25 Sep 2023 00:58:17 -0700 (PDT)
Received: from [192.168.88.20] (91-157-153-81.elisa-laajakaista.fi [91.157.153.81])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7E53BEEE;
        Mon, 25 Sep 2023 09:56:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695628595;
        bh=xEzhsc3FN6UKMFcpvmm4Yd3AEeRG98yKKMebcBkD+Lk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bZJou6m/blG7lo+/sh7rqWAtjgybB3KtR8RErxAUWcwBWoNcD1OFqfl3Wh65igsav
         rzBIquqR53I6APAo5atOKT0JVCinzULF9FKMwHLs+LlmAWkC2+O4apaK32NknBKEqi
         fhIpIGedTkOi29Sr8cJWf+16O7Lxbd+wW5Xq3k5E=
Message-ID: <4ddd4851-1476-ea99-dbca-01813910a0ea@ideasonboard.com>
Date:   Mon, 25 Sep 2023 10:58:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 3/5] arm64: dts: ti: k3-j784s4-main: Add DSS and
 DP-bridge node
To:     Jayesh Choudhary <j-choudhary@ti.com>,
        Maxime Ripard <mripard@kernel.org>, r-ravikumar@ti.com
Cc:     nm@ti.com, vigneshr@ti.com, afd@ti.com, rogerq@kernel.org,
        s-vadapalli@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        a-bhatia1@ti.com, sabiya.d@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230803080441.367341-1-j-choudhary@ti.com>
 <20230803080441.367341-4-j-choudhary@ti.com>
 <aqfx7fj446gkyirhsiwijiuilhoao4hexmpjfxu4gojpujhbib@2wqzjuh3yz46>
 <427dc37e-1bf5-d3d7-f4af-1a0ee980f28b@ti.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <427dc37e-1bf5-d3d7-f4af-1a0ee980f28b@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 09:46, Jayesh Choudhary wrote:
> Hello Maxime,
> 
> On 17/08/23 16:24, Maxime Ripard wrote:
>> Hi,
>>
>> On Thu, Aug 03, 2023 at 01:34:39PM +0530, Jayesh Choudhary wrote:
>>> From: Rahul T R <r-ravikumar@ti.com>
>>>
>>> Add DSS and DP-bridge node for J784S4 SoC. DSS IP in J784S4 is
>>> same as DSS IP in J721E, so same compatible is being used.
>>> The DP is Cadence MHDP8546.
>>>
> 
> [...]
> 
>>> +
>>> +    dss: dss@4a00000 {
>>> +        compatible = "ti,j721e-dss";
>>
>> As far as I can see, this compatible limits the (DPI) pixel clock to
>> 160MHz, but the TRM seems to mention that it's 600MHz?
>>
>> Is it expected?
>>
> I am unsure about why the max DPI pixel clock was set to 170MHz for
> videoport bus type DISPC_VP_DPI.
> Bus type DISPC_VP_DPI is used only for tfp410 bridge which can support
> min 6.06ns pixel period (165MHz pixel clk).
> I think the max value however should still be independent to what the
> bridge can support.
> We can look into this issue independent to this series.
> 
> Tomi,
> Any comments here..
> There should not be any issue making the max pixel clock for DPI bus 
> type 600 MHz as well????

The dispc can output at high frequency, but when it goes to DPI, meaning 
a parallel video bus outside the SoC, we move into another domain. And 
even if the signals would be ok at the SoC's pins at higher freqs, I'm 
sure they would degrade quickly with a cable going to the panel 
(Disclaimer: I'm no HW engineer =)). If I had to guess, I'd guess that 
200 MHz would still be fine-ish in most cases, but I have hard time 
believing that a 300 MHz DPI signal would look valid in an oscilloscope.

With a quick look, the J7 datasheet says "Cycle time, VOUT(x)_PCLK " has 
min 6.06 ns. As that's the same as the one you mention for tfp410, and 
results in 165MHz, it sounds to me that it's just a safe limit, not any 
kind of real limit.

On DRA76, I think the "offical" DPI max was the same, but running with 
~210 MHz still worked fine, for the particular pieces of hardware I had.

So... I'd keep it (at least near) the official limit, unless someone has 
use cases which require higher frequencies.

  Tomi

