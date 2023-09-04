Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D77791B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352344AbjIDQEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbjIDQEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:04:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F7CCC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 09:04:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5009969be25so2503057e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693843474; x=1694448274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pTzXd+O1B3yH/seobxQV5EVMcTd2XaoEQoDnA1Tg8Gk=;
        b=K+MoEB31GfpDYnZAqTJsx1E1KWSfkSm3e+UglnId5ZQ6pw+yOJdI+moxlm1QUKCAem
         JauIahaWmdJf6QYg8lhAZ86l5+du+OHdzD93lHKnlqDByJPVNk9kseonLqAHfNqB6IBZ
         Hf2evEvlkaXDeSMhl9pO6KFCJcwWdqG8f4jOFp7MCAMo6CJY1OyS1xGKwB+MRTEHwvA2
         /nIUIs+Zxl6XDfeIP1woGg52XSdkYvtwKPP4dVONE+a1i9KtvC9xD/kQrriC0UVrQdCv
         ChIFxaHmqBCMYXiKllngUN9ePiFOMTs+vnbqx7DNepCi/Okx3fZKHO6ikn2NE5eF7XsR
         oGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693843474; x=1694448274;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTzXd+O1B3yH/seobxQV5EVMcTd2XaoEQoDnA1Tg8Gk=;
        b=ViPiodWuRgyO8X8W0tyddL6+e6775xYBFaDKpE4fGKu7roieGM+XOfTG6d6zVDVB2C
         jALG6fxpGfrGw3HKfdidoAPCFvAx8NAmvoQsYs/RDV4fld8BBq7LsCCpuk3EGbRBFevr
         t4aVLp5PRrUAOe+ZiLClvjzWP1B6ITXVthGtLxLCSdoaMnVeISii3Y+6VGMcDqsRlLwu
         7vPXm5gQprPQ47QkN7ypBhUQWQfmVvCIUNUHpAz4QSycxvI8glkJ76BklTGXfvHpXafb
         /9SYbD642XxZCvuUkn0J3t8qtSAlxhVlJ0fBVaHGU/CETpRkBcNwhRYH+74t8RF+bYJA
         mXCQ==
X-Gm-Message-State: AOJu0YxZ2QEEnm5BsSHZ8bvu44ghktAsHF894znEkQFYza2V3mbAqCT+
        CfKxb2jJXRVHI7vmQqbYli4H6w==
X-Google-Smtp-Source: AGHT+IFr0XYxT9znxwfZ+8KPYVO0/pY/WbaPz8gNplqIVaKIQvbpT5Hlqpd+WNeTjvqL/hRcQczMpw==
X-Received: by 2002:a05:6512:340c:b0:500:9d4a:89f8 with SMTP id i12-20020a056512340c00b005009d4a89f8mr7404816lfr.28.1693843474641;
        Mon, 04 Sep 2023 09:04:34 -0700 (PDT)
Received: from [192.168.1.101] (abxj43.neoplus.adsl.tpnet.pl. [83.9.3.43])
        by smtp.gmail.com with ESMTPSA id o26-20020ac2495a000000b004ff9ab6463fsm1805408lfi.87.2023.09.04.09.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 09:04:34 -0700 (PDT)
Message-ID: <bfd34bb8-0fb1-4984-8af5-3651b4a1a74c@linaro.org>
Date:   Mon, 4 Sep 2023 18:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: firmware: Add documentation for
 qcom,platform-parts-info
Content-Language: en-US
To:     Naman Jain <quic_namajain@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_kaushalk@quicinc.com, quic_rohiagar@quicinc.com,
        kernel@quicinc.com
References: <20230901060223.19575-1-quic_namajain@quicinc.com>
 <f340f731-8471-39be-c7b2-7d930916e3b1@linaro.org>
 <359ba91d-866b-45e4-83fe-598ed791f877@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <359ba91d-866b-45e4-83fe-598ed791f877@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.09.2023 10:38, Naman Jain wrote:
> 
> On 9/1/2023 12:52 PM, Krzysztof Kozlowski wrote:
>> On 01/09/2023 08:02, Naman Jain wrote:
>>> Add documentation to describe device tree bindings for QCOM's
>>> platform-parts-info node. Firmware populates these nodes to pass the
>>> information to kernel regarding the subset of hardware blocks
>>> and features like Camera, Modem, Display present in a product.
>>>
>>> This is to support that the same software image runs seamlessly on
>>> different platforms where one or more HW blocks are not supported or
>>> if some sub parts for a particular block are not supported.
>>>
>>> Purpose of these definitions is to allow clients to know about this,
>>> and thus, handle these cases gracefully.
>> Whether camera is or is not supported, is defined by presence of camera
>> node or by its status field.
>>
>> Existing firmware (e.g. U-Boot) is also doing this - patching DTS when
>> needed.
>>
>> I do not think introducing some parallel way makes any sense, so no,
>> that's not the way to do it.
>>
>> Best regards,
>> Krzysztof
> 
> 
> Thanks Krzysztof for reviewing the patch. I think for telling whether the Camera HW block is not
> supported / not present, firmware can either remove the device tree node, or change its status
> to disabled, so that is fine.
Messing with the device tree for no reason (e.g. filling in
/memory@something/reg is expected) or without user intervention
(e.g. static DTBO flashed by the user) is not favored.

Konrad
