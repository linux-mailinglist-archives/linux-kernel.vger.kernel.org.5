Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DDF764E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjG0JGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjG0JF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:05:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7808686BD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:46:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso937604a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690447613; x=1691052413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ets1w26MUwejoH+A9n2QYCu2qpqKJHRSC2S8at9KYEk=;
        b=mcZhvnB02gKM3qOKeT5DfaC1RexC0wy1Ty75fYaAahmJwcr8hMghjI1raaAiOMpkaN
         0Zchaj7bFyjPGtf16dCrzVMyPuyuH/+Ay8MtpDPyhayksIhPUQL1GREYmzV/sGoEcAyw
         LmWXK4V+iO2KzfVeOCKOXlD8q1HjWy8O4QjPni3Hre5ppq+l42TLPEb/BZwNfw3Ss57J
         EiwV2gwB77bDIx9lxxYQPPaeFKanyB4MqlMZlN0hlDhG/9Hyr6F8QQ6KYowUtPm2vcxL
         Fg8uK2kG85pUKOX9etQOCe5xFTu+uWIePyYGcRZUoZLjo++jmaA6E6SynY8s+VLTBEPd
         JG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690447613; x=1691052413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ets1w26MUwejoH+A9n2QYCu2qpqKJHRSC2S8at9KYEk=;
        b=Zgv/L2dgiHAZFSMIavmq6d1JdJiiuVjSbYl4jCoDjP4Ly50p+jxhq0yBHRtup5SJcH
         7W3TD7EKyCoPK0x7N8g7v+dWhZ0DL4LdIFbzqrIU+HzVli9/goRPsJCj1Q1WEib5b2+u
         1KparwrkRWSQtFhO4gha/sVtxHRisy9f6ScKx09+gSX9wy+JzeHPuBA66FXxnTSDN+h/
         PANVxxeobkRae0nizMnu7PSIPiQK6YmX0WjeCaK2+h7ZEEzZUuoTjOTY4RI+bROeuwz+
         J8uS2qZnpFovCEdVdzu02zuxRO0aWMjUYh1LSoPqYWSzmirrsDK9wnRJB2qTclPoGIHU
         FBJg==
X-Gm-Message-State: ABy/qLbrpXVau9GbVcFG/fnhsezXxZW27ZwefCh5YqqUYUJ1llNatXk7
        u1Fi7UpsLlDTWc97PHeIsH85AqeoYjd8disr1ho=
X-Google-Smtp-Source: APBJJlFxdL0vdm+bMblC4hZEphjyfMCt1APebzBtD1OFoA5fB+WkLPwO3nmCxBu4/5qgvq5ojn1hbQ==
X-Received: by 2002:aa7:c906:0:b0:522:3849:48d8 with SMTP id b6-20020aa7c906000000b00522384948d8mr1317797edt.9.1690447612836;
        Thu, 27 Jul 2023 01:46:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7c54b000000b0051df54c6a27sm390970edr.56.2023.07.27.01.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 01:46:52 -0700 (PDT)
Message-ID: <d8cd4f03-6824-da32-4e96-d7f750cbcf09@linaro.org>
Date:   Thu, 27 Jul 2023 10:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/42] clk: at91: at91rm9200: fix checkpatch.pl check
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>, mturquette@baylibre.com,
        sboyd@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
 <20230727053156.13587-18-claudiu.beznea@tuxon.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727053156.13587-18-claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 07:31, Claudiu Beznea wrote:
> Fix the following checkpatch.pl check:
> drivers/clk/at91/at91rm9200.c:100: CHECK: Alignment should match open parenthesis
> 

Doing such trivial changes per one file is way too much churn. Fix all
these trivial checkpatch issues in all at91 clock drivers at once.

Best regards,
Krzysztof

