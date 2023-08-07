Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144E8771A83
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjHGGhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjHGGha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:37:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01E0171A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:37:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bdf08860dso1118152666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691390247; x=1691995047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJUsdl71xTfW5cw9jShWN7bQN13L2c8KVaQNeqdmBx8=;
        b=i9eW+WP4Zh8JYB3xwfirDvSBJK3fe3VP6fSkVESj6Bt3uGqATOcjr1hHNNWFMxUxK5
         uBPtAk2ziKVJQy8ntt1GhuYygmmV0WeN9aP8teiamo7jLhH2IL61baHOyRl1PTO4m6Gk
         VBHMuclvnp/6fM5CMuLExt36NwTiYjDva0YqBvJnPlBNmzowVjLOYHr87KiMFq/qLGf7
         9VH5mqxcDIzdT73dFcUt+aaZxmdlqyteB86HQN9sRQXZB7LXPXe0PT9GnsDcV5em7X0j
         hFuhQf6EgOu99xFY9f3NaS8Yi69fK6NA5L8GEx7N4drOFJ3WFkgfCZ+4YrG8allQKIvl
         AhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691390247; x=1691995047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJUsdl71xTfW5cw9jShWN7bQN13L2c8KVaQNeqdmBx8=;
        b=VW9B01atXL5HS3xPjNYKKh44hziRxgIog7raejW7ME3NtdybTBIJqVe/KmA5FH3Rnn
         /UKrOx9VdTQ9c49/qRD3eEZGaQcKCq82t+A2mYNNablV7FUkMKD05vHgXbVCwNdV2Zjy
         2pxvdD72Fs28JLzBNU6zEDnVrd9OHFTkLvLKG/Y7VyM1e9qq88zY0REnkW7AkzbDazr3
         I4PijjAQIHQswTN9CTt7JrQtzqTB9rfJF0cRvE5czN4Oraof3Xk278ccAT8xcM/wJCTZ
         tfjpjadR+xEMyWE5VtH8oJOQrf2k5aApeIxTC9oKyk8aTCLG94z2jGrJpF0l6XqBa4qs
         TXKw==
X-Gm-Message-State: AOJu0YzXTCf3K3cEhXt+qgY68vfNFyRA/rOBN6LrigDzTgdXBezp8BZ3
        sdK+fxAG69cJvc3ay6CJiAqaFA==
X-Google-Smtp-Source: AGHT+IH48I2n+o3nJXIDM47/JPWmQGzO7ZatYG2/6OHX3B77CEGddulYk2xbALN4FJJ70iFF2ayNqw==
X-Received: by 2002:a17:906:9bf2:b0:988:b61e:4219 with SMTP id de50-20020a1709069bf200b00988b61e4219mr6910073ejc.29.1691390247416;
        Sun, 06 Aug 2023 23:37:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906271900b0099b4d86fbccsm4820054ejc.141.2023.08.06.23.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 23:37:27 -0700 (PDT)
Message-ID: <2b41d0a8-5222-de07-2796-329066a45079@linaro.org>
Date:   Mon, 7 Aug 2023 08:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Content-Language: en-US
To:     Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1691389687-31211-1-git-send-email-alina_yu@richtek.com>
 <1691389687-31211-2-git-send-email-alina_yu@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1691389687-31211-2-git-send-email-alina_yu@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 08:28, Alina Yu wrote:
> Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> 
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> ---
> v6


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

