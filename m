Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB107847A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbjHVQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbjHVQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:32:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB7E137
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:32:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c4923195dso607498166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692721926; x=1693326726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uQSylp0y7KOudR5yNt2H8UCOVpvtj04yDey4znHRLA=;
        b=e5CZu2+RpDcrjPEl8gmUFILhTTitUimNfzkLuXEk57VQEAR2kqg4fzp0GPXAj6oabp
         y/RseqyXDzppUaEiTL85pFDe1WvN3QJYyOeMFpclFRQ/AkswADsSbfon5WGJ33/DT18o
         KtT5l2KhvnfzIeAdB76PQW/Ov67hq+hLXRfBGw6HvcvdHYAYUVzlXBFPQtE3tso33cjb
         tsTACVCo49NMTag1NXI9lSVdEud/QGTchIkcgqlHbMsvvLlIAgDl/iLVO/BPrY8zjLfR
         GwEBlkmoJEdJ9K7LE4qGL/ApbUeXqvu65DKCENt2U+QuaxoILHikD32g8j3t1mGm4Btz
         eCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692721926; x=1693326726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uQSylp0y7KOudR5yNt2H8UCOVpvtj04yDey4znHRLA=;
        b=TmAUIb481vbbfBlWtLDmi1c+hW5pXw0DPRKyOEDdJXBSgj7ysmFyOXhmxS346Os016
         sgFEBf4aAiIzVeeZ42t0Ytx2UEAOnvzknGqyHjlT+KPBEgwu6TW3I0nbhT3DLHDdkQBQ
         /zmZ5nIOGiawwQ/LTzjyRUb/SyiGIUeHZAADVgjyHS0UzBTGRtFMVCHCw4p3bvDZ329g
         w3xgYHIe+FY6axw2ShQvwN397EKlfv14JrNXnPSTAfxqjZNQy1R7KJnh0Ero9RCG5ie5
         9aNCaGFmWcQ8fPz8mSBMVYc3SD7vX32qSLbMACtirhsUnRMktSLMCq8HIwZS0lJkuLJl
         nVjA==
X-Gm-Message-State: AOJu0Yzyojrx3HrHCrx0pXLjuCPqepVEFugmH/Fm9lJmfkLhk4zjIohU
        3tNW6p7uafh7J/4PtCsq5L6JPg==
X-Google-Smtp-Source: AGHT+IHY8roXOKlErN1u6cAk1xEiMD1JJ8eVAuVfBioslGRRaPmLvzi0W/JaIoSiX7eCI6hpEj0Ksg==
X-Received: by 2002:a17:906:cc16:b0:9a1:870e:cc9d with SMTP id ml22-20020a170906cc1600b009a1870ecc9dmr6733431ejb.18.1692721926631;
        Tue, 22 Aug 2023 09:32:06 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id x5-20020a170906148500b0098e42bef736sm8505501ejc.176.2023.08.22.09.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 09:32:06 -0700 (PDT)
Message-ID: <d2a6060a-c8a0-51c7-f621-1bed2c3074b4@linaro.org>
Date:   Tue, 22 Aug 2023 18:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V10 1/4] dt-bindings: clock: document Amlogic S4 SoC PLL
 clock controller
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230822082750.27633-1-yu.tu@amlogic.com>
 <20230822082750.27633-2-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822082750.27633-2-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 10:27, Yu Tu wrote:
> Add the S4 PLL clock controller dt-bindings in the S4 SoC family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>

Lovely. I sent youa  friendly reminder at v8 which turns our you
ignored. You keep ignoring, I will start ignoring as well from now on.

Best regards,
Krzysztof

