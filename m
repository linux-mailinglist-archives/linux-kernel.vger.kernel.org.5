Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BA9803BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbjLDRhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjLDRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:37:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DEE192
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:36:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c09f5a7cfso16336715e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701711399; x=1702316199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrH3TZ7rDJNZ1i1xkHsBwxvyHvELnk0ZpD7/x/oBw9Y=;
        b=YdhkMhoGN1X3whSpOe/FsavSLt1BL7ZAEYCFyXKBvy4xL5/wMbF8Xnf94cxkpGUkj2
         hevO8KVvQAQQ7OhmH8LXHaVun8jHAuVHf59P+DgXeKFIX0O4SbKO5jsdRVVHdOG33pC9
         wYQCXLZdAwOymvJYoJHKUnY+ezt0dzK5VwZLhJtQrqjf8T1eEoAkg73GgeU1L0MPrJVM
         0EbPytgwOIie/vgvAllONoh6HFJHDGTLfl0vRM5kJzLSLIh1GNKA4A4tFN8EhA7Daxgv
         VKrEhBOR8YwrzC4DxUgrRMQM2KvfLaLPuEyYxpbter4gSn+SlXPDIF271bqFI/QQ5X0O
         ClZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711399; x=1702316199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrH3TZ7rDJNZ1i1xkHsBwxvyHvELnk0ZpD7/x/oBw9Y=;
        b=vwqzyLQkjKar6VfF3wRACp2sylFfyRaP2ZI49sdnbc95OS1gGVcQIkEcAMTzHs3IHU
         H2qw4MTfs7DL2nrvWG2uiI3n8rzEjluAdE1ZINBhN20TJ/SPpg9e64IY7mYa36H63vnH
         n2bnWjZQGT2MhUBYkj8muxAWyAhqVdeWhqJ2pVkGHMhL8AmwwpAT8StaxXtCd+M4LO0e
         itHl8RkXy5OzDv4GZWEVR3V1LVmLjQS7AcKJxY7qo3Bd4dIskojPrQEyRpHCGkTr0V0X
         XV2V16ZtZPsM7vGKFadXjNpVAHYSSCAtSCrHI4k78jENr3WgnsI0cL0B+OaGgpi8CdIC
         Pp6A==
X-Gm-Message-State: AOJu0Yxcz4gUt9AJGrzP0hTfTCcvQCFeVByzYPcTlwq/kcjEQYBKcY1S
        5TgdaOFkJO1xEl69WsHhQrlwjw==
X-Google-Smtp-Source: AGHT+IHdnEyw7hSWzDnQ6Cq7koICvW6bO2UEREv9+4lNfMkR8SUMavgu503H0yzMUvZMLsKT14gfLg==
X-Received: by 2002:a05:600c:3115:b0:40b:5e21:ec0e with SMTP id g21-20020a05600c311500b0040b5e21ec0emr2430132wmo.64.1701711399381;
        Mon, 04 Dec 2023 09:36:39 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c831:1e47:2:5b96? ([2a05:6e02:1041:c10:c831:1e47:2:5b96])
        by smtp.googlemail.com with ESMTPSA id l27-20020a05600c1d1b00b003feae747ff2sm19560106wms.35.2023.12.04.09.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:36:39 -0800 (PST)
Message-ID: <518bff9d-5cf8-4211-bdfb-7d8edb80d89c@linaro.org>
Date:   Mon, 4 Dec 2023 18:36:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dt-bindings: timer: Add StarFive JH8100 clint
Content-Language: en-US
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>, kernel@esmil.dk,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzk@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@linutronix.de,
        conor@kernel.org, anup@brainfault.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, michal.simek@amd.com,
        michael.zhu@starfivetech.com, drew@beagleboard.org
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
 <20231201121410.95298-4-jeeheng.sia@starfivetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231201121410.95298-4-jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 13:14, Sia Jee Heng wrote:
> Add compatible string for the StarFive JH8100 clint.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied 3/6, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

