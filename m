Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6357175C4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGUKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGUKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:41:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED621701
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:41:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso2895544e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689936099; x=1690540899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdhi2NedOY3rPKrFENYE2Nl2LSqlJJTZXcd9Gne5I04=;
        b=i0dHRxpu0kna0O9NCPmLzRXgf88kJo2ZgVSCbvTcaHo0mvuQItb/M1C6iAu7Md/gZx
         KaXjyNUf302VW15XVbpy6EjR50AYuTV87PXUiCROKdnQp/wY2D7BtcEMk7/gdfnqY6C0
         25k6OfooUTt6AV5HWp7VtRZztB3kwwmBsLSA/1S3Dk2c+a08XlZmCWii51hWtTmu+/O2
         2PQqfKhS6jORVc11xZDYTGEj5k3FKXOebWIYS/kmo4/AdiYRT3w1QOK7R++f6N9ijv4I
         rXbP3OHTPFtu+RAxG00rIl3uJyTYioqmUAlEf66E6PgoYhsrDKBysFVHd/sIX1eOlmTW
         sYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689936099; x=1690540899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdhi2NedOY3rPKrFENYE2Nl2LSqlJJTZXcd9Gne5I04=;
        b=Di4pNjXkAyiz1EJvMBCfrqvdmziYeaRmzx/bVMxdiuDJcJsg1Gm1UAAYYAa5+imx1W
         S2LuNIjDvvKot1xAAvgIIPvYMSEblnEYb800AknpJ7lqRh/da2/XBnELw9jGBBbLPCg6
         UJoPtIWI08VoIp+NMTdM3LRY4PMZV1+lFQpcjruf8LiE+De0xuUXxK7l5NRF+57OW+Xf
         cjxTRjXjwcFLyb8ri3geNljUO6sxweAJar/N9b/wl8N0rHbStLI66z+wqdLdZAGYDjCJ
         tDEvJF3+G8EzDzzX/tzTEyaqJJ/0T1wEA/GKKSSu/fDXzDVNmV1cUlerjSuTL8q5OcZQ
         XR8g==
X-Gm-Message-State: ABy/qLaiUCSo4aDoMJ6W7MgQx80RrGIepiHNi6R+1a18Rz0/nWmt0HJ8
        5VHgAquxg9sq+qTqYMV/0sbnlw==
X-Google-Smtp-Source: APBJJlFQmFvK48oV49nMp/IbxPuefxmFnwY291qWfYvu5RzStg53uV3nZ6Q24KNkC6P/NA8VabpC3g==
X-Received: by 2002:ac2:5e3a:0:b0:4f9:56b8:45de with SMTP id o26-20020ac25e3a000000b004f956b845demr977055lfg.38.1689936099113;
        Fri, 21 Jul 2023 03:41:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4b46000000b0031590317c26sm3806487wrs.61.2023.07.21.03.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 03:41:38 -0700 (PDT)
Message-ID: <97756604-0d35-aaff-7d2b-2cf65c0b4623@linaro.org>
Date:   Fri, 21 Jul 2023 12:41:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with
 Custom Board
To:     James Hilliard <james.hilliard1@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230721103350.3684483-1-james.hilliard1@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721103350.3684483-1-james.hilliard1@gmail.com>
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

On 21/07/2023 12:33, James Hilliard wrote:
> Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I asked to drop it, because patch changed significantly, so Conor should
re-ack it.

Anyway, it's third patch within 3 hours. Give people a chance to review
your series. One patchset per day, usually.

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---


Best regards,
Krzysztof

