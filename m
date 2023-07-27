Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F2D764990
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjG0H5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjG0H41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:56:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E2C0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:54:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fddd4e942eso1088677e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690444442; x=1691049242;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isl1KK0eoajcFODNhz2lA5LEZSkd5qTO7vMoegtga2M=;
        b=U3jNgc3tQRKaIZsbGXZbMNqx/A6stXWkzDAMNk1Gu1kw2Qr2fJVOoOk/41k1KuzVNS
         XJAY3tT4NXnBaqGHRXcaCVLj03EV7VzefUd/OrNyJJXolJKr/tSHI1mqSveN/6ii+XvN
         Y2Ab7AUCzoT6S3OHEmX0EXzldoub6lN2HGzw0l6oq4g8baerEVqv/v7yzKwT9kQdacVb
         dGC0EmMcB9kITFxO25ZSqpMC5ucfXsA1BryPFPksvn01DfC9utVg3ruMYFcbFeXhRB23
         wwCRL7rUNC0+c5QZpBM1qb/JA4V1jl3khZ2DCweD7Pq+RcFoAb61BSY9sZ/rgT6FBhbO
         nqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690444442; x=1691049242;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isl1KK0eoajcFODNhz2lA5LEZSkd5qTO7vMoegtga2M=;
        b=XLa0ragNBNdU+W6oQwtgaqYr92bwcihrvnmjCd2hQr/XfhIw8fd0zM4RUaVo9uUzvS
         QQ2VmigFx5jpMiFGTTZvgofx/lkBBtQArcKkx8pnJ1Fm3AlehqrvWxNCvizLXk5EX8hq
         WjxH9xU6vlYvM7p07e416aFO0VihFI+uKjYiTVUGl8OTfH+KTeJYRNpNKWXRilFvIk7E
         i/qJE0yd+5MztLYr7pngBLdTJjrlx2sVAhwzuG8SH7POSGQMD3YdzJHamhKN4jg0m1pY
         MnXlMaumxFpjge4iypxIALKecrVB5rOEk4hn7Tu/lvqwQSufnR8LH1tTBrH5MUNDVPs6
         kvfQ==
X-Gm-Message-State: ABy/qLbO1DkY7GFJWoLmbGkMk0Qe0uxxI6HekgoTmMjkLW2TkZMT/4/p
        CDc8X2TbVv01OuaR9iw9sNzUaRvcxtcJ0Gxl4ZTYvw==
X-Google-Smtp-Source: APBJJlFjOjQ4lYR/Kkboq5LPTjVVZJFuOYhPYa8Wr6yYW0KmYWKkx68AjI9Oov6jaWK/IQU2Puingg==
X-Received: by 2002:a19:f70a:0:b0:4fb:8cd1:1679 with SMTP id z10-20020a19f70a000000b004fb8cd11679mr1172128lfe.44.1690444442216;
        Thu, 27 Jul 2023 00:54:02 -0700 (PDT)
Received: from [192.168.1.101] (abxj4.neoplus.adsl.tpnet.pl. [83.9.3.4])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b004fb745fd21esm193836lfo.122.2023.07.27.00.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 00:54:01 -0700 (PDT)
Message-ID: <dc319190-fb7e-be8e-b66b-76354dee593a@linaro.org>
Date:   Thu, 27 Jul 2023 09:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: nuvoton: Add Fii Mori system
Content-Language: en-US
To:     Charles Boyer <Charles.Boyer@fii-usa.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Vivekanand Veeracholan <vveerach@google.com>,
        Lancelot Kao <lancelot.cy.kao@fii-na.com>
References: <20230726184651.1221-1-Charles.Boyer@fii-usa.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230726184651.1221-1-Charles.Boyer@fii-usa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2023 20:46, Charles Boyer wrote:
> Add the device tree for Mori BMC, which is an Ampere server platform
> manufactured by Fii. The device tree is based on Nuvoton NPCM730 SoC.
> 
> Signed-off-by: Charles Boyer <Charles.Boyer@fii-usa.com>
> ---
Any reason this reached linux-arm-msm?

Konrad
