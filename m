Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB5C7C5227
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjJKLcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjJKLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:32:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AE7A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:32:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32167a4adaaso6095550f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697023946; x=1697628746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DsAOowwWi0mesEKoVHK/FxVP45knAnyTgl6rwq9d2Wk=;
        b=lUTrVc3rbmUmso8qs5tXp6uyqqbg3KlfOS0wTeIyOFfoVnEEiZIaLMI7yra6lV30I4
         LxgJlj1BRP0boHaeIDR/7qlF9Cl6rvK4Bq1/Yrb+Xuxfp220vyFolFqEBNub81spCKts
         M3/0p4DehkEG+AaWM2SmJYyVg3Ah3OQtdFA4RHF6g7I9Jsn0Y7Mwnz9U8NU/csw6TqBf
         BoYxYIO5Xl0MLRUgtmCzNBRmMptoKP5QuA8oIzNbXVDez2WuCPtEJOwWLH05CI2qWk9B
         eGPuzitegsVKH43ycpFtdTWDmQiGEYPk4jV4zRDQ3Wp4Y6wLdGU5Bve3aWlDpEfeOlTw
         BEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023946; x=1697628746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsAOowwWi0mesEKoVHK/FxVP45knAnyTgl6rwq9d2Wk=;
        b=j8Z19Esm5aScVELoShzEV4M25ponvMqnkqTVCgaRXVc11BX4QsWnvgNKR6ivu0IWVB
         zNy96bbxgOeuKTF1pAofJ35JbGsR6q3IO2dGBnIwUalAhGd2xFcsYmR7Bpc4cc4lv42/
         4e0i25Rfh+dMfRGBzrdLwIpqrL7RY3xnoWvAWXbYti5qeJdVc2UwmQGA/FMx7knYIl1Z
         vLTvAjibUgZey5CC9BHXP55OnH4ZLFFfecVS9jDR3nFdFBYK3UYiXmM46UV50RnQZuUW
         yAtl8CQK6XtLlWqbpU6ctfxMOEgf6Y66Se3jeVRhvfzsrmHs2F7/yE0QIj+I7T3JjFJ8
         6Q7A==
X-Gm-Message-State: AOJu0YwiP+O7AHEPreLVPjAPzzv9GgiQLbM83HxSeb8wFcqcOuPXTp0G
        NpOGk7TP56gZ6BUb5Q5lUL1rSw==
X-Google-Smtp-Source: AGHT+IFVqtSBtBksjGsb0ABOial+OCLDVVV8fSQM2KSkd89dHm4/o/uhzWuDJfp//dH7f49WpCFPpA==
X-Received: by 2002:adf:fc4c:0:b0:319:785a:fce0 with SMTP id e12-20020adffc4c000000b00319785afce0mr18564439wrs.26.1697023945994;
        Wed, 11 Oct 2023 04:32:25 -0700 (PDT)
Received: from [172.30.204.240] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n20-20020adf8b14000000b003296b62d413sm14830649wra.82.2023.10.11.04.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 04:32:25 -0700 (PDT)
Message-ID: <f97d167e-688e-428d-8463-5b315b9a9593@linaro.org>
Date:   Wed, 11 Oct 2023 13:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Jie Luo <quic_luoj@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20230923112105.18102-1-quic_luoj@quicinc.com>
 <20230923112105.18102-5-quic_luoj@quicinc.com>
 <10bcb0cc-19db-4914-bbc4-ef79c238a70d@linaro.org>
 <49c8a8ff-bdb9-a523-9587-d2a46d401e41@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <49c8a8ff-bdb9-a523-9587-d2a46d401e41@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 13:26, Jie Luo wrote:
> 
> 
> On 10/11/2023 6:25 PM, Bryan O'Donoghue wrote:
>> On 23/09/2023 12:21, Luo Jie wrote:
>>> The clock controller driver of qca8386/qca8084 is registered
>>> as the MDIO device, the hardware register is accessed by MDIO bus
>>> that is normally used to access general PHY device, which is
>>> different from the current existed qcom clock controller drivers
>>> using ioremap to access hardware clock registers.
>>
>> "nsscc-qca8k is accessed via an MDIO bus"
>>
>>> MDIO bus is common utilized by both qca8386/qca8084 and other
>>
>> commonly
>>
>>> PHY devices, so the mutex lock mdio_bus->mdio_lock should be
>>> used instead of using the mutex lock of remap.
>>>
>>> To access the hardware clock registers of qca8386/qca8084, there
>>> is special MDIO frame sequence(three MDIO read/write operations)
>>> need to be sent to device.
>>
>> "there is a special MDIO frame sequence"
>>
>> "which needs to be sent to the device"
> 
> I will update the comments, thanks Bryan.
> 
>>
>> the following indentation splat from checkpatch
>>
>> CHECK: Alignment should match open parenthesis
>> #2071: FILE: drivers/clk/qcom/nsscc-qca8k.c:2004:
>> +        ret = __mdiobus_write(bus, switch_phy_id, (reg | 
>> QCA8K_REG_DATA_UPPER_16_BITS),
>> +                upper_16_bits(val));
>>
>> CHECK: Alignment should match open parenthesis
>> #2131: FILE: drivers/clk/qcom/nsscc-qca8k.c:2064:
>> +static int qca8k_regmap_update_bits(void *context, unsigned int regaddr,
>> +        unsigned int mask, unsigned int value)
>>
>> total: 0 errors, 1 warnings, 2 checks, 2162 lines checked
>>
>> NOTE: For some of the reported defects, checkpatch may be able to
>>        mechanically convert to the typical style using --fix or 
>> --fix-inplace.
>>
>> 0004-clk-qcom-add-clock-controller-driver-for-qca8386-qca.patch has 
>> style problems, please review.
> 
> Thanks Bryan for the review. The code line mentioned by CHECK is more 
> than 100 columns, so i separate the lines.
Please read what checkpatch tells you.

It asks you to change

very_long_func_name(arg1, arg2,
	arg3);

to

very_long_func_name(arg1, arg2,
		    arg3);

(remember tab len is 8 for the linux kernel)

Konrad
