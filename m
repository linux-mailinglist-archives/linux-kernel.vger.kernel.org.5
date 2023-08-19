Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632D67817F9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 09:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbjHSHK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 03:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344099AbjHSHJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 03:09:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B53C27
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:09:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c353a395cso210661766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692428992; x=1693033792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8qI0sJztqQDw6h/vBwRwLhtMGerNoCgM5/KeoVhh6Q=;
        b=loNavOkqgomEZyWZklIcwWH6P4OTjuA0nITXlNoir2jSumGwkTVrhmiRvoWpu3BygZ
         v0b4SPNBoGaqal88HKs2X4+Qc+QC1/nyhzWLYJIM52KayIqvLrUrQ3Um4JYxxSUHCg/+
         1auED2qbQ0qAyTYlFQJUMx6b3tCHvcxTFp4SP/KtSKjmmMxGUDQ9OHXDwrquhXRudOnP
         e3Y6/qF2J2rL6/rdgV0LcSZDXYdH+047HqSY5YvsKqyDahJVNmb10oBXpeQEQZNgzaFZ
         VVpKPma5j4km5nSuz05zfxCvHHCOitODpDmoln5EgH8WMtQXt7xGZHSfMcVdshypbL9v
         lk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692428992; x=1693033792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8qI0sJztqQDw6h/vBwRwLhtMGerNoCgM5/KeoVhh6Q=;
        b=iPzmb9JopTW9r0drQHNXsCoW34AVP8pW2YYNwYxDunh4/19SIKWlv9AEGoIq5vhNk5
         h14DZC4P41lWNf4Nj5Fe82GGyBX3guDFWwi2cU4WusQnmHXFDK4D8jJC679EqnrJiqAk
         p0pl0IBtrPghhFqO5h9yXHaFFj9M0BxxfwMf/b6EPoJrf76v5r+aYA5X4he0cJCR1riG
         E0ol5YDOJjsKiAp0ah36CIeaExt9fUiGF3J2BBX7V2Arg+hz4Z3d7tUrkeEZwAEsCu3q
         Xz68nVfjRI8GsjzaapOXGAra7taVoL2g2SgYQEypzTHwjjgt4FUHS3PCydADqtLUh0Et
         cg9A==
X-Gm-Message-State: AOJu0YwGrQnbCPeEWqav/9ACY3yV5CA8DqTrhiJ5/K4w56J3xgK1RvfF
        kh0TpqXhYMb72TsM5PPrMLicXg==
X-Google-Smtp-Source: AGHT+IHs6WiXcA/juYG/iLEiP8ou4eb7inN/XUyyyKaBZRpQm/jMfrvGH7BD8NMoU7Rbym5ZM3OM/g==
X-Received: by 2002:a17:906:113:b0:99d:dc0b:a898 with SMTP id 19-20020a170906011300b0099ddc0ba898mr870453eje.69.1692428992020;
        Sat, 19 Aug 2023 00:09:52 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id sa17-20020a170906edb100b00997d76981e0sm2182783ejb.208.2023.08.19.00.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 00:09:51 -0700 (PDT)
Message-ID: <b5d56d90-dc94-c29b-6429-281622e4c559@linaro.org>
Date:   Sat, 19 Aug 2023 09:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/8] dt-bindings: usb: samsung,exynos-dwc3: Add Exynos850
 support
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     JaeHun Jung <jh0801.jung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230819031731.22618-1-semen.protsenko@linaro.org>
 <20230819031731.22618-2-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230819031731.22618-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2023 05:17, Sam Protsenko wrote:
> Exynos850 has dwc3 compatible USB controller, so it can reuse existing
> dwc3 glue layer. Document a new compatible for Exynos850 and its clocks.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../bindings/usb/samsung,exynos-dwc3.yaml        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

