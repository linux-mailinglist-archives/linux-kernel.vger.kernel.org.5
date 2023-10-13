Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088C87C88AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjJMP3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJMP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:29:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A213EB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:29:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40572aeb673so23585755e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697210976; x=1697815776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUCYxw5J6iwor6975fGrE/EZkSZ8o+5o0K3BHCF8RKo=;
        b=FSIYIRMxTZLqbq5fonVOUhxKKjytUYRG2UmFL4rY/EGaokz/b+6OnUZJrCk6AI9Yil
         ccyiwByAyHv+7S6j01b4Mhyf1gK2hvxKKbaV90HjmrP9fMFQpZ5Er9CBRSSL1IOxCWOg
         5sXDvz7m4CgE6XO5/RLVgKHU/NVhD8kfWT/QM1xxtsT3nqdWPLteHCnVEinSw6svt9Ia
         Q1WNeTuWuUEYWWccrJ5F/YCRDrk5Cy8YeQk9uFOCbiO/gz8Assn72dBq9f8sdTZyKhz+
         7QN9SS7rtbdfautmottATWdxlDaQPVd8Y/D4RwvpVqjbiGlDu4sG92ClVC1c5MRgO8Wv
         xkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210976; x=1697815776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUCYxw5J6iwor6975fGrE/EZkSZ8o+5o0K3BHCF8RKo=;
        b=gF5QGytzD/GspPCuDOkO09bq1E9gmcDbICOS6yTgbHuf4zN/i/jXagg1qRRZWw8b8n
         W5P+wLgZq75rf332vBa+paCfoaP271YKe1W1zwMg0JFswHXT+q3E6apN82jv+hWIAuNG
         doj1BVpUMiRSQ49IvLGApf6Y/h8izmgQqUZFWtoqeSLovyZDlRan3srP6dmm0O47Ytn4
         qVD+wLk2PeWTDL0APbXjIoGlRv9hTC9yGtDpNZOXyGCiJxnbVsC5B0QD22aelqMyR6mb
         LzHSsib2Z1tQO8jSZMTBY66Elpyi5sG/4mx4mBgtoTl8Au8ynnRiBJS93JKXUZlVeWC7
         mRhg==
X-Gm-Message-State: AOJu0YwsoGdFS91rQ4G632iy5KNPdBJ2ns86Oj3jBuLfK7KGqelF8LKo
        //JNbR/jr83dzlyL99OkeTPaljgMCqVuUWDxRfM=
X-Google-Smtp-Source: AGHT+IHfnbxeEfnJe9k7JJ9FJHh2hq6k+1Ef90cuy5HNEau4LWaTe6txpAvuK/fqLI1OT5CBtPuQcw==
X-Received: by 2002:a05:600c:290:b0:406:177e:5df7 with SMTP id 16-20020a05600c029000b00406177e5df7mr23603764wmk.29.1697210976070;
        Fri, 13 Oct 2023 08:29:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b004060f0a0fd5sm435559wmq.13.2023.10.13.08.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:29:35 -0700 (PDT)
Message-ID: <6fa74ee3-a2ef-4d76-964f-51249f53cbaa@linaro.org>
Date:   Fri, 13 Oct 2023 17:29:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: w1: Add YAML DT Schema for AMD w1 master
 and MAINTAINERS entry
Content-Language: en-US
To:     Kris Chaplin <kris.chaplin@amd.com>,
        Conor Dooley <conor@kernel.org>
Cc:     thomas.delev@amd.com, michal.simek@amd.com, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@amd.com
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-2-kris.chaplin@amd.com>
 <f864dd17-7848-4a83-bd8b-2093d11a153a@linaro.org>
 <20231013-january-caliber-2e7acbee15ec@spud>
 <c58fbddb-cda1-e0de-8ad9-e4701c2c73cb@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c58fbddb-cda1-e0de-8ad9-e4701c2c73cb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 17:23, Kris Chaplin wrote:
> 
> On 13/10/2023 16:07, Conor Dooley wrote:
>> On Fri, Oct 13, 2023 at 05:04:32PM +0200, Krzysztof Kozlowski wrote:
>>>
>>> That's a quite generic compatible. axi is ARM term, 1-wire is the name
>>> of the bus and master is the role. Concatenating three common words does
>>> not create unique device name. Compatibles are supposed to be specific
>>> and this is really relaxed. Anything can be over AXI, everything in
>>> 1wire is 1wire and every master device is a master.
>> Given the vendor (and the title of the binding) this is almost certainly
>> an FPGA IP core, so the generic name is understandable. Using the exact
>> name of the IP in the AMD/Xilinx catalog probably is the best choice?
> 
> Indeed this is an Programmable Logic IP core - the official name of the 
> core in our catalog is axi_1wire_master.  It is a soft HDL core.

AMD product managers are highly skilled in naming things. Sigh.

Go ahead with AXI 1-wire master. Any future - from now to next 100 years
- product from AMD which will be different but sold under the same name,
thus creating conflict in compatible naming, should be rejected because
of that conflict or renamed to something else. If that happen I will
propose a name like "banana-wire".

Best regards,
Krzysztof

