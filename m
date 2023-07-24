Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216A175EC53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjGXHRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGXHRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:17:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C6190
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:17:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so8444032a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690183023; x=1690787823;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJeCwWsTZzA36Ct2WHsZleOWnEulDvesUCm+9RmBnlc=;
        b=VRhmyspr/uwOw7U5C+iqvVN8dDJGuOiYMYQF8fjXq05CRtkf+30RTsBhBHK0AUCafG
         mBK42bDn3VTPmfWZkymq29W32moXxgjCDAOgPIUgkLZQDvH5ZW39AAydKc32Vla6RJCY
         n5Ql/9mYZZ8uPqG8/bpaH1HQMo+1cmCuP1ckInSQUXlG7ef4S1m+rvLXekBhO2vOZ7gX
         E0IXF96gKmVDhccaq+YQfkFnV3OSb6NTMSgz35ZiKKH8IHwFSYBx7rEZBzUnfr2EnDiF
         fM52jOegNLTc708zAVIyvuDTeVwjr/B+2auojbzmf/1sNoC/JMBhTAsV8UMgG8UEz8j9
         wr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183023; x=1690787823;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJeCwWsTZzA36Ct2WHsZleOWnEulDvesUCm+9RmBnlc=;
        b=QxK5u1Kby+Sncx1DovtRXaxvgLVLvCEWMgLTw42gJpfZVsk2PpgR4Eb9AtD14HXmak
         tpLheFoTGjsG3eyDpKIpxajfquttjRB8dFBJrFPypIBJyo6P++WoPr53t/2RlEXHtfna
         uNRaBkpRme/Q/KmKBKc72k+IPyWlIKKNijEMGrSWTJKXx+I8gww9k8NG1zbyqdxsl8Yq
         ACu3yyOs3/TojDHy4sbtaNiOgMPuZlJamevF8BWU1O3jLPCD+fUu0BE/uX/HZeC2+aA6
         HOFSFamFqnCKRooIzqvUHOCRpl7txklKrDAllk+GIMPBsX9O1ZJqg/B5NVcdsXtBdMd1
         mYiQ==
X-Gm-Message-State: ABy/qLbx9j6Qb1S8e8Ew2JYVs5sZGJEE8POQUHA6/R/PF2ctIIA5cLfY
        o3/svZ8B+vbffnLEmqTmanfS7g==
X-Google-Smtp-Source: APBJJlGFysQs9dpzH5dvNmJw2OFgVyn3hSReFByLVNkWVJirJAy3bVofDekwJc5hBq+rtfZjDiTBDw==
X-Received: by 2002:a05:6402:752:b0:521:d2ab:e4df with SMTP id p18-20020a056402075200b00521d2abe4dfmr9094672edy.19.1690183023462;
        Mon, 24 Jul 2023 00:17:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7d3da000000b005222c160464sm1200954edr.72.2023.07.24.00.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 00:17:03 -0700 (PDT)
Message-ID: <8e9164fc-2276-e6b8-a4f6-c0c025bd6b86@linaro.org>
Date:   Mon, 24 Jul 2023 09:17:00 +0200
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
 <9dd411e0-6cc5-44c1-be56-ecb2ad809a9b@linaro.org>
 <DU2PR04MB86309B90B0849AFB23F6462F9502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU2PR04MB86309B90B0849AFB23F6462F9502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 08:37, Pankaj Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, July 13, 2023 12:12 AM
>> To: Pankaj Gupta <pankaj.gupta@nxp.com>; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Gaurav
>> Jain <gaurav.jain@nxp.com>; linux-kernel@vger.kernel.org; Daniel Baluta
>> <daniel.baluta@nxp.com>
>> Subject: Re: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding
>> doc
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 10/07/2023 19:52, Pankaj Gupta wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: Friday, June 16, 2023 6:51 PM
>>>> To: Pankaj Gupta <pankaj.gupta@nxp.com>; robh+dt@kernel.org;
>>>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>>>> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>>>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
>>>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>> Gaurav Jain <gaurav.jain@nxp.com>; linux-kernel@vger.kernel.org;
>>>> Daniel Baluta <daniel.baluta@nxp.com>
>>>> Subject: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu
>>>> binding doc
>>>>
>>>> Caution: This is an external email. Please take care when clicking
>>>> links or opening attachments. When in doubt, report the message using
>>>> the 'Report this email' button
>>>>
>>>>
>>>> On 16/06/2023 20:11, Pankaj Gupta wrote:
>>>>> The NXP i.MX Message Unit enables two processing elements to
>>>>> communicate & co-ordinate with each other. This driver is used to
>>>>> communicate between Application Core and NXP HSM IPs like NXP
>>>> EdgeLock
>>>>> Enclave etc.
>>>>> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
>>>>>
>>>>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>>>>
>>>> I don't see reply to Daniel's concerns.
>>>>
>>>> I don't see improvements here based on the previous review you received.
>>>> It seems you just ignored everything, right?
>>> Replied to Daniel's concern.
>>>
>>>>
>>>> Limited review follows up because binding is not in the shape for upstream.
>>>> Do some internal reviews prior sending it.
>>> Done the internal review.
>>
>> I doubt. Your v4 bindings and DTS were not tested. v4 Driver has trivial issues.
>>
> It is tested and my driver get probed. And all my functional tests are passing.
> No Patch-set is sent without testing.

As you explained there, you did not test the bindings nor DTS with
dtbs_check. So your test-suite is incomplete, it lacks basic testing.

Best regards,
Krzysztof

