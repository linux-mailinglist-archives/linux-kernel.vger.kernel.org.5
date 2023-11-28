Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F07FB708
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjK1KVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjK1KU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:20:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF018F;
        Tue, 28 Nov 2023 02:21:01 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EEAD16606F5E;
        Tue, 28 Nov 2023 10:20:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701166860;
        bh=54tD+0Tstg5j+b+ww3zATak7yvK6MgBTy7TZLjR9EQg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XLQhRroj4lwvhoB01HFE3noEy6wTtCG2wzTzBgATFEhAa8glnFAa0MpdeHrMwRPFF
         lsP6riICCUjv53diP5ZWmieIMlunMG1zaBInMPuqcuTm2Se3LRwmwigjUDMrF4EQgE
         VjxfBXeg4x0fwAxT0C7k3YpOcq9OMhhFRkio/6augFXbbBWepukZrsVrLZHPm4b1WB
         oy9mJGlMoAsp2uY9mXkh0pMAh0QFx8wH9y2EI+hb/jL5TS1dTwHMZNlN49nuzYbtoq
         GyJbMXaztuL99MOZ6yQV4AlMvwtF0hcDszY7KR0t4IHrZRJp/aVapZtAtO6Ayy8Rxn
         XiHbs4I8xTUGg==
Message-ID: <36ba3f89-2bd0-45f0-8b61-59f5c6691427@collabora.com>
Date:   Tue, 28 Nov 2023 11:20:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: mediatek: extend number of tuning steps
Content-Language: en-US
To:     =?UTF-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?UTF-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20231128070127.27442-1-axe.yang@mediatek.com>
 <20231128070127.27442-3-axe.yang@mediatek.com>
 <207c2f89-b1e7-448d-966f-0c403a9f9e8b@collabora.com>
 <ea1a82b07e98fa682140c460048901a9f962be2b.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ea1a82b07e98fa682140c460048901a9f962be2b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Il 28/11/23 10:38, Axe Yang (杨磊) ha scritto:
>> On Tue, 2023-11-28 at 09:53 +0100, AngeloGioacchino Del Regno wrote:
>> Il 28/11/23 08:01, Axe Yang ha scritto:
>>> Previously, during the MSDC calibration process, a full clock cycle
>>> actually not be covered, which in some cases didn't yield the best
>>> results and could cause CRC errors. This problem is particularly
>>> evident when MSDC is used as an SDIO host. In fact, MSDC support
>>> tuning up to a maximum of 64 steps, but by default, the step number
>>> is 32. By increase the tuning step, we are more likely to cover
>>> more
>>> parts of a clock cycle, and get better calibration result.
>>>
>>> To illustrate, when tuning 32 steps, if the obtained window has a
>>> hole
>>> near the middle, like this: 0xffc07ff (hex), then the selected
>>> delay
>>> will be the 6 (counting from right to left).
>>>
>>> (32 <- 1)
>>> 1111 1111 1100 0000 0000 0111 11(1)1 1111
>>>
>>> However, if we tune 64 steps, the window obtained may look like
>>> this:
>>> 0xfffffffffffc07ff. The final selected delay will be 44, which is
>>> safer as it is further away from the hole:
>>>
>>> (64 <- 1)
>>> 1111 ... (1)111 1111 1111 1111 1111 1100 0000 0000 0111 1111 1111
>>>
>>> In this case, delay 6 selected through 32 steps tuning is obviously
>>> not optimal, and this delay is closer to the hole, using it would
>>> easily cause CRC problems.
>>>
>>> You will need to configure property "mediatek,tuning-step" in MSDC
>>> dts node to 64 to extend the steps.
>>>
>>
>> If we can run 64 tuning steps, why should we run 32?
>>
>> Why isn't it just better to *always* run 64 tuning steps, on SoCs
>> supporting that?
>>
>> Thanks,
>> Angelo
> 
> Hi Angelo,
> 
> That is a good question. The benefit of preserving 32 steps tuning is
> that it can save time in certain scenarios.
> 
> On some platforms, when the delay selected through 64 steps tuning is
> very close to that chosen through 32 steps, we can reduce the tuning
> step from 64 to 32. This can save time sending the tuning block
> commands.
> 
> Thus using 32 steps tuning can save kernel boot up time.
> 
> Another case where time can be saved is when accessing the RPMB
> partition of eMMC. Each time switch to RPMB partition, there is a
> retune action, causing a certain drop in performance. If we are certain
> that the results of 32 steps tuning are usable and we use it, this can
> in a sense also guarantee performance when accessing the RPMB
> partition.
> 

Thanks for this explanation! Though, I have some more questions...

...regarding boot up time, how much time are we talking about?

I'm asking because while now I see - and agree - on using 32-steps tuning
on eMMC to guarantee performance during RPMB access, as far as I know,
there is no RPMB partition on SD/MicroSD cards (and, of course, SDIO devices).

If the boot performance impact isn't big, as in, up to ~100 milliseconds is
not big at all (especially with async probe!), we can definitely avoid the
addition of a devicetree property for 32-steps tuning, hence use a dynamic
selection strategy such that:
  - On eMMC devices, always perform 32-steps tuning (hence no boot delay)
  - On SD cards and SDIO, always perform 64-steps tuning

Cheers,
Angelo

