Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37AB7AD2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjIYIKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjIYIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:10:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646BAD3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:09:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so46429565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695629398; x=1696234198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdYilTekDb0Up2tp6VS+VmtWrxem1JJhXEmUroxYIuI=;
        b=zIDVGTVSYnqNftLIZhi/ML5d1aOLeI/mTAK4YVLCEZXQ/KFBwqMag8NVnuw+qKcyIs
         DGKDltByGVw2mazhFDWofFAC0l3gRMNi4/diZ7cZpjtTtYzwvRFVPqeNA2LRHR59DIFm
         Y4R5THQUCz7TuCaMC/kNEIQIhM8p26Bg81WAye+KkfGxopj15x4Sp0tSVAmo3ydSJMuA
         FZKyq5iiqomKWRwmaHN5RElAr3ZlgKepUbJ4TN8LfD+7hMxr2fJAJcIHukILTtDoTu0e
         DQdW8HzRWkPbf52cHNjtAYbpsUUVRjzOhKgYCBaieGpoELvKhyISE7+J8fF8TGZ00S5f
         n1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695629398; x=1696234198;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdYilTekDb0Up2tp6VS+VmtWrxem1JJhXEmUroxYIuI=;
        b=pBz9hjj6E2Gc0Qi0lxsqU9whvP4h5ItRcMK7PXri0b81306tdE0LGs7OB7qtfCHhMl
         D70m7nEAnVSt18O60JaazAd/g5tZGeUAOCjW8ZyMclHzdxKQ29K4SpMuZ05XQqcw67u2
         ezgJG4eWrb+25hSXuO7wUrg9q0QrMOvefqwDm9pXl5RF6QGiTWtBjXZfPkML3Xny7shr
         vRF0g9URG+4bCjdqzlkqXG+NC+TlIdNowTFqfcUnGZUSZPyaUA+dZLtA7jdVNVVm4UU0
         s153JqOhS/lZRoUiFq9rFgFBBxEcvdsVelEbShB1Yr7KNBtfkSBp5lVt1nVj5t+gExXt
         7OKA==
X-Gm-Message-State: AOJu0Yz/r0VG/muIZv00W2m0ruMP17hbd0FI+5BntzL3P4JDzfr/VUEU
        JZrZY6QJUV8mf35D9w1mxhTJXw==
X-Google-Smtp-Source: AGHT+IFKP+P7ZaWW/RljNf2s0i02eoE+oQePNTo+bT2u2SP26Ig9V5Qsuo0sSv7q+AvDVOoqZctcAA==
X-Received: by 2002:a1c:4b1a:0:b0:3fe:1fd9:bedf with SMTP id y26-20020a1c4b1a000000b003fe1fd9bedfmr4484843wma.11.1695629397856;
        Mon, 25 Sep 2023 01:09:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c26c500b004030e8ff964sm10516466wmv.34.2023.09.25.01.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 01:09:57 -0700 (PDT)
Message-ID: <751a552e-5209-4d5e-9292-23339a06f8a9@linaro.org>
Date:   Mon, 25 Sep 2023 10:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230925074131.10133-1-ming.qian@nxp.com>
 <20230925074131.10133-2-ming.qian@nxp.com>
 <bbc8dd05-8589-44ec-87dd-f2d7b4368245@linaro.org>
 <AM6PR04MB63418AE18D3D0ED98CCC1A0FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <AM6PR04MB63418AE18D3D0ED98CCC1A0FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 10:07, Ming Qian wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2023年9月25日 16:02
>> To: Ming Qian <ming.qian@nxp.com>; Mirela Rabulea (OSS)
>> <mirela.rabulea@oss.nxp.com>; robh+dt@kernel.org; shawnguo@kernel.org
>> Cc: krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; X.H. Bao
>> <xiahong.bao@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Tao Jiang
>> <tao.jiang_2@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
>> devicetree@vger.kernel.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign slot for
>> imx jpeg encoder/decoder
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 25/09/2023 09:41, Ming Qian wrote:
>>> There are total 4 slots available in the IP, and we only need to use
>>> one slot in one os, assign a single slot, configure interrupt and
>>> power domain only for 1 slot, not for the all 4 slots.
>>
>> No changelog and I do not see much of improvements. Do not ignore the
>> feedback but respond to it or fix the patch. Really, what happened here?
>>
> 
> Hi Krzysztof,
>    What do you mean wrap commit message? Do you mean line wrapped at 75 columns?
> 
>   - The body of the explanation, line wrapped at 75 columns, which will
>     be copied to the permanent changelog to describe this patch.

I gave you clear link to the doc explaining this. What is unclear there?

And you decide to ignore all the rest of the comments here as well?

Best regards,
Krzysztof

