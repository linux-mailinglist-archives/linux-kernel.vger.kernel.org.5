Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD57F7B45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjKXSDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXSDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:03:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F82D19AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:03:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54b0c7987easo516683a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700849007; x=1701453807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MndQpVDkv6hGG4LUMDweRAv86F12JwKJYkhf1nWt7WU=;
        b=nIA/AicyWtzc+b/PGuNEjKX0YX8e8OglS99DRndgvVS4tvduyR2mVLfypKp1i/lZ6O
         XkqaAQBr5SxM66D6DcoTMQhxgeD39Aeib3CtorGi0VFNQqhFGgdCbcrlX7ML646TS6PO
         BGuvBD0575Gr5406zrcs6aKHZiAbu5lRn+YfXEbGe9Cmz4L2Sl+E9oUEbMtV2/p50LwR
         bFtbMtuwXaUMC4BT0imUUP8AUbB3liZFFxOwfp1Id7YMpJ+WheVJ8FpxoHi1LDzokJOp
         O70okzoB2KCsRxvzY/KR+23G5dT4MCod27ta1YYRPPYI1RVzyN54assKYcvujl0KWwsR
         gsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700849007; x=1701453807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MndQpVDkv6hGG4LUMDweRAv86F12JwKJYkhf1nWt7WU=;
        b=XJe40yAAidAHGzhjvB7epivROvLD8tAoe1wn9LKFLbaphWSmoRN5z5LTHrueIE0hhu
         X3bsyPpbfY9AJwb5JcziI7M5toHkufRi1j9MP4j/WYeJnBhz9t4agB+Gl+bH8wPLB0Rs
         eu9l5jz1orFpt4oXeioBMoFaxUfl6CAfdbjXLey0oLtr6TfAPd6RCpvexNslIqKKbzEj
         zCKTuRIh9UlF/18vuK+qcH+i6vsEPRVWjdRLPEOCwVP6TR+hHFWMOCEeYOlrZY7ojbT9
         tqhMDD4QtXNwLiGag2ynvS7mUHMX8u9V0k+VNSNbXHs+1vJSMNoUSP3E1QwbyXHsQVKW
         w1IQ==
X-Gm-Message-State: AOJu0YxG55DoUq1SpuvOGz4ti29o4Gtkj+Kb34UmKHlXAggSSijsn2Q0
        ZZnOXsOSRt6bWJS/MdGQvOsR9g==
X-Google-Smtp-Source: AGHT+IEm6PNoAISQt/a+CGBHVOqOhz1dJROIbgE/wYFt4624zqFyrSEXjKTBWLcT2L29vYX4yt557g==
X-Received: by 2002:a17:907:1de1:b0:a00:3512:2e23 with SMTP id og33-20020a1709071de100b00a0035122e23mr2420774ejc.75.1700849005634;
        Fri, 24 Nov 2023 10:03:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906591800b009fdc684a79esm2341649ejq.124.2023.11.24.10.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 10:03:25 -0800 (PST)
Message-ID: <e35882ea-c325-4039-bb84-c18b0244dbe0@tuxon.dev>
Date:   Fri, 24 Nov 2023 20:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] net: ravb: Add runtime PM support
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-14-claudiu.beznea.uj@bp.renesas.com>
 <04cb07fe-cccc-774a-f14d-763ce7ae7b07@omp.ru>
 <b3456a4d-336c-434d-9fd5-4c87582443cb@tuxon.dev>
 <9af21eb9-6fe1-de3a-f2eb-4493778ebb32@omp.ru>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <9af21eb9-6fe1-de3a-f2eb-4493778ebb32@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 21:19, Sergey Shtylyov wrote:
> On 11/23/23 8:04 PM, claudiu beznea wrote:
> 
> [...]
> 
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>>> RZ/G3S supports enabling/disabling clocks for its modules (including
>>>> Ethernet module). For this commit adds runtime PM support which
>>>> relies on PM domain to enable/disable Ethernet clocks.
>>>
>>>    That's not exactly something new in RZ/G3S. The ravb driver has unconditional
>>> RPM calls already in the probe() and remove() methods... 
>>> And the sh_eth driver
>>> has RPM support since 2009...
>>>
>>>> At the end of probe ravb_pm_runtime_put() is called which will turn
>>>
>>>    I'd suggest a shorter name, like ravb_rpm_put() but (looking at this function)
>>> it doesn't seem hardly needed...
> 
>    Does seem, sorry. :-)
> 
>>>> off the Ethernet clocks (if no other request arrives at the driver).
>>>> After that if the interface is brought up (though ravb_open()) then
>>>> the clocks remain enabled until interface is brought down (operation
>>>> done though ravb_close()).
>>>>
>>>> If any request arrives to the driver while the interface is down the
>>>> clocks are enabled to serve the request and then disabled.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>  drivers/net/ethernet/renesas/ravb.h      |  1 +
>>>>  drivers/net/ethernet/renesas/ravb_main.c | 99 ++++++++++++++++++++++--
>>>>  2 files changed, 93 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
>>>> index c2d8d890031f..50f358472aab 100644
>>>> --- a/drivers/net/ethernet/renesas/ravb.h
>>>> +++ b/drivers/net/ethernet/renesas/ravb.h
>>>> @@ -1044,6 +1044,7 @@ struct ravb_hw_info {
>>>>  	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
>>>>  	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
>>>>  	unsigned refclk_in_pd:1;	/* Reference clock is part of a power domain. */
>>>> +	unsigned rpm:1;			/* Runtime PM available. */
>>>
>>>    No, I don't think this flag makes any sense. We should support RPM
>>> unconditionally...
> 
>    If RPM calls work in the probe()/remove() methods, they should work
> in the ndo_{open|stop}() methods, right?

It might depend on hardware support... E.g.

I debugged it further the issue I had with this implementation on other
SoCs and it seems we cannot do RPM for those w/o reworking way the driver
is configured.

I wiped out the RPM code from this patch and just called:

pm_runtime_put_sync();		// [1]
usleep_range(300000, 400000);	// [2]
pm_runtime_get_sync();		// [3]

at the end of ravb_probe(); with this the interfaces fails to work. I
continue debugging it and interrogated CSR and this returns RESET after
[3]. I tried to switched it back to configuration mode after [3] but fails
to restore to a proper working state.

Then continued to debug it further to see what happens on the clock driver.
The clk enable/disable reaches function at [4] which sets control_regs[reg]
which is one of the System module stop control registers. Setting this
activates module standby (AFICT). Switch to reset state on Ethernet IP
might be backed by note (2) on "Operating Mode Transitions Due to Hardware"
chapter of the G1H HW manual (which I don't fully understand).

Also, the manual of G1H states from some IPs that register state is
preserved in standby mode but not for AVB.

[4]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/renesas/renesas-cpg-mssr.c#n190


> 
>> The reasons I've limited only to RZ/G3S are:
>> 1/ I don't have all the platforms to test it
> 
>    That's a usual problem with the kernel development...
> 
>> 2/ on G1H this doesn't work. I tried to debugged it but I don't have a
>>    platform at hand, only remotely, and is hardly to debug once the
>>    ethernet fails to work: probe is working(), open is executed, PHY is
>>    initialized and then TX/RX is not working... don't know why ATM.
> 
>    That's why we have the long bug fixing period after -rc1...

I prefer to not introduce any bug by intention.

> 
> [...]
>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>> index f4634ac0c972..d70ed7e5f7f6 100644
>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>>> @@ -145,12 +145,41 @@ static void ravb_read_mac_address(struct device_node *np,
> [...]
>>>> +}
>>>> +
>>>>  static void ravb_mdio_ctrl(struct mdiobb_ctrl *ctrl, u32 mask, int set)
>>>>  {
>>>>  	struct ravb_private *priv = container_of(ctrl, struct ravb_private,
>>>>  						 mdiobb);
>>>> +	int ret;
>>>> +
>>>> +	ret = ravb_pm_runtime_get(priv);
>>>> +	if (ret < 0)
>>>> +		return;
>>>>  
>>>>  	ravb_modify(priv->ndev, PIR, mask, set ? mask : 0);
>>>> +
>>>> +	ravb_pm_runtime_put(priv);
>>>
>>>    Hmm, does this even work? :-/ Do the MDIO bits retain the values while
>>> the AVB core is not clocked or even powered down?
>>
>> This actually is not needed. It's a leftover. I double checked with
>> mii-tools to access the device while the interface is down and the IOCTL is
>> blocked in this case by
>> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/renesas/ravb_main.c#L2266
> 
>    Have you tested with ethtool as well?
> 
>>>    Note that the sh_eth driver has RPM calls in the {read|write}_c{22?45}()
> 
>    s/?/|/,
> 
>>> methods which do the full register read/write while the core is powere up
> 
>    Powered.
> 
>>> and clocked...
>>>
>>> [...]
>>>> @@ -2064,6 +2107,11 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
>>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>>  	const struct ravb_hw_info *info = priv->info;
>>>>  	struct net_device_stats *nstats, *stats0, *stats1;
>>>> +	int ret;
>>>> +
>>>> +	ret = ravb_pm_runtime_get(priv);
>>>> +	if (ret < 0)
>>>> +		return NULL;
>>>
>>>    Hm, sh_eth.c doesn't have any RPM calls in this method. Again, do
>>
>> In setups where systemd is enabled, user space calls this method in
>> different stages (e.g. at boot time or when running ifconfig ethX, even if
>> interface is down). W/o runtime resuming here the system will fail to boot.
>>
>> The other approach I wanted to take was to:
>>
>> if (!netif_running(dev))
>> 	return &ndev->stats;
>>
>> But I didn't choose this path as there are some counters updated to nstat
>> only in this function, e.g. nstats->tx_dropped += ravb_read(ndev, TROCR);
>> and wanted an opinion about it.
> 
>    Have you seen the following commit (that I've already posted for you on
> IRC)?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fa2955ff70ce4532f144d26b8a087095f9c9ffc
> 
>    Looks like the RPM calls won't do here...
> 
>>> the hardware counters remain valid across powering the MAC core down?
>>
>> The power domain that the Ethernet clocks of RZ/G3S belong disables the
>> clock and switches the Ethernet module to standby. There is no information
>> in HW manual that the content of registers will be lost.
> 
>    That's what your current PD driver does... isn't it possible that
> in some new SoCs the PD would be completely powered off?
> 
> [...]
>>>> @@ -2115,11 +2165,18 @@ static void ravb_set_rx_mode(struct net_device *ndev)
>>>>  {
>>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>>  	unsigned long flags;
>>>> +	int ret;
>>>> +
>>>> +	ret = ravb_pm_runtime_get(priv);
>>>> +	if (ret < 0)
>>>> +		return;
>>>
>>>    Hm, sh_eth.c doesn't have any RPM calls in this method either.
>>> Does changing the promiscous mode have sense for an offlined interface?
>>
>> I've added it for scenarios when the interface is down and user tries to
>> configure it. I don't know to answer your question. W/o RPM resume here
>> user space blocks if tries to access it and interface is down. I can just
>> return if interface is down. Let me know if you prefer this way.
> 
>    Looking at __dev_set_rx_mode(), the method gets only called when
> (dev->flags & IFF_UP) is true -- but that contradicts your experience,
> it seems... However, looking at net/core/dev_addr_lists.c, that function
> is called from the atomic contexts, so please just return early.
> 
>>> [...]
>>>> @@ -2187,6 +2244,11 @@ static int ravb_close(struct net_device *ndev)
>>>>  	if (info->nc_queues)
>>>>  		ravb_ring_free(ndev, RAVB_NC);
>>>>  
>>>> +	/* Note that if RPM is enabled on plaforms with ccc_gac=1 this needs to be
>>>
>>>    It's "platforms". :-)
>>>
>>>> skipped and
>>>
>>>    Overly long line?
>>
>> Not more than 100 chars. Do you want it to 80?
> 
>    Yes, it's not the code, no need to go beyond 80 cols, I think...
> 
> [...]
> 
> MBR, Sergey
