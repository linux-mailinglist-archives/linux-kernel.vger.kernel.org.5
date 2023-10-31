Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2D7DC9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbjJaJbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343923AbjJaJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:31:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A6FA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:30:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so78327941fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698744657; x=1699349457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0Y2avDJsz7sXh0pdxQmO/TmfDGo4p5TSfw0Y5/rpSY=;
        b=Pkq6njkoCl5w3kltM+CUZvmbEaYXHKJdXmKwcucz6D94TsDvFYwHf/LlByF8Y6WlFL
         5Ki5QNkjjdX/LAje8BLLPSf1NrjyDTwYJHyt/NQK7mk14iISi0vBUG3uzyGKbGSgeIrS
         8FB0cYLe6ZFTWJKHcgr1DEre86MWmfnVulU0D/kFxdv9TaMQbhvvgBOAFME9EJfAUQn1
         kRyKqFRdLVLXSEBaqAabVzxjTPwv86NnO6c1vqI+GaVT6Ejh0+4RJz5rnWaXvY5diEHA
         QIrv/rY65UWw45qhJv4Fn7qtNi/4ivtWnSLuuMzIqp+u2jXUDlCBKjO1rHHzvwHa7Uoj
         pJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698744657; x=1699349457;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0Y2avDJsz7sXh0pdxQmO/TmfDGo4p5TSfw0Y5/rpSY=;
        b=VPJp5q4cNizRDQOogX7SU9rIR/j/Ll2TEIcmqgfO49626SJXLWHzUQWKW4sWy0xBQv
         aTFUzIiZmXv7e6tAwXWT8ANVDilvuuc72uvxwUkVTM4fLz+VlyKIVLVS3xdetnD5MA+k
         6CLYRJFTQIKb/FO2SF4gV7kVMTNQvXYtsZ7a75qPzbnjhb6Cn1kKeMzmD92lWF//bUse
         /XJFTdFQ0bTyF/IaXJvVUaoHkFbJ96pmtlQ3mkHh23fUbkHVVbbvWx7XgZKTSVMbF6jC
         yWVvjRsa1Z5/NvTFE+u6/Cnh/BIBccpAK8ITgezIRMnW7n2HMT+vYpIn0Jjk7fHS15MF
         J88A==
X-Gm-Message-State: AOJu0YyqEOSvAvQbwjwDS0HEM04jA9FjZUBgsz/MrSGnn8AwU3q5K/2r
        XnmB2s2rhdtgVYmnizoRU9CFCX8nSR5c66iNcuXosQ==
X-Google-Smtp-Source: AGHT+IGow8orEXWDCnDIZ+pmVCaCifTA3MFRpjtvbFIu4Aft683/Ms/V0+dbh4Ine2mE2lEwGBAtfw==
X-Received: by 2002:a2e:9893:0:b0:2c5:9e4:3fdd with SMTP id b19-20020a2e9893000000b002c509e43fddmr9753182ljj.27.1698744656754;
        Tue, 31 Oct 2023 02:30:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4d69:3958:c5b9:5f3e? ([2a01:e0a:982:cbb0:4d69:3958:c5b9:5f3e])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600c2e4200b004064e3b94afsm1187183wmf.4.2023.10.31.02.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 02:30:56 -0700 (PDT)
Message-ID: <14ecb334-827b-41b8-b0d1-41c4d9d98dc1@linaro.org>
Date:   Tue, 31 Oct 2023 10:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Content-Language: en-US, fr
To:     Can Guo <quic_cang@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
 <ccf40aed-3acc-474e-b456-031669b4a895@linaro.org>
 <059cc112-7fb6-4da4-bc25-4eede0252f0e@linaro.org>
 <d5ffacca-579e-83c9-148e-1fd3b6ab5aad@quicinc.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <d5ffacca-579e-83c9-148e-1fd3b6ab5aad@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/10/2023 06:06, Can Guo wrote:
> Hi Neil,
> 
> On 10/27/2023 8:51 PM, Neil Armstrong wrote:
>> On 18/10/2023 16:02, Neil Armstrong wrote:
>>> On 11/09/2023 07:59, Can Guo wrote:
>>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
>>>>
>>>> Retrieve UFS device version from UFS host controller's spare register
>>>> which is populated by bootloader, and use the UFS device version together
>>>> with host controller's HW version to decide the proper power modes which
>>>> should be used to configure the UFS PHY.
>>>>
>>>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>>>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>>>> ---
>>>>   drivers/ufs/host/ufs-qcom.c | 30 +++++++++++++++++++++++-------
>>>>   drivers/ufs/host/ufs-qcom.h |  2 ++
>>>>   2 files changed, 25 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>>> index 710f079..8a9d54f 100644
>>>> --- a/drivers/ufs/host/ufs-qcom.c
>>>> +++ b/drivers/ufs/host/ufs-qcom.c
>>>> @@ -1030,7 +1030,7 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>>>>                   | UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP);
>>>>       }
>>>> -    if (host->hw_ver.major > 0x3)
>>>> +    if (host->hw_ver.major > 0x3 && host->hw_ver.major < 0x5)
>>>>           hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>>>>   }
>>>> @@ -1038,11 +1038,33 @@ static void ufs_qcom_set_pwr_mode_limits(struct ufs_hba *hba)
>>>>   {
>>>>       struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>>>       struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
>>>> +    u32 val, dev_major = 0;
>>>>       ufshcd_init_pwr_dev_param(host_pwr_cap);
>>>>       /* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
>>>>       host_pwr_cap->hs_tx_gear = host_pwr_cap->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
>>>> +    host->phy_gear = host_pwr_cap->hs_rx_gear;
>>>> +
>>>> +    if (host->hw_ver.major < 0x5) {
>>>
>>> Here you set G2 for < 0x5
>>>
>>>> +        /*
>>>> +         * Power up the PHY using the minimum supported gear (UFS_HS_G2).
>>>> +         * Switching to max gear will be performed during reinit if supported.
>>>> +         */
>>>> +        host->phy_gear = UFS_HS_G2;
>>>> +    } else {
>>>
>>> So here is for >= 0x5
>>>
>>>> +        val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
>>>> +        dev_major = FIELD_GET(GENMASK(7, 4), val);
>>>> +
>>>> +        if (host->hw_ver.major == 0x5 && (dev_major >= 0x4 ||
>>>> +                          dev_major == 0)) {
>>>> +            /* For UFS 4.0 and newer, or dev version is not populated */
>>>> +            host_pwr_cap->hs_rate = PA_HS_MODE_A;
>>>> +        } else if (dev_major < 0x4 && dev_major > 0) {
>>>> +            /* For UFS 3.1 and older, apply HS-G4 PHY settings to save power */
>>>> +            host->phy_gear = UFS_HS_G4;
>>>> +        }
>>>
>>> But behavior of > 0x5 is not clear here, could you clarify it in v2 ?
>>
>> Now SM8650 is public, could you update it for v2 ?
> 
> For HWs whose hw_ver.major is > 0x5, say SM8650, initially phy_gear == host_pwr_cap->hs_rx_gear, which is HS_G5.
> 
> If a UFS3.x or older UFS device is connected, we overwrite phy_gear as HS_G4. I don't see an impact to SM8650.
> 
> Please let me know if I misunderstand anything here.

It's clear now, please add this in a comment when you send a v2,

Thanks,
Neil

> 
> 
> Thanks,
> 
> Can Guo.
> 
>>
>> Thanks,
>> Neil
>>
>>>
>>> Thanks,
>>> Neil
>>

