Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B937849DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHVTEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjHVTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:04:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20719CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:04:02 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50087d47d4dso2429411e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692731040; x=1693335840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMIdA2LGk1sJ3CEqERbuxzJSilxx/7toGS2HI7pofz4=;
        b=sFBanmUnVxv5OtXJb8GV4Tvk/z9rO8NhxbqyCzPIp5CqKtzMv+/mxNc/WczABOKoE7
         TYR9OkKfrFMEtCKwuFgSu01PcbPuz1St12SImB7VitVA7bmXGhJDxq7mg0K6SWD1f2VW
         aT4I8h6YhN/cqQBMhnd1aVc5nRd/AugJqbEfOyxw7PWwbq998kEwXO5MEh9A4uM6ro8S
         oaVBt97UjOSgNYfysd5GzNDG78CKaZz8Ttfi8VkftUSjQn/XzJqhhC+ETTSUl8gDOePr
         QBxnioBOSQiIwQqk8kMTf8KkUOs6CPXc7YGLu6WQsvdCm6PrTK4XlWVa0Htv/Dn6arF9
         ySrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692731040; x=1693335840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMIdA2LGk1sJ3CEqERbuxzJSilxx/7toGS2HI7pofz4=;
        b=IdxbgPM89FLWMKjzbixF0gM9B7miZ+xXRoaBgmgE5nLoZnGAE9DzMt3PbNASu7eh+z
         B6llX8GeVFTAYs/t8ePA71SPGHfjWP8TxbekZ3kawy8bB5QyzGCP8wbCmZ0DAd8DP3oK
         RYDKGnEeIbZMuXOGIyjSl9CcuSYwPv3W/cAGle0a1muIpOd2ItgBTEQKLadun5EZ9zLT
         gNHWYsGVmLDTr6Dq1SyTf/SEZpiQd3AqLPqTaw829OSV0Yj6PJ2hsPij/yJ666PY9FHN
         wcf+zEzeLBIII5gjb59tlNRgRV9F+ypAfdK/64fm2GGs8ygCVfWn83rlyGDHLFkKkSH6
         kSSw==
X-Gm-Message-State: AOJu0YxUUfqlLAWqpmycEhoRxAMhNkXwyiCZsZQvRpav3nkQdixtBlY7
        RpMXBzh/vxnXDpkSmp53iz6QYg==
X-Google-Smtp-Source: AGHT+IH49N6lN9cj8u9gYTzDFG7gpdm89P7a++8jngJ2sOV6RbP/ugxa+GDhWrbpvO5o/2BW6thpbQ==
X-Received: by 2002:a05:6512:3f09:b0:4fe:3e89:fcb2 with SMTP id y9-20020a0565123f0900b004fe3e89fcb2mr8107456lfa.34.1692731040167;
        Tue, 22 Aug 2023 12:04:00 -0700 (PDT)
Received: from [192.168.1.101] (abyk189.neoplus.adsl.tpnet.pl. [83.9.30.189])
        by smtp.gmail.com with ESMTPSA id b30-20020a056512025e00b004ff725d1a27sm618041lfo.234.2023.08.22.12.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:03:59 -0700 (PDT)
Message-ID: <65c46da5-b03b-41cd-9030-8ebd7ae7b1e9@linaro.org>
Date:   Tue, 22 Aug 2023 21:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE
 when VC is greater than 3
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
 <20230822161620.1915110-9-bryan.odonoghue@linaro.org>
 <5c917927-92ed-4139-a69f-95761ec63c83@linaro.org>
 <b5b3a8a6-c54d-c503-db76-c8c38942b3b0@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <b5b3a8a6-c54d-c503-db76-c8c38942b3b0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2023 21:03, Bryan O'Donoghue wrote:
> On 22/08/2023 17:32, Konrad Dybcio wrote:
>>>       val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
>>> +    if (vc > 3)
>> I hope you don't pull your hair out, but I think GENMASK(1,0) could be
> 
> 
> I generally dislike the pattern of 1 << value in this code but, it's not something I'm proposing to solve at this time.
> 
>> in order here with a comment about the bitlength requirements
> 
> Not parsing the bitlength requirements comment, whatdoyoumean ?
The thing you mentioned in the commit message, it could also be a
hint in the code above the if-statement.

Konrad
