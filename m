Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810FF772BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjHGRBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHGRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:01:06 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C410DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:01:05 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bfca0ec8b9so1164065fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427665; x=1692032465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKi/ylxygovjlPf6mua/FLxbGKNsQH3//RWonl36ciA=;
        b=dop4vKi12DYvQUGfzdjXRJMSibHsdYHfzugjMw30Qhcq8rhJ0uUxtgyLU89kfE6xBE
         cPNoBQzVg9AOxB6P8ThKPRKrc0T65ZSwdvl3hkF+hA+s/CfICmq0MnvC1p40OGckN1so
         idOP7uZg79K8T2vAD5zHeN+LbyyEZDyTTyX7Pk0XUHY30AJ1+k0j8OJiFaGJi67HZpYD
         SLx/jkZ+P/+o2lVT/P4M/iMWPzwP7G5LppwJPdwRennzPotgWzxCtuVr/0lCkf99Enmb
         3PCDUPQelwgvvP8m9nSK8r2C2J3SAkHJUDRQIuwxxp9INKYH70d3x9HBqXNkmspJc3vy
         KKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427665; x=1692032465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKi/ylxygovjlPf6mua/FLxbGKNsQH3//RWonl36ciA=;
        b=P1yhhepiNs/x40Ci6OUoCgaF+Rnj4B0gUnrH/RFKNUv5gxEgAFW7PYnvqdYqa83CKn
         WV6orcdHcrIR0ZQB0qnD3Nsy13BkUUsxBLMGuSQjCph95O8ZDlVx4h6fKHOt6QDx4ACo
         rIt52ggw2pr3lPdiX05fNLo9C37a6UHGCxNLGrtibN4ECbqdx5YEn1YgfsQPCVSFk7TL
         wyPXUhaJcaNJltSnLQ6v7fD33PrTaAfYndyEW2te5UwmGZ7EUDPH+XrV7pjRo0CLKN6R
         t+CMdZt2EY8DC2n1wcilKG3AJojs1x4/htDgM+TT4XGPX2eKStUaF59WsHcZiEaM5DRU
         T6Dw==
X-Gm-Message-State: AOJu0YyfJeX65Uk4zqEyIGUtL2zO3s1dmV5s1StFVxF+RjVeLlQxqzme
        qMilqPmHHJN/16GyJ/qWjeocEJFw9aIl9L4OIiQ=
X-Google-Smtp-Source: AGHT+IHXcRHl6PiCY49Vwty52gk4G0CN2uuAjoSjckBdYdUSo4qenBQADiiDq3PreabnVG+dT82n9lPqjRi88StUeTI=
X-Received: by 2002:a05:6870:524d:b0:1bb:a264:a7ba with SMTP id
 o13-20020a056870524d00b001bba264a7bamr11346535oai.56.1691427665071; Mon, 07
 Aug 2023 10:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230802015941.9124-1-sunran001@208suo.com>
In-Reply-To: <20230802015941.9124-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:00:54 -0400
Message-ID: <CADnq5_Mh7-uGDEG-WAkrUT=XjFQ_77wMMq_oaUFbZqmdQxGAcA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu75.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 9:59=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space prohibited before open square bracket '['
> ERROR: "foo * bar" should be "foo *bar"
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h b/drivers/gpu/d=
rm/amd/pm/powerplay/inc/smu75.h
> index 771523001533..7d5ed7751976 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
> @@ -224,8 +224,8 @@ struct SMU7_LocalDpmScoreboard {
>         uint8_t  DteClampMode;
>         uint8_t  FpsClampMode;
>
> -       uint16_t LevelResidencyCounters [SMU75_MAX_LEVELS_GRAPHICS];
> -       uint16_t LevelSwitchCounters [SMU75_MAX_LEVELS_GRAPHICS];
> +       uint16_t LevelResidencyCounters[SMU75_MAX_LEVELS_GRAPHICS];
> +       uint16_t LevelSwitchCounters[SMU75_MAX_LEVELS_GRAPHICS];
>
>         void     (*TargetStateCalculator)(uint8_t);
>         void     (*SavedTargetStateCalculator)(uint8_t);
> @@ -316,7 +316,7 @@ struct SMU7_VoltageScoreboard {
>
>         VoltageChangeHandler_t functionLinks[6];
>
> -       uint16_t * VddcFollower1;
> +       uint16_t *VddcFollower1;
>         int16_t  Driver_OD_RequestedVidOffset1;
>         int16_t  Driver_OD_RequestedVidOffset2;
>  };
> @@ -677,9 +677,9 @@ typedef struct SCS_CELL_t SCS_CELL_t;
>
>  struct VFT_TABLE_t {
>         VFT_CELL_t    Cell[TEMP_RANGE_MAXSTEPS][NUM_VFT_COLUMNS];
> -       uint16_t      AvfsGbv [NUM_VFT_COLUMNS];
> -       uint16_t      BtcGbv  [NUM_VFT_COLUMNS];
> -       int16_t       Temperature [TEMP_RANGE_MAXSTEPS];
> +       uint16_t      AvfsGbv[NUM_VFT_COLUMNS];
> +       uint16_t      BtcGbv[NUM_VFT_COLUMNS];
> +       int16_t       Temperature[TEMP_RANGE_MAXSTEPS];
>
>  #ifdef SMU__FIRMWARE_SCKS_PRESENT__1
>         SCS_CELL_t    ScksCell[TEMP_RANGE_MAXSTEPS][NUM_VFT_COLUMNS];
> --
> 2.17.1
>
