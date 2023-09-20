Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DBE7A8ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjITRki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjITRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:40:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B68D8;
        Wed, 20 Sep 2023 10:40:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50305abe5f0so174956e87.2;
        Wed, 20 Sep 2023 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695231625; x=1695836425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUpQnLgPr5GH62DooFGOBZRz56X6z7oZywTK/KoWxmI=;
        b=MO6GYxtNv8u2pfnJBIJozKLyei2aBKLMqsMnEyvnDEmhGgCc5zoZfe2AQ9Nd3xbwfc
         9B3hiQMfr9hZeLTP5VWEQKN71Khv6NBNKtfTgcPDMZR/p0042GEeYu9RNOZFOXOJSVzY
         j9qmSXl+MTXooZA1K6Bh2UO3uwS6uyatHnFSANX5JT3OJFdSUPF9gbQNuypzAKlfyO29
         EJAxugDBhxVBSwjrx8Qkbt4+zOQRYOAxI4A8tbYHQqXrv16bX0eMpAhWyEx/c3b97Xpn
         uwcPQCZnupuooOobTrEU5A2L2ne555lyNey7VuGfOwpnX39kYcSXeG47mK0wokzGcCbn
         wh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695231625; x=1695836425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUpQnLgPr5GH62DooFGOBZRz56X6z7oZywTK/KoWxmI=;
        b=UAiEZsO6cIAXveLZo1VUyx+sGyK42iM5uw11obrnmzLuUr+tTi5BTbVBXS+5BpIQjG
         SEkqbamGdSNmYTqATiJaUMrXD5m3oz/Jw6hhsm0hWD2/lEne5XGz2HV06x33RK00SaLZ
         +k2eVdKHNkrXLPAywT6q24pzF6aqeIXnvcur/bc0lLtIrnpF5S2Nuaoah+URWMbAnfJ6
         lMZpS6eJCQR9NjV0aVuX579yciTtkfX2lnX3VlelcwLAF2YxyC+jyGloooij62OVi/vv
         gYBUNjaytFL5sGjV+Pb89zmteUToFggrIYU98QpYkfhblFKuVLEy5SDXJT5h624/d33Q
         t0jA==
X-Gm-Message-State: AOJu0YxO3LL2aa3eofsTUqYiSTeAHfvC595WlOv4EB1WIL/lMzPYA1NO
        pwO/KZGYnELiVFVBdYQPfH8=
X-Google-Smtp-Source: AGHT+IEa8KTWQ8QDVhxaJs6xczzJcPRSO9uUoS6BnlsRQNU8RKkW/edDXZs9p8u/5N0Pei2f9+q+Tw==
X-Received: by 2002:ac2:58e3:0:b0:4fb:8bab:48b6 with SMTP id v3-20020ac258e3000000b004fb8bab48b6mr2490419lfo.52.1695231624440;
        Wed, 20 Sep 2023 10:40:24 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id f3-20020ac251a3000000b004fdbb36a677sm2792122lfk.288.2023.09.20.10.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:40:24 -0700 (PDT)
Message-ID: <dac768d2-2c66-4d6b-b3d3-d1ef69103c76@gmail.com>
Date:   Wed, 20 Sep 2023 20:40:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting
 fck_src
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-2-andreas@kemnade.info>
 <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
 <20230920063353.GQ5285@atomide.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230920063353.GQ5285@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 09:33, Tony Lindgren wrote:
> Hi,
> 
> * Péter Ujfalusi <peter.ujfalusi@gmail.com> [230919 18:25]:
>>
>>
>> On 7/5/23 22:03, Andreas Kemnade wrote:
>>> Commit 349355ce3a05 ("ARM: OMAP2+: Drop legacy platform data for omap4 mcbsp")
>>> dropped prcm_fck for omap4,
> 
> The prcm_fck should be there in the dts for each mcbsp interconnect targe
> module as "fck" alias and get's enabled/disabled when the mcbsp driver
> calls runtime PM.
> 
> So maybe the description should explain that things broke as the aliases
> for prcm_fck and pad_ck no longer get added.
> 
>> it also dropped the pad_fck for that matter.
> 
> OK so an alias is needed for that too.

Something like that, yes.

> That's the MCPDM_CLKCTRL pad_clks_ck alias, right? Seems like the
> pad_clks_ck should be claimed by the mcpdm and mcbsp drivers if they are
> used? I guess it would be for some external device use case?
> 
>>> so the clk_src might not be >available making the
>>> clk_get(src) fail.
>>
>> Wow, so OMAP4 audio is pretty broken if would ever need to select FCLK?
>> By default we don't on OMAP4, but this is astonishing.
> 
> So sounds like we just got lucky because of -ENOSUCHUSERS? The mcbsp works
> for me, not sure how come I'm not seeing this issue, does it now only work
> for the default clock source?

It will be only a problem if McBSP is the clock provider and we need to
change to external reference clock for the BCLK/FSYNC generation. In
most board designs the codec provides the clocks - they tend to be more
flexible when it comes to clock source.

> Do we have some other examples for devices using other type of clocking?
> 
>>> In such cases, rely on the devicetree to assign
>>> the correct parent.
>>
>> You cannot rely on DT to dynamically select the FCLK parent for
>> different use cases.
>> The dai_set_dai_sysclk() cannot select between internal or external
>> source of the reference clock and DT cannot handle this.
>> If one sampling frequency is available with pad_fck while other is only
>> possible with internal clock then this is no longer possible.
> 
> If the functional clock source needs to be changed, seems things
> should work. The parent interconnect target module driver does not care
> about the fck rate. Not sure if the clock usage count causes issues
> though with reparenting, if so, sounds like reparenting needs to be
> done in runtime PM suspended state to do the switch.
> 
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>>  sound/soc/ti/omap-mcbsp.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
>>> index 21fa7b9787997..f9fe96b61852b 100644
>>> --- a/sound/soc/ti/omap-mcbsp.c
>>> +++ b/sound/soc/ti/omap-mcbsp.c
>>> @@ -70,8 +70,8 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
>>>  
>>>  	fck_src = clk_get(mcbsp->dev, src);
>>>  	if (IS_ERR(fck_src)) {
>>> -		dev_err(mcbsp->dev, "CLKS: could not clk_get() %s\n", src);
>>> -		return -EINVAL;
>>> +		dev_info(mcbsp->dev, "CLKS: could not clk_get() %s\n", src);
>>> +		return 0;
>>
>> I would rather have some clock alias for OMAP4/5 to provide the clocks
>> that we need for the fclk.
>> If we did not got the clock we needed to select we cannot say that all
>> is good, carry on.
>> Normally the machine driver does this and it thinks that we switched
>> clocks while we did not and the clocking is all wrong now.
> 
> How about someting like below to deal with getting the fck in a bit more
> future proof way:
> 
> fck_src = clk_get(mcbsp->dev, src);
> if (IS_ERR(fck_src)) {
> 	fck_src = clk_get(mcbsp->dev->parent, "fck):
> 	...
> }

It is not the parent's fck, it is the PRCM clock which is selected as
the sourcee of the clock generator (CLKS) for BCLK/FSYNC. That is the
functional clock as well for the McBSP instance.

> Also sounds like we should also add the missing the aliases too like Peter
> pointed out if mcbsp driver needs to reparent. But just adding the alias
> will possibly cause trouble for anybody adding mcbsp support for some other
> SoC variant.
> 
> To me it seems in the long run the mcbsp configurations using pad_fck
> should configure it in the dts for the interconnect target module node
> instead as the default clock. Then mcbsp can still look up the fck
> of the parent device, and change it dynamically as needed.

Out of reset it is using the PRCM source which is fine in all current users.
I would do this fix or workaround in a different way: instead of
ignoring the error, avoid it in the first place. Do nothing if the
already selected clock is requested.
That would remove the error and will fail in case the reparenting is not
working -> boards will know this and might be able to do something about
it in a reasonable way.

How that sounds?

> Regards,
> 
> Tony
> 

-- 
Péter
