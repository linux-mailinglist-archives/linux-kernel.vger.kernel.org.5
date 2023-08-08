Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A169774539
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHHSi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjHHSic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:38:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C113A9E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:29:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5234f46c6f9so106297a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691515791; x=1692120591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/ENPbWDACTq/gT25pwElyGsToVBQemAbfEgTyGefM8=;
        b=QVAQRjJAZxjR7NM/wpip7qp2r55aFMRxg+0Z9HSNCq/VrKy3NLv44xcR+IYwtctX5O
         nR92sMUyEMx6lEsRDWOLlfTMvBZVVevFQoywL2sbdg7jy6f33xLt/tviz9aqgOzmoCAC
         /wPuAXfTu5KGF39G5zUiC21k+ITBap89VyS/3pkY4k8FkNm5uAWocR7BQGbxFZQ7Lyxq
         T0CTrn2EDq6kd5LIgSBoZHu0KOXL0hSUeg5EpprqD5Cvcoycez3KNaxuWBp4Vichv/3A
         ALDzHpuxxX5Cj5n06ACnMM71Bd6ltxV5mvgcC9eYi/DRIb6o0x5A2hDveUvnzWwiR3ih
         sw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515791; x=1692120591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/ENPbWDACTq/gT25pwElyGsToVBQemAbfEgTyGefM8=;
        b=i4yItM7jTWWwPHOcz3KNUjYyrA3pTQfGg7h1xSJlnJb8atiisIGcAXYrFQ9otWoT37
         Eg6dqH4O5p1MT8tRNp6rAhQMmiUH/+oOVmENZM144WWiBRwIypfFbaiAWY5IH19Nt36m
         Zy6r1YOCJfPKDVTQVyIxYh694tGqGNvgjLHvjEjaaf29QgjCW4IEu1bDhXSHLOiXnJql
         G+603v2W86pM3uqwyJ6vQ5LNdiURhIuB8RXj6NyoiOiblTCuZx98HXd1atAO8ABkFj0V
         rHo8lFHylaOw//+BN1n7uXY6Rita2DRWCmJ2aaBkSRUMX1425FkNFXysPPJyQkcq3DIC
         J5oQ==
X-Gm-Message-State: AOJu0YykcQcv9hz95R9iamrKWy/OFSd4Ih6yaJ+o9KuDZzlmrNUd5PTf
        +lVD9b7mfC0YhqA/3QCtb6qAWBxbC8S2wZh6kq0=
X-Google-Smtp-Source: AGHT+IH20o5oXu1MzFaME7Vqm8k1vG/h5IULgofIK8nWT0wfuYK0Ryctno9bzeuLujRtR/SQOzZBWA==
X-Received: by 2002:a17:906:d8:b0:99b:ca5d:1466 with SMTP id 24-20020a17090600d800b0099bca5d1466mr11379531eji.66.1691474329221;
        Mon, 07 Aug 2023 22:58:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e4-20020a1709062c0400b00982d0563b11sm3463474ejh.197.2023.08.07.22.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 22:58:48 -0700 (PDT)
Message-ID: <9e235de6-972a-84e5-3e09-f0b07b10e28d@linaro.org>
Date:   Tue, 8 Aug 2023 07:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 0/8] Initial Marvell PXA1908 support
Content-Language: en-US
To:     =?UTF-8?Q?Duje_Mihanovi=c4=87?= <duje.mihanovic@skole.hr>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
 <5723818.DvuYhMxLoT@radijator>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5723818.DvuYhMxLoT@radijator>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 23:02, Duje Mihanović wrote:
> Patch 8/8 is missing because b4 lost connection to my SMTP server while 
> sending it. Should I resend the whole series?
> 
>

Just send patch 8 manually setting in-reply-to= argument to git
send-email. b4 maybe also has this option, I don't know.

Best regards,
Krzysztof

