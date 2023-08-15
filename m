Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D55977D510
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjHOVXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbjHOVXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:23:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6ED1FFB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:22:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so54013695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692134552; x=1692739352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KpDKD+sVJdXYaU1Wg1EqC/TG70NEvYXh6Aa2hn+1SF8=;
        b=mo/F20fQ0IV8rC45YQYoGu9fXtjd8xFk8bEPz3rwDZT0XHWjNk4OV5Lr/LFf7ENuVo
         QB635uQyhyi1Q4gS55sUjBMzRCUIxg+5wP5bO4ReUuvpWM4UvA24KZKjIf0c9kLW5gjk
         pCROeJkIUg446ZMz16e8O1FQKil2qyQItlpWlKbV5OYHoPUU4WujHdVUc3/R/IPzk8X5
         dvWN+9S63vEuPvSnWrQ61TG4e8uYWynYWga8LpIb2Gn8GxmVnrAVVsM3B1f9T5qMbqXo
         RBiuoQhMHPPxUDHNsiztpOLuZ9w58cOnDMgCnSWAKV/HKo5mN9aEy+q7q3BTv4DdrIkF
         /zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692134552; x=1692739352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpDKD+sVJdXYaU1Wg1EqC/TG70NEvYXh6Aa2hn+1SF8=;
        b=Pgp/dgMNQGfIIWV12hcyF0xA7GeKfptqJKggwHZ5GjhEuYGloP7Yai2oaxyjow4vW0
         chXYWhTEJM+o4JRQyaqvP7V7s5517danuan4rV7GpmVOxloAjzc0NTLymaLyKoNZUZjT
         zkxpdunqtFIheYRCkBDvWgjyNH/FZvXpHWaHnqWl6V98pZa0nmeHQ6v9Bm3Ib9YqMrRf
         1w7A0RBU6IuXrEHbPJ3x6kPIqm+tKiUzyOgC0qT0XmSa62crKG7LU/nZLF+muI9NDa8J
         D7ci/F+xxanHvNz+EQRG0K0uvzI+7L8I6jH5k1mf3RHq9JmRGg/LgG8TtvBw5B7YqVRI
         xIhg==
X-Gm-Message-State: AOJu0YwSSdDx1o6gUzbimM5plCiotzpfl3UcSrohMt7JMbcI+JqxKL58
        81e4SI+lSx4+lWWH7MbG7Qutxw==
X-Google-Smtp-Source: AGHT+IHKDvMEkLOSRPizQwXu+XFv7VpeI6lXHQZLj2L6dnAscAMJiSsjUaGqM5Fsq2M1+Cy5dP7Gng==
X-Received: by 2002:a5d:6b88:0:b0:317:67bf:3387 with SMTP id n8-20020a5d6b88000000b0031767bf3387mr9434123wrx.60.1692134552252;
        Tue, 15 Aug 2023 14:22:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id q18-20020a5d5752000000b00315af025098sm19078047wrw.46.2023.08.15.14.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 14:22:31 -0700 (PDT)
Message-ID: <eb082e10-efc2-0f5f-95e1-4d2707c87c59@linaro.org>
Date:   Tue, 15 Aug 2023 23:22:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7180: Add board id for
 lazor/limozeen
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
 <0cc71595-ba11-11d4-1fcd-865721ede3f9@linaro.org>
 <CAD=FV=UfKXBQ6R0+5yY6WaNFS49=jmg2NTXrUPcyD3MBZA7A5A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UfKXBQ6R0+5yY6WaNFS49=jmg2NTXrUPcyD3MBZA7A5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 23:10, Doug Anderson wrote:
> Hi,
> 
> On Sun, Aug 6, 2023 at 11:34 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/08/2023 11:58, Sheng-Liang Pan wrote:
>>> add BRD_ID(0, Z, 0) = 10 for new board with ALC5682i-VS
>>>
>>> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
>>> ---
>>>
>>> Changes in v2:
>>> - correct newly create dts files
>>>
>>
>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
>>> new file mode 100644
>>> index 000000000000..5a58e94c228e
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
>>> @@ -0,0 +1,30 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Google Lazor board device tree source
>>> + *
>>> + * Copyright 2023 Google LLC.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sc7180-trogdor.dtsi"
>>> +#include "sc7180-trogdor-parade-ps8640.dtsi"
>>> +#include "sc7180-trogdor-lazor.dtsi"
>>> +#include "sc7180-lite.dtsi"
>>> +
>>> +/ {
>>> +     model = "Google Lazor (rev10+)";
>>> +     compatible = "google,lazor", "qcom,sc7180";
>>> +};
>>> +
>>> +&alc5682 {
>>> +     compatible = "realtek,rt5682s";
>>> +     /delete-property/ VBAT-supply;
>>
>> No, don't delete properties. First of all, why you do not have this
>> supply here? I doubt it... Especially that this DTS has vbat-supply
>> regulator!
>>
>> Second, define the properties where applicable instead.
> 
> It looks like v3 is out, but responding here since it looks like
> Sheng-Liang didn't make any changes in v3 but also didn't respond and
> explain why he didn't make any changes. Sheng-Liang: for future
> reference you should make sure to address comments folks have on the
> list. If your new version takes their feedback into account then
> there's no reason to just respond with "Done", but if (like in this
> case) you ignored feedback you need to say why.
> 
> In this case the extra "/delete-property/" is needed to pass bindings
> checks. Specifically this revision of the board replaces the "rt5682i"
> with the newer "rt5682s". This new codec is _almost_ a drop-in
> replacement for the old codec with just a few tiny changes. One such
> change is that the new codec doesn't need a "VBAT-supply".
> 
> Since most trogdor devices have the older "rt5682i" codec, the default
> in "sc7180-trogdor.dtsi" specifies the properties for that codec. Only
> the handful of boards that have been spun to use the new codec have an
> override like this. You can see that the override done here matches
> the one done in a few other trogdor boards. A good grep is:
> 
> git grep -A4 realtek,rt5682s -- arch/arm64/boot/dts/qcom/sc7180-*
> 
> Ironically, that grep finds that "sc7180-trogdor-pazquel360.dtsi" is
> missing the "/delete-property/" which I'm fairly certain means that
> it's giving a validation warning today.
> 
> I'm happy to have a bikeshed discussion about doing this better. In a
> previous reply [1] I suggested that it's probably time to move the
> "realtek,rt5682s" snippet to something like
> "sc7180-trogdor-rt5682s-sku.dtsi". Then we could include it in the
> devices and avoid duplicating this bit of dts. I didn't insist on it,
> but if you feel strongly then maybe Sheng-Liang could add that to his
> series? Once done, we could have further bikeshed discussions about
> whether we should continue to use the "/delete-property/" solution or
> if we have to also create a "sc7180-trogdor-rt5682i-sku.dtsi" and
> force all older SKUs to include that. Personally I don't hate this
> "/delete-property/" but I don't care a whole lot either way.

Thanks for explanation. I vote against /delete-property/ because it is
error-prone and a bit confusing. The same with overriding compatibles -
if possible, should be avoided. sc7180-trogdor-pazquel360.dtsi is doing
both, but that's not the pattern I find easy to read.

I accept overriding supplies or pins, because these differ per board.
But if common DTSI defines compatible, then it is common for everyone or
it is not really part of common DTSI.

IOW, the common DTSI should be more like a SoC DTSI - have only parts
present there. I simplify here, because obviously SoC is a real thing
piece of hardware and common board DTSI is not. It's just an
abstraction... but anyway if different boards use different codecs, then
I would say it is not part of common platform.

Best regards,
Krzysztof

