Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060C5766C83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjG1MFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjG1MFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:05:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA09449F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:04:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe104df822so3888685e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690545891; x=1691150691;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gSlNrbO1rk+xDcirdtw/sCPOvAObe1RjL0munXiM0TI=;
        b=TYAGc8gfKz/OW0msL2tWpU19Rrpb9zzQbEvwEfVYCaMxf9mhIVH1+pAcJEsQdJIpOM
         a8fAIFAoI1iDM10KfqmwXLV7uvlbB1FNhiglVqunVuwzHgAgi0ZHcGsPLg6GHOoXXnRI
         ugrnOjLkoOsEjXLgUHQlKdZZYNZULW4edGDaWo2zImtX9UtQoUtt0F8oS2yFt1SnVqq3
         /pz8Qz706MKvRhZTLoBM2GhSYuj/uAlwoCqBgXVe2sC9BbI7nNmW1UgBpa8bsl/6SsaA
         ydAN0AGxuzyzGh5shMOHMC6p/05z1ZGvjVz4MV2q6a+afLnUOsnHokQFFsAzUkSKKdFh
         ynjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545891; x=1691150691;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSlNrbO1rk+xDcirdtw/sCPOvAObe1RjL0munXiM0TI=;
        b=Mapt55g6qR+D/ynvEhl61D7uFwspu1eZsLXOhok9oWJliex5ztzo3BPZbmjJ+T7pYi
         BlmnBTqYRX1VzDahbJDn5mfBFo3fBYUOlqAE/RsNaBIHtEhbCdiwCK1wQFJrqOOwGRvG
         2eu0mDgGKbJ7AjIiiXfrQW8bd8Bv5gC3mj4VG35/hrSwluc0D1jx7TnPC3MC/P2mqVOF
         QPFj2bueewpGD2Bl490bA4GB88Qk71I/ForrcgoryvPpNhcEEQtdTIYVaW451dR6+yAO
         orfSk+VOnn7eKnLpZxN74iZbVvVkF6q6I7o30z8CrehgkNi01ugBCfF1qjpFPbe1rNYF
         PadQ==
X-Gm-Message-State: ABy/qLb56/FNvocxES6ByghPQiqEoEOEqhKyuydJ+vUUgTqr5mYZLvCz
        OcSmw2oMMICHW4EP8BmYkpxQFA==
X-Google-Smtp-Source: APBJJlF7KNSBtqEn3YNXXxJtPliF98qe2Pe1xhZtaQNRmbDUL27Nsx5wL/sI2Y8D8rG+4ibwvdWjLQ==
X-Received: by 2002:a7b:cb97:0:b0:3fb:b280:f548 with SMTP id m23-20020a7bcb97000000b003fbb280f548mr1861877wmi.0.1690545890946;
        Fri, 28 Jul 2023 05:04:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n7-20020a1c7207000000b003fbb8c7c799sm6879499wmc.30.2023.07.28.05.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:04:50 -0700 (PDT)
Message-ID: <30c23f06-a942-a28d-d8e8-6cf98abe5a6d@linaro.org>
Date:   Fri, 28 Jul 2023 14:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 40/50] clk: at91: sam9x7: Allow PLLs to be exported and
 referenced in DT
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102943.267342-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102943.267342-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:29, Varshini Rajendran wrote:
> Allow PLLADIV2 and LVDSPLL to be referenced as a PMC_TYPE_CORE
> clock from phandle in DT.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  include/dt-bindings/clock/at91.h | 4 ++++

These are bindings, so "dt-bindings: clk:".
Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index 3e3972a814c1..6ede88c3992d 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h


Best regards,
Krzysztof

