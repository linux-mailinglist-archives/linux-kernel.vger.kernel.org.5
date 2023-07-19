Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD3759E47
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGSTMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjGSTMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:12:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528C1BF7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:12:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so67626075e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689793939; x=1692385939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvEd31taP6wRlK87QhahHcwJ2xv09Kelq5ZrE/jUkus=;
        b=RvVQYPe8RGBdZ0GX4ZHzlJeksnNyFaI3oGxbC3lkCMAqDDYGSE/xRCC/uHtjgEtvts
         h8HF6UKbjfaD24l0eLWrgvsm9P7LoONlTdSjV7Q+lPaKNkV8mGfi0TbqV+IzRmz/Z7S1
         WoUNxoa0WK4O1E6m1MsO4XQ8K3f/4R+5Uv5FXyjvo1L68uXYoehq990tWk4v5kknm7DC
         0IjAyV82/ljwoSgtJdvMmM/8xCLP4wFyYb4CtgU5lV4u10aTT28yQ2Okf1YLxKBEJPlc
         LBUi15++rvWzVl3/rMQ+lo9ahfi6IJCuEP1ltmFxlNckTyPLnNNadr7Sdpl2OeqIADoJ
         HLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793939; x=1692385939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvEd31taP6wRlK87QhahHcwJ2xv09Kelq5ZrE/jUkus=;
        b=Z/w7QzCjJC9N9UjDxU+4eknF2I1IoMUqOHMgz5cz5zXSTya+gSA77A4TtgK+rlu/bl
         N1wW22QvxMeyciFEjn7gb5RPMyBZyffed4Xwop+s9KDfBXU3+sCA5LcGpCHnsavtW5Mt
         EmLlNGlyrhAHCEma/LAy8DmCp8yP6Pu/cD+o5YV87lmpNYRcEz1Q5wtLb0qAS8bgeHR6
         3ynb0BSgl0jynksCYyTIdNBu3lHRnQT/pmxoqVroWGPPKVXbdgUZ7K+f+oHPtOAFrQ9s
         KBnKC7yPZ4/PA5wCB6kF5ceIy1s2DIumX8BfM9qmH4GdgNGSp6mqL0Wc9pzGx3j0mJaD
         Imgw==
X-Gm-Message-State: ABy/qLYPUluPSWiCryH0IC9RslbqQ/0LoszfbuEci3mLPB1oauYFSgOT
        XrJnwvfLuK8IRIUvye2K/YtP0Q==
X-Google-Smtp-Source: APBJJlHV3QTWLiDrXN1wXQpc5tvZUnIgvqfABF7e0qbLd5AUbQE0ZrnB/TUSRe5tzJ0INWbVauth0g==
X-Received: by 2002:a7b:c7da:0:b0:3fb:a2b6:8dfd with SMTP id z26-20020a7bc7da000000b003fba2b68dfdmr2596160wmk.32.1689793938728;
        Wed, 19 Jul 2023 12:12:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c230700b003fba6709c68sm2334548wmo.47.2023.07.19.12.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 12:12:18 -0700 (PDT)
Message-ID: <a4ad14db-f3e6-a9a9-c7a9-b64bf2b3d33d@linaro.org>
Date:   Wed, 19 Jul 2023 21:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: Add panels based on
 ILITEK ILI9806E
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20230719152147.355486-1-luca.ceresoli@bootlin.com>
 <20230719152147.355486-2-luca.ceresoli@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719152147.355486-2-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 17:21, Luca Ceresoli wrote:
> Add bindings for LCD panels based on the ILITEK ILI9806E RGB controller
> connected over SPI and the "ShenZhen New Display Co NDS040480800-V3"
> 480x800 panel based on it.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index aee340630eca..3c38699ee821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6515,6 +6515,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/ilitek,ili9486.yaml
>  F:	drivers/gpu/drm/tiny/ili9486.c
>  
> +DRM DRIVER FOR ILITEK ILI9806E PANELS
> +M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc

Nope, same for recent one-driver-subsystem. It's like a second try...
You do not have git tree for one driver. The git tree is for subsystem,
not driver.

Best regards,
Krzysztof

