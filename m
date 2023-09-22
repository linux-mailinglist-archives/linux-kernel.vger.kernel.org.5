Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAAE7ABAF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjIVVNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjIVVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:13:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8732C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:13:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31f737b8b69so2429763f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695417187; x=1696021987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPmLiR5IgzcGCz2TB0wzW8FJ1Dhj+kYM5aO45oGXNRQ=;
        b=nSB1CsWmz1w4s1bKUvSxc0V/DySavsCqx3d92MTj09nuuHs8qInl9+oaQ6MdLWr3lA
         a80K2j6gco0pwbK1Hdc0aEg6LsvVf8VFed2monujUv9oANQyNtcD8SqE4//nJbCa5bF+
         626ejkyKyt+g8qstDRVmZK9r0J1WOwyMqzy2JAZx47WzWiEyLCQ+F4Fycu10PwU1kN8o
         ZouguGEUUtch01pljVEXHjCb7M3Z5orNWpsVzvPp0785vCBNETQZ/zlp02Xw00UQgQY6
         BN3IlSn4JO+o+YkMK2s9FCFnEV7eS9ADUWZulN+Fp16Bksyu/c8rMXho0SMNyb1DmchR
         DhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695417187; x=1696021987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPmLiR5IgzcGCz2TB0wzW8FJ1Dhj+kYM5aO45oGXNRQ=;
        b=NaGSgmA3QCLi1C1L7dJ3rGipFvihe8vrgHLEkyfxBm1Iem+g+UxMA2nTMYxcec8AqI
         p5L85pt16gwDOA6/2OFkMQP8C2UGHccIcLoK9yCFhTCZyYa7qJwAVmgF6qX04NMpl1nK
         t9hOlZp7kdbInBnUPtUdxglWGneNORdBJUlqbndCmXqq+J9XB6a6zbeKGpj+d+WRr0m2
         e2O12IrViDbM24oqOAb+5ThlPsGSD/tjuHUZWphH7HPjPGbulJ4sHJcloAXEsYqsRb5y
         wA2LuIWdGjF1Owdzj9NbfYBev3CxdQMjRs2BKINT1R8mIjSEEbqkB5CwDDilSjQVq7JJ
         d8dw==
X-Gm-Message-State: AOJu0Yyb+SCrGjTfw2JgAY9Wi1ulxVhiDZ+Md3RjrqWl7Upe+wjmIlQo
        8i35q7ue6exFTpEuSPd5Xee8Ng==
X-Google-Smtp-Source: AGHT+IHf5ZxDpCJE6fRz6XZphI8mb32jsaQEqcUsZ3kR6Q3S+T6sO8QyjI1hjtdbu3Jkr1wVzfam0Q==
X-Received: by 2002:adf:cd8f:0:b0:319:5677:f832 with SMTP id q15-20020adfcd8f000000b003195677f832mr680854wrj.62.1695417186634;
        Fri, 22 Sep 2023 14:13:06 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w7-20020adff9c7000000b0031912c0ffebsm5330097wrr.23.2023.09.22.14.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 14:13:06 -0700 (PDT)
Message-ID: <d794af54-08f0-4d10-a282-bd9735bcb704@linaro.org>
Date:   Fri, 22 Sep 2023 22:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to
 DT overlay
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
 <c835c404-33f3-4f5b-8a8a-819d4019e74b@linaro.org>
 <ZQ3_8njijHqat5eV@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZQ3_8njijHqat5eV@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 21:58, Stephan Gerhold wrote:
> On Fri, Sep 22, 2023 at 09:47:07PM +0100, Bryan O'Donoghue wrote:
>> On 22/09/2023 16:11, Stephan Gerhold wrote:
>>> Follow the example of the recently added apq8016-sbc-usb-host.dtso and
>>> convert apq8016-sbc-d3-camera-mezzanine.dts to a DT overlay that can be
>>> applied on top of the apq8016-sbc.dtb. This makes it more clear that
>>> this is not a special type of DB410c but just an addon board that can
>>> be added on top.
>>>
>>> I also prepended a patch that cleans up the node names a bit.
>>>
>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>> ---
>>> Stephan Gerhold (2):
>>>         arm64: dts: qcom: apq8016-sbc-d3-camera: Use more generic node names
>>>         arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to DT overlay
>>>
>>>    arch/arm64/boot/dts/qcom/Makefile                    |  5 +++--
>>>    ...nine.dts => apq8016-sbc-d3-camera-mezzanine.dtso} | 20 ++++++++++++++------
>>>    2 files changed, 17 insertions(+), 8 deletions(-)
>>> ---
>>> base-commit: 7236e86ce5c8198b01c30933c2334d07d877cf48
>>> change-id: 20230922-apq8016-sbc-camera-dtso-f247bea40f99
>>>
>>> Best regards,
>>
>> db410c doesn't ship with a bootloader that is capable of applying a dtbo
>> though, so this conversion mandates an updated or chainloaded bootloader or
>> out-of-tree kernel patch to support.
>>
>> __adding__ is fine but, converting implies imposes a new requirement on the
>> bootchain.
>>
>> Perhaps a middle road solution is to
>>
>> - Add, not convert a standalone dtbo or
>> - Add a dtbo that includes the mezzanine dts but amends it
>>
>> Option 2 for preference but, I'm not sure the dts syntax can be meaningfully
>> made to do that.
>>
> 
> With these patches the apq8016-sbc-d3-camera-mezzanine.dtb is still
> magically built, by running fdtoverlay on apq8016-sbc.dtb and applying
> the dtbo. It's applied during the build process so you don't need a
> bootloader that supports DTBOs.
> 
> There is literally *no change* for you in terms of usage. :-)

Ah I see

+apq8016-sbc-d3-camera-mezzanine-dtbs	:= apq8016-sbc.dtb 
apq8016-sbc-d3-camera-mezzanine.dtbo

I guess I like the idea of having the base board dtb a mezzanine.dtb and 
a dtbo that could be applied as an overlay to the base board dtb, 
optionally.

Our model then for mezzanine enablement wouild be

1. baseboard.dtb
2. baseboard-mezzanine.dtb
3. baseboard-mezzanine.dtbo

With booting #2 or #1+#3 resulting in the same image but, potentially 
allowing for

1. baseboard.dtb
2. baseboard-mezzanine.dtb
3. baseboard-mezzanine.dtbo
4. baseboard-some-other-mezzanine.dtb
5. baseboard-some-other-mezzanine.dtbo

#1 + #3 + #5 which would represent a hypothetical stacking of mezzanine 
boards.

As a model, I think that has merit.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
