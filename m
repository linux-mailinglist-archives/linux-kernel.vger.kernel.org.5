Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702447914C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbjIDJdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIDJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:33:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAD2B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:33:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so4482508a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693819979; x=1694424779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6lF0yLij+X6WG+JF5oJhpFpGYbg0jGTt46XFYaBxW8=;
        b=miYKQxxiRTzlomOErBbMlnIaZ1nhTCrhc+YcYAP7I++MBEVoRNFpAndULlEFfJepa9
         9JWtoIBTMpjMBannBauiakeRFIW8L8rm+LbKeYSNtSRBFeh73Co+fAOpVhSh4Vrg3Tib
         NFEDYXt8s9qcPdEmfPr6W9hB8+IhIRS93uUjDBmy1UU747y8UqpvdYNrjL2kKvvwm3LQ
         G/i7OWTTy8zKsWCxu4zZKmhnZSiqsoovt0G7xdZncQK3R1gQOsuE0HRYhfdYpQPu5XDM
         R0LZtTnO7Yf5ho75/28YtZpdrDhnpy7x1DtXxFh0EI1XtCz4+aoBuRFs9jD26fsEibQS
         92Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693819979; x=1694424779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6lF0yLij+X6WG+JF5oJhpFpGYbg0jGTt46XFYaBxW8=;
        b=Jb4L1B1P1mxE2f+hkwEpYOPi9aGQh6ZRVWdG3zkX2q8olRzmC62JkiHxQ/ypOvRuoN
         V/+Bz7bYecIjLK1YBzsYyPWx+zfAUhds0wHuNUh7O6FRqU41J74O7dCMqhNOTN4YTGQw
         6jLFnLtkUUNBedNQ7pnGeQdWCFmZ79i9RWsQW3CdNXjqEbKb0konKyiL6d8l26YGSms/
         CTtCFLAFvEuHPaVwWSFYRoPFioRrQWaswWDL5QcP2Rz0ofHvYW11E1bTGIBE6UZbLxmy
         j3DPNWMs2dr5YrmaTtkXALYJ86p0O36LuHBDcu32Q8DcE6aGPvmmzLUVsyS3nH2B2Ruj
         K2VA==
X-Gm-Message-State: AOJu0YwNV7RdpPKnzoes30SVYn6aorl5eGbk9bm13hngUKUwAYGFMaP5
        JmFZrm0YgJb6CzHU4YLqLIlJaw==
X-Google-Smtp-Source: AGHT+IG2UiuAQfd9LsYfk4KhK5NrnZMH7uuYN45A4Nx09ClzsdyQVmSs6ZHB918+eFkJOiNJb43vWA==
X-Received: by 2002:a17:906:7395:b0:9a1:f1b2:9f2e with SMTP id f21-20020a170906739500b009a1f1b29f2emr9371713ejl.2.1693819979089;
        Mon, 04 Sep 2023 02:32:59 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id gh4-20020a170906e08400b009a1e73f2b4bsm5838482ejb.48.2023.09.04.02.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 02:32:58 -0700 (PDT)
Message-ID: <fbfc6e8d-dd6a-ee1d-a62a-d076470db18b@linaro.org>
Date:   Mon, 4 Sep 2023 11:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: firmware: Add documentation for
 qcom,platform-parts-info
Content-Language: en-US
To:     Naman Jain <quic_namajain@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <359ba91d-866b-45e4-83fe-598ed791f877@quicinc.com>
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

On 04/09/2023 10:38, Naman Jain wrote:
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
> Thanks Krzysztof for reviewing the patch. I think for telling whether 
> the Camera HW block is not
> supported / not present, firmware can either remove the device tree 
> node, or change its status
> to disabled, so that is fine.
> With this patch, I was trying to address the use case, where Camera is 
> supported but certain features
> of that particular Camera are not supported, due to dependent HW blocks 
> not present, or due to
> product decision to not support it. We wanted to avoid the firmware to 
> have this overhead of knowing
> what these individual bits mean and thus, disable few of the HW blocks 
> that are supposed to be
> disabled. And this is applicable for each of these HW blocks.

What is and what is not supported by camera, is obvious from the
compatible and you do not need this patch.

> 
> For example, we can know from 32 bits provided for modem, if 3G/4G/5G is 
> supported or not on a
> platform.

Again, compatible-dependent.

> That is decided based on presence/absence of certain HW 
> blocks, but it may or may not be as
> simple as disabling a particular DT node.
> Basically we wanted to defer it to the subsystem drivers, to do whatever 
> they like with this
> information on sub-parts that are available.
> 
> Will rephrase my commit message to make it clearer, but would like to 
> hear your thoughts on this first.

Sorry, no, such node is not the solution.

Best regards,
Krzysztof

