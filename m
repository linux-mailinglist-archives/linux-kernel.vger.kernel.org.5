Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE6C78A61D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjH1GzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjH1GzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:55:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD16810D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:55:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5236b2b4cdbso3821241a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693205707; x=1693810507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ptVbyds4HPxErszif0wxUcSHmLuVkPZo/yMJrdkcDs=;
        b=u0I+AIPq3WtDnTAreCyy90MCKvMJSVNboKn65rhdsoXltifxtaS6henYb7U0KLvsNW
         i3wZxjTfgqN2DGvK+g6X5zL58jJHihTJBSEV+1gP9QOU5Tnx/Qg8QEVzU8jL6D/72qBR
         stTOBbz4Wfqgfqu5+Fmk10KypDISxN8gdjsRZMcWX3qg+cWAIKaJaLJFRV61/btyTdXG
         d+TWmGQoixmcQpB76hT7R8fMtEONUFXi5BsUvJgwln7TnTNjCPCENZT97Y9ix7MoWkrX
         ewjOuQc4ovmaamkKRAx4EYWbGB4nPpyqXRpu5ZAkl3FQP5V7gjaSEr1qFs+64bVfk80/
         iMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693205707; x=1693810507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ptVbyds4HPxErszif0wxUcSHmLuVkPZo/yMJrdkcDs=;
        b=H64x6aJDlmgRzHXDv6bzavE8SFCDV+pTFyckIai6zLdRKGIfzmxOAadTaRi8nPmHTf
         XKvmjyN3WggbHwCmQxjMdVbNApVQe277bF7q6saDWtsB9lm6Iq6e4UanE1VZ+N4AbWkL
         Gal3bAE3wuRnNzANzEdgSrQEdTgJIeYVGhrEHMSmj8fn7Qy8FFDlinDKJAr1bbVrXGLR
         V5yfXsKOJgR4bLbHQHOsGADAvasQpaQeSGqDP+RC4F+ROREVcLIt+WVWmPuiiVvpBiYd
         hJvbStrwEiksw73AeDc7bLkg/hxvtSClwwhnQeJ9lwrPVaCIPhm8s4LPG0N0XHp9Yc6p
         TX4w==
X-Gm-Message-State: AOJu0Yz3k6a/anY6JO83lB7zcoOuBY00RJrkbaamMd8+9QZ3eL1l2WMZ
        UR7uIK/5zFBaQuhE4bDaDmLqWQ==
X-Google-Smtp-Source: AGHT+IE1kB47fLHbKb5MQZ/Hd2Twqa/OpuzYsNApKa6FCmlGY1PnQViOFPgPIAAC/uHevNyPrQA4Nw==
X-Received: by 2002:a05:6402:545:b0:523:1400:2d7c with SMTP id i5-20020a056402054500b0052314002d7cmr16646990edx.35.1693205707362;
        Sun, 27 Aug 2023 23:55:07 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id o7-20020a056402038700b0052565298bedsm4094401edv.34.2023.08.27.23.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 23:55:06 -0700 (PDT)
Message-ID: <9f983d06-e82b-e572-e007-18d39c15ead7@linaro.org>
Date:   Mon, 28 Aug 2023 08:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Content-Language: en-US
To:     Varun Sethi <V.Sethi@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Pankaj Gupta <pankaj.gupta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-2-pankaj.gupta@nxp.com>
 <20230823124340.GA2022486-robh@kernel.org>
 <574e93da-ec74-f1a2-7170-c16bb225a2bb@kernel.org>
 <2023082422-proofing-dispense-1a1a@gregkh>
 <AM9PR04MB8211D170F1D484E083C8F899E8E0A@AM9PR04MB8211.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM9PR04MB8211D170F1D484E083C8F899E8E0A@AM9PR04MB8211.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 08:00, Varun Sethi wrote:
> Hi Greg,
> 
>> -----Original Message-----
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Sent: Friday, August 25, 2023 12:54 AM
>> To: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>; Pankaj Gupta
>> <pankaj.gupta@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; clin@suse.com; conor+dt@kernel.org;
>> pierre.gondois@arm.com; Jacky Bai <ping.bai@nxp.com>; Clark Wang
>> <xiaoning.wang@nxp.com>; Wei Fang <wei.fang@nxp.com>; Peng Fan
>> <peng.fan@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
>> davem@davemloft.net; krzysztof.kozlowski+dt@linaro.org; linux-arm-
>> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Gaurav Jain <gaurav.jain@nxp.com>;
>> alexander.stein@ew.tq-group.com; Sahil Malhotra
>> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Varun
>> Sethi <V.Sethi@nxp.com>
>> Subject: [EXT] Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw
>> binding doc
>>
>> Caution: This is an external email. Please take care when clicking links
> or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On Thu, Aug 24, 2023 at 08:45:41PM +0200, Krzysztof Kozlowski wrote:
>>> On 23/08/2023 14:43, Rob Herring wrote:
>>>>> +                                                          |
>>>>> +  +------------------------------------------------------ |
>>>>> +                     |             |           |          |
>>>>> +  userspace     /dev/ele_muXch0    |           |          |
>>>>> +                           /dev/ele_muXch1     |          |
>>>>> +                                         /dev/ele_muXchY  |
>>>>> +                                                          |
>>>>> +
>>>>> +  When a user sends a command to the firmware, it registers its
>>>>> + device_ctx  as waiter of a response from firmware.
>>>>> +
>>>>> +  A user can be registered as receiver of command from the ELE.
>>>>> +  Create char devices in /dev as channels of the form
>>>>> + /dev/ele_muXchY with X  the id of the driver and Y for each
>>>>> + users. It allows to send and receive  messages to the NXP
>>>>> + EdgeLock Enclave IP firmware on NXP SoC, where current  possible
>> value, i.e., supported SoC(s) are imx8ulp, imx93.
>>>>
>>>> Looks like a bunch of Linux details which don't belong in the binding.
>>>>
>>>> Why do you need your own custom interface to userspace? No one else
>>>> has a similar feature in their platforms? Something like virtio or
>>>> rpmsg doesn't work?
>>>
>>> +Cc Greg,
>>>
>>> I doubt they care. This is some stub-driver to pass messages from
>>> user-space to the firmware. The interface is undocumented, without
>>> examples and no user-space user.
>>
>> Great, no user?  Let's delete the code then :)
>>
> [Varun] We do have middleware applications that utilize the driver.
> Following
> are the links:
> https://github.com/nxp-imx/imx-secure-enclave
> https://github.com/nxp-imx/imx-smw
> 

Why this is not explained in the cover letter and in the patch adding
the interfaces? You still need to document and explain the interface.

Best regards,
Krzysztof

