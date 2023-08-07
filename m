Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A88772B76
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjHGQt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjHGQt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:49:57 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82589D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:49:56 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56d263da4f2so3403607eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426996; x=1692031796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgQa+1FKvDWzR4zoWEz8VexbuxihC5GZckb0Q0xRORc=;
        b=FQTZy50gW5hiLnD/qVVaqF2n4OXGk9PzU4wck0u5FbLinIBT//IhILVvwwU3x9Rtm8
         +lZXsAW2YkdkgV9Eexq3fUXpgofjnAkhuSbOVy80lx+5f8pszAh1xrUONZD6fRNpAhkw
         tg2bGo0vdY0sr4sqUMdlcduc+IBdahhv+QzitcQbsf6Bynaw6PhS3KmIJW11tT7SJDZh
         itWgPTtTILvwpUbcpW5S2f1V9S6MXwMftJYXay9qge47tFbJh35OPuk1uQadtSnKw15M
         KH8KSK7YoQopcH3HxcWRgt5SqTw1l7IPsmEH3yyKI1yZIL7LgFqzUZvcWF0sxxuqRV8Q
         Wy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426996; x=1692031796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgQa+1FKvDWzR4zoWEz8VexbuxihC5GZckb0Q0xRORc=;
        b=Z1JYAjsdivdMZvHNgx0PR9YL9hHTsh49g2Q2oVPHOrnveo5xzIFZEVkKbdDESK0DEO
         peK9+AHi3yHKCzWL5mcSjHSLgZXtW5S7fivTTsYQRItMg6MC7ofKcqD8+XxBCwQSXroW
         ST1AsFpl0MlwVIwbEsj9GU4R85J6Q6WcWf4fNHMBX32jy1QRcVzIGlJl+rlboZhQr0jx
         Jtc773t6sLfxHaenPsDmO1WKoHAaVlHNZ/beIHmjBeSt0Z7WDH5nSy+QAunnbkt6k25B
         3ZKJRZ8dANhShGVh8G3tCbS/UZbSqEAMkX2HRk5Vmr//gxkzkSunulEYOueWY4+ua8nx
         LOuA==
X-Gm-Message-State: AOJu0Yw6ymQUEnEVFUY3aAlUIGBtgvYUeKSxyCZaPP9pIHgtNLKkuLYM
        GAZp2pCptOFLoYF/g6bZxRfYiyn1tg+YqIg2bN0=
X-Google-Smtp-Source: AGHT+IF/s1MEl434BzAsfKCcOnEZp4qpAJMatQaOEWnbl10rllg9YsKo7f4muZb+TbaWgnJGpjbma+BjChf8iv/FsII=
X-Received: by 2002:a54:4e0d:0:b0:3a7:9837:7148 with SMTP id
 a13-20020a544e0d000000b003a798377148mr3848673oiy.58.1691426995953; Mon, 07
 Aug 2023 09:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230801094443.7942-1-sunran001@208suo.com>
In-Reply-To: <20230801094443.7942-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:49:45 -0400
Message-ID: <CADnq5_MbmP9sEkWHndxaG+pp6bJkeO7h1qvya3wZWmktDpFYpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega20_pptable.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 1, 2023 at 5:44=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: space prohibited before open square bracket '['
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../amd/pm/powerplay/hwmgr/vega20_pptable.h   | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h
> index 2222e29405c6..b468dddbefff 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h
> @@ -73,14 +73,13 @@ enum ATOM_VEGA20_ODSETTING_ID {
>  };
>  typedef enum ATOM_VEGA20_ODSETTING_ID ATOM_VEGA20_ODSETTING_ID;
>
> -typedef struct _ATOM_VEGA20_OVERDRIVE8_RECORD
> -{
> +typedef struct _ATOM_VEGA20_OVERDRIVE8_RECORD {
>    UCHAR ucODTableRevision;
>    ULONG ODFeatureCount;
> -  UCHAR ODFeatureCapabilities [ATOM_VEGA20_ODFEATURE_MAX_COUNT];   //OD =
feature support flags
> +  UCHAR ODFeatureCapabilities[ATOM_VEGA20_ODFEATURE_MAX_COUNT];   //OD f=
eature support flags
>    ULONG ODSettingCount;
> -  ULONG ODSettingsMax [ATOM_VEGA20_ODSETTING_MAX_COUNT];           //Upp=
er Limit for each OD Setting
> -  ULONG ODSettingsMin [ATOM_VEGA20_ODSETTING_MAX_COUNT];           //Low=
er Limit for each OD Setting
> +  ULONG ODSettingsMax[ATOM_VEGA20_ODSETTING_MAX_COUNT];           //Uppe=
r Limit for each OD Setting
> +  ULONG ODSettingsMin[ATOM_VEGA20_ODSETTING_MAX_COUNT];           //Lowe=
r Limit for each OD Setting
>  } ATOM_VEGA20_OVERDRIVE8_RECORD;
>
>  enum ATOM_VEGA20_PPCLOCK_ID {
> @@ -99,16 +98,14 @@ enum ATOM_VEGA20_PPCLOCK_ID {
>  };
>  typedef enum ATOM_VEGA20_PPCLOCK_ID ATOM_VEGA20_PPCLOCK_ID;
>
> -typedef struct _ATOM_VEGA20_POWER_SAVING_CLOCK_RECORD
> -{
> +typedef struct _ATOM_VEGA20_POWER_SAVING_CLOCK_RECORD {
>    UCHAR ucTableRevision;
>    ULONG PowerSavingClockCount;                                 // Count =
of PowerSavingClock Mode
> -  ULONG PowerSavingClockMax  [ATOM_VEGA20_PPCLOCK_MAX_COUNT];      // Po=
werSavingClock Mode Clock Maximum array In MHz
> -  ULONG PowerSavingClockMin  [ATOM_VEGA20_PPCLOCK_MAX_COUNT];      // Po=
werSavingClock Mode Clock Minimum array In MHz
> +  ULONG PowerSavingClockMax[ATOM_VEGA20_PPCLOCK_MAX_COUNT];      // Powe=
rSavingClock Mode Clock Maximum array In MHz
> +  ULONG PowerSavingClockMin[ATOM_VEGA20_PPCLOCK_MAX_COUNT];      // Powe=
rSavingClock Mode Clock Minimum array In MHz
>  } ATOM_VEGA20_POWER_SAVING_CLOCK_RECORD;
>
> -typedef struct _ATOM_VEGA20_POWERPLAYTABLE
> -{
> +typedef struct _ATOM_VEGA20_POWERPLAYTABLE {
>        struct atom_common_table_header sHeader;
>        UCHAR  ucTableRevision;
>        USHORT usTableSize;
> --
> 2.17.1
>
