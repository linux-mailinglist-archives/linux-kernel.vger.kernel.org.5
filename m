Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D2773FF2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjHHQ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjHHQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:56:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6C419418
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:59:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bc512526cso850349266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510381; x=1692115181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMxa/gVKuibvIVWmpuZpFEwzt5/SE/hyALHDnspMprc=;
        b=APBgrt3C3itVlNbiO6kRKj9GJylAzpbSRWqWoH7imhPKP4364nZOfJjIuU8NP4tW0+
         OBLn3dRTQvbr9xaTZLE3Eq+Dk9FIxUOKTqZgKCdE//N/HNdbee9Xk3SJq128K9pBzgf3
         q39fkzthJTV1YTeBceTrvWDiINhKaUeM895bXJHwlQbVKgF7ps3Pc+I0mOQZmbX0p6rC
         UhFf6hfUn3sHjnR5yGJ19swURzA172Uc0IZ4508FtCASzqMUb+G3CMQHhb6SdLAJ02Mj
         4iXzIHqztOevMtzQP3xdoVamuz3EZVkcJigPVlGX/FG/X3DRViYo3lp97lIktNvSD4Ib
         jwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510381; x=1692115181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMxa/gVKuibvIVWmpuZpFEwzt5/SE/hyALHDnspMprc=;
        b=ZPIX0laS6kfpa0uTfhiiJdwVFVjLZDgZ7Rl1H1ghFbPZ4rMmO3iCmBb6KIKGgaIw6E
         H843p1szNl3880bYDVijkMTyopTLZ2SIWkf/BAyH1uDupOHYfDl+o3Lc8d1wWdYtX8eq
         KJimHrTI+rc77Ue4m7+iwivxh7A1s0IWo86wjbDkDcD4p84mVFMsNbwHJJlj8pBRSWdj
         lkogCHR3Bjg+19mELX6UQRvX7NbXvFWyzzV+886oV39QlaqyrdutwX4Yj4PH5BltO9qy
         hKjxK1bglC4c2C2xjrsT2Tg8Zpl8ZAsgfKlfefVBMVMwP2lhU1pwWw6Y+3NA4aE1FMdA
         mtEw==
X-Gm-Message-State: AOJu0YzrWjGNT+uyun+VMEcdFTLqrLbGc5bKHoEs7BF06sVp6th56wjL
        S5GfuPlElnzpUEdkIiiBc4Wn/A==
X-Google-Smtp-Source: AGHT+IHhsovjxambnGZbWubCZ75bBFP/uvpp7zDOuVqUVK6QAMMeX03Ka2xjCi2S22J1Wto5SIwDqA==
X-Received: by 2002:a17:907:2c75:b0:99b:4378:a5ab with SMTP id ib21-20020a1709072c7500b0099b4378a5abmr9603548ejc.74.1691510381238;
        Tue, 08 Aug 2023 08:59:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id bn10-20020a170906c0ca00b00992b0745548sm6886811ejb.152.2023.08.08.08.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 08:59:40 -0700 (PDT)
Message-ID: <49edf46a-b35c-1135-c500-2382a453e58d@linaro.org>
Date:   Tue, 8 Aug 2023 17:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] dt-bindings: i3c: ast2600: Add resets and reset-names
Content-Language: en-US
To:     Dylan Hung <dylan_hung@aspeedtech.com>, jk@codeconstruct.com.au,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, p.zabel@pengutronix.de,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, kobedylan@gmail.com
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
 <20230808154241.749641-3-dylan_hung@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808154241.749641-3-dylan_hung@aspeedtech.com>
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

On 08/08/2023 17:42, Dylan Hung wrote:
> Add two reset lines to the AST2600 I3C controller:
> - core_rst: the reset line of the controller itself
> - global_rst: the reset line of the I3C global register block. Since all
> six I3C controllers in AST2600 share this global register block, the
> driver needs to handle this carefully. Generally, this reset line should
> only need to be de-asserted.

The commit msg does not explain why this is now required.

> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> ---
>  .../devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml  | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
> index fcc3dbff9c9a..3166d6f3a39c 100644
> --- a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
> +++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
> @@ -23,7 +23,12 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    maxItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: core_rst
> +      - const: global_rst
>  

Drop "_rst" suffixes from both.

>    interrupts:
>      maxItems: 1
> @@ -48,6 +53,8 @@ required:
>    - compatible
>    - reg
>    - clocks
> +  - resets
> +  - reset-names


Best regards,
Krzysztof

