Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5D79B6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356725AbjIKWET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbjIKJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:41:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0CFFD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:41:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so5584721a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694425312; x=1695030112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXHJJdbxzqcIQ7/jV1cMbzvwmre8W6Km5hkF3onYKso=;
        b=G+jElKLrhjQ1AkGY7mJl1J1gE80AMZ4V132hMFdyAIxykIgfKwnYeVTSCVh06TpVNI
         coIbQbRyhDPRkcJzbRFJj9fU8yvQq1dmDqMV58tlmz//YyIHNedd39vI7L6ctR7cstLC
         kxlx5xBDb6Htzn71Xqiu+YliQfPLG28OhlQPapJaFq8DPdBTw8f6+a0bdiMm73xWgIO+
         g0q6/ICoeycFGa5vZpnO+iwsRwtku3oHkpnXctYT+JMSgRLU8Nj4NvCz+IN/ihuWu/B6
         PMBz+Q+NxoY+ytg70zIKbXldCy1DQ4B0G9HSm5iQNzKqsHfOSNfFGaUs7KgWUCvYT3rq
         3TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425313; x=1695030113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXHJJdbxzqcIQ7/jV1cMbzvwmre8W6Km5hkF3onYKso=;
        b=atQs0w8YRpk73ZuUN0Fyum/EKS78arCf/9TieqKPEvDkkWOk9Si/cjm4TWEnkPrlTz
         4W+6Pd5O4jD6pXnyiyPtHUZr9gsmrBzqLlrXBCSWe9IbUyNqUW1kIUePmsd5ZBzrrn4g
         2zBcb57guc3rG+syY0XwAqr998zES6BC+ZPu1iwr14TLFzV9ntBtOLoTwTK4SmdIjqRF
         h7ovzXWkBTJY7YlyFwdZ5DSU3piyQXNpzI6+Jfny393qshq8Pgjv+313+e0Qgq0aBU4h
         EQ89OUKBprpjakRdcleyQlBx5jeP6EWJZqc7x2Re9TUijuNJP7w+aIyEgLYqtYgCiXSq
         fnKg==
X-Gm-Message-State: AOJu0YwSIdQEWhD2AbZG/FZR0D3t0trl5BbMHupwKsvTX7xs41JMLMYH
        nXs4EFKEmg5HvsOjuAgW4ig1rw==
X-Google-Smtp-Source: AGHT+IE7iZHF6KNh3bEWf9qZmU+mUmpM+L0mGI9OUUdk7KwOQH7iMgOFaFRxWJXmczhwjhmbN6mLiQ==
X-Received: by 2002:aa7:de02:0:b0:525:6ab3:dd22 with SMTP id h2-20020aa7de02000000b005256ab3dd22mr7721098edv.38.1694425312792;
        Mon, 11 Sep 2023 02:41:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id r25-20020aa7d599000000b005256d80cdaesm4311321edq.65.2023.09.11.02.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:41:51 -0700 (PDT)
Message-ID: <d35a0c54-531a-24a1-dbf6-2b40eac12081@linaro.org>
Date:   Mon, 11 Sep 2023 11:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 7/8] dt-bindings: vendor-prefixes: Add fascontek
Content-Language: en-US
To:     John Watts <contact@jookia.org>, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-8-contact@jookia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911090206.3121440-8-contact@jookia.org>
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

On 11/09/2023 11:02, John Watts wrote:
> Fascontek manufactures LCD panels such as the FS035VG158.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Best regards,
Krzysztof

