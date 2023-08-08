Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312FF774177
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjHHRVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjHHRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:20:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD49783F1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:08:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so9625811e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510880; x=1692115680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fDUJSyowELFFr/mrbugPdpucnV9wVL9S5WvHo40rsE=;
        b=syjniGA9emAaKbQCvO3DbyIHMXmgKct+616AL0Ux8lS0WSatjyIHeVzYy8Erj5zv4k
         35mqa5hY42FbSDoe9WtnzP+vLJW4WRP1ZbeNWmiK9XQ9QtSM0DetgUO9RFM7Ik+KEDg3
         P1We3+ALCMRAREVdBHR10O9BnLo7mSYjnbniZL4HmhC8f2KuGjdZS6eeQgyLaYnh6Les
         hkmgITOK/jVtVPhXo583u+gjhiTZRj1bep52b/IFjgg4HT/FgRZQl0Sd16g+GzRepMwr
         jYyUt03Y2xgT9kF6XO62FUoKCkUDBn6JnLJXOk9TpgesVnr68wttB/8ihnNfnhpWEwM3
         rPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510880; x=1692115680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fDUJSyowELFFr/mrbugPdpucnV9wVL9S5WvHo40rsE=;
        b=BCRK9qzxt+LmpTpcLcn+UYbqlGQahP/71VEfcIAbNgmOuw/kq+4u9U3fkAWd1/NnXO
         CwQk4omHURkgP35FtTTBIj8cx0yzW0rhVIbO2kwZ2dtQpm5tPClXFRWyfm7q9aapAcIz
         Dc/rlUEdlitbPfpzsqri+JqeYpruWnTuZA6RPBAWTFK3g9VhZSRgNTdZkSoGMvl6GoFn
         Y7+G0BjS+WHwqzK7HztfyIwDmCKTdWt1TWBoF8Fupdr/H8InwcbCippz5oqkF3USnwf8
         1DflKq49fJeIeCvvcNa3Rg7rLwxx57K2wu64eo0damfUVcsryZOx8TlZziHS2572ZMMY
         PJnw==
X-Gm-Message-State: AOJu0Yyk5vXjZHxvJReJMtJVzgOOb20QvT2v7G6HsL1G5FSP1BUez6sa
        jBVJtyCbjcsq77NB3exOzuErAA==
X-Google-Smtp-Source: AGHT+IFeJnROaNDYChsa8tqDPdUZ0jbri12bPyUnucgweW28Yum76XnbsnQfFybEIs8a1gFhxfZWEw==
X-Received: by 2002:ac2:5b03:0:b0:4f8:7781:9870 with SMTP id v3-20020ac25b03000000b004f877819870mr7470934lfn.60.1691510880011;
        Tue, 08 Aug 2023 09:08:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402180800b005227ead61d0sm6972572edy.83.2023.08.08.09.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 09:07:59 -0700 (PDT)
Message-ID: <9a86a125-2eda-721b-8b17-c1cfe144adc9@linaro.org>
Date:   Tue, 8 Aug 2023 18:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: fsl: fix DEBIX binding
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        dan.scally@ideasonboard.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230807171513.156907-1-m.felsch@pengutronix.de>
 <20230807171513.156907-2-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230807171513.156907-2-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 19:15, Marco Felsch wrote:
> The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
> corresponding bindings by adding an own entry for it. Mark
> polyhex,imx8mp-debix as deprecated but keep it within the dts file since

The deprecation did not happen anymore.

> we already have a user for it [1].
> 
> [1] https://elixir.bootlin.com/barebox/v2023.07.1/source/arch/arm/ \
>     boards/polyhex-debix/board.c#L38
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> 
> v3:
> - drop 'deprecated' status and adapt comment instead

With adjustments in commit msg:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

