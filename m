Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A292E7CDE39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344816AbjJRODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjJROC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:02:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09355FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:02:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507bd19eac8so2904579e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697637770; x=1698242570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrvJS16JwCCTQYGqZYQ32U8uJ0RKwf4JAv30R+ZXmZ8=;
        b=PQZqOGiVjYZckjK5bRLTDhbHCT8J8PEpRUV2u+rpiuYQAIEC2wxvfCVgWZanNQ7T8x
         qpBj+GEVa8CjhYEXpDJCvNAR4+kgieuysA85yEANEMcDvuQrxDKcCgZW9KtdcgYFkOeb
         9I425vfBf9d698FCUKI8QPkTF/kVtDo4/OMmw1XS8n+ZgIkO0TJXxqAUId71t70tl3IK
         MkpERzCaiocCFsiRzJCTNif2XBNIXEtFz0PE5Keajt8TwA85PxAknnSCrWYBVgLjqkO+
         wk82gNPqbeXyGRXGPVS0iZUMPT7ePtQDQaHFTXUGpPEYAva8zfTe8pEs8GUBzgM8pZB/
         oQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637770; x=1698242570;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BrvJS16JwCCTQYGqZYQ32U8uJ0RKwf4JAv30R+ZXmZ8=;
        b=Y9/Dt/LgTOy28eRqCYpq92R9AJtAMb7qWPtCFrepUFt3GGtL0ByvaTHCZAQnWx0NAD
         gRsSBP/Ha1bF7Og2HGXWpzyA7BUzU681sKwCZIFMV1W6CM+0i2IVc3f8b23paPUYMTwB
         nCxEY5symo6lxUSKW2ViBUbFCQFLtmlTIAibcg0YvvERWwdOlY6cFm6hCs086JUvGoKy
         kFjRRbP7pqlb5JnJkcqKdivjVO7rO/hWjAmsx9IUWsGLV8gPyzoLldYFjfP3TKaCaqpD
         BjBo4ld3PkFiQchLOl8bIsv0JuB+FU5eMOspW1X+ScGrSmr01PtqaGMsgOEP9BON0S0V
         9tLA==
X-Gm-Message-State: AOJu0YyK0WSPIk76kHGgyByEh83HtiLYu4wdcJFEAN+JxPjWqSoY4+n8
        TkILNzR03Bi1dEuPPH0+fRLvKA==
X-Google-Smtp-Source: AGHT+IFwm9UwIKru6U6PA5v6Sik26DhFXloXccGwkzfIWGxSemOJitg8JS639gA9BfXuUVOtyhKfCw==
X-Received: by 2002:a2e:a0cb:0:b0:2c0:1fb4:446f with SMTP id f11-20020a2ea0cb000000b002c01fb4446fmr3743183ljm.14.1697637770014;
        Wed, 18 Oct 2023 07:02:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d8f:701:423:3d05? ([2a01:e0a:982:cbb0:5d8f:701:423:3d05])
        by smtp.gmail.com with ESMTPSA id fm12-20020a05600c0c0c00b004030e8ff964sm1758913wmb.34.2023.10.18.07.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 07:02:49 -0700 (PDT)
Message-ID: <ccf40aed-3acc-474e-b456-031669b4a895@linaro.org>
Date:   Wed, 18 Oct 2023 16:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From:   Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 07:59, Can Guo wrote:
> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> 
> Retrieve UFS device version from UFS host controller's spare register
> which is populated by bootloader, and use the UFS device version together
> with host controller's HW version to decide the proper power modes which
> should be used to configure the UFS PHY.
> 
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>   drivers/ufs/host/ufs-qcom.c | 30 +++++++++++++++++++++++-------
>   drivers/ufs/host/ufs-qcom.h |  2 ++
>   2 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 710f079..8a9d54f 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1030,7 +1030,7 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>   				| UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP);
>   	}
>   
> -	if (host->hw_ver.major > 0x3)
> +	if (host->hw_ver.major > 0x3 && host->hw_ver.major < 0x5)
>   		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>   }
>   
> @@ -1038,11 +1038,33 @@ static void ufs_qcom_set_pwr_mode_limits(struct ufs_hba *hba)
>   {
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>   	struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
> +	u32 val, dev_major = 0;
>   
>   	ufshcd_init_pwr_dev_param(host_pwr_cap);
>   
>   	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
>   	host_pwr_cap->hs_tx_gear = host_pwr_cap->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> +	host->phy_gear = host_pwr_cap->hs_rx_gear;
> +
> +	if (host->hw_ver.major < 0x5) {

Here you set G2 for < 0x5

> +		/*
> +		 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> +		 * Switching to max gear will be performed during reinit if supported.
> +		 */
> +		host->phy_gear = UFS_HS_G2;
> +	} else {

So here is for >= 0x5

> +		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
> +		dev_major = FIELD_GET(GENMASK(7, 4), val);
> +
> +		if (host->hw_ver.major == 0x5 && (dev_major >= 0x4 ||
> +						  dev_major == 0)) {
> +			/* For UFS 4.0 and newer, or dev version is not populated */
> +			host_pwr_cap->hs_rate = PA_HS_MODE_A;
> +		} else if (dev_major < 0x4 && dev_major > 0) {
> +			/* For UFS 3.1 and older, apply HS-G4 PHY settings to save power */
> +			host->phy_gear = UFS_HS_G4;
> +		}

But behavior of > 0x5 is not clear here, could you clarify it in v2 ?

Thanks,
Neil

> +	}
>   }
>   
>   static void ufs_qcom_set_caps(struct ufs_hba *hba)
> @@ -1287,12 +1309,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>   		dev_warn(dev, "%s: failed to configure the testbus %d\n",
>   				__func__, err);
>   
> -	/*
> -	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> -	 * Switching to max gear will be performed during reinit if supported.
> -	 */
> -	host->phy_gear = UFS_HS_G2;
> -
>   	return 0;
>   
>   out_variant_clear:
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 4db64d9..e10889f 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -56,6 +56,8 @@ enum {
>   	UFS_AH8_CFG				= 0xFC,
>   
>   	REG_UFS_CFG3				= 0x271C,
> +
> +	REG_UFS_DEBUG_SPARE_CFG			= 0x284C,
>   };
>   
>   /* QCOM UFS host controller vendor specific debug registers */

