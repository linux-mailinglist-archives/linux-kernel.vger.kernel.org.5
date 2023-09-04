Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F6E7916EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352896AbjIDMOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIDMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:14:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB91B8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:14:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500913779f5so2230581e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693829673; x=1694434473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8h2PEzYhpa6MHVwUhluiZHRc9KyJDz5gg/68n+8KtA=;
        b=XRU7lkbiDt3rkV5mw5rhznZyS3bh42VDA8UDKkfVrqyX+Zk0ByN5LvWiioHg5e55rw
         DLhSMHnBRJn3cW7OsJDX3s0Nlh1PovrNmOXy8CbWSVbvu/0TVCRy6S6z7VXLpRPoX0gU
         Okw97o0NDqgi8NLIlEZBpTH3lfJ1RpXCeFhjCV7l306++gorVCM8IzbXcfnsCBifnOMD
         8fqhQlZLIGUi8XVt2nysD32f4I9EJfVbBU4++t9Kfx/uoOvweO4ngLRUvdmFvkl4gDJl
         0wRJhbGg6K1nHwCX8JsMTZyPG0I4CFSfeY8hrg55rPwGrIF74lpcm5iurvNHMnaMmCR5
         MYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693829673; x=1694434473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8h2PEzYhpa6MHVwUhluiZHRc9KyJDz5gg/68n+8KtA=;
        b=Q14eQ/MJ+cT6gOgihwN1vtZqtCilbWySHkNzBFqVvk905LePLEBFKinO5LzLOVu3fI
         4YxHUAxbq93QRbaP1CCtCFOn/P1DURNpoZDdTK8KzuorBEX6CKLOxqvGn4GFKHljrwI1
         6NVKfmutifisodGL8auw+YX9YmScQ8Weo38vVbOvH3uc/l6L3b1QZXnf0Bj1LVWxh2ri
         cyRjEeEn013HOa69KcwGOHQopm9E8LBIBSNJEr5548hveUP/wWQvHVmsRMG3WP8T5JJt
         un2kbAceqDeWSK8TBiM0PwkIwyQfACPFuWSWVm7mv/CH89qurjC127qulTaGDwN7agri
         KrKw==
X-Gm-Message-State: AOJu0Ywxrcxj5Lq6+IZb88fKNTWlINmzfStmEht2GbTNpJG1tHWsxM0I
        y3devCVckrEykFZ6PQNK4tXcKw==
X-Google-Smtp-Source: AGHT+IE2wrX16Gd9r87d7r5ei0oq1G2ppg6vlpwEiVioalK8RSkBhOZ14YzpapLDxGwN6EbpHHSRBg==
X-Received: by 2002:a05:6512:ac7:b0:500:7cab:efc3 with SMTP id n7-20020a0565120ac700b005007cabefc3mr9077071lfu.11.1693829673359;
        Mon, 04 Sep 2023 05:14:33 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id r2-20020aa7c142000000b00522828d438csm5789637edp.7.2023.09.04.05.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 05:14:32 -0700 (PDT)
Message-ID: <a3ada071-4c8e-f65d-ad75-655370ba2c55@linaro.org>
Date:   Mon, 4 Sep 2023 14:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V1 1/3] ASoC: dt-bindings: Add schema for "awinic,aw87390"
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, herve.codina@bootlin.com,
        shumingf@realtek.com, rdunlap@infradead.org, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, yijiangtao@awinic.com,
        liweilei@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
References: <20230904114621.4457-1-wangweidong.a@awinic.com>
 <20230904114621.4457-2-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904114621.4457-2-wangweidong.a@awinic.com>
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

On 04/09/2023 13:46, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add a DT schema for describing awinic aw87390 audio amplifiers.
> They are controlled using I2C.

Thank you for your patch. There is something to discuss/improve.


> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: awinic,aw87390
> +
> +  reg:
> +    maxItems: 1

No reset-gpios? Shouldn't this be just merged with awinic,aw88395 bindings?

Missing sound-dai-cells (const: 0 or 1)

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        audio-codec@58 {
> +            compatible = "awinic,aw87390";
> +            reg = <0x58>;

Please add sound-dai-cells for the example to be complete.

Best regards,
Krzysztof

