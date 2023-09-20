Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3E7A8A87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjITRY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjITRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:24:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07B9F7;
        Wed, 20 Sep 2023 10:24:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50336768615so200559e87.0;
        Wed, 20 Sep 2023 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695230647; x=1695835447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfiikMIrYn39kPmf1XpzwzyflnoDFSxd0c5KM6+tLH4=;
        b=W4Mq0WbOB9vEqBJPMnnHQYpL+G399iQMigLVgovqCSrecdsyJLWiDyPDjsfPH4MiXs
         gD37S5yMTUsoIBcDoOeGSRCZo751aTaxCfZYM8/jaYqh9K4N1ZyLdLbQ/LZzDXvtHLHs
         jq9yWVUctT4XZSUHX61bs6Bi0dJmNNKqpMxEQfAI/69/AQB+E8+llzwOwex2AS2/uvKh
         9BkDghiT8nyYWgtyrAm3hb/hjonfDW2aoly4QIqyqro9lpJ7Tf4bOC1iLS52hQuP4NyK
         gMpWM10XS0waqwUv/oPt0twoZEgXHksYAmFhZ57EFsTBp/CS74HxtDkQ19uTywlIMrPM
         XNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230647; x=1695835447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfiikMIrYn39kPmf1XpzwzyflnoDFSxd0c5KM6+tLH4=;
        b=adP/3iPNLF++tJVBRsAZIbUhSVVuJSJL04vjz9IitK3+yrt8XtHWVFc3O6KLjkVzUB
         PkhbxSOvii65FOWXnq53xxYmI4JgMvWz9q7SCM8m0e/Tf3b5rbayCAqOupg2hiJJ7AUW
         u7IeHgHFXAJMMYW8DslWH4GyuyKVhwqxnvkKAMFmPx/kJijyDpa2UkhDJ/RQtfuBu3BT
         GQPqnMfHK9jbwFiA92OsMBPO0KvkdOwWLjTWGW6P1NXICgx53sb2zuqkHwM05QePWQcT
         utrME2EJ5v48k9lWVryXhzb0QIpfvMKgECZXLPUl1gOa1OAIDwIVCITFI9/l4ZyCMx3B
         fpHw==
X-Gm-Message-State: AOJu0YweQhA/8pSN4nqawP8ZjkJuWKza1CWItuOy2FHNvOosEx0ej5P3
        GUmwLcL/KnLjZ5WrJUTpprc=
X-Google-Smtp-Source: AGHT+IECCauuhP3vTBGBf/lQVx6tED+vbCi8sf5TYDpauGNNEOX3HDVGDsKjG3Bi3kURlLtbgevGPA==
X-Received: by 2002:a05:651c:235:b0:2b9:b27c:f727 with SMTP id z21-20020a05651c023500b002b9b27cf727mr2797044ljn.8.1695230646850;
        Wed, 20 Sep 2023 10:24:06 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id v8-20020a2ea448000000b002c128e45245sm107170ljn.23.2023.09.20.10.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:24:06 -0700 (PDT)
Message-ID: <68b74422-d53e-4147-bbb5-ffc04443f969@gmail.com>
Date:   Wed, 20 Sep 2023 20:24:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting
 fck_src
To:     Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-2-andreas@kemnade.info>
 <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
 <20230920063353.GQ5285@atomide.com> <20230920165204.0fbc0ff3@aktux>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230920165204.0fbc0ff3@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/20/23 17:52, Andreas Kemnade wrote:
> Hi,
> 
> On Wed, 20 Sep 2023 09:33:53 +0300
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> Hi,
>>
>> * Péter Ujfalusi <peter.ujfalusi@gmail.com> [230919 18:25]:
>>>
>>>
>>> On 7/5/23 22:03, Andreas Kemnade wrote:  
>>>> Commit 349355ce3a05 ("ARM: OMAP2+: Drop legacy platform data for omap4 mcbsp")
>>>> dropped prcm_fck for omap4,  
>>
>> The prcm_fck should be there in the dts for each mcbsp interconnect targe
>> module as "fck" alias and get's enabled/disabled when the mcbsp driver
>> calls runtime PM.
>>
>> So maybe the description should explain that things broke as the aliases
>> for prcm_fck and pad_ck no longer get added.
>>
>>> it also dropped the pad_fck for that matter.  
>>
>> OK so an alias is needed for that too.
>>
>> That's the MCPDM_CLKCTRL pad_clks_ck alias, right? Seems like the
>> pad_clks_ck should be claimed by the mcpdm and mcbsp drivers if they are
>> used? I guess it would be for some external device use case?
>>
>>>> so the clk_src might not be >available making the
>>>> clk_get(src) fail.  
>>>
>>> Wow, so OMAP4 audio is pretty broken if would ever need to select FCLK?
>>> By default we don't on OMAP4, but this is astonishing.  
>>
>> So sounds like we just got lucky because of -ENOSUCHUSERS? The mcbsp works
>> for me, not sure how come I'm not seeing this issue, does it now only work
>> for the default clock source?
>>
> Well, I did not run into any problems (besides of no sound output)
> as long as I tried to use the codec side as bitclock/frameclock-master and
> that is what droid4 does...

Looks like only omap3 pandora is using external clock source for McBSP,
most OMAP4/5 devices tend to use McPDM and in most cases the McBSP is
not the clock provider, so the clocking does not matter.

It is going to cause issues on new boards, but those are unlikely to
surface.

-- 
Péter
