Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E07E07C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjKCRvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCRvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:51:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B1A1D42;
        Fri,  3 Nov 2023 10:51:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77F962F4;
        Fri,  3 Nov 2023 10:52:29 -0700 (PDT)
Received: from [10.57.81.32] (unknown [10.57.81.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D4DC3F738;
        Fri,  3 Nov 2023 10:51:41 -0700 (PDT)
Message-ID: <1cbc6def-8255-4a13-99b0-145d3f8ffcac@arm.com>
Date:   Fri, 3 Nov 2023 17:51:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Content-Language: en-GB
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Leo Yan <leoy@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>
References: <20231102152033.5511-1-duje.mihanovic@skole.hr>
 <20231102152033.5511-3-duje.mihanovic@skole.hr>
 <ffb08cc2-705a-468e-b6d2-9ce591c08ab4@arm.com> <2919185.e9J7NaK4W3@radijator>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2919185.e9J7NaK4W3@radijator>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-03 5:02 pm, Duje Mihanović wrote:
> On Friday, November 3, 2023 4:34:54 PM CET Robin Murphy wrote:
>> On 2023-11-02 3:20 pm, Duje Mihanović wrote:
>>> +config ARCH_MMP
>>> +	bool "Marvell MMP SoC Family"
>>> +	select ARM_GIC
>>> +	select ARM_ARCH_TIMER
>>> +	select ARM_SMMU
>>
>> NAK, not only is selecting user-visible symbols generally frowned upon,
>> and ignoring their dependencies even worse, but for a multiplatform
>> kernel the user may well want this to be a module.
>>
>> If having the SMMU driver built-in is somehow fundamentally required for
>> this platform to boot, that would represent much bigger problems.
> 
> The SoC can boot without SMMU and PDMA, but not GIC, pinctrl or the arch
> timer. I see that most other SoCs still select drivers and frameworks they
> presumably need for booting, with the exceptions of ARCH_BITMAIN, ARCH_LG1K
> and a couple others. Which of these two options should I go for?

Well, you don't really need to select ARM_GIC or ARM_ARCH_TIMER here 
either, since those are already selected by ARM64 itself. Keeping 
PINCTRL_SINGLE is fair, although you should also select PINCTRL as its 
dependency.

As an additional nit, the file seems to be primarily ordered by symbol 
name, so it might be nice to slip ARCH_MMC in between ARCH_MESON and 
ARCH_MVEBU.

Cheers,
Robin.
