Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDBD7AC4D2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjIWT0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjIWT0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:26:15 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920FA83
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:26:09 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59e77e4f707so48840317b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695497169; x=1696101969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZizts65y01ok+ES2EUhAYAn9GXHIb4VmooXZajucCU=;
        b=uNeVk+4wrEtA25qCf/0cc+V/J0m5Bv+FMDG8kGqEEoFlimXmspGlZ471bmLaWTR6Td
         svLBkwjoQ5RijQ121IJl/hmiuNKyS+WT/T2Gwm2T/sOGLUGvnXRo3v/tlVCdffyi+8zs
         QB+TT+5b2sh6nB+K0vELCI7ByecLH9qX4fncnhD3sxMhUxl2+l1WN9A95ggUhWwsLGKu
         biMyYisQOb3tnAnGiB+x2aW3r+EqpPceYseOmI29PjY1CaPZ3O8/+HKoqB8vx17UM/uy
         lUTNlH5O3A8vua5hzsHsd0MNdDlyUan+qr+hUm6Ar+JALhPs1eztA5WOu7f8XfcLK8mD
         NqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695497169; x=1696101969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZizts65y01ok+ES2EUhAYAn9GXHIb4VmooXZajucCU=;
        b=Q26L+/9GK99e1PSxBYcfVEMrNdBJrZlAQf/NqjwvboFMqoGBe/lq4bBSGWQzzOSjwf
         RnX6athUOM3UeUGOPsr8Dpa3Coq/uYUrD+kZbyaxJEOirhkbm8QDsYXJYMLxsdIT7j9j
         Tma6bDCpzbJd+zAQNqstrt0nwdFiu7fWRGzHeKYFCuDWI8SU2qgCqNBJEnjUSj/5Altz
         +XDBYSnc4MyInwW9VyU78laX0InyvkwRI1ct/EfSECffs+c/jmO2IMnjKB74SkF3MHai
         x6EExmCUwHFrRMj7A6TuEv6fa8D4Kv08cqp9b9e2mrDx/4HauZPx0mQ03XI8+z1WZdhh
         6Tyg==
X-Gm-Message-State: AOJu0YyyIm9sd27VdhkIb93hpmJOYyWz3jue3alksONTEC82DToKkc8s
        a87+v1O2Dg42wnahpdis1DP8PWpM95wEeIP6ntkvcQ==
X-Google-Smtp-Source: AGHT+IH8xd9FGQCscz8xMLf0DoFylip6IAWZhY41aoUSaGynGex3s2gK+VocIMx3e8QuWNuPxfssl9IzVZ3Wrlq/3w8=
X-Received: by 2002:a81:6089:0:b0:59b:4f5e:12d8 with SMTP id
 u131-20020a816089000000b0059b4f5e12d8mr2866968ywb.47.1695497168744; Sat, 23
 Sep 2023 12:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230922-msm8226-i2c6-v2-0-3fb55c47a084@z3ntu.xyz> <20230922-msm8226-i2c6-v2-3-3fb55c47a084@z3ntu.xyz>
In-Reply-To: <20230922-msm8226-i2c6-v2-3-3fb55c47a084@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 22:25:57 +0300
Message-ID: <CAA8EJprhhUN6Txbiyvb1Jk8mEnX1bxhf-WWcDU2J2WH0uVF9kQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: qcom: msm8226: Add blsp1_i2c6 and blsp1_uart2
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Fri, 22 Sept 2023 at 19:56, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Add more busses found on msm8226 SoC.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 33 ++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
