Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57D37CF873
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjJSMLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjJSMLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:11:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597C010D5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:10:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b201a93c9cso5373995b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697717457; x=1698322257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7TOTIKoWImuAkDVVYCBVqPy3Cdis5b4Vo38tYuQrdI=;
        b=d8UyzsFmlR5wEaODr/yL3J9LGIQEMJWnmNN2KVJDKAwmTsS7vPJqW6T2Pb/TpU/4oN
         eDm1JO7Ypv6w7iBPbWFmEXK7erhcKYeXH1vUvJGEBxxW/uqCdbSQmDNjifIhsRf4BmxH
         fSJdkTYfCF1qN9E6Hmkj4aQ7k1BcjP0i/X4Q7U4Ia7IU1H5eZ/gFzrhZAeHDBIqJMHh6
         ddqy4kEaDYHgInK1QKQwXA9NqlxJaNUH5rOKo6q8VdboUeWJn+p6QYW7FOA55ygVM6+Y
         szzglpOeHpVauLc8I2+wDUZrbOQTkLmJd69MqsdoFQz01Q7WBSLJ9g3zvkxbeAYrbmzE
         Ru3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697717457; x=1698322257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7TOTIKoWImuAkDVVYCBVqPy3Cdis5b4Vo38tYuQrdI=;
        b=T398XVt84RKJo2CCK4h2EnxkocJVHppe1JEv6fa97HVSLPfv9XEsfZW9vZx+OThSFD
         +hAFbagV/9P9ckxHEit2pDjI5Q8U0LCUzgEOINHHUK6YYNObDwgHCw+SonerdaJlwueC
         tSR0VijHvQT3O7bHxjeJ5Nn76ZCr8/SJdlOAfR2WubKt0pt/K2uZtHctlzD1woj1v43u
         cRHi3qwX5k9upp4HcBGZi0CROHPkV9ZVufc8Ha+0S6R9eN2bGYv0/EgY6TWqpbzZYKiW
         cjpNMx+FSHkiiUwqRlvTk6g67Emb8UFzfVqmupatCm5mlAGjYtVhtEif597Vy6J0Mkdf
         VQ8w==
X-Gm-Message-State: AOJu0Yxcq2lcF4maj+08pfYX6EIx9lD8XGoQSYGpdncfxY3AYhZbF2pS
        T9zQe7EasTVZd25UtVHUkhyNLw==
X-Google-Smtp-Source: AGHT+IGyjJ5achfYpuzb0OcmwqIHdD90ognp6JgCUWc4UnEvDk50gbaB0ggnIRhz4omdqkMNYXqe2Q==
X-Received: by 2002:a05:6a21:3e0d:b0:17a:dc55:4dc4 with SMTP id bk13-20020a056a213e0d00b0017adc554dc4mr1725217pzc.26.1697717457492;
        Thu, 19 Oct 2023 05:10:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:43ac:2324:cc6e:9fa5? (2403-580d-82f4-0-43ac-2324-cc6e-9fa5.ip6.aussiebb.net. [2403:580d:82f4:0:43ac:2324:cc6e:9fa5])
        by smtp.gmail.com with ESMTPSA id a186-20020a6390c3000000b005898a3619c7sm3262535pge.48.2023.10.19.05.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 05:10:56 -0700 (PDT)
Message-ID: <5a7d1ff3-8ac4-cdd1-028a-84b9fc240201@tweaklogic.com>
Date:   Thu, 19 Oct 2023 22:40:50 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
 <20231019-rematch-ethically-9d482ca4607e@spud>
 <6b856b0d-4f69-70ac-59a7-237fd21d1a92@tweaklogic.com>
 <20231019-hurry-eagle-0ffa95b1a026@spud>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231019-hurry-eagle-0ffa95b1a026@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Sorry, I should have put a longer description and a longer commit message.
>> That patch series adds a new driver - apds9306 which is separate to this
>> patch. As per Krzysztof's comments, first operation is to merge the existing
>> apds9300 and apds9960 schemas. This patch is the first operation.
>>
>> Second operation will be to add apds9306 support on top of that. I will
>> explain more on Krzysztof's comments. Thank you for reviewing.
> 
> Ahh apologies then. The best course of action would likely be to include
> the patch merging the two bindings in your series adding the third user.
No worries. Sure. You can reject this patch then. I will add my changes in the
main apds9306 patch series.

Regards,
Subhajit Ghosh
