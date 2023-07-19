Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1C759317
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGSKag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjGSKaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:30:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4E21FD2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:29:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e57870becso8943916a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689762573; x=1692354573;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsbdF3vSFjWOVf7tTPeAyNmYXPOrPPfpGyXWv71M4vY=;
        b=pMflW6B6zdC43SRPUZaBNyhVj9ywPekh1ELYAAqf0KlpE0hJGBH+W0q+Cw+ck5fBYV
         ymbC8xPJjNLICUR6EHbtArsWt4KeHjjU6xe+49HCiUWoCwxqgkSVijIhzhyHlV4ENYlf
         QqNapgCKPE+KhWpp0Lzz1eY2nNQyd1c98UIHgtNWjhyoQN+XR24GU0pIFvWE4P6rdY55
         fQ7dqFlUAyjHb3+GLq48He1mbQFjr9brzgkXWywQLzDgi6ooceElSVDDtVKGlQ0acRUX
         p0nuLr+M1NfwwPLJHe87MxbtgPqupsuabUz8pqE2fKQZJQXY5T2sI6XaY825SScC8TPf
         aunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762573; x=1692354573;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsbdF3vSFjWOVf7tTPeAyNmYXPOrPPfpGyXWv71M4vY=;
        b=HOiAQt3KtkY6STzog+Spe73kdOGuaD7pH+Ip742W4jMeW9eAF68snJjCRqt0FDUz3I
         VJ2B9SVuIEuzF0Up1flpwpgP5NqzeE5htr0m8ElC/BOt9PV8j8v6MEw7sEiRprrqOgf1
         bhUk6+m/RM+oRJU2YsaJLmbw7DxWskc9WOjysE9UVY+ClM6oXmLYGc1ShaJZ7ZXafi31
         9Jb5WXGGalSx/RwLJNyGgWbKQM2lHy8gTLdLIyrcCW/QB1hlphjX9A5m4R7GzcGNgYLK
         zxN+hiNTagNNxh/VMBGmglHnY6WbJhReg2iJY4UWFhKVzqzA9vf1pIGVglN2B57NOvAj
         Vn3w==
X-Gm-Message-State: ABy/qLaV7EDLNHgG+brV/y3rUOjd8r0HTVPd5AoZiOLfSZ9L8kq/8ZtF
        mYRK6oAGPZP8T7R6tsFz8FGm8A==
X-Google-Smtp-Source: APBJJlGjAQSiTv09hvjzoL2bHorCfqXaWQw+3rHRmToUpY1BWy3cRCU5AjBIV+sp0DuIyOQ3WgrdxA==
X-Received: by 2002:aa7:d482:0:b0:521:aa4b:24f3 with SMTP id b2-20020aa7d482000000b00521aa4b24f3mr2106665edr.24.1689762573695;
        Wed, 19 Jul 2023 03:29:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n7-20020a05640206c700b0051e2a5d9290sm2487874edy.77.2023.07.19.03.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:29:33 -0700 (PDT)
Message-ID: <6d9ded3a-415a-e879-2c80-e462c21ed9cb@linaro.org>
Date:   Wed, 19 Jul 2023 12:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] drm/tiny: add display driver for philips pcd8544
 display controller
Content-Language: en-US
To:     Viktar Simanenka <viteosen@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719102430.316504-1-viteosen@gmail.com>
 <20230719102430.316504-2-viteosen@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719102430.316504-2-viteosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 12:24, Viktar Simanenka wrote:
> Support for common monochrome LCD displays based on PCD8544 (such as
> Nokia 5110/3310 LCD) SPI controlled displays.
> 
> Signed-off-by: Viktar Simanenka <viteosen@gmail.com>
> ---

No changelog, same version, so nothing improved here?

Best regards,
Krzysztof

