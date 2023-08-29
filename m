Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5698178BC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjH2B6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjH2B6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:58:31 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18941A2;
        Mon, 28 Aug 2023 18:58:25 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8D3F47FFE;
        Tue, 29 Aug 2023 09:58:22 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 09:58:22 +0800
Received: from [192.168.125.72] (113.72.145.245) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 09:58:21 +0800
Message-ID: <afac7b40-1bdc-c546-1ba1-2cfba74e6adc@starfivetech.com>
Date:   Tue, 29 Aug 2023 09:58:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [-next v1] riscv: dts: starfive: visionfive 2: Enable usb0 and
 fix tdm pins sort order
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230828115239.16012-1-hal.feng@starfivetech.com>
 <3a5e343c-a0cc-8d1b-eadc-82c3d038aaa1@linaro.org>
 <20230828-hence-unguarded-2020c68246e8@wendy>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230828-hence-unguarded-2020c68246e8@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.245]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 13:05:06 +0100, Conor Dooley wrote:
> On Mon, Aug 28, 2023 at 01:54:53PM +0200, Krzysztof Kozlowski wrote:
>> On 28/08/2023 13:52, Hal Feng wrote:
>> > usb0 was disabled by mistake when merging, so enable it.
>> > tdm_pins node should be sorted alphabetically.
>> > 
>> > Fixes: e7c304c0346d ("riscv: dts: starfive: jh7110: add the node and pins configuration for tdm")
>> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> > ---
>> >  .../jh7110-starfive-visionfive-2.dtsi         | 49 ++++++++++---------
>> >  1 file changed, 25 insertions(+), 24 deletions(-)
>> > 
>> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> > index d79f94432b27..382dfb5e64e4 100644
>> > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> > @@ -440,30 +440,6 @@ GPOEN_ENABLE,
>> >  		};
>> >  	};
>> >  
>> > -	uart0_pins: uart0-0 {
>> > -		tx-pins {
>> > -			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
>> > -					     GPOEN_ENABLE,
>> > -					     GPI_NONE)>;
>> > -			bias-disable;
>> > -			drive-strength = <12>;
>> > -			input-disable;
>> > -			input-schmitt-disable;
>> > -			slew-rate = <0>;
>> > -		};
>> > -
>> > -		rx-pins {
>> > -			pinmux = <GPIOMUX(6, GPOUT_LOW,
>> > -					     GPOEN_DISABLE,
>> > -					     GPI_SYS_UART0_RX)>;
>> > -			bias-disable; /* external pull-up */
>> > -			drive-strength = <2>;
>> > -			input-enable;
>> > -			input-schmitt-enable;
>> > -			slew-rate = <0>;
>> > -		};
>> > -	};
>> > -
>> >  	tdm_pins: tdm-0 {
>> >  		tx-pins {
>> >  			pinmux = <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
>> > @@ -497,6 +473,30 @@ GPOEN_DISABLE,
>> >  			input-enable;
>> >  		};
>> >  	};
>> > +
>> > +	uart0_pins: uart0-0 {
>> > +		tx-pins {
>> > +			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
>> > +					     GPOEN_ENABLE,
>> > +					     GPI_NONE)>;
>> > +			bias-disable;
>> > +			drive-strength = <12>;
>> > +			input-disable;
>> > +			input-schmitt-disable;
>> > +			slew-rate = <0>;
>> > +		};
>> > +
>> > +		rx-pins {
>> > +			pinmux = <GPIOMUX(6, GPOUT_LOW,
>> > +					     GPOEN_DISABLE,
>> > +					     GPI_SYS_UART0_RX)>;
>> > +			bias-disable; /* external pull-up */
>> > +			drive-strength = <2>;
>> > +			input-enable;
>> > +			input-schmitt-enable;
>> > +			slew-rate = <0>;
>> > +		};
>> 
>> 
>> What is fixed in this hunk? Order of nodes is just a style, not a bug
>> needing backports.
> 
> Please split this in two parts, with one for my screwed up conflict
> resolution & one for the node ordering.

OK, I will split this into two patches. Thanks.

Best regards,
Hal
