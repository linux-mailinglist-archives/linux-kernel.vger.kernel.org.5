Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D770E787044
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbjHXN3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241360AbjHXN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:29:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D3D19B3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:29:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso647917a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692883765; x=1693488565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ax05PKPz9SgHipd7DNB0MzN1smLmJbw/disDYAaAxck=;
        b=BEzuV/tOmMzZsRLCGgQWRceWTftbc19i88fAqd6Vg7zljGx4lFFvzw6ituwj55xYnm
         cfXW+pXYuQcXOTyMFMNIWG5TpKfOcawQzwMLEQBAtvDxQgfYdEr+mHcZEeTbN2upE0wr
         zZ0uT6ox43u5clJ0iVAvmO2JQbeppFRiaeC7nX37UWiF6Q9fnrhrzATaFD0LqVxez79e
         d2PRSYQLFOJDP7rp9YbokDptlGEzjwt7FL7F6m8XMFdo1fEtLXiyh4+4H2VpaDizWfG4
         NprkSeWxG4dQ+GXg/fuGoqc6MDLj8zDEFDugTgw/osZxhY2QrCUeGMHf0n343KT+93HI
         Veyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883765; x=1693488565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax05PKPz9SgHipd7DNB0MzN1smLmJbw/disDYAaAxck=;
        b=OSGYylJtQxjc1/7LCUQVDzrYfcFvyZ4KXU0uhSnVrJbT4FeFP95r38XbH8TFiXOKzZ
         xshS0xYk/e2e5aB7HI+DYmLxAyvxOG/WZNgP8PdHP08KQxMSKUcDi51Ep+V83OhtPioN
         Bv3RYtGDWNZqns9PyXnL38qHIRU/TvH+aB5Uu6R+d3xjbuD5FsZQm8lOiJvCAWuSHi0/
         UwPGaJKEfFlWGqImee10I56RjLzoUuacdYU0buY0xRE0H0JVZmHRBPmbZA1bqRxM23QA
         nedXBpC7BSiH5tc6piZGw0AdaPZlmDL9g2Ij62ebvYtEQGYNdq8G+WBKc1JfyK+PFsnZ
         Sz3w==
X-Gm-Message-State: AOJu0Yz58vaHjcmnIZfbA43JNXjVkfqUeR2EOfqgubMkqNmJyy4tJd9r
        nlAnsCxgncUCcQPSThzWHpyy9A==
X-Google-Smtp-Source: AGHT+IE2cmtnCunbbnMmsNzjLWYWjY3Ep6zCnD57mNmS06p32KbZAXy2EuFDo5DJcGe0eudWiy0fZA==
X-Received: by 2002:a17:906:7691:b0:99b:f66a:3189 with SMTP id o17-20020a170906769100b0099bf66a3189mr12430044ejm.8.1692883765282;
        Thu, 24 Aug 2023 06:29:25 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906394800b0099bcb44493fsm11130574eje.147.2023.08.24.06.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 06:29:24 -0700 (PDT)
Message-ID: <c1e722c0-f329-a6f4-f712-0e1060a4804e@linaro.org>
Date:   Thu, 24 Aug 2023 15:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: bq24190: Add
 ti,bq24193
Content-Language: en-US
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
 <20230824131342.206784-1-linkmauve@linkmauve.fr>
 <20230824131342.206784-2-linkmauve@linkmauve.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824131342.206784-2-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 15:13, Emmanuel Gil Peyrot wrote:
> This power supply device is used in the Nintendo Switch.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> index d3ebc9de8c0b..2ad107589a16 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> @@ -19,6 +19,7 @@ properties:
>        - ti,bq24190
>        - ti,bq24192
>        - ti,bq24192i
> +      - ti,bq24193

Why are you sending new version so fast after previous one? Before we
finished discussion?  One version per day.

You did not include here my comments.

Best regards,
Krzysztof

