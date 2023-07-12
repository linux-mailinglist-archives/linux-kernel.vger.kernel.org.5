Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CBB75112B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjGLTZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGLTZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:25:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506781FC1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:25:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9891c73e0fbso250394566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689189936; x=1691781936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qlC2xd+LWkAw6VtZI/SCBHO2xi/vQf/CwDed84n3xeQ=;
        b=lTzQAFm0UwnXd24PWylRYpcU0F457aHyP9KciWJkMJEWnnNM1CDllzQ4uWcH8EfUQv
         cbZrg8V55iXV0C8nY+uTF7hJl5aPxJnjV9T0geZilx5Ca0xXAKbU8yDrCIYeYYezeCTD
         LnK9GtarHRZDKWRyLhJztJPJDs+bfLXXFymXnErXhGDmgjYgkmbbsy/yjPESTQGA3IC6
         vPSBfHKsAR+Iq642bz+6uTsci/xNYrGfUkpeK2n05ltckLJGjCXRJl8BxhYPr4qqUNuo
         TvOd0aQSG1GkKzUTsXpwujhkrVkL1VFqLHYH/P+us70BQ1E3IzzJGKKGQjUMsylhYQgF
         MJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689189936; x=1691781936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlC2xd+LWkAw6VtZI/SCBHO2xi/vQf/CwDed84n3xeQ=;
        b=aOm7i/WxQejKkht2iRxUHxBkk/8LrJrCIt/yvRGyksITDJuPPixLilMpT4u8waHScr
         6z4fuGgNaOOd+Z7MbLYZOh4LipfflZloILUQ5yAiWvUfjsSHR8fgfxZhpnntqAnzlprs
         GG6GC6qggfVOYdASX8mQ5Q/5dK+72zs4S5AO9FJnv25j2s2xfaqEOKb3L4H94Z203u3T
         XIaXbG0HCcqiqwj6J63pl5QXpcx3KKuhBt1sEXXzlqE/qEZO9lgyVd7oo1QtVudI71uG
         smJsyqfyBTg8eCHvgEOaRh3khACYa3i10LES2fHinptSpScl3jElv0EureLZcEBkGSws
         19PQ==
X-Gm-Message-State: ABy/qLZ8pAjOFcLk8//ZEQHg/Ev5b8yQgTD+nWCum6BqwIJusOMS8lkG
        2r2+ngJrVM4Q/Wdh5O0X1k4x5A==
X-Google-Smtp-Source: APBJJlGsZdGD7bEjsV+5Ybs5t0WWeawP39YFnwraXzAZG+K1Jg6V4qqvtL+9S5NUbMA6Ge3qBEZgnA==
X-Received: by 2002:a17:906:1053:b0:992:8d96:4de3 with SMTP id j19-20020a170906105300b009928d964de3mr4213382ejj.24.1689189935773;
        Wed, 12 Jul 2023 12:25:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906661300b009920e9a3a73sm2929510ejp.115.2023.07.12.12.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 12:25:35 -0700 (PDT)
Message-ID: <aa05bcd6-140d-d951-2c7f-c09abf7f49f7@linaro.org>
Date:   Wed, 12 Jul 2023 21:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] ARM: multi_v7_defconfig: Add SCMI regulator support
Content-Language: en-US
To:     p.paillet@foss.st.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Etienne Carriere <etienne.carriere@foss.st.com>
References: <20230712142432.1885162-1-p.paillet@foss.st.com>
 <20230712142432.1885162-5-p.paillet@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712142432.1885162-5-p.paillet@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 16:24, p.paillet@foss.st.com wrote:
> From: Pascal Paillet <p.paillet@foss.st.com>
> 
> Enable ARM SCMI regulator support.
> 

This we see from the diff. Please explain why, e.g. which boards use it.

Best regards,
Krzysztof

