Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D25766520
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjG1HTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjG1HSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:18:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5919AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:18:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso2286938a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690528727; x=1691133527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFRs+1l4ttYgce/W/Q/lR0//anrGUYTWZshXgYuQpfM=;
        b=X+8YpOCRlNu+CrYzZ9s51R51phORgLLkvU1YXhrdW4w3DQXRasewx+yxyK/GVhvqv0
         m6wo2m08SQArbieyg2c9eHYamZfJHMvQ9UMYU4EX7bqS7UsOWwi2wSpsgeopvZLgt1RD
         w2LMTxdQQrn6oenHpc2ZPpAlYtMuDy+TsEYOIo8gyykcJqYmkCtkC05G3M+MZvhuZeZn
         MwraUPRQUDxjDLIyH0g2yPlWHU/fQLHCbpDH4pLVw+2Iwm+HolXeILpXhjvWOcXJPBnE
         ZdtTKK9oXIu1mRsBQDqmTgeylHBOBDnikFUMkUw2GqVA3KYLHHoLXnJ7hsaTn2NAuudZ
         xyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690528727; x=1691133527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFRs+1l4ttYgce/W/Q/lR0//anrGUYTWZshXgYuQpfM=;
        b=EtKwD3LFVXTq2uRylPVTKsTHlgYNnDc8okyq9/5b+o40RT6tNuiQDIYw2TUfvTjQC4
         WzAr1pGEi1UeDDUvkm0FJKJ1YU4BCkB6LUNaPSgHJPSmiW8EWsDaXdjIXqZ9s/8wIghQ
         pD+Vr66Eh7AuuYZ5+0gFZqcVhZvzISElFTc4QUYMf+7TomSnjDxwatNpv+K4llcAfuCi
         F/o5bx3Y6r8baU0KApGCQMSnIxfKf+E9Jd+7ZZexfEFQ45YfY6Eu8pzpgAJ6884s65hX
         uKM5aq6nkgH50HChwvwhtycsuopk1XaIP2UBXe26TdOHPbmNnZbulkidDaH1IyMh+V5f
         CR3Q==
X-Gm-Message-State: ABy/qLY8BfYmFGWuSfXvowVvsUAQdtM37hsKBvVCzfxszTWjyZIyzHv+
        zq7oHqFeOmM978IDN61fyt+zmw==
X-Google-Smtp-Source: APBJJlHB7YcDxfEFdwmeU91iDamcQPeuv4jgYP8CBYnnw95qVTyfL/9+3ouqOSWZtgQ1H53Yh82/3w==
X-Received: by 2002:aa7:df89:0:b0:522:3aae:c69b with SMTP id b9-20020aa7df89000000b005223aaec69bmr918747edy.20.1690528727494;
        Fri, 28 Jul 2023 00:18:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e8-20020a056402148800b0052227c4384esm1467532edv.34.2023.07.28.00.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:18:46 -0700 (PDT)
Message-ID: <fe60d09a-aa79-f3b9-cf9d-e8ae8ff58d09@linaro.org>
Date:   Fri, 28 Jul 2023 09:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/9] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Duje_Mihanovi=c4=87?= <duje.mihanovic@skole.hr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
References: <20230727162909.6031-1-duje.mihanovic@skole.hr>
 <20230727162909.6031-5-duje.mihanovic@skole.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727162909.6031-5-duje.mihanovic@skole.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 18:29, Duje Mihanović wrote:
> Add dt bindings and documentation for the Marvell PXA1908 clock
> controller.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---

...

> +/* apb (apbc) peripherals */
> +#define PXA1908_CLK_UART0		1
> +#define PXA1908_CLK_UART1		2
> +#define PXA1908_CLK_GPIO		3
> +#define PXA1908_CLK_PWM0		4
> +#define PXA1908_CLK_PWM1		5
> +#define PXA1908_CLK_PWM2		6
> +#define PXA1908_CLK_PWM3		7
> +#define PXA1908_CLK_SSP0		8
> +#define PXA1908_CLK_SSP1		9
> +#define PXA1908_CLK_IPC_RST		10
> +#define PXA1908_CLK_RTC			11
> +#define PXA1908_CLK_TWSI0		12
> +#define PXA1908_CLK_KPC			13
> +#define PXA1908_CLK_SWJTAG		17
> +#define PXA1908_CLK_SSP2		20
> +#define PXA1908_CLK_TWSI1		25
> +#define PXA1908_CLK_THERMAL		28
> +#define PXA1908_CLK_TWSI3		29
> +#define PXA1908_APBC_NR_CLKS		48
> +
> +/* apb (apbcp) peripherals */
> +#define PXA1908_CLK_UART2		7
> +#define PXA1908_CLK_TWSI2		10
> +#define PXA1908_CLK_AICER		14
> +#define PXA1908_APBCP_NR_CLKS		14
> +
> +/* axi (apmu) peripherals */
> +#define PXA1908_CLK_CCIC1		9
> +#define PXA1908_CLK_ISP			14

Why do you have gaps between IDs? The clock IDs are supposed to be
continuous, otherwise it is not an ID.

> +#define PXA1908_CLK_GATE_CTRL		16

Best regards,
Krzysztof

