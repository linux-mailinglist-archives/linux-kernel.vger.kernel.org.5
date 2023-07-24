Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5883776019A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGXVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGXVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:55:31 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E2172D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:55:30 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-558a79941c6so2787081eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235729; x=1690840529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8guhtErTn6aNVQ1Iyi8hYudi3GFlQwENuhyidPmzNs=;
        b=riH8prdIh4N80P2QMC/I8TGBRunp3tp7X2cT4CaOUuIe87vDpBwZFpcd6B75rCzyJ6
         Y3fmrU0fnf0ovYMpXolI3muN61KF5fA9cunEp+k3uj/QgT9AjNDbstjLR4oxzT0ik5v9
         b1liVJFoOCGPRwkaxdG1BgyLYyMDlNmIL9v+ThvBOFHFOv2ndNlGc8xTu7wrhqiRI9hu
         odtRR/UW4YlMw3wW1V/Y4GpEaJFKDk5nPJ+gq4hXqh8qRBqORwHZ/8oPtivM4G4cRFZ3
         U6vGsM1FjsGQO/lQtxQkL0JesoRy7p3NyQxchL2R7PKAz5wIOgyOjLoLmnn+1dcXImW8
         ywWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235729; x=1690840529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8guhtErTn6aNVQ1Iyi8hYudi3GFlQwENuhyidPmzNs=;
        b=J55Z5TYlNOzayuggyLaGDccw4eyjEm61zj86WSuttY01Jc2fOGfWNigJxCqU0mV55f
         soY8h7tb+Qz0rOaEqWStsH3mfgwHIXYCGWzpbuJ2ddCrVZCS0ggsrZmeVGYCv71+mov9
         JXabfAQndmvrTc2+S4OgvdooolEB1e8GHM0r53SMZ4AsejchvQc/xACiX6sCv2kazHbT
         5OlqgPrnbKtEUC309YON5AL1tEpAhGcVqnlgcGXJDgeiUxbiJUxA+F+qjuDrVbqG8Yry
         269bWwMOapdi2LEt3VcIMiIGOecJ5MLDkcwOR4RoQTFPxlw4P/3xeiQ0J8r6piYL3QP/
         7d/Q==
X-Gm-Message-State: ABy/qLb4hR8bIS5Jj68L2McOYkemhnTwo8W/fF4EpFkY7cmP4QzbpRa9
        1R8BZ9N7s1CIrH/4enRWmXrZ/be5YQ3M7CC+X9o=
X-Google-Smtp-Source: APBJJlGpvGvYHofhn296p0VQ4ekG8ECA+40wh6sjcsrKBSQ8a77kj0PDgEyovPB3KuscQIqDW7M85yrHYLg5IbNv+lY=
X-Received: by 2002:a4a:344a:0:b0:566:efc9:1464 with SMTP id
 n10-20020a4a344a000000b00566efc91464mr9031534oof.0.1690235729572; Mon, 24 Jul
 2023 14:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230724071121.8710-1-xujianghui@cdjrlc.com> <be6d6605aa504964eba3476910f7140a@208suo.com>
 <a026386d6759911afbb1446a9145bdec@208suo.com>
In-Reply-To: <a026386d6759911afbb1446a9145bdec@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:55:18 -0400
Message-ID: <CADnq5_M0pcefVivAG+sVCfkyu2y2Mjb0bXs2O19KFZtBsB5aGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: open brace '{' following function definitions
 go on the next line
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

Applied.  Thanks!

On Mon, Jul 24, 2023 at 4:44=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> ERROR: open brace '{' following function definitions go on the next line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> index c788aa7a99a9..5e408a195860 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> @@ -205,7 +205,8 @@ int smu_v12_0_set_default_dpm_tables(struct
> smu_context *smu)
>         return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
> smu_table->clocks_table, false);
>   }
>
> -int smu_v12_0_mode2_reset(struct smu_context *smu){
> +int smu_v12_0_mode2_reset(struct smu_context *smu)
> +{
>         return smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
>   }
