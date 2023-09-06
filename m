Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2007079338F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbjIFCKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjIFCKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:10:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93215DA;
        Tue,  5 Sep 2023 19:10:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2179793b3a.0;
        Tue, 05 Sep 2023 19:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693966204; x=1694571004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGpPqAvRxHlO49Def4EkEw3YsTe5pPmN/itzaU5IvZg=;
        b=jZhce/bQl5eve+4i50QYq5IpPBi7r7ycE2qy5MvJLyloCt/4c3Acauuw1aeS0Bg8D4
         Nz81BsCtKam1z6XeJUe4Tgz0soOf0S0fXqtlvA7Xycqz87vcvH/LqpC2khMSj7wk6nOs
         o7Ge3vN6o8RG5qJiRBYRIoYTnynDTAXsKOtvLVM7nIC8xdI0P4M04Jo6vpKpW0SYVIKD
         QF1SwOC3IEkC8rrAqD4OtfLpXdDbjpUR3cF2gJhHUxQX099up/5ALLp0OgrP1ISrMRF/
         R+uoDdmh5erqgawrBIl+L2LnDucGq9KCQu+qIRnzby2mBHEmK2SBd77WKbzJlAHiakfe
         K/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693966204; x=1694571004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGpPqAvRxHlO49Def4EkEw3YsTe5pPmN/itzaU5IvZg=;
        b=Jwjqe4JeoBZ4lYZLVNbY9H9KK6mqkWdULANIINYPa3GUeChKVZ3Xay39H0cLzIoh0c
         WiKUDTH/l3nbhZN8YHAR8kRiGDTZOJTdBqf2I/zenjvaZP+P9oxQyHi1HNHpCc0zGK4u
         s8gy0/FYA8k+zYOA5EeOIZ3W3u0WEFIY0ZLJ+2dcLeglD4WAHwItSDBAdvlsUB0fQ730
         JSjrwW3j7MZt5IHUh9EGm4T3ZRifTLVthmIFrq00B/QV5o9Q8qRllQdCGX5iWtYP4L8r
         ++nbYGfoAEO/bYu7xLbxhJUKp/rn37FSXqB2Kbk6xdeVGq+YyZbtI4h+dDt6TJPdR6qa
         xroQ==
X-Gm-Message-State: AOJu0YxSCtMruJ2hxsdnQFgw9PNQzKFXeDvhmrJHGWDMEc2IwyCSnI1h
        IlUSpt1cA8Mcg7dQ6LRAHAjTQr1Inx8x9Q==
X-Google-Smtp-Source: AGHT+IFHi8yS62mJScVTCGYXqkYmPO0vzOrPlYOFM6ccgBgCL/6i5bn5+f46O0/s+HcPNHrWgPjdeA==
X-Received: by 2002:a05:6a21:81a7:b0:14c:ee61:139a with SMTP id pd39-20020a056a2181a700b0014cee61139amr12186302pzb.27.1693966203870;
        Tue, 05 Sep 2023 19:10:03 -0700 (PDT)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001c3267ae314sm6532575pll.156.2023.09.05.19.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 19:10:03 -0700 (PDT)
Message-ID: <136c0434-a588-877e-54e5-dd1078ff94a3@gmail.com>
Date:   Wed, 6 Sep 2023 10:08:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     patrick@stwcx.xyz,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        peter.yin@quantatw.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
 <20230905062223.774871-3-peteryin.openbmc@gmail.com>
 <20230905181637.GA3742088-robh@kernel.org>
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <20230905181637.GA3742088-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/23 02:16, Rob Herring wrote:
> On Tue, Sep 05, 2023 at 02:22:22PM +0800, Peter Yin wrote:
>> Document the new compatibles used on Meta Minerva.
>>
>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>>
> You should not have blank lines between tags.
> Thanks your comment, I will fix it in next version.
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> index 68f717670f78..32582ee56264 100644
>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> @@ -79,6 +79,7 @@ properties:
>>                 - facebook,elbert-bmc
>>                 - facebook,fuji-bmc
>>                 - facebook,greatlakes-bmc
>> +              - facebook,minerva-bmc
>>                 - facebook,yosemite4-bmc
>>                 - ibm,everest-bmc
>>                 - ibm,rainier-bmc
>> -- 
>> 2.25.1
>>
