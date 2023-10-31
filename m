Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D257DC9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbjJaJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbjJaJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:36:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6BC1;
        Tue, 31 Oct 2023 02:36:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so70664011fa.2;
        Tue, 31 Oct 2023 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698744988; x=1699349788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZxuIywVAswW6n/3J3JwVTLwlBubokHR2MZeIGKjrtI=;
        b=Xz0zvABveXqYwSKFALQ7NWwIbFMm20qVJU4etACzUZYQKY1w2nnI7KYN5HUe7FDlhs
         2VHCuSMlsZbab6BhEe3RCsSZIixDLa5Y/40RM7sqb3yUP3zy7f7UsXZRmC8Fz5V36tdA
         EXLuM9trD2sQf1eC6pvOC0Y0+ggmdsbmJZHvYEtZf+vgGJvYMMa4wAy+U2mzKYoJaSCM
         IfoZgnil4sv4mnix5wxiD7b0KPk3h0U192w9YLgPlKYXdmIcVYmuK2wf0JGw7fQGt1VC
         T8AcooLBqj5m6k7+Dtwf1KJAAEYulE0ooxSqOVmSk1mcIUxtbbsdFux5mf10Y4oDH4a8
         DBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698744988; x=1699349788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZxuIywVAswW6n/3J3JwVTLwlBubokHR2MZeIGKjrtI=;
        b=udbtNbNH3oX8+8QJ4D+QV/NcOU23aw3eUbRiBYSPuWzeAGHJsKSLitGDjuEysAEgqQ
         q9aG+u6Bx6NTHja8Po3T9HjpsuYwtt3MICGUFfmDu6/vV4u9oQO08MzE6XvEhJUu/YyA
         bZRslPBhR8c6mQ+f2YMcJ3zP3dkD4vr+kQWKaPisAEroVQVo6P1ij2vFKjEfYjWlnCVj
         SnOsnG+a4+PEh7cJDzqui1XVcaDwj9rC8tmKhjiD2LM1UyskzBTNiJz+gO48IWuDhykX
         v/JOoWbtt3xWCw29zeFEr6mtQkRyeuzn4ZFNLeDwuLlb8+lRlib8SY/dx97ub1XwLLIr
         gOaw==
X-Gm-Message-State: AOJu0Yyj8sUnQdMQ/4JpNXyAgZ2MJuMBux/tpecb5eJBr3Y+UWHngE5M
        7SnuXc0e+Y4JNUl02e8ZJN8=
X-Google-Smtp-Source: AGHT+IEZ9zXeGMJceMpb5rGwW0sdXh/8Dl8SNTWHY6N1AvdiNZeyT0y7zdVviADVeWXOriHDMvl8xA==
X-Received: by 2002:a05:651c:42:b0:2bf:f32a:1f64 with SMTP id d2-20020a05651c004200b002bff32a1f64mr9978572ljd.18.1698744987958;
        Tue, 31 Oct 2023 02:36:27 -0700 (PDT)
Received: from [192.168.43.75] ([37.30.4.35])
        by smtp.gmail.com with ESMTPSA id 4-20020a05651c008400b002c17dcd8d91sm138722ljq.120.2023.10.31.02.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 02:36:27 -0700 (PDT)
Message-ID: <0a4ae01e-fd47-4468-b7c1-527977e53965@gmail.com>
Date:   Tue, 31 Oct 2023 10:36:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
 <20231030-bcm59054-v1-1-3517f980c1e3@gmail.com>
 <5a906074-5c1e-4c1c-8023-5346e7fe9738@linaro.org>
Content-Language: en-US
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <5a906074-5c1e-4c1c-8023-5346e7fe9738@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.10.2023 06:52, Krzysztof Kozlowski wrote:
> On 30/10/2023 20:36, Artur Weber wrote:
>> Convert devicetree bindings for the Broadcom BCM59056 PMU MFD from
>> TXT to YAML format. This patch does not change any functionality;
>> the bindings remain the same.
>> ...
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
> 
> There is no other feature here, so this should go to regulators directory.

There are no other features *yet*, but the driver will eventually be 
expanded to support the other features of the PMIC (charger, fuel gauge, 
rtc, etc.).

In that case, should I move the bindings to regulators for now, and move 
them back when the other features are added, or would it be fine to keep 
it in mfd?

Best regards
Artur
