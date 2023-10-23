Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC87D2CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjJWIhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjJWIhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:37:18 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72D1188
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:37:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so44599151fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698050235; x=1698655035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=me2MC4nn/CV3tpkA7KZB34ZTwycbNAKshOBYMr2X+Pk=;
        b=PPhvIOR7tf5eRKVGIOnItTLxoqVfUtMphG2mxi5WG83HKhPmatY8WspWdceVH+Cg98
         tPjI+S9JB2VUevZ5k4WVdY/GNpKFmANGaU62cBOwNV+d875stIGB6pGbDiHI0/guxG3O
         cZ5GUT+jyJqDHGUcrZrryE0G6mura5rZPg+ZhayY0tiW3RPFhmGdPJg3TJ0iDTRVy+7R
         UymCwJWTXvYwYgB4+1SBaeX0BSbkVVhmEqPyc5eB//esbWk8et42rprRHXGu/q/nfi/J
         WDQaBL4CDuTbYmsdvnkZWs+0P7RfzJka7VqSHui7+91ih2KozkMrxwxp4M6d6gUX/TW+
         Mg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050235; x=1698655035;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=me2MC4nn/CV3tpkA7KZB34ZTwycbNAKshOBYMr2X+Pk=;
        b=fddnmx1AfDfU39iPuEafg2knzvV4yirvRnsyV6XNXX0iU5XZIDMA7BLuxuju57FZL8
         3hTYfsnMaqcf4I3VdaLjF+qRnZPvXSoIEQVgOoanVgi1avNfrpDyPg1zzyc5On5l2o4j
         Ipxe9657MweNxUBgeay9hilcEmbBi5SxhEySlVONvWQABS9GAiCTA594qLOebinz+jBJ
         sCc/z//k182gJLR14EnB1G05B56RNpKn8eF1OCYT2AAo85SZcgvFZ9uNL1hJVYWaYVR9
         NxVRfl62wujJNDQ/jHt2ogGSx4GoQQo8klXUUYgTmJBipSOVqetLQNP6MSnylysR97Zj
         JdzA==
X-Gm-Message-State: AOJu0Yy2qaWqJ0QMy4LDzQYBFn9RvLSAs8nr4aI7TvrZqxJHrBN8A/An
        1UgAlsCrDr4HNgmFDUE/SV0ssw==
X-Google-Smtp-Source: AGHT+IHlKoNRRLj9D+bLl/GMYZXBlYtqehKTnbdPLVHoetbAT9+UytWeVgCL/DfTleBsee6/yAUHYQ==
X-Received: by 2002:a2e:a589:0:b0:2c5:1a8e:e4c9 with SMTP id m9-20020a2ea589000000b002c51a8ee4c9mr6107923ljp.31.1698050234775;
        Mon, 23 Oct 2023 01:37:14 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id az20-20020a05600c601400b004054dcbf92asm8758062wmb.20.2023.10.23.01.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 01:37:14 -0700 (PDT)
Message-ID: <06a2c115-278a-47e0-b5ba-74639b6b23aa@linaro.org>
Date:   Mon, 23 Oct 2023 09:37:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,q6dsp-lpass-ports: Add WSA2
 audio ports IDs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231019153541.49753-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231019153541.49753-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 19/10/2023 16:35, Krzysztof Kozlowski wrote:
> Add defines for audio ports used on Qualcomm WSA2 LPASS (Low Power
> Audio SubSystem).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
> index 39f203256c4f..c5ea35abf129 100644
> --- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
> +++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
> @@ -139,6 +139,11 @@
>   #define DISPLAY_PORT_RX_5	133
>   #define DISPLAY_PORT_RX_6	134
>   #define DISPLAY_PORT_RX_7	135
> +#define WSA2_CODEC_DMA_RX_0	136
> +#define WSA2_CODEC_DMA_TX_0	137
> +#define WSA2_CODEC_DMA_RX_1	138
> +#define WSA2_CODEC_DMA_TX_1	139
> +#define WSA2_CODEC_DMA_TX_2	140
>   

Patches looks fine as it is, but do you realize that this s a dead code 
w.r.t upstream.
WSA2 is used only with 4 speaker setup and in such cases we use WSA 
codec dma to drive 4 channels.

So WSA2 will not be used by itself.
I would prefer support for this to be added when we are really able to 
test WSA2 by itself.

thanks,
Srini

>   #define LPASS_CLK_ID_PRI_MI2S_IBIT	1
>   #define LPASS_CLK_ID_PRI_MI2S_EBIT	2
