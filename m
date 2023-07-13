Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2008751E27
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjGMKES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjGMKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:03:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D0A2D5B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:03:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31454996e06so610001f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689242615; x=1691834615;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHv3kkZ/P7da9z9ntbvIGbuhBODaxXDEcQWub3lPMo8=;
        b=MF1q5bm71f/u1h82c4O/qHNGi++umiOSCdY9FjCTQ6nfHGcdClwcFoaCehnt4jy1jZ
         Zz1poC0Q3jpri9CDd0L7fgeWnSmdzKJsQ/NuutdbDJJFpJqop/ntJch8OVk/eJyMcyOK
         xb0rW1TZ/Ud1rj1mbi+xR190cHcwA+2DT7sHRmStT4b9R5PnyHwrFiqyBABSYAvZXsis
         uuNyvXz3zZ+RJOLAopRgFkcaYVjhQ2ysMriY1XlVo4XnzineLa71SJsX35jCyQhPn8jD
         NetnyR1oPM2x+NfBSUJ7b+j93uZLWqkKUZJHFsi3uoBqjq5Nx6hrp3JP44Vl0F05TlMH
         yLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242615; x=1691834615;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHv3kkZ/P7da9z9ntbvIGbuhBODaxXDEcQWub3lPMo8=;
        b=g7U9MxV3pxGUWI/M68mhbk9QLurfbePOG0Q+I3sxWkR9vPc+gD781gweEMR8dLCrj3
         cKrHhbNyBFsGxKP8MNLUrXmbKxZxTll1iejRs0tDDTBPzdK4rhoHEBJC9W4w5g1dkG3q
         Tv7KfYp+8TQzuWcRLtzpew0BsxyDsqtOJM+deF4zCFzb5lB/k9vNXh/Nle7o4PaNpsTg
         WdwWvGmPxdqz5PgO4I+Doe4kp0vVSeQtDcXERvExV8rUIHxrVq4TGTSM4PHOumLvPIIE
         TFlZgLGIqOdgxqdncT+P9PyMBRP91hau6np/Qfu6Ap/fjCf7imDDaMT+MEEtxMpl7rVN
         eBmQ==
X-Gm-Message-State: ABy/qLYEG+BQFNiWkiJ6uq2ZrjdEepyicQHvVLGDcYFq+974IqhbPP/W
        2P1eEXcVr+jV4zRLsLCRD+Jd9Q==
X-Google-Smtp-Source: APBJJlGuNxZ/cw1HTYc8O2dt4QAK7fopOZ8wb3bG2IouIV3zkbD2I6sjyBoNwUxIvF/DL9hNaQf1+g==
X-Received: by 2002:a5d:67c9:0:b0:313:ece8:e05c with SMTP id n9-20020a5d67c9000000b00313ece8e05cmr968841wrw.33.1689242615200;
        Thu, 13 Jul 2023 03:03:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b0031431fb40fasm7528569wrp.89.2023.07.13.03.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:03:34 -0700 (PDT)
Message-ID: <204ad135-5358-35d0-2df2-9495acf0432d@linaro.org>
Date:   Thu, 13 Jul 2023 12:03:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2 2/2] ARM: dts: at91: sam9x60: fix the SOC detection
Content-Language: en-US
To:     Durai Manickam KR <durai.manickamkr@microchip.com>,
        Hari.PrasathGE@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, varshini.rajendran@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com, cristian.birsan@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        davem@davemloft.net, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        Horatiu.Vultur@microchip.com, robh+dt@kernel.org, andrew@lunn.ch,
        michael@walle.cc, jerry.ray@microchip.com, conor+dt@kernel.org,
        jesper.nilsson@axis.com, andre.przywara@arm.com, ada@thorsis.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20230713095111.335346-1-durai.manickamkr@microchip.com>
 <20230713095111.335346-3-durai.manickamkr@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713095111.335346-3-durai.manickamkr@microchip.com>
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

On 13/07/2023 11:51, Durai Manickam KR wrote:
> Remove the dbgu compatible strings in the UART submodule of the
> flexcom for the proper SOC detection.

Why?

> 
> Fixes: 99c808335877 (ARM: dts: at91: sam9x60: Add missing flexcom definitions)

If this is a bugfix, then please clearly describe the bug and its impact.

Best regards,
Krzysztof

