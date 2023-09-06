Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72846793B04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbjIFLYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbjIFLYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:24:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF38E64
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:24:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a5be3166a2so501810566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693999465; x=1694604265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1wAlvRs1s+iG2Zeq5bR+RPSk1Ov/XWzqSAXnvT9GRU=;
        b=Cr6cFzoLB5hEQaCmG6yP2k72P7JPbW1EQZnCYlXBQeWQfgU6ae5nS7oZzFDj65Ov35
         VPv8el2bjm+Rs+m1VDlSWws60urG7ZXQlo4iClYLjlwFr4RlA1PGcSvg8T3sjIP6efrD
         3U96OKOL+WzUzGOUNMZvadkr4ncEEySjzF/t56IHurGjUZAKTTTuwbxxUMiU65KPhdZZ
         awegITPdLRqkUOy/dO/rVv4nPQkp+ei3Kk70VQLQ6PZr6bp5IFZCR6xlCvEFZe7h7scW
         VBZY94exQr+kmg4Slj1yah8FI1Q4i/s2ZIlzZrPc1NNXnMNuvo7KAAToVTr57F1A/JHS
         I8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693999465; x=1694604265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1wAlvRs1s+iG2Zeq5bR+RPSk1Ov/XWzqSAXnvT9GRU=;
        b=WvFk8va2HnA+kyKm2D5iHvbBr+bLzc0Y8KNsPCgPNzW7zrt6a/7RaemcHf131C9kEz
         sWT1jOm6pRt4KUwtCbjVNbbZNK47V+PKlL1EzMk1LadyuxerJ2sudPiidYh3mqkPVKaW
         Twnqy057TfqG20LW0rbisEyJ2/wqteLianes8uV0P/0OJq7GST0hRPr5xTyqfR8Id8i6
         ym0CKo73tb06Dm5O7pt/J/nn3dznBwEDZum+QTlnQ+5p4yyVhZtmB71gkWUDt9vVDyll
         fD9LgfZJefIIp66Hv7dxM0RPZQyhtrWHL9oyKJvvV9GBkxvaSSE5NyQy+ixcr6OCvj2c
         BTcg==
X-Gm-Message-State: AOJu0Yw4akirIWpFTlds27WQP5bXL8k0XrxZIkxLKy8ue+UXcstYK05n
        sX+IZi1C3q0X0IksKeSpzsTAWQ==
X-Google-Smtp-Source: AGHT+IF78fS9Eg7R0VlxkHPMQfbfw3JU8+PGZlkuhqY6CLgNB73N4t7Yp4iilxfshUiQOSytqEPEaQ==
X-Received: by 2002:a17:907:a046:b0:9a1:d29c:6aa9 with SMTP id gz6-20020a170907a04600b009a1d29c6aa9mr1883605ejc.11.1693999464940;
        Wed, 06 Sep 2023 04:24:24 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id rp24-20020a170906d97800b009a5c98fd82asm8785839ejb.81.2023.09.06.04.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 04:24:24 -0700 (PDT)
Message-ID: <50f7fbdd-8592-7a47-b2d8-a1af8ed93b92@linaro.org>
Date:   Wed, 6 Sep 2023 13:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-1-macpaul.lin@mediatek.com>
 <fbad941f-232b-9f56-5de3-98a16a8c4d89@linaro.org>
 <c3ddf00c-235a-2d23-db60-c998a67a3fcd@mediatek.com>
 <f343b6e2-6106-47eb-71cb-f391aff6cb7f@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f343b6e2-6106-47eb-71cb-f391aff6cb7f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 12:48, AngeloGioacchino Del Regno wrote:
>> Yes, mt8395 is fully compatible with mt8195.
>>
>> But after reading Angelo's comment, we thought it is necessary to create a new 
>> compatible to avoid confusion for users.
>> https://lore.kernel.org/lkml/bf8394c6-5460-8696-f46b-0c39927aaf84@collabora.com/
>>
>> Although they are fully compatible, developers cannot arbitrarily replace the chip 
>> on the board with another one. So separated bindings might be better.
> 
> Sorry you've misunderstood; I was trying to explain to Krzysztof that the two
> SoCs are fully compatible... my suggestion was in like with what you're trying to
> do as in I am agreeing with your first version, Macpaul, to inherit MT8195.
> 
> So,
> 
> - enum
>      - mediatek,mt8395-evk
> - const: mediatek,mt8195
> - const: mediatek,mt8395

The other way - mt8395 followed by mt8195 :)

Best regards,
Krzysztof

