Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6A680C7CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjLKLTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjLKLTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:19:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC1AC4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:19:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso15860145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702293579; x=1702898379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pZPdZp6957k6C1NFCMTL6mm1rsB1Mx6NLsmieoSb4Q=;
        b=hl4yLjD04Vb7BahGs6dSi/TFdTjeQaWuzf/WzJfD2PzO4VpvHcJy2eREeh3I06Zcuj
         Kqwqj2Gs/73TWt4bfPF2tGujeBkI7859fYbblNeXsLpL0Jec+cmhVj2DfYAfS2dyXhps
         pDnjC5HPxLEjj6yEa5rKlZjufn6N8Gg/xo9mDwXzwBNJW21psta7Wb4z7foBGT/uojXk
         U+6wHH435LSwCh/CB4qgmr6/tuMX6q1T9SIqX4+T4zklJOHtlIxij2TDMqs9lDVmga4t
         /cFL1duJK1tgAOq1COiAOvGFmt9u4sbdL2BgZNtnpSm9+FIADpLkz5nZQ7TbH0YN9A3Z
         4CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702293579; x=1702898379;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7pZPdZp6957k6C1NFCMTL6mm1rsB1Mx6NLsmieoSb4Q=;
        b=uDqwTrZWCe0bwT9o24J7TOMxzi2Vs2XkiMR26WCKP6zNRonKqCrmY8Eqo/+KejtP69
         q1EeDTYgvjG4q34Vb/iKpfDQj1tvsjWUEoZTsQddYxSvj5FlVlJA4P9t+Ckt1RL++fy/
         tW/RAjzm52LKxq2etA/wzsoZ9YO6mgX5r5QWs0MNU4muj2YJxXDve7AesBziROqt/uSg
         hMqGl2klRaWojsxHcFgmloqwpClxv2yEuJRlV1889iAldH/D6TsBjYvkhjYMBxRenKG0
         txkEc8texW+2UrVMnaku1F/DROKU8h1vJW5jeoxC45ar2q1UeVcV8pKBQ8/+J9Tajp7v
         7TwA==
X-Gm-Message-State: AOJu0Yy/viEnu+zma2aYudz5vw4AelJ7YDQslbNG/L86wOUHwMVQa+V7
        UepJq0S2ip/XHTJzK97BwvDdjQ==
X-Google-Smtp-Source: AGHT+IFhW7zhl+mrlfS6rhFqzVBgcXUus3YQCkHiFyDCopoJBuSiE5WNhXTl94dw0BFYn8zKpX1AGg==
X-Received: by 2002:a05:600c:3d8b:b0:40b:5e4a:406b with SMTP id bi11-20020a05600c3d8b00b0040b5e4a406bmr1938322wmb.139.1702293579015;
        Mon, 11 Dec 2023 03:19:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:302e:e0c2:d42c:cb23? ([2a01:e0a:982:cbb0:302e:e0c2:d42c:cb23])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b004064e3b94afsm15042877wmp.4.2023.12.11.03.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 03:19:38 -0800 (PST)
Message-ID: <5d77a476-06ee-4319-8e20-eef1c6ad51c6@linaro.org>
Date:   Mon, 11 Dec 2023 12:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/3] remoteproc: qcom: pas: make region assign more
 generic
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
References: <20231208-topic-sm8650-upstream-remoteproc-v4-0-a96c3e5f0913@linaro.org>
 <20231208-topic-sm8650-upstream-remoteproc-v4-2-a96c3e5f0913@linaro.org>
 <76f18323-a59e-4724-96ec-6306e5dcd2dc@linaro.org>
 <374addd2-e336-4625-9e0c-45e5efe1eb47@linaro.org>
 <b4b0ed80-eed5-4045-8ceb-5b507c77e4e2@linaro.org>
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
In-Reply-To: <b4b0ed80-eed5-4045-8ceb-5b507c77e4e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 10:54, Konrad Dybcio wrote:
> On 11.12.2023 10:37, Neil Armstrong wrote:
>> On 09/12/2023 19:06, Konrad Dybcio wrote:
>>> On 8.12.2023 16:04, Neil Armstrong wrote:
>>>> The current memory region assign only supports a single
>>>> memory region.
>>>>
>>>> But new platforms introduces more regions to make the
>>>> memory requirements more flexible for various use cases.
>>>> Those new platforms also shares the memory region between the
>>>> DSP and HLOS.
>>>>
>>>> To handle this, make the region assign more generic in order
>>>> to support more than a single memory region and also permit
>>>> setting the regions permissions as shared.
>>>>
>>>> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>> [...]
>>>
>>>> +    for (offset = 0; offset < adsp->region_assign_count; ++offset) {
>>>> +        struct reserved_mem *rmem = NULL;
>>>> +
>>>> +        node = of_parse_phandle(adsp->dev->of_node, "memory-region",
>>>> +                    adsp->region_assign_idx + offset);
>>>> +        if (node)
>>>> +            rmem = of_reserved_mem_lookup(node);
>>>> +        of_node_put(node);
>>> Shouldn't this only be called when parse_phandle succeeds? (separate
>>> patch with a fix + cc stable if so?)
>>
>> It's not a bug, it was added like that because of_node_put() already
>> checks for a NULL pointer:
>> https://elixir.bootlin.com/linux/v6.7-rc5/source/drivers/of/dynamic.c#L45
> Ack
> 
>>
>>>
>>>> +        if (!rmem) {
>>>> +            dev_err(adsp->dev, "unable to resolve shareable memory-region index %d\n",
>>>> +                offset);
>>>> +            return -EINVAL;
>>>> +        }
>>>>    -    perm.vmid = QCOM_SCM_VMID_MSS_MSA;
>>>> -    perm.perm = QCOM_SCM_PERM_RW;
>>>> +        if (adsp->region_assign_shared)  {
>>>> +            perm[0].vmid = QCOM_SCM_VMID_HLOS;
>>>> +            perm[0].perm = QCOM_SCM_PERM_RW;
>>>> +            perm[1].vmid = adsp->region_assign_vmid;
>>>> +            perm[1].perm = QCOM_SCM_PERM_RW;
>>>> +            perm_size = 2;
>>>> +        } else {
>>>> +            perm[0].vmid = adsp->region_assign_vmid;
>>>> +            perm[0].perm = QCOM_SCM_PERM_RW;
>>>> +            perm_size = 1;
>>>> +        }
>>>>    -    adsp->region_assign_phys = rmem->base;
>>>> -    adsp->region_assign_size = rmem->size;
>>>> -    adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
>>>> +        adsp->region_assign_phys[offset] = rmem->base;
>>>> +        adsp->region_assign_size[offset] = rmem->size;
>>>> +        adsp->region_assign_perms[offset] = BIT(QCOM_SCM_VMID_HLOS);
>>>>    -    ret = qcom_scm_assign_mem(adsp->region_assign_phys,
>>>> -                  adsp->region_assign_size,
>>>> -                  &adsp->region_assign_perms,
>>> I think this should be renamed to region_assign_owner(s)
>>
>> Why ? this bitfield is names "perms" everywhere qcom_scm_assign_mem is used
> And IMO that's not correct - there's the qcom_scm_vmperm.perm field which
> is oneOf r/w/x/rw/rwx and this one is filled with ORed BIT()-ed elements
> allowed in qcom_scm_vmperm.vmid (QCOM_SCM_VMID_...)

Ok right I just use the same namings as in rmtfs_mem, fastrpc & ath10k/qmi,
but indeed the qcom_scm_assign_mem() 3rd param name is srcvm but doc says "vmid for current set of owners",
so yeah it could be named owners.

I'll send a v5 with the rename.

Neil


> 
> Konrad

