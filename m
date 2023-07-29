Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE5767E94
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjG2LSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjG2LSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:18:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C081A5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:18:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bd1d0cf2fso422172866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690629486; x=1691234286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eqa0WFoYInEcNI2I+h5DdsTKLO1lHB99H7qWxbe2rbs=;
        b=AMtNRdNw40PF6v9NFEnUbNyil/bZSiU3GWSPFKCEtT9fAq0ehX+1pwG+S8LPu/Q3F0
         6kAjF2bpTFYd6RyWwO0InU9i9hpAYy2/+IUzjs5tRceICs2c60hVxssHWY6G3WIZ/wzc
         9aXEQLs6Vjll321UVSZUp3vSNYbGGZex43TiPMjD3EkAY4kkU2QZa/u/gO1399ULn1kg
         f7+d3XiTqXKBZ65xFi21Y3W4GlkbyDGg9esGW00pPJDi9q7/u5Ph9RWwDdnkLjodNjxv
         OoBJx9oXJUIcy8MwdcWw6SD+yA+bBJ5OJXlyItJq0fcbJACASWjK25C6rdqda5Sl33Vy
         WwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690629486; x=1691234286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eqa0WFoYInEcNI2I+h5DdsTKLO1lHB99H7qWxbe2rbs=;
        b=SNF/qKNJeqwFNWmS73rSVeb/BjLArYFQE2Ubs+eDKLEhP3Q/e41WST/Rue6qWLEKh7
         RlcE65q7hzHCZSIpmXD3m8LLMRG9NXYHrpM/6Bv5I6uBOuOBy4q6h9ua2zxLmEh8boaQ
         Gp0Jl65G3+3vJptr3GpiU6MuyJGchnIR5PiQWb+pdm0Wty3bnVJmhUWIceB7EPeRb7os
         LDo5g+5g2WeFJ1JzwsBnm7ugaNfKy+wLO7KGI9YqngUPBybWStGWw2mfMsPQ/OzyQ/Ga
         SHBLem+bXA0RpGqrRvqAWeNATWrnRaarjfIEDPPyP2odrwrURBRuAGobPIlEhYx2AfpI
         Ac/g==
X-Gm-Message-State: ABy/qLakcJFRaqNqmciPeDi3tijo/hOgoWBkfmNS7N7lmBAYQqgFhOY2
        hm3TQfAALbAQQVKbrpp8tPPYJg==
X-Google-Smtp-Source: APBJJlEkQGQRcewKkAwjhvPMyxCNjkMEEW1B7oPxKPYIoK0kUjfqQYotwVF5uAKLDyIlvjJO0Hhcww==
X-Received: by 2002:a17:906:739a:b0:98e:37fe:691b with SMTP id f26-20020a170906739a00b0098e37fe691bmr1920911ejl.34.1690629485669;
        Sat, 29 Jul 2023 04:18:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x23-20020a1709065ad700b009893b06e9e3sm3203982ejs.225.2023.07.29.04.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 04:18:05 -0700 (PDT)
Message-ID: <b68021a2-c108-e865-be42-ac8ec2454501@linaro.org>
Date:   Sat, 29 Jul 2023 13:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 1/5] ASoC: dt-bindings: Add schema for "awinic,aw88261"
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, shumingf@realtek.com,
        ryans.lee@analog.com, 13916275206@139.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, fido_max@inbox.ru, povik+lin@cutebit.org,
        liweilei@awinic.com, yijiangtao@awinic.com, colin.i.king@gmail.com,
        trix@redhat.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
References: <20230729091223.193466-1-wangweidong.a@awinic.com>
 <20230729091223.193466-2-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230729091223.193466-2-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2023 11:12, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add the awinic,aw88261 property to the awinic,aw88395.yaml file.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

