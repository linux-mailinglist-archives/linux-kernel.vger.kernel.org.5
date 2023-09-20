Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521FC7A7FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjITMa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbjITMaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:30:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002FACE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:30:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so889523466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695213044; x=1695817844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJ3gWCgaztMYxFnAMNrtqdjgXM+bJh+ntMtoT8Y2h/4=;
        b=L1Y6mtFO47avwBfG5Zum/Hmix9VjhrpYFHcnGUk6mrsQugxjoItGsbnSg52vrAb7EB
         kZ6hDh5OLpsIXQjPFrrk2UIm8Zi1SpzuJ/ELjec/Mh7bZmpMAikCiV0eWbltcx6eAbtH
         5t+kXfLWkuFMCj1RdGdVOCMHrdAq+S23WcbyL+5rGZ9rgmSRppIXL+5oPTtMQLywRWaP
         Byx7C3/FykfXlAvl5TEg3vdTqXVBG/BUNSgQRNNgwQCDWY3imYl9jv4tqqaMdaK47l91
         na1f2dppaBRGUryvRtWbq7chvfLdkP7uVZY2d994RV7ythEQn4wHIMQGPwdr7UqQd7LI
         KlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213044; x=1695817844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ3gWCgaztMYxFnAMNrtqdjgXM+bJh+ntMtoT8Y2h/4=;
        b=Avn9H04CJA7Ya0KMBZfjcd1EKRkY9XKcZqZDfmLoJcr/6ZLfgYRkaphL5HfhSq41al
         YMOwcKLVkoX8uHzZnah6OD8b1y/g3DOBc34nn369a70LUUUn9H72J288d3QHaDhn3XtW
         RsxrAuwkh3I6HjURVdUn9WxdhxvQ225mOWzW6eNvA2dZ4hXV5nrCF4ahaZJ9ost9vGff
         wXX/qI3NVuFlyezK99X2Y55CGT50N7vYrKx0Z1cqKEwbUU0DTMXnMtqNqMVRJA4DZT9f
         4Dr/Ue4Gzz6xmtPHUGHXDWCfT6zSMHN7ZizD6AHFuU/dhp4FioLC8wDa4kj/tPYqaM14
         frIw==
X-Gm-Message-State: AOJu0YzvxF29dCkhDIBoNChEzF50HlYeBvlxxn2fhubVZhwbPetgLBey
        gWe5k8it4Cbnh63IAhEsqvey9g==
X-Google-Smtp-Source: AGHT+IG8CKEIWP/OfpZQP7e91vQw36N6TjapDi739Gf8g3hmlpL4db+fqvvNocVe0zeyxjUzbpHznQ==
X-Received: by 2002:a17:907:78ce:b0:9ae:4978:ed8e with SMTP id kv14-20020a17090778ce00b009ae4978ed8emr1452101ejc.13.1695213044454;
        Wed, 20 Sep 2023 05:30:44 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id dv7-20020a170906b80700b0099b8234a9fesm9337948ejb.1.2023.09.20.05.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 05:30:43 -0700 (PDT)
Message-ID: <66b988f0-39fc-2ed3-8f38-151d6a3c9e52@linaro.org>
Date:   Wed, 20 Sep 2023 14:30:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Content-Language: en-US
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
References: <0b84ef92-f6b7-f3bc-fd51-8f61cbc91ff8@linaro.org>
 <IA1PR20MB4953117947BA7DAA60C1F435BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <IA1PR20MB4953117947BA7DAA60C1F435BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 14:15, Inochi Amaoto wrote:
>> On 20/09/2023 08:39, Chen Wang wrote:
>>> From: Inochi Amaoto <inochiama@outlook.com>
>>>
>>> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
>>> the timer and ipi device separately, and do not allow c900-clint as the
>>
>> Why?
>>
> 
> If use the same compatible, SBI will process this twice in both ipi and
> timer, use different compatible will allow SBI to treat these as different.
> AFAIK, the aclint in SBI use the same concepts, which make hard to use the
> second register range. I have explained in another response.

What is a SBI? Linux driver? If so, why some intermediate Linux driver
choice should affect bindings?
Best regards,
Krzysztof

