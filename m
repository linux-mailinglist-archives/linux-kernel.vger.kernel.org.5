Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B978B400
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjH1PI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjH1PID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:08:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3DD9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:07:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff09632194so5344338e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693235278; x=1693840078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ul6FRFi92oOWpvyHep3fuCukYB06hlwzeQNDsgsMvfM=;
        b=pk7Z50dJ86+vrXjofZKiKu4d0wR/XrpDGcG2MqTqN5OnkFVuH+mzMHouULhJqiB7nr
         u7nivJ+Posa70V+gHCdPOkjZYkvGGzrz9IStgCGvQyFuNTjN6FiodPYPkUvXG90Muf0j
         f4C+DsDgU8Gio491RcFyKfhLcutrcegQyctYb2ouGhrHTh/EXktNSvIuZyiBeehTL3tV
         fMfHdr0H9n1uEv8uQPlaXD5XjYotfTAjdFy5CCfRBtOLQwuUgAfIXjDjyWsu1+1ekxML
         Hv2aNQG9v1U0ttWXio0Y/+ngD93AkI2YdPhwt/Xi8N3GHh0uvCB7qBL5xKNMKJa0X6gz
         ATxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235278; x=1693840078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul6FRFi92oOWpvyHep3fuCukYB06hlwzeQNDsgsMvfM=;
        b=Q8zmocBQ/EVkw0hPDw3lsXq6UuRhw4TH8anHCBnvaW/uZMHEZYawHYLF/FHfGbe9wn
         wKl+SQJisWL0fKvXG5/jI5ZVWh6W469dlitAgV1/bbq8xTyQLi4SMWLR9dn23Zlru+mA
         6iszDXyg4wZ55ICNXy0K2oLkTRs8KPhxDP8eObF/Ez9UVRphMSWCZlSxXF5GAVA3a5nT
         bEQI3D58+4SArOlcA+Z2caX+NX/IY2ewlMdh9EHWQO6uB1bQtWgF5UzNrLogm5UYzovB
         SPxBqUv1+DRzyhWRM4HNtosRJ0K2uYwbX/uDx/2ZwMTTZbhWnuR+ne33nUdoUJVnu3J7
         ReRQ==
X-Gm-Message-State: AOJu0Yxd1FMygytlgG3BsONDv7r7dClR9a4FgNELd/xX8rqYsicOqXBl
        /TdSTK2zQJ8TrgW7DBHm4mN9Yg==
X-Google-Smtp-Source: AGHT+IGRAtQjdjvduPUEmTfSr9t63cYjX0pHzP1Q6xsU5KorgANjH1jv5lgyiduawYIsFPtrFZMdJQ==
X-Received: by 2002:a05:6512:3125:b0:500:94aa:7390 with SMTP id p5-20020a056512312500b0050094aa7390mr10823552lfd.18.1693235278054;
        Mon, 28 Aug 2023 08:07:58 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b004ff947bea2asm1623801lfo.54.2023.08.28.08.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:07:57 -0700 (PDT)
Message-ID: <ab36d90a-147a-481f-9ab6-3a027563b8ea@linaro.org>
Date:   Mon, 28 Aug 2023 17:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180: Reorganize trogdor rt5682
 audio codec dts
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
 <20230816112143.2.I29a5a330b6994afca81871f74bbacaf55b155937@changeid>
 <610a1b08-ced2-4e07-8b69-b2dd2749293e@linaro.org>
 <CAD=FV=VRj4oXFimYxkEOAj7c2ddkWhX1hpTfOFYuAW_svRuAqA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAD=FV=VRj4oXFimYxkEOAj7c2ddkWhX1hpTfOFYuAW_svRuAqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2023 17:04, Doug Anderson wrote:
> Hi,
> 
> On Sat, Aug 26, 2023 at 2:36 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 16.08.2023 20:21, Douglas Anderson wrote:
>>> It was asserted that the "/delete-property/ VBAT-supply;" that we
>>> needed to do in the rt5682s dts fragment was ugly. Let's change up all
>>> the trogdor device trees to make it explicit which version of "rt5682"
>>> we have and avoid the need for the "delete-property".
>>>
>>> As a side effect, this nicely gets rid of the need for a delete-node
>>> in coachz, which doesn't use "rt5682" at all.
>>>
>>> A few notes:
>>> - This doesn't get rid of every "/delete-node/" in trogdor, just the
>>>   one that was used for rt5682s.
>>> - Though we no longer have any "/delete-node/", we do still override
>>>   the "model" in the "sound" node in one case (in pompom) since that
>>>   uses the "2mic" sound setup.
>>>
>>> This is validated to produce the same result (other than a few
>>> properties being reordered) when taking the dtbs generated by the
>>> kernel build and then doing:
>>>
>>>   for dtb in *trogdor*.dtb; do
>>>     dtc -I dtb -O dts $dtb -o out/$dtb.dts;
>>>   done
>>>
>>> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>> [...]
>>
>>> +&mdss_dsi0_phy {
>>> +     qcom,phy-rescode-offset-top = /bits/ 8 <31 31 31 31 (-32)>;
>>> +     qcom,phy-rescode-offset-bot = /bits/ 8 <31 31 31 31 (-32)>;
>>> +     qcom,phy-drive-ldo-level = <450>;
>>> +};
>>> +
>>> +&panel {
>>> +     compatible = "boe,tv110c9m-ll3";
>>> +};
>> This is odd
> 
> Can you clarify why it's odd? There are two possible panels used in
> wormdignler, one with an INX display and one with a BOE display. This
> one has the BOE display.
> 
> For the BOE display, there is one with the old Realtek audio codec
> (rt5682i) and one with the new Realtek audio codec (rt5682s).
> 
> Previously, the BOE/rt5682s device tree could just include the
> BOE/rt5682i device tree and override the audio. ...but Krzysztof
> didn't like that. ...so now we have to duplicate the BOE bits in both
> the BOE/rt5682s and BOE/rt5682i files. We could make a fragment for
> just this bit, but that feels overboard for something that's in just
> two files.
I didn't catch that at all, thought it was an unrelated change that
sneaked in..

> 
> As per my "after the cut" description, I'm not really convinced that
> the end result here is easier to understand. Some bits are clearer and
> some more complex. I simply wrote it up because it was requested.
Yeah I'm not sure either. But then I'm not sure that there is any
fantastic way to go about things with this many SKUs, all of them
just tip the dt-number-vs-duplication ratio one way or the other :/

Konrad
