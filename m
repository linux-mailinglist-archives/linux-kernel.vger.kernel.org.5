Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B00786343
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbjHWWR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjHWWRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:17:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23471E76;
        Wed, 23 Aug 2023 15:17:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 915A83200942;
        Wed, 23 Aug 2023 18:17:44 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Wed, 23 Aug 2023 18:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692829064; x=1692915464; bh=AJ
        zczaftfjE76N6b8jnnq/OzxQnWOdo/COmnCGRSxTA=; b=CpIpmipw825f9G2aFd
        mvuICoMk17eBfE0b7h14mDcSLmJuH34n92aXzn9uhu0VhGdOlMrH3LlM/sflIzNg
        leWkguuIBkvlslMJfa7INxu4KImMMqMN8dco83g9Pj4tiy7Y/m7oqRC0H36HDW3q
        RqAOxDhCd4Ph6HnsTK0MaD3KdyQ1QbN1kOciHDUDriApyMLumslH3vJBh+wu21JI
        hXvpdbLCcYb33dEhl2TGPNAhdvQl4j6kvhZckmKxkLT0tXdyFUcYn1BNl4iSY1jR
        qy8e7DG+tRqaH8NymIYOOfUY6VkzXcstGbRZVtgmnL7UOByvZMWs3eMTKkP+zrUh
        O7CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692829064; x=1692915464; bh=AJzczaftfjE76
        N6b8jnnq/OzxQnWOdo/COmnCGRSxTA=; b=tmElo778KZyaHtTQ66a+vNCrw+wW/
        T8m7+vLDG+HvmclveoGcBEMQJ/gufEZWsADSQJMuBtow1c3HLkjykkfx42w8YkKh
        2FCRKpYMokokGCwPN2lEZzPBihmdKLLS/gHvcwtcSw+lQxv8ODUYV35lxK1C4CaV
        cHNFh6PpEEpU8bvIDUXzEvFafNyoRv9qwY9Nfa5CWigbKNPmYWueaT8sNK58UVX3
        feqFsqiQtxFPWM3v/yVJX9Vq129A5/uLpRNob+m9qT2gYnsZvC1hGfMDXxEVLmNa
        7QHAHPqV7mPE1xGDeRFzsuesziBY50g9ajyTeLVBPiDyHo5mPg8RnvImQ==
X-ME-Sender: <xms:hoXmZINLV1HZfbswP3fp06eE01QvhPiUu0OpBA6R5qJf2pNkU8Z68w>
    <xme:hoXmZO_0vI4WfmXFkp4Iv-Ikq3OSNkgdIS6hMMvqjhUuJ15jFArhnVo_lF7xIm58S
    3BGR-GsAWooM0XxfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvhedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeeffeejgfefieetueeffeeiiedthffghefhtdffveegudegffduuddt
    hfelleeludenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruh
X-ME-Proxy: <xmx:hoXmZPRbN5CH7cDcbokCm30hfByvnlX7U2eYVuQnZ1FWPVxZz9cMkg>
    <xmx:hoXmZAvLAsZwynnZMElYQfF_CgAkWgAhiWO9IkZyFFi8QZXI-Q6Q4Q>
    <xmx:hoXmZAcaBMYnSht-nWg2xvV1U07kn-lyAtWaFL1Rqq8HGk9HWo5cig>
    <xmx:iIXmZHwpBW-pzDWZP5cM0QUIPqgufG_s38dveUqp-vSYAm3hwSXKlg>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E7B071700096; Wed, 23 Aug 2023 18:17:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-647-g545049cfe6-fm-20230814.001-g545049cf
Mime-Version: 1.0
Message-Id: <e536fefa-18b9-48e3-8c70-e56dcd30123a@app.fastmail.com>
In-Reply-To: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
References: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
Date:   Thu, 24 Aug 2023 07:47:21 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     peteryin <peteryin.openbmc@gmail.com>,
        "Joel Stanley" <joel@jms.id.au>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Eddie James" <eajames@linux.ibm.com>,
        "Johnny Huang" <johnny_huang@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     peteryin <peter.yin@quantatw.com>
Subject: Re: [PATCH] Title: Select GPIO command source.
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, 24 Aug 2023, at 01:38, peteryin wrote:
> From: peteryin <peter.yin@quantatw.com>
>
> Description:
>   The capability to choose the GPIO command source
> between ARM LPC and Coprocessor CPU is supported.
>
> Test Plan:
> Get Bank gpio command source
>   e.g.
>   cd /sys/bus/platform/drivers/aspeed-command-source/
>   cat 1e780000.gpio-command-source/bank_abcd
>   ARM ARM ARM ARM
>
> Set Bank gpio command source.
>   e.g.
>   cd /sys/bus/platform/drivers/aspeed-command-source/
>
>   echo "A ARM" > 1e780000.gpio-command-source/bank_abcd
>   or
>   echo "A LPC" > 1e780000.gpio-command-source/bank_abcd
>   or$
>   echo "A COP" > 1e780000.gpio-command-source/bank_abcd
>
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> ---
>  .../sysfs-driver-aspeed-gpio-command-source   |  24 ++
>  .../soc/aspeed/gpio-command-source.yaml       |  58 ++++
>  drivers/soc/aspeed/Kconfig                    |   9 +
>  drivers/soc/aspeed/Makefile                   |   1 +
>  drivers/soc/aspeed/aspeed-command-source.c    | 266 ++++++++++++++++++
>  5 files changed, 358 insertions(+)
>  create mode 100644 
> Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
>  create mode 100644 
> Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
>  create mode 100644 drivers/soc/aspeed/aspeed-command-source.c
>
> diff --git 
> a/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source 
> b/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
> new file mode 100644
> index 000000000000..4698f47a1f75
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
> @@ -0,0 +1,24 @@
> +What:		/sys/bus/platform/drivers/aspeed-command-source/\*command\*/bank\*
> +Date:		August 2023
> +Contact:	Peter Yin <peter.yin@quantatw.com>
> +Description:	Get or set the gpio command source for ARM, LPC or 
> Coprocessor CPU.
> +
> +		When read, each file shows the list of available options with bank
> +		that depends on the selected bank file.
> +
> +		e.g.
> +		get gpio command source
> +		cd /sys/bus/platform/drivers/aspeed-command-source/
> +		cat 1e780000.gpio-command-source/bank_abcd
> +		ARM ARM ARM ARM
> +		In this case, gets bank gpio command source.
> +
> +
> +		e.g.
> +		set gpio command source
> +		cd /sys/bus/platform/drivers/aspeed-command-source/
> +		echo "A ARM" > 1e780000.gpio-command-source/bank_abcd
> +		or
> +		echo "A LPC" > 1e780000.gpio-command-source/bank_abcd
> +		or
> +		echo "A COP" > 1e780000.gpio-command-source/bank_abcd
> diff --git 
> a/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml 
> b/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
> new file mode 100644
> index 000000000000..034183667501
> --- /dev/null
> +++ 
> b/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# # Copyright (c) 2023 Quanta Inc.
> +%YAML 1.2
> +---
> +$id: 
> "http://devicetree.org/schemas/soc/aspeed/gpio-command-source.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Aspeed UART Routing Controller
> +
> +maintainers:
> +  - Peter Yin <peter.yin@quantatw.com>
> +
> +description:
> +  The Aspeed gpio command source control allow to dynamically write 
> the inputs for
> +  the built-in gpio command source.
> +
> +  This allows, for example, to connect the gpio command source to ARM 
> LPC or Coprocessor CPU.
> +  e.g. let LPC port80 to connect the gpio group.
> +
> +  This driver is for the BMC side. The sysfs files allow the BMC 
> userspace
> +  which owns the system configuration policy, to configure gpio 
> command source.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2600-gpio-command-source
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +  gpio0: gpio@1e780000 {
> +    #gpio-cells = <2>;
> +    gpio-controller;
> +    compatible = "aspeed,ast2600-gpio", "simple-mfd", "syscon";
> +    reg = <0x1e780000 0x400>;
> +    interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +    gpio-ranges = <&pinctrl 0 0 208>;
> +    ngpios = <208>;
> +    clocks = <&syscon ASPEED_CLK_APB2>;
> +    interrupt-controller;
> +    #interrupt-cells = <2>;
> +
> +    #address-cells = <1>;
> +    #size-cells = <1>;
> +    ranges = <0x0 0x1e780000 0x400>;
> +    gpio_command_source: gpio-command-source@0 {
> +      compatible = "aspeed,ast2600-gpio-command-source";

You're using the devicetree to load a specific driver rather than to describe the hardware.

The command source registers are fundamentally part of the GPIO block. As such, the kernel support for the feature should be integrated into the existing GPIO driver. It should not be necessary to add this binding to expose the feature.

Andrew
