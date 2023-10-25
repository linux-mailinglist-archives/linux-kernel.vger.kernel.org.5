Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15E7D658D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjJYIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjJYIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:45:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B604130
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:45:30 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da0359751dbso567068276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698223529; x=1698828329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUjEKPPK1HVvfm5iMA1jsGeiAQzbP3C1OGLLdP7j+F0=;
        b=kSM011+WAbhKhCRdz24MzwZyamjVKjC/cB3FztXBlYvS0d7bsbuzPYja3I9/Q09xm0
         gsF4aVwWcbkGNVnRqNkcamg7dVf/7LGH8turTSUXWcrDh5wzN7wiAEYtnpAIzsGMy4bD
         BMwY6gWhdDRicHXaA569SlHyTA55BxTqxWA+LtBT2QHi8x6mQAUKvHk7+pbnqk1hKZkv
         idwO3Iw0UCKwyULLyjvBKSH5zZhDcvI8aaT9PKb4NQoLOW3hVzXqmzzkpQ8HTCRjjkkv
         Eyc/rv4A1hGRti6z9yxJEsuCXHy/KOMZTq6GRsbc/dsuMU1WchD8OapOEKeedNoRaYR5
         djLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698223529; x=1698828329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUjEKPPK1HVvfm5iMA1jsGeiAQzbP3C1OGLLdP7j+F0=;
        b=Pnq564y1zXe/tPQYttBVRvxwxy5Inm87ORf2ycab5ee7VeqLh9CU4Rcviihzf+3FFQ
         sGEk6qbnQ6e6bSin1MlCGHZ1zzoyPzVuWKpa5ZAvhrWYtD+0b9IpMF/7nocqFtcDmh16
         ZAq3r1skfygRQbjSDoo73pdKI0KcZA5pauEp3m1YHvLqZenuUwZ03BAsNJghrVN/tW7S
         lMCR79ae/UahFmHZP/dlZm/U67Ez2JA6hIvSvrzA/JGamNCLW79cbIphiXRqdfQoMslR
         OBulAaDqD2qlkaI0HnCj0a1tc9jnWNTWiiCrwx+T/G0CUiHBbMX3pFkcyIjAPz4TLF7Z
         W62A==
X-Gm-Message-State: AOJu0YzdnI0kGakm1OkMUMZy1WCnergRauA8aEiuDXbCv0gK6MAABxyy
        nLGkhaR683BfymlmoAJKs8oPa9WfKYNX3K/vDwf79g==
X-Google-Smtp-Source: AGHT+IGyTbrxVs7VFxCmBF9leqPAvlEBqZar6fx6efgCVXxbDR6j2gqXzGwebhUh2fQozM72QqmvnBQQTeXly8PMoB8=
X-Received: by 2002:a25:7687:0:b0:d9c:28cb:2e54 with SMTP id
 r129-20020a257687000000b00d9c28cb2e54mr21029326ybc.18.1698223529452; Wed, 25
 Oct 2023 01:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org>
 <20231025-topic-sm8650-upstream-clocks-v1-10-c89b59594caf@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-clocks-v1-10-c89b59594caf@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 11:45:18 +0300
Message-ID: <CAA8EJprbfWZs+hofu4PhfdtYox96vhE3FFY1XK5vEds1dX213Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] clk: qcom: rpmh: add clocks for SM8650
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 10:40, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add RPMH Clocks for the SM8650 platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
