Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1426275916D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGSJUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjGSJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:20:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103BAE75
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:20:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52166c7f77cso7980442a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689758446; x=1692350446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjy/zInodwF90mdzVXilFr3NozHNXzuS79ZDMdnFQX8=;
        b=i60Aoe6sKlbaJHj69t8McRqXSs3vrTLBic75AAkoxvunUJCfshvocoWFEHsGRbokJq
         mU1gBlWkbkqVWHO8s74rpAEvgvPLdCmJP1AKQKNlRG+qP/wo/HJCl4coS8BvfUcbRBBo
         9Z07l1/JUXltef/DT4FqWg07hsiJa7UhQvbmfLrMgUPMrmXtPrOnYByV+S3Zr3IOR1lZ
         vWOkQ4aDmEvD06DnFbaRHglU4D7TD8PhQ16ahw2GX6JcQWHbbqPMgIqB7IIbD7c4mnEb
         Tn5RP1JL7u42IUn7YuYi+MIt/luZFQsA7T1YYsdTRZcBG989WMjSLa38N5esko7O+dp2
         pVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758446; x=1692350446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjy/zInodwF90mdzVXilFr3NozHNXzuS79ZDMdnFQX8=;
        b=jCEg8pcP09QRgyJv7iPqDhEeA0xEkpkmWcaLdKhJ2cFOFn87Tg+dbIJrxRRq1xx7ZB
         81OFMb5ue1ivZySK3yI+Da9RysYYdgOI9z7pcPcAdd5em478nw993+7UwgSTfjJgMsip
         ENS4vevpkGs8+Z6Y6/IVzGnLDhUJqsLpv0NT0IjleCjrExE4jQGH/unvR1Lv7jge+rYb
         vb1XXBPu37vXoMpm9Hw5SLEdSWYNogUPFdJiW7iHf6FPB/DkAKGlfMSJbRmXqvWh6cYX
         8EQA5+hhg1SellLXKI+dUaE644rlL2ILeymMeB6S0oW+NoUQ98+vRj9wVJEnm97nce0K
         GWVA==
X-Gm-Message-State: ABy/qLbighGnMgmdGRKr+6L9YZn/dB3f3XtpEbUIa+OPeHvSKQlqXitV
        JR2RbWUnfkO29UnOP3varyV84w==
X-Google-Smtp-Source: APBJJlE02NNgXcHWDwx2eOLlrlNdSXvDfll7mulXd4JytQ4YuPnk966r5PDOBQ03j0vWixrMvkCcOw==
X-Received: by 2002:aa7:c148:0:b0:51d:d3d4:d02f with SMTP id r8-20020aa7c148000000b0051dd3d4d02fmr2273113edp.8.1689758446473;
        Wed, 19 Jul 2023 02:20:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d1-20020a056402516100b00521a3d8474csm2431520ede.57.2023.07.19.02.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 02:20:46 -0700 (PDT)
Message-ID: <56ef499c-d47a-19a1-2542-5e8a7c86d510@linaro.org>
Date:   Wed, 19 Jul 2023 11:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] usb: dwc2: Add platform specific data for Intel
 Stratix10 platform
Content-Language: en-US
To:     "Li, Meng" <Meng.Li@windriver.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230719025509.3007986-1-Meng.Li@windriver.com>
 <20230719025509.3007986-2-Meng.Li@windriver.com>
 <ec93a939-883d-5778-2f32-69eb370c9768@linaro.org>
 <PH0PR11MB519152C26157460397FA73E2F139A@PH0PR11MB5191.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB519152C26157460397FA73E2F139A@PH0PR11MB5191.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 11:10, Li, Meng wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, July 19, 2023 2:40 PM
>> To: Li, Meng <Meng.Li@windriver.com>; gregkh@linuxfoundation.org;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> dinguyen@kernel.org; hminas@synopsys.com; linux-usb@vger.kernel.org;
>> devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/3] usb: dwc2: Add platform specific data for Intel Stratix10
>> platform
>>
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender and
>> know the content is safe.
>>
>> On 19/07/2023 04:55, Meng Li wrote:
>>> Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
>>> the Stratix platform also does not support clock-gating. So, refer to
>>> commit 3d8d3504d233("usb: dwc2: Add platform specific data for Intel's
>>> Agilex"), add platform specific data for Intel Stratix10 platform.
>>>
>>> Signed-off-by: Meng Li <Meng.Li@windriver.com>
>>> ---
>>>  drivers/usb/dwc2/params.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
>>> index 8eab5f38b110..3d085ae1ecd8 100644
>>> --- a/drivers/usb/dwc2/params.c
>>> +++ b/drivers/usb/dwc2/params.c
>>> @@ -267,6 +267,8 @@ const struct of_device_id dwc2_of_match_table[] = {
>>>         .data = dwc2_set_stm32mp15_hsotg_params },
>>>       { .compatible = "intel,socfpga-agilex-hsotg",
>>>         .data = dwc2_set_socfpga_agilex_params },
>>> +     { .compatible = "intel,socfpga-stratix10-hsotg",
>>> +       .data = dwc2_set_socfpga_agilex_params },
>>
>> NAK. I already wrote why.
> 
> If I don't add the SoC specific compatible entry, how I use to the specific data on Stratix10 platform.

You do not have match data specific to Stratix10. I explained already
that I expect them to be compatible. I gave you example how it is done.
What is unclear in that example?

> If you think the new SoC specific compatible entry is not necessary, the patch2 also has issue.


Best regards,
Krzysztof

