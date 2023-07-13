Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC3752AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjGMTLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGMTL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:11:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B439D2715
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:11:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3142a9ff6d8so1075983f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689275480; x=1691867480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQIiOmeN3SwtcvllP1czSfDTQyGSShmdHmMFKCXwIlc=;
        b=p+09KlpLsBCuEMp2SHB9rDXs7M3xKYJkE0OIw5I/Lp4pmGBMRg2LS686NRXFU0bP5v
         rJGJc6obYKrW9675xb99N14927wBYlCw8fSBM7edL/wFvbxv50veM4Fr73AevCs6W/iq
         buGjrbkxroKQeD5J1P5/d2uLPRkUSIh7bTiL8zH9hW3ZkJ70wsOXm/uzuyxx4+5Wkw8A
         vDX7y/L6pXHrzaa1t0eRucz70kH+tbAgKgROmc3JD0LoQmRbbQChtbTHc8qwZp6uiDgg
         kUtq1/gVyvKAnTGCCozGjjgq3O0F6zyhUZYr5821trpFItKTxvyShIQilfO9LteNng5q
         echg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689275480; x=1691867480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQIiOmeN3SwtcvllP1czSfDTQyGSShmdHmMFKCXwIlc=;
        b=OLLN8qfBPrVEmUQsTC7hXSFhXoDTHuC+wZeathTGmHuAWBnp9zRrwE14FG90mBG51z
         pIbi0t7qTPI/3JRa7El1FhbupiLy4KQH5n9WZiyLDfimzLvisfm4vAr96Ub9Vt08Z3VN
         sLp/18NcbmvIddtUVyXl9UFF/KyiBLDId22nmnnyMMTWMq9WLjYkKggtxNMPuYHoVdjm
         dWG0+yWh4kgi9tFtxhlChNVzl1oXEIDr8HUqcimIxMoQpYEWC5ueiWOr+gk8HoXbUhyF
         Fxj/p6xJbcZ0K5kKUYvnKVndIDEr5ZtGqGr7hi5DsrPAh7SSANDo4bbim+4o8KeJtXJm
         wzCw==
X-Gm-Message-State: ABy/qLYw7cCIszoKDD3p7GGFfU6BVAlRpNe8F16elD1KeVxjwiJKWYar
        9Im1as//mpm5V4ocXXkVkSyi1g==
X-Google-Smtp-Source: APBJJlEFZkRx0SdmMLRjwpOMielvDE6lFd1/hBuAzqhS/OjUDxPvWiFlr2FO5hkBuA4f+d7ybieajA==
X-Received: by 2002:adf:fe4c:0:b0:313:e8bf:a6e with SMTP id m12-20020adffe4c000000b00313e8bf0a6emr2554284wrs.21.1689275479815;
        Thu, 13 Jul 2023 12:11:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b002c70ce264bfsm8723987wru.76.2023.07.13.12.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 12:11:19 -0700 (PDT)
Message-ID: <8323d011-517f-6269-be6f-f7c0accb079f@linaro.org>
Date:   Thu, 13 Jul 2023 21:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] dt-bindings: ti-serdes-mux: Deprecate header with
 constants
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peda@axentia.se, rogerq@kernel.org
Cc:     s-vadapalli@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230713151707.8109-1-j-choudhary@ti.com>
 <20230713151707.8109-3-j-choudhary@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713151707.8109-3-j-choudhary@ti.com>
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

On 13/07/2023 17:17, Jayesh Choudhary wrote:
> The constants to define the idle state of SERDES MUX were defined in
> bindings header. They are used only in DTS and driver uses the dt property
> to set the idle state making it unsuitable for bindings.
> The constants are moved to header next to DTS ("arch/arm64/boot/dts/ti/")
> and all the references to bindings header are removed.
> So add a warning to mark this bindings header as deprecated.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

