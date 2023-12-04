Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84F803BA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjLDRdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjLDRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:33:30 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BE5B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:33:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b4746ae3bso42824715e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701711213; x=1702316013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sug326j4RkqoO9Ptow3nZ3kvcZ7Swug2lDF9621hV9A=;
        b=f7MytYUbrdtausDhteiUMCXlZNoYmoLBj8Om99FuRmFo1j1dgdrCQ9n0o7I+pYai6y
         E5P3GtQS1mC12rQmHbhdnpw0UBurWft0JOFNeSz0GHKzxRpxCexqQcKQ7cm99/yzyU2i
         0Fm9S1llnC1fFrvOthitXmDtb0P6qSNV0ozR4aqL81RPryLcYoUkvi52pTlPl4RO1m4f
         h/LfKTEFyRNaAHNSS+VDIP1R90zyBR+UQnve/ra68P8wdiQI2ZAp1ihPbfPj3ogd44wU
         sZs80uW8FS7tIKUOv8qewsptWMHDbMw2Yv6EKXSz0NWMWjL1MVVQcRVEle++rSIbGuv3
         dFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711213; x=1702316013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sug326j4RkqoO9Ptow3nZ3kvcZ7Swug2lDF9621hV9A=;
        b=pgZV1hBCc4HqDvdjlZmMSu3ymFCHTIXhE6BN3XNlXfPDp+bN6fR/Gqp9Mbp6vwNKqB
         jvBBRvvlZPyF+iurqDbPtHuZmoHMLMNNRXMoGKDkPKTA2v9sgbekPnssCHZZqVCodiAH
         182+0twS0exm1GR9yFsb5WtCqbGv54PdlHJl7xrKUE5is2PFuvzK8vNd6AGdm5+xHedM
         ODrOHN+o8zioX6KoYgqxSqLwc5dqnZpMhs6h3QRwXl2OjcSATTaZEjlWEzORuCUgxi3H
         J1nbpa7HuP7em2OKkbG7vSe8r0QpA0e3kFh4cqqp794+xCDnd9auJyNvN/5gSronIxfx
         ub0g==
X-Gm-Message-State: AOJu0Ywc1tYufM0Z9P/LiBzdSLLxaFqjEygz8iTWfgHdq+I3FDMQoHY0
        4nSbJxMAnebJLRaBZaU2wI0I8Q==
X-Google-Smtp-Source: AGHT+IEfufrDY6qwjOLalRVS7Y554Xwet3E/NEIZZ+pHinD5dFboEosniYAItYzJ7nNnf+ykmvOhMQ==
X-Received: by 2002:a05:600c:296:b0:40b:5e59:b7b0 with SMTP id 22-20020a05600c029600b0040b5e59b7b0mr2669578wmk.141.1701711212988;
        Mon, 04 Dec 2023 09:33:32 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c831:1e47:2:5b96? ([2a05:6e02:1041:c10:c831:1e47:2:5b96])
        by smtp.googlemail.com with ESMTPSA id h9-20020a05600c314900b0040b3d8907fesm15826309wmo.29.2023.12.04.09.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:33:32 -0800 (PST)
Message-ID: <09b2fc2f-dde9-4f43-9704-d8053bfc85cf@linaro.org>
Date:   Mon, 4 Dec 2023 18:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Content-Language: en-US
To:     Inochi Amaoto <inochiama@outlook.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <IA1PR20MB4953C912FC58C0D248976564BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49531ED1BCC00D6B265C2D10BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <IA1PR20MB49531ED1BCC00D6B265C2D10BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 10:51, Inochi Amaoto wrote:
> The timer registers of aclint don't follow the clint layout and can
> be mapped on any different offset. As sg2042 uses separated timer
> and mswi for its clint, it should follow the aclint spec and have
> separated registers.
> 
> The previous patch introduced a new type of T-HEAD aclint timer which
> has clint timer layout. Although it has the clint timer layout, it
> should follow the aclint spec and uses the separated mtime and mtimecmp
> regs. So a ABI change is needed to make the timer fit the aclint spec.
> 
> To make T-HEAD aclint timer more closer to the aclint spec, use
> regs-names to represent the mtimecmp register, which can avoid hack
> for unsupport mtime register of T-HEAD aclint timer.
> 
> Also, as T-HEAD aclint only supports mtimecmp, it is unnecessary to
> implement the whole aclint spec. To make this binding T-HEAD specific,
> only add reg-name for existed register. For details, see the discussion
> in the last link.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
> Link: https://lore.kernel.org/all/IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com/
> ---

Applied 1/2, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

