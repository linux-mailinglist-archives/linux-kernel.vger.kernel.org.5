Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C57772B35
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjHGQjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjHGQjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:39:32 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7541C270E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:38:51 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bf54f415afso2642078fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426323; x=1692031123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rarcK3MbD7gHOcFshzJfH5zeoDzMas3hks50J5ozAg0=;
        b=OCjP+09Q1alWEsFY+IxdlRu38FWBMjCp3y8nFvqDAdqOpZLZdGQEWBO+RO1RyvVS9E
         ofMvJAvuQUvo7DBHiV1E/sxJRFBP+BeZcD1qfsXN2sKrl4a/yOGwfcK6CUzVg/3P2jIP
         vv5EMq7AimUln0OAoeyQFzE4DKoTlRzCXV1h7ivJU4UUNu7e/GMDVROnYLl3IjqHpTbl
         huLEmqcbM7U9PT5j5WBRn//yBbeSr9i2PFxpGxi2kWlbXJarlt4EbGGo2qrw1xnX6Cgz
         frFbK17PLe/RsCaTMg5PuhmpxWWQ1ssiicxfwZniSSJI3B/6N/b9O7YGLkSOx12o8jeP
         1x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426323; x=1692031123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rarcK3MbD7gHOcFshzJfH5zeoDzMas3hks50J5ozAg0=;
        b=UciY3XIWgdzn31CMlwPcIhibtpbfKrgC6YBKLAnHHIMgAvud3y3Bsq0zeJaFIob1yt
         O62cbpxZ7NL/JBWl83L4M+O9VzK22ZWSaB+hlghniDzoUx5Ei16Z3tNE63Ntn4DG6xxx
         EpJ2IEFLJLNRdbeL6QP9Q/5mNwxKu/JIu0Xu0xhenl5expWLPDsBdAbkwULPRSFGJ+Zm
         xYv50KroVK+dniKDvMfP2VSMmYjY9W61IxOsVpaVb+snbKlPe5PPHFJl6lZJ9uFqox2s
         IfdPd1zFbvZk3+BY4AyH3EdTA9BBaFihBYImL/DddU/aFgcbyziSv8HVDDV2HunsqQRD
         yXvQ==
X-Gm-Message-State: AOJu0YxRviEMrVHS2pHW7wcZqZYxz/lO8pL1UXK1HtehFtRAJCXK0jvE
        +nZjqoV3etcIuWYVztNrvle2BnDc2zU3gh92Ief4B3n6
X-Google-Smtp-Source: AGHT+IFqN+3LznOGCB7Ec+vmLC5iyrrexubmYVqGFrrYDW9B7OvQdOGZ5AjY9CQYSSBF5Hfs0wiQPOyXky18W4I+sdk=
X-Received: by 2002:a05:6870:3282:b0:1bf:df47:7b5d with SMTP id
 q2-20020a056870328200b001bfdf477b5dmr4252575oac.24.1691426322778; Mon, 07 Aug
 2023 09:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230801084024.6826-1-sunran001@208suo.com>
In-Reply-To: <20230801084024.6826-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:38:31 -0400
Message-ID: <CADnq5_Pn4U0uV4qLkBauxnWdRQZHtiq135qn+-uDRR34ZHbaPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega10_pptable.h
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

On Tue, Aug 1, 2023 at 4:40=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../amd/pm/powerplay/hwmgr/vega10_pptable.h    | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> index 9c479bd9a786..8b0590b834cc 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> @@ -317,16 +317,14 @@ typedef struct _ATOM_Vega10_Thermal_Controller {
>      UCHAR ucFlags;          /* to be defined */
>  } ATOM_Vega10_Thermal_Controller;
>
> -typedef struct _ATOM_Vega10_VCE_State_Record
> -{
> +typedef struct _ATOM_Vega10_VCE_State_Record {
>      UCHAR  ucVCEClockIndex;         /*index into usVCEDependencyTableOff=
set of 'ATOM_Vega10_MM_Dependency_Table' type */
>      UCHAR  ucFlag;                  /* 2 bits indicates memory p-states =
*/
>      UCHAR  ucSCLKIndex;             /* index into ATOM_Vega10_SCLK_Depen=
dency_Table */
>      UCHAR  ucMCLKIndex;             /* index into ATOM_Vega10_MCLK_Depen=
dency_Table */
>  } ATOM_Vega10_VCE_State_Record;
>
> -typedef struct _ATOM_Vega10_VCE_State_Table
> -{
> +typedef struct _ATOM_Vega10_VCE_State_Table {
>      UCHAR ucRevId;
>      UCHAR ucNumEntries;
>      ATOM_Vega10_VCE_State_Record entries[1];
> @@ -361,8 +359,7 @@ typedef struct _ATOM_Vega10_PowerTune_Table {
>         USHORT usTemperatureLimitTedge;
>  } ATOM_Vega10_PowerTune_Table;
>
> -typedef struct _ATOM_Vega10_PowerTune_Table_V2
> -{
> +typedef struct _ATOM_Vega10_PowerTune_Table_V2 {
>         UCHAR  ucRevId;
>         USHORT usSocketPowerLimit;
>         USHORT usBatteryPowerLimit;
> @@ -388,8 +385,7 @@ typedef struct _ATOM_Vega10_PowerTune_Table_V2
>         USHORT usTemperatureLimitTedge;
>  } ATOM_Vega10_PowerTune_Table_V2;
>
> -typedef struct _ATOM_Vega10_PowerTune_Table_V3
> -{
> +typedef struct _ATOM_Vega10_PowerTune_Table_V3 {
>         UCHAR  ucRevId;
>         USHORT usSocketPowerLimit;
>         USHORT usBatteryPowerLimit;
> @@ -428,15 +424,13 @@ typedef struct _ATOM_Vega10_Hard_Limit_Record {
>      USHORT usVddMemLimit;
>  } ATOM_Vega10_Hard_Limit_Record;
>
> -typedef struct _ATOM_Vega10_Hard_Limit_Table
> -{
> +typedef struct _ATOM_Vega10_Hard_Limit_Table {
>      UCHAR ucRevId;
>      UCHAR ucNumEntries;
>      ATOM_Vega10_Hard_Limit_Record entries[1];
>  } ATOM_Vega10_Hard_Limit_Table;
>
> -typedef struct _Vega10_PPTable_Generic_SubTable_Header
> -{
> +typedef struct _Vega10_PPTable_Generic_SubTable_Header {
>      UCHAR  ucRevId;
>  } Vega10_PPTable_Generic_SubTable_Header;
>
> --
> 2.17.1
>
