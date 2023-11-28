Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA57FB596
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjK1JXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjK1JXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:23:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB67C9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:23:18 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b4a8db314so5990335e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701163397; x=1701768197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eenye9HdwTQxcArWUErxKolkkutscBR5gpaggr02P4=;
        b=GnGkZbtiheroQobMSUxq7dUvI00AKEHIchWrvd3HEctrXtCg+trXbZRnN3I228o7lQ
         8qDfKZ6gkD2c3VSTW0p/PXS9qknyyVFmzAIOSFYPyuxtgYsh7BhQVhcfKu0BdAZPaG5o
         ehgj6tWDrt/C173tX2+PvMHhyX1+oc988kXd2h329RWxndmHzpxnj41MstDiXQgiw1zj
         i0tnspF7c4R3iny7iHx8YE5Wh08OKfwf1lH2ODFbOEhK6DZxRTYRbCY/ObIfHWFVxy1d
         1TONFb57q6prPv48+q+jh325hWSpbs3rtETVHB977/4mZqOc5tNIVL5DEYLkirj/wouY
         9zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163397; x=1701768197;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eenye9HdwTQxcArWUErxKolkkutscBR5gpaggr02P4=;
        b=CCyK97VTU+XMgK8D6EvWhjgqH+1PE5/vsqOSytNWZZksihP4mF7y9p4rDq3EMyqedO
         kULxVV8Mx+wx1rQrVH/KNwrahPSAxP/ikKX/TzQSANVRoMt2vtThMC8GKwm1wMc0mKCd
         Mulp/bBilPrKnuD8afmLfNfDCySYKZOajSt6jFsqk1BWp0koU+MG/V9X92w57im+mBEH
         CayjBOrr5wnUZ6Q5kz+uw6bfhUX07AVWjpAALcgbhbTOQwZU+dgLcQlHt5DbW1J22hkj
         HntvJdb2zoMYcafSj3o/g3W4MDm7DmFpGg25ANKRlG4omlxlpSlx7ZnBf15CVNu+nAEb
         Nj9Q==
X-Gm-Message-State: AOJu0YzVDm9bWaSr2Tauxr/gogAWCtVDydscNF3m/LXeCS+xpI1I0OPp
        /MjjByxXe2YMpreOdcleLOvwkg==
X-Google-Smtp-Source: AGHT+IGibnyWd1w48I6Ajmwf/X3NGYilAHusSAq4LrFN1+MyJ4arDz0Y2YD15SvgxvKbXqE/SQ790g==
X-Received: by 2002:a05:600c:3595:b0:409:7d0:d20b with SMTP id p21-20020a05600c359500b0040907d0d20bmr10879906wmq.24.1701163396780;
        Tue, 28 Nov 2023 01:23:16 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b004030e8ff964sm17602133wmb.34.2023.11.28.01.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:23:16 -0800 (PST)
Message-ID: <6bcc69b6-d198-4185-aaab-b9ab9aa09c87@tuxon.dev>
Date:   Tue, 28 Nov 2023 11:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] net: ravb: Add runtime PM support
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
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
 <ece2601d-9311-462b-8687-c241d889ec16@tuxon.dev>
In-Reply-To: <ece2601d-9311-462b-8687-c241d889ec16@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 27.11.2023 16:46, claudiu beznea wrote:
> Hi, Geert,
> 
> On 27.11.2023 16:05, Geert Uytterhoeven wrote:
>> Hi Claudiu,
>>
>> On Sat, Nov 25, 2023 at 12:00 AM claudiu beznea
>> <claudiu.beznea@tuxon.dev> wrote:
>>> On 23.11.2023 21:19, Sergey Shtylyov wrote:
>>>> On 11/23/23 8:04 PM, claudiu beznea wrote:
>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>>> RZ/G3S supports enabling/disabling clocks for its modules (including
>>>>>>> Ethernet module). For this commit adds runtime PM support which
>>>>>>> relies on PM domain to enable/disable Ethernet clocks.
>>>>>>
>>>>>>    That's not exactly something new in RZ/G3S. The ravb driver has unconditional
>>>>>> RPM calls already in the probe() and remove() methods...
>>>>>> And the sh_eth driver
>>>>>> has RPM support since 2009...
>>>>>>
>>>>>>> At the end of probe ravb_pm_runtime_put() is called which will turn
>>>>>>
>>>>>>    I'd suggest a shorter name, like ravb_rpm_put() but (looking at this function)
>>>>>>> off the Ethernet clocks (if no other request arrives at the driver).
>>>>>>> After that if the interface is brought up (though ravb_open()) then
>>>>>>> the clocks remain enabled until interface is brought down (operation
>>>>>>> done though ravb_close()).
>>>>>>>
>>>>>>> If any request arrives to the driver while the interface is down the
>>>>>>> clocks are enabled to serve the request and then disabled.
>>>>>>>
>>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>>>>>>> --- a/drivers/net/ethernet/renesas/ravb.h
>>>>>>> +++ b/drivers/net/ethernet/renesas/ravb.h
>>>>>>> @@ -1044,6 +1044,7 @@ struct ravb_hw_info {
>>>>>>>    unsigned magic_pkt:1;           /* E-MAC supports magic packet detection */
>>>>>>>    unsigned half_duplex:1;         /* E-MAC supports half duplex mode */
>>>>>>>    unsigned refclk_in_pd:1;        /* Reference clock is part of a power domain. */
>>>>>>> +  unsigned rpm:1;                 /* Runtime PM available. */
>>>>>>
>>>>>>    No, I don't think this flag makes any sense. We should support RPM
>>>>>> unconditionally...
>>>>
>>>>    If RPM calls work in the probe()/remove() methods, they should work
>>>> in the ndo_{open|stop}() methods, right?
>>>
>>> It might depend on hardware support... E.g.
>>>
>>> I debugged it further the issue I had with this implementation on other
>>> SoCs and it seems we cannot do RPM for those w/o reworking way the driver
>>> is configured.
>>>
>>> I wiped out the RPM code from this patch and just called:
>>>
>>> pm_runtime_put_sync();          // [1]
>>> usleep_range(300000, 400000);   // [2]
>>> pm_runtime_get_sync();          // [3]
>>>
>>> at the end of ravb_probe(); with this the interfaces fails to work. I
>>> continue debugging it and interrogated CSR and this returns RESET after
>>> [3]. I tried to switched it back to configuration mode after [3] but fails
>>> to restore to a proper working state.
>>>
>>> Then continued to debug it further to see what happens on the clock driver.
>>> The clk enable/disable reaches function at [4] which sets control_regs[reg]
>>> which is one of the System module stop control registers. Setting this
>>> activates module standby (AFICT). Switch to reset state on Ethernet IP
>>> might be backed by note (2) on "Operating Mode Transitions Due to Hardware"
>>> chapter of the G1H HW manual (which I don't fully understand).
>>
>> You mean 37A.3.1.3 (2) "Transition during power-off by module standby"?
> 
> Yes!
> 
>>
>>     The AVB-DMAC completes the bus master access in progress,
>>     and then shifts to reset mode. At this time, the operating mode
>>     configuration bits in the AVB-DMAC mode register (CCC.OPC) are
>>     set to B'00.
>>
>> "reset mode" could be interpreted as "register contents are reset (lost)".
>> However, the R-Car Gen3 documentation contains the same paragraph,
>> and register contents are known not to be lost...
> 
> I remember (from the debugging session I've run few weeks ago) that I
> checked on G1H an Ethernet register before point [1] and after point [3]
> and the values were the same (but I may be wrong, I need to double check it).

I checked again DBAT before point [1] and after point [3]. Before point [1]
DBAT=0x6c040000, after point [3] DBAT=0x00000000.

However, if all the register settings done before point [1] are re-executed
after point [3] the Ethernet connection seems usable. I tried the above
settings after point [3] to confirm this:

        ravb_set_config_mode(ndev);

        usleep_range(1000, 2000);

        pr_err("%s(): 2: mode=%08x\n", __func__, ravb_read(ndev, CSR));



        if (info->gptp || info->ccc_gac) {

                /* Set GTI value */

                error = ravb_set_gti(ndev);

                if (error)

                        goto out_disable_refclk;



                /* Request GTI loading */

                ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);

        }



        if (info->internal_delay) {

                ravb_parse_delay_mode(np, ndev);

                ravb_set_delay_mode(ndev);

        }



        ravb_write(ndev, priv->desc_bat_dma, DBAT);



        /* Initialise PTP Clock driver */

        ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);

        ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);


However, I don't have a PTP setup to check.

> 
> I will double check also the value of MSTOP for Ethernet on RZ/G3S (though
> I checked that this worked on my code), maybe RZ/G3S doesn't go to standby,
> I have a bug in my code and that's why it works for RZ/G3S...

All is good in RZ/G3S. MSTOP is set accordingly and no issues.

Thank you,
Claudiu Beznea

> 
> Also, I see that the STANDBY state is missing from CCC.OPC documentation
> (chapter "37A.3.1 AVB-DMAC Operating Modes" on RZ/G1H vs "31.5.1 DMAC
> Operating Modes" on RZ/G3S).
> 
>>
>> 37.7.2 for Ether ("sh-eth") states:
>>
>>     After returning from the standby state, the ether should be reset
>> and initialized.
> 
> Ok, I found that one in my G1H manual. It is not available on RZ/G3S
> manual, though.
> 
>>
>> Sergey: does sh_eth.c really reinitialize the hardware completely after
>> pm_runtime_get_sync()?
>>
>>> Also, the manual of G1H states from some IPs that register state is
>>> preserved in standby mode but not for AVB.
>>
>> Indeed, AFAIK all modules on SH/R-Mobile, R-Car, and RZ/G SoCs keep
>> their register contents when in standby-mode (module standby enabled).
>> On modules in a (not always-on) power area (e.g. SH/R-Mobile), register
>> contents are lost when the power area is powered down.
>> So I'd be surprised if EtherAVB behaves differently.  Of course that
>> is still possible, there are big difference between EtherAVB in R-Car
>> Gen2 and RZ/G1, and the revision found in later SoC families.
>>
>>>>> The reasons I've limited only to RZ/G3S are:
>>>>> 1/ I don't have all the platforms to test it
>>>>
>>>>    That's a usual problem with the kernel development...
>>>>
>>>>> 2/ on G1H this doesn't work. I tried to debugged it but I don't have a
>>>>>    platform at hand, only remotely, and is hardly to debug once the
>>>>>    ethernet fails to work: probe is working(), open is executed, PHY is
>>>>>    initialized and then TX/RX is not working... don't know why ATM.
>>>>
>>>>    That's why we have the long bug fixing period after -rc1...
>>>
>>> I prefer to not introduce any bug by intention.
>>
>> Iff register contents are lost on RZ/G1H, I'd rather add
>> an extra clk_prepare_enable(priv->clk) to ravb_probe() on
>> "renesas,etheravb-rcar-gen2"....
> 
> This should work, though I would go with a pm_runtime_put_noidle().
> 
> Thank you,
> Claudiu Beznea
> 
>>
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
