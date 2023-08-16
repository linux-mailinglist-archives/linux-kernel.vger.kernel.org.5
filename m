Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA8877E7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbjHPRgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344525AbjHPRgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:36:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA2C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:36:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe655796faso10990659e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692207372; x=1692812172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=am0/Q3stKuBxx8e63FY+o9BSm3oiO2R3IBlAH+Mi9ok=;
        b=hXW27+q3rYB4HsP/B7zpUIeSwERHFsDCgbmkI9jk5q0kqi7vaT2zmAKj82Azcp6jLL
         3tz9flOJ6ClvyOFcuCsCL72Gq38Uwl++tokUxyQgPKuGRjw5LaHCtQ7is3/ee4Lvr5R4
         GBFBVG9skciT8hgIClC4hPwNMosU3FaTkYw/jlq6wkTVJFOvFRqVGpUIdiIR+HEeppIe
         eqbZo4sD7nj/p1z6i1+cUpphyad+XV72gWeSYcVAKbadM4LHojPUSA28z0Bmt0S0zinO
         ENYR4oDu8LzOZugTJzb+IdNuPDn5TugpjOvSs56jI7sXUxIrZ2epEPRFuAF+p/nQow9h
         X+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207372; x=1692812172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am0/Q3stKuBxx8e63FY+o9BSm3oiO2R3IBlAH+Mi9ok=;
        b=hoI9Ct1VhaDoKovg91+Wfd3ZVCWS1jQuX6oOZDNIjxfT2Wy3XrOSUtTti6/0FhDuAm
         z4gUqdsV6lBDkOYlawSDp1uVzo3c+3HF84pJNRPuHj0LX9v8CU0o1EvaYIOH5+PlNEoO
         K859J+QLwKAhUG54KLUnsff8qH/FGjv3WAiW6ivCAv/dE1Aty5njeGupcT7lU2MTUtNK
         xhdnOF3FnhBlafe8F3e7d3GFBaoPNMYwT9FR+yj26g7Ff9o6xN/nHoYxfOTOauSDNZLB
         E7/UPI2Dur/7VKLAHjYeYJi6pUQWf+ccZcr4y5Ywn5TODFgH281gGb8E3FFgKPdBG7Ah
         ORYw==
X-Gm-Message-State: AOJu0YwLgxpXvbKI0cDiI9sPpkGZUVLLPhVmGfWweuCLOn6Jmd+w0i4y
        YG6R9s3y6TY1GIpV6gPGTBnTPA==
X-Google-Smtp-Source: AGHT+IEJu2EKFIYVQP1vOtcr2w8izNQRsMDD+f95NDPhGQunIwect/XiCjpLlFl6RBB01zTret7EzA==
X-Received: by 2002:ac2:4c9b:0:b0:4fe:179a:18d2 with SMTP id d27-20020ac24c9b000000b004fe179a18d2mr1939743lfl.21.1692207372308;
        Wed, 16 Aug 2023 10:36:12 -0700 (PDT)
Received: from [192.168.1.101] (abxi8.neoplus.adsl.tpnet.pl. [83.9.2.8])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651204c700b004fbb610c354sm2988732lfq.0.2023.08.16.10.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:36:11 -0700 (PDT)
Message-ID: <17542518-42ff-46f6-8304-fb8a214bfa77@linaro.org>
Date:   Wed, 16 Aug 2023 19:36:10 +0200
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <2980f5e6-40b0-4ab2-ae73-bceeb97b4de5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.2023 03:09, Joel Selvaraj wrote:
> Hi Konrad Dybcio,
> 
> On 8/8/23 18:38, Konrad Dybcio wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> This is a driver for the Novatek in-cell touch controller and
>> supports various chips from the NT36xxx family, currently
>> including NT36525, NT36672A, NT36676F, NT36772 and NT36870.
> 
> In kernel v6.4, a basic novatek touchscreen driver was introduced [1].
> I was able to tweak IT a bit (add devicetree compatible, regulator support, remove chip id hardcode) and get it properly working in my Xiaomi Poco F1 which has Novatek NT36672A touchscreen. Probably the other ICs will also work. So, do we really need a separate touchscreen driver? Maybe the existing one can be improved to add more features if needed?
Do you have your end outcome somewhere?

I can take a look and compare if anything's missing..


> 
> Personally I have been looking forward to the v10 of this patchseries :) Thanks for working on this! But, yeah, we need to decide if we need this to be a separate driver.
We'll see, I was hoping I could add firmware loading, SPI transport and
eventually pen support..

Konrad
