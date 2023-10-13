Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896317C8938
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjJMP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjJMP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:56:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4CFC2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:56:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32d9552d765so1502396f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1697212577; x=1697817377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rL18hk5JsFe4nXO4KOVUi65U7rixgreCJydX/X6y9mk=;
        b=MFNMVQWIr33fr2xNVIQ62hr6045OYsT6A6NdQDqCN+o3+1kM5q5Or/4WEYsuErirFq
         h+XAaFwTsxn0/IUjegURXb0zWIm9GewtqwPgVHCsr6QGQPM0MJaHpYlsFsWH7/BzX62v
         bXepjcwN5coQQGwRpzBuiLgxlQJo70X5Db/qShAvK2c+lAeKwFprLQyu7jZBFCiCcBXY
         rFcd6g9XPqqvsxEA/hA7tsnoCMqCxLAAFQ1n9ET1mHdHHpF6p58o8VReK9m5V4bIFTrd
         EgOGeH2FHeAujzddTdb4mTJXAegRZ2AEmDh1nWSGy6zTXMmflP4UV6cESzN9CHwQQkJy
         nEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212577; x=1697817377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL18hk5JsFe4nXO4KOVUi65U7rixgreCJydX/X6y9mk=;
        b=tjstkF8xVFlWHBG0HutIZfOhU5UdltqcM7UslRvizD4JY9NSZAV3WzyGPJovyjsjx3
         IkTob+aPYtevrXoyFwpSy8Gt9ROIc0CgW/G465OLfeX/NhGYLw1elgCF4vXlB9F7tJJ6
         mppPJGZl7bEZZAsMMMXhCJjtKCgNbqbHaovz7h8wL6PzUP077JC7iE6tMTpkmjI2W7we
         wFBSiHQf8O4O0g79l8xvI3HtRheuqk7ImNXcS3zTC2QkcFsgGMx0Ys9j/GvSjlaIZu/a
         UhAEi3iyUCdU95Vltxxt2390gMR8ZQ2QRlmkYkGsOAZup4KL0ENKsPiyVqTG6V3jzCyY
         P0uA==
X-Gm-Message-State: AOJu0Yy4Wf3N1q4DGo3tyz8oTGIftbAX5R75PCOywzDGgxPrKST1/h80
        4GnhjEkr23uwKGxkhXDyLyqXdQ==
X-Google-Smtp-Source: AGHT+IFCoo0IzBlMAA4TrE2I6pvmzmCXr+kr/lGD7qgNi5epMPiamTtxMdZhyMwsiYp+iIcP5iaD6w==
X-Received: by 2002:a05:6000:1001:b0:32d:81fe:7104 with SMTP id a1-20020a056000100100b0032d81fe7104mr7622602wrx.63.1697212576925;
        Fri, 13 Oct 2023 08:56:16 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c450f00b0040651505684sm488980wmo.29.2023.10.13.08.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:56:16 -0700 (PDT)
Message-ID: <6fab7459-42f1-4d3c-a777-d92ee000f243@nexus-software.ie>
Date:   Fri, 13 Oct 2023 16:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231012113100.3656480-1-bryan.odonoghue@linaro.org>
 <20231012113100.3656480-4-bryan.odonoghue@linaro.org>
 <20231013140921.GA3773179-robh@kernel.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20231013140921.GA3773179-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 15:09, Rob Herring wrote:
> On Thu, Oct 12, 2023 at 12:30:59PM +0100, Bryan O'Donoghue wrote:
>> Add bindings for qcom,sc8280xp-camss in order to support the camera
>> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
> 
> You don't need 2 'media' in the subject.
> 
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> This patch depends-on:
>> https://lore.kernel.org/lkml/20231004161853.86382-2-bryan.odonoghue@linaro.org/T
> 
> Who is supposed to apply the above and this patch? Normally, this would
> go thru the media tree, but you didn't send it to them or the media
> list. 

Ah you're right.

I've reused the list of recipients for the camcc series and missed Hans 
from linux-media.

---
bod

