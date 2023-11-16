Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A387EE64C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbjKPR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjKPR6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:58:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D0CD6B;
        Thu, 16 Nov 2023 09:58:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73177C433C7;
        Thu, 16 Nov 2023 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700157525;
        bh=RxJ6S2Hi/3+YDzTC2uALLuab6Zat66e3MT6zAyEv5yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSPpjdQveDhb+t5iA1s9xkPhSJowYPwGF0MCOFMCge22czZz10HFNo4z3C6iqDM+R
         USUAIyO4Cw+39lKg9nZL9/jlnhlkTS3PcEWi3gmt+NncFKNUJlbdY4y+aG7aOlM3Kr
         EzaKTTKGvX2L0DwEr4FXfxRWt/3GcLMSNuYjheb2cxlP/NMqj4ASM7ZnzC/NnBFOh+
         dx8u9d4qKNfRV+z3nhVNpfWXc4j/V0OIpuHohJ/F16zft3W+2h9wsWjilPcQVHxjsI
         lpiMGtwIsO4fUQ38FViuGH9tFXmP4zqUZtthkTNC0amMgw9jcOJcFKUqQ6tCSia2+t
         LUczGkbbiP9Ng==
Date:   Thu, 16 Nov 2023 12:58:44 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 34/40] arm64: dts: renesas: r8a779f0: spider:
 Enable PCIe Host ch0
Message-ID: <ZVZYVCE6rr9izfA2@sashalap>
References: <20231107121837.3759358-1-sashal@kernel.org>
 <20231107121837.3759358-34-sashal@kernel.org>
 <CAMuHMdXWBzM41KjWCVRTmncJa=e2degFqXpRG0M7jE+s-Rkysw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXWBzM41KjWCVRTmncJa=e2degFqXpRG0M7jE+s-Rkysw@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 07:50:52PM +0100, Geert Uytterhoeven wrote:
>Hi Sasha,
>
>On Tue, Nov 7, 2023 at 1:21 PM Sasha Levin <sashal@kernel.org> wrote:
>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> [ Upstream commit c588e1c9846b32182fd5a0ceb637b983810e7100 ]
>>
>> Enable PCIe Host controller channel 0 on R-Car S4-8 Spider board.
>>
>> Since this board has an Oculink connector, CLKREQ# pin of PFC for PCIe
>> should not be used. So, using a GPIO is used to output the clock instead.
>> Otherwise the controller cannot detect a PCIe device.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Link: https://lore.kernel.org/r/20230905012404.2915246-3-yoshihiro.shimoda.uh@renesas.com
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Thanks for your patch!
>
>> --- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
>
>> @@ -145,6 +157,18 @@ &mmc0 {
>>         status = "okay";
>>  };
>>
>> +&pcie0_clkref {
>> +       compatible = "gpio-gate-clock";
>> +       clocks = <&rc21012_pci>;
>> +       enable-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
>> +       /delete-property/ clock-frequency;
>> +};
>> +
>> +&pciec0 {
>> +       reset-gpio = <&gpio_exp_20 0 GPIO_ACTIVE_LOW>;
>> +       status = "okay";
>> +};
>> +
>>  &pfc {
>>         pinctrl-0 = <&scif_clk_pins>;
>>         pinctrl-names = "default";
>
>These references have a hard dependency on commit 183a709d3719e5c9
>("arm64: dts: renesas: r8a779f0: Add PCIe Host and Endpoint nodes")
>in v6.6+ (i.e. v6.7-rc1 soon).
>
>To actually work, this has a soft (runtime) dependency on commit
>0d0c551011df4519 ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller
>support for host mode") in v6.6+.

Sounds like I should just drop this patch :)

-- 
Thanks,
Sasha
