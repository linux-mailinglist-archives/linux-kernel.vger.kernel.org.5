Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50037D25E9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 22:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjJVUoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 16:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVUoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 16:44:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F6FE9;
        Sun, 22 Oct 2023 13:44:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso21143335e9.3;
        Sun, 22 Oct 2023 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698007452; x=1698612252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ubgw7EUHwh2i5TKOLdKPVsembpOTYUP/UvZXFU0rg78=;
        b=mDgkekMViIMHUVKEElk6WIEAcPnNNvN3lgdSnXe7igIQN30kPThBt2we2voqngV8DF
         fMTX7xTtPeM1jxT9eAJWIGCFS/9DjfaeRD0nvt8PqB5KmKPkJKpjnoXfZJ6tUPGuIEhI
         u4K1pCh4W3IU+YErDM1TFa9Ny+IZd8QbHJRATs+k99zDAEkOHnZTV4qetS02MoFJcI9W
         WD+Y2ZhcDIqFf7BLxIXuSfyokxE/9upBlpktRlW/MSnVAmi/oxvIpMgpyxGjAMLOGi40
         uiu6S8oDi7g6gp+SWVPEqKSIGae/sI6Iij1YvxcZ97XSyWg617nzL2rHxjVJ75GIhZMJ
         reuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698007452; x=1698612252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ubgw7EUHwh2i5TKOLdKPVsembpOTYUP/UvZXFU0rg78=;
        b=DVqQUdxzbFpmni4ejliis32a/6eX1sm8CaYir6633mcTzSIupE9+2pf+B9d7BhOhoz
         EzWqXYQqm7W+uE7D7hqn7HuX/BB8Jlf5QYsawXHQjsZEiYahgzxgX+hjRIzgnIAsqqQ9
         z/ovStXGrgpN+vbNLK+8b2FipVclmxpwXNB/yCCFlaLqqVp8o/TcSufUvLGsJOzniMD5
         8dYuk8u5zX1Pq5Ap5ZLPZUvTaKpv9bTCv1eq1q6hJAAXv0/2WJeduWnJX83Vk7CSMguh
         nqj+xZ7D6HYEOzN8ARLl4B2QZdYy/xrChYtReIocOiA1I9HrmCzSjTcQINUenFkBLX9O
         CQXg==
X-Gm-Message-State: AOJu0YzMyalFhdq5+VF5haw/taa1Sf8vukIlzKW8EyRTt2S9fGpoqC0p
        bQEWHcuc5KuoMkbr5kmllds=
X-Google-Smtp-Source: AGHT+IHZYO1YiVrh2DH1F+7+TsN/xjQg42iDfCcbvE3YbjU49pCuy7+y82CN88ZfctX3IIhkTcppsg==
X-Received: by 2002:a05:6000:b11:b0:32d:b6a2:8de2 with SMTP id dj17-20020a0560000b1100b0032db6a28de2mr5271520wrb.39.1698007452174;
        Sun, 22 Oct 2023 13:44:12 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4852000000b0032db4e660d9sm6259104wrs.56.2023.10.22.13.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 13:44:11 -0700 (PDT)
Message-ID: <6ea02e5e-bc95-48b5-d6e3-15338ebd0a4d@gmail.com>
Date:   Sun, 22 Oct 2023 22:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: usb: rockchip,dwc3: fix reference to
 nonexistent file
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20231022185150.919293-1-vegard.nossum@oracle.com>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20231022185150.919293-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/23 20:51, Vegard Nossum wrote:
> This file was renamed but left a dangling reference. Fix it.
> 
> Fixes: 0f48b0ed356d ("dt-bindings: phy: rename phy-rockchip-inno-usb2.yaml")

> Cc: Johan Jonker <jbx6244@gmail.com>

[PATCH v1] dt-bindings: usb: rockchip,dwc3: update inno usb2 phy binding name
https://lore.kernel.org/linux-rockchip/f8747552-d23b-c4cd-cb17-5033fb7f8eb6@gmail.com/

Already Acked.

> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> index 291844c8f3e1..c983dfe0f629 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> @@ -15,7 +15,7 @@ description:
>    Phy documentation is provided in the following places.
>  
>    USB2.0 PHY
> -  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> +  Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>  
>    Type-C PHY
>    Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
