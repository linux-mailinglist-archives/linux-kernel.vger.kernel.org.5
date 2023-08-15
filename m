Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6704677D4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbjHOVJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbjHOVJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:09:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9251980
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:09:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d58b3efbso5077787f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692133772; x=1692738572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8bBzfKoERpsKitiZN4nMKM6RbRCpRMSgVwMeOyuDg4=;
        b=OjxSJtIN2ZIP+L8D41IWH1CGQyReANeeXBAPLe69Hpr+3kS54QfG/oynwDua/CAnHi
         Nw72Vp5E3PUMgDzPld8Q8GpMHfJCci4b71+2wmbo7cMaAZA4wz1t08sJzfDqqMVqSvHM
         fJoFmh49Fkc/sd8FtHOtRVe7/ftXUrfoYxSOgNAOq9MzuLaGQTaZ7y/6Xa8HGNAa3uEu
         G7vGn9EFWuibwGW9FIC2JtJ9f2ixiRzBDF/IIGiCYvYeaLpMQVjPFwkYw/Suk79SLR6M
         Kh+MWNwFD/jJC5leFulRdQzOljIyYv2KZAg7DGR4zFqRncV/00jgOBRTOkIIirFyb7SY
         2VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133772; x=1692738572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8bBzfKoERpsKitiZN4nMKM6RbRCpRMSgVwMeOyuDg4=;
        b=S2IYLP8WJZLxe7E2JaI7MNwA17Us/B+PcjE749G9CP57+EMeDUaYi46zL9wgNFicNJ
         HGbEHzM6ol77UU9KhC80OhvPGSoQcnj+P8lxpG0Idp+lTdNsLR2CjbwX2ZwbRkO4zIeW
         CZjH/84oW1QS0WnMuZ4+AEhFxtGzERUBSl1Wk0buE+1wmmeQgC7eA6aPgVeR2qO23p/W
         oNOPepeJ3Fag3aNv+UlqvR2fyPgohZnnP9ZKowbAh8mV/YuhisrCkhwNbk18Hal6LOPR
         H5vXoC7WZBMmRHNF+XF0sss6z2WwmXW29+5dYjbwTVdWRIxpngGpqC5I+FfmDQ6j2NWz
         GSyg==
X-Gm-Message-State: AOJu0YzyhteUNt4mhOxAmgOmXPMQwvs+oSAIP1nQbJzTqI6qrBLEICa3
        d/bMwF/LxbQaHtmRmKR/H4ZucA==
X-Google-Smtp-Source: AGHT+IFeyYIxvUFpoWnFQI7t+pjFr9Q0npWo2Sw9oiEPkR63padzY60CtlGuUN1fxXnm795IfPPgtg==
X-Received: by 2002:adf:ee87:0:b0:317:5e0d:c249 with SMTP id b7-20020adfee87000000b003175e0dc249mr11068136wro.35.1692133772560;
        Tue, 15 Aug 2023 14:09:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe9cd000000b0031934b035d2sm18253015wrn.52.2023.08.15.14.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 14:09:32 -0700 (PDT)
Message-ID: <2f1cb309-9cc7-cdf6-261b-ee5bc8095d67@linaro.org>
Date:   Tue, 15 Aug 2023 23:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v3 07/10] dt-bindings: net: snps,dwmac: add
 safety irq support
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-8-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230809165007.1439-8-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 18:50, Jisheng Zhang wrote:
> The snps dwmac IP support safety features, and those Safety Feature
> Correctible Error and Uncorrectible Error irqs may be separate irqs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---

Please share, how did you address comment from Conor on v2?

Best regards,
Krzysztof

