Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C4F7976F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjIGQSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242255AbjIGQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:18:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9661D2090C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:45:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso844462a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101489; x=1694706289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMRlMwN20QLTSRPs/jI5d8COnV1IkaL0AH6Bo1uSv5s=;
        b=A0mF5RseBSiIXVefgCV7xTv+a1EU9P133IfDqxhtbIbMMekz9jsF7Z6SiLZbag+urq
         ShogIgKrp2DSAJDTkeTBFdgksHWoqcTuQTlasKLkxjbBVlps6aAeIVeMvNh0Rv7tZvWP
         xxChyYAIEz0O4z+wJcGWKRG59kh6dmNR0jOVpae/4uiVjGgRsD5F61DJs1yldR6hGyqm
         wbolupI22vD7v1X+KeTASTc67myiM3PkuirY0SNnkI8snwrOHbGK4dQwxqb1d8UteYGo
         osHKoDLAHtYJ+0ibtHPbDK55DkVJCQqU5ph/HQitgD0ruM+rP5LtRoRcac2wpKWaOBuR
         Y0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101489; x=1694706289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMRlMwN20QLTSRPs/jI5d8COnV1IkaL0AH6Bo1uSv5s=;
        b=fJa3h8FZjx4DnfvxkQVEpcKj4OL6lOiBFzpTd9l4QcjulVDr85cOcqt2UhYjJzongz
         hJ/rh0424TImhOxlFxdzwIxvg3tBytv3uTpYgBcLAzezsbpdChue92bg0EeATz9bHcsI
         3DM/F4IrN0Qo9KCxoH36NwoVCee8oUpBeEScyH/ddVfIonkfK1TIeDaoj4cfTsetYp1P
         zXYnbapxbi20EdP8njUch/Ag8cjvu/ybjmHNPSzagQFWLMB5NKEG/oV5YVIHUh4lqwY+
         VOi0gxVd8+RC7h/ShVtAjw0YJ/fOKebBbsMUernN6TwB2Dj64rmBbUtt8r4F45jYIPqV
         3Zsg==
X-Gm-Message-State: AOJu0Ywc7Cl4Klb4XNrDEMxz4PuO7vVbxBOb5g9LnslFzHvaq17GZQIf
        OZ9i38cb9YcVHa7tbnatNY2ugRQzeaz9p9cIaWpyTe4/SmB1/+sp
X-Google-Smtp-Source: AGHT+IFUuNXZQLnUGxYZ4nwOIc/1ZCmT/RBxdiDK6aXiF/foDyogFPcREcWU6P3R5YT2nx0jFgg2XzMsNGlNNM2BlgA=
X-Received: by 2002:a25:a1e9:0:b0:d78:35cd:7f5c with SMTP id
 a96-20020a25a1e9000000b00d7835cd7f5cmr19661493ybi.46.1694093927719; Thu, 07
 Sep 2023 06:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <00a5ca23101df1f8f20bdec03be20af9d39c64d1.1693996662.git.quic_varada@quicinc.com>
In-Reply-To: <00a5ca23101df1f8f20bdec03be20af9d39c64d1.1693996662.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Sep 2023 16:38:36 +0300
Message-ID: <CAA8EJpqtXw1ukDZ1hXAc3G7LNDwjcduUdNaPHadfSqCuV3fxbg@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] clk: qcom: apss-ipq-pll: Use stromer plus ops
 for stromer plus pll
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
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

On Thu, 7 Sept 2023 at 08:22, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> The set rate and determine rate operations are different between
> Stromer and Stromer Plus PLLs. Hence, use stromer plus ops for
> ipq_pll_stromer_plus.
>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Fixes tag?

> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index e170331..18c4ffe 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -68,7 +68,7 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
>                                 .fw_name = "xo",
>                         },
>                         .num_parents = 1,
> -                       .ops = &clk_alpha_pll_stromer_ops,
> +                       .ops = &clk_alpha_pll_stromer_plus_ops,
>                 },
>         },
>  };
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
