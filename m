Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C27F75EF1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjGXJaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjGXJaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:30:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B56B129
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:30:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-993d1f899d7so729932166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690191001; x=1690795801;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57uky2J15DdtQrv2rjlWZgMfo8NXsRG2fMzc55Ic198=;
        b=jFUErFeLeVEptlB+O9nzNQK7hMxAZV5rnGkc32PL+8jQzi2r2g/x7soBqZdIg6Fxrg
         We4BePUKG4F7C8zc7TXoYaa8FPk8Vfx0s+CbXcu2UnFDofBjAYUmZRBXpe2XCU1ggQa3
         u7JeLIVl9rW+W+bhv5MYSWMw0DAjE8RTfxWmR5FRpJ/0oKtUUtIfH/CRWhU3lpJvm4Wh
         GdlPrwSKegBu95Tk9ra339DpmFjPsQM8MtJ1LdqVzEZDNAZz7G8K+VXrRpRGrLBu91wO
         TkPIadcN39N9Wic+GOZ05rdWfLmp86SsGQHf6PFdorOi00nVmftfU0Px4enSOwf+01YO
         2zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690191001; x=1690795801;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57uky2J15DdtQrv2rjlWZgMfo8NXsRG2fMzc55Ic198=;
        b=khKDjKrELcTf93EXc2qWIxscNNGVPUno3OM3SeajeFwHPMqalJiXQ6f22boA0GtO4W
         gbVkcG2DOU/d7kE5jPEYGf+BhbWdf+ThD+nHCmZ0tc0oUP2+rWJaKLi3QRid+1RGAZjb
         entyZCouu6sG/TuqModzWVXhzIKSTva7O0fFiNcHoZYGPJc5XdOAFD0C96uIQY6Z+hfz
         FvH7TLRY6YEuS2BNbUWg1dewqUE3L7mI3GELFKIURTBabSQaofJPFqAQA1PXq3NOrCAj
         wTpQ3MDz9ZBV6x6fEUxlX6eisGuYabP3AVykbp9L76FmOOY+q+zpkdN/bllea3Du8iSp
         XPfA==
X-Gm-Message-State: ABy/qLb0coPna+X5JfXcplSSzI/ux/ikELCN1psPN18M/qaCpJckzc2U
        PWUXrd6oomO46qyksoVmpHPulJ6BnlDvLJrg0/TLBw==
X-Google-Smtp-Source: APBJJlEJtEovotfOmkPJ26TOunzbReLP+q75OveEDvLGcOEOs/CvHoM5sMCzzWydJ4UlTAkQtjQQRQ==
X-Received: by 2002:a17:906:7a01:b0:992:a0c7:8d2a with SMTP id d1-20020a1709067a0100b00992a0c78d2amr9270109ejo.54.1690191000874;
        Mon, 24 Jul 2023 02:30:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906960800b0099316c56db9sm6376255ejx.127.2023.07.24.02.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:30:00 -0700 (PDT)
Message-ID: <6e6562b3-82a1-433d-f44b-f717e2f9943c@linaro.org>
Date:   Mon, 24 Jul 2023 11:29:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] dt-bindings: display: add bindings for pcd8544
 displays
Content-Language: en-US
To:     Viktar Simanenka <viteosen@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230724090713.1489-1-viteosen@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724090713.1489-1-viteosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 11:07, Viktar Simanenka wrote:
> Add device tree binding documentation for PCD8544 LCD display controller.
> 
> Signed-off-by: Viktar Simanenka <viteosen@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

