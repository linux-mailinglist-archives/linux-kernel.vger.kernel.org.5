Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1CA771244
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHEVGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjHEVGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:06:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B2E7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:06:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso28777005e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691269563; x=1691874363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enBCBmHitxeLdrcfm+/oFsM43lqq+eJAYSi9GmLcgzA=;
        b=RPg44PJlZtK5bRONAjeZWeAEUZiLJzQg7prE+g23SRsdUOBTRsJt7l0BlFftHj949l
         IjubuPkGnvx0yIlx0gfshWJnYJs/tOU3R4qBEMO15KsrCnzgHRk1tt3QUKKNx70VU1Sz
         hyN/kajzIuLa2P0t6cRZYtXsuQWbixzQy4mUfstt4eKtNQDc4s5CiLphvUZHXue3fH/W
         ygAu2Ufo7zqLp7KYXG5mGVOp0k5r26QYWcr8cZ8xITqwnmjSwA0RUg2a8pAZv/a9yPqz
         lcdunzTU/dcncKyhxAxl3i4VTDo+wMS2+itVeSwpwjdaPdXYi5QZiLMnZoyb/s+1DiZl
         N4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691269563; x=1691874363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enBCBmHitxeLdrcfm+/oFsM43lqq+eJAYSi9GmLcgzA=;
        b=MxHkcsZB3Rtg6MAUEskN4dR626IQAHUCPxFekbUooXrDygWuhDYwkNuNJA39ZeQBS2
         vj0pXY2URZ2aoUdRbXiHGtoVBQvsMjSCbKW9fhxecLVhuijcuBW1acp9BsgbdeclXtNa
         WUhXhb5NFvkUlVaSal2xd0/dGqZtmkCcNWN/h/Srjd6OWKD3pQwsE0Y+Vx6Jt7YXMzth
         skVB2CncOXmG4kqyRlSycBn7VKdmrNWuZcsGKj3vqYG9BAuhqXtCkdBxEWXgH/dJN/nO
         Ro4itDo1HFawoykh2jIWedCCNvrQL03NMEYqwOV/D7Qa+rWFpu70W1MF5MnrViqt/zbI
         OEKw==
X-Gm-Message-State: AOJu0YyMepu+J1NRkHIJJnhvDQQcQfA2G4Mc1e8jnMgnFemyC7Qof/Fl
        4OioKU5UGDJnL6nT8gb+PkXKAA==
X-Google-Smtp-Source: AGHT+IFzK0A1mP9ER/4TDJghHVvR9IpHGmHw8x3cRz8uDtx7ZxPz5Qv/Nds5ncFysRJ2AMropbcbzA==
X-Received: by 2002:adf:ec87:0:b0:313:f94f:3b15 with SMTP id z7-20020adfec87000000b00313f94f3b15mr3635933wrn.2.1691269563395;
        Sat, 05 Aug 2023 14:06:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id u3-20020adfed43000000b0031759e6b43fsm5965330wro.39.2023.08.05.14.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 14:06:02 -0700 (PDT)
Message-ID: <1cb290fc-ea98-5cb2-8e52-b787c2b98702@linaro.org>
Date:   Sat, 5 Aug 2023 23:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v8 03/16] media: dt-bindings: cadence-csi2rx: Add TI
 compatible string
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-3-fb7d3661c2c9@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731-upstream_csi-v8-3-fb7d3661c2c9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 10:29, Jai Luthra wrote:
> Add a SoC-specific compatible string for TI's integration of this IP in
> J7 and AM62 line of SoCs.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

