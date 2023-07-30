Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788E776874E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjG3TNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3TNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:13:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F0910FE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:13:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso43234515e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690744413; x=1691349213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0ecqV+zQBrvHKU8P7urlBJt6tFNPZIqLBFcAYgaXHc=;
        b=aeN5dBIw8dAZs1vLJMDO/AnhsBq0W8SZSb3g3qrWn7K/gRBEtE7SgRRPqLxCKx+hoZ
         7h6xApke7c+HdKTWCApjr7owhXz0sDbIEuhVQcxqzpY3p3zA99oi/95GvesWzBkjqMhk
         wRxxPz2Q6aAUJqEHtj3tpKIWf6jyDb7rBn41AljRYo3oMju5p8NtcUF6KBF4ZQpnA2nP
         +/NOIdw2ulfvkQdH5rG44/m/OnDG1J44gwoahNHBqhFK8yRR1r0XrYyOLvhlCH4hT9Bh
         gxAvT1Ok3UeKOr2AC5J79tn1/r9nRDhiZwGNzces5VybhhAaGdSgZu2Z3+lzyg/NYvZs
         8TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690744413; x=1691349213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0ecqV+zQBrvHKU8P7urlBJt6tFNPZIqLBFcAYgaXHc=;
        b=PLXuI3jirIeTbNTsJNa0wNyIb3SHZwVpZg4mkRnsVB9LnaF8hKo/oe4MAt4DE6XhCj
         p+rKyzsd390KkpECvXUDUtzF52W9g00+eF5No5uDShMqUz1aS4xSn97EQ+LUXyCizpJT
         0tjfoGznJdyAKDiEnfpOO7nWzJq2svhuClu2nOh1eovGoCNbdW/Axhjtye+aBLtWWQ1+
         O1lSDNQg6VxeZwr6X0VeLQ+PJuxQ6BPlwJKu2EDKQhdqalEXqFHEFBN584W3D1jCTfp5
         xGFFLuL8+gtspKFAyEtdrWHVKscn5fFuPBAbq2Q2rWXsj4ji3v4kKwUHRb2MtNsXqaGu
         PdjA==
X-Gm-Message-State: ABy/qLYS9WQeECNDWpwu0G9af7vdunQrx6TvKpD0ixuuA8JfGqk2Y6lw
        xi+gbSF3tk/f5QWXcAF2E8Wkdg==
X-Google-Smtp-Source: APBJJlHgJTuWoq/+j8ZmgJoc3K/QqyIwwtGgg/uMn9KDVYpruhtGFWsefLl9lfof8594VrGyYM6lXg==
X-Received: by 2002:a05:6000:12d2:b0:317:5e73:7594 with SMTP id l18-20020a05600012d200b003175e737594mr6080504wrx.28.1690744413699;
        Sun, 30 Jul 2023 12:13:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id f1-20020a05640214c100b0052276921a28sm4463825edx.78.2023.07.30.12.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 12:13:33 -0700 (PDT)
Message-ID: <8fc36939-49e7-4422-be94-ce57a82a56f6@linaro.org>
Date:   Sun, 30 Jul 2023 21:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3] dt-bindings: sound: gtm601: convert to YAML
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, - <kernel@puri.sm>
Cc:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230730190243.113105-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230730190243.113105-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2023 21:02, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v3:
>  - incorporated feedback from Krzysztof

...

> +properties:
> +  compatible:
> +    oneOf:
> +      - items:  # 48 kHz stereo
> +          - const: broadmobi,bm818
> +          - const: option,gtm601
> +      - const: option,gtm601  # 8 kHz mono
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +additionalProperties: false

I missed one thing in the previous review, sorry. Something was looking
here as missing but my brain did not work. Please add "required:" with
compatible.

Best regards,
Krzysztof

