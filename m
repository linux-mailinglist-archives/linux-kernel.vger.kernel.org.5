Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2E80F010
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376672AbjLLPYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376664AbjLLPYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:24:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEC5EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:24:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-336356d9092so324069f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702394677; x=1702999477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LN7cfdgQAjkSsoxFqP1f5cDcD2uFywdfIaaBewRyeQk=;
        b=GscDMUm5DcwxPRexhZ21fFVz9oFvHgCUDciKEqEDAMZZEztPVJ2lKxrgR6p2IZscy7
         jWpZSrZHG4SbElx8SrHcNqGudH6ECCUomOm1tTSG6CTcE1To8vppAyUs0qCxbuLFxfry
         GqI1bt7OYXbpq4vcVOSlL4PBmWXzQrwC2FcfR6TIQ5xJtuLlJ6q4OZ5g0LkN8dIvUJUK
         MKzGUmTeV8yaOK5leZ3QAvgenmJz4YoCoFHSs7dT0uaW+O0Tr/KMpbxbnIz8uRjC2shm
         z360MPz8J110bHv6Iwmc1Gd2RDe4BaxGwCChnA9OsmopOrBth1WAefUVxhKW+I2ZQB6W
         j0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394677; x=1702999477;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LN7cfdgQAjkSsoxFqP1f5cDcD2uFywdfIaaBewRyeQk=;
        b=TxBvv/fBUd91FmoKvjjJ1hElYdABfEop0L4ICYlwrH6IVhPTkokQ2lw63SofGL331Q
         J5jwJSAUG1NJaGt2oTzFK4Ab4jjeqA2QuH3H3bAHys8ue3v20eqL/XIpFoChXNhAljx4
         UgOSdRDefNGPLWO2hawfOmpJMWJm80yvMQLzlHzxiQdvZxyVPD4yo/6HDlncTkjeFea+
         8L4OkDwxSzs7W1lQ6B5Qij0RVvEQiuFBdvP4Ududl/R4AUeEJqRi2BW4opikiC+7pszw
         jt6xMcmFIN53QOglOZS7M9DYjLhrVV/5sgX3oZ4UutDkYoS4Tb1N1kn7dk01OJ/4g4W3
         ncpA==
X-Gm-Message-State: AOJu0YxcMWHunn+xNJeLvADFxODujDEngjWtOwYCD8tC1x/BbO07d1vk
        XuXvLNhxgoeVMMUweJk+3iasAQ==
X-Google-Smtp-Source: AGHT+IHozVD4U0YiFbAu/YdcjR8DiKmGxIQYmCeg73PrL+XEUhQ0LgEDBk9rzgYB6UAAD4H/hUPNmA==
X-Received: by 2002:a5d:4e01:0:b0:333:6338:f1af with SMTP id p1-20020a5d4e01000000b003336338f1afmr3511573wrt.98.1702394676959;
        Tue, 12 Dec 2023 07:24:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5894:fa62:26b4:bf82? ([2a01:e0a:982:cbb0:5894:fa62:26b4:bf82])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d54cf000000b0033635d121besm725476wrv.52.2023.12.12.07.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:24:36 -0800 (PST)
Message-ID: <29afe196-7b73-425c-8200-78ffbe17e8c0@linaro.org>
Date:   Tue, 12 Dec 2023 16:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] soc: qcom: pmic_pdcharger_ulog: Fix hypothetical ulog
 request message endianess
Content-Language: en-US, fr
To:     Andrew Halaney <ahalaney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
 <20231205-pmicpdcharger-ulog-fixups-v1-3-71c95162cb84@redhat.com>
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
In-Reply-To: <20231205-pmicpdcharger-ulog-fixups-v1-3-71c95162cb84@redhat.com>
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

On 06/12/2023 00:05, Andrew Halaney wrote:
> Sparse reports the following:
> 
>      % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make C=2 W=1 drivers/soc/qcom/pmic_pdcharger_ulog.o
>      ...
>        CC      drivers/soc/qcom/pmic_pdcharger_ulog.o
>        CHECK   drivers/soc/qcom/pmic_pdcharger_ulog.c
>      drivers/soc/qcom/pmic_pdcharger_ulog.c:57:34: warning: incorrect type in initializer (different base types)
>      drivers/soc/qcom/pmic_pdcharger_ulog.c:57:34:    expected restricted __le32 [usertype] owner
>      drivers/soc/qcom/pmic_pdcharger_ulog.c:57:34:    got int
>      drivers/soc/qcom/pmic_pdcharger_ulog.c:58:33: warning: incorrect type in initializer (different base types)
>      drivers/soc/qcom/pmic_pdcharger_ulog.c:58:33:    expected restricted __le32 [usertype] type
>      drivers/soc/qcom/pmic_pdcharger_ulog.c:58:33:    got int
>      drivers/soc/qcom/pmic_pdcharger_ulog.c:59:35: warning: incorrect type in initializer (different base types)
>      drivers/soc/qcom/pmic_pdcharger_ulog.c:59:35:    expected restricted __le32 [usertype] opcode
>      drivers/soc/qcom/pmic_pdcharger_ulog.c:59:35:    got int
> 
> Let's deal with endianness conversion in the rare case this ever runs
> on a big-endian machine (and to quiet down sparse for this file).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312060355.M0eJtq4X-lkp@intel.com/
> Fixes: 086fdb48bc65 ("soc: qcom: add ADSP PDCharger ULOG driver")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   drivers/soc/qcom/pmic_pdcharger_ulog.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.c b/drivers/soc/qcom/pmic_pdcharger_ulog.c
> index f1aaacf05005..238cd38589dc 100644
> --- a/drivers/soc/qcom/pmic_pdcharger_ulog.c
> +++ b/drivers/soc/qcom/pmic_pdcharger_ulog.c
> @@ -54,9 +54,9 @@ static int pmic_pdcharger_ulog_request(struct pmic_pdcharger_ulog *pg)
>   {
>   	struct get_ulog_req_msg req_msg = {
>   		.hdr = {
> -			.owner = MSG_OWNER_CHG_ULOG,
> -			.type = MSG_TYPE_REQ_RESP,
> -			.opcode = GET_CHG_ULOG_REQ
> +			.owner = cpu_to_le32(MSG_OWNER_CHG_ULOG),
> +			.type = cpu_to_le32(MSG_TYPE_REQ_RESP),
> +			.opcode = cpu_to_le32(GET_CHG_ULOG_REQ)
>   		},
>   		.log_size = MAX_ULOG_SIZE
>   	};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
