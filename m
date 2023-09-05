Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61557928BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbjIEQYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353530AbjIEGdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:33:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13827CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:33:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bed101b70so317679566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693895612; x=1694500412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWFX6+i8IQvGh2J8fHr7nL2f/+MfWw9G8OUDH7h5OUM=;
        b=GHfn6314YmpEe5ootfD0lGHtCEzsLPJXTYh9HVv05bjYTrFPA7G1/AxAffOylA0lFV
         SrA5GtGqtQUh/zRYKTm1HjVEqmfQP5Us13hr1DMnfSDfw2Dx1SFLoXdExpyBnE+8NTRu
         reXMrIL5SEUj6aHagrsscZMEKnXgNOlciXwui4ym9nCXx8bhFvsgbYDMjmoNTOlXY1wp
         Ks8YzGs8HjoJqbce2oiklVElNInZHph/86/CBlfQ6EokCM/va7XEdczch9YjWbhLKede
         OTrQCQ+5q/gggTp8kzyLBHMH9N+t5uCVWP+EQtdYqiNwzTeLjd2/LGYeUjaLR2z+vTon
         nxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693895612; x=1694500412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWFX6+i8IQvGh2J8fHr7nL2f/+MfWw9G8OUDH7h5OUM=;
        b=CmtdcqoIqNNscuMSBtgz2qBWjnn2PVXjYz6NGEJftSZE/scVRuvTXFNhbZGS2wXnLG
         XpNSBUMcAQ1L4Ep1+fpW7Vnc9vJKDEOi0QdZ+eXbAMwgj0TN8u/mZpQkr4+Kwdx/hJDQ
         y0J3HTrUOWQZYTyFHuHU5q1BxpJnwHx42UHN5VJMojZMNRlkJwJ6/bz2Z4n/qJ24E1ek
         tIsLhGXzYx7gMkif7JhTfR342hr1/w+WTODw1wmuaVvxhoMK/Pm7Psv1NxWZbwiZ+KH0
         8p0cAFEjIGuLXdTPpM2aXoH9bI4CmOzativUFSyNHgOTdZHdTjnYMstDaFpfJ9lgcoHh
         gsKg==
X-Gm-Message-State: AOJu0YzxXRDTawn6tnBnD1ZD+EEkRjxTI1mKDlWPopEVaxnWmlZEPt2c
        3ZdNCPIetSeEkHxbGdLeSY5MTuiStbK7CFEjBeY=
X-Google-Smtp-Source: AGHT+IGpBIPJMYYgXkLtFpRdZgcZHZssyisZiGMuIXFfCeQFxHixJsdk/LohVRdBDI9Q4C92cDtevg==
X-Received: by 2002:a17:906:3152:b0:99d:ff60:6ff4 with SMTP id e18-20020a170906315200b0099dff606ff4mr10228026eje.70.1693895612575;
        Mon, 04 Sep 2023 23:33:32 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id ds11-20020a170907724b00b0099bcf9c2ec6sm7163324ejc.75.2023.09.04.23.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 23:33:32 -0700 (PDT)
Message-ID: <2b6e5216-4718-7bba-ff0d-3b0e01291cdd@linaro.org>
Date:   Tue, 5 Sep 2023 08:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V1 1/3] ASoC: dt-bindings: Add schema for "awinic,aw87390"
Content-Language: en-US
To:     wangweidong.a@awinic.com
Cc:     13916275206@139.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        colin.i.king@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, herve.codina@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liweilei@awinic.com, perex@perex.cz, rdunlap@infradead.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        shumingf@realtek.com, tiwai@suse.com, trix@redhat.com,
        yijiangtao@awinic.com, zhangjianming@awinic.com
References: <a3ada071-4c8e-f65d-ad75-655370ba2c55@linaro.org>
 <20230905033103.15343-1-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905033103.15343-1-wangweidong.a@awinic.com>
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

On 05/09/2023 05:31, wangweidong.a@awinic.com wrote:
>>> +examples:
>>> +  - |
>>> +    i2c {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        audio-codec@58 {
>>> +            compatible = "awinic,aw87390";
>>> +            reg = <0x58>;
> 
>> Please add sound-dai-cells for the example to be complete.
> 
> Thank you very much, I will modify it in patch v2

I expect in example all properties your device can use. Not only some
subset you want to add just to satisfy my comment above.

Best regards,
Krzysztof

