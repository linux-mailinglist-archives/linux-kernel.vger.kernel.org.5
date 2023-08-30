Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6429378E0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbjH3U3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbjH3U3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:29:12 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262D6513A7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:44:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d7bb34576b9so890507276.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693424561; x=1694029361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1KOegy06ogcAjmdzAViYXl4NQcN+91FD3LEAsWAkUdY=;
        b=WawVIysO6ipFvpgGIYNqxI8IwbnfR6SZfDvp/G0P78khfA6W7QrB7MSmtUKw1dvAHS
         /T46kPLyt9nINOUz+0JWRlCJb5t37S3aryVBUirzIgCfT8UT9qKI4Kj/vZXj1Mp/i7wg
         yGeplctbu4sAkWSm5A0WJKaVMnS5atElnTgH6LmgYYAxOYVIWuuGLysO5oT6R8+Ow32s
         Jl4b+wUinSTZU1l0HpuimOovsCYz+4GNC6Z2LDGXvDp0rygdhaxsCITsxs7OR5GsBWYz
         Ld7HbHE/DVo1w7oROTG2LYM9bn0XShsSWeU4B8rJV07Swh85MDXKW+qi8HpOM/fQdvFZ
         WhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424561; x=1694029361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KOegy06ogcAjmdzAViYXl4NQcN+91FD3LEAsWAkUdY=;
        b=ftSDzFeC87NgqpwvX1c/JY+PvcSRADcNxHAjqokl+3NHa4/ywNZacBNiYaLj9WsZ/2
         ugkZ22vrkAUEh5RhJRlef9KEC/x2gPDFqGKTyxMPYt2giJv29qG8dyWOW6C1AzXcM/rQ
         ArZ4lXGUxsc9bccbAiseJFzaGkGT0A97g43XzFB9kmhp5clh52c4cZVenikI5ciQH1jY
         /U7vYJKqRAyAstlpoCDe5PTnLLY37wuiFodXsfn2RIy2AmkomhD1pKSWQFkMij+0rUCM
         WP0QilvHpBZ/s9HNA02lwwLtucsyyQzpkevL4oT1DqFReaSBZK6erkwdMGX223pai3x1
         kRgw==
X-Gm-Message-State: AOJu0YwArJEnQ67QUgn2ybdZHEvkxjFVBTSvmpNq768r1gdhKWr8d58S
        BDHC/wQESkZIlA/Zk1P9rNzYZSds2LOpGOW8XDf2uA==
X-Google-Smtp-Source: AGHT+IG7TvoHuWNPaDhyhT+X0ymvRmY9e9DoTJccBmV6ELNz8an6E/b58h/EKFxkyXSfq0zQ3gZSQX9I0Ytk/qlKz3w=
X-Received: by 2002:a5b:41:0:b0:d7a:8e37:6d4d with SMTP id e1-20020a5b0041000000b00d7a8e376d4dmr3133168ybp.43.1693424561021;
 Wed, 30 Aug 2023 12:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
 <20230829095423.760641-4-quic_gokulsri@quicinc.com> <f457ee94-81d0-bd28-1432-ba2828dabb79@linaro.org>
 <efe09cb6-7b67-9307-28e7-99e238a3672b@gmail.com> <0941e2f4-6b58-a4e7-3dda-c1723f5503ac@linaro.org>
 <CAOX2RU4j57H51ceYdKk9K-2ZNO7N4MDA6BOKrP2N3DNbphQAow@mail.gmail.com> <f7a350a9-5580-c3b9-a917-69a9b16dbf41@quicinc.com>
In-Reply-To: <f7a350a9-5580-c3b9-a917-69a9b16dbf41@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 22:42:29 +0300
Message-ID: <CAA8EJpoE=oF86piKCnt-7-Nw8xa9nYg-TqSOaP1V-vb=Oxwwng@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
To:     Gokul Sriram P <quic_gokulsri@quicinc.com>
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 21:32, Gokul Sriram P <quic_gokulsri@quicinc.com> wrote:
>
>
> >>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>>>>    #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
> >>>>>    #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> >>>>> +#include <dt-bindings/clock/qcom,apss-ipq.h>
> >>>> c is before r.
>   Sure, will update.
>
> [...]
> >>>>
> >>>>> +   cpu_opp_table: opp-table-cpu {
> >>>>> +           compatible = "operating-points-v2";
> >>>>> +           opp-shared;
> >>>>> +
> >>>>> +           opp-1008000000 {
> >>>>> +                   opp-hz = /bits/ 64 <1008000000>;
> >>>>> +                   opp-microvolt = <1100000>;
> >>>>> +                   clock-latency-ns = <200000>;
> >>>> And the rest of OPPs?
> >>> Hi Krzysztof,
> >>> IPQ5018 only supports running at 1.1GHz, but its running at 800MHz
> >>> by default from the bootloader so there is only one OPP.
> >> Isn't this contradictory? If it is running at 800 initially, then it
> >> supports running at 800...
> > I can only guess that it's not validated at 800MHz.
> As per the h/w design team, there is negligible power or thermal benefit
> by lowering to 800MHz clock.
> Hence, 800MHz opp wasn't included here.

Just my 2c. If 800 MHz is supported, it should be included. Even if
just to prevent the kernel from throwing a warning about the CPU
running at the unsupported frequency. Then one can use scheduler
tunings to prevent the CPU from going to 800 MHz state.


-- 
With best wishes
Dmitry
