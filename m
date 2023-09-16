Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0DF7A2C9E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbjIPAoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbjIPAnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:43:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F712738
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:41:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31f737b8b69so2546608f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694824651; x=1695429451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cs8ffVpaEJyCfU4sBIS3Iatn3H0nM+QmhyXAWCxFGXs=;
        b=CoCJwcXt1gX6dPyJTorsOPE9cq3vKXPjFs6jt5ElxXflB7dxxUur3LzINx2y2YrYVO
         6yiMXo/lpcFflNTRvTF3x8lDMBL/pgJvqEQT9nuIZBNx4G/I9mQgzWh2FUqDZkqK8yNt
         ZtXv41axRr2tvoh/6Lszl4iWHNQoSJHDVLWOk1kULzwfpW8RUZMpcpVRMO1cLwbOdXLz
         2iOLnAx7/21cfYSnm7UcJEczqqzj2fMIxVwY37W6VJlRlV6hXwpD4YlkiMEVITqnvkPo
         Vdj9n86dm/eb5Ji7VSwa7WoccjWqvPNG6Rae2bQpUBqP57AVNVDtd9zvzANxOysUTaZn
         JNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824651; x=1695429451;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs8ffVpaEJyCfU4sBIS3Iatn3H0nM+QmhyXAWCxFGXs=;
        b=BuVM1AlzkUDrJQ2V/rYdV3XusqyxsPzNJzzfgI5/GbE8DgOndAzNyqtLwmCFXMdr09
         Z/rgbQBRd8lRIzDEgBVGHSlm33I/CJZlOV/E9AUuOONF0tC9dNqP+E9vt6iI1+2uF+/5
         hMGhIc+MzXvVe1O0EDNIugi6wVLRyBDnomtFOwaEaihrnfq2ddmdc94xXHujCWS3n3Ds
         HdMqqp3sCElyiIai9rClvwgNKp1rL43YCJ4Faws7iu4iUHmteOq7jCsfBNyqTESYvBks
         AHFec3PTcf//Nnc13L3nUTK98kJYGzw/vSQV/lC4Qic881VVYDZTeBzjkNSk815VHPXv
         a4SQ==
X-Gm-Message-State: AOJu0Yw0ZDkZlwWBabAQklWjqBErNizlv/RRVjOHs/rEwle/vmldRtZz
        CsXLM000PKouKeXwfj4nVZkxuA==
X-Google-Smtp-Source: AGHT+IFHMldYMcm0cwNSdiXdqEx/c5pov89rhv5UGqSedaK5wqsQkTq6rI3RCsnIK45uZyRUwMHc6Q==
X-Received: by 2002:a5d:4acb:0:b0:313:eb09:c029 with SMTP id y11-20020a5d4acb000000b00313eb09c029mr2701367wrs.43.1694824651092;
        Fri, 15 Sep 2023 17:37:31 -0700 (PDT)
Received: from [192.168.37.154] (178235177186.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.186])
        by smtp.gmail.com with ESMTPSA id d17-20020aa7ce11000000b0052568bf9411sm2816951edv.68.2023.09.15.17.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:37:30 -0700 (PDT)
Message-ID: <9144cb67-9606-4b17-b760-a6d3e8e346cc@linaro.org>
Date:   Sat, 16 Sep 2023 02:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/33] ASoC: dt-bindings: Add Q6USB backend
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230916001026.315-1-quic_wcheng@quicinc.com>
 <20230916001026.315-24-quic_wcheng@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230916001026.315-24-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.2023 02:10, Wesley Cheng wrote:
> Add a dt-binding to describe the definition of enabling the Q6 USB backend
> device for audio offloading.  The node carries information, which is passed
> along to the QC USB SND class driver counterpart.  These parameters will be
> utilized during QMI stream enable requests.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,q6usb.yaml | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6usb.yaml b/Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
> new file mode 100644
> index 000000000000..51ff0b1ffa2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,q6usb-dais.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm ASoC DPCM USB backend DAI
> +
> +maintainers:
> +  - Wesley Cheng <quic_wcheng@quicinc.com>
> +
> +description:
> +  The USB port is a supported AFE path on the Q6 DSP.  This ASoC DPCM
> +  backend DAI will communicate the required settings to initialize the
> +  XHCI host controller properly for enabling the offloaded audio stream.
> +  Parameters defined under this node will carry settings, which will be
> +  passed along during the QMI stream enable request and configuration of
> +  the XHCI host controller.
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,q6usb
> +
> +  iommus:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 1
> +
> +  qcom,usb-audio-intr-num:
> +    description:
> +      Desired XHCI interrupter number to use.  Depending on the audio DSP
> +      on the platform, it will operate on a specific XHCI interrupter.
So is this the number of interrupters to be used or the index of
a single interrupter? If the latter, then "num" is definitely way
too ambiguous.

Konrad
