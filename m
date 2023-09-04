Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F842791DA7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjIDTdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbjIDTc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:32:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6119CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:32:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b962c226ceso29178501fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693855942; x=1694460742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rVdQIOAoMktMc9/gFJkeJa5tLobQ/kK3OvMEs1xXl7w=;
        b=hXxPT4CMtMB+FX2AOXThLC6oWEzhYncxYikgiLn/Gt+0DeuOffHVOhAnw18pffN1N7
         PRIdgY2mlqp5z87oNT6wQfTCT/4kKXWVZdLm7u2bV218zWkMFbKRPmScKCAzaATtCYrf
         fGsZ9XCyI7Xv+7kqAt0NyorR3mYCjgt5HRcBR4P4YGqO7duT4h5SCivH+KGvxTE8MEp7
         DLo1EigVYcYLRvp6vqbg3sc0DsbDkdaRFwJEIB/3FiA5CoZ93EcKJg3L2Ej2IfltPWhG
         VKSoqpogXX3p528kqImBBqISA9rsnTeRyAlBDfyFOp51RFdgsIXaRgfHGRUC2HJ5CMLz
         IFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693855942; x=1694460742;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVdQIOAoMktMc9/gFJkeJa5tLobQ/kK3OvMEs1xXl7w=;
        b=jfEC18KUme/EHNIoSuuvyfc3/e00ZABdKpNQRfxcngg++T2YQzFd8iD1XOF+zSyeYK
         4qO9K7IZ0+PoLBzGgYdyo3y/32OeAr457SoBhaPUWS4MFJwcGNEpLNij4aT1+dzKEuaW
         VvA9ohmMm2CocOfmChXgGF4w+TdeT3PGWDWKkwHPtqu7AWz3mOphb5R3kKuYJw/zu//d
         JdRzYgypts+8RmN0B1Tgv9CSUKVeoM2fShpfoQCsR+QB4ZDa1NiHOCtPos2nbOWOrEY5
         MDgEQyVmRzIvLPlViEZjYCSNLpNvOlYQL8A+t43V+8Ay+EhvW3okUypT4TLX3tG0d4eN
         9jUw==
X-Gm-Message-State: AOJu0Yw647ipIERkJ75R8tfpbUHBmrOHexankjK+ngvhh3bmi6CtfTJp
        tlHQEIGJgV9tygZ+RJzIlQUIRg==
X-Google-Smtp-Source: AGHT+IEH2dxkBZJx2NV5baglAlP2EKsVHdnwt4SlvirVq5W4Eu88n8vZN0VfF7NI+QLRGZG/CUDaMA==
X-Received: by 2002:a2e:350e:0:b0:2b9:ed84:b2bf with SMTP id z14-20020a2e350e000000b002b9ed84b2bfmr7205421ljz.33.1693855941974;
        Mon, 04 Sep 2023 12:32:21 -0700 (PDT)
Received: from [192.168.1.101] (abxj43.neoplus.adsl.tpnet.pl. [83.9.3.43])
        by smtp.gmail.com with ESMTPSA id w15-20020a2e300f000000b002b6ce8b0dd6sm2343719ljw.75.2023.09.04.12.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 12:32:21 -0700 (PDT)
Message-ID: <49d5c223-c2c7-4e5c-a0a3-dba86408c272@linaro.org>
Date:   Mon, 4 Sep 2023 21:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/15] media: qcom: camss: Fix support for setting
 CSIPHY clock name csiphyX
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-13-bryan.odonoghue@linaro.org>
 <6f381a9e-9aac-4a3a-814e-26a230026d66@linaro.org>
 <5714055d-84b9-f60b-ed58-77d86722d71e@linaro.org>
 <e51e0d29-f455-463f-9324-6ee0459df067@linaro.org>
 <3b3682be-5dbd-5e2d-a6c1-7bdf6d3ff8cd@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <3b3682be-5dbd-5e2d-a6c1-7bdf6d3ff8cd@linaro.org>
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

On 4.09.2023 21:11, Bryan O'Donoghue wrote:
> On 26/08/2023 13:12, Konrad Dybcio wrote:
>>> I really don't understand your point. Could you please restate it ?
>> If we categorized the clocks at probe time (these ones go to csiphy, these
>> ones go to vfe or whatever), name matching like this could be avoided
>>
>> Konrad
> 
> Yes, I like this idea.
> 
> I'd like to make that into a separate series. So I'd like to address your concern on the size of the string in the lookup and then punt the clock story over to another series since it will involved churning though a fair chunk of code, yaml and dtsi.
I can only think of code changes, but fine, this series is large as-is.

Konrad
