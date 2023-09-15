Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA497A1778
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjIOHaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjIOHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:30:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F901BC9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:30:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso20476225e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694763009; x=1695367809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2EYiqatqk/mmeH++F9aAHu7AJpxnj8N1J8p9RtMdAg=;
        b=UASsDevONc7DpbsDNodpqOkNqH9bY5cjZfpryE631e5wyLGrj6a6CJt341cg8OEzKV
         8GkOlPiUq8wG9BqG4y2k8uAfYNbwxj/6yEc5lA/yTpmToMHLETNragqvEXW8KoRy8S0a
         urCXfLl8J9VGiFG9r1f2QyHH0Mlzr1H2TedUd8nWGnK5v3PZLxdaSVitNkisN7Yex0GA
         BvZx4+tZT6Ra1lwogsyiHuN+cbrj7IsoJmo+JPqJHl1oHlJXBUTgICqC6bnnOPE310t4
         3wiOzXnOZTG7MHcQBjZ++gocyRxhrdirSXdxv4qqtJaSVyPcdBea+XCPY1i/6nv5/4gR
         T1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694763009; x=1695367809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2EYiqatqk/mmeH++F9aAHu7AJpxnj8N1J8p9RtMdAg=;
        b=goox9pNbiBi3ekwqhX6MWekncEbqfHP2LMNdgJQu/4tFfQYWhFWM2YzAPbdud7ysJL
         OvwlZbPh/tkkNGpuoM+z7Sv3hbQNsaybVgHLHi+f2NhvZfQ+LGJaWi6+MYcQkZCZ3JX5
         eoXYwr3K4pNFU28x24py3vwWDzFx72gZwEsGpNvakZx61pUylgkw6xV6PXXkw8e/rUdt
         zRAKk5MZiHfjKYPCpknzRUvv72Pzx+R9yJEZF5JIe+BykoDyj9mcS9d7tPFbDUpUNcqb
         4hKruSEMYM2goRQ9LEzIKkKWU8quoMhKjc5X8QKrDqoElJUmECYaiZkyezRN1toc60Hu
         8xyg==
X-Gm-Message-State: AOJu0YzRbQbvsIANXWl45AiVjJkIjX1AQDnUrk9Ie//du3HNrtTVXW2z
        g/RTLRBNh9ACcNiWMjI4aeQqAQ==
X-Google-Smtp-Source: AGHT+IF7980nHByDaff0z5ewi2mUURn7ocVGdQTtGpw9rYCqn6ZZNLdUhnzi5ATsOWz+mZaHFsrIrQ==
X-Received: by 2002:a7b:ce93:0:b0:3fc:60:7dbf with SMTP id q19-20020a7bce93000000b003fc00607dbfmr843441wmj.41.1694763009367;
        Fri, 15 Sep 2023 00:30:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id s23-20020a7bc397000000b00403bbe69629sm3840766wmj.31.2023.09.15.00.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:30:08 -0700 (PDT)
Message-ID: <a57827f6-1af1-e914-fbcf-74e99413eb05@linaro.org>
Date:   Fri, 15 Sep 2023 09:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/12] dt-bindings: interrupt-controller: Add SOPHGO's
 SG2042 PLIC
Content-Language: en-US
To:     Wang Chen <unicornxw@gmail.com>, linux-riscv@lists.infradead.org,
        conor@kernel.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
References: <20230915072358.118045-1-wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915072358.118045-1-wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 09:23, Wang Chen wrote:
> Add compatible string for SOPHGO SG2042 plic.
> 
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index dc1f28e55266..3abb1f68ea62 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -66,6 +66,7 @@ properties:
>            - enum:
>                - allwinner,sun20i-d1-plic
>                - thead,th1520-plic
> +              - sophgo,sg2042-plic

s is before t.

Best regards,
Krzysztof

