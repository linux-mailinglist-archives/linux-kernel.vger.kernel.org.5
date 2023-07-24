Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3246576018E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGXVwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGXVwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:52:19 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9EA10EF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:52:18 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9c57c4d12so3833011a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235537; x=1690840337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZCLkvKumUHQk3r9AhtcRAYNusNQAwfIfwo76NwqwxM=;
        b=NJNrPR/+4w6Db4s9Be7NZWjp/7j0bjgT7rQXSNmYmdzNn4jSbrYE2el9AKekxRp0kc
         NI2LDXWXmfaG35F1XQXlzoXMZjh+YdUJmKIBmKKatLYYh/QRahssfyt8pfx9Qk4297Ba
         2hOtMcuyB31sz8AZjCQ3yQU3yYJfF7wOIbe+ZyvHLiey8syH3ruGJBW3sCRekn6s4h97
         B8y6Oop/h3Wzitd5jlSr0QOzP+aMploxiP0/u7lkjIG6aGAlWCoFjPlRkjudds2Iziay
         qgAbK9doQXoJ2C0j5EVnyStr6OKMXLQx591Yy0/1sn54gPWcjHprIkvR0Fy4NpKxZLaa
         RK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235537; x=1690840337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZCLkvKumUHQk3r9AhtcRAYNusNQAwfIfwo76NwqwxM=;
        b=Z1q9NtvwUKy4yVMkArqAQv+5n06wCOA7KD42o5UOZuNf5Q2U66glSuyuK/FVaDlNVB
         XymFFwwnw5RNIRU8YF5Mdz1iTHTurHUx8poflOb8o8EGDfi8v6B+d/eluqp5tc4mKZ6T
         JrToMyW8rQwAjnNBje60nK5lcEMX1nwCsz5eLR4WuaRG8h44Al1tWqSWpAlu1dx98gSl
         xldYVoAbQtLVf3Oz/tntLEC/2fx/t12eZkpF+/TEL32lgG5c8/l+9sUMwMgZCZzzU/Hu
         7G0EIrJ+lkX63TaO0B/va/rPiOg7Ol2PGIJqr4GY23rp0LJ+sHU4UmwXq7CQwlnSAL8h
         4ILg==
X-Gm-Message-State: ABy/qLYUi3ngDd7sLvGgvWmw4TtdwyIgr7mP69urcHyIfHOVYJMOVyZt
        BqKBKuRpEqtKJ6TbfuNBjjgwtakgdOLgD2hN7iubE9lB
X-Google-Smtp-Source: APBJJlExIYKSDixzSsODi4CidihdVt45LGPc8je8XTJjgDd8A4P+3kDHdnCQNc8Nk8vMMkzw76CIuftJuOAcEsiXtiE=
X-Received: by 2002:a9d:66d3:0:b0:6b9:bf1e:c141 with SMTP id
 t19-20020a9d66d3000000b006b9bf1ec141mr9203742otm.23.1690235537654; Mon, 24
 Jul 2023 14:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230724083344.9285-1-xujianghui@cdjrlc.com> <8e6eda082855e1b928253669fbb49316@208suo.com>
In-Reply-To: <8e6eda082855e1b928253669fbb49316@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:52:06 -0400
Message-ID: <CADnq5_PsrhawfqtB3HKjT7cH4=tJ8AnAEMrTAQwn8Y7wWBOzoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu11_driver_if_sienna_cichlid.h
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't apply cleanly.

Alex

On Mon, Jul 24, 2023 at 4:34=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: trailing whitespace
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
> index c5e26d619bf0..8ec588248aac 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
> @@ -30,7 +30,7 @@
>
>   #define ENABLE_DEBUG_FEATURES
>
> -// Firmware features
> +// Firmware features
>   // Feature Control Defines
>   #define FEATURE_CCLK_DPM_BIT                 0
>   #define FEATURE_FAN_CONTROLLER_BIT           1
> @@ -92,7 +92,7 @@
>   #define FEATURE_ZSTATES_ECO_BIT             57
>   #define FEATURE_CC6_BIT                     58
>   #define FEATURE_DS_UMCCLK_BIT               59
> -#define FEATURE_DS_HSPCLK_BIT               60
> +#define FEATURE_DS_HSPCLK_BIT               60
>   #define NUM_FEATURES                        61
>
>   typedef struct {
