Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E216B790795
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352037AbjIBL2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352004AbjIBL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:28:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3435F10F4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:28:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so50007561fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693654102; x=1694258902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VsfrFUgcxNOYobHwJHkKquAqgaoJylbXl5Nl82d+Atc=;
        b=KucV5F4HrfPtaiGiGFNIdOfHWZ0KxpLhTKzBxkExzc9J976mmzdOgVjDeHyjag6oMz
         b90h8r7g6RU2btaoCaBTTnawJpzq1UX/gApZNzUD7huJE2HDADJWS8GhECpZNX4blTwO
         85iRsJsTpvP7NEoQwkX6Kn+vF2b0tl11QspizWMkhKmoX0rrrIcRkv9W7fp97UfUQZnl
         UeQdltI949ll0383zyk41owofBZr3/49ZmKQ5RaV/S1zL71hWPoMt+vvW5t+5TJKZ7Xr
         MCQ255Un2kkYtB9wjPXiD3tVIX7BAwpYHFwUodkKNWsKSUYER/CQmnQAhqkyJ07WWT6D
         8CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693654102; x=1694258902;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsfrFUgcxNOYobHwJHkKquAqgaoJylbXl5Nl82d+Atc=;
        b=bRLlLTw5+lRD0tdFWn/OWrNuiR7ZPUMR3sf7Kx0SWLCoeXOaOmkkvzNt+LWl+3J+ON
         BZzQ8UaClQNR3TJtLS9oxfAxJeBY1D+X4YuWCiCI+GnXFk4cINA8e0wWrQieswP0TySG
         1pdDo4rcj4TYp7MZiQPb7gMwzZoda16lIY8GUSv4LTzy0FpFm5jljb2IjjzAyJ8PS6Mi
         MZFsaj2nhYzrtBvcde/+Y5HIHbWrQPQu+Qmk1pZQv39WEMN/MwG+KpmB6wfEV6DTwerH
         GNFeMWOkfaQ4dLSICWX3KDhRU12TuWbhvKII1URThgMPOBpIZnb2EVdR3T6dpoVRarTN
         UkaA==
X-Gm-Message-State: AOJu0Yy02B6UWoieSAqpi6JE+4la+il3G3lJ+dS1AGA0ZMY5fdG/pqO+
        fuicIbnV89OVlPsY13L0o+VNFw==
X-Google-Smtp-Source: AGHT+IGalkW48+qbpM2/vyVsGVSrEqPpmdwi+QuqK0KCQ5T6RGsTAlv/HYItmH9/2ed7UyUPUU+CJw==
X-Received: by 2002:a2e:8718:0:b0:2bc:eafa:cfaa with SMTP id m24-20020a2e8718000000b002bceafacfaamr3173011lji.53.1693654101759;
        Sat, 02 Sep 2023 04:28:21 -0700 (PDT)
Received: from [192.168.1.101] (abxi170.neoplus.adsl.tpnet.pl. [83.9.2.170])
        by smtp.gmail.com with ESMTPSA id p5-20020a2e9ac5000000b002b836d8c839sm1162345ljj.40.2023.09.02.04.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 04:28:21 -0700 (PDT)
Message-ID: <c11abae5-f8d8-468d-a651-ecbbbec9e9e6@linaro.org>
Date:   Sat, 2 Sep 2023 13:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] nvmem: qfprom: Mark core clk as optional
To:     Doug Anderson <dianders@chromium.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
 <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
 <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
 <CAD=FV=XhdORH=naTtoc+kCC4A7UdAJKwq=Te6B3qvXNGBwBieg@mail.gmail.com>
 <CV7O0TYYEFA8.1Q42JITFSW77Q@otso>
 <CAD=FV=UG-dFg7wZsn6n=pkejie0fr+G0q3CguNspGYxoC2ZBLw@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAD=FV=UG-dFg7wZsn6n=pkejie0fr+G0q3CguNspGYxoC2ZBLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.09.2023 17:08, Doug Anderson wrote:
> Hi,
> 
> On Fri, Sep 1, 2023 at 7:54 AM Luca Weiss <luca.weiss@fairphone.com> wrote:
>>
>>>>> So maybe the right fix here is to just change your dts to specify one
>>>>> memory region?
>>>>
>>>> I got feedback from Konrad that this here would be the preferred
>>>> approach compared to having a different dts for ChromeOS vs non-ChromeOS
>>>> devices. I don't feel strongly to either, for me it's also okay to
>>>> remove the extra memory regions and only have the main one used on
>>>> regular qcom devices.
>>>>
>>>> Let me know what you think.
>>>
>>> I don't hate the idea of leaving the extra memory regions in the dts.
>>> They do describe the hardware, after all, even if the main OS can't
>>> actually access those memory regions. ...though the same could also be
>>> said about the clock you've removed. Said another way: if you want to
>>> fully describe the hardware then the dts should have the extra memory
>>> regions and the clock. If you are OK w/ just describing the hardware
>>> in the way that the OS has access to then the dts should not have the
>>> extra memory regions and not have the clock. Does that sound right?
>>
>> Not sure which of those memory regions are actually accessible on this
>> board, but honestly I don't even want to try accessing it. Blowing fuses
>> is not my wish there ;)
>>
>> On downstream the node is just described like the following:
>>
>>         qfprom: qfprom@780000 {
>>                 compatible = "qcom,qfprom";
>>                 reg = <0x780000 0x7000>;
>>                 ...
>>         };
>>
>> So we have 0x780000 - 0x786fff here.
>>
>> In sc7280.dtsi we have the following:
>>
>>         qfprom: efuse@784000 {
>>                 compatible = "qcom,sc7280-qfprom", "qcom,qfprom";
>>                 reg = <0 0x00784000 0 0xa20>,
>>                           <0 0x00780000 0 0xa20>,
>>                           <0 0x00782000 0 0x120>,
>>                           <0 0x00786000 0 0x1fff>;
>>                 ...
>>         };
>>
>> So I guess this:
>> * 0x780000 - 0x780a1f
>> * 0x782000 - 0x78211f
>> * 0x784000 - 0x784a1f
>> * 0x786000 - 0x787ffe
>>
>> So at least the last memory region seems to be partially out of range
>> according to downstream.
> 
> From the other discussion, it sounds as if you _can_ leave the clock
> in the device tree and then use "clk_get_optional" here. IMO then, the
> right answer is to use "clk_get_optional" but then also modify the
> check below so that instead of:
> 
> /* Only enable writing if we have SoC data. */
> if (priv->soc_data)
>   econfig.reg_write = qfprom_reg_write;
> 
> It is:
> 
> /* Only enable writing if we have SoC data and a valid clock */
> if (priv->soc_data && priv->secclk)
>   econfig.reg_write = qfprom_reg_write;
> 
> 
> Does that work for you?
> 
> 
>> So after reading all of this I tried running this commmand on the phone
>> and the phone reboots into 900e mode.
>>
>>   $ cat /sys/devices/platform/soc@0/784000.efuse/qfprom0/nvmem
>>
>> I guess normally this should work? So if I interpret this correctly, the
>> Linux driver thinks it can access more than it can/should. But also
>> should probably try this command on another chipset to see if it works
>> on any really?
> 
> Presumably your firmware needs a different "sc7280_qfprom_keepout". If
> that's true then I guess you'll have to undergo negotiations with the
> DT bindings folks and the nvmem maintainer to figure out how to
> specify that your firmware protects different things than the ChromeOS
> firmware?
Luca, if you feel like wasting some time, you can probably bruteforce
this.

I assume this keepout thing could be expanded in a generic way and
made into a dt property.

Other than that, I think it'd be fine to skip that for now, as it
sounds like it's functional so long as you don't intentionally access
forbidden regs.

Konrad

