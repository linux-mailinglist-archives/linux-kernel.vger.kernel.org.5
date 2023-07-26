Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E0F76363B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGZMZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjGZMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:25:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F224DD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:25:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9922d6f003cso1122100866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690374311; x=1690979111;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlhtyM+OrTTctRIsKX8V1gw7veM/quE3CQ/8xqXe/V4=;
        b=jBXnauaEBV4Ci/AfNaTw9YyCnVwegJCt/Lkk1yJiBLu1VjfJfv3Ug8jDCtfAwfu6+5
         v2ijcvGGrm39P/7eCGiLUG7RQYoGdGfPTLU85thv+RFUXliYEgJbOfNABzsWvKvmtcnn
         iaA4fTSTv9XrO9yQnpnsq5r+D6H5EOpC+VKlrA0jsf9qSYp01GrbzQI7qf2NRbqD+2KH
         LT54lGXhNOzeZXFJUDi4BxLrv3y04D2b5ls0ejbRkXuUIq2Wzr6sQzpFQQllzkLorges
         S5dkmsg/Qr0GPdwUgPq46ffe9SFaqZelXiyQkkWFbNgLNTkTa3Q59X6G3ZGzwk3/uciZ
         vM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374311; x=1690979111;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlhtyM+OrTTctRIsKX8V1gw7veM/quE3CQ/8xqXe/V4=;
        b=BKYjSPeuH63nzcaDJ/w/ZIh7VKM+wOSwnh+NHxwvkj9xknyxFW1qGeDjzHHuD6afaF
         5Kaj+RkCUObHTNqzstFjNQr+1z91uLlgCFw5as3MG8H+hHnvtAMuLXBabszWV/puzqhE
         XG7T/ijPi88lBI+lWNBG8FKFPPW4WO/TM1RjFJeDx2bn5f8xaQl+6KRQLzNd3utRhwqJ
         z76uBjl2g9NZHWdHy0mDRl8yBF4JfpchRb2dbm9YyTSFNq1yWb/5LX/UX3x2fWv61WoJ
         +H1Ma0nw4iS3ENGDmF52dKjkG10JzFeXr8c5Q3V2/urjpSY2N3RdVybctq+XvLwX4VOR
         hrnQ==
X-Gm-Message-State: ABy/qLb+wqsteP9s0uTUFJCfF7/H4lze3GKvgxmZ3UXtWPvw1HyjTI2j
        CG6staThvFXDZcl6AyJp3Ur3LA==
X-Google-Smtp-Source: APBJJlFGA4XUY2FqvE0YIn/1R8i6M97EGxmz0JJ77jnidALchE4QpWT5FXR5ELobtg5JlZKYU5LwgA==
X-Received: by 2002:a17:907:7883:b0:993:eddd:6df4 with SMTP id ku3-20020a170907788300b00993eddd6df4mr1660612ejc.10.1690374310935;
        Wed, 26 Jul 2023 05:25:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qh1-20020a170906eca100b0099bc8bd9066sm661019ejb.150.2023.07.26.05.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 05:25:10 -0700 (PDT)
Message-ID: <71e859aa-ba01-eb3b-8272-fa9993318b34@linaro.org>
Date:   Wed, 26 Jul 2023 14:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hwmon: (hs3001) Fix unused variable compiler warning
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     werneazc@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>,
        kernel test robot <lkp@intel.com>
References: <20230726113605.13966-1-andre.werner@systec-electronic.com>
 <11620112-ffe4-8df1-6b38-0f3082c5d16f@linaro.org>
In-Reply-To: <11620112-ffe4-8df1-6b38-0f3082c5d16f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 14:20, Krzysztof Kozlowski wrote:
> On 26/07/2023 13:36, werneazc@gmail.com wrote:
>> From: Andre Werner <andre.werner@systec-electronic.com>
>>
>> Delete unused variable in drivers probe function.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202307261819.VMDuxZOM-lkp@intel.com/
>>
> No blank lines between the tags.
> 
>> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> 
> Was the original patch actually merged? I don't see it in next.

Ah, I see Guenter's response.

Best regards,
Krzysztof

