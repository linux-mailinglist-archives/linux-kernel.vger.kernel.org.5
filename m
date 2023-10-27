Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE35F7D9528
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345638AbjJ0KYJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Oct 2023 06:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjJ0KYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:24:08 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD760D7;
        Fri, 27 Oct 2023 03:24:03 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 70B0724DBFD;
        Fri, 27 Oct 2023 18:24:01 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 27 Oct
 2023 18:24:01 +0800
Received: from [192.168.120.47] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 27 Oct
 2023 18:24:00 +0800
Message-ID: <e3faaa46-896a-405d-ac5f-97587e81fba4@starfivetech.com>
Date:   Fri, 27 Oct 2023 18:23:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] pwm: opencores: Add PWM driver support
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
 <20231020103741.557735-3-william.qiu@starfivetech.com>
 <20231020112539.gctx5uj2rrhryulo@pengutronix.de>
 <b2ef7299-5d5a-4ef7-89fd-04b6130cb227@starfivetech.com>
 <20231024114545.73ljfceuon2blkxz@pengutronix.de>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20231024114545.73ljfceuon2blkxz@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/24 19:45, Uwe Kleine-König wrote:
> Hello William,
> 
> On Tue, Oct 24, 2023 at 05:16:49PM +0800, William Qiu wrote:
>> On 2023/10/20 19:25, Uwe Kleine-König wrote:
>> > Hello,
>> > 
>> > On Fri, Oct 20, 2023 at 06:37:39PM +0800, William Qiu wrote:
>> >> Add Pulse Width Modulation driver support for OpenCores.
>> >> 
>> >> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> >> ---
>> >>  MAINTAINERS              |   7 ++
>> >>  drivers/pwm/Kconfig      |  11 ++
>> >>  drivers/pwm/Makefile     |   1 +
>> >>  drivers/pwm/pwm-ocores.c | 211 +++++++++++++++++++++++++++++++++++++++
>> >>  4 files changed, 230 insertions(+)
>> >>  create mode 100644 drivers/pwm/pwm-ocores.c
>> >> 
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index 6c4cce45a09d..321af8fa7aad 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -16003,6 +16003,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
>> >>  F:	drivers/i2c/busses/i2c-ocores.c
>> >>  F:	include/linux/platform_data/i2c-ocores.h
>> >> 
>> >> +OPENCORES PWM DRIVER
>> >> +M:	William Qiu <william.qiu@starfivetech.com>
>> >> +M:	Hal Feng <hal.feng@starfivetech.com>
>> >> +S:	Supported
>> >> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
>> >> +F:	drivers/pwm/pwm-ocores.c
>> >> +
>> >>  OPENRISC ARCHITECTURE
>> >>  M:	Jonas Bonn <jonas@southpole.se>
>> >>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> >> index 8ebcddf91f7b..cbfbf227d957 100644
>> >> --- a/drivers/pwm/Kconfig
>> >> +++ b/drivers/pwm/Kconfig
>> >> @@ -434,6 +434,17 @@ config PWM_NTXEC
>> >>  	  controller found in certain e-book readers designed by the original
>> >>  	  design manufacturer Netronix.
>> >> 
>> >> +config PWM_OCORES
>> >> +	tristate "Opencores PWM support"
>> >> +	depends on HAS_IOMEM && OF
>> >> +	depends on COMMON_CLK && RESET_CONTROLLER
>> > 
>> > Would it make sense to add something like:
>> > 
>> > 	depends on ARCH_SOMETHING || COMPILE_TEST
>> > 
>> > here?
>> > 
>> But there is no mention of architectural limitations in the OpenCores's
>> specification.
> 
> I already guessed that. Still it probably makes no sense to enable that
> option on most machines. The PWM device found in i.MX SoCs can
> theoretically also be implemented on AT91 or S390x. In practice it
> isn't, so there is a dependency on ARCH_MXC || COMPILE_TEST.
> 
> Consider the role of someone who does a kernel bump for a certain
> machine (on one end of the spectrum) or a distribution kernel (on the
> other end).
> 
> If you take a 6.5 x86_64 allmodconfig + COMPILE_TEST=n and upgrade to
> v6.6-rc7 and do an oldconfig, you get 90 questions[1].
> 
> Just looking quickly through this list, among them are:
> 
> 	DRM support for Loongson Graphics (DRM_LOONGSON) [N/m/?] (NEW) 
> 	Xilinx AXI DMAS Engine (XILINX_DMA) [N/m/y/?] (NEW)
> 	Clock driver for Renesas VersaClock 3 devices (COMMON_CLK_VC3) [N/m/y/?] (NEW)
> 	Realtek RT1017 SDCA Codec - SDW (SND_SOC_RT1017_SDCA_SDW) [N/m/?] (NEW)
> 
> I didn't check in detail and maybe one or the other is valid on x86_64,
> but I'd be surprised if you find two that are sensible to enable on
> x86_64 to support a real machine.
> 
> While I think Kconfig cannot be held responsible to only allow
> generating "real world sensible" configurations, we should work a bit
> harder to rule out the obvious violators and make it easy for people
> configuring the kernel where sensible.
> 
> In my book it's better to have a too strong dependency at first for a
> new driver (but allow it with COMPILE_TEST). Someone who as a device
> needing that driver will find it out and speak up. However if you allow
> to enable the driver everywhere, many people will disable the driver
> (maybe using yes '' | make oldconfig), some will spend time to research
> about this option to find which machines actually have such a device and
> if the machine(s) they care about are in this set. This is a waste of
> time and opportunities. (And note, this isn't only about people spending
> time to decide if they enable or disable PWM_OCORES, this is also about
> people who use yes '' because there are too many questions and so they
> might miss the handful of useful ones.)
> 
> Best regards
> Uwe
> 
> [1] measured using
> 
> 	yes '' | make oldconfig
> 
> and counting the occurrences of "(NEW)".
> 
I see, I'll think about it.
Maybe depend on STARFIVE'S SoCs first?

Best regards,
William
