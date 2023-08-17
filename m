Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8477F497
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350040AbjHQK5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245144AbjHQK5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:57:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E62D4A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:57:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so73679295e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692269831; x=1692874631;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjVAH+L39jCmTn0TVkHpJ3UBkanw2yXWlt0thMhfDmc=;
        b=LlMi+qQTpRyCPEKl9t1YJ0W2vus7IY+xJCpZKXvbY2lZnQr3r7eGX/itC7Siw5P33p
         2adB0tEtvxouSx0wVNSjhHNe4eXRXWuMqllyB0KR88ZIG0YI566mj3OtTZQKvJCgmbmk
         fT//eThLEdwujAi0yfwpRNJxbGKge0LHPlx6Vh7KKD8CFEPCTuz/IyTOVdsQyShtpSnl
         7ow3ODNV9yiJNwr8aCkrnknKCJ57Kjflsucxjdg9n8s38qlMJdeMeWfxqEhDqChP9SHc
         kHCOLxwjUXK7jqeZz6yYsVQPcznUEpB85qpV49oVrcK/R8lGgxkZM4rwhq43MNkr7sly
         lyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692269831; x=1692874631;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjVAH+L39jCmTn0TVkHpJ3UBkanw2yXWlt0thMhfDmc=;
        b=XlaR6JWXbGaK8ecf/EU81vPBz738xRVm97swLRzoOpjjTTjiv4XRr8/aB/fEfXKXhQ
         yfoSjEvtN30iE9Iu4ePCkxatwy0p7ySo9tGzNxHMZ60VYURR2uAhvULH46RR2JMwaMkd
         A9dCF9U6ObCAYNQ57NAottflx8Y3mMJlUFL5pUd48yWR+T/eZLQOGA+MrLSRQS1XmEHr
         F3SPOZ1w3/4rdNb/kQKP37IYS5M9UvnUd181BFi69YXxnT3R/xNoOwlzlx3VKWsi6K33
         Dfh4S3U1RveHz0lrcmNGkcpNLcLir02plXVNOvWIZPEVku141BG+8YRmcGnKg7Iql7WR
         DF0Q==
X-Gm-Message-State: AOJu0YyyVB/aZUyxtX1UwhvRnPjE4u/54wMEoiAHJhbDMyVowBTcyIMA
        kkzOXU4COhdAsqT6qTsr5d+6+A==
X-Google-Smtp-Source: AGHT+IEEoql9Vvr4zUpU3Cvvlmd/nq5BYhlBhLEUsQc8BCtCCmeQWk/n+2A0RDfCX4a3MgVWPGlASg==
X-Received: by 2002:a1c:721a:0:b0:3fe:5501:d284 with SMTP id n26-20020a1c721a000000b003fe5501d284mr3734445wmc.11.1692269831663;
        Thu, 17 Aug 2023 03:57:11 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s3-20020a1cf203000000b003fe17901fcdsm2498138wmc.32.2023.08.17.03.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 03:57:10 -0700 (PDT)
Message-ID: <f9895948-292e-078e-8a33-1cb18727bbf8@linaro.org>
Date:   Thu, 17 Aug 2023 11:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 04/14] media: qcom: camss: Pass icc bandwidth table as
 a platform parameter
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230814162907.3878421-1-bryan.odonoghue@linaro.org>
 <20230814162907.3878421-5-bryan.odonoghue@linaro.org>
 <eaed15ca-5c0b-420e-a11e-007ef5608019@linaro.org>
 <5332efa6-621c-a338-09e7-dfcc86f898ca@linaro.org>
In-Reply-To: <5332efa6-621c-a338-09e7-dfcc86f898ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 20:09, Bryan O'Donoghue wrote:
> On 16/08/2023 18:20, Konrad Dybcio wrote:
>>> +    icc_res = camss->res->icc_res;
>> Would initializing at declaration time fit in 100 chars?
> 
> Ah yeah, that would be nice.
> 
> ---
> bod

Looking to do this code for this, IDK this would really work.

Going to stick to how its being done in Venus 
drivers/media/platform/qcom/venus/core.c

---
bod
