Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD107937F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbjIFJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjIFJVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:21:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0733E50
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:21:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bcfe28909so493202166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693992093; x=1694596893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mosQA1Z8AMW4TgZ1FXhqGU5ILwvCqddYrUv5k/pOamA=;
        b=IOd6v58ZPrtHsqjUprMVsvMiR5zJ17qkyC1G8K7JLTNvofbDVSxRheg9aSD/SgyrOe
         SzbAD65CMsOo+8DT1K5OhZPV2IIkLJQdQZGJyod/zjMROB788+xK7F41XEKIDgicB25o
         rr2eswa1qkkMNt91uA3KUgWl9PeZwZ1g4a9ihmgJxAZ2L8om34paZibyAdVJc+4euIm9
         NiFIFde3OSEIU7U8weqUajOF6/ChoFB/BARSvng16Dkoasf+E8xiJt6etTbQnKoeuH6V
         PR9u3f/JxFMgKriNkO2BXt0cnzwwnZGopw0GggvZPcVG3taXQHc1tSWlAki0NdtuPVDw
         /arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992093; x=1694596893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mosQA1Z8AMW4TgZ1FXhqGU5ILwvCqddYrUv5k/pOamA=;
        b=VcNmv2zSQElSMKaapq7SgmgaZgJr/Wm2w6TDFG/ZD5pJ6sRKltz9grawXpA+X42AtU
         uMMdpuA110AD4FMMIDlQ/UCzgdDrJ4zUwYg7Y87KrqnVGPGgKsEJ5pPjfEiRHw8FEBiw
         N0fN+rv2noq2cSgUM7ob0lCvrwm7zzXFdY1xitCNrQa3HWcu71XI2V2RrPInoMfN9pCP
         HvL2RDm2x+XcDkTupkups9DuMuR4kCh+RSUuoTcw/DAWZ7a1HCKQ58L8GjU7RdwFwqes
         GhOZVNX4FOoqYFoa2n8G/fTdLAwE+cz4jMdcCHv6enSr4b887Hs+HN1dsKZP7i5w5CvY
         0JLA==
X-Gm-Message-State: AOJu0YzYZWUvDlqJVsoIXxy6XTDexp4cdb+QOelORj7zsEh8fBPRJ7Q+
        tA1JaJAPfSPo1GA0/PjYS5QTzQ==
X-Google-Smtp-Source: AGHT+IEqN8yumUMQ6iPTk72w0/+TSYnLcyYvOBAXXX38lgfTKbtqWsQSEHcxbrabVrpvOooKpQNTig==
X-Received: by 2002:a17:906:846a:b0:99c:fb44:d4a9 with SMTP id hx10-20020a170906846a00b0099cfb44d4a9mr1493075ejc.77.1693992093387;
        Wed, 06 Sep 2023 02:21:33 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709060ac700b0098d2d219649sm8882459ejf.174.2023.09.06.02.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:21:32 -0700 (PDT)
Message-ID: <59e07c6a-6f1b-0cc7-dddc-96d2a4050843@linaro.org>
Date:   Wed, 6 Sep 2023 11:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays
 for thp7312 cameras
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-4-paul.elder@ideasonboard.com>
 <502fc7b1-a32d-6901-3a45-d2aa0e0c3849@linaro.org>
 <20230906083237.GL7971@pendragon.ideasonboard.com>
 <a3ed9856-a87b-5cf6-26b5-ff2b19234a8a@linaro.org>
 <20230906090058.GB17308@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906090058.GB17308@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 11:00, Laurent Pinchart wrote:
>>> has a regulator@0. There are similar instances for clocks.
>>>
>>> I understand why it may not be a good idea, and how the root node is
>>> indeed not a bus. In some cases, those regulators and clocks are grouped
>>> in a regulators or clocks node that has a "simple-bus" compatible. I'm
>>> not sure if that's a good idea, but at least it should validate.
>>>
>>> What's the best practice for discrete board-level clocks and regulators
>>> in overlays ? How do we ensure that their node name will not conflict
>>> with the board to which the overlay is attached ?
>>
>> Top-level nodes (so under /) do not have unit addresses. If they have -
>> it's an error, because it is not a bus. Also, unit address requires reg.
>> No reg? No unit address. DTC reports this as warnings as well.
> 
> I agree with all that, but what's the recommended practice to add
> top-level clocks and regulators in overlays, in a way that avoids
> namespace clashes with the base board ?

Whether you use regulator@0 or regulator-0, you have the same chances of
clash.

> 
>>>>> +		orientation = <0>;
>>>>> +		rotation = <0>;
>>>>> +
>>>>> +		thine,rx,data-lanes = <4 1 3 2>;
>>>>
>>>> NAK for this property.
>>>
>>> Please explain why. You commented very briefly in the bindings review,
>>> and it wasn't clear to me if you were happy or not with the property,
>>> and if not, why.
>>
>> Because it is duplicating endpoint. At least from the description.
> 
> The THP7312 is an external ISP. At the hardware level, it has an input
> side, with a CSI-2 receiver and an I2C master controller, and an output
> side, with a CSI-2 transmitter and an I2C slave controller. A raw camera
> sensor is connected on the input side, transmitting image data to the
> THP7312, and being controlled over I2C by the firmware running on the
> THP7312. From a Linux point of view, only the output side of the THP7312
> is visible, and the combination of the raw camera sensor and the THP7312
> acts as a smart camera sensor, producing YUV images.

None of this was explained in the device description or property field.
I probably judged to fast but it just looked like duplicated property.
Then shouldn't it have two ports, even if camera side is not visible for
the Linux?

> 
> As there are two CSI-2 buses, the data lanes configuration needs to be
> specified for both sides. On the output side, connected to the SoC and
> visible to Linux, the bindings use a port node with an endpoint and the
> standard data-lanes property. On the input side, which is invisible to
> Linux, the bindings use the vendor-specific thine,rx,data-lanes
> property. Its semantics is identical to the standard data-lanes
> property, but it's not located in an endpoint as there's no port for the
> input side.

And how does the property support multiple sensors? What if they data
lanes are also different between each other?

Best regards,
Krzysztof

