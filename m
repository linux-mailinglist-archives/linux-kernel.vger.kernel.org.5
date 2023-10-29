Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437657DAE79
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjJ2VQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2VQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:16:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B006D97;
        Sun, 29 Oct 2023 14:16:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso6140038a12.1;
        Sun, 29 Oct 2023 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698614176; x=1699218976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QvsKzG+rs1HOWlhjYy4OEuq3sm4Ra3HE4ezTkFwDqiM=;
        b=UhNfIPk+DRSz+HZMRj9wTUobBajfXCb9fxSkPVF7NNMGMaqyHGvqpzdRJ3It1vxF5Q
         J0G2nmYNstIytW88HHCvsiHg15POckPeedejFb3C2TqK0Si+wzmzYMnFN911hfnAW07x
         rFyLBWupdGsp6bZ6mmRQBO6b4cuv/tpsazW17oPC5IoLDq7vfLKcj2UxiKJvIGww5EqM
         r3/fp+cBWQD5Pu2txrtOW+tgGhshjVM/S9gWtcHhah8ABN1s0JrTxZWLQNSw+tBOT1dr
         npZ7o1CDYJRyOppbWoHWvSVv8QvWYSn3QVKJaDcv9J2yOfYvJSiaBYravFp/ybwT37o5
         6nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698614176; x=1699218976;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvsKzG+rs1HOWlhjYy4OEuq3sm4Ra3HE4ezTkFwDqiM=;
        b=VkGtGLFRiGM16vuBiPJHcXSxvDesEFpq3HQYrrlH+9crBgu9pBockpyDtDDiaIrzJN
         TGGfDDy1TuQ7hzSyWz/wU2z1yXDFBYf/B9uoZfIj3mGZ3Q8c7jVBZws3GU+VK0lYZiD3
         JlrKfXHU6FBFeZnZVozTyMIS2y61cd9hnfnSl7UmCXczspvBtYs3vHAe+HvX11VKibT3
         LQty4R0kRtt7D9+r+EthvMfw/OTeESGQS+eGHPVGnbISFI2JlwdtxPY6VXpg6lkWgCwO
         /K+ubk7WBG5EdvpE6v2TUZtkg7AVkUQPfFirstvOrMzDqk5r1ngKd3QadDiC23RoOxeO
         lpiQ==
X-Gm-Message-State: AOJu0Yyv/wTK8rlFfl1egKLEiN1pB/2JuYBTt986NXQ2W6Xe3Locc8L4
        Uvs7RiakrUU9EcjlZYBpfGU=
X-Google-Smtp-Source: AGHT+IF7sE5EoaLdZ8ZzvjrwxAns0T3bzFyPglhgZ/pN3bXockxACawGbRmYwmhYVlGo9hG2IWqNCw==
X-Received: by 2002:a17:906:c10e:b0:9c2:a072:78c8 with SMTP id do14-20020a170906c10e00b009c2a07278c8mr6691256ejc.26.1698614175965;
        Sun, 29 Oct 2023 14:16:15 -0700 (PDT)
Received: from [192.168.50.244] (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id rn20-20020a170906d93400b009930308425csm4890885ejb.31.2023.10.29.14.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 14:16:15 -0700 (PDT)
Message-ID: <5bd796c5-3e9a-4aa5-b284-27fb4fc8ea48@gmail.com>
Date:   Sun, 29 Oct 2023 22:16:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: clock: brcm,kona-ccu: convert to YAML
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZTf0oWfOqnyMEKbF@standask-GA-A55M-S2HP>
 <20231027-bulldog-component-5b84e4660465@spud>
 <ZTzw5c5/MwU3VOBo@standask-GA-A55M-S2HP>
Content-Language: en-US
In-Reply-To: <ZTzw5c5/MwU3VOBo@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/10/2023 13:30, Stanislav Jakubek wrote:
> On Fri, Oct 27, 2023 at 03:47:48PM +0100, Conor Dooley wrote:
>> On Tue, Oct 24, 2023 at 06:45:21PM +0200, Stanislav Jakubek wrote:
>>> Convert Broadcom Kona family clock controller unit (CCU) bindings
>>> to DT schema.
>>
>> I didn't cross-check the clock-output-names, but this conversion mostly
>> looks good to me.
>>
>>> Changes during conversion:
>>>    - remove "dmac" from clock-output-names for brcm,bcm11351-master-ccu,
>>>      it is not used in DT nor the dt-bindings
>>>    - remove "uartb4" from clock-output-names for brcm,bcm21664-slave-ccu,
>>>      it is not used in DT nor the dt-bindings
>>
>> This I'm not sure about - they _were_ documented in the text-form
>> dt-binding, even if they weren't used in the dts. If the clock
>> controller does actually produce these clocks, removing them doesn't
>> make sense to me.
> 
> Hi Conor. Looking at downstream, I was not able to find these clocks, though
> I admit that I'm not familiar enough with the downstream mess to be 100%
> confident.
> 
>  From what I can tell, the BCM21664 arch/arm/mach-hawaii/clock.c (e.g. [1])
> doesn't contain any mention of uartb4, only uartb, uartb2 and uartb3.
> And similarly, for the BCM281XX arch/arm/mach-capri/clock_capri.c (e.g. [2])
> I wasn't able to find any mention of dmac, only dmac_mux_apb and dma_axi
> (though these two don't seem to be supported on mainline yet).

I've done some digging in the downstream kernel; for the BCM21664, I'm
almost certain that the uartb4 clock doesn't exist. Broadcom helpfully
left in "RDB" files containing the entire register layout of all of the
components; and even in the RDB for the slave clock manager[1] (used by
the other uart clocks), there is no uartb4, nor is it mentioned
anywhere else in the kernel (judging by a quick grep in the kernel
sources).

As for the BCM281XX clocks, there indeed doesn't seem to be an exact
"dmac" clock but there is a "dmac" clock gate register[2], which is
used for the dma_axi clock, so perhaps that's what this is referring
to? Also not 100% certain.

Best regards,
Artur

[1] https://github.com/Samsung-KYLEPROXX/android_kernel_samsung_kyleproxx/blob/cm-14.1/arch/arm/mach-hawaii/include/mach/rdb/brcm_rdb_kps_rst_mgr_reg.h
[2] https://github.com/surblazer/android_kernel_samsung_galaxys2plus-common/blob/android-7.1/arch/arm/mach-capri/include/mach/rdb/brcm_rdb_kpm_clk_mgr_reg.h#L417-L433
