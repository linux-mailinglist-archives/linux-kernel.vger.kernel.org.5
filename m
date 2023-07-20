Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73D75A62E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGTGTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGTGTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:19:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C7210C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:18:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98de21518fbso84116166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689833938; x=1692425938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1vT3QM3Tws0yhZV0aH1KXdvYo5tOn4vcuMaEjFOGLs=;
        b=UmAsO2maMsT92alrbsvUerKKaswVCX5d1/JPlw60P0RWKRSKXviRfVz71amaCfQIcY
         Lro4RfIz6xCKCG1zm1rQvDI/4A0LxMtlOlHv2dnQBD4bm1TnivzLmeHypPqkhNuBNM7w
         NmTYjyVzHxpG0KgMXnnJhyBR4j9dLcKHT5wQjJA14jt/8rzDev8P+l4Wyfdz+3s3BAuR
         saaVTjbTN3cFn51+3Xf6ENsm5KviWFymUn7qwSUrGO51U0M7FmpDuiqxPrOtKhdrTlSF
         26PKp0YS0pWYmbctNNneXxkHXdCOVoxKiEBLkrBWcqZEU2qBLM7iYhm4/prt8Ja4EQms
         LaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689833938; x=1692425938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1vT3QM3Tws0yhZV0aH1KXdvYo5tOn4vcuMaEjFOGLs=;
        b=fSvN5G1/f5k6uWbq7MwCJTuL28IykhJVp7lpUKVM7g7iTZY7KA31heFHIZKIJTlgKq
         RpvLaTJUgfuwObLpYcpRCpK3GlTeYOSwBqP6XJV5yn58KsJ4EQCQMAlUDLJT0ZlJ/3mb
         gKfhohNWRATft/74GddxUmC2ULzWdjdS963akLue1RA/di1/qsQb8cP7QnU0bXqByPPp
         Q04UA1Uga4xL6p5OBO5DYp+amN5z95hvVq6o4vwdVYxPm23jbQL2k6cDoP0+mpkBea55
         4agDzv9vCPSwWdM8YbzKw9RIzjdz7QE/HerfSOlzsqQsdV3Ys3fhn2aMUIf2wn6N5jmT
         8r/Q==
X-Gm-Message-State: ABy/qLZ7kg1rHrfBmcFFtMNH4zVuybGfaLOEIFw1myoD6QmPS2UKXt0+
        GaJxslyvb7otI7QMuvsJ3eZXPg==
X-Google-Smtp-Source: APBJJlFh3AelKq01ZQ5JGdjYDQNoPdpDFzUxnlt++SxL3YEUaCO2z9HHzeCiEJuWz2sHZHWQ3/VJOg==
X-Received: by 2002:a17:907:6d82:b0:94f:29f0:edc0 with SMTP id sb2-20020a1709076d8200b0094f29f0edc0mr5572680ejc.44.1689833938251;
        Wed, 19 Jul 2023 23:18:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id rl6-20020a170907216600b009920a690cd9sm189438ejb.59.2023.07.19.23.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 23:18:57 -0700 (PDT)
Message-ID: <69fa21b4-3197-d5f1-f300-d070cf5e7fda@linaro.org>
Date:   Thu, 20 Jul 2023 08:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] dt-bindings: Add bindings for peci-npcm
Content-Language: en-US
To:     Iwona Winiarska <iwona.winiarska@intel.com>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tyrone Ting <warp5tw@gmail.com>
References: <20230719220853.1029316-1-iwona.winiarska@intel.com>
 <20230719220853.1029316-2-iwona.winiarska@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719220853.1029316-2-iwona.winiarska@intel.com>
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

On 20/07/2023 00:08, Iwona Winiarska wrote:
> From: Tomer Maimon <tmaimon77@gmail.com>
> 
> Add device tree bindings for the peci-npcm controller driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Signed-off-by: Tyrone Ting <warp5tw@gmail.com>
> Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---

No changes from previous versions? Nothing improved?

>  .../devicetree/bindings/peci/peci-npcm.yaml   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-npcm.yaml

Use compatible as filename.

Best regards,
Krzysztof

