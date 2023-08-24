Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0778782B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbjHXSnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242916AbjHXSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:43:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD4170F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:43:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50098cc8967so176975e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692902588; x=1693507388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhjKefBKCRC+/owmV/hiYBIN6wU3GhkPU+/uLiid8fA=;
        b=t0hZepahLQFMnLH7qVeX+rfYGlgRPOOQADTSynJ8f/4Csf2w7ceb2m8YA1dNQ7T9SS
         9IbBLEowTSPypoTXa5HNiFXvdNAfMiVZy3XgxURQRamecDzEWGL9nxch7ULMKfgJ8pFt
         3+ii4udxYCMmY6yoxokW3rfOu4kUNzx1tzQdwi2AEUErvSwYxQJ3z61Zj5BqyrEo01px
         ihvlG8R6qre8JllcNlSxH82F4PzmR36bPYR5X/0jXyLV0R7LFqEAwePGxzzuB7W4KgHD
         6J0a/To4OIYi6fP5uMOD6I84AiBziPb3CqY2rjI1tnxVc6y5/UkqVv+zn3rOQERGuq4U
         /PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902588; x=1693507388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhjKefBKCRC+/owmV/hiYBIN6wU3GhkPU+/uLiid8fA=;
        b=TmPyh06uDSA5/WzPsgSDsZxp2uY0rlzVWErYtoJoMp/LnH0eSYnwOHSXCPmVOJePJa
         BdMQYzP96RFFMkQDmx9MOD3/NmpUzLW6d/sQiWIy+mhTkvg84nnSVDCViqW4JxnFMY+v
         jBNKN4llpA0fQBvvWGguc3Uk+HPzVFodEuGUUleATh2d84rY3iS4xlJypiUvZUZDHai3
         5bCTd689cpuBn9vz4kHJ5at5w0Wa+Vqd8PJYdoKsb3kM10PWkcmpQYr06U33Lbqux2JA
         zymcTiNhVg6WQDbM0g8Q+YoiQsovQfpLBHbpCqM/UUBF55C106Dp5CllKoFcagbEi5iF
         zjAA==
X-Gm-Message-State: AOJu0YxM8P55GYvpmX/tl6UMWQQTYACCdJNicypVvVcI+DEdfDQ82V9R
        WnuWQrY03bigJ5y7dS/O1BRg6g==
X-Google-Smtp-Source: AGHT+IEJmE2eCB7KS0sCNrctPm2u18Rv+ib/at04vzWZ+1rQlB90iVtX5m+f/8F8Lq4WvToGXoORDA==
X-Received: by 2002:a19:5f43:0:b0:4ff:70d2:4512 with SMTP id a3-20020a195f43000000b004ff70d24512mr9219024lfj.23.1692902587561;
        Thu, 24 Aug 2023 11:43:07 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7c74f000000b00522828d438csm54965eds.7.2023.08.24.11.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:43:07 -0700 (PDT)
Message-ID: <949e6b65-653b-7b9d-00de-3541b7579bdc@linaro.org>
Date:   Thu, 24 Aug 2023 20:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXT] Re: [PATCH v4 6/7] firmware: imx: add driver for NXP
 EdgeLock Enclave
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Cc:     kernel test robot <lkp@intel.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-7-pankaj.gupta@nxp.com>
 <e143fd58-5c2b-fdb6-96bf-57bbf799d76c@linaro.org>
 <DU2PR04MB86306BC4EAB6F8EF2F252F8F950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU2PR04MB86306BC4EAB6F8EF2F252F8F950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 14:36, Pankaj Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, July 13, 2023 12:27 AM
>> To: Pankaj Gupta <pankaj.gupta@nxp.com>; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; clin@suse.com;
>> conor+dt@kernel.org; pierre.gondois@arm.com; Jacky Bai
>> <ping.bai@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>; Wei Fang
>> <wei.fang@nxp.com>; Peng Fan <peng.fan@nxp.com>; Bough Chen
>> <haibo.chen@nxp.com>; festevam@gmail.com; dl-linux-imx <linux-
>> imx@nxp.com>; davem@davemloft.net; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
>> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Sahil Malhotra
>> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Varun
>> Sethi <V.Sethi@nxp.com>
>> Cc: kernel test robot <lkp@intel.com>
>> Subject: [EXT] Re: [PATCH v4 6/7] firmware: imx: add driver for NXP EdgeLock
>> Enclave
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 12/07/2023 14:12, Pankaj Gupta wrote:
>>> The Edgelock Enclave , is the secure enclave embedded in the SoC to
>>> support the features like HSM, SHE & V2X, using message based
>>> communication channel.
>>>
>>> ELE FW communicates on a dedicated MU with application core where
>>> kernel is running. It exists on specific i.MX processors. e.g.
>>> i.MX8ULP, i.MX93.
>>>
>>> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
>>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> What did the robot report? New driver?
> [Pankaj] reported printf format-specifier for size_t. 

That's not what you said here. You said robot reported the driver.

...

>>> +
>>> +     pr_info("Misc-devices on i.MX enclave MU is configured.\n");
>>
>> No silly probe success messages.
> [Accepted] Will removed in V5.

I still found more.

>>
>>
>>> +     return devm_of_platform_populate(dev);
>>
>> No. You do not have children. Just open your own binding and look there.
>>
>> This driver is in terrible shape and I asked to do some internal review in NXP.
>> Internal review should point such trivial comments but your changelog from
>> v1 tp v4 says nothing about it.
>>
>> So internal review did not happen. Don't use upstream as cheap reviewers for
>> poor quality code. Please work internally till it starts looking correct and all
>> automated tools pass. NXP is not some small, amateour company which can be
>> excused of this. Or is it?

I don't think much improved here... Still no coccinelle, probably no
other tools. You Cc-ed like 10 NXP people, for what? Did they provide
reviews?

Best regards,
Krzysztof

