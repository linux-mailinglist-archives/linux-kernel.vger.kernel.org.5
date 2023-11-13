Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889687E9DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjKMN7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjKMN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:59:16 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59835D5F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:59:12 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c011e113so51971247b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699883951; x=1700488751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkvb5jXjgdppD5M3BE/7qL+8HuZSIdn/P5Opxdga4vg=;
        b=TCKOvUQ4CSkCSxPbE6alrem+biq8PaJkJSBINQyZ4QQ9WWz/ffRg+EnpMvR3ykCJDa
         FKr6ZHxgbnXnPMnAAVNQXaLQHmDxZfZoqrSNYkVTspltrJc5W6tDashZ09oPhzx4yMYI
         M0vbd+DMOT/giyez0MocDXpuW8gh9St8FjBkwtT3gQgp/aZgeFeK9gSnKOyUGQvux3lu
         rAhmp3nW2MA6eCeDXJI55tFJwCySlKKwIWEc8sVmPldNAWpIHl5IXEGoBunYDQd56O7O
         S+7LEHs2Dzl1HErh3B83ZpGT9gTXO9SIDjfeA1e6+UBPe5mX2EdPPWwAmuyfPM7XQktF
         /lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699883951; x=1700488751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkvb5jXjgdppD5M3BE/7qL+8HuZSIdn/P5Opxdga4vg=;
        b=K+jNbXOtksKy+B9oG5sRm0NZ7R1kXjSystwYJlEEbyuTJFUZWpg6QSGyQU64c+TOYy
         O3WVx5CS2hSzOBUvucOrR/X6qwumtrlTXMt3t8ni57J+thMN3B3RbKcOi7BKMwcUpYI/
         cA4i/op4Tc72SRAOK8QiDtE9aQU8+Q65wB6v2RxiICWXR8/PY8Rr/5n/KNP4pr5UjHSa
         z1PZ+dMaNU6og4VT8H97CZvyzxR3v1W8v8dVmSD8Mc3AQmb62kA+xX3/4CCCbFCedxJ9
         G1Nh3NM5BWguuVx4Xk2DVdEoKZT7tavKqDOBu0YjydGiEBmh9thoL1orQYtFJ/G1xtjA
         8Fjw==
X-Gm-Message-State: AOJu0YxP505f9h9ey/83Gs8Lju5PlPyNMpZj2jLr77gMgHzFaL9mzwSK
        N2QkmxC2pFAWEwAaxeVbK7kP/lLPO/ScV+iWnLm28Q==
X-Google-Smtp-Source: AGHT+IFOcCkw5XM4JWZUE7/qoRjiVbjPcLcLFuTmK8ZrnLgJQhE8oa+pIkQakxeis9S8rmZPpg6AROJznV8FA2Cgah4=
X-Received: by 2002:a0d:e342:0:b0:5ad:289b:999 with SMTP id
 m63-20020a0de342000000b005ad289b0999mr6727763ywe.28.1699883951561; Mon, 13
 Nov 2023 05:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20231027093615.140656-1-krzysztof.kozlowski@linaro.org> <20231027093615.140656-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231027093615.140656-3-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Nov 2023 14:59:00 +0100
Message-ID: <CACRpkdbSCkq7a-3=FfC6=bxh2JB8UZK9K1Eumf0PBnpuArkHSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom: sm8650-lpass-lpi: add SM8650 LPASS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 11:37=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Add driver for the pin controller in Low Power Audio SubSystem (LPASS)
> of Qualcomm SM8650 SoC.
>
> Notable differences against SM8550 LPASS pin controller:
> 1. Additional address space for slew rate thus driver uses
>    LPI_FLAG_SLEW_RATE_SAME_REG and sets slew rate via different
>    register.
>
> 2. Two new pin mux functions: qca_swr_clk and qca_swr_data
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied.

Yours,
Linus Walleij
