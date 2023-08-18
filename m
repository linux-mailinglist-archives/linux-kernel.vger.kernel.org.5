Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399B37808F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359380AbjHRJwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359375AbjHRJwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:52:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAB52D7D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:52:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c4923195dso85612066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692352338; x=1692957138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rw/a63G6w5B5qtZzy1HI13w7YRF8Pj5+EKoCvfJ/qRs=;
        b=S1oGvxjyN9yxvffmn4IkOZmj9gz1CVQnSlSFVA1L+G2HV4CuV4PCNJxsb03smRKwvX
         zYLHdGI6EvfZqYpILHJJNfHni1glg1dc8lBc92KQsZoLd3Ko+xICl7SG3gA5zxqFjGkt
         jCLriEfVeyAUkz3HZaYctRNRxYtXEfC8iqoV9Vbm4EtiSdbVGDZXILFSr+8lpLfousdI
         YnktD5vIKtd0NUJyk8mkb3oFwc0XzGQuwlrNTtH4Ssh3AM3BKOKSDs+wsejEb/zC8eET
         CyqVg0xl6eHeRtszW9B29XdsFAXpfQk9acAq2XeL/SyYf5wXgs1FtFhSCSnE5En2DZz8
         clCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352338; x=1692957138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw/a63G6w5B5qtZzy1HI13w7YRF8Pj5+EKoCvfJ/qRs=;
        b=jb95meP3wRvsx+1pMVYJMGOy1aWuAUr5vw2Wp8NbErOiUxJrrIw+ZLSFqBACRv/+/M
         ypYmYOGYGtOoU43lACSKuj6DFZ2LvTSIJ0MG3AQz8LKP4wo/LHkuV2u6XPZ6H8LvsHeS
         GTBETaV0kDGgxEaIx3+ovs27iQxwWSSddSayuNG8WfiWYAr4EJNAR3YVfWlocU/hL/02
         P17NwXXPqK2YUp0W4KigF04Sk8OcutaH/X9Zrs6v1DdEBZ2F1bWfJznttr7vR4sBuGhb
         nCW7+5eUt8SZJEA0dueOSruBfDmz4Nr1XyKnUoZJXl61dfTGbCyienGPGaXrMRUm0nck
         0Kjg==
X-Gm-Message-State: AOJu0Yx+5YfrEQf0VuL4tB/fnnjTug5BHNKt4f49oZVsk9bTuhZLpZf5
        sjZyngKXP0U2AsJmb95UczNFyw==
X-Google-Smtp-Source: AGHT+IHQd1eoTNPoP2RDth7XG1mJ4IWioPAPtRFb4qxTQi1S3CjszS0n18uXDRFchKoco0o3IpsyFA==
X-Received: by 2002:a17:906:2249:b0:99b:ef8a:d64a with SMTP id 9-20020a170906224900b0099bef8ad64amr1597226ejr.0.1692352337806;
        Fri, 18 Aug 2023 02:52:17 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906125200b009920a690cd9sm981818eja.59.2023.08.18.02.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:52:17 -0700 (PDT)
Message-ID: <acec7eb3-92b5-e431-f84c-500f07a2dd14@linaro.org>
Date:   Fri, 18 Aug 2023 11:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: Fix Exynos5433
 compatible
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816201123.3530-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816201123.3530-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 22:11, Sam Protsenko wrote:
> The correct compatible for Exynos5433 is "samsung,exynos5433-dwusb3".
> Fix the typo in its usage.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: 949ea75b7ba4 ("dt-bindings: usb: samsung,exynos-dwc3: convert to dtsche


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Greg,
I assume this one is for you.

Best regards,
Krzysztof

