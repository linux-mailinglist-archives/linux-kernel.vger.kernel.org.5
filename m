Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEBC800926
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378371AbjLAK4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378351AbjLAK4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:56:19 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982658E;
        Fri,  1 Dec 2023 02:56:24 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6509E000A;
        Fri,  1 Dec 2023 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701428183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aHykdI2ZYd1V9EjT5KVj02Y0Ap+cQgVJzA3meTQI8g=;
        b=iEZjQQCWe6qrlWcccMIHxYXYpai7JvMmIwbARLlXoLnLmilJAoiCMiike1Pcq0ppcc3F7H
        FUvg02eTR4x8vnnXl8aJoVKmNFgpjSgSvdnQCH9ggxCpvx6tInGPi1s6R+Jh3LkESVgs5x
        27eSkWLQ9QE8+9FSBXiiypTvq/h1fTJJSUVRQ8zAjNfaCvjaWHmuvOajwnChg8wERuzScm
        aN4plzh4zs/MQmMFQkuAP+QuMN+nd5lbkOigA1cJ2jLJGjGI1QQXh6YHcFTgOj8Iz9/qDu
        FtQ2MjYJM0gQ574dGqDiFtPCkpN+sKJr6oVKgEllR4bopdeWkq47g7wPycheSQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 18/21] MIPS: mobileye: Add EyeQ5 dtsi
In-Reply-To: <46bba00c-00b7-46db-984c-4391f7fc11f6@linaro.org>
References: <20231123152639.561231-1-gregory.clement@bootlin.com>
 <20231123152639.561231-19-gregory.clement@bootlin.com>
 <46bba00c-00b7-46db-984c-4391f7fc11f6@linaro.org>
Date:   Fri, 01 Dec 2023 11:56:22 +0100
Message-ID: <87r0k6dwdl.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 23/11/2023 16:26, Gregory CLEMENT wrote:
>> Add a device tree include file for the Mobileye EyeQ5 SoC.
>> 
>> Based on the work of Slava Samsonov <stanislav.samsonov@intel.com>
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>
>
>> +	aliases {
>> +		serial0 = &uart0;
>> +		serial1 = &uart1;
>> +		serial2 = &uart2;
>> +	};
>> +
>> +	cpu_intc: interrupt-controller {
>> +		compatible = "mti,cpu-interrupt-controller";
>> +		interrupt-controller;
>> +		#address-cells = <0>;
>> +		#interrupt-cells = <1>;
>> +	};
>> +
>> +	gic: interrupt-controller@140000 {
>
> Why do you put MMIO nodes in top-level?

I can move it back under the soc node I think

>
>> +		compatible = "mti,gic";
>> +		reg = <0x0 0x140000 0x0 0x20000>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <3>;
>> +
>> +		/*
>> +		* Declare the interrupt-parent even though the mti,gic
>> +		* binding doesn't require it, such that the kernel can
>> +		* figure out that cpu_intc is the root interrupt
>> +		* controller & should be probed first.
>> +		*/
>> +		interrupt-parent = <&cpu_intc>;
>> +
>> +		timer {
>> +			compatible = "mti,gic-timer";
>> +			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
>> +			clocks = <&core0_clk>;
>> +		};
>> +	};
>> +
>> +	soc: soc {
>
> Are you sure dtbs_check W=1 does not complain? I think you miss here
> address.

Yes dtbs_check W=1 does not complain. There is no reg property in this
node, so there is no address to add to the name of the node.

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
