Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076CE7939B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbjIFKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjIFKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:20:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7244E10C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:20:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4cbso4811775a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693995611; x=1694600411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bq5VaCN58woKfHlu27g2JEDxXsqU8G37VcS/uYaOtG0=;
        b=AlKmqOwhhBr2V67YG9Z20CkK5bWFizanI2oRm1PWqnTkoLTZPyGZiPFawSHcdhvpEv
         D3L/lUizrrPEUa3UYQ27F2BWLr56ngf35RN6BflDjYOXNV+BW1SbFnhrJumIlUtoq5m3
         /4oeVgRd3bI2gIED3A/UnLgvS6oGEVsZK44zoTFSx4q0G3mAyvB+cwUgabAE3sNyLkys
         avP3LNxxpy9YBjmMr+nNV0djXQvdtlxP26qBLV0+RzbgDs/9OkLUo1RAlmSBnajrW0Ti
         fx5mnpoHBNUPhvS3hf7UYjiMltKWvjX/ebmQUQPFgu7nJ/6iE8t4duCO2RyqpdzddvPe
         U3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995611; x=1694600411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bq5VaCN58woKfHlu27g2JEDxXsqU8G37VcS/uYaOtG0=;
        b=lDhbJoCo4RJng9cGzT36kKJ7zOAFkUmun2De9S4yQ9TGj8/Mp45BzqjPa+gfng4b9F
         bn7rNK61V1CRAtvdn2eCWv1JO81wj1fFvZxhHz70rPtBXmpQOfXdvfjR4TgZ9h1q6ZYl
         Du4ySOWhQ16VA6VxC2LzK64/enPWLvz6fLISw+VqGDU+4iz8/dX2sNPUDw/evKDkvq4N
         3k3PuIbkTNj55P5XMBuS/jrDHV9DgNLDLLjMuEwRCk5h0Ebic61oL18iDWXJOdmQ7I17
         QTk6W08F0kpvK8SG3WmzuENPakdAFUm4VMFdPy8dXKKVGN/3k6HbCKlJdHZC0n1661ty
         2kqQ==
X-Gm-Message-State: AOJu0Yw21VQ/oyMXQdh+oQrp2MzaD6Riqv0SCEz8lfCnKlinoFO86Btz
        Bqkf/mDZ58ppRhR6cd92tdFOkA==
X-Google-Smtp-Source: AGHT+IECInaTz8AGdtzkKqE3txhHtVT5HkkOVMm7zF06XwaR9R8LGP/zSAC3l08RLFTjiI82UIK5ew==
X-Received: by 2002:a17:906:cd1:b0:9a2:232f:6f79 with SMTP id l17-20020a1709060cd100b009a2232f6f79mr1652416ejh.25.1693995610974;
        Wed, 06 Sep 2023 03:20:10 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id hb26-20020a170906b89a00b009931a3adf64sm8986930ejb.17.2023.09.06.03.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 03:20:10 -0700 (PDT)
Message-ID: <145f9a3e-af61-c62f-1752-2abb7663d7a3@linaro.org>
Date:   Wed, 6 Sep 2023 12:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: add device-tree for Genio
 1200 EVK board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, Ben Lok <ben.lok@mediatek.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-2-macpaul.lin@mediatek.com>
 <2cb8069a-976b-0af4-a427-1e63ba4e7870@linaro.org>
 <951e34bc-dda3-f9d4-b251-7f0fd02052ee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <951e34bc-dda3-f9d4-b251-7f0fd02052ee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 12:15, Macpaul Lin wrote:
>>> +
>>> +wifi_3v3: wifi-3v3-regulator {
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
> 
> 
> This keeps a format with -regulator is because I've found some other use 
> cases. It seems "-regulator" or "regulator-" could be arbitrary. I'm not 
> sure if it is a new guideline for regulator's node. If there is in the 
> devicetree document, maybe I just missed it?

What is the point to name in the same DTS some of the regulators
"regulator-foo" and some "foo-regulator"?

Best regards,
Krzysztof

