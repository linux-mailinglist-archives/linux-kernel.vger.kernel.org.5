Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D86763710
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjGZNHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGZNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:07:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC8F1FDA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:07:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so98659661fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690376823; x=1690981623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wsh3ywboypSR9IxavTMFwQ0boo9RTAm9WcxI76p9a0=;
        b=On8Lm3TQuDsqs6FLqYifzbrx1zVIb+8FK1Wv7zFU5QCkStu92wqu6+CMBrGHeYZW5c
         tAiUG+PXvQXlNbeHJWd6SkUYcCQAZAOoa/iZvt/sRsck7Vuw0Qh3ncJqqPePGuOUtLMT
         QhsxYyH6w3YUVSCdczi36mv0wzLS2nE5UNOcptd5nj2xpa3zZ8XQfAyz0/46BtgY+oQL
         zCZ6GHdSxSBp8LeqTifhQEDSM2kjcmn7EGM+zPhK21VyhmNCuQcYEim/+I98JnorxdOs
         oZ6Axsst7JUaUZx3Sgh6ff+BHpVawV0bsR5GVe47oLeHAd6hOT+d0hEae92AqxovWzeT
         xrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690376823; x=1690981623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wsh3ywboypSR9IxavTMFwQ0boo9RTAm9WcxI76p9a0=;
        b=JZjMh9QdSRrA9G00aC4KlaKxoV8dDThG0qAqgXtcFMOg9zUBcUdi4gBoA5GTBZbSCj
         DPhRrtari38L5aT+GKH+YrH7yGgkCyYb2H/iIDC25Tj+HVAF8g2GiODpC1EEUM4kxAwJ
         ute+gNIDBoSskMTDMYetewJd9X2R68SVRuikidxqnKzQxUKvefQD0+c7ZkFWXZNLOYSN
         RpvMg6OmVY148qou/pEOBWoRS3cDEDUGFHzeGB+EJftndFGmIxR/6aWgBG/GvxipPKsB
         2uzsNk/32ReGBsZG0dpLTynRrgyctIMYSInknVSF2mZLJRwPXfY1Hbtli/2Harhhfqso
         YUPA==
X-Gm-Message-State: ABy/qLbkReruaUxsALETgV6Lw2YRiVBnjYi+b7RmFVOLAcw/3ldqAmmC
        JIpo+4klmSK7LCwCiWI5uhFsQQ==
X-Google-Smtp-Source: APBJJlG98W5tRZK9vG8UqmQ9KZqEsLF80l499aQXx/tbGOR5Yk1+QO2D3mq3YniowdDSnIVOuAT7JQ==
X-Received: by 2002:a2e:95c6:0:b0:2b6:da88:a2d0 with SMTP id y6-20020a2e95c6000000b002b6da88a2d0mr1449694ljh.47.1690376822773;
        Wed, 26 Jul 2023 06:07:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r27-20020a17090638db00b009786c8249d6sm9661395ejd.175.2023.07.26.06.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:07:02 -0700 (PDT)
Message-ID: <33232e22-1014-2670-47f6-712b0acc929d@linaro.org>
Date:   Wed, 26 Jul 2023 15:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1] arm64: dts: qcom: sa8775p-ride: Remove min and max
 voltages for L8A
Content-Language: en-US
To:     "Naveen Kumar Goud Arepalli (QUIC)" <quic_narepall@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230725100007.14775-1-quic_narepall@quicinc.com>
 <a3l7356miuuapf5dakgfchdjmxjp62ynvle4ta3hejd3tjvzd4@e2t2zm6jh7hb>
 <516a54da44724001895f7e50634ad884@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <516a54da44724001895f7e50634ad884@quicinc.com>
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

On 26/07/2023 14:32, Naveen Kumar Goud Arepalli (QUIC) wrote:
> On Tue, Jul 25, 2023 at 03:30:07PM +0530, Naveen Kumar Goud Arepalli wrote:
>> L8A is the supply for UFS VCC, UFS specification allows different VCC 
>> configurations for UFS devices.
>> -UFS 2.x devices: 2.70V - 3.60V
>> -UFS 3.x devices: 2.40V - 2.70V
>>
>> As sa8775p-ride supports both ufs 2.x and ufs 3.x devices, remove 
>> min/max voltages for L8A regulator. Initial voltage of L8A will be set 
>> to 2.504v or 2.952v during PON depending on the UFS device type. On 
>> sa8775, UFS is the only client in Linux for L8A and this regulator 
>> will be voted only for enabling/disabling.
>>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts 
>> b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>> index ed76680410b4..6f3891a09e59 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>> @@ -98,8 +98,6 @@
>>  
>>  		vreg_l8a: ldo8 {
>>  			regulator-name = "vreg_l8a";
>> -			regulator-min-microvolt = <2504000>;
>> -			regulator-max-microvolt = <3300000>;
>>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>  			regulator-allow-set-load;
>>  			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> --
>> 2.17.1
>>
> 
> Reviewing with very little expertise in the area....
> A few questions below that would help me understand this a bit better.
> 
> Does it make sense to *not* set the range of the regulator at all?:
>>>> Yes, we are removing the range of the regulator.
> 
>     1. A board dts knows its UFS device
>     2. Is UFS backwards compatible with respect to UFS2/UFS3?
>        I don't know how the version is determined, but if it's a
>        "start at UFS2, go to UFS3" should it be scaled as that goes?
>        >>>> For a UFS device 3.x, we cannot start as UFS 2.0. vcc has to be as per UFS 3.x recommendations.
> 
> Relying on the bootloader to set up the device before the kernel starts
> seems like a direction that should be actively avoided instead of
> depended on in my opinion.

I have trouble finding which part is your reply and which is quote of
Andrew. Please reconfigure your mail client.

>>>>> As per upstream UFS driver,  voltage voting is not there and we vote only for enable/disable . 
> Since UFS is the only client in Linux for this rail (L8A ), we don't need min and max range to support
> UFS 2.x and 3.x cards.

I would assume some reasonable range is always desired. Why it cannot be
the wider range from both? 2.4 - 3.6?

Best regards,
Krzysztof

