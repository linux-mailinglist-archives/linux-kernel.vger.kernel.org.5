Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C111A757582
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGRHkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGRHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:40:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540061707
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:39:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52166c7f77cso6114159a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689665998; x=1692257998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCZGDhTgx6NYOp09z9fZEqiBxYqKY8CBN/xmXk4iCoo=;
        b=dnjfF+gTMJhJ6xn6nZzoF+kfk+qFPkiU2XKRFG0/9ccT48Mt8Ku4fhW+o1tGO2Srp6
         jPh2r/LFYaGIGnM9aMGeo7nQI5P1fpF6edzNIf65lrnaThti6SDlGDRV5NPEWFbw9lQ8
         rgAq5m5V5c9yAgeqU8NyB8wpwMXwG8rn02hvVJ0lNds8KFEG64498lVSCplbNbDYhNrD
         liQjQmys4bnzj9Eg79qo7zbbDaEt2+8bOl4quvv1jxC5kfMqK2gfaV2dG25iXtsiS9gB
         4tv3KXBA2Zljhh+hIzo7gDKEBIQgOm5hSnLDJR5lgs4bYhp+wMgEVyxCbjZ8I4TurqFC
         dUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665998; x=1692257998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCZGDhTgx6NYOp09z9fZEqiBxYqKY8CBN/xmXk4iCoo=;
        b=cM4Qiegz3MtXcncHxpNunXZZMQmqhcHlJNxqLjBBolPcV6kk+9p6GcH29eF5zhw8GR
         osW+0xQwGi1t2oTuccvUmVdyxFk/IJ6ETQDWzySvVytnde7+5ZQOuDye/rXqw9xmoup6
         mLIgS7whp13mO5Cx68b9YWpyePwvRea1H6Jjm1nTDh6LuhgXhs7LLXLPz7X/+jz1vmHx
         jeAIBdcxzjq4KObyL2L78OdtdnFG66aB827/bUVp38J4Q/pluonNc7E5N2SrC2auQ3GB
         WyRSO/eb9p4Fh6l6M/gy2GIG0Mv5+lVN94U4Jm9j26mi5XxP7FxsX/w0pzUc7PJvy7WT
         nk4w==
X-Gm-Message-State: ABy/qLai7VeRr8ERdobgrZa2VljMAwosOFW6bYGjuCeMfCnvkQkqtBo2
        hzQPZNQvtICr/oJNz0AvWX6mUagE5y32/KQbFdQJgQ==
X-Google-Smtp-Source: APBJJlHtM2qyLgwJSqxg2UXJx5aW8x/WbIayLUoq4l15QVDQYvOmALzkFctyWPRAM453Vof7NrQfUg==
X-Received: by 2002:a17:906:197:b0:987:fe18:1c56 with SMTP id 23-20020a170906019700b00987fe181c56mr1240597ejb.47.1689665997665;
        Tue, 18 Jul 2023 00:39:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906345000b009930c80b87csm654385ejb.142.2023.07.18.00.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:39:57 -0700 (PDT)
Message-ID: <694a1314-0b25-ff5e-b19f-5a0efe07bf64@linaro.org>
Date:   Tue, 18 Jul 2023 09:39:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
 <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
 <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 09:10, Michal Simek wrote:
> 
> 
> On 7/17/23 22:47, Krzysztof Kozlowski wrote:
>> On 17/07/2023 20:40, Conor Dooley wrote:
>>> On Mon, Jul 17, 2023 at 04:53:47PM +0530, Piyush Mehta wrote:
>>>> Added documentation and Versal-NET reset indices to describe about
>>>> Versal-Net reset driver bindings.
>>>>
>>>> In Versal-NET all reset indices includes Class, SubClass, Type, Index
>>>> information whereas class refers to clock, reset, power etc.,
>>>> Underlying firmware in Versal have such classification and expects
>>>> the ID to be this way.
>>>> [13:0] - Index bits
>>>> [19:14] - Type bits
>>>> [25:20] - SubClass bits
>>>> [31:26] - Class bits.
>>>
>>> Riight.. I'm not sure that describing these as "indices" is really all
>>> that valid, given only 13:0 are actually the index.
>>> I'd be inclined to say that the type/class/subclass stuff should not be
>>> part of the dt-bindings, and instead looked up inside the driver
>>> depending on the index.
>>>
>>> Hopefully Rob or Krzysztof can comment further.
>>
>> This confuses me as well. I don't understand why do you need it in the
>> bindings. Nothing uses these values, so storing them as bindings seems
>> pointless.
> 
> Power Management team wants to use these NodeID with format describe above to 
> identify that elements. And I already told them that ID (0-max) translation to 
> internal NodeID format should be done in firmware but they don't pretty much 
> agree with it.

Too bad for them. They can join the discussion, though :)

> 
>  From DT binding perspective I think it doesn't really matter if numbers are 
> from 0 to max or they are from random high number to another random number 
> without step equal to 1.
> And it is driver implementation detail if driver itself is checking that 
> requested ID is bigger than number of pins passed.
> 
> In connection to reset driver in Linux.
> 
> Core has:
> static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
>                                   const struct of_phandle_args *reset_spec)
> {
>          if (reset_spec->args[0] >= rcdev->nr_resets)
>                  return -EINVAL;
> 
>          return reset_spec->args[0];
> }
> 
> /**
>   * reset_controller_register - register a reset controller device
>   * @rcdev: a pointer to the initialized reset controller device
>   */
> int reset_controller_register(struct reset_controller_dev *rcdev)
> {
>          if (!rcdev->of_xlate) {
>                  rcdev->of_reset_n_cells = 1;
>                  rcdev->of_xlate = of_reset_simple_xlate;
>          }
> ...

If you use both, it means you don't need bindings.

> 
> And zynqmp reset driver already defines of_xlate function that's why checking 
> against nr_resets is not done as is visible from code below.
> 
> 
> static int zynqmp_reset_of_xlate(struct reset_controller_dev *rcdev,
>                                   const struct of_phandle_args *reset_spec)
> {
>          return reset_spec->args[0];
> }

Exactly, there is no xlate. These IDs are not suitable nor needed for
bindings.

> 
> 
> And actually Xilinx Versal platform is using this for a while and you can find 
> IDs description here.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/reset/xlnx-versal-resets.h?h=v6.5-rc2

We cannot fix existing bindings, but we can fix future ones.

> 
> Xilinx ZynqMP is using IDs from 0 to 119
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/reset/xlnx-zynqmp-resets.h?h=v6.5-rc2
> 
> 
> but IDs itself are shifted by 1000:
> include/linux/firmware/xlnx-zynqmp.h:217:  ZYNQMP_PM_RESET_START = 1000,
> #define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START
> 
> static const struct zynqmp_reset_soc_data zynqmp_reset_data = {
>          .reset_id = ZYNQMP_RESET_ID,
>          .num_resets = ZYNQMP_NR_RESETS,
> };
> 
> static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
>                                 unsigned long id)
> {
>          struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> 
>          return zynqmp_pm_reset_assert(priv->data->reset_id + id,
>                                        PM_RESET_ACTION_ASSERT);
> }
> 
> 
> That numbers in DT are virtual no matter if you use ID from 0 to max or random 
> values it is up to code to handle them. Checking nr_pins against ID is done in 
> core but it is up to drivers.

No, you confuse "virtual" and "ID". IDs are not virtual. IDs are real
and have representation in Linux driver. You do not need to define
anything virtual in the bindings.

> In our case that IDs are coming from firmware and driver itself is just matching 
> them.

So they are the same as if coming from hardware - no need for IDs.

> At the end of day pretty much IDs in header can be from 0 to max and conversion 
> to IDs can be done in the driver itself or in driver probe firmware can be 
> requested to provide IDs with specific call.


Best regards,
Krzysztof

