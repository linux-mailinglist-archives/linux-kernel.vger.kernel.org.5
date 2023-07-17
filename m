Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D2756096
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGQKgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:36:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09728E5A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:36:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so45494675e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689590200; x=1692182200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQ7PNN0asI/i839sW3EbNjmcJ7buFzqatBShkv/7H+Y=;
        b=waj29Xi7wU96x2L+L8f1UMx8Hi5xFuqnIWWI35l02Ybgf1BbBH071A+6e9xnTPfH6G
         CnG/QXPA650ZmLU5LE1nZHc6oqac08RmevwCdCVLLS5X6PHJ0EIADb3eCEKjo1eNZm4j
         Z8j5j+eJWqsKpPpyribk/vAp048Ij1X5Xib5Jegkw9E9OU0HCoEM7wDiadIkWIf64AwB
         apVIx8ymO/vdugRcwxIh2pJZAl1qXBpYpbmZok03/0Z+SrP61DyFZ7RwnI72ccTX7A9Z
         hONMBLhAsTAP0CvhQ+pUTN2uNNY6VjeiTHEyZVIBejSWtS5QS46JZM80KRFu+mEf8oHe
         OmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689590200; x=1692182200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ7PNN0asI/i839sW3EbNjmcJ7buFzqatBShkv/7H+Y=;
        b=XOHg4xXWOvBbZEfXXt6F9ETDBusTUbwuuTPpO6YrlkYDgHuN/mHR4IIf79e/m9DX3I
         XTAaRMQgPuXQrpJzLePQd3Bke4+RZcZOtvAS4K/A3qr3lQRHLGycjb7tMLrwIC15J6L+
         s+REAFk19fAv1a3VnC7RenU38+ubHrR0+WBT+gYIxN/99YwC4y0DNrM5C6AphINlCCdb
         Fu7VaiEd41kdBEeFUPl1stAsO1NJgF0PYZ6CpZ2f/DcN8T8Bz+nzkC7LPiIHybMoY0UH
         2zdk5Krr1KdRkqZPrkwPyY8y3rR+mdKSM+iwQOGITim1dYk5T6cUhfsmoGqS3A77Qg/h
         WVhQ==
X-Gm-Message-State: ABy/qLazMADxW5YXUcXPC1hw3OmrImYgeE85RFb+5BWJvIwdRrR+vtgK
        1n2SIyGjRtFeujRNYYKF4FD3Sg==
X-Google-Smtp-Source: APBJJlElle/nL2NAUBnF7cDf+eAc4GrVNZ4mC3HHJlY612jFSfNo9g05yqh4YJezf0Ac4Cg6zlQKJA==
X-Received: by 2002:a05:600c:22d7:b0:3fb:e2af:49f6 with SMTP id 23-20020a05600c22d700b003fbe2af49f6mr9129486wmg.39.1689590200412;
        Mon, 17 Jul 2023 03:36:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p14-20020a05600c204e00b003fbdd9c72aasm7714436wmg.21.2023.07.17.03.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:36:39 -0700 (PDT)
Message-ID: <f3a4f113-e470-4bc3-1d77-0b9646c6a4af@linaro.org>
Date:   Mon, 17 Jul 2023 12:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Di Shen <di.shen@unisoc.com>, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, orsonzhai@gmail.com, zhanglyra@gmail.com,
        Di Shen <cindygm567@gmail.com>
References: <20230710033234.28641-1-di.shen@unisoc.com>
 <6d3f24a4-ae70-49eb-6e41-86baa1db6bed@linaro.org>
 <CAHYJL4og14kQ4ev6QtDQeknJELME7URTN_HmR01P5+2RhpthzQ@mail.gmail.com>
 <f7cf2153-aa22-d376-f776-54ea940a5e35@linaro.org>
 <CAHYJL4p7FEjLTZURA6fvVPCmwKodmxWS7fNpi_c0ZFBX7yjDZQ@mail.gmail.com>
 <33508f0e-414f-a990-29ad-58e43d20374b@linaro.org>
 <0844022b-cf2a-dadb-9340-9107cd40169b@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <0844022b-cf2a-dadb-9340-9107cd40169b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

On 17/07/2023 12:07, Lukasz Luba wrote:

[ ... ]

>> int ipa_trip_update(struct thermal_zone_device *tz,
>>              struct thermal_trip *trip)
>> {
>>      // Do more IPA crazy stuff or return -EPERM
>> }
>>
>>
>>>> Lukasz ?
>>
>> Lukasz? what do you think?
>>
>>
> 
> My apologies for delay, I was on 2-weeks vacation. I'll catch up and
> respond to those questions.

No worries, I hope you enjoyed your vacations

The main thing is to know you got the info ;)

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

