Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E87A1F28
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjIOMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjIOMtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:49:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E3A173A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:48:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502e6d632b6so3029584e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694782137; x=1695386937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5i0WGwPOIuosSgjTn5NrbismLE/MeEP0vSOG+InMUVA=;
        b=LvFg525FB/QfuY5vhy33TiqyyDhBt/2TKgKbc1iKkMy0+L6R3wEvbyt5pNm5u69EDN
         xHloB1yn9sug5WAro7+/T7JoP7Oew5cWoLNR97TFppyP7hSvCK1W0eaMGMSlcWeBtmLD
         2rVXbniF+vK2UqHif+KsYhrqMhFUpcmPEo753jAy1Lc4PY+ru0POg62h2EUP3S8bLUSQ
         Xw9JUK+Vb01f9pelvnosoO9xJQGek4JN++ecrm0b68dQ2/cATnwkLE/It06k6p8yjVp0
         AGYa4NFqJXjTFdsZjlwLEFGF5Vtm/ox3SydoM+8bThHxm3lb6TVNP37839ZA+goZW4C1
         Q1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782137; x=1695386937;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5i0WGwPOIuosSgjTn5NrbismLE/MeEP0vSOG+InMUVA=;
        b=lGAgE0uCSfh6I5W1FdfT90Xad2X1RKloL2amvPNsuPRD5ijew7StLGgIF9mXvBuufH
         B53/LQu0FLzei9FiVpFqKKwYl7YY1EEJnF07anemUQg2iW6uXV0on+U/+i3yBgYO8n8R
         7mXel3det8COxSfEcO4jYG5BMPSp8u6uYyiEmfHfcUpZSDqOoV7uTwyVNCqjz9xEDa3R
         rbs6G4y1LUlh4gVCavFvdYuG+GF9kavCxd4Cguc5amTqVzmBq8DQ0VmRbpddAlHU+8jl
         yDF4DABg7wXDKLkdJjKDNL2Vo4JVi+lJzCDVDfmLjD/nl/1bxBqvVXwAKqoGPmKFsDMs
         iGoA==
X-Gm-Message-State: AOJu0YxxkTsXQYCAJVZ6VvdkwFGL8ITIT0w02O616f8IjUnvE28Mth5m
        bPu0h+1nJKVQCi/B8QulAuKljQ==
X-Google-Smtp-Source: AGHT+IGLqRFaqXd/mEeemTxxlAfS7+KAgBxG+kIszP8FvxCKBQrtG90SO1rcF1jCVM1ECpsl1iBSJg==
X-Received: by 2002:a05:6512:252c:b0:500:ac0b:8d52 with SMTP id be44-20020a056512252c00b00500ac0b8d52mr1527805lfb.7.1694782133756;
        Fri, 15 Sep 2023 05:48:53 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b? ([2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b])
        by smtp.gmail.com with ESMTPSA id r17-20020ac25a51000000b004fbab80ecefsm633283lfn.145.2023.09.15.05.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 05:48:53 -0700 (PDT)
Message-ID: <b6e729ee-d63d-4167-925d-f3ec5e49ae75@linaro.org>
Date:   Fri, 15 Sep 2023 14:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
 <6055cd57-4de7-4b7e-a4f3-68a7de1aef28@linaro.org>
 <6225a132-4b7f-bbb4-e863-4e62b99dd79d@quicinc.com>
 <31823dc4-6f50-435b-9a20-66471209ec31@linaro.org>
 <d34242f8-6e21-1549-b87d-3db2e825b7d5@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <d34242f8-6e21-1549-b87d-3db2e825b7d5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2023 12:02, Can Guo wrote:
> 
> On 9/11/2023 5:46 PM, Konrad Dybcio wrote:
>> On 11.09.2023 11:42, Can Guo wrote:
>>> Hi Konrad,
>>>
>>> On 9/11/2023 5:17 PM, Konrad Dybcio wrote:
>>>> On 11.09.2023 07:59, Can Guo wrote:
>>>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
>>>>>
>>>>> Retrieve UFS device version from UFS host controller's spare register
>>>>> which is populated by bootloader, and use the UFS device version together
>>>>> with host controller's HW version to decide the proper power modes which
>>>>> should be used to configure the UFS PHY.
>>>> That sounds a bit fishy.. is there no bootloader-independent
>>>> solution to that? Can't we bring in the code that the bootloader
>>>> uses to determine these values?
>>>>
>>>> Konrad
>>>
>>> Agree, it is.
>>>
>>>
>>> All these complexities come from one request from PHY design team - power saving.
>>>
>>> And to achieve power saving, Qualcomm UFS developers are requested to use the
>>>
>>> lowest hanging PHY settings which can sustain the Max agreed HS Gear (btw host
>>>
>>> and UFS device) during UFS's lifecycle in High Level OS,  whereas the power saving
>>>
>>> request does not apply to bootloader, which works for only a few seconds during
>>>
>>> bootup. Hence, there is no such version detect code in bootloader -  it just uses the
>>>
>>> highest PHY settings to configure PHY, boot up UFS and put UFS device version in this
>>>
>>> register.
>> First of all, your email client seems to be inserting 2 newlines
>> instead of 1. If you're using thunderbird, you may want to edit:
>>
>> mail.identity.(default or your mail identity idx).default.compose_html
>>
>> to `false`
>>
>> and add that to your internal wiki page, as I see many @quic folks having
>> this issue.
>>
>>
>> Going back to the main topic, I don't think we understood each other.
>> The commit message states:
>>
>>
>> "Retrieve UFS device version from UFS host controller's spare register
>> which is populated by bootloader"
>>
>>
>> Which means the bootloader is able to somehow determine the value
>> that's in the spare register and write it there.
>>
>> I'm asking whether we can take the logic behind this value and
>> move it to Linux so that we don't depend on the bootloader to
>> guarantee it (e.g. Chrome or some other devices with more exotic
>> fw may not work this way).
>>
>>
>> Konrad
> 
> 
> There is no logic behind this value at all in bootloader, as I explained, after bootloader
> 
> initializes UFS, bootloader simply reads UFS's device version (the value you are referring)
> 
> and write it to the register. But in Linux kernel, we need (or want to know) this value
> 
> BEFORE we initialize UFS host controller (and UFS device).
Can't you just initialize the PHY at G4 or G5 unconditionally,
read back the required info and then decide based on that?

Konrad
