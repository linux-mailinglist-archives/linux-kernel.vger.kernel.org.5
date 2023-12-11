Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2F80C44F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjLKJS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjLKJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:18:54 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52522AF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:19:00 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67acdcb3ccdso31767486d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702286339; x=1702891139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9yuTaGFAwkEc1ukkaRJK+sBPyGEOqtEgknLH+caKD4=;
        b=Hchor3SFugPGNYcnM37AXZhShKZ3380cJsKu2zirGlJlz6B4npTf4/3S/SE2vpQRPa
         wH4vV4zq/FVdwCYqsXLxEO7Y8J76h9jhUsC+TvAvx5G5qf4YecVvga5bcQumdESNWu6O
         SYCt4E74OaDyLTojC93/h0WLwRWRgKJzedjJ/Wuc0Ib1pTn6QKfg7DTY0cmcSlFmE/v2
         BG5n/cjwpYOAc+fbIIAwWISySxgn43KPJ1kLaeI2Ntcd01VzF8WVhTFr1RVvvNuM1Whu
         QpeQQZjEu7YpnF9b/7ddQSAWDAZEJavmjXr+nVsOB1ngbe7ZDzfztmJp7t13QpMSdvU1
         OCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286339; x=1702891139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9yuTaGFAwkEc1ukkaRJK+sBPyGEOqtEgknLH+caKD4=;
        b=VTVdy43OCzSlxmNOK5+bu85fxpWs0OJW0KKfdFFMYHa2kS8Ga0S2B2zbfiU0NJQ4q8
         ym1qYaCtotGDQibFkVh4EWUUE5MlG0BYp+jTZBmLyfTQOK24jEI2o+cIHldoHEx70gvZ
         /rK9tgDSiyASGK/j1PzCJwssXR8/1azUkCtppl9fO/FiZZ84x3CZPALL42QbaRBj7HSP
         uRngzOw6Dop9unaEKWLlWrNno9pHsTBQyPd5yYz4bYWkhwhyWaYU5OlzIzB2ws/66fas
         yKbip7Pgg6jbSz+S4PH25r8S9h+Ay+bUhPOccDrOto7e9c1xiCtUOevYvUiuYwaodFlP
         zwLw==
X-Gm-Message-State: AOJu0Yy3tAGqiai73KmfLIvvjNEPRAdaS5UBEmJfOypwrp5TOCGh7wuA
        z5IspDCuoIF2LqURALYVDB44VH5o0RRO3vwzNruzDw==
X-Google-Smtp-Source: AGHT+IEqLsX2ewE1yl3rEl4Rf+VGHAMxg46fPT5XD8IOIyjR0GG/3ZZZI1NZ+w222HvNzSoZ/3nzznNmFCW3qOampxE=
X-Received: by 2002:a05:6214:1408:b0:67a:a721:b195 with SMTP id
 pr8-20020a056214140800b0067aa721b195mr4830414qvb.80.1702286339401; Mon, 11
 Dec 2023 01:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org> <20231209-b4-arm64-sysreg-additions-v1-8-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-8-45284e538474@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 11 Dec 2023 09:18:23 +0000
Message-ID: <CA+EHjTxhXgYs-Z0-2y7c1bdvr+LpT8-nb67DEP+yCJEL5gaPOg@mail.gmail.com>
Subject: Re: [PATCH 08/13] arm64/sysreg: Add definition for ID_AA64FPFR0_EL1
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,


On Sat, Dec 9, 2023 at 1:03=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> DDI0601 2023-09 defines a new feature register ID_AA64FPFR0_EL1 which
> enumerates a number of FP8 related features. Add a definition for it.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/arm64/tools/sysreg | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index d1bb6ebcd959..68236cf1abda 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1131,6 +1131,35 @@ EndEnum
>  Res0   31:0
>  EndSysreg
>
> +Sysreg ID_AA64FPFR0_EL1        3       0       0       4       7
> +Res0   63:32
> +UnsignedEnum   31      F8CVT
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +UnsignedEnum   30      F8FMA
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +UnsignedEnum   29      F8DP4
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +UnsignedEnum   28      F8DP2
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +Res0   27:2
> +UnsignedEnum   1       F8E4M3
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +UnsignedEnum   0       F8E5M2
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +EndSysreg
> +
>  Sysreg ID_AA64DFR0_EL1 3       0       0       5       0
>  Enum   63:60   HPMN0
>         0b0000  UNPREDICTABLE
>
> --
> 2.39.2
>
