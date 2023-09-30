Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313D47B41FB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjI3QKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjI3QKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:10:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA3CB3;
        Sat, 30 Sep 2023 09:10:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98377c5d53eso1985070766b.0;
        Sat, 30 Sep 2023 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696090205; x=1696695005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hT4wg6SFaxc/Zrzrs1O2q3JEcPmbwJT97hvjdtjnBO0=;
        b=MjLSRzvM7MIilQWs2VpFPS2DCoEDK53v/2M7GRaPEA5L7vLnPEeKeb6sPHlcFDswAM
         2dhWkppIm5WT9ayrP2nRQWQaoyCSisjnfzmPwXSB82gGewgCZes8uMtrA1MscxgdZP+5
         FCVOLICDjHcM2TCrq/8mtyRpuPrt2M58t04E/hxZQ5sINi0f02EtOvbHkcFFYTbzC/Pw
         gji1x59WO5oZAhGcoV0OGtO0fiGN/QIfA+IafIpXWjxbXPWI6XurZEHKa2XxIK7OCwrq
         ikqd6yfLREL23vG2jef8WMeC0776Wsx/4Rl/cHz9W0hc+p9n1Winv1ru4WRTbCePmX3+
         SfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696090205; x=1696695005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hT4wg6SFaxc/Zrzrs1O2q3JEcPmbwJT97hvjdtjnBO0=;
        b=FhFGLf+fYfwQFSUbNE0R0IjBw/Xin+uerTByaE4kv5AClmIO8pEvdKOKgUZ/X1VY5y
         GxuMlzbhdCw2kXk1NzlquOIjhWElSNpuufgv07PC/RKDIiypvKWSwEMTzD49eoCO/Rks
         IReiWck1dqG/Y44Mro/gYIXuulYxgdqIHBfLRe264pyhvC8pcsReYapC0xuV53GWvBsp
         Tw+OP/NDhFsmdiZL8yhXfcNjNF9ruzfJLnpMx1V6BEewYxF1PWE6I4h+AcvUTG+cwked
         28oFe8q1ZAqw2ezkRxxMbbiruJejMrDqwKWqJwXLfPlwVxC6byaVTWj8mvOrbcgGEzt+
         NCyA==
X-Gm-Message-State: AOJu0Ywcf9PYloLwj01VnRCZzY4PGeOzL7HjxX9ejcrn4inFxMI+sssA
        RkiFOakIzx/ZDQGRF81zNpk=
X-Google-Smtp-Source: AGHT+IES+0aQItUKZ+mIWv62mI8aD4cW6kBitGYQqvesTy1EwlNyRc7rqs9a8/vMpcsmYZd+isxGgw==
X-Received: by 2002:a17:907:75cc:b0:9ae:7150:afb6 with SMTP id jl12-20020a17090775cc00b009ae7150afb6mr6198798ejc.68.1696090204952;
        Sat, 30 Sep 2023 09:10:04 -0700 (PDT)
Received: from [192.168.31.111] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id jt24-20020a170906ca1800b009929d998abcsm14123688ejb.209.2023.09.30.09.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 09:10:04 -0700 (PDT)
Message-ID: <83b92ee4-3dfe-495f-96a0-b8b1780ced68@gmail.com>
Date:   Sat, 30 Sep 2023 19:10:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] input: generalize the Imagis touchscreen driver
To:     Karel Balej <karelb@gimli.ms.mff.cuni.cz>,
        Karel Balej <balejk@matfyz.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jeff LaBundy <jeff@labundy.com>, linmengbo0689@protonmail.com
References: <7b9864bf-2aa6-4510-ad98-276fbfaadc30@gmail.com>
 <72e02837-9a82-4007-8ba2-fa05f3c17670@gmail.com>
 <CVUR18U9FUME.XSF1MML0B1QN@gimli.ms.mff.cuni.cz>
 <06e71bb8-370d-4b66-bedb-3041d6e3b2c6@gmail.com>
 <CVVJR34G5A55.2LYQW8Z5PEEDA@gimli.ms.mff.cuni.cz>
Content-Language: en-US
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <CVVJR34G5A55.2LYQW8Z5PEEDA@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

On 9/29/23 19:37, Karel Balej wrote:
> Hello, Markuss,
>
>> If you don't mind the extra hassle, I'm all in for my generalization
>> thing going together with your series.
>>
>> Alternatively, I can resend it myself, but I believe it would be better
>> if they go in bulk since they need to be applied together.
> great. Do you wish to make any changes to your original series? If not,
> please let me know and I will use the v2 [1] as it is.
I believe that version should be fine.
>
>>>> As for the voltage set, I believe this does not belong in a kernel
>>>> driver. You should set it in device-tree with `regulator-max-microvolt`
>>>> and `regulator-min-microvolt`.
>>> Please see my response to Jeff regarding this. I will be happy to hear
>>> your thoughts on what I propose.
>> Actually, the regulator values belong to the device-tree, because the
>> device-tree for the board is what describes the board's regulators, and
>> since you know what components are installed on that specific board you
>> can know which regulator values are supposed to be set for it.
>>
>> [...]
>>
>> The actual min/max values for regulators or its voltage table is
>> provided by the regulator driver itself, so there's not much point in
>> specifying those again in the device-tree.
> I see. I think the reason why I thought what I wrote before is that
> downstream the regulator DTS lives separately from the board as a .dtsi
> file which made me think that it can be used universally. So if I
> understand correctly now, the hardware specifications of the regulator,
> such as the minimal and maximal voltage should be part of the driver,
> while the DT should contain requirements for the given use of the
> regulator (with a specific board) - is this correct?
That is correct.
>
>> This manual voltage setting can cause conflicts with other drivers for
>> example. Also some device can use a variable wide voltage range, and
>> some only specific narrow one, and e.g. the driver with wide range
>> would set it to voltage that isn't suitable for the narrow range
>> device, so it's much better to just specify it manually than have it
>> resolved.
> I would expect that in the case you describe, the kernel would set the
> voltage to a value which would satisfy both the ranges. I don't know
> what would happen if that was not possible (i. e. there was no
> intersection in the two requested voltage ranges), though. Or does a
> call to regulator_set_voltage set the voltage immediately taking notice
> only of the hardware contraints? I think I am having trouble
> understanding what this quote from the regulator_set_voltage
> documentation means:
>
>> If the regulator is shared between several devices then the lowest
>> request voltage that meets the system constraints will be used.
> But actually, it probably doesn't make sense that the kernel would try
> to resolve a range suitable for all calls to this function as, I assume,
> a single driver could call it multiple times with disjoint voltage
> intervals.
Well, I assume kernel has some sort of behaviour for that stuff, but I 
believe setting the voltage by the device manually is discouraged in 
general. It should be possible, though.
>
> Thank you for your patience.
>
> Kind regards,
> K. B.
- Markuss
