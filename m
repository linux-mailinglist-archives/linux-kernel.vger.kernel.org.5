Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC94E769C29
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGaQUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjGaQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:20:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB6510CA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:20:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf9252eddso407585966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690820414; x=1691425214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LY+KbzBFphMzSu4CSWcWecu2jgDoDXdn/pB8KLGIIfE=;
        b=tU6OkIeB3huSjBfcsVnlz75FPXQ2/zgKLdy18dmBe8uw+HIjjBpAErKzguBjn0TMx7
         CIrAFWnjDrIGWZcGlqTWtCOu2YQzlDY2XbttdVGLf2Mcou5v29fZqr3GlBCZWFhnzgvW
         jw1XD8dV9FkIQB8MoWCjiq8iRhdZMidpDAP/h5IXFuXbUop/NJGe+IcIYr8VvGpN6V6W
         WX6FZTD1pliYBK+prT9FER/mPmXxUonhgJ4q9UQgKGOOoGO9txm9hGeT/RvAgZk4a6ml
         UJvb7DgWIc56Q8r5UclUB2gOXkFm0CTDVo7bWI76DDUdyP1a2UKzA/gpwypAi2oapVAd
         6n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820414; x=1691425214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LY+KbzBFphMzSu4CSWcWecu2jgDoDXdn/pB8KLGIIfE=;
        b=TXr16m7Nt9n9gqSr/GXy+Z041MtMcSWRmnFa5P5Rmfyqm6c0lG1+5vnjlQ4NlYi/j3
         T9M21CTXVz3vbAMdFe4DnfR7OPpWcyc0ywJqZ37MaIIEd484H6qDxiuS+YBofaBEJFHd
         oKlGWzjfVna/xF1OSdT6ZcJckaOKkeOb3LjvSsDu7kwNHW3sFLJH7+kQxJt9eEFVL0ns
         reCcGJU65MPx0FZn+jbGRlQg3N9P9XMhQlgtNj8R4WaW6QROLgxB96fvfI0dRhHNTCLM
         aNZxiNTCupnM1UtYHpaNVPXM+wCv+un4W4rBVCgf1BnIAmhg2IofRGS9FBylK6nbWo5m
         yw6A==
X-Gm-Message-State: ABy/qLbGa2XFDW+OantyTMjf3lpiyD7nB8Bc39OMM+aIOCsKtUE6E771
        7+spOnJNNwwJCvz0DuTVAnsogA==
X-Google-Smtp-Source: APBJJlGggMtpyljLc9riF8RUrIAPo7Q+TTBtJ4g1AR2b41xwuFmhnLuBPcwnCkq0rAXRxEV2lETg6A==
X-Received: by 2002:a17:907:78cd:b0:98b:dc6c:b304 with SMTP id kv13-20020a17090778cd00b0098bdc6cb304mr249625ejc.38.1690820414600;
        Mon, 31 Jul 2023 09:20:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906490a00b0099bd6ef67e8sm6424163ejq.78.2023.07.31.09.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 09:20:14 -0700 (PDT)
Message-ID: <42cddfaa-ce92-f6c2-4fcb-7064bf964aea@linaro.org>
Date:   Mon, 31 Jul 2023 18:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v4] arm64: defconfig: Enable various configs for TI K3
 platforms
Content-Language: en-US
To:     Udit Kumar <u-kumar1@ti.com>, vigneshr@ti.com, nm@ti.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, arnd@arndb.de, geert+renesas@glider.be,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     j-keerthy@ti.com, a-nandan@ti.com
References: <20230731161048.2522154-1-u-kumar1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731161048.2522154-1-u-kumar1@ti.com>
Content-Type: text/plain; charset=UTF-8
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

On 31/07/2023 18:10, Udit Kumar wrote:
> Enable TI ECAP, DP83869 driver, OMAP2 Mailbox, K3 remote proc
> SND_SOC_J721E_EVM, MCAN, UFS and RTI, Thermal driver to be built
> as module.
> 
> These configs are supported on below TI platforms
> 
> ECAP on am642, am65 iot2050 EVM.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

