Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B980E71E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjLLJOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjLLJOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:14:06 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F86BD5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:14:12 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5df49931b4eso30999297b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702372451; x=1702977251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=94mArPi0KBLNCW+9/5j6k94DKj0W9iwezw/gK4SeWNw=;
        b=i/RA8czSn8NHJ77rUq8fpNBebUWp3+qX1rj4dvxzlcCC66KYB2Zboda8GfdaTOPt1o
         MTJg6nPuvTng/SDyqIVjxeWX/I9jP4ASSEeF/D5fJuuEIl92NbFYWTNsJHKJHqD3l5Ot
         WEmNq2VzjlC5yDeMC/nP2fJEbz9ah3ULIDiPtDb1olKdDxu/f+M1h+hjrJWdhK96R2eU
         PbjB6/1er/zlVRvsMw+i+j61I63PDJRIBUb7HsE0yi7TViQ2ZvsXnXPirmLIZEyVbCR2
         AQ2IBIkq/d7G6ZhMB56kv3g1mCm8w8az2VAq85znHJN2WeCJ82otAyzEJz7Ey/YOIUtc
         6Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372451; x=1702977251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94mArPi0KBLNCW+9/5j6k94DKj0W9iwezw/gK4SeWNw=;
        b=P8yyafTo+HgNE/3pzMVA/fSf+RaKqScZcowWux1PkAuarXwrqlbkwdZTylPB2q4Zwq
         WfQFU1JUoWKUzWDkRl4oK3+2QCtaNGbmnFfKknzibPLsO8t51tNdZ/AYjiVHVa9bCyBk
         iuX3WwOW6BKyayJq5w0kiEp09xgbRg17qHfu6Re3KKxZbCHNNwEblwf275/6gh1KDnUC
         PwNKZwLhZhW/++zc94BU0+CezFtlHSF+/gSvMVaOUN+CJ9NFwklyC/jQkRoibI0Uaj6j
         a5JIPl7ZpAAEo94hIUtXzWlKcPMX0fCgFKyeosfSe4iUG5JqZVEDVrU9fGDWLvkwW2V7
         ZMlQ==
X-Gm-Message-State: AOJu0Yz7zU915Hvc4egsYTrsKE/3FBqydnxYMBTBRPaKOiGmUec2269s
        2qG1spo+b4iuQkvLrsRPRueSSATCJSvluUSgQtcllA==
X-Google-Smtp-Source: AGHT+IEM/V0yIgohqydrpyBc5XyPo5SnxiZzn3s8K+OkWsi4tAsIzwUabgxsCocaEqBDGw3AWP5HKXJFT+e/tKMQ+IQ=
X-Received: by 2002:a0d:c386:0:b0:5d7:1940:b386 with SMTP id
 f128-20020a0dc386000000b005d71940b386mr4641044ywd.82.1702372451507; Tue, 12
 Dec 2023 01:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org> <20231212-x1e80100-clock-controllers-v1-7-0de1af44dcb3@linaro.org>
In-Reply-To: <20231212-x1e80100-clock-controllers-v1-7-0de1af44dcb3@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 11:13:58 +0200
Message-ID: <CAA8EJpoaydf3Fqpo5baAihGS5X37LCytKuYP5EmQt75ibMmKmQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] clk: qcom: Add dispcc clock driver for x1e80100
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>
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

On Tue, 12 Dec 2023 at 00:46, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>
> Add the dispcc clock driver for x1e80100.
>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig           |   10 +
>  drivers/clk/qcom/Makefile          |    1 +
>  drivers/clk/qcom/dispcc-x1e80100.c | 1699 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1710 insertions(+)

Reviewed-by: Dmitry Baryshov <dmitry.baryshov@linaro.org>

-- 
With best wishes
Dmitry
