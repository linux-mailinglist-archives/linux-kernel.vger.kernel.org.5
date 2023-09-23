Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35167AC1A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjIWMDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjIWMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:03:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B031AD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 05:03:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5041cc983f9so5765510e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 05:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695470587; x=1696075387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f55qP7nCVYbXurKDZckzIAMBIRtqowALRh+W0NZh5Nc=;
        b=zbmwnZLmbWrAjWaROPIfiAa8xavQ9/OM6jfWAqBDe1xbJZK4GleV5bSmf4J1NmIl+r
         Y2mFCyJZ8bJ59SE5jbKCwhzB5vwBVQGzJtDQRAR2MhDBjepMPCdplsQicBonxVdeDMK6
         dJB9Fuh9wRUTpRfFTX7nIef4S9pb4HDkUu1aEB9g7hcew1nWVbwmADMEjeMNNzjeNldq
         9js6h7L4i+QhqjgdOc8WZses/xySWMfi9qPX0+N1wJInD246wM4GwuzTiv+iE0jzS2/D
         DXhUJc8mH/SajaShSfy3l1IFtNPBwjG6Deeo7tu6FgtsqzQMsVxbTTnjDOWOQwWo2cyU
         7Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695470587; x=1696075387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f55qP7nCVYbXurKDZckzIAMBIRtqowALRh+W0NZh5Nc=;
        b=Z2dkAX9yUWuE155//JXt9tOfGm6h+ZcNv8Mv9rUNBdqvs2NxO65cI0F68yvG5+M7P2
         dzuC/Txj/db6jzRz29SlAYRGnzsMI5UgCo3Ff3qUdxc1OZDiYpStLlJ6SpSNUNQLjCj1
         VwatXCl4QRWeOF6HG4q1KJ2WFAm+ndkZcXk8fWAi6pAaCuIFGsMEBdsVNK2D1Jzu+P0o
         eBMKbNQg0VprxuRkWA6yQ51etbEZ2KQrGMj+8ygwlKhlsCF0XSCr7olcjAaIairrHMG2
         lvARgAN6Zw7+ybKM0135vaWOu3GmTN4ippnJLoozUaj/Q8xEt3yyMqruRtLqc7Yljj5N
         hBuw==
X-Gm-Message-State: AOJu0YxfdJ+hyULpePpB1PbHwGsNpd3sCnkV0/BksBbLAbZhh6Yv7KxR
        G/WuW2FZV+Pdkywhja38Pk/3tg==
X-Google-Smtp-Source: AGHT+IFMHyw3oyV/wPERpsJHswm4pIY5M0fNziIV/0COuSfToqBWfJ3sEzb8zWNZJEh87HB5E+edrQ==
X-Received: by 2002:a05:6512:2812:b0:503:1913:ed8e with SMTP id cf18-20020a056512281200b005031913ed8emr1848786lfb.61.1695470586790;
        Sat, 23 Sep 2023 05:03:06 -0700 (PDT)
Received: from [192.168.1.110] (abyk237.neoplus.adsl.tpnet.pl. [83.9.30.237])
        by smtp.gmail.com with ESMTPSA id s6-20020a19ad46000000b004fe15a2f0f6sm1065533lfd.62.2023.09.23.05.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 05:03:06 -0700 (PDT)
Message-ID: <a26911e0-c77b-1eee-5f85-1491b83acd10@linaro.org>
Date:   Sat, 23 Sep 2023 14:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] Small style fixes in msm8974.dtsi
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
 <2899653.e9J7NaK4W3@z3ntu.xyz>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2899653.e9J7NaK4W3@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 18:59, Luca Weiss wrote:
> On Dienstag, 27. Juni 2023 21:45:12 CEST Luca Weiss wrote:
>> While making sure the nodes are sorted correctly, I also noticed that
>> some lines are wrongly indented. Fix both.
>>
>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>> ---
>> Luca Weiss (2):
>>        ARM: dts: qcom: msm8974: replace incorrect indentation in interconnect
>> ARM: dts: qcom: msm8974: sort nodes by reg
>>
>>   arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 80
>> ++++++++++++++++---------------- 1 file changed, 40 insertions(+), 40
>> deletions(-)
>> ---
>> base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
>> change-id: 20230627-msm8974-sort-e34b28f10a34
>>
>> Best regards,
> 
> Hi Bjorn,
> 
> also ping on this one. I didn't check again if it now conflicts with -next (as
> pointed out by Konrad a while ago), if it does let me know and I'll resend.
git fetch linux-next
git checkout linux-next/master
b4 shazam <msgid>

if retval == 0:
	ping
else
	resend

this only takes a couple seconds and saves you the burden of sending
an email and Bjorn of checking ^^

Konrad
