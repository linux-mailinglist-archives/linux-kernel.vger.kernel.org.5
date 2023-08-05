Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86D0770F8B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjHEMLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 08:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjHEMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 08:11:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A09744BF
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 05:11:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so29801105e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691237494; x=1691842294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxBP0feVH6uC2ORtGS9BSJOQoNg5tL9xY28BGMfIX6s=;
        b=f5WrVWP+ourzePHp24/NJ0Jh86Q6FuElfYOQPPTG3aqE3hOQCQY2+xQuTH/arVDFs9
         POkpPo/6GwaHc7aiZYcM5e8dY3mE9hDPSwaKjbNwInh4zHnxzJhFLhAsmTTfY1O6oNGW
         KDpYmYgW1rR70uGB3rIkl7WgGHw6jmO6+VnTAaDSUhGUzodCUWCUlUMfhtd1wFLCjsE7
         O1hD+sJPFABmVkMus+AB7wohF9+l5/Y3HbPkapskKKrFQtvpypqH4aG3ji7+Hgj1FaEb
         cyf+qxq1PDYGX2tyDYp8SYha+vTuFvEmshUT537VwlXu1thwkov3WGHpfhdX1YXd6JT4
         OcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691237494; x=1691842294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxBP0feVH6uC2ORtGS9BSJOQoNg5tL9xY28BGMfIX6s=;
        b=TXpnrSHM4m3pMvGVVFxW1rRDwqB7A5M1CuHgZ08N6uWSy+p8Jbd9fZZQoyjHWbBrUC
         upnd6FPsi/kA0L8coUb1cRHnETtxptQGCDRc0i9vJJsRJ3GLZPymmXjn4Tb6GO5pi2WB
         gCdCFo8Dzx19H8sNdH0VVF/htwS6PBaK8XMam6UuTzGYrrKdvAYoFV3Qtr1uRmH03ojR
         renGCvb8yIPUQTlu+SXd8pYXzGiWQ4q7ZYe1TYOhAirAUFLd6D0OpzPO5fuI0dzF55Cm
         fA9NBhpeTAgoIBOKKYAx/1rOXUtFgI8IcaNyCVYB+ZjGfMqeNmAdi8righz+tB/zEcNl
         +ipA==
X-Gm-Message-State: AOJu0YwJdtwN287yZvotvKaRXFKuVO5zhSYRdx2KDjk29H2zxvoenpjQ
        FwvKFvXtLdoxUq4BI73Gu/Rv1Q==
X-Google-Smtp-Source: AGHT+IFInS8TEVpw8at3nnFmeIOA264PuHBbiEjhb4uEc3ufRCS8Se9DI9mdwo2KzkeTrYqD5yxYkA==
X-Received: by 2002:a7b:cd96:0:b0:3fe:1cac:37d5 with SMTP id y22-20020a7bcd96000000b003fe1cac37d5mr3563058wmj.4.1691237493833;
        Sat, 05 Aug 2023 05:11:33 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c2a4800b003fbc30825fbsm4829034wme.39.2023.08.05.05.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 05:11:33 -0700 (PDT)
Message-ID: <1eec01ce-5d14-e6f0-c399-ad14e6d176a9@linaro.org>
Date:   Sat, 5 Aug 2023 13:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/6] media: venus: core: Add SC8280XP resource struct
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-6-8c8bbe1983a5@linaro.org>
 <989aea4c-50e7-8141-dd60-3f41058192f8@linaro.org>
 <c0d4845d-d290-4082-b5c5-996637bcac2c@linaro.org>
 <c2bdc6a5-2f97-9c7b-d620-ff3e361f1f07@linaro.org>
 <172bce60-6581-4832-b489-7497989fc91e@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <172bce60-6581-4832-b489-7497989fc91e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 22:17, Konrad Dybcio wrote:
> On 4.08.2023 23:12, Bryan O'Donoghue wrote:
>> On 04/08/2023 22:10, Konrad Dybcio wrote:
>>>> Would it not be more legitimate and logical to have 8350 use 8280xp's frequency table, instead of 8250 ?
>>> top freq is higher on 8280
>>
>> Still though its a bit suspicious 8350 doesn't have its own table.
>>
>> Are we missing the downstream reference ?
> 8250:
> qcom,allowed-clock-rates = <239999999 338000000 366000000 444000000>;
> 
> 8350:
> qcom,allowed-clock-rates = <239999999 338000000 366000000 444000000>;
> 
> (identical)
> 
> Konrad

Fair enough

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
