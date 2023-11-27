Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1517FA357
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjK0Oqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjK0Oqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:46:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D919A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:46:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3316c6e299eso2889764f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701096401; x=1701701201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCoJcLnWtoaRFSULW7kGoOetfOvECY+PtBhA6zgTVO4=;
        b=Wn6rajQvhzyfjhqiYppg6fub5v4S8e+dm3q7d8c+Sjz/W5COo8aEQBZDAnmqxdyxEG
         ErdTojoc9sxqOWoaRFcdn67WPUJbFpgzfV7OnMEh7CSkImIMFCZCf3UloAeiTBfVdDCu
         Yv05Xqq3M8cE6AB+WhRk+WF5HYrSMjlQbAvwhSRHwW53ZEs1z8yEzphCA3UDM9jfAzFf
         ACLk+RP4xE4EfoWTz+5ItFy6UR/GSoarZatKoFAzFxM8iNGLlc6RrdmJQ9YQ5EvjbIB/
         1gAhLg5hO7y3eKw04dcqb9ubuFjaNth5Gq4dXTqlUZyTAC8UOnd4YWYiZ36rTYcyTNxJ
         5r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701096401; x=1701701201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCoJcLnWtoaRFSULW7kGoOetfOvECY+PtBhA6zgTVO4=;
        b=VHCMtUx+qIDLedx4+v9ayftmqkgMQb34173YqirPYKgiWioq9qjnY4BKpGe3/IaMR+
         7lP+m57+pe/ah6XGEEuetXgonxAMVsYmpQ8JUe7oPza6F+eSeMLc+yfbxbRjrMFSxOET
         gou+/bfM39h7Ye6CaXDGiu6peoOeY8mRXg4/tnWY3EZKxO13p+1JVNeOUOqa+R2k85wR
         npkrTEx5WNapilvpDqzzv8dp5pBL0oRng7dH0nk4jmROFSxuwpfRUpQ1nrNmfFwbTUgO
         Hh7ospNpSzur7KxESVa1jnKeZjS2gwesd1Y4/ho+De9xfQrjSVjUlRg+oKHyX/snvCKP
         75ew==
X-Gm-Message-State: AOJu0Yxj6IIfdx8Ex+MfANiCMvMAGu24vJW3Aq6DjFdDaYKkkgwxXT+G
        Jdg++n4JD/BU/HAUTA+2XSS66A==
X-Google-Smtp-Source: AGHT+IFuvetCyg9riYOiLzuWVUUQhocNmYIjGwF2f+UGrnEvLgAMXJeY2jo196j2aQPSMCdvXBxhkA==
X-Received: by 2002:adf:a348:0:b0:32f:7a1a:6b21 with SMTP id d8-20020adfa348000000b0032f7a1a6b21mr9462534wrb.50.1701096401254;
        Mon, 27 Nov 2023 06:46:41 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id f6-20020adff586000000b00332e1c46dddsm12282523wro.98.2023.11.27.06.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:46:40 -0800 (PST)
Message-ID: <ece2601d-9311-462b-8687-c241d889ec16@tuxon.dev>
Date:   Mon, 27 Nov 2023 16:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] net: ravb: Add runtime PM support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-14-claudiu.beznea.uj@bp.renesas.com>
 <04cb07fe-cccc-774a-f14d-763ce7ae7b07@omp.ru>
 <b3456a4d-336c-434d-9fd5-4c87582443cb@tuxon.dev>
 <9af21eb9-6fe1-de3a-f2eb-4493778ebb32@omp.ru>
 <e35882ea-c325-4039-bb84-c18b0244dbe0@tuxon.dev>
 <CAMuHMdVCRXYKtcwaC=v-HhJW-PLV-zhj_3GmeU6Vu1JOK_eu0Q@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVCRXYKtcwaC=v-HhJW-PLV-zhj_3GmeU6Vu1JOK_eu0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 27.11.2023 16:05, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Sat, Nov 25, 2023 at 12:00 AM claudiu beznea
> <claudiu.beznea@tuxon.dev> wrote:
>> On 23.11.2023 21:19, Sergey Shtylyov wrote:
>>> On 11/23/23 8:04 PM, claudiu beznea wrote:
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>>> RZ/G3S supports enabling/disabling clocks for its modules (including
>>>>>> Ethernet module). For this commit adds runtime PM support which
>>>>>> relies on PM domain to enable/disable Ethernet clocks.
>>>>>
>>>>>    That's not exactly something new in RZ/G3S. The ravb driver has unconditional
>>>>> RPM calls already in the probe() and remove() methods...
>>>>> And the sh_eth driver
>>>>> has RPM support since 2009...
>>>>>
>>>>>> At the end of probe ravb_pm_runtime_put() is called which will turn
>>>>>
>>>>>    I'd suggest a shorter name, like ravb_rpm_put() but (looking at this function)
>>>>>> off the Ethernet clocks (if no other request arrives at the driver).
>>>>>> After that if the interface is brought up (though ravb_open()) then
>>>>>> the clocks remain enabled until interface is brought down (operation
>>>>>> done though ravb_close()).
>>>>>>
>>>>>> If any request arrives to the driver while the interface is down the
>>>>>> clocks are enabled to serve the request and then disabled.
>>>>>>
>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>>>>>> --- a/drivers/net/ethernet/renesas/ravb.h
>>>>>> +++ b/drivers/net/ethernet/renesas/ravb.h
>>>>>> @@ -1044,6 +1044,7 @@ struct ravb_hw_info {
>>>>>>    unsigned magic_pkt:1;           /* E-MAC supports magic packet detection */
>>>>>>    unsigned half_duplex:1;         /* E-MAC supports half duplex mode */
>>>>>>    unsigned refclk_in_pd:1;        /* Reference clock is part of a power domain. */
>>>>>> +  unsigned rpm:1;                 /* Runtime PM available. */
>>>>>
>>>>>    No, I don't think this flag makes any sense. We should support RPM
>>>>> unconditionally...
>>>
>>>    If RPM calls work in the probe()/remove() methods, they should work
>>> in the ndo_{open|stop}() methods, right?
>>
>> It might depend on hardware support... E.g.
>>
>> I debugged it further the issue I had with this implementation on other
>> SoCs and it seems we cannot do RPM for those w/o reworking way the driver
>> is configured.
>>
>> I wiped out the RPM code from this patch and just called:
>>
>> pm_runtime_put_sync();          // [1]
>> usleep_range(300000, 400000);   // [2]
>> pm_runtime_get_sync();          // [3]
>>
>> at the end of ravb_probe(); with this the interfaces fails to work. I
>> continue debugging it and interrogated CSR and this returns RESET after
>> [3]. I tried to switched it back to configuration mode after [3] but fails
>> to restore to a proper working state.
>>
>> Then continued to debug it further to see what happens on the clock driver.
>> The clk enable/disable reaches function at [4] which sets control_regs[reg]
>> which is one of the System module stop control registers. Setting this
>> activates module standby (AFICT). Switch to reset state on Ethernet IP
>> might be backed by note (2) on "Operating Mode Transitions Due to Hardware"
>> chapter of the G1H HW manual (which I don't fully understand).
> 
> You mean 37A.3.1.3 (2) "Transition during power-off by module standby"?

Yes!

> 
>     The AVB-DMAC completes the bus master access in progress,
>     and then shifts to reset mode. At this time, the operating mode
>     configuration bits in the AVB-DMAC mode register (CCC.OPC) are
>     set to B'00.
> 
> "reset mode" could be interpreted as "register contents are reset (lost)".
> However, the R-Car Gen3 documentation contains the same paragraph,
> and register contents are known not to be lost...

I remember (from the debugging session I've run few weeks ago) that I
checked on G1H an Ethernet register before point [1] and after point [3]
and the values were the same (but I may be wrong, I need to double check it).

I will double check also the value of MSTOP for Ethernet on RZ/G3S (though
I checked that this worked on my code), maybe RZ/G3S doesn't go to standby,
I have a bug in my code and that's why it works for RZ/G3S...

Also, I see that the STANDBY state is missing from CCC.OPC documentation
(chapter "37A.3.1 AVB-DMAC Operating Modes" on RZ/G1H vs "31.5.1 DMAC
Operating Modes" on RZ/G3S).

> 
> 37.7.2 for Ether ("sh-eth") states:
> 
>     After returning from the standby state, the ether should be reset
> and initialized.

Ok, I found that one in my G1H manual. It is not available on RZ/G3S
manual, though.

> 
> Sergey: does sh_eth.c really reinitialize the hardware completely after
> pm_runtime_get_sync()?
> 
>> Also, the manual of G1H states from some IPs that register state is
>> preserved in standby mode but not for AVB.
> 
> Indeed, AFAIK all modules on SH/R-Mobile, R-Car, and RZ/G SoCs keep
> their register contents when in standby-mode (module standby enabled).
> On modules in a (not always-on) power area (e.g. SH/R-Mobile), register
> contents are lost when the power area is powered down.
> So I'd be surprised if EtherAVB behaves differently.  Of course that
> is still possible, there are big difference between EtherAVB in R-Car
> Gen2 and RZ/G1, and the revision found in later SoC families.
> 
>>>> The reasons I've limited only to RZ/G3S are:
>>>> 1/ I don't have all the platforms to test it
>>>
>>>    That's a usual problem with the kernel development...
>>>
>>>> 2/ on G1H this doesn't work. I tried to debugged it but I don't have a
>>>>    platform at hand, only remotely, and is hardly to debug once the
>>>>    ethernet fails to work: probe is working(), open is executed, PHY is
>>>>    initialized and then TX/RX is not working... don't know why ATM.
>>>
>>>    That's why we have the long bug fixing period after -rc1...
>>
>> I prefer to not introduce any bug by intention.
> 
> Iff register contents are lost on RZ/G1H, I'd rather add
> an extra clk_prepare_enable(priv->clk) to ravb_probe() on
> "renesas,etheravb-rcar-gen2"....

This should work, though I would go with a pm_runtime_put_noidle().

Thank you,
Claudiu Beznea

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
