Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA07A67B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjISPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjISPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:12:48 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA6DED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:12:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d7ecdb99b7aso5544356276.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695136362; x=1695741162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RwBFLBCefbsy21c4npTbAU6eApQw+jfQJ+Mmxu8RhRA=;
        b=bPEnTuJcF4lDHZmR3vRaBKtKbtTG2Yfj3cVbo0Wq7d5IaoDzIAKJDzUM5Xki5vzkY0
         FdOjCa89MFz6pfx6oixsBsXeIfVGtS1V1jAKEAW9ODR/MgoEHkL3WNrTPN3kiY0BSxZl
         amMu/mC1tglsxOKbPhFBNBaNBZcU52g/il/v3OHlt5EGp+pCrfdT0oKsggJIz3YIL19C
         npLepS0/V9w54eOQKknN4ZNhANpVCJaWwSF2a4E6go7ygBnx4kUGhSDJ5rBJKHitZvUM
         rpVAqmAT9m7gV1lIwwmxURZc85ZVpusyIAJ0G/NLdu+xvrzXNQZR3PFlHbUXeVILetfa
         mRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695136362; x=1695741162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwBFLBCefbsy21c4npTbAU6eApQw+jfQJ+Mmxu8RhRA=;
        b=SH+u9F/FYp86ZvCbixGuiial9R0K1mrXGlmSUo9j1z8TxDLzu2D092dZTLBNm6Ikst
         RL8kM6ijnHmB+9C7T+dz+zFWari/2hVHEVLOcTDh0s3wxY0waXc8t7a0zBRNPpE766oC
         odZR6Ys9sGfZ9KsjRP4HbukKOK/eSndpdYRPauLE/Rh0yRaNzQ4IklpBxF/cjLNWnb01
         J+60JmUwoqTtGkIYLh3jgX5u9I8uvk3DN5Dv7Q+DlzxYYBkiLKLmx7zWq5J1yOYqJgnw
         jofZID6UoUFLrSM4y/ExReRsbAzqGM4oTd5z4aoe8QBNPGzLKrF6oiY4zaoM7IPvJd41
         xkXg==
X-Gm-Message-State: AOJu0Yx9pds2djpN+PTqRqs9IIQi5O/Cfekuii6t3qAman+ymxSxqBSc
        pP3ra+YLeo7hm3n74Yq/sVS8efGian4b8X4TXS7bfA==
X-Google-Smtp-Source: AGHT+IGSY0KfKzL/8laxx9lvgeIq6kZxzBsZt5dq8iJrSTHyFpS5ghMNwzig2inkSJFiqO0qXFR1oOfDMzboG7t3tJc=
X-Received: by 2002:a5b:c48:0:b0:d81:cb92:337c with SMTP id
 d8-20020a5b0c48000000b00d81cb92337cmr10601197ybr.54.1695136361868; Tue, 19
 Sep 2023 08:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230918205037.25658-1-quic_nitirawa@quicinc.com> <20230918205037.25658-3-quic_nitirawa@quicinc.com>
In-Reply-To: <20230918205037.25658-3-quic_nitirawa@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 19 Sep 2023 18:12:30 +0300
Message-ID: <CAA8EJprAxUhipHS1+BRRVo8o6gubNRJk12msMgOraDjFBo8rVQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] phy: qcom-qmp-ufs: Add Phy Configuration support
 for SC7280
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manish Pandey <quic_mapa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 23:51, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
>
> Add SC7280 specific register layout and table configs.
>
> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
