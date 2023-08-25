Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DD3788514
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbjHYKjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbjHYKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:38:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930BD199E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:38:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-523b066d7ceso1153539a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692959930; x=1693564730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3C+86T5StrlLjJhPZobulBJ5EM1n9ZhQMafts6OhmY=;
        b=Iny/APsjg2ZXEcZFuPYahGnFXzs8Q673KdHP1n472FNMvhnQWGofqWgUnF49fL9H4j
         psTf3gW2UqW4XbRj1XFRwBcpF7O7kr6M7yV3tMs6l+Zei6sxDEX2Nf01ijNoabDSpYJg
         9F0FEjPZDm8DyIuovK0QdtM44Qnd0V7HDlXmxmllZO09wj9zZMigiCJj8Ikl6TdGk//i
         /M9zfowc1aCclRT7FVoDSdueNEuS1IkmX9zyeRh3J44wvpHWkcrJzU4L174L6lgtwq1q
         Yl3I8Wp/EwvZSGqIJFrnDCyrdALRjWVgDH1B6dU3frUdRWzAGe772l4wz4/8CcT//qbC
         Gnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692959930; x=1693564730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3C+86T5StrlLjJhPZobulBJ5EM1n9ZhQMafts6OhmY=;
        b=h3acCX70vRSQ0kWWNmRxtORL/Yv015T/q6z9usI0m4CT1lmxf42unsC5n8gvxJ3e8Y
         HewaFJ3ZbnIg+edd8BJYh9l4htWar7yGDCw3sNE6QBhzF5h1Zl0X2Ks4Cu9emEsG1yDP
         HTayKLsbdSvR7ByKWj9vvw+xaabrFv6cRKplvZk1V0tOKdxDzegKxJESMp0Q0ypqmZ8+
         dSCKQcng0TELKxyRboZRxAFzNj0VSqXyz1E7ewsx6DZsgyGbxvBM2QPzPthSqe5P4A4/
         wb6kyQ1FFmgsM+ddyR7v2uHda89k/GUu/qXZ+QzQWGHMwjnzrwX7vmuAeGeF0Byse2ph
         KMUw==
X-Gm-Message-State: AOJu0YxobetECDzb9Q964OGHNadARK05feuxTk2hJG9lPv5xp4wOkqKq
        Q0pLMmlNgFTNEJlzrGqnasjPQQ==
X-Google-Smtp-Source: AGHT+IFN8932Eby5S9OZDlGNpVF0+Zju5KfZZSZwwcQkQWqVLGGgaDFmghzjTCLMy5XUEKel54LPSg==
X-Received: by 2002:a17:906:9be3:b0:992:3897:1985 with SMTP id de35-20020a1709069be300b0099238971985mr14396652ejc.43.1692959930048;
        Fri, 25 Aug 2023 03:38:50 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906365600b009a1b857e3a5sm818029ejb.54.2023.08.25.03.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 03:38:49 -0700 (PDT)
Message-ID: <5373a7b5-df23-47df-b732-60a31c1ea6d0@linaro.org>
Date:   Fri, 25 Aug 2023 12:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq5018: Enable USB
Content-Language: en-US
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Amandeep Singh <quic_amansing@quicinc.com>
References: <20230825093531.7399-1-quic_nsekar@quicinc.com>
 <20230825093531.7399-6-quic_nsekar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825093531.7399-6-quic_nsekar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 11:35, Nitheesh Sekar wrote:
> Enable USB2 in host mode.
> 
> Co-developed-by: Amandeep Singh <quic_amansing@quicinc.com>
> Signed-off-by: Amandeep Singh <quic_amansing@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> index e636a1cb9b77..cdf5e22ec54e 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> @@ -70,3 +70,15 @@
>  &xo_board_clk {
>  	clock-frequency = <24000000>;
>  };
> +
> +&usbphy0 {

u is before x

Best regards,
Krzysztof

