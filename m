Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A558082DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378244AbjLGIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjLGIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:22:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5A210C0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:22:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so1632825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701937356; x=1702542156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDf7SvWLZ5+cswjG2lbWFH7UEQugglQ6D+KquB8Vuos=;
        b=kp2zlW4dDRC33fS1h5jWO8E6Cy3cCmUKkmKu1CXQ6SK2pRU+zhvFMSPD6CKTH2hqiU
         tFwunkexjJvJ/BsvBgJrZWEzRcickV1uzeaWK3VD443pE4CZNft03QNPyECRK6wjhVkh
         38pfMGGEUK+rPQYz4ytHHTvnyi646S4gMvTCtX/3h9ZvMELQIfK4lUhwm6hyqj6Dood/
         xw60cu67hZQIMU+vulb3MzAAaeQvSx3fefMtPMarqDN8jBPcSN+jKs1RCNa6ejNLdisM
         lzrlCSsnYR2+cqqzMcqOAex0I1NiXIr+lzVW/wb0ORKCQ+XpqtjSmPXY7WjjoskolP4b
         o8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937356; x=1702542156;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rDf7SvWLZ5+cswjG2lbWFH7UEQugglQ6D+KquB8Vuos=;
        b=TZ4UsTe67tbA4UeexkklkS633l2KHRw06FOUccsh6ATmay2M/bygtiqoOYW9zDHr4Y
         ig6n3VP4s7feATreP8bT4nVFqZh1hcBbgsq8zUsknY4BoCmgtyCQdebnwe/QwpizKUxd
         8FN/6lEpKqZU61C6WiTzaWf6d9WQxGRMAWvJbTMfuVu8VgeP/vzK77Viqg8Li3qLNuHP
         7fdJYGGvZHnlxNbii4966XDaXhTIaUudNsUIs47+fgrNZdJnMrqtiwPcDISUyNSLMPXs
         REe1cR/AY3LfZclY2lAFEo1cGe8GvOzLW/frzVGeBsnbLiKSgg7WkNO1sloGn266R6ob
         hheA==
X-Gm-Message-State: AOJu0YyA3GuGLi/Sbdmfc2Bv6edQihP2/lQMs6O6LFAJ9J/tJLZdX4OC
        WtGenlVK0GQ1dM7wtm9tNm979Q==
X-Google-Smtp-Source: AGHT+IGF9OuAWjGtYphdzWDjQPyZgfERgCXt+mOZieRcXvjvu/X9KRP0irbnabGkLGrQ7SPCxAP6iw==
X-Received: by 2002:a05:600c:3516:b0:40c:903:5a36 with SMTP id h22-20020a05600c351600b0040c09035a36mr608634wmq.49.1701937356016;
        Thu, 07 Dec 2023 00:22:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5978:2b23:4be8:d698? ([2a01:e0a:982:cbb0:5978:2b23:4be8:d698])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d6808000000b003333b0d603bsm779643wru.42.2023.12.07.00.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 00:22:35 -0800 (PST)
Message-ID: <e851f59a-a8fe-42fa-a3e3-65fc5b8f3269@linaro.org>
Date:   Thu, 7 Dec 2023 09:22:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v8 00/10] Enable HS-G5 support on SM8550
Content-Language: en-US, fr
To:     Can Guo <quic_cang@quicinc.com>, bvanassche@acm.org,
        mani@kernel.org, adrian.hunter@intel.com, vkoul@kernel.org,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "open list:ARM/Mediatek SoC support:Keyword:mediatek" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support:Keyword:mediatek" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support:Keyword:mediatek" 
        <linux-mediatek@lists.infradead.org>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
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
In-Reply-To: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Can,

On 02/12/2023 13:36, Can Guo wrote:
> This series enables HS-G5 support on SM8550.
> 
> This series is rebased on below changes from Mani -
> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-1-manivannan.sadhasivam@linaro.org/
> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-2-manivannan.sadhasivam@linaro.org/
> 
> This series is tested on below HW combinations -
> SM8550 MTP + UFS4.0
> SM8550 QRD + UFS3.1
> SM8450 MTP + UFS3.1 (for regression test)
> SM8350 MTP + UFS3.1 (for regression test)
> 
> Note that during reboot test on above platforms, I occasinally hit PA (PHY)
> error during the 2nd init, this is not related with this series. A fix for
> this is mentioned in below patchwork -
> 
> https://patchwork.kernel.org/project/linux-scsi/patch/1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com/
> 
> Also note that on platforms, which have two sets of UFS PHY settings are
> provided (say G4 and no-G4, G5 and no-G5). The two sets of PHY settings are
> basically programming different values to different registers, mixing the
> two sets and/or overwriting one set with another set is definitely not
> blessed by UFS PHY designers. For SM8550, this series will make sure we
> honor the rule. However, for old targets Mani and I will fix them in
> another series in future.

You dropped my tested-by tags, but I did a new test with v8 and:

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

Thanks,
Neil

> 
> v7 -> v8:
> In "scsi: ufs: ufs-qcom: Add support for UFS device version detection", fixed a BUG introduced from v6 -> v7. The spare register is added since HW ver 5, although reading the spare register on HW ver 4 is just getting 0x0, to be on the safe side, we are exluding HW ver 4.
> 
> v6 -> v7:
> 1. Rebased on linux-next, based SM8650 PHY settings are merged there, no changes to patches for UFS driver
> 2. Addressed comments from Mani
> 
> v5 -> v6:
> 1. Rebased on scsi-queue-6.8
> 2. Addressed comments from Dmitry and Mani in patches to phy-qcom-qmp-ufs.c
> 
> v4 -> v5:
> Removed two useless debug prints in patch #9
> 
> v3 -> v4:
> Used .tbls_hs_overlay array instead of adding more tables with different names like .tbls_hs_g5
> 
> v2 -> v3:
> 1. Addressed comments from Andrew, Mani and Bart in patch #1
> 2. Added patch #2 as per request from Andrew and Mani
> 3. Added patch #4 to fix a common issue on old targets, it is not necessary
>     for this series, but put in this series only because it would be easier
>     to maintain and no need to rebase
> 4. Addressed comments from Dmitry and Mani in patches to phy-qcom-qmp-ufs.c
> 
> v1 -> v2:
> 1. Removed 2 changes which were exposing power info in sysfs
> 2. Removed 1 change which was moving data structs to phy-qcom-qmp-ufs.h
> 3. Added one new change (the 1st one) to clean up usage of ufs_dev_params based on comments from Mani
> 4. Adjusted the logic of UFS device version detection according to comments from Mani:
> 	4.1 For HW version < 0x5, go through dual init
>   	4.2 For HW version >= 0x5
> 		a. If UFS device version is populated, one init is required
> 		b. If UFS device version is not populated, go through dual init
> 
> Bao D. Nguyen (1):
>    scsi: ufs: ufs-qcom: Add support for UFS device version detection
> 
> Can Guo (9):
>    scsi: ufs: host: Rename structure ufs_dev_params to ufs_host_params
>    scsi: ufs: ufs-qcom: No need to set hs_rate after
>      ufshcd_init_host_param()
>    scsi: ufs: ufs-qcom: Setup host power mode during init
>    scsi: ufs: ufs-qcom: Allow the first init start with the maximum
>      supported gear
>    scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
>    scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 4
>      and newer
>    scsi: ufs: ufs-qcom: Check return value of phy_set_mode_ext()
>    phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550 UFS HS-G4 PHY Settings
>    phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for
>      SM8550
> 
>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>   .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   9 +
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 191 ++++++++++++++++++---
>   drivers/ufs/host/ufs-exynos.c                      |   7 +-
>   drivers/ufs/host/ufs-hisi.c                        |  11 +-
>   drivers/ufs/host/ufs-mediatek.c                    |  12 +-
>   drivers/ufs/host/ufs-qcom.c                        |  97 ++++++++---
>   drivers/ufs/host/ufs-qcom.h                        |   7 +-
>   drivers/ufs/host/ufshcd-pltfrm.c                   |  69 ++++----
>   drivers/ufs/host/ufshcd-pltfrm.h                   |  10 +-
>   11 files changed, 309 insertions(+), 108 deletions(-)
> 

