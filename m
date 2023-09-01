Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68A478F66C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 02:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347954AbjIAAhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 20:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347949AbjIAAho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 20:37:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8715AE6A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 17:37:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50091b91a83so2520879e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 17:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693528659; x=1694133459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYdpUn9gLAoEvJd9iNxNuu7nuI2TvK4K+oqwqFNmkh0=;
        b=U86Na8YNKJSoxERzfugxeheT2Y7+S44GNWCqp9iPl+2Uohwc7EIo+8zY1xN5CefXLn
         Ln5X12BQVrrO3exhFFwqN1RA++qFJ6Jly2RJasyXOY+dBVPSoMRp5/cAJ6lG/jbWSEmf
         H6KqOIaqmNKYufw9QYq8IFOshncShOE8RWHd3u7pOxx4ZNcj16Q044nu5eQ12+8eaklU
         Lp6Z7TF5eDKRWgCs5e9oZd/xsOvU57HhXNYSsnwbKzSsmQmDZKu1BpvHIBO6KGEoCMRI
         Cwe3z3hHH4bDhtvxOorF/u8qBf+pXTYYyuQ22i117IAPa7oS/XhEbo/RZRfsXQBvoyqZ
         5Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693528659; x=1694133459;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYdpUn9gLAoEvJd9iNxNuu7nuI2TvK4K+oqwqFNmkh0=;
        b=VVaZ6M4bxvyiGOum+gfzcjgvdnjlxrHWMYR+giJmGdmRbcTcWWA2KSdn17gMZJr5JM
         BlR8lxK3CI7tXoSuV4+XnxVxFNRnz3xRg9UppRcsS8slQmXdo+3LX/C6wNYTXEqF3uXR
         pnJfT4ZLY2grznajDXn+RrMzJgR8AsSK7I3ywzQtfxHFdhlwrGNVaAcRVOw2hCG0DdiU
         8mkuPeMDobN1VAIlpQBDhANHJ1Lf33ezE4dAbtdERebjRS4pIObEH9sAm2f/QRcYw9hM
         hgN5tAH4PYU/+L0+jyyt4JbABRdtiHsscCb0ngu64/ftuHNz0y6MuLCuvBjE17cMgkVa
         Kzsw==
X-Gm-Message-State: AOJu0Yw+yYRhX/TiYhn8VZRAvtey2gZxWrMKLc4k680hyHPiPEnrQFPn
        k9g0F33+I02k4Lm7iIyK9f/59w==
X-Google-Smtp-Source: AGHT+IHzu5ZJZb0x3sS/i4MWS/1/KBJVuPzd/Xj0UNFvrnHyTKgAclHTUw9A6fBqNzsQCtkSauh5CQ==
X-Received: by 2002:a05:6512:ac3:b0:4f9:5a87:1028 with SMTP id n3-20020a0565120ac300b004f95a871028mr600403lfu.30.1693528659636;
        Thu, 31 Aug 2023 17:37:39 -0700 (PDT)
Received: from [192.168.1.101] (abxh154.neoplus.adsl.tpnet.pl. [83.9.1.154])
        by smtp.gmail.com with ESMTPSA id x11-20020ac259cb000000b004fe9d0a417dsm467382lfn.185.2023.08.31.17.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 17:37:39 -0700 (PDT)
Message-ID: <5b46f0ab-afb4-475d-b338-ed230c8b4343@linaro.org>
Date:   Fri, 1 Sep 2023 02:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] Input: Add Novatek NT36xxx touchscreen driver
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230808-topic-nt36xxx-v10-0-dd135dfa0b5e@linaro.org>
 <20230808-topic-nt36xxx-v10-2-dd135dfa0b5e@linaro.org>
 <2980f5e6-40b0-4ab2-ae73-bceeb97b4de5@gmail.com>
 <17542518-42ff-46f6-8304-fb8a214bfa77@linaro.org>
 <500b52ee-02e5-4809-b03b-21a9ad6d2b30@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <500b52ee-02e5-4809-b03b-21a9ad6d2b30@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2023 00:17, Joel Selvaraj wrote:
> Hi Konrad,
> 
> On 8/16/23 12:36, Konrad Dybcio wrote:
>> Do you have your end outcome somewhere?
> 
> Here is the driver changes on top of upstream "drivers/input/touchscreen/novatek-nvt-ts.c"
> 
> Link: https://gitlab.com/sdm845-mainline/linux/-/commit/d2f7702a7f6a72eaf2655840036668398942c194
> 
> and here is how I specified it in the Poco F1 dts:
> 
> Link: https://gitlab.com/sdm845-mainline/linux/-/commit/4dd6e4578cc737d2584c7f9657f9f185effe9035
> 
> Regards
> Joel Selvaraj
Hm, the one present in mainline is quite lackluster compared to this
one that Angelo made..

Konrad
