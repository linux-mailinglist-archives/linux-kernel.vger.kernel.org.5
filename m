Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645E27F9C68
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjK0JLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjK0JKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:10:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF512D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:10:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so32291935e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701076241; x=1701681041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUR2wSeOP6LFGt4qpl7i9vzWxJbRVNeOLPPh4XEQ8eo=;
        b=dD5kiba0TRgMzObo2+i7/LOfOGSfaYX+nKV+oxsPD85bJQYFQtlxZk9Vh0HGByIDG/
         iOCYPaWwe6DiQDnRHXs1bofrj6KhXeX1/6wfSL5OJFVYT6PkVID5nK2WJVVQLgk63I9S
         jR3PES2dbkPP8gCUwmE1kEvpmFSO5WRAhoROVNNScppooeytrdWGt3s4dujPupbym3eO
         8fGJhzXuIpg+dizGVqJPuZAabVF8LnoUMqrx1XQw5O+QeIqTJe3vnlkO1YH5k8kMmz+Z
         VKlkZs65dOC3LEEpsvFBkw0XX0YPa9nvWmf/f0xOLwa5AN3SU5DSMg7dVYqq378F67KB
         vf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701076241; x=1701681041;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hUR2wSeOP6LFGt4qpl7i9vzWxJbRVNeOLPPh4XEQ8eo=;
        b=haFmdXal9sS/V6y3s9XkHQnj+QnD2go6ouB+weqaurSpp7W2hrHXr7I2iNeu2pz59k
         Y5RfodNgIroHc2aFbs/L/PHmmglW2LfQJmjzS9AW3RRG9tV9Smhwg3EaYUdkD4kPlW6e
         3VytEf7w08U6GItnC25hvC78d1+PKSpClwcnKbVIKoDZ6MtAYne3gRfLNMB3I/9CLT+R
         V/hIB6xn0I8ysXHju9CPBRgTfkJCfq+O1YOJhFjwA90GT/xPXRyQUdXgPZr6FTU6KgTH
         Rp+7bfTOiRLh6cIMuzMsw5Z+PxO8sIWU1hya9eNDDVqu2n6olSfLdUye9pH4cDMr6LVJ
         KstA==
X-Gm-Message-State: AOJu0Yw2tsfCiQ/bLjdwopOoJdH1ZKXB9oAYItriZUm5xghz7elL6Rm1
        rGp4SC/iI5Ly7EcbibEmF7otgg==
X-Google-Smtp-Source: AGHT+IFdF9J39dEZvkbZ81hKhdmhhKBkmB1jsS57Ela0Iatt8UvL2WcJf77YPNlkLrIktkxFHD1Y1Q==
X-Received: by 2002:a05:600c:1384:b0:40b:41c8:f414 with SMTP id u4-20020a05600c138400b0040b41c8f414mr3931901wmf.31.1701076241165;
        Mon, 27 Nov 2023 01:10:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff? ([2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff])
        by smtp.gmail.com with ESMTPSA id c37-20020a05600c4a2500b003fee6e170f9sm12942449wmp.45.2023.11.27.01.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 01:10:40 -0800 (PST)
Message-ID: <38d323d0-d8a8-4de7-8db9-57ea488e544e@linaro.org>
Date:   Mon, 27 Nov 2023 10:10:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 0/8] arm64: dts: qcom: Introduce SM8650 platforms
 device tree
Content-Language: en-US, fr
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org>
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
In-Reply-To: <20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 24/11/2023 10:20, Neil Armstrong wrote:

<snip>

> 
> Bindings Dependencies:
> - aoss-qmp: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-aoss-qmp-v1-1-8940621d704c@linaro.org/ - Reviewed
> - bwmon: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-bwmon-v1-1-11efcdd8799e@linaro.org/ - Reviewed

Applied

> - cpufreq: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org/ - Applied
> - dwc3: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-bindings-dwc3-v2-1-60c0824fb835@linaro.org/ - Applied
> - gpi: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-gpi-v2-1-4de85293d730@linaro.org/ - Reviewed

Applied

> - ice: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-ice-v1-1-6b2bc14e71db@linaro.org/ - Applied
> - ipcc: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-ipcc-v1-1-acca4318d06e@linaro.org/ - Reviewed

Applied

> - pcie: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pcie-v1-1-0e3d6f0c5827@linaro.org/ - Reviewed
> - pcd: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pdc-v1-1-42f62cc9858c@linaro.org/ - Reviewed
> - pmic-glink: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-pmic-glink-v1-1-0c2829a62565@linaro.org/ - Reviewed
> - qce: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-qce-v1-1-7e30dba20dbf@linaro.org/ - Applied
> - rng: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-rng-v1-1-6b6a020e3441@linaro.org/ - Applied
> - scm: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-scm-v2-1-68a8db7ae434@linaro.org/ - Reviewed
> - sdhci: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-scm-v2-1-68a8db7ae434@linaro.org/ - Applied
> - smmu: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-smmu-v1-1-bfa25faa061e@linaro.org/ - Reviewed
> - tsens: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-bindings-tsens-v2-1-5add2ac04943@linaro.org/ - Reviewed
> - ufs: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-bindings-ufs-v3-1-a96364463fd5@linaro.org - Applied
> - clocks: https://lore.kernel.org/all/20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org/
> - interconnect: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org/ - Reviewed

Applied

> - llcc: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-llcc-v2-0-f281cec608e2@linaro.org - Reviewed
> - mdss: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-mdss-v2-0-43f1887c82b8@linaro.org/ - Reviewed
> - phy: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-phy-v2-0-a543a4c4b491@linaro.org/ - Applied
> - remoteproc: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org
> - rpmpd: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org/ - Applied
> - tlmm: https://lore.kernel.org/all/20231106-topic-sm8650-upstream-tlmm-v3-0-0e179c368933@linaro.org/ - Applied
> - goodix: https://lore.kernel.org/all/20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org/ - Reviewed
> 
> Build Dependencies:
> - clocks: https://lore.kernel.org/all/20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org/
> - interconnect: https://lore.kernel.org/all/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org/ - Reviewed

Interconnect bindings has been merged, Georgi provides an immutable branch at:
https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-sm8650

Thanks,
Neil

> 
> Other:
> - socinfo: https://lore.kernel.org/all/20231030-topic-sm8650-upstream-socinfo-v2-0-4751e7391dc9@linaro.org/ - Reviewed
> - defconfig: https://lore.kernel.org/all/20231121-topic-sm8650-upstream-defconfig-v1-1-2500565fc21b@linaro.org/

Reviewed

> 
> Merge Strategy:
> - Merge patches 1-5 with Clock bindings immutable branch
> - Merge patches 6-8 with Interconnect immutable branch
> 
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v4:
> - Collected reviewed-bys
> - Fixed dwc3 interrupts
> - Added comment on the reserved i/o ranges
> - fixed s/resetn/reset-n/
> - Used minimal patch strategy to make patch 6 readable
> - Link to v3: https://lore.kernel.org/r/20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org
> 
> Changes in v3:
> - Cleanup of thermal zones
> - Rename SDE pinctrl to real signal names
> - Link to v2: https://lore.kernel.org/r/20231106-topic-sm8650-upstream-dt-v2-0-44d6f9710fa7@linaro.org
> 
> Changes in v2:
> - Drop RFC since most of bindings were reviewed
> - Collect Reviewed-by/Acked-bys
> - Remove #ifndef PMK8550VE_SID in favor of #define in sm8550 dts
> - Add allow-set-load/allowed-modes to LDOs
> - Add QCOM_ICC_TAG_ALWAYS/QCOM_ICC_TAG_ACTIVE_ONLY to interconnects = <> instead of 0 & 3
> - minimal sm8650-qrd.dts cleanup
> - Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org
> 
> ---
> Neil Armstrong (8):
>        dt-bindings: arm: qcom: document SM8650 and the reference boards
>        arm64: dts: qcom: add initial SM8650 dtsi
>        arm64: dts: qcom: pm8550ve: make PMK8550VE SID configurable
>        arm64: dts: qcom: sm8650: add initial SM8650 MTP dts
>        arm64: dts: qcom: sm8650: add initial SM8650 QRD dts
>        arm64: dts: qcom: sm8650: add interconnect dependent device nodes
>        arm64: dts: qcom: sm8650-mtp: add interconnect dependent device nodes
>        arm64: dts: qcom: sm8650-qrd: add interconnect dependent device nodes
> 
>   Documentation/devicetree/bindings/arm/qcom.yaml |    7 +
>   arch/arm64/boot/dts/qcom/Makefile               |    2 +
>   arch/arm64/boot/dts/qcom/pm8550ve.dtsi          |    6 +-
>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts         |    1 +
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts         |    1 +
>   arch/arm64/boot/dts/qcom/sm8650-mtp.dts         |  679 +++
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts         |  804 ++++
>   arch/arm64/boot/dts/qcom/sm8650.dtsi            | 5384 +++++++++++++++++++++++
>   8 files changed, 6881 insertions(+), 3 deletions(-)
> ---
> base-commit: 4e87148f80d198ba5febcbcc969c6b9471099a09
> change-id: 20231016-topic-sm8650-upstream-dt-ee696999df62
> 
> Best regards,

