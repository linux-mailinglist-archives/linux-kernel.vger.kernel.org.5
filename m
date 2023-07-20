Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC375A9A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGTI4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGTIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:40:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2AC26BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:40:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so775007e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689842425; x=1692434425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ny1C6PeLQpN5ZLbijkdZaNqiK2k79yucQLdYgkrn53U=;
        b=aFBG0SYMD/IRe3XLlCKozpprl92+XqJcF2MAka/KfMjKDReuzkcmJ2uf/ECoz8UlWn
         4GK+/CelbnGjXhzyDqEYftoxP3JMTFm+GgKtfzA9uMq0mnkrzOLHjSSlCQ9V0pldYE2C
         s4wANbiQ/hPAcT3bPHPmjAnviob6L3a11ysiSWojTbcX+DdXNInwqSAcTLO4psSrej9c
         LkgtWKbcByQBqhcvLv8onn8g7DmEuSludNW870ExIa80eXkmDB7rOqNP0NobZkyz7OGB
         WO1zzncZxcXb8HIYdAI+OOqfGtgmejvOnwzghYrBQJPDSWEGhgbMoCfs0SXTLI5O5QB9
         Bjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689842425; x=1692434425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny1C6PeLQpN5ZLbijkdZaNqiK2k79yucQLdYgkrn53U=;
        b=i4YBrHW757FD4nAnUwiOBa5JFHKX3yVStAAbdNz9CAwQgco8ERtBKxrpLYrH4hmoo+
         q70iqOT7v9TYgSOVQu0b4ZEXUPMpS5QvLPG577s0h0QERf9fJ+Q39hL8p9krzZg72kM9
         6LU3pmaKoMrUPOpRrG+dg1dX04ut0ME1YAD1NDUdlb96+bNLoY/AIfHELo7KMTFcPrdS
         uI21e7tMfRiK6YHVP37Bi52jViEu/g2GbLVjQHeIqfshRGifbcbS2qrnqP2xYraZPhYD
         5HTJbCiHr8Y/XvoJOLAd23rcdymbXN/rREzhHPMPVRVhqJWItpcq5AZh5caxulTznuYY
         mD4A==
X-Gm-Message-State: ABy/qLb/pqz0QFPpepz6/zdlCUPfQVSOEh5z2ofr4+NWlBciBDi7uXVm
        X0gfJ3rnTFjpsg4PRuhHe/AwWA==
X-Google-Smtp-Source: APBJJlHQ0Qhh09L6OiUWIqkMakxji1+KahYOK1XPSil7Jw6cbkGwy8gUKJ1qyNUV+O8YbLMJpY1rXA==
X-Received: by 2002:ac2:530e:0:b0:4fd:8976:5fc9 with SMTP id c14-20020ac2530e000000b004fd89765fc9mr1632271lfh.23.1689842424987;
        Thu, 20 Jul 2023 01:40:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bcd0e000000b003fc01f7b415sm3370111wmj.39.2023.07.20.01.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:40:24 -0700 (PDT)
Message-ID: <ca665afc-24af-4a9a-4bb1-a5421b2d6912@linaro.org>
Date:   Thu, 20 Jul 2023 10:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] Add support for PECI Nuvoton
Content-Language: en-US
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "avifishman70@gmail.com" <avifishman70@gmail.com>,
        "Fair, Benjamin" <benjaminfair@google.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "yuenn@google.com" <yuenn@google.com>,
        "venture@google.com" <venture@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20230719220853.1029316-1-iwona.winiarska@intel.com>
 <b0993a11-6589-2fcd-3487-2e6eb68e18e4@linaro.org>
 <9a400a1be13adb87002ae476839e235aea117060.camel@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9a400a1be13adb87002ae476839e235aea117060.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 10:00, Winiarska, Iwona wrote:
> On Thu, 2023-07-20 at 08:17 +0200, Krzysztof Kozlowski wrote:
>> On 20/07/2023 00:08, Iwona Winiarska wrote:
>>> Hi!
>>>
>>> The series adds support for PECI on Nuvoton-based BMC boards.
>>> It is based on patches that were sent by Tomer Maimon from
>>> Nuvoton [1].
>>> Similar to Aspeed driver, unused (as in, default values were used in
>>> all of the available DTS files) vendor-specific properties were
>>> removed.
>>> If there is a use-case for such properties, they can be added in
>>> a separate series.
>>>
>>> Thank you Tomer for testing this series on Nuvoton hardware.
>>>
>>> Thanks
>>> -Iwona
>>>
>>> [1]
>>> https://lore.kernel.org/openbmc/CAP6Zq1jnbQ8k9VEyf9WgVq5DRrEzf5V6kaYP30S7g9BV9jKtaQ@mail.gmail.com/
>>>
>>
>> This is not v1 but v3 or v4. Please provide proper changelog and versioning.
> 
> This is the first submission - also known as v1 :)
> Could you elaborate on why do you believe that this is v3 or v4?

I had such impression because I saw it:
https://lore.kernel.org/all/20230616193450.413366-2-iwona.winiarska@intel.com/
https://lore.kernel.org/all/20230628090404.234965-2-tmaimon77@gmail.com/

Best regards,
Krzysztof

