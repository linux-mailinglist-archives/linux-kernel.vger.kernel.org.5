Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF21757AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjGRLrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjGRLrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:47:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E69B3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:47:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51f90f713b2so8495048a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689680828; x=1692272828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgwkT6/ww+wGY+KnhW+AnmHhERDPUw3m+qyEsiw+eiM=;
        b=gm8AZISMYgDWrcpqlNV7XSWGhwCuU99E8AmVjG8gJL/c/QLOS3v+Z5XgqrxYMkYtXK
         KGZbvTNg3o379y4SY8349W/RXwRdO3sn/NWR/YQ9cI0zp7cqmIxphvbzgCuhdDUm/BHT
         cBgWwKha6D48+pCsUHf+RD0fgUb4HKnCzU1KfZUcDKUX+kNmMtmrkGdT1WI23IFJSNeK
         CZxQV/fNNhBRWOyB6F6bQmAoNks8QJofiZiO3E9+npH5qsUk+w8QZkEQPNBVsgZYPMnJ
         J+CMYmTBgTzwhi717Zo7QClWWJ2u9dvXkfG7EgHWDHlWsFC7VpoFze65MZQ+I7TTuvGn
         KPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680828; x=1692272828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgwkT6/ww+wGY+KnhW+AnmHhERDPUw3m+qyEsiw+eiM=;
        b=N0SX+wVhUpo0IERlV7sZtWwkcRgR/ERFjbU+0yNMeUH7ibVX7HGz2OnYT/AtNFs8bh
         cVlfIpieSZ3tYZNKhUnY8D/FkI6FnK99zYLtj5BjGPVffLwT+RiNCu8wVAbw9AeCoQSQ
         j5BRhXXi3KNFLhajNQtpVR0wDN8dKlBmynxpZ9CreTKk9AOI1K9sQehr6Cl7numQjygz
         DrcaAhYxRrArWIYqv8niGJPNOQw2ATBusicBgHIV+iVpBv8LAfs4kj9hDOFsruSEA2sJ
         0WsESjSvC+a45LjbYLeWqdspZMpFmQcrjd9rRe/BK7tLjqzRjV7bctgCLXa35XAoCKSZ
         N5ZA==
X-Gm-Message-State: ABy/qLbPOn6OqwjTfC00OfdHskta4L2kkqBL81HA3i8etoCMtV/mJDG/
        WYG5W42v5XfCSjEYsFszq75TRw==
X-Google-Smtp-Source: APBJJlFT/DybxzSCIUirucC7X3IgslcqDkoxyI/x5YpoNguRTUf6H2jOVZIRryHeAvuImMBdxHBMdg==
X-Received: by 2002:aa7:c643:0:b0:51e:3bb0:aa4e with SMTP id z3-20020aa7c643000000b0051e3bb0aa4emr2018660edr.15.1689680828445;
        Tue, 18 Jul 2023 04:47:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l25-20020aa7d959000000b0051a4c1dc813sm1088621eds.82.2023.07.18.04.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:47:08 -0700 (PDT)
Message-ID: <b3813aeb-8650-e406-eee6-05658ba568ff@linaro.org>
Date:   Tue, 18 Jul 2023 13:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] arm64: dts: Add node for chip info driver
Content-Language: en-US
To:     William-tw Lin <william-tw.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230718112143.14036-1-william-tw.lin@mediatek.com>
 <20230718112143.14036-4-william-tw.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718112143.14036-4-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 13:21, William-tw Lin wrote:
> Add dts node for socinfo retrieval. This includes the following projects:
> MT8173
> MT8183
> MT8186
> MT8192
> MT8195
> 
> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 15 +++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 15 +++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi | 10 ++++++++++
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi |  9 +++++++++
>  5 files changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index c47d7d900f28..115f907751c1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -590,11 +590,26 @@
>  			reg = <0 0x10206000 0 0x1000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +
> +			socinfo_data1: socinfo-data1 {
> +				reg = <0x040 0x4>;
> +			};
> +
> +			socinfo_data2: socinfo-data2 {
> +				reg = <0x044 0x4>;
> +			};
> +
>  			thermal_calibration: calib@528 {
>  				reg = <0x528 0xc>;
>  			};
>  		};
>  
> +		mtk_socinfo: mtk-socinfo {

Why do you put non-MMIO nodes in MMIO bus?

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof

