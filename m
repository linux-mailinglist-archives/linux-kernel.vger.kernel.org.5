Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD1C7B83E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbjJDPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242943AbjJDPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:42:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E37DC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:42:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so4369081a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696434165; x=1697038965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8DE4zdD720w+nB08pMGoCZE7Ip3totgPMtAuz9kdkA=;
        b=FMpxquoC/7ve68H/pc7pu4nCLxEmQbpC+ompMs/0shkW9aIEXbz8Jj/sxoEjQJ++jv
         8qT8Jh9FwyLN9GFXkYN/Vra/aPh/Vg+8oyBABfXfHuKgTsDglfr45mseWKz09p2Zg4zf
         Q8se59aAI8Cd9Nl4x0MQrlL/h6xYRI4PHIYg2wc5zNk41cUwBkK913q5kqgyfe1JUYc0
         rGczJl/iKBRVhvx2Y25YG/g52CMC3RvERtpTgZiBCpLrXEGTPYE0IDVq1HXekFLje3mt
         g3Gm5vD1PWKtfTLlZoMWPHXBzKHut9QT+sK2vYmFkVoCgEtW32jRIVe5LbIhIfgu/zO7
         Revw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434165; x=1697038965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8DE4zdD720w+nB08pMGoCZE7Ip3totgPMtAuz9kdkA=;
        b=PsBx5ojHNDPVHbAqqz3Hx8B/p1XyQi0yrIJNnppsiUvy0ZEyP8YhnQ5ofbarHIIKWc
         EjoNCf+R/ooScIvG8yya7w197zjFGPIw30HGtz8PLs4BOdleLtuQXHA8esaQZg7a8BAj
         OOYy3jaTKLABPXUjqRoMRVP2q2MfYOCKxg8rz7pMn/F1JyGjrL7HdBZxPnXqKdlWt8qz
         0BT2zb2MQNMgY7Ibj1pz2KfllDz9HjJuZPtpG5/f42cahVHgHnYlxINnExvhixxZn1J8
         f0viW40SOLsrZ8MiBW3XfIWCOKCXWpg/deu45RObMaiENP4aoyB9+rkVhdh28tzbOF96
         C8jA==
X-Gm-Message-State: AOJu0YwmGlQSDieFLdYOp8Bg36QraW3oGJfixr/XithCY6MV+S3sUtxU
        ONeD4Bze8R6tDty8GQilqoLzvQ==
X-Google-Smtp-Source: AGHT+IHt6QCS+6KicgQ/3XQlI9b6uoZ8ZLkTSXrjbJDaqgf7w6rFT9LS21HbHEM6uq7eRWvzIT6+Mg==
X-Received: by 2002:a17:906:9a:b0:9b2:b149:b818 with SMTP id 26-20020a170906009a00b009b2b149b818mr2484723ejc.70.1696434165478;
        Wed, 04 Oct 2023 08:42:45 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906594500b009ae6a6451fdsm3005126ejr.35.2023.10.04.08.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:42:45 -0700 (PDT)
Message-ID: <60d3847b-0a6d-4858-b43a-c88a623fb09f@linaro.org>
Date:   Wed, 4 Oct 2023 17:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: altera: convert socfpga-system.txt to
 yaml
Content-Language: en-US
To:     "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231004030723.11082-1-niravkumar.l.rabara@intel.com>
 <43b158b2-6958-4a2f-8b2d-c6f7d3b39dfb@linaro.org>
 <BL3PR11MB6532D84A9844761292995EDFA2CBA@BL3PR11MB6532.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <BL3PR11MB6532D84A9844761292995EDFA2CBA@BL3PR11MB6532.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 12:32, Rabara, Niravkumar L wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, October 4, 2023 2:46 PM
>> To: Rabara, Niravkumar L <niravkumar.l.rabara@intel.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>;
>> Conor Dooley <conor+dt@kernel.org>; Dinh Nguyen <dinguyen@kernel.org>
>> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] dt-bindings: arm: altera: convert socfpga-system.txt to yaml
>>
>> On 04/10/2023 05:07, niravkumar.l.rabara@intel.com wrote:
>>> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>>
>>> Convert socfpga-system.txt to altr,sys-mgr.yaml.
>>>
>>> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>> ---
>>>  .../bindings/arm/altera/altr,sys-mgr.yaml     | 50 +++++++++++++++++++
>>>  .../bindings/arm/altera/socfpga-system.txt    | 25 ----------
>>>  2 files changed, 50 insertions(+), 25 deletions(-)  create mode
>>> 100644 Documentation/devicetree/bindings/arm/altera/altr,sys-mgr.yaml
>>
>> arm is only for top-level. What is this this device about? FPGA? SoC?
> 
> This is for Altera SoCFPGA System Manager registers, common binding file
> for ARM and ARM64 platforms. 

So SoC part?

> Should I use  "altr,socfpga-sys-mgr.yaml" as per the naming conventions? 
> 
> Do you also suggest to move this yaml to different folder instead of 
> " Documentation/devicetree/bindings/arm/altera arm/altera/" ?

I am suggesting to move it to soc.


Best regards,
Krzysztof

