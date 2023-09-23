Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08B27AC4BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjIWTQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWTQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:16:57 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8968B193
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:16:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59f6492b415so4112797b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695496611; x=1696101411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVcs6WaBObvyPdVxt4a5ep98U8wpHctaEIsm3KAKh80=;
        b=J6VcQkqQc2z9FtFHX4tE0jeBVeL8wBkqFXLesQhydNyG3xjNWeQpKSpAZmkDprEZIt
         8yKF6B3bXrG4yr5TCHRRbVbnm+xd/KAQ1qr8GMvcT+ForXPvAra3mm8nKOA6EY8ZcxCL
         V79x5bSt0gr6kn5wEe2hj+6aAaYfzhJFvD6N1aaUY0swTjrqyD31iUeHw7izc5pHTwyi
         KEAbmB19do8DFfqTdsvmB0L4J3BrZa59fGnOM7sDjZQjNg+O6BR4QMsi70lgScOmTCol
         JxQ41++h9EiHeSDGoDpMdPBrWk4jdJ2xHgmRoOTPnlML7jzBA35POHrEP+uLDQ48c9XM
         DwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695496611; x=1696101411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVcs6WaBObvyPdVxt4a5ep98U8wpHctaEIsm3KAKh80=;
        b=OSJT0VOrzy8YfRNkzeh7SOtnj/BTlHHd/+Wioa1iKaz563CPltUmaGSVaJQcpaUmYU
         0mbJYNYSmKG1z5a6t2VKyPso8qTK+WljXvbXEtyEJ3riZFoTFbJtwcTnL/PdUdvP04NS
         4YgnLIk19asLU5uYOMR9q129DQ2jyVjuqpTJeqfMr1jhnMIDGz2zlwfea3yAjBn5ifuM
         jdkOmEIGXNXGsjnrG1bQBkRTYzkdxe7t7AeSuf6rvPGfKoSj0Iui9s3SvzFjRoxC0Ary
         xpy92lgOzhZOUA0PLJhyw1WhBsrxxvyIkA5U/LyzbSIUDsNe8AnTqWIzxFtefLVZcX5I
         C6vQ==
X-Gm-Message-State: AOJu0YxgrD+PIsZzGy1HA7auwI0mTv/nLCcjEBcCt+bDotTbCR6IRTYj
        JoiioN1nCR500tcqo2vSbtp/u2KkMqpFGEnmY9R9Z5mzCiN3YWly1V/RuQ==
X-Google-Smtp-Source: AGHT+IEy0vvL/85ZN5uulULrJQv0Z1SuezWIFLtE1yQJUsfrQPn+35lk02l8OpHWlZTaEa792MHcx0f3bd7yvT6Y/GY=
X-Received: by 2002:a81:4916:0:b0:59b:e743:630 with SMTP id
 w22-20020a814916000000b0059be7430630mr4069305ywa.22.1695496610786; Sat, 23
 Sep 2023 12:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230922-db410c-adv7533-regulators-v1-1-68aba71e529b@gerhold.net>
In-Reply-To: <20230922-db410c-adv7533-regulators-v1-1-68aba71e529b@gerhold.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 22:16:38 +0300
Message-ID: <CAA8EJprcJmU060FojSfG0d4uWnS5vQnm-R1sNPqdvp5Qxm1Q3A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: apq8016-sbc: Add missing ADV7533 regulators
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 13:50, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Add the missing regulator supplies to the ADV7533 HDMI bridge to fix
> the following dtbs_check warnings. They are all also supplied by
> pm8916_l6 so there is no functional difference.
>
> apq8016-sbc.dtb: bridge@39: 'dvdd-supply' is a required property
> apq8016-sbc.dtb: bridge@39: 'pvdd-supply' is a required property
> apq8016-sbc.dtb: bridge@39: 'a2vdd-supply' is a required property
>         from schema display/bridge/adi,adv7533.yaml
>
> Fixes: 28546b095511 ("arm64: dts: apq8016-sbc: Add HDMI display support")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry
