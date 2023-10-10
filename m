Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439F07BF563
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442662AbjJJIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379424AbjJJIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:12:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C797
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:12:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3226cc3e324so5274147f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696925546; x=1697530346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7w5ncK3ZGR6hn3gQth0yAs2IU5AJ9lM29YZdM7MiT5k=;
        b=zVrsmYFJBJcTOWDRtTpVV3SPPbdGybN8P+vFD0blH92io0WYM5h+Ab3vWRZUQsAhc7
         qdUpipqYxWaY5GWsdCzCJjnMCuXCgpvQd/7wRKoPc7NZyPftm4ZjkDnF/WoAoopvKMJK
         Q+sPS7HTT0emLFQWiQ842MuQEiTc6lNXTuRXK6xLrh9PLu6niPSME/8EzDC7CkTFi36E
         sjcPVmmavBvsfz4H3+TGfaegVnzEIhuxb0b76xIMoVUgeVnelpxH3+pqK+HcK1MK+2dU
         rRdexPJQ8/FWNDajf3sQJdFO81i4CdB7LiZkzO5zIab6Tw/yiqAF0o+ygpaCZJ7GmjLk
         +1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696925546; x=1697530346;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7w5ncK3ZGR6hn3gQth0yAs2IU5AJ9lM29YZdM7MiT5k=;
        b=mPrbOh9mWNsl3JU34eVr6GyTNWJQHAhkG3o3Quno7j3tpK/ZJpizgfdxXMjkrUX64U
         6xTEXJQ6LazPtvRpajaBWAfP5WLJJSJyaiHyubKf7Pm3mlf5+ihq0WHNvgpDUpeM+LIa
         nZz6oFWf1asYQ6soF8nqvkNW7PxyX4apDMLrilVkKFHsKPmLp+Jqj91j1lLjqnzMHHAs
         Ir8Sihgp0vML21TpSe2Z/933+PLiwK2kIxMsXzYOgyJaiUOJAbZ3Izu8CdH5ZbgyvFyh
         Sn5cpxTaFCXZiziVY0Ny8TEd3urM7vo7omfMHPmdIMFf00oyjEpYTWZ5IMgkIdZD6HlR
         XHVw==
X-Gm-Message-State: AOJu0YxFhhBgLpyGRwPiskBHjEd2VIQllHUKoozSgGoC4SoLBK4swamr
        MWBcKWECGL0F6wmuNroDL6PuiA==
X-Google-Smtp-Source: AGHT+IGChbVUIQ32HuRaG9qe+y5bIYwF/hH4ZD5e2kuk6uI613nNful+o/eFf29+lVKWZwenjHG0+Q==
X-Received: by 2002:adf:db50:0:b0:327:d08a:1fb3 with SMTP id f16-20020adfdb50000000b00327d08a1fb3mr15699165wrj.35.1696925546377;
        Tue, 10 Oct 2023 01:12:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:2eac:5b51:e0a4:4807? ([2a01:e0a:982:cbb0:2eac:5b51:e0a4:4807])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d6b0b000000b00324853fc8adsm11818176wrw.104.2023.10.10.01.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 01:12:25 -0700 (PDT)
Message-ID: <e7413bc9-6964-4fe2-9eb7-2f4d81548fb1@linaro.org>
Date:   Tue, 10 Oct 2023 10:12:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 0/5] drm/msm: dpu1: correctly implement SSPP & WB
 Clock Control Split
Content-Language: en-US, fr
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
 <dxcfxhqesrauyo5bscwwj5ejrlulsndiewwfahmnhhztj4gil5@vowdkbp5bsqj>
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
In-Reply-To: <dxcfxhqesrauyo5bscwwj5ejrlulsndiewwfahmnhhztj4gil5@vowdkbp5bsqj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 10:10, Marijn Suijten wrote:
> On 2023-10-09 18:36:11, Neil Armstrong wrote:
>> Starting with the SM8550 platform, the SSPP & WB Clock Controls are
>> no more in the MDP TOP registers, but in the SSPP & WB register space.
>>
>> Add the corresponding SSPP & WB ops and use them from the vbif QoS
>> and OT limit setup functions.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Neil Armstrong (5):
>>        drm/msm: dpu1: create a dpu_hw_clk_force_ctrl() helper
>>        drm/msm: dpu1: add setup_clk_force_ctrl() op to sspp & wb
>>        drm/msm: dpu1: vbif: add dpu_vbif_setup_clk_force_ctrl() helper
>>        drm/msm: dpu1: call wb & sspp clk_force_ctrl op if split clock control
>>        drm/msm: dpu1: sm8550: move split clock controls to sspp entries
> 
> Fyi we're all using drm/msm/dpu: now :)

Ack, thx, will change for v2

> 
> - Marijn
> 
>>
>>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 35 +++++++++-----------
>>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  4 +--
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  4 +++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |  9 +++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h        |  9 +++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c         | 23 +------------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c        | 21 ++++++++++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h        |  4 +++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c          |  9 +++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h          |  4 +++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  9 +++--
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           | 38 +++++++++++++++++-----
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h           | 12 ++++---
>>   13 files changed, 120 insertions(+), 61 deletions(-)
>> ---
>> base-commit: 9119cf579b4432b36be9d33a92f4331922067d92
>> change-id: 20231009-topic-sm8550-graphics-sspp-split-clk-43c32e37b6aa
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
>>

