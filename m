Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171CC755B37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGQGKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQGKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:10:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188291A2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:10:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so5412960a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689574228; x=1692166228;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boNA5wbGopnlpd9Kq61Pyfllqt47KC3kQNIa8Y9Qhbw=;
        b=cxVTADGFGfsIaFcmhBNR4X7yWGVyZr/OPvn5luZQsCbYuaQN33s81RqC0NSByC7gCO
         En/jvYs/Xy+wOYXENRwgckeiayt2SzljXsJgvGtPWN9e8//+qmwmJtfl+0zPCmEJl7VL
         DZvWLJWg6aAOwjRYBEu5sNQZhAEBkrd+ruiLdMW1QNT6Cc8/9f3NLCW98vTlH4o0STJN
         R7tPU9lvoLGMskO1AEjIN7hoVDuRgRPJtryoJWmu2pfLSzNtAtKetI0sT6LAyXxdhY7p
         RTQT7vipe3QMn97U8WaIqWa0V6WEnuZW73xkn5PGwVcg+hz3CENRkkAzNBLxk7Mv4Quu
         +rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689574228; x=1692166228;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boNA5wbGopnlpd9Kq61Pyfllqt47KC3kQNIa8Y9Qhbw=;
        b=V+BSzawwY/QP9/YGw6oftioaaXWr+FCKgc/sS9+AJNq+Zf44JUozIN3RZZQ8L8pZgs
         JI+Dzs43+ppTaWKLGLhM+2AQ8zraGg26KwebdgJGVgE2F+CyXA37enY9DRPGUXIZ+htA
         GBHQSZfUQ3JXwQAAn8Q/5VVpDDVpL4PB3tenVoefQXK0Cgq7i0mzWRAUOcl1XwZjbXjQ
         O3RaW5V9lgQYePMBQ+8ZLP9MZu/4qMAtuvAGcuOaUGw9dNWFvbqsE6uenVLTm4PymksW
         XgjR9UFpcJtj4Et7T5NCkHS4XsxZuziVO/cTQnEXCsh26OmbvsohT75v3or8xzIPcr1U
         SU3w==
X-Gm-Message-State: ABy/qLZl3RBY56PMKE285Mw2bkbV1wxgFNZD8AyYAozSUxXI9r0Muc7W
        YUBsTUkTWvsaDMBQaIwRjYXoyQ==
X-Google-Smtp-Source: APBJJlEDCx2r1wT4va1S4F70boZGfjKHEuUyXmLqtNoeOWWwMVhlru2lP+L+CcFCUE+A302DVcq0wA==
X-Received: by 2002:aa7:c60d:0:b0:51d:9195:400f with SMTP id h13-20020aa7c60d000000b0051d9195400fmr10622163edq.17.1689574228594;
        Sun, 16 Jul 2023 23:10:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa7d992000000b0050bc4eb9846sm9530357eds.1.2023.07.16.23.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 23:10:28 -0700 (PDT)
Message-ID: <b0b8f7c5-0b6b-3a75-d894-752997bd387d@linaro.org>
Date:   Mon, 17 Jul 2023 08:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] dt-bindings: net: davicom,dm9000: convert to DT
 schema
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
 <20230713152848.82752-4-krzysztof.kozlowski@linaro.org>
 <b5647c230e4e2c473dc0ed66390301fafa561911.camel@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b5647c230e4e2c473dc0ed66390301fafa561911.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
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

On 14/07/2023 17:27, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> Le jeudi 13 juillet 2023 à 17:28 +0200, Krzysztof Kozlowski a écrit :
>> Convert the Davicom DM9000 Fast Ethernet Controller bindings to DT
>> schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/net/davicom,dm9000.yaml          | 59
>> +++++++++++++++++++
>>  .../bindings/net/davicom-dm9000.txt           | 27 ---------
>>  2 files changed, 59 insertions(+), 27 deletions(-)
>>  create mode 100644
>> Documentation/devicetree/bindings/net/davicom,dm9000.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/net/davicom-
>> dm9000.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/net/davicom,dm9000.yaml
>> b/Documentation/devicetree/bindings/net/davicom,dm9000.yaml
>> new file mode 100644
>> index 000000000000..66a7c6eec767
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/davicom,dm9000.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/davicom,dm9000.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Davicom DM9000 Fast Ethernet Controller
>> +
>> +maintainers:
>> +  - Paul Cercueil <paul@crapouillou.net>
> 
> Did you decide that by yourself? :)
> 
> I do have one of these on my MIPS CI20 board, so I'm fine with
> maintaining it - but a head's up would have been nice.

Ah, apologies, I am really sorry. I remember to write a note that
maintainer is needed and many you can be one, but then eventually I
forgot and sent it as is.  :(

Best regards,
Krzysztof

