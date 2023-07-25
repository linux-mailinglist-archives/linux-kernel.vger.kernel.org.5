Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D78776108B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjGYKWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjGYKWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:22:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9183910E2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:22:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9923833737eso781490766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690280536; x=1690885336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWadWjqF45OYKb04rK5xzE1AeT6F9pvOBw28ewY8qRw=;
        b=CQiqWpke4LmeiynkUU0LU4wU+J5FlhcsxT3Js4zHwRI/SiW2kSi8fbWeP8Zuc4XdWd
         B2ENsZ7qPQojA9+xYW+5DNO+4OL1FsHFEOfM3CtYhFj7dLmESzp5eL2x4cdJMs/vs5Bn
         8ABaHje1rWZ8sX5Mpe9IjWUqw/H3tTrWnTle3qYiQFZ6oA6ayHc8lrWlEte53fBrFjrW
         IcZYrlf2HseSwTZn7rT4igpkk2hKMSRG77sW6LU1yp/btgD6tbiE6UE4vVlk9tTk9qRL
         YE6RVWu/giPc3uvJJzSzdOqY7mu6hP8EigzRYKBeDo0RnG1dkuBsiJd4InbMBVDO+C+G
         lCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690280536; x=1690885336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWadWjqF45OYKb04rK5xzE1AeT6F9pvOBw28ewY8qRw=;
        b=R8GTr+VgGPciRNmvrJ3PIMZuXRTFSC1NUWAOoCdVGBjNywT9m5A7l+tOdb4mnGbSA1
         q+btzb+TNkL44Omo+fuIj0wMiqrQ5EwvluKCM/wmpET60G9feigLAaOJM8j434lmzXZj
         xqdmJ3/vR+FEumVkuL0Pq5J7gJ8Dt+cXuf4UhViDgg+PsHYKkJmiMMZOGqd38K8LqMLq
         Y4exbo0YYQIFwYZlH0oBUhPZDNeMUNgd14tgzUOye4Kwj2/1n8wBM1r+GWCGra8+RxTV
         rj12eM4Vb9iD5cotXDlLYQj3DKfau6aMESO8MNDrzieZ73iMNMUuZEREQxHbxZjhXmy5
         XWlw==
X-Gm-Message-State: ABy/qLbwZeM30jjAMNjelp1fgxWugxEuMC3mK5m1Keu+EnkqLadmRF0Y
        IBL5X0h6Ytk0Hvi/ckDHdk6e9Q==
X-Google-Smtp-Source: APBJJlGGVArmfyzfCFxzdLxo1G3ncs6vyd50LiUpQOe+HyUBxHObEZr0PgpxaPwhnG1avvlYapxTDQ==
X-Received: by 2002:a17:906:30c3:b0:993:f996:52cf with SMTP id b3-20020a17090630c300b00993f99652cfmr12726557ejb.28.1690280536032;
        Tue, 25 Jul 2023 03:22:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id jp7-20020a170906f74700b009937dbabbd5sm7952129ejb.220.2023.07.25.03.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 03:22:15 -0700 (PDT)
Message-ID: <c54c8973-7cff-dad5-51ef-41523cf2f2b5@linaro.org>
Date:   Tue, 25 Jul 2023 12:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: usb: add missing unevaluatedProperties on
 USB connector
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jagan Sridharan <badhri@google.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Min Guo <min.guo@mediatek.com>,
        Gene Chen <gene_chen@richtek.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230723071105.40157-1-krzysztof.kozlowski@linaro.org>
 <20230724162638.GA3784203-robh@kernel.org>
 <60e7e772-bf0a-264d-abac-4ed72766a2d0@linaro.org>
 <CAL_JsqLwZR_VQEAuhLLqN4BF8Yvh=3vkQe=tFHaKWzJzMMP+qw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqLwZR_VQEAuhLLqN4BF8Yvh=3vkQe=tFHaKWzJzMMP+qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 23:02, Rob Herring wrote:
>>       compatible = "usb-a-connector";
>>       phy-supply = <&exp_usb3_vbus>;
>>    };
>> };
>>
>> I would assume that phy-supply should be a property of the phy.
> 
> Indeed. We already have vbus-supply which this looks like it is. I'm
> pretty sure I've seen Vbus in phy bindings too which I've pushed back
> on as to whether Vbus really went to the phy or was there because the
> phy driver just wants to control Vbus.
> 
> The marvell platforms aren't in great shape schema wise, so maybe
> don't worry about it now.

OK, I will send a v2.

Best regards,
Krzysztof

