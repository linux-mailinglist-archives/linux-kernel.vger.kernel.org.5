Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7885D78D9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjH3Set (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbjH3Ob2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:31:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D05919A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:31:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c93638322so202966966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693405883; x=1694010683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7MRgYxQ/rskHMSwacRwQkPlWa4q6KhrBYjtpS5/K2k=;
        b=wpCgh2IXpcYDznF3K9ZFs4oSXTsbpDj8USbQzL7RXBGwd955+rVWxztkVYIipByKx5
         ASV9ddV9sqz1Ay4lNVjiW/x+nIR+vBPhhWocHkFNW0TP4+hF54ZKOA01qskecl8/pAen
         M6tmKgLvnToliVewgFabFk0Gs271Qqhani7DfHcKsOhdYzfWbHaq383Nv/2Ke15bb3+h
         7siE5iDH0LrfYj/7yy+ebqDcSv/z2Mn0uO00M4cVFC9J5jJqgRI+8jHT9ooA1tvm4QSJ
         supdSu9KHGYw7ve9Eu0FpRK98VfW1WJaU8uD8YsBwAUsOSDSv3En/7swKi4RvaOuICot
         9W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405883; x=1694010683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7MRgYxQ/rskHMSwacRwQkPlWa4q6KhrBYjtpS5/K2k=;
        b=XHgeQC3LurWYDxn5Ah6cT7vS89yl3Z6atO8hq3npiTSoCOcLEIsRNQP9+/UDGG9zb2
         FF9dWUeyvhSbzBSe43nJ8/k2rUDfeoNCAYTLbbp+7LbXccLZUB1nbr8UVkCbw/z9XV2a
         tP6FMEO4MM2o3CnSy44Z4uTW3jRbw8kZuy/uiVXxYo0VG8RwpEY63KfJZJftLveJddL1
         5WUnf2jQuV6SpKzdRXIxzGuv+iDdrBlygwMnZcq3KBAxG0IOEoGwWkz8E1YqcGIpmQLC
         MQUFNc3RaJKkEa3mALtpRUJ+n/J175/I+qpiI7DHhLykIEl8kJr+aNRiOFsvluzIf6Ho
         ur/Q==
X-Gm-Message-State: AOJu0YxRgqTRQ3uB8bBKDz1vgKnPd8/aUqHImPqMaUdkxEB2UkPxbFue
        ycP4g5X2ODl7MSaCeuWC04jdvg==
X-Google-Smtp-Source: AGHT+IEYuob+ogJ2cn3jEWJnDOBU0Ct0kNqfWrlOusL37c4JbyVAYrGnYOxwg04hk2/YDSj8e21Uhw==
X-Received: by 2002:a17:906:51c6:b0:9a1:f1b2:9f2e with SMTP id v6-20020a17090651c600b009a1f1b29f2emr2690005ejk.2.1693405883593;
        Wed, 30 Aug 2023 07:31:23 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id pk18-20020a170906d7b200b00997e00e78e6sm7249902ejb.112.2023.08.30.07.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:31:22 -0700 (PDT)
Message-ID: <587b738c-118a-5e1e-bb6b-ea3ca2b93234@linaro.org>
Date:   Wed, 30 Aug 2023 16:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 06/11] firmware: qcom-shm-bridge: new driver
Content-Language: en-US
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-7-bartosz.golaszewski@linaro.org>
 <8b7bada9-3898-1b60-3dea-766a760412f7@linaro.org>
 <CACMJSetObp0k312DmqhTCkw7jsf05OHX1yxbyYj+sVfbtwRcVQ@mail.gmail.com>
 <86bb50fd-72f3-7c76-c4fe-f8e4765e33d5@linaro.org>
 <CACMJSes9Lwgh+xSDQo4KQhOHdcLigYgi=scFTeCtiqKFt1QNnw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACMJSes9Lwgh+xSDQo4KQhOHdcLigYgi=scFTeCtiqKFt1QNnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 15:09, Bartosz Golaszewski wrote:

>>>>> +
>>>>> +     return gen_pool_virt_to_phys(pool->genpool, (unsigned long)vaddr);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(qcom_shm_bridge_to_phys_addr);
>>>>> +
>>>>> +static int qcom_shm_bridge_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +     struct qcom_shm_bridge_pool *default_pool;
>>>>> +     struct device *dev = &pdev->dev;
>>>>> +     int ret;
>>>>> +
>>>>> +     /*
>>>>> +      * We need to wait for the SCM device to be created and bound to the
>>>>> +      * SCM driver.
>>>>> +      */
>>>>> +     if (!qcom_scm_is_available())
>>>>> +             return -EPROBE_DEFER;
>>>>
>>>> I think we miss here (and in all other drivers) device links to qcm.
>>>>
>>>
>>> Well, SCM, once probed, cannot be unbound. What would device links
>>> guarantee above that?
>>
>> Runtime PM, probe ordering (dependencies) detection.
>>
> 
> Shouldn't we cross that bridge when we get there? SCM has no support
> for runtime PM. Probe ordering is quite well handled with a simple
> probe deferral. This is also not a parent-child relationship. SHM
> Bridge calls into the trustzone using SCM, but SCM is also a user of
> SHM Bridge.

OK

Best regards,
Krzysztof

