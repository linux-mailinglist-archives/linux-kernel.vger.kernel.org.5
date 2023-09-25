Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFF27AD8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjIYNOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIYNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:14:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB72A2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:14:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a9f139cd94so768926866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695647667; x=1696252467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J86WRvPi/8qQQ0zr4LtcTB0aCNrnSqZgcNekM0PEZbE=;
        b=S89866vV3nF7jNaIAvIdQ6YX246ND/DjJSzqmkjYLJj6VlzhUclQ0NVPVyF+5Ma5Rj
         X2+EyqHtS4PX0Or7aB2CgF4Blvr96mmkRWw12JGBumWTV0Xy9j1iHvVOzdLYWXdjBykE
         5RoQndqlEXJN/bUtkPpNHzPRD5sRD5f2SdQKhFtbD/f+5U7x7/C7hpd9hVSNqKMWWP5S
         50FxBJe2MmJ+ljGuh3kjZ0rDI+Ym/hEDOvmFm1Mxk009kCLEhkVZT+JZ9s57JcaTkrjT
         jKJL7Ge1Nx1iO97qdV8+pIyBM6jWm+UbMV557nbHxJ1sPnAW/DCWgZR58ZKxrbU5C9K+
         WfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647667; x=1696252467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J86WRvPi/8qQQ0zr4LtcTB0aCNrnSqZgcNekM0PEZbE=;
        b=twjOxiD8xxnkiwtg4JyrdKINYeNb2i4Tl+LjRVRO8D2EW3t9sq2a8U+e2upFc4MuK0
         D84v3OWgrvLUxRRTewUCMNtJd56CrEFwVdIPGkJEFuPXYt3zQd8bSvydUM2FyUUVxuIT
         tdobCYJLHEjUj5mFAN1PH7rLhKN/TNuG45aCnjR7xnCyPHpoiZFtdCEoXDPQhLEL8cBz
         34gEbLHHviY53Bs6Ol6QVsMLadk6zrGLN37sr/8QyJzgn9vU/glRWxilOit/R1GbpYyp
         wt1Pu+MrdqFEX4fd15SdIv+XRPcQoBRq1M/zH2L+7g1kFtcw0zLD1DyZwUisSr/SCA0G
         ezTQ==
X-Gm-Message-State: AOJu0YzoPWjVwKKs6KswqUPWpQIDD7Yx45tiS4bf22OyiAmxhnj1OtTo
        Ah7jv6xx3dnj8xb8Q+NrdMOK9A==
X-Google-Smtp-Source: AGHT+IFXons9dSUZZ+FaGwS5NZaM8AKzDYaJRSx6q49+G7s2ATcPj4Rq5Vk4jjix6KQN0ltwSpX1vg==
X-Received: by 2002:a17:907:86a1:b0:9a5:a701:2b90 with SMTP id qa33-20020a17090786a100b009a5a7012b90mr6736495ejc.40.1695647667474;
        Mon, 25 Sep 2023 06:14:27 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z23-20020a1709060f1700b009b285351817sm1125357eji.116.2023.09.25.06.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 06:14:26 -0700 (PDT)
Message-ID: <77b14fab-ea46-36bd-9886-49fc6cfc980e@tuxon.dev>
Date:   Mon, 25 Sep 2023 16:14:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] dt-bindings: ARM: at91: Document Microchip
 SAMA5D29 Curiosity
Content-Language: en-US
To:     Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, cristian.birsan@microchip.com,
        alexandre.belloni@bootlin.com, andre.przywara@arm.com,
        jerry.ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andrei.simion@microchip.com,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230919124606.26898-1-mihai.sain@microchip.com>
 <20230919124606.26898-2-mihai.sain@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230919124606.26898-2-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mihai,

On 19.09.2023 15:46, Mihai Sain wrote:
> From: Andrei Simion <andrei.simion@microchip.com>
> 
> Document device tree binding of SAMA5D29 Curiosity, from Microchip.
> 
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Your SoB should have been here to reflect that this has been upstreamed by
you. Keep it in mind for next time. I adjusted it for now.

> Reviewed-by: Mihai Sain <mihai.sain@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to at91-dt, thanks!
