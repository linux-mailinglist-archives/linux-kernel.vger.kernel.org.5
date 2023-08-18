Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAFF7813F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379680AbjHRT5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377351AbjHRT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:57:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861426A4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:57:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26b44247123so954062a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692388624; x=1692993424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FVy8/I6+hZEhbfOu9dBJY0K2hcEvw4odHhWMeKKSlSQ=;
        b=Wa22YcrQ8hR7kutK9Cs/OH6zIDYKtTp61fXYhWf3xpUE1rqFQJonTLOePXKjLIqpSz
         j2x/7uPJk/GM8YxKmVNls9MGZGNQD3t9xkZRItjXW4vSRODwNYKArVV9kowRbFjUBD3T
         EeMVyocQhxPysCYBODX9xNHP15zKYz0J16vHc6N9tOd7MCRM+TTLKIFA9POjzFm4YkMa
         /rE9XxV5ER/TpdwhtCrq1BtafPFYepIcJeD6IXS/QzlufzIZ8EARXG8GoHoB6ufUV4My
         HRiHGcHReaBnQIPYT4DEZvQmHXqtFEJfXslFzNPFxplwDUsYVVIW/XW4jEDLtBuYeFjw
         8WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692388624; x=1692993424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVy8/I6+hZEhbfOu9dBJY0K2hcEvw4odHhWMeKKSlSQ=;
        b=Iz6tURnSySg8KJGjxz5soA+ySHnH8rqq9d73VargnJ809PQI4hjOFHaWFxGilSq1ue
         QojnAC+N59irf3EVVlcqSkMYBXvSLvHBZfODFUHNN0buU/gwsmJwy8G5xNb/q7hJjDze
         nEJrzIrOqoin7OcwrStX+zSP5woyrK9zbppv7+HpVzs9c3fF03AFSKJXz2aQevxfTLzQ
         6/L3ZLunl5aPbuUcnr+G2IumYW53M2FjiiBpzE8kl80H2Ck1pT+uC8a5a93+6U1aKhcK
         OmTFFJXtbVt0cEC1SCsbxttfvWIcQMmVmpNYSJqS8Qrt75m0DP11v+rsyM18blRct2w1
         io5w==
X-Gm-Message-State: AOJu0YxmzgFZGqfUKVFS0V+HICyhrqNHPzzYzo/zg+nWexXR5wsEHYHi
        sroxyP6Z07pDcXGpl046NvJVdr1IWWpBfK6nJ78qhA==
X-Google-Smtp-Source: AGHT+IG1AUyT+kHxOcDxv2bvger1UKXAP+l8gqMIhxZAF556A4JVr7/WDWdrcG8dpTGWzJ7hKbnfj/3TE43gBySo1CQ=
X-Received: by 2002:a17:90b:4f4a:b0:268:300b:ee82 with SMTP id
 pj10-20020a17090b4f4a00b00268300bee82mr190016pjb.19.1692388623694; Fri, 18
 Aug 2023 12:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230818102911.18388-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230818102911.18388-1-krzysztof.kozlowski@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 18 Aug 2023 14:56:52 -0500
Message-ID: <CAPLW+4kiGoHvOjKxCNxb3adL+i1V2FMbun8Cq3bw0M1aeYfjAQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: fix order of
 clocks on Exynos5433
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 at 05:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The Exynos5433 DTSI had always different order of DWC USB3 controller
> clocks than the binding.  The order in the binding was introduced in the
> commit 949ea75b7ba4 ("dt-bindings: usb: samsung,exynos-dwc3: convert to
> dtschema") converting to DT schema.  The Linux driver does not care
> about order and was always getting clocks by name.  Therefore assume the
> DTS is the preferred order and correct the binding.
>
> Fixes: 949ea75b7ba4 ("dt-bindings: usb: samsung,exynos-dwc3: convert to dtschema")
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
> index 240f41b7133a..deeed2bca2cd 100644
> --- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
> @@ -82,8 +82,8 @@ allOf:
>            items:
>              - const: aclk
>              - const: susp_clk
> -            - const: pipe_pclk
>              - const: phyclk
> +            - const: pipe_pclk
>
>    - if:
>        properties:
> --
> 2.34.1
>
