Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346DD7CC8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjJQQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:22:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE12ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:22:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507962561adso6734341e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697559730; x=1698164530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhFXYnO9Sn+RH2C/xMmWiKTwoHM9JKuhK3zd261Cr0s=;
        b=lT6jPE50MGNKevW1X1gWUvhfUODj4hpFpz71XE6+EhQjcAY6mVszKMQsWOqdqN456L
         u/trIBom5FFuOP6aV931LjXIJ4ErxRfnN0QXFbC9LOISi3BjrmLNQ9jT7RZpLuIaNZGv
         bIM9QPYA8vtUCb4QcBQ8Vn/qyCGytaghbhNw8yy0bc2rJljzMmhXwBqx8LURLw9mwByV
         ls8RuC9LuMMPC/ZLd7ydE/G0e9YofuDOD4q+FxsjChkXQB7C2TKPf5nxkIMV8bsQk4pH
         YRJefyNzqSai6w1qsK6iQKgMQ5QDTVByryuXoE0Fnbn6zGpeZNfRYXBVx4C7rBZa3iKk
         oCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559730; x=1698164530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhFXYnO9Sn+RH2C/xMmWiKTwoHM9JKuhK3zd261Cr0s=;
        b=tXqgh4y0gpT6OQwrCJ6BmVqkOUE7Y8sb8C/VJsPeJEYha/ECMHd+mgqEMP+t5UImyk
         dE7UxFIOBxDj3p6G7HXZksaNHXQ3SDVwH8Wv1Wau8bJ1TwmLlHhopPCeLro1D4ebzWvf
         BI8aw33QhFcWnXjAKw5RfVsfasqor74MbDbKed9PvLJRTN7tn51enAX+Nv9gVo83q/07
         j343Cx6FSQzTqaYLXTRa/sh1PHCbpE3PH0M9cN0gb5LJMwQXppGhZHhPa9rUBlLrg9NN
         CrYwSSSQGcZnAyDXTBGjQ1SLI2AIfIgC9+ArRaE6EEjjAqa9E5OssspOmq5Y7s3Hs8ea
         ew/Q==
X-Gm-Message-State: AOJu0YyASJl6tKedRO1oQsoGI0bOgVTNeuv1d7jSBBuGGcIzf5ydBUpD
        QyQpNWSh9PvEsuCn1dsVje1GdQ==
X-Google-Smtp-Source: AGHT+IGe4/EPokGcR14WOKTrawH9tGwUZLQcJXRew6V+8JtVuXgdh2CH8CgJREzH8K+96cAmlsZdIg==
X-Received: by 2002:a2e:99da:0:b0:2c5:19ab:726e with SMTP id l26-20020a2e99da000000b002c519ab726emr2386571ljj.47.1697559730239;
        Tue, 17 Oct 2023 09:22:10 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b0040813e14b49sm1684492wmq.30.2023.10.17.09.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:22:09 -0700 (PDT)
Message-ID: <f4a5cd2e-112d-478c-b56b-68bc55ecbdf7@linaro.org>
Date:   Tue, 17 Oct 2023 18:22:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY
 compatible
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230929-topic-x13s_edpphy-v1-1-ce59f9eb4226@linaro.org>
 <CAA8EJprXCzVyaU49qgVcVfF0-FJ3QqAfTMZj5CEZm187hoi4=g@mail.gmail.com>
 <ZSz7---IW_7Oj2Zr@hovoldconsulting.com>
 <CAA8EJpr=HQOs8Ho_s_34y0-krCHwq3MThMkUzhOkPVdOSMQ62A@mail.gmail.com>
 <20231017032810.GP3553829@hu-bjorande-lv.qualcomm.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231017032810.GP3553829@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 05:28, Bjorn Andersson wrote:
> On Mon, Oct 16, 2023 at 12:10:18PM +0300, Dmitry Baryshkov wrote:
>> On Mon, 16 Oct 2023 at 12:01, Johan Hovold <johan@kernel.org> wrote:
>>>
>>> On Mon, Oct 16, 2023 at 11:51:33AM +0300, Dmitry Baryshkov wrote:
>>>> On Fri, 29 Sept 2023 at 19:03, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>>
>>>>> The DP PHY needs different settings when an eDP display is used.
>>>>> Make sure these apply on the X13s.
>>>>
>>>> Could you please clarify, is it the same PHY type, just being
>>>> repurposed for eDP or is it a different PHY type?
>>>
>>> Same PHY, just different settings AFAIK.
>>>
>>>> If the former is the case (and the same PHY can be used for both DP
>>>> and eDP), it should carry the same compatible string and use software
>>>> mechanisms (e.g. phy_set_mode_ext()) to be programmed for the correct
>>>> operation mode.
>>>
>>> Possibly, but that's not how the current binding and implementation
>>> works:
>>>
>>>          6993c079cd58 ("dt-bindings: phy: qcom-edp: Add SC8280XP PHY compatibles")
>>>          2300d1cb24b3 ("phy: qcom: edp: Introduce support for DisplayPort")
>>>          3b7267dec445 ("phy: qcom: edp: Add SC8280XP eDP and DP PHYs")
>>>
>>>          https://lore.kernel.org/lkml/20220810040745.3582985-1-bjorn.andersson@linaro.org/
>>>
>>> And you'd still need to infer the mode from DT somehow.
>>
>> If it is the same hardware block, it seems incorrect to have two
>> different compat entries. For example, for PCIe RC vs PCIe EP we
>> specify the PHY mode from the host controller driver.
>> I'd say, we need to fix the bindings for both DP/eDP controller and
>> the PHY.  See the `phy-mode` DT property for example.
>>
> 
> It is one hardware block, supporting both eDP and DP, so I like your
> suggestion of having a single compatible instead and using some other
> means of defining the configuration. I just wasn't able to find a
> better way to do so back when I wrote the binding/driver...
Since this one is still unused, we can deprecate it (not sure if remove, 
but deprecate) and add phy-type instead. I was quite surprised to see 
that a new compatible was added as well :/

Konrad
