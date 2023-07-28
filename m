Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31095767219
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjG1Ql4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjG1Qly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:41:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF0B421C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:41:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so2992528a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690562507; x=1691167307;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orpfdfVEmFYyWCeY7K4CEDuayTWlQJluljmwDPaIJMo=;
        b=mwZIO7Gspo6sMkmffElsuFvo0BcnCnlzeyCERZ9wG0iSUPIXbFuWNMpdgPmb4IEMdg
         sRBo+2uCGXF9Z5UMaHuS9yGM8iTW27IWYBrYCRmPWNhNDQaWQPLYwKoLUU2SzGr+nxZJ
         dtRoNV/12YVV7eeo239sqsieXUH3MDoQ6sAfMLQypfHAwzzTBp8lK3rm7tKMQKp6+lTl
         d3eIShO++HI+IRiuj72pP2Mix3proUCeTToz1My1axqxx2LRJTO9E8+3u05XA5Z5BIq0
         vAvCdFnjxRn6ClNMaBQeF+46zPuQTGnfCK8UESIJLA3/ZSKJPEhK7y4mi+c31/tk+0WU
         6UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562507; x=1691167307;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orpfdfVEmFYyWCeY7K4CEDuayTWlQJluljmwDPaIJMo=;
        b=Sh1i8JVvmvWlwboIfcGUMbZHnK3oJUXcfJmvOlQBkOlfHYdXq9CdEUCQfYilsdF2RX
         Dm4SMo5LRhmQffkDdV9HfMceSU4lrBZBt/whahtH342DAfJb1+Rrpyogb/+4Z42DIno5
         U3VZcQyUt62dcpgNpXE0lTwJJBfKxE/bIAtM0q1kC7yapPOvKprjS+WWm3f9yzykh8qO
         r7hURzv/Gwkk8ydejMn4+lsz5O9qQjhuAOndPlZhxyhjSSK+9z4NAO3f8Sp5fm/BY2IM
         6bL1loixRrAz/hD2VYb1rIkO2dqlQE+PSXIzDSLU1dLXULJ7+EmodQ00gHKYIiYaa7Mm
         SrgQ==
X-Gm-Message-State: ABy/qLYpuuK8Xl1TjNdTdNwwHd/r4VyxFWcdPJV9umPOUdOn8r9Vd2uA
        pln16ImtcvfuFaum5LrW5qi/X/igzO+2C1ngcpTD0g==
X-Google-Smtp-Source: APBJJlGibJvtVcDgz5ibKZkDiY/s+WjsQMgg3+FkI4BP6RD+oYwseU4rOkmRxVxGch/QiIOtfVX4Lw==
X-Received: by 2002:a05:6402:1a29:b0:522:1d80:7549 with SMTP id be9-20020a0564021a2900b005221d807549mr1839629edb.26.1690562506830;
        Fri, 28 Jul 2023 09:41:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402151900b005224ec27dd7sm1976375edw.66.2023.07.28.09.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:41:46 -0700 (PDT)
Message-ID: <e8ca771a-d023-d112-04cc-48f6704547cf@linaro.org>
Date:   Fri, 28 Jul 2023 18:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 29/50] dt-bindings: irqchip/atmel-aic5: Add support for
 sam9x7 aic
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230728102811.266759-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102811.266759-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:28, Varshini Rajendran wrote:
> Document the support added for the Advanced interrupt controller(AIC)
> chip in the sam9x7 SoC family.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

