Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDAC7A1785
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjIOHbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjIOHby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:31:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BFD1BC5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:31:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-402d499580dso19631365e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694763076; x=1695367876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psUYRiGcbU1OwB/5y/R6sSINX0z5CsdjGxmapbhxkEc=;
        b=v/YjmCmDec0SFlavo6P/GLK57KBK2RaL6JvN3y7sgHo6fiIHnjDfUy85awapzDqX0v
         eAI6j2PEZMqbf4S9Fijoar88PDDnnuYNe8WIUu/KyaS5BPVbww9UXR0mjLkuVa0CFklw
         c8BgkuV9v5vwlPgBod3rXIrKTISmWkBIQGuMJ7Awb0edDONqKt9qsr51i1GstKSFwBkx
         3Eok5AxQ/IY51c8v2w4z4ru/Ju8NmApVfFnvGZbFd0e6Tc6+SBqlVJuYQ1mR64BfGlr4
         DpPHUX4H0yRDRvtZ8WswlK/pTmpNHj3EMNTzkoOod7fB5iFPdVE7XTATvzOWT56yapZO
         TjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694763076; x=1695367876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psUYRiGcbU1OwB/5y/R6sSINX0z5CsdjGxmapbhxkEc=;
        b=hkYhHrTfvgKolqpGu2hiHx/beLyOm+NIANA22BxOydomxzE71QWd9E0sFhfr/QkO0g
         H7NJgpvpE9dGeP2KV2olquDDNZ0XSOuFd6iF/upnwchNUpLKGCXBbd9GN/0xshxrcmic
         rRewrAgECm+GwUJOTRXU2qgaJnglDChuq9dPN+sgJHwusI9fDM2AH7GHJxZBVxVPsRLk
         Ss56o1+01WKkzeFhvjz/66/WUzSI3I1aGQP+q8cDMRZL8UqX7IIMvDmK+Oz+uOFAKiCP
         mQtXGjIc0fks6bCN5ZlFx6WzwDQ2i6K0TXCS2YDH2TVUcDA3o367IoYJ2BA0r7h4NYoL
         f1Yw==
X-Gm-Message-State: AOJu0YyKlCMilG7+ZBqC6jr3Jf3XVDqXlYgpvat//sTxQ/TxhQDhasI1
        zpfPYRO9E1jPGHeQ81zLyFlv+Q==
X-Google-Smtp-Source: AGHT+IEzcssOytMiuWez42gEHao5Kw2NkuxenhdyXU5euFPWe8NZ4zTEcTm0nySnu4uCOWK/ADVkQA==
X-Received: by 2002:adf:ed8b:0:b0:317:7330:bd82 with SMTP id c11-20020adfed8b000000b003177330bd82mr772813wro.8.1694763076095;
        Fri, 15 Sep 2023 00:31:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e11-20020a056000120b00b003196b1bb528sm3719683wrx.64.2023.09.15.00.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:31:15 -0700 (PDT)
Message-ID: <0c059b65-181f-3e87-fb51-64435ad5bc0c@linaro.org>
Date:   Fri, 15 Sep 2023 09:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 03/12] dt-bindings: riscv: add sophgo sg2042 bindings
Content-Language: en-US
To:     Wang Chen <unicornxw@gmail.com>, linux-riscv@lists.infradead.org,
        conor@kernel.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
References: <20230915072242.117935-1-wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915072242.117935-1-wangchen20@iscas.ac.cn>
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

On 15/09/2023 09:22, Wang Chen wrote:
> Add DT binding documentation for the Sophgo SG2042 Soc [1] and the
> Milk-V Pioneer board [2].
> 
> [1]: https://en.sophgo.com/product/introduce/sg2042.html
> [2]: https://milkv.io/pioneer
> 
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>

Fix your email threading :/



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

