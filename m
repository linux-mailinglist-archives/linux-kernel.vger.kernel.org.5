Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E404D80C444
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjLKJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjLKJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:17:34 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7069EF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:17:40 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db99bad7745so3798735276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702286259; x=1702891059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tON2THycPn5WWu4go17kYKIdjO0Li+YdKKlN3UXl7fo=;
        b=e00PNCpN8ZLjOL7xSctTJ/LYxlUQtCXrYTS/HL4+rSs/7TUTxIBKl86FqWh+mo8OwY
         5Ag+4v/LCUpmaTpiyNhtiXbWB84j5o0VuOXdEYktImiwc7cCL3NfUx7Vg0lqrx3psb50
         TBng6bR4Nx7f8JA4wHxyqMd79dWGoXbum1K+z6nsgBaxNksI6yXe2nWZXnBZA/YcN62y
         nou5jioMpADLCzw2piBGiyHhT2im2vOPHT6R9guU84bx/JDET4X4Uw7n4WGkbR84hQ1T
         FLJKNrP1iX0l2mog6FglukxVIcaL9plddu3H+gzqeDgizKFdq+0I3H5Tr+Po0YVBf7Fw
         KENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286259; x=1702891059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tON2THycPn5WWu4go17kYKIdjO0Li+YdKKlN3UXl7fo=;
        b=LJduIqG8H4VwkfuruhGLOVfZGI7z9CKrZbtfwtQ97AbPfcoFFxGf4eXmMySUcXkxSU
         SHbhw2QTKsQlFEojOF6PCB8WU1Verb+nNXNa30oixLNrecExg3c6D6sCekvpLaMBRrEd
         Oh3+wSPXQWezIGpdqx/ko0GhYC52lo5reeixYH+EA+PiXGeI2AycbpBdLZhMXTBe9rNC
         IRRzkAUTPWak9icOYrlcTwk/G7w/DXMerxa/fxMXR4VCjTQr4zLeJi2WO7k22QGQY7Kx
         rlktCGEPsaC1OUaboygPL7cW5Ka+zoW9bqa8Dd5PCn9pcCw4Dn6N7fbhlhY/RK7D+lw9
         IOaQ==
X-Gm-Message-State: AOJu0YxvhFR1W6n4It7HUHOChyqxWdisC1KACI4/jdVAoqb7h6dCiaj2
        aFYDzSzNMVJGl7bredygyjvr4YkCZ0L1wUBcniG/ag==
X-Google-Smtp-Source: AGHT+IGFfzc18Y0DvF6kIgNlWfALl1M8QjjxShgvXEdPkndGc0o1rTK2NDXz2q1MVL3JVH+322w8AxuAAcd+0Gs5STg=
X-Received: by 2002:a5b:dc3:0:b0:db7:dacf:2f32 with SMTP id
 t3-20020a5b0dc3000000b00db7dacf2f32mr2625241ybr.121.1702286259533; Mon, 11
 Dec 2023 01:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org> <20231209-b4-arm64-sysreg-additions-v1-9-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-9-45284e538474@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 11 Dec 2023 09:17:02 +0000
Message-ID: <CA+EHjTwQUd66umh-w=fTtHsf-iUAUKk4HbtO-27RdZ6HRP=UEQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] arm64/sysreg: Update ID_AA64SMFR0_EL1 definition
 for DDI0601 2023-09
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
> The 2023-09 release of DDI0601 defines a number of new feature enumeratio=
n
> fields in ID_AA64SMFR0_EL1. Add these fields.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/tools/sysreg | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 68236cf1abda..839f7cca53e0 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1079,7 +1079,11 @@ UnsignedEnum     63      FA64
>         0b0     NI
>         0b1     IMP
>  EndEnum
> -Res0   62:60
> +Res0   62:61
> +UnsignedEnum   60      LUTv2
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
>  UnsignedEnum   59:56   SMEver
>         0b0000  SME
>         0b0001  SME2
> @@ -1107,7 +1111,14 @@ UnsignedEnum     42      F16F16
>         0b0     NI
>         0b1     IMP
>  EndEnum
> -Res0   41:40
> +UnsignedEnum   41      F8F16
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +UnsignedEnum   40      F8F32
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
>  UnsignedEnum   39:36   I8I32
>         0b0000  NI
>         0b1111  IMP
> @@ -1128,7 +1139,20 @@ UnsignedEnum     32      F32F32
>         0b0     NI
>         0b1     IMP
>  EndEnum
> -Res0   31:0
> +Res0   31
> +UnsignedEnum   30      SF8FMA
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +UnsignedEnum   29      SF8DP4
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +UnsignedEnum   28      SF8DP2
> +       0b0     NI
> +       0b1     IMP
> +EndEnum
> +Res0   27:0
>  EndSysreg
>
>  Sysreg ID_AA64FPFR0_EL1        3       0       0       4       7
>
> --
> 2.39.2
>
