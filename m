Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D47686D8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjG3RsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG3RsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:48:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C303E7B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:48:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99454855de1so533077266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690739289; x=1691344089;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXKQ+FT+ekXbJrRPEIuPYA+iGs9lD32lLjaVB8WOkqg=;
        b=NZXsMIFMSLCs4+QDwceXzmBnaaK14KVhIqegweudBDG32KMjauPNLPeLqW/387BC45
         SkiJXPT5Hr1Z0C9T8pTN9zhHJBwhXeLbHoj8inInwwBeUWWUq0VXKoS40e8q0Axj+fLK
         6pou8JxL1U2EaASYK22MCaq/54iiV4depgEG3CaEkSKkkBKGRMFdThbyy0DpkkAvbvbV
         rri+j6QoqREMkludmGpAVJOGe+kiqUMOWj0yS1Kp79rnpDIypCVtQpdkwONM7N84rew6
         8Q1enUJ/u8dKQFk2yTmGVLSt//LxWUUfOwdONFLAPB0Nez9Bs5mUhDu4daUsoWaRR9bf
         re1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690739289; x=1691344089;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXKQ+FT+ekXbJrRPEIuPYA+iGs9lD32lLjaVB8WOkqg=;
        b=CwoHO7yD+gZ+3i598H4VMNrwTBpMVFUusqVgK23/hekte8BU3hNJZfgYBGFm2iyYyx
         HTGshFC8EjTNCX/ntx3pprLb89Du/O+OUN9qDKPewpVd8ref1hMS3+UmIybKzsy9h8TJ
         yPZM2tWEphk4h3khoYblR7HfOVPzaekfxI5cSbRbQsJzDbiYgX9mS7+Yw7A1888dnPOk
         pMDgvFhLI2pfJUs8oQUuYiE5/FhmEXRnJB0inBY6AUQmf6HZhl2C4xpifRlH0RCel0IN
         aP0YjA+4P7D6wn2ZgUzqt4hXmBIpARhGsjoJwKvOFc4Zk6xqu6khFh+hYkZyKtNLgU+6
         xSUQ==
X-Gm-Message-State: ABy/qLYUg3KWkdPNH7ZYz8NPvQPmi4TC1TjKj86+u5sI61ZQjnRp7phN
        R3sWxjCunEQdJlNHoJtBpSAajw==
X-Google-Smtp-Source: APBJJlFZSxLeec25a5kiJaaoHg3q/S3QWVUH2q6ROn1ceOrFwC2RtorZVHCxlbc8BcE8bpP1BWThTA==
X-Received: by 2002:a17:907:7709:b0:983:cb6c:8aa3 with SMTP id kw9-20020a170907770900b00983cb6c8aa3mr4127267ejc.59.1690739288810;
        Sun, 30 Jul 2023 10:48:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b00992e51fecfbsm4976102ejo.64.2023.07.30.10.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 10:48:08 -0700 (PDT)
Message-ID: <222ae956-213e-264d-c217-45bb8d624382@linaro.org>
Date:   Sun, 30 Jul 2023 19:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 3/4] AMR: dts: st: ste: switch to enable-gpios
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230726070353.103989-1-krzysztof.kozlowski@linaro.org>
 <20230726070353.103989-3-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726070353.103989-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 09:03, Krzysztof Kozlowski wrote:
> The recommended name for enable GPIOs property in regulator-gpio is
> "enable-gpios".  This is also required by bindings:
> 
>   ste-hrefv60plus-stuib.dtb: regulator-gpio: Unevaluated properties are not allowed ('enable-gpio' was unexpected)
> 

Subject prefix needs fixes (AMR->ARM)

Best regards,
Krzysztof

