Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF17591E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjGSJqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGSJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:45:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210631BFC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:45:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52176fdad9dso6807467a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689759952; x=1692351952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgDMq8EIs6cspXF6h80EUdVrIdTF49gQA8Jmrcfwu8g=;
        b=G0NhZBDiVzdqDKmNidzXpVTTlrgUn853zGTxU3EvK5rxIR4e9IBv6tesf/GFDoH/RH
         0zage/xH+HJrFRElelFJGFU93Uch6HW1DVDOpOY99SsDbowmR0qBVzISY1dLzOCOJjDi
         Hlli/Uup8eu0arXpzS/KKziNgMxDtODc4wUrRxDwxPL5KPCdQOOpJfwKrDq6crANldnQ
         k/75QdimFUxu5NvmgvgLfR76rcmT3JiFUz4sdjEWQ7cnJVlxkyAnjhHueJqpHl6AFnIp
         DddFx/7vLLIPECUXadL2ElFrv5iZ1sKvuWUh4JejAjLCR32hJjW6gvyh5FowP9RdIjaa
         w4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689759952; x=1692351952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgDMq8EIs6cspXF6h80EUdVrIdTF49gQA8Jmrcfwu8g=;
        b=e7bPOFwVI5hByIUEw4257BBiGrbOge8SUHzfRwBRVEj2QzbCfZIJmsDistae6Xqiu8
         g8kDprb9cpHh/r5snuMo9qxH7If7g6n6NZK/BFNAdotCRvoViit5yiDLr+gBftwJyZeF
         FbCpTc3czET2At+gV+q4r5RP+L9gADF+4P2sD69Nl4qudP4QCx+hyh8mazIy2YTuw0Pk
         NBgyXp1FGgzbvk1lGq/QrQX1pL7npM06HpAK39lDTgjJUPh/R16mMMk8yAT+7r/tIt1z
         vE1XyReE0lpFB5qUNRkKGeCLF+Og0DgUC9wy014bYSZmklhNhWFiVDL8mdp4cz3j/8gz
         7KRg==
X-Gm-Message-State: ABy/qLbg0UxqBUprpi6n5I98li/XJ8JjjP5PM5fZ7TAmekiJPlTBl6PY
        SCTp9twha/xp9J1dcZfHBJWkog==
X-Google-Smtp-Source: APBJJlHexnJstMsdtGTJCbSIgOlieYQJgNdMtFqtxAgvGnbbXeTx2dJ1MnyPK18EMK3MjtK+PnfcDw==
X-Received: by 2002:a17:906:7a4a:b0:993:e883:491f with SMTP id i10-20020a1709067a4a00b00993e883491fmr2340646ejo.8.1689759952496;
        Wed, 19 Jul 2023 02:45:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709060b4a00b00999bb1e01dfsm774352ejg.52.2023.07.19.02.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 02:45:52 -0700 (PDT)
Message-ID: <2c1c69bf-3cd5-4d68-43db-696ce0f15197@linaro.org>
Date:   Wed, 19 Jul 2023 11:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] arm64: dts: qcom: sdm630: Add support for modem
 remoteproc
Content-Language: en-US
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230719093458.2668842-1-alexeymin@postmarketos.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719093458.2668842-1-alexeymin@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 11:34, Alexey Minnekhanov wrote:
> Modem subsystem in SDM630/660 is similar to MSM8998 and
> device tree node for it is based on the one from msm8998.dtsi.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> ---
> 
> V3: Use memory-region property to specify memory regions, instead
>     of using "mba" and "mpss" subnodes.
> 
> V2 link: https://lore.kernel.org/lkml/20230621175046.61521-3-alexeymin@postmarketos.org/
> 
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 59 ++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 2136ded22f7e..797625cf78ac 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1032,6 +1032,65 @@ data-pins {
>  			};
>  		};
>  
> +		remoteproc_mss: remoteproc@4080000 {
> +			compatible = "qcom,sdm660-mss-pil";

Missing bindings so standard comment:

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof

