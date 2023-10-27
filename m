Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1CE7D98F6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjJ0Mvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0Mvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:51:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11652BF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:51:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32ded3eb835so1511706f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698411102; x=1699015902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaC3Tst7u/+sfV3eqRZ7QDIrge5vEY2rhdCtJxg0roU=;
        b=LbX/sRyxLx0vbQFnQy5xztxQ4KZsEI4mTtSgH4CCOOU9CSYgM+T+hNTjhZcf09aI2i
         mdHQH7Zv5RLGmhQaONAscWgDLoEeIXq3uz0l586Vk6jOb2p3Wie5R+CKqZy9fCaRqznN
         mwFGcHU5kGm3IJiVq0GAMKcekFDl/7KgrH6GJyl1kNstxKrolk617L9a25IluIYyZdOc
         Ekh6cD/eHwmsZmoc7BwZfcTSHz3WPuuFY9Ao1kjUk5D/+KfuHlN22Uc3Jq4m/UM8m6Wb
         TyFhrlDCtuj3VyAayjZJ2FnwgMGEmWLp8JHEP/b0xYBGAZItLMaGrZT+Nr5xORzblMwJ
         BDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698411102; x=1699015902;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AaC3Tst7u/+sfV3eqRZ7QDIrge5vEY2rhdCtJxg0roU=;
        b=ektthrX050EmRFs9KjebQbHYVKByn5bYYA3W1qIENOM9R1fGAyAD1mF+RHEg9B4NTd
         BI4Ytan1Tz3e38TlF8VXpZ53M6nwiBc3OOjrk0r/KVfkygWxPu9d1RuOBL5bC/zu0Q8F
         6Vz3LXCWtkWQYV2oDwCUucPlgeKjTjtZvhwBSUYCEMJsmSPIB0KxTBukZ1yFhvwFBk+a
         HpARBdXakMtuIAbe3mUE6QIV8Kh1FFFoiyT416mDHU5aLvj0b2w3QPoFImUhA8jhhdgU
         s/XqIzu8Iov+/XIQYxk5Y4O77kNiyEb14M/MaopkcVQUiE86ErUyY9rrpJh5z6PWw51F
         4p7Q==
X-Gm-Message-State: AOJu0Yxyclfv3+Oi/LSPcG30bxyl/JhBxGV//0cSm/u1LbzV3bqKW/0w
        0g2Jj+jbuKUicRGzyqyfvqL7z4Y/wv5YxDLpnBEydli6
X-Google-Smtp-Source: AGHT+IH8hagq+WbAKMvfNgSyoiEk62mu6RFvdQDX+6GMr0u3AOSp8GkSpVsqN50DlZNICMdZHODWow==
X-Received: by 2002:a5d:4dcd:0:b0:32d:87df:6dea with SMTP id f13-20020a5d4dcd000000b0032d87df6deamr1946689wru.45.1698411102373;
        Fri, 27 Oct 2023 05:51:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bba7:4e7d:4d42:af62? ([2a01:e0a:982:cbb0:bba7:4e7d:4d42:af62])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d564d000000b0032ddf2804ccsm1692158wrw.83.2023.10.27.05.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 05:51:41 -0700 (PDT)
Message-ID: <059cc112-7fb6-4da4-bc25-4eede0252f0e@linaro.org>
Date:   Fri, 27 Oct 2023 14:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Content-Language: en-US, fr
From:   Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <ccf40aed-3acc-474e-b456-031669b4a895@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2023 16:02, Neil Armstrong wrote:
> On 11/09/2023 07:59, Can Guo wrote:
>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
>>
>> Retrieve UFS device version from UFS host controller's spare register
>> which is populated by bootloader, and use the UFS device version together
>> with host controller's HW version to decide the proper power modes which
>> should be used to configure the UFS PHY.
>>
>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 30 +++++++++++++++++++++++-------
>>   drivers/ufs/host/ufs-qcom.h |  2 ++
>>   2 files changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 710f079..8a9d54f 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -1030,7 +1030,7 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>>                   | UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP);
>>       }
>> -    if (host->hw_ver.major > 0x3)
>> +    if (host->hw_ver.major > 0x3 && host->hw_ver.major < 0x5)
>>           hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>>   }
>> @@ -1038,11 +1038,33 @@ static void ufs_qcom_set_pwr_mode_limits(struct ufs_hba *hba)
>>   {
>>       struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>       struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
>> +    u32 val, dev_major = 0;
>>       ufshcd_init_pwr_dev_param(host_pwr_cap);
>>       /* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
>>       host_pwr_cap->hs_tx_gear = host_pwr_cap->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
>> +    host->phy_gear = host_pwr_cap->hs_rx_gear;
>> +
>> +    if (host->hw_ver.major < 0x5) {
> 
> Here you set G2 for < 0x5
> 
>> +        /*
>> +         * Power up the PHY using the minimum supported gear (UFS_HS_G2).
>> +         * Switching to max gear will be performed during reinit if supported.
>> +         */
>> +        host->phy_gear = UFS_HS_G2;
>> +    } else {
> 
> So here is for >= 0x5
> 
>> +        val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
>> +        dev_major = FIELD_GET(GENMASK(7, 4), val);
>> +
>> +        if (host->hw_ver.major == 0x5 && (dev_major >= 0x4 ||
>> +                          dev_major == 0)) {
>> +            /* For UFS 4.0 and newer, or dev version is not populated */
>> +            host_pwr_cap->hs_rate = PA_HS_MODE_A;
>> +        } else if (dev_major < 0x4 && dev_major > 0) {
>> +            /* For UFS 3.1 and older, apply HS-G4 PHY settings to save power */
>> +            host->phy_gear = UFS_HS_G4;
>> +        }
> 
> But behavior of > 0x5 is not clear here, could you clarify it in v2 ?

Now SM8650 is public, could you update it for v2 ?

Thanks,
Neil

> 
> Thanks,
> Neil
> 
>> +    }
>>   }
>>   static void ufs_qcom_set_caps(struct ufs_hba *hba)
>> @@ -1287,12 +1309,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>>           dev_warn(dev, "%s: failed to configure the testbus %d\n",
>>                   __func__, err);
>> -    /*
>> -     * Power up the PHY using the minimum supported gear (UFS_HS_G2).
>> -     * Switching to max gear will be performed during reinit if supported.
>> -     */
>> -    host->phy_gear = UFS_HS_G2;
>> -
>>       return 0;
>>   out_variant_clear:
>> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>> index 4db64d9..e10889f 100644
>> --- a/drivers/ufs/host/ufs-qcom.h
>> +++ b/drivers/ufs/host/ufs-qcom.h
>> @@ -56,6 +56,8 @@ enum {
>>       UFS_AH8_CFG                = 0xFC,
>>       REG_UFS_CFG3                = 0x271C,
>> +
>> +    REG_UFS_DEBUG_SPARE_CFG            = 0x284C,
>>   };
>>   /* QCOM UFS host controller vendor specific debug registers */
> 

