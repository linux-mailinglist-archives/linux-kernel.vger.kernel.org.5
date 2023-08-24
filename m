Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9ED787771
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbjHXSHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242967AbjHXSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:06:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7148A1BDB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:06:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50079d148aeso98775e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692900391; x=1693505191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXj7S19q5RtNo0D6iEd60OU8sFKZ3w5IrG/8uMz9J+Y=;
        b=Ki5a+t6UrQ1+9tLh7WV4ENOQmIOrWU6BmGDMU8UqYaFeZE9pPEOZYZESCIffhk8M1O
         YPZNXY0mZRFBW5BCBfyPUwnJsUcUA0sxsXjYb40YDXmWWQwZFfxqIUYa7upR5ev2fBcX
         CKBi2M4O1sdyvu4eBzBRlVn7Z8qkLzvofJiFNPD289RLB5bIldVpNXbivz8P08qQXAEK
         HZOXNDNWHE7iYK5NAcDu/l33E/HipVpF/y3xwCHCQQT5DG9WE3gHM2ExyWYiLuwRmu2a
         amCDOMNHvfRQ3n6KRtPhxOB7tWUCeg9ueZl8ZGV+wPVbB6KUQJfE3EtxvbedTWXiLy45
         SgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692900391; x=1693505191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXj7S19q5RtNo0D6iEd60OU8sFKZ3w5IrG/8uMz9J+Y=;
        b=LJ+1Z5RDrv3E7XEXW9bIIXIc1vEF06+VrigBH/VuAgFQa/LMW1ABzUgHwvvyqZDrV3
         WmmUpSoEqpepTUwmcTp9VXjtBzay4lROY0TFF8PS0WBXYDsPXJxww4vT5HDxb0fZmk/E
         4d86no+GUX+K2rXUvfdcEquLbLHzH5yCib93Gzpj3PyOIZYOhhHOSg1DvmMJbXgqhHGT
         EcbKtm/jezabdJtVFdC+VCJW3FtBerAbatWhWZFAUUz2/DEQroEvwfbk6TyegcsY2ws9
         aLWtM+8IgbYOsrmw4FL/u74HWekUsu9NIsJRJA2ginV+b/za+RVc4VlKEi8zwrx2as5H
         bBrQ==
X-Gm-Message-State: AOJu0YwEDxUHnapqiA+rrKm87dCD+i7WRLGpvsXM+LEk5OHZxLE5ANP6
        ClMSJEeJFn/hu1Es1EGjuX62rw==
X-Google-Smtp-Source: AGHT+IHvVpbN9zi77RkQ8HXMO7WXhe94dT4RB/bcvBKwuEkMOB6WxM8tK+7RaBfXqx9rlD5oCnH8rw==
X-Received: by 2002:a19:791d:0:b0:4fb:7675:1c16 with SMTP id u29-20020a19791d000000b004fb76751c16mr10077974lfc.49.1692900391074;
        Thu, 24 Aug 2023 11:06:31 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id z24-20020a170906815800b0099b42c90830sm11256190ejw.36.2023.08.24.11.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:06:30 -0700 (PDT)
Message-ID: <84865d1b-1322-2f40-2c1b-069f12e6ea29@linaro.org>
Date:   Thu, 24 Aug 2023 20:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] dt-bindings: clock: meson: Convert axg-audio-clkc to
 YAML format
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alexander Stein <alexander.stein@mailbox.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20230824164649.2914789-1-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824164649.2914789-1-jbrunet@baylibre.com>
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

On 24/08/2023 18:46, Jerome Brunet wrote:
> From: Alexander Stein <alexander.stein@mailbox.org>
> 
> Convert Amlogic AXG Audio Clock Controller binding to yaml.
> 

...

> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 29
> +
> +  # All clocks except pclk are optional inputs of the controller
> +  # which may or may not be wired in depending on SoC variants, boards config, etc ...
> +  # The order in which those clocks appear is unpredictable and does not matter.
> +  # Lacking a better way to describe this, the optional clocks are repeated 28 times.

Use pattern.


Best regards,
Krzysztof

