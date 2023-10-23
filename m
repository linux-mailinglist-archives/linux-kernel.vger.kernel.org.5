Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC277D3856
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjJWNpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjJWNpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:45:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B6AC5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:45:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso505227866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698068711; x=1698673511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDFbA105q1xOYs5HIYLstL3H0Batpxkx92pzSsWbZfQ=;
        b=Vl1bICU+SALaOlqV414lB+n+CashJdL8DeqM5aCMhHWnAtzSwxPmH4dDTrX5ep9wdb
         WRRpmyeBxdG9lIIrP1+jCx6/bsqfm6X92nkfwM/ATlmd045xEtcskQLwvlt46Iwzrw/x
         h1adHod6ZdBnywm5iGGY/hHfd19DclYtw61TsJUUWVMt2iXcTaPY2QHDkfx8o/GjgjaH
         WXUrGNtkULrm4psGhXT7JTlhFKyrOKTU9fD9rIj7u6uKLtzj+kiZuvVZC7Whv+yRumCR
         sC6IJ/iwpvLrYNsPKP5hEnIVyyusGyUdbVwP1824PbbCk1EgTOX7uGU9YZkF0b9LrXgY
         zCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698068711; x=1698673511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDFbA105q1xOYs5HIYLstL3H0Batpxkx92pzSsWbZfQ=;
        b=al+RfMLTrFz6gV6BqxFkoMz3T6s0AM9UpEmtnZcJTO+xRLv9W/tVaAHblkDtDJeDRJ
         HafbAzOAIX1gUoVzC5HNHfvpBhqjTpFpybQPHY1Y4IbUCGvX9qTrhRQq5xoZ3q6/JMnq
         kh0R5TclCSCtshU/xc92YO/4Z6vWE0f5hX2w0BbO4XVBHEIABCAO9xb3tLBuv3sCAcVq
         IXd38y3e8j2Sl7UNLGbPFQt7ijYfR4csquvXFzsqO4p7L/mxUVFex5oA5Sk0F5wklTmN
         fyRKrvCyEX5q1QI5ix9AorQi9K6OdRygwpKBqUHwZLl+/0ZTraFkflRAGlhyR32TYVol
         PIpg==
X-Gm-Message-State: AOJu0Yziw04hyA2nSJd/kRCarj9EuHlMDAtEZ0cOSpVrJuye5S8UMGyf
        KTPtHyOhA/OOze7XU8Gv8XQI2g==
X-Google-Smtp-Source: AGHT+IH6zJ3DzlZloqajxWjKPx6W0RsdVGjMLOLLeGeGdZpl8NPBb4g3zN2L5wPshyoRDAjKdrKLEQ==
X-Received: by 2002:a17:907:1c92:b0:9ae:69b8:322b with SMTP id nb18-20020a1709071c9200b009ae69b8322bmr8977698ejc.60.1698068711288;
        Mon, 23 Oct 2023 06:45:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id rh8-20020a17090720e800b009930308425csm6640729ejb.31.2023.10.23.06.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 06:45:10 -0700 (PDT)
Message-ID: <33ec4697-87b3-46af-9152-8a44abd3423e@linaro.org>
Date:   Mon, 23 Oct 2023 15:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: [RFC v1] arm64: dts: mediatek: add dtbs with applied overlays
 for bpi-r3
Content-Language: en-US
To:     frank-w@public-files.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
References: <20230916083214.7059-1-linux@fw-web.de>
 <trinity-3fe161a2-70f1-4619-be28-199ea6201668-1696078629921@3c-app-gmx-bs36>
 <trinity-13c822b5-7d6f-4bd0-863f-8f98b1a8689b-1698062394687@3c-app-gmx-bs46>
 <9c1a1119-3257-44dc-8223-7992ea6c86ac@linaro.org>
 <29DCF69F-41B5-4BFB-9539-7ADCC52104ED@public-files.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <29DCF69F-41B5-4BFB-9539-7ADCC52104ED@public-files.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 15:36, Frank Wunderlich wrote:
> Am 23. Oktober 2023 15:25:27 MESZ schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>> On 23/10/2023 13:59, Frank Wunderlich wrote:
>>> Hi Rob/Krzysztof
>>>
>>> can you please give an Ack or tell me if something is wrong?
>>
>> Hm? I do not recall being the maintainer of Mediatek. Why do you need an
>> Ack from me?
>>
>> Best regards,
>> Krzysztof
>>
> 
> I asked you because rob suggested the fix,but does not confirm i have done it right. I guess you have same role,or am i wrong here (sorry then)?
> 
> If no ack is needed, then mtk maintainer can apply it to solve the problem rob reports? So then we can continue with additional dts changes

There is no requirement from a reporter/suggester to confirm your fix.
Just like with every patch, anyone is welcomed to review, so pinging
specific non-mandatory reviewer is rather noise in our mailboxes.

Best regards,
Krzysztof

