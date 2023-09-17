Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8A7A3447
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjIQI0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjIQI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:26:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E3133
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:26:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so7697952a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694939172; x=1695543972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECgwhafg3/hjFYGez4Lfo2Lk7AlEQkzhPQOhVe/2Q4Y=;
        b=q1qHcJS6gjLT2Q7P3murwDSRiTN4Y8PThJdgj/ZzqYu0XjMK5XHsxzraEvKhrV0mqm
         ly4CURWXkWP4mTvwL0KGjrxDUGeJBlizm8SfY7eVnMtX0Fitzo20y+ACGTACqKPCw8mc
         sEcDrkJkXhVV7gj0gXxLPd1TkanYZIpHkGEwI0Jxs1p9cHHk+qCePEE3xEID8PkdBx53
         2iD6YHUMc+wCQxjamAAP6aio8Pp0BgHgn4eGBl2EAA/VPLSbnP6V0kCMhRhw7eBsHSyj
         Dwt+e3277upjIgcTbclZcipGZZ3nO+WED3ZP08XIQSY4BTL1gWpPpCRJ/Wr2OH3FAZF7
         1ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694939172; x=1695543972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECgwhafg3/hjFYGez4Lfo2Lk7AlEQkzhPQOhVe/2Q4Y=;
        b=NfVWpu0cbT1GHPor/8q5xPcEWVkoQHV/KB9e8ymrVaN0VgYtWoodxrg5STJMGEgYIS
         aYM+/MkJoNBFgsdD9DIdlZwA3fMabPgEmAkUcH4IIL7aB0WWkO25AQPCOFV4cRnloIDR
         F1TydCi1y44TL+jweXwqIpkpk/f++ksET00S9xligwZh2oHXKKbU5TlIGlS4GnOsFGZX
         FhCYJWqiyFy/cCuJRjvh87hFo1ItRiWqP08XqKfcKEbXqGWn7pH95yNIsX8RRF4S6dFY
         ZbbIRGxC4AzyVZ/jABjHs9TGyabcy6ajx80w3E3s3m5EytvmQAY8ngMyD7yHQHxk1WPU
         PNcA==
X-Gm-Message-State: AOJu0YxzZGkSDCKczWxDBWAk/XW/9WqHu/T9A3BTsizoNKcpHXW8+2If
        WNuessVhhye62O2VxW+RYKqVrA==
X-Google-Smtp-Source: AGHT+IFgDjgI68oBB35B+lNMXppqHwPyG7kpxwszDiieF6pp/UNLwKHmoSE5dOg/U7+Qx6+GIuBFww==
X-Received: by 2002:a50:ec8c:0:b0:52f:a763:aab4 with SMTP id e12-20020a50ec8c000000b0052fa763aab4mr9366082edr.5.1694939171635;
        Sun, 17 Sep 2023 01:26:11 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id v21-20020aa7dbd5000000b005256771db39sm4371991edt.58.2023.09.17.01.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 01:26:11 -0700 (PDT)
Message-ID: <3e7bc476-ffc7-fb07-8e64-246427da736c@linaro.org>
Date:   Sun, 17 Sep 2023 10:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/3] dt-bindings: hwinfo: Add mtk-socinfo driver
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
References: <20230915152607.18116-1-william-tw.lin@mediatek.com>
 <20230915152607.18116-4-william-tw.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915152607.18116-4-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 17:26, William-tw Lin wrote:
> dt-binding documentation for mtk-socinfo driver.

Here and in subject, drop driver and instead descrbe hardware.

> mtk-socinfo driver provides SoC-related information.
> Such information includes manufacturer information, SoC name,
> SoC segment name, and SoC marketing name.
> 
> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
> ---
>  .../bindings/hwinfo/mtk-socinfo.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
> new file mode 100644
> index 000000000000..74f03f1dc404
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml

Nothing improved.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwinfo/mtk-socinfo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SoC ChipID
> +
> +maintainers:
> +  - William Lin <william-tw.lin@mediatek.com>
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Kevin Hilman <khilman@kernel.org>
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  MediaTek SoCs store various product information in eFuses, including
> +  Chip ID and Revision fields, usable to identify the manufacturer,
> +  SoC version, plus segment and marketing names.
> +
> +properties:
> +  compatible:
> +    const: mediatek,socinfo

What happened to compatibles? No, this is just wrong and no explained.
You ignored other comments as well. Really, that's not the way to go.

NAK

Best regards,
Krzysztof

