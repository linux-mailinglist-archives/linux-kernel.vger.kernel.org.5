Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D07E3AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjKGLRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGLRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:17:31 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441FBEA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:17:28 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5afabb23900so66174637b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 03:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699355847; x=1699960647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UA3eKIbLDTi66ojZwbDxHVIuKSsgHZtrRSiuZGWoeyc=;
        b=dWqXvis+OwkoJT65+PJJWt+1Sow1vy5tTWvFEH++6nNf7fw8e08nDjvcf6CstovLuB
         cNSbBnQ4Gn1Dcwoa9E5VGTPQoEtUccyVHHpNqslET08dmI5ktdM7sy0pIF3irRRGBuBW
         uwOM7G9W5IwHgaD5yIGhiTo9y7/HGy9Gz6TDS3DG0xn+mZEqw9kt6ib1iTsB1QJ7Rd6T
         e9TjllZlTgX5Nypl+eOOoaP/L4ShgjBZNBERs1a+OlAI+O8TElZYCfuYuntVv9bK0FoT
         WbVhWVydVrDPfc6UL9Mr19UTuKKvELeugMJzq9Dnx3QVKFbgLCY8ulDjwCaVrDe5Jeqk
         awiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699355847; x=1699960647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UA3eKIbLDTi66ojZwbDxHVIuKSsgHZtrRSiuZGWoeyc=;
        b=HRJQtYicvsO9cEbr/xogyjZOLsd7hvKv5UjxyYhFIicvaE8RhusF4g2s5xNS4Ce5ox
         w9iGNL6GW3mihL7V8ZMoEeos0m+jhCBZUu95WlXSzvmRPK0xryigsAXnT1foPkmungZv
         wtvHz7tUCVX2uTe4s49R1ZCNmia3omnAAHtGcIX4o/FEDclJ/0iI38quWjLLIdOwHYwR
         pN/FUvYMFH8dBvHfloUby8QzN2Xv23xf7xbmAIjmpad/trs+gY32ed7Q2BMYnl9Pd7dR
         iwmvo0nUj6l/KDNfmlW7iOUHzh9yjvwS3veu+WTucficU6SvdwZl4WTDmUHCstnVnJai
         8PXQ==
X-Gm-Message-State: AOJu0YxLUp6rRg40r1K+v+9PVfAQ2s4OgI6cI6EMiPQV1aM78fMHUSaI
        XgFnAFiFbJ2LLqbP5ehM2FAQ6RseptuxZuDkGg2rUQ==
X-Google-Smtp-Source: AGHT+IHn3xKQPpJfw/yjLuHXdyOodKFRa5wwg/lTDhjEOxriRvZNoqLiIAWRsDO3lXJMhO5jwURzlpoFeGFv7Rl4xts=
X-Received: by 2002:a05:6902:18ce:b0:da0:4576:3689 with SMTP id
 ck14-20020a05690218ce00b00da045763689mr35368328ybb.25.1699355847423; Tue, 07
 Nov 2023 03:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org> <20231107103540.27353-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231107103540.27353-3-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 13:17:15 +0200
Message-ID: <CAA8EJpq6=DbWHzYnhLb2=pnVivQEepcpJvdKgA6b7kYVpnY7Dg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8350: move DPU opp-table to its node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 12:35, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The Qualcomm MDSS bindings expect that DPU opp-table is defined within
> DPU node:
>
>   sm8350-hdk.dtb: display-subsystem@ae00000: Unevaluated properties are not allowed ('opp-table' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 58 ++++++++++++++--------------
>  1 file changed, 29 insertions(+), 29 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
