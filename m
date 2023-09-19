Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E227A62EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjISM3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjISM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:29:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E074100
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:29:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a64619d8fbso743556366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695126579; x=1695731379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EtiuNXgnIZXl6uZ3s+na9fQCFST8PiCnTLp3+2BYCE=;
        b=jitHC/oMKRr6hiQh1x5wonGwka2eXk/RXLcSh9OTs09XQPHeO8ek5ZoM5RpRfuEIi6
         BTbKFe3dd305hI1vK2aVyuf3xJq80a0+rdV90+gTgyv5hU08wgDRrM3hCG6eBHUUVSGQ
         WJU8mH/SRwlx+92DKHlkYaW8aG0+gIXRdpCJvhjy3s5mhCh6rvkjVJ2pQi6Ovg2ylU7/
         FHs8aI3rGxpbV/Oynaz7JWLc4HORC5oHuwVgxOnZZEsDfFyQ7K3rFyLtF3/KwamWZIQF
         cZ16tct63KSn5F9gIxDSYQB10Jx6rZkXGWE6kXI8hr0R6exHriujSElCX0RCB/2GQKGk
         AInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126579; x=1695731379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EtiuNXgnIZXl6uZ3s+na9fQCFST8PiCnTLp3+2BYCE=;
        b=hLJjFq1zWzLGK1IsD5h5tKWP/CCkVAex2zAHKQevGvbPO1mF4Iqn5bswA8GvxtYoaj
         IuqsNvHISm8FogAkeZ7+DXLwzYEDq/+wKVc9GCdCvHpaggd9fTw+x5qlxBRpPK2EA771
         qd5UIYjhJMOt7epnFgR2x59+m2theU9CLhlKXv1wSAvedJw3U/ae3H1fluAvCMQnbeOe
         Bco4HkcN1/m8FN2eK5FH5WemBXGsXXX7Ljuj9/Skm4gXttKOdxOuXqGvFCPyeVLzgFBq
         ti2PJOhAlpXyOq6i7N9O4Mk6NJtPazdgq1yaDscOj8aPa7ROn6q5tYqU+kIgxmu0jDpP
         D2qw==
X-Gm-Message-State: AOJu0YyYR3+J+k4Inx6vKZAdd8uPJXtVP6qKWABtffulSZxpiq1+bh2n
        Cr0KXbwnvSGszic3moENszRWYg==
X-Google-Smtp-Source: AGHT+IHHeTZchplaQKxq8oPK/RMzsBnOVPhOn2auV6wN1oA1mFfnJtCuhxn4/gkedGhA7WnuWYoR+w==
X-Received: by 2002:a17:907:b0c:b0:9ad:a46c:2936 with SMTP id h12-20020a1709070b0c00b009ada46c2936mr10566454ejl.8.1695126578936;
        Tue, 19 Sep 2023 05:29:38 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id br20-20020a170906d15400b0098669cc16b2sm7677155ejb.83.2023.09.19.05.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:29:38 -0700 (PDT)
Message-ID: <1fd6fb74-40be-13e3-8a96-f4db358582d1@linaro.org>
Date:   Tue, 19 Sep 2023 14:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: Add Richtek rtq9128 audio
 amplifier
To:     cy_huang@richtek.com, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695086301-10376-1-git-send-email-cy_huang@richtek.com>
 <1695086301-10376-2-git-send-email-cy_huang@richtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1695086301-10376-2-git-send-email-cy_huang@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 03:18, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Create richtek,rtq9128.yaml for rtq9128 amplifier.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


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

