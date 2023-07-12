Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0A750FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGLRrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGLRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:47:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CEB19BA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:47:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-315adee6ac8so919676f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689184054; x=1691776054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOaV0grZnsNI4Fl7DZBG49fG2tc/HAbGipS8Qo3wc0A=;
        b=qqWpmjJrFuel/DHvEJJKM04xvz1Mk7oGZfhLSuUe7UHU+51lpdyKCFIUnyB1FqnWYV
         6ZNvYeMuOoy3U24y24JMAoVZBqhVp0nFHB/Jh37up8BBuAeLy9NZmWwx7GpvPg3P8DBC
         A6BnTuVO4XKfOtY4yTA5DZ1DaRqqChwRAsAB8oSOqYCd0Ev4oZzrL1mhpeQ2Z7HKm7XR
         iz3hxUkgDPX385zrHQPKCDX1/9vgXcH9BkY62IeJi5i1YatDDWRNylND/EsoOylHP5Sa
         mhNfmIzOHwP9tLztfhrXX27LoNjHhxN8NVLm3jXlqhchBhzAk8IYqtbVmztDB/zrm6JO
         lfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184054; x=1691776054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOaV0grZnsNI4Fl7DZBG49fG2tc/HAbGipS8Qo3wc0A=;
        b=BdmiDw5sC4AAObe2CJ7wmHf1I0cJJQKamgF5QoDxTaTYtVUmRpgVQJ6JxikH5LyLZx
         YM7eG7LMw7ui+iStiIGdBjKLY/47K2KxCr20AoLd94FwjlXcRTnPtTSmcAqPY932seUa
         JIk88IM3k4eRN5/3jXgIoVL7qSvR+RDPMHUHj2FfM31y0X0Iodl9heGjIC93AFTxYzGI
         R+eZuKP3a0GxhnwoS34R5LOLouvxIuoPwlDWw0VaDO6/A6W7YA/jyyi318WkNPD63+eM
         iogv0QIcyNd7zqHvcD+Tr6Y85rmrrgqwNFeUtgcx39Bmeg0nNt/P7kV03mBQLNPxEx5q
         RYhA==
X-Gm-Message-State: ABy/qLZ4d/BCZB1QGmMcOqI42yDqUx4wWfRHe4xfCBXjR1KvxjLyfyYL
        rIFSaP7DBeQc3uvAQlT+crYskQ==
X-Google-Smtp-Source: APBJJlEJfjGeLanhi9Xmn6oDNZ6EyRFZ+2EPPqjkpGpuBEYKKYnpLHusa3fMPgQE13YQQA35khbMGQ==
X-Received: by 2002:a5d:6e5c:0:b0:313:ef96:84c8 with SMTP id j28-20020a5d6e5c000000b00313ef9684c8mr16023951wrz.67.1689184054645;
        Wed, 12 Jul 2023 10:47:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709064d8700b00993004239a4sm2802472eju.215.2023.07.12.10.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:47:34 -0700 (PDT)
Message-ID: <217c37be-996d-82ef-ee50-68feb341df26@linaro.org>
Date:   Wed, 12 Jul 2023 19:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: gpio: snps,dw-apb: allow gpio-line-names
To:     Andy Shevchenko <andy@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230712074553.35907-1-krzysztof.kozlowski@linaro.org>
 <d25vlma6vefztgggatas7ipn36rumhuodzcalfq7c6apwliy7a@ddgo3fgulv2s>
 <ZK7GqJlXhCIcA/J2@smile.fi.intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZK7GqJlXhCIcA/J2@smile.fi.intel.com>
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

On 12/07/2023 17:28, Andy Shevchenko wrote:
> On Wed, Jul 12, 2023 at 12:53:00PM +0300, Serge Semin wrote:
>> On Wed, Jul 12, 2023 at 09:45:53AM +0200, Krzysztof Kozlowski wrote:
>>> Allow the GPIO controller subnode to define GPIO names.
> 
> Are we going to do this for each GPIO controller bindings? Can it be done once
> for all please?

No, because sizes differ. Although here the size is anyway flexible, so
not much benefit of it, but in other GPIO controllers it is not flexible.

Best regards,
Krzysztof

