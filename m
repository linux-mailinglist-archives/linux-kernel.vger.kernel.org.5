Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6DE76C43C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjHBEpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHBEpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:45:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E651981
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:45:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so27872265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 21:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690951546; x=1691556346;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAHQ1xVD6mCYyeiHHsFX9UKA5VExLMCp78lQW4TVXnM=;
        b=BmU/dlqWP9BR2t3cqOtUyIszlumMyzotg5G2gXjdshwDEjfrgkS+yYIPBT2yqbEyBy
         zQZh2/UneAWy+5R8sMHrgElD2QZOZTzvojG9RrLe6RWOLMAngd1Q5DjQVl6rxEcv3CSk
         GZxQs+//rpFM6SF4UEOBw2d96dD+lR0xo/Ns3l7teCmAJKJltgeKeH4D1eMn/O0jcTei
         RNraLAQ3hHGw4wrvkwMhWVAl4GavMxuXIVL2eLHl39rQl9GVgEVbDAS1AJ5Q1LM/NHyi
         Wrp7y/yIlxxTXw5emyfGIjoHOvaTZfJCl/naQo4GJ6w0zZORRkGdxOaPw2W/yfPJhky2
         ry2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690951546; x=1691556346;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAHQ1xVD6mCYyeiHHsFX9UKA5VExLMCp78lQW4TVXnM=;
        b=kgNw7sWDm7auQnx37HfcypRp5Lfj3Z7yyV2PxgaPa5PJDbduXPqifeLl1m12fvi4rB
         6da7OK0meT23zmSm0ooImgJ7iiczaHsZVysvxYvZA929zSYgJS8xb5Ygim9d/G0juIdv
         xGBfjX4UZoNnD36ugUqmW4KUwmzeISsl77jwkm5i4PYIfiOig7GityCobvOlZ14QIY3B
         h7Zh5c6feRngSkHNSJezcEOo2FK09PY0hfS54qFW/V0VWm3UenZ7VyGWxW6Dk36w1EEW
         ZsOwYZpFEztZyrAJvkLEX2b89Uk4K9fUVr2gkvpvgSkEvnwUKtgkz/x2suWEhXXi/f6c
         IoLg==
X-Gm-Message-State: ABy/qLad8StJXbLelrRv8duCgIFezPjFq1lq3rkLFbQKyAApolOld1AS
        zCALlBY+EjWcp9IxlCU3C/UKfw==
X-Google-Smtp-Source: APBJJlGtYTEql3jo5gHuxQQNiIFSjGkQMXkUH6rBQhDuXth2jauQBfYAxpIAHPFOMFct74Mb8jKaVw==
X-Received: by 2002:adf:e505:0:b0:315:9ee6:132f with SMTP id j5-20020adfe505000000b003159ee6132fmr3764483wrm.68.1690951546310;
        Tue, 01 Aug 2023 21:45:46 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0030e56a9ff25sm17789401wrl.31.2023.08.01.21.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 21:45:45 -0700 (PDT)
Message-ID: <a4286b78-7000-2271-513a-6147c68a7ac2@tuxon.dev>
Date:   Wed, 2 Aug 2023 07:45:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: microchip: split interrupts per cells
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230730111542.98238-1-krzysztof.kozlowski@linaro.org>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230730111542.98238-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.07.2023 14:15, Krzysztof Kozlowski wrote:
> Each interrupt should be in its own cell.  This is much more readable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to at91-dt, thanks!
