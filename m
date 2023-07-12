Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37E47510AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjGLSmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjGLSmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:42:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939B81993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:42:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-993a37b79e2so913282866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689187323; x=1691779323;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VbqSmbjxd319jc3pHxnfRfT+EF14Ir6yLeHR+Ky6zQ=;
        b=c4KeNxpUGgtLN1Sca+NB1c/2juC1nEZFZaY5AnB+CAsKREgk4LqoWp3zSmyJXc0TOC
         oPNsq5n0e7A2+I4kIGBLRASoKFQ8SFQhUjdxT3FQa8+wAPhpTz+pWZDKOqzG1WDvnZw8
         3ujBwIV2ZMUfZ8VyI5rVIKPVJ4NNqRO1jbED9CsTWu8dwu4y1tXi30qwb6vefwVAWo/k
         KIv9VSo7Bba6SbynW5PHaymLjfafabanBZzzW9DMGZlQlBtsRWpm+CNjuCsYBK075Frk
         IkEr4jvbO9LkIN92odv9iurgPzHZtZSZPh1R4kDqMZI65rddpvkvPiEnfCFCWiQUbUHo
         NiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689187323; x=1691779323;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VbqSmbjxd319jc3pHxnfRfT+EF14Ir6yLeHR+Ky6zQ=;
        b=T2/gMpJFFGEsAL0bJOi/wgiKEviedqjKbV4r1ypMkPNgQCoaUIcsitMoFDftosW/gD
         l1yI5C2oNVB+jxvPulIiCyzqBlpxa/rlmDl/EnUx/gSKFzzJx9n0Y7hOu/exyKfT/Jn9
         hka52jeo+twdPtGDW2Hkf/JGl1LDyLTh+u8SccyGuP4rrhcY/eBQMV8wsiPyby6XBS5G
         PJ4gdsncmJStuQFS+uLsEB2U0zVdZ5ilT2FnHUGU97wltK4hAhLrlCa+ppWC9P1xJWIX
         GvujE9nmx3hBFFwymLSb9rkDK7pavb9Ao2McPLMEt2QoLsOB3iBUzMBWFXcNKWkPyox7
         KMHg==
X-Gm-Message-State: ABy/qLaQBWeMumwPBQ9T+AOJRmVL69sx+BT1O9zmRmwM2mlx0EMkV5Qx
        iqpZU9XPsQ3FVWuU4tXajS11HA==
X-Google-Smtp-Source: APBJJlFXEcz3wlImRsK+1uA5uQWbCe/hQkTGM6SGBv1HGhN8yaC0By+YRqnQwD8/1/e2bUyMjNVfew==
X-Received: by 2002:a17:906:5291:b0:973:e5d9:d6ff with SMTP id c17-20020a170906529100b00973e5d9d6ffmr19468175ejm.66.1689187323009;
        Wed, 12 Jul 2023 11:42:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ss25-20020a170907039900b0098921e1b064sm2875113ejb.181.2023.07.12.11.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 11:42:02 -0700 (PDT)
Message-ID: <9dd411e0-6cc5-44c1-be56-ecb2ad809a9b@linaro.org>
Date:   Wed, 12 Jul 2023 20:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding
 doc
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
 <20230616181144.646500-2-pankaj.gupta@nxp.com>
 <a06dbb80-c9b2-3a57-cbc5-b18432b4029a@linaro.org>
 <PAXPR04MB8638D1504946559095E1CAB69530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB8638D1504946559095E1CAB69530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 19:52, Pankaj Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, June 16, 2023 6:51 PM
>> To: Pankaj Gupta <pankaj.gupta@nxp.com>; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Gaurav
>> Jain <gaurav.jain@nxp.com>; linux-kernel@vger.kernel.org; Daniel Baluta
>> <daniel.baluta@nxp.com>
>> Subject: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding doc
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 16/06/2023 20:11, Pankaj Gupta wrote:
>>> The NXP i.MX Message Unit enables two processing elements to
>>> communicate & co-ordinate with each other. This driver is used to
>>> communicate between Application Core and NXP HSM IPs like NXP
>> EdgeLock
>>> Enclave etc.
>>> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
>>>
>>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>>
>> I don't see reply to Daniel's concerns.
>>
>> I don't see improvements here based on the previous review you received.
>> It seems you just ignored everything, right?
> Replied to Daniel's concern.
> 
>>
>> Limited review follows up because binding is not in the shape for upstream.
>> Do some internal reviews prior sending it.
> Done the internal review.

I doubt. Your v4 bindings and DTS were not tested. v4 Driver has trivial
issues.

Best regards,
Krzysztof

