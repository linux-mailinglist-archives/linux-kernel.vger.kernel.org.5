Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333747640DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGZVAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjGZVAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:00:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A6E19AD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:00:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so3118026a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690405207; x=1691010007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxBJ0tFj1UbUOBEqoo5krK0VcqyYI11I6KTerRdAx7Q=;
        b=x+rFUkLZ5fBSAD+SlvEMEuMVK8vhBZsqqpAgrIUUtRGFzZYWEuF3zKmwpDzOOqytTH
         3tFXfLJNRyJCh/6PdS67Hv7e+4iidv0I19PKMZ92VsmP6r4r7mdF+Y0tSqh1jJJd226u
         s0kbzZMEby7Mms+4n5XdHn8UTXYItiWk//96Dfegk3k1i/3Gldjk8JnKtrHDoInm1Ofk
         37tlNOA+1+3HhAk0FOiIyrIy3LJWXYuOrhH9Vo7a/soZy9jg0nmK22jy1pZAO8BWahnu
         XS4RCydB/v+0tE7LeFGRd+C4nmsPlTMvaOgDXw4v0NFigcdtlZrRNNhcgauQTOCP7N41
         oATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690405207; x=1691010007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxBJ0tFj1UbUOBEqoo5krK0VcqyYI11I6KTerRdAx7Q=;
        b=dPjhFlCuDv/IFE7uk2BgYy0IT7grOF4cKQnknjRr0Lb07uLhuriBcMMOVheUwEFCX7
         EyO1wJI6KLwAf8fAr1ctuHgd57WXaSbDK7Lu44UY2OXFsIQTaoVxBvq/eoOA+8lHsA/X
         wlpGH9GJyBI188dUPh32ADMQL/XU2LD1DkNsSW0fvTLasTUNT0X2aE+v7jtmT8mQhxqj
         Hjhu6qWHgcxKtuAqoob3tSG1rKnrn3AHde+GkfzaEvjC5Ud+7wNIrYsYSTRKvbZjwgot
         ILIia2pvtI3ZqiItefcw+C11v3MTOKI2CezxoRGdj6Dcz77FU3m2Bech5juFPukf42//
         5Zog==
X-Gm-Message-State: ABy/qLYW09iqeNwpdLDUu2ZG9nIVsItBTqCfLCPMkdYNtSTayIJQjDaj
        5QELmGmh0f6ldiF8YbKcEZrqfQ==
X-Google-Smtp-Source: APBJJlFZJICiVh5rlt6ysLzD0BWx1vEgt0m23dypJlzCPgv0/Qw+dtH2Pk55t+Ec0uttPJRaapYBCQ==
X-Received: by 2002:a05:6402:5188:b0:522:28b9:e84c with SMTP id q8-20020a056402518800b0052228b9e84cmr183918edd.21.1690405207622;
        Wed, 26 Jul 2023 14:00:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402088600b005223d76a3e3sm3209902edy.85.2023.07.26.14.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 14:00:07 -0700 (PDT)
Message-ID: <df37ca83-a198-6395-723f-94aede45978b@linaro.org>
Date:   Wed, 26 Jul 2023 23:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: media: Add bindings for Imagination E5010
 JPEG Encoder driver
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, b-brnich@ti.com, detheridge@ti.com,
        p-mantena@ti.com, vijayp@ti.com
References: <20230726162615.1270075-1-devarsht@ti.com>
 <b6bddd59-ac78-3f75-828e-cff54766fc72@linaro.org>
 <3d26f0f719cd5f71c20e80599362cd52bcfe8dd4.camel@ndufresne.ca>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3d26f0f719cd5f71c20e80599362cd52bcfe8dd4.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 22:35, Nicolas Dufresne wrote:
> Le mercredi 26 juillet 2023 à 18:33 +0200, Krzysztof Kozlowski a écrit :
>> On 26/07/2023 18:26, Devarsh Thakkar wrote:
>>> Add dt-bindings for Imagination E5010 JPEG Encoder driver which is
>>> implemented as stateful V4L2 M2M driver.
>>>
>>> Co-developed-by: David Huang <d-huang@ti.com>
>>> Signed-off-by: David Huang <d-huang@ti.com>
>>
>> A nit, subject: drop second/last, redundant "bindings for". The
>> "dt-bindings" prefix is already stating that these are bindings.
>>
>> Drop also "driver". Bindings are for hardware, not drivers.
>>
>> Prefix starts with media and then dt-bindings.
> 
> That being said, I haven't seen any submission for the driver using these, is it
> common practice to upstream bindings for unsupported hardware ?

I assumed I wasn't CC'ed on the user, but it seems there is no user.
None, neither drivers, not DTS.  Commit msg also doesn't explain it.

No point op submit bindings where there are no users.

Best regards,
Krzysztof

