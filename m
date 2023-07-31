Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2907690DC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGaIyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjGaIxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:53:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E6127
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:52:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so4485306f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690793522; x=1691398322;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VLfWbi9LpC+kAc3VGMMFbleVV5XYZZSHuZj8dV0MRNQ=;
        b=FJR40C7sbicVIIcodXp71hYuVhBgeudkRgQSSBTx58mWsaH14NYH2tlakcOZMZqxk7
         ZL7focUOBxoBxzDKQFyr62olZJnM5/eixvH5KuTthddb/IS6gutu2nYMxkCDFtQ8MFPG
         cjISnP0BxDZBVSzf2l+qf6IS+SYQMQICsrI8Rpkp7VxHpjfD7nRj/HkTdaiW53VBJoiR
         WJjR19qOxlk8eSS7V60zZdQvW1a//lYBM92R31yTBqbDPd2Nj1u4X7MNruDANA4IHaSj
         XBKu/q/zb8Ik1sDaiP8p8A4W5WCMKVFg9IoezXR9B1VcqVVaZE6NvqIQJINfaw7dKVTd
         KfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793522; x=1691398322;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLfWbi9LpC+kAc3VGMMFbleVV5XYZZSHuZj8dV0MRNQ=;
        b=eJdTf928Ulyt/0MrYJdBqD+EM9Y4aCU/YBm8Z4QmpNEKGwxJDYR6BwI6/kQZd5FJzq
         K8FPJCOHVnwjTvkJAjvs50KmpoxF4S0t7LbnFuCeQn76FmhGhHb2aVvpC+iIA8yS7l8c
         TUmUiVwUns6mqUqD+a5sw761CDv5H7LxKD2tG5Wuh8DRy3jyavHf8xGY7rhTdNOvc0El
         5SVgEneIGp6czlv6gJbeELfgC3PB6quFVgv2rD4Kq29Kfo/nk9+Y8m8kfW1mPhKEgb1X
         LnmZDg3KgaPuPjY2Pt0bY2hVDz5yUAr3uUQLOEOlIqaBwcmLao9t/m1QOE1IQ+2ErpxX
         Z2jA==
X-Gm-Message-State: ABy/qLa4s4pDHcyQU4bKh8EEDeiIa7D1Sz21j1xxfr5DO8QwZjOUy7Yx
        DTA7+9eIpvVgjUx9YLwfvnZOZA==
X-Google-Smtp-Source: APBJJlHwcsFlqzq6Ui6fHsJxLcC3Q8EQl4TVADmOlbJQGH/OQBQpfNySHW5H12XqkePG0iNJ6TGrMA==
X-Received: by 2002:a5d:60cb:0:b0:313:fbd0:9813 with SMTP id x11-20020a5d60cb000000b00313fbd09813mr6600073wrt.28.1690793521863;
        Mon, 31 Jul 2023 01:52:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b00317878d83c6sm10179563wro.72.2023.07.31.01.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:52:01 -0700 (PDT)
Message-ID: <78f54ba9-2ef9-02b2-63ed-85b73f5b0429@linaro.org>
Date:   Mon, 31 Jul 2023 10:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] ARM: meson: Drop unused includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230717225623.3214384-1-robh@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20230717225623.3214384-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 00:56, Rob Herring wrote:
> of_platform.h is not needed, so drop it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   arch/arm/mach-meson/meson.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
> index de56e707c7aa..d3ae89dd84bb 100644
> --- a/arch/arm/mach-meson/meson.c
> +++ b/arch/arm/mach-meson/meson.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
>    */
>   
> -#include <linux/of_platform.h>
>   #include <asm/mach/arch.h>
>   
>   static const char * const meson_common_board_compat[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
