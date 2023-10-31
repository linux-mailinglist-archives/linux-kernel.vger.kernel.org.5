Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E63B7DD43C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbjJaRHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjJaRHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:07:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFB1122
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:06:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507be298d2aso8426725e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698772008; x=1699376808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYTMv8X3U5FI7ySCLoXYmLFVJr1LqDHNIhuGjQPgB7E=;
        b=gTqUAMRhypIKmTAln9+WC/d7LDxmcLqq0wLN45BsvlVBt7ReFZ/zEtf6bO1zuLL/Ih
         Br5cY3Jv5kE3cBf8AN+F+HW4UtjT/PfeAq3NbiTlT7c5wnwlVDQHSh5uGBdMhszsTnyg
         dJjkWGb5lcrzmLYuxuSVsblr1p1vC8ZHVaNvj2e2FY9uiIgWtAkTB+3qsswcnfQ8F7n7
         TkEGx2OKcPNfQwLhG87nhIQOwAOIl9BJDQjOx1nmIqClFkawjGgxvuoLtj17WGIPTyJz
         jizNGeQZNwaTD01M5OT14a6yJ2wBmkZhdkps2qMx/FINCpH0iLaRQCSR1iIuKfJenIcj
         doRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772008; x=1699376808;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OYTMv8X3U5FI7ySCLoXYmLFVJr1LqDHNIhuGjQPgB7E=;
        b=i3L/MaCnHrPAxKVkU38MJsLdR9HbIGao7uPbh1lTxos7emAW4DE10W60l1jNtVuC3u
         OFc9hwS+NIFOWTByb44311wOLSBauZ3Rgkf1mZOQEsWwaDq8KrwpFaQJB4k7036ADUC5
         CHsLBZJ0HKcpdKCik5wjxGHLYTc0vC3Ru8W2lbQpff2dE5whmvE5aEf/HFkuareQI/JF
         G3viIfG1Wb9H+A0djeUaWv9piRa5RcOvYJzaiik1VIYCQpqk4k9WDWl6mruJUVJTI3O8
         8rxiDnxuedTQrcb7+z+WLEsBll89qwWjFp1BUuULYEeU7+GIoW9B6NQTW8s8Zm40uwWX
         znrg==
X-Gm-Message-State: AOJu0Yx6Wn3nd2piCQ6NTSIXnDGjhTZdTa07NuXQ/vs7KhrXXjnQWpHI
        CBGoFsDoAs7snkH/E0eH/2P5iQ==
X-Google-Smtp-Source: AGHT+IHdbC76RrPmrObHCE9qXDnMZP5mg4FLxeHHnRQmER4pwL5yggT4juXMRirmPc0bFcflcC8HIg==
X-Received: by 2002:ac2:511a:0:b0:507:984e:9f17 with SMTP id q26-20020ac2511a000000b00507984e9f17mr9305155lfb.34.1698772008298;
        Tue, 31 Oct 2023 10:06:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4d69:3958:c5b9:5f3e? ([2a01:e0a:982:cbb0:4d69:3958:c5b9:5f3e])
        by smtp.gmail.com with ESMTPSA id g8-20020a056000118800b0032db8cccd3asm1916388wrx.114.2023.10.31.10.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 10:06:47 -0700 (PDT)
Message-ID: <65dcdd9c-a75b-4fe7-bdcf-471a5602db20@linaro.org>
Date:   Tue, 31 Oct 2023 18:06:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] remoteproc: qcom: pas: make region assign more
 generic
Content-Language: en-US, fr
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org>
 <20231030-topic-sm8650-upstream-remoteproc-v2-2-609ee572e0a2@linaro.org>
 <8e71ba02-5d6a-4c7e-4a55-f9ef79c2f928@quicinc.com>
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
In-Reply-To: <8e71ba02-5d6a-4c7e-4a55-f9ef79c2f928@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/10/2023 14:10, Mukesh Ojha wrote:
> 
> 
> On 10/30/2023 3:33 PM, Neil Armstrong wrote:
>> The current memory region assign only supports a single
>> memory region.
>>
>> But new platforms introduces more regions to make the
>> memory requirements more flexible for various use cases.
>> Those new platforms also shares the memory region between the
>> DSP and HLOS.
>>
>> To handle this, make the region assign more generic in order
>> to support more than a single memory region and also permit
>> setting the regions permissions as shared.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/remoteproc/qcom_q6v5_pas.c | 102 ++++++++++++++++++++++++-------------
>>   1 file changed, 66 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 913a5d2068e8..4829fd26e17d 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -33,6 +33,8 @@
>>   #define ADSP_DECRYPT_SHUTDOWN_DELAY_MS    100
>> +#define MAX_ASSIGN_COUNT 2
>> +
>>   struct adsp_data {
>>       int crash_reason_smem;
>>       const char *firmware_name;
>> @@ -51,6 +53,9 @@ struct adsp_data {
>>       int ssctl_id;
>>       int region_assign_idx;
>> +    int region_assign_count;
>> +    bool region_assign_shared;
>> +    int region_assign_vmid;
>>   };
>>   struct qcom_adsp {
>> @@ -87,15 +92,18 @@ struct qcom_adsp {
>>       phys_addr_t dtb_mem_phys;
>>       phys_addr_t mem_reloc;
>>       phys_addr_t dtb_mem_reloc;
>> -    phys_addr_t region_assign_phys;
>> +    phys_addr_t region_assign_phys[MAX_ASSIGN_COUNT];
>>       void *mem_region;
>>       void *dtb_mem_region;
>>       size_t mem_size;
>>       size_t dtb_mem_size;
>> -    size_t region_assign_size;
>> +    size_t region_assign_size[MAX_ASSIGN_COUNT];
>>       int region_assign_idx;
>> -    u64 region_assign_perms;
>> +    int region_assign_count;
>> +    bool region_assign_shared;
>> +    int region_assign_vmid;
>> +    u64 region_assign_perms[MAX_ASSIGN_COUNT];
>>       struct qcom_rproc_glink glink_subdev;
>>       struct qcom_rproc_subdev smd_subdev;
>> @@ -590,37 +598,52 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
>>   static int adsp_assign_memory_region(struct qcom_adsp *adsp)
>>   {
>> -    struct reserved_mem *rmem = NULL;
>> -    struct qcom_scm_vmperm perm;
>> +    struct qcom_scm_vmperm perm[MAX_ASSIGN_COUNT];
>> +    unsigned int perm_size = 1;
> 
> AFAICS, not need of initialization.

Indeed, removed

> 
>>       struct device_node *node;
>> -    int ret;
>> +    int offset, ret;
> 
> Nit: one variable per line.

Done

> 
>>       if (!adsp->region_assign_idx)
> 
> Not related to this patch..
> Should not this be valid only for > 1 ?

I don't understand, only region_assign_idx > 1 triggers a memory_assign,
and this check discards configurations with region_assign_idx == 0 as
expected.

> 
> 
>>           return 0;
>> -    node = of_parse_phandle(adsp->dev->of_node, "memory-region", adsp->region_assign_idx);
>> -    if (node)
>> -        rmem = of_reserved_mem_lookup(node);
>> -    of_node_put(node);
>> -    if (!rmem) {
>> -        dev_err(adsp->dev, "unable to resolve shareable memory-region\n");
>> -        return -EINVAL;
>> -    }
>> +    for (offset = 0; offset < adsp->region_assign_count; ++offset) {
>> +        struct reserved_mem *rmem = NULL;
>> +
>> +        node = of_parse_phandle(adsp->dev->of_node, "memory-region",
>> +                    adsp->region_assign_idx + offset);
>> +        if (node)
>> +            rmem = of_reserved_mem_lookup(node);
>> +        of_node_put(node);
>> +        if (!rmem) {
>> +            dev_err(adsp->dev, "unable to resolve shareable memory-region index %d\n",
>> +                offset);
>> +            return -EINVAL; > +        }
> 
> 
>> -    perm.vmid = QCOM_SCM_VMID_MSS_MSA;
>> -    perm.perm = QCOM_SCM_PERM_RW;
>> +        if (adsp->region_assign_shared)  {
>> +            perm[0].vmid = QCOM_SCM_VMID_HLOS;
>> +            perm[0].perm = QCOM_SCM_PERM_RW;
>> +            perm[1].vmid = adsp->region_assign_vmid;
>> +            perm[1].perm = QCOM_SCM_PERM_RW;
>> +            perm_size = 2;
>> +        } else {
>> +            perm[0].vmid = adsp->region_assign_vmid;
>> +            perm[0].perm = QCOM_SCM_PERM_RW;
>> +            perm_size = 1;
>> +        }
>> -    adsp->region_assign_phys = rmem->base;
>> -    adsp->region_assign_size = rmem->size;
>> -    adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
>> +        adsp->region_assign_phys[offset] = rmem->base;
>> +        adsp->region_assign_size[offset] = rmem->size;
>> +        adsp->region_assign_perms[offset] = BIT(QCOM_SCM_VMID_HLOS);
> 
> Do we need array for this, is this changing ?

We need to keep region_assign_perms for unassign, but for the other 2 we would
need to duplicate the code from adsp_assign_memory_region into
adsp_unassign_memory_region.

> 
>> -    ret = qcom_scm_assign_mem(adsp->region_assign_phys,
>> -                  adsp->region_assign_size,
>> -                  &adsp->region_assign_perms,
>> -                  &perm, 1);
>> -    if (ret < 0) {
>> -        dev_err(adsp->dev, "assign memory failed\n");
>> -        return ret;
>> +        ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
>> +                      adsp->region_assign_size[offset],
>> +                      &adsp->region_assign_perms[offset],
>> +                      perm, perm_size);
>> +        if (ret < 0) {
>> +            dev_err(adsp->dev, "assign memory %d failed\n", offset);
>> +            return ret;
>> +        }
>>       }
>>       return 0;
>> @@ -629,20 +652,22 @@ static int adsp_assign_memory_region(struct qcom_adsp *adsp)
>>   static void adsp_unassign_memory_region(struct qcom_adsp *adsp)
>>   {
>>       struct qcom_scm_vmperm perm;
>> -    int ret;
>> +    int offset, ret;
>> -    if (!adsp->region_assign_idx)
>> +    if (!adsp->region_assign_idx || adsp->region_assign_shared)
>>           return;
>> -    perm.vmid = QCOM_SCM_VMID_HLOS;
>> -    perm.perm = QCOM_SCM_PERM_RW;
>> +    for (offset = 0; offset < adsp->region_assign_count; ++offset) {
>> +        perm.vmid = QCOM_SCM_VMID_HLOS;
>> +        perm.perm = QCOM_SCM_PERM_RW;
> 
>> -    ret = qcom_scm_assign_mem(adsp->region_assign_phys,
>> -                  adsp->region_assign_size,
>> -                  &adsp->region_assign_perms,
>> -                  &perm, 1);
>> -    if (ret < 0)
>> -        dev_err(adsp->dev, "unassign memory failed\n");
>> +        ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
>> +                      adsp->region_assign_size[offset],
>> +                      &adsp->region_assign_perms[offset],
>> +                      &perm, 1);
>> +        if (ret < 0)
>> +            dev_err(adsp->dev, "unassign memory failed\n");
>> +    }
>>   }
>>   static int adsp_probe(struct platform_device *pdev)
>> @@ -696,6 +721,9 @@ static int adsp_probe(struct platform_device *pdev)
>>       adsp->info_name = desc->sysmon_name;
>>       adsp->decrypt_shutdown = desc->decrypt_shutdown;
>>       adsp->region_assign_idx = desc->region_assign_idx;
>> +    adsp->region_assign_count = min_t(int, MAX_ASSIGN_COUNT, desc->region_assign_count);
>> +    adsp->region_assign_vmid = desc->region_assign_vmid;
>> +    adsp->region_assign_shared = desc->region_assign_shared;
>>       if (dtb_fw_name) {
>>           adsp->dtb_firmware_name = dtb_fw_name;
>>           adsp->dtb_pas_id = desc->dtb_pas_id;
>> @@ -1163,6 +1191,8 @@ static const struct adsp_data sm8550_mpss_resource = {
>>       .sysmon_name = "modem",
>>       .ssctl_id = 0x12,
>>       .region_assign_idx = 2,
>> +    .region_assign_count = 1,
>> +    .region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
>>   };
>>   static const struct of_device_id adsp_of_match[] = {
>>
> 
> -Mukesh

Thanks,
Neil

