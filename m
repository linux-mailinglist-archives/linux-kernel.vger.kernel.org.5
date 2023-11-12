Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316D47E91E2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjKLSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKLSAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:00:52 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468671BE7;
        Sun, 12 Nov 2023 10:00:49 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so2191461fac.0;
        Sun, 12 Nov 2023 10:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699812048; x=1700416848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfKjTNPjLOgd1jDpWmUB18irX4zVfrahQ01NcwWX1j8=;
        b=aET9zyyUd5aLPSCnScWfUmePCK08538scYb1OpqpViWbSlhkjpK6wOYbWwj09rrQon
         tMk9dDIrTZGRFoiDhv8nYgCAc8a06E3hzmco5j+OJIUDIv85z9VSyCjMcwuN2VgKO7yw
         rfRM46TrGw00rQz7EKSVguy+hZc+ow7TVqMAJYChFVySynmk2Oir2upxCUsc5VCp+sCp
         yGvRaeV2uC26Slqu6v712CFAx9fOso5OvhP3K35ZZa2KsRCf4GkseoSFcG7x88aM/CgU
         2bh8K5jTXulp5/GYC2cTl+a14wvX9QC3VV2RAalVdeyoX4Ftjhq4M4ng3pnUFCFgc3z3
         tPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699812048; x=1700416848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfKjTNPjLOgd1jDpWmUB18irX4zVfrahQ01NcwWX1j8=;
        b=jHBcbGziwb+TPdIuP/2PeRVJx08Rqh1fXINgLArHGLewDestXHlnZax8cp9uyqKKLR
         xYgmfFljJMjeoDa1n4M4hm+j4KHbbcjns1zO7hljzHUe9nRC3E3LY7mVDyIJu04OuLtn
         +gs13E/NasXtXuDXQB+OmMXT48Hf/6hTey2v7iMoBySfVPW9CkDTW/L3YpfEg1yWb6p2
         M2ZICbamALJAK1MIPXPRwpVGnDqY02cfV3FBqNLqLYQFDiKsPrO1LXRC13Z1Wm4zghVo
         gTJWeKr4wxXNvbnlsCntgs1PBxH877+LN/Zf8Qu6530PEDG9Jb/EBarRLJwcsHPwBiq0
         dv0Q==
X-Gm-Message-State: AOJu0Yz+MOJE70afq20Jl90DE2gpgxaPFZcO+AL3Y0D03RbUBiyLW3de
        51QJn1Ld9unA07XDO2iEAGk9IfzesGlclEo6R1U=
X-Google-Smtp-Source: AGHT+IH9fCeY0p+889Hq5E/FeznaMxKk7hWotHF2e82tGctkmrbNfl7InHIcS1n/Xm3M6i7unsWVB+A73D9Q09eat1c=
X-Received: by 2002:a05:6870:cd0e:b0:1e9:dae7:f58a with SMTP id
 qk14-20020a056870cd0e00b001e9dae7f58amr6491610oab.22.1699812048373; Sun, 12
 Nov 2023 10:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20231112132736.175494-1-sashal@kernel.org> <20231112132736.175494-9-sashal@kernel.org>
In-Reply-To: <20231112132736.175494-9-sashal@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Sun, 12 Nov 2023 13:00:37 -0500
Message-ID: <CADnq5_OyK=rDH38Q8Kiyq9BhWuihgd8wX7XKAffxwkO4w+ksog@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 09/11] drm/amd: Fix UBSAN array-index-out-of-bounds
 for Powerplay headers
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 8:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> [ Upstream commit 49afe91370b86566857a3c2c39612cf098110885 ]
>
> For pptable structs that use flexible array sizes, use flexible arrays.
>
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2039926
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't think any of these UBSAN flexible array changes are stable material=
.

Alex

> ---
>  .../drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h |  4 ++--
>  .../amd/pm/powerplay/hwmgr/vega10_pptable.h   | 24 +++++++++----------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> index 7a31cfa5e7fb4..df7cab1a571b3 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> @@ -367,7 +367,7 @@ typedef struct _ATOM_Tonga_VCE_State_Record {
>  typedef struct _ATOM_Tonga_VCE_State_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;
> -       ATOM_Tonga_VCE_State_Record entries[1];
> +       ATOM_Tonga_VCE_State_Record entries[];
>  } ATOM_Tonga_VCE_State_Table;
>
>  typedef struct _ATOM_Tonga_PowerTune_Table {
> @@ -481,7 +481,7 @@ typedef struct _ATOM_Tonga_Hard_Limit_Record {
>  typedef struct _ATOM_Tonga_Hard_Limit_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;
> -       ATOM_Tonga_Hard_Limit_Record entries[1];
> +       ATOM_Tonga_Hard_Limit_Record entries[];
>  } ATOM_Tonga_Hard_Limit_Table;
>
>  typedef struct _ATOM_Tonga_GPIO_Table {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> index 8b0590b834cca..de2926df5ed74 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> @@ -129,7 +129,7 @@ typedef struct _ATOM_Vega10_State {
>  typedef struct _ATOM_Vega10_State_Array {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                         /* Nu=
mber of entries. */
> -       ATOM_Vega10_State states[1];                             /* Dynam=
ically allocate entries. */
> +       ATOM_Vega10_State states[];                             /* Dynami=
cally allocate entries. */
>  } ATOM_Vega10_State_Array;
>
>  typedef struct _ATOM_Vega10_CLK_Dependency_Record {
> @@ -169,37 +169,37 @@ typedef struct _ATOM_Vega10_GFXCLK_Dependency_Table=
 {
>  typedef struct _ATOM_Vega10_MCLK_Dependency_Table {
>      UCHAR ucRevId;
>      UCHAR ucNumEntries;                                         /* Numbe=
r of entries. */
> -    ATOM_Vega10_MCLK_Dependency_Record entries[1];            /* Dynamic=
ally allocate entries. */
> +    ATOM_Vega10_MCLK_Dependency_Record entries[];            /* Dynamica=
lly allocate entries. */
>  } ATOM_Vega10_MCLK_Dependency_Table;
>
>  typedef struct _ATOM_Vega10_SOCCLK_Dependency_Table {
>      UCHAR ucRevId;
>      UCHAR ucNumEntries;                                         /* Numbe=
r of entries. */
> -    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamica=
lly allocate entries. */
> +    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamical=
ly allocate entries. */
>  } ATOM_Vega10_SOCCLK_Dependency_Table;
>
>  typedef struct _ATOM_Vega10_DCEFCLK_Dependency_Table {
>      UCHAR ucRevId;
>      UCHAR ucNumEntries;                                         /* Numbe=
r of entries. */
> -    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamica=
lly allocate entries. */
> +    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamical=
ly allocate entries. */
>  } ATOM_Vega10_DCEFCLK_Dependency_Table;
>
>  typedef struct _ATOM_Vega10_PIXCLK_Dependency_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                         /* Nu=
mber of entries. */
> -       ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynam=
ically allocate entries. */
> +       ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynami=
cally allocate entries. */
>  } ATOM_Vega10_PIXCLK_Dependency_Table;
>
>  typedef struct _ATOM_Vega10_DISPCLK_Dependency_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                         /* Nu=
mber of entries.*/
> -       ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynam=
ically allocate entries. */
> +       ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynami=
cally allocate entries. */
>  } ATOM_Vega10_DISPCLK_Dependency_Table;
>
>  typedef struct _ATOM_Vega10_PHYCLK_Dependency_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                         /* Nu=
mber of entries. */
> -       ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynam=
ically allocate entries. */
> +       ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynami=
cally allocate entries. */
>  } ATOM_Vega10_PHYCLK_Dependency_Table;
>
>  typedef struct _ATOM_Vega10_MM_Dependency_Record {
> @@ -213,7 +213,7 @@ typedef struct _ATOM_Vega10_MM_Dependency_Record {
>  typedef struct _ATOM_Vega10_MM_Dependency_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                         /* Nu=
mber of entries */
> -       ATOM_Vega10_MM_Dependency_Record entries[1];             /* Dynam=
ically allocate entries */
> +       ATOM_Vega10_MM_Dependency_Record entries[];             /* Dynami=
cally allocate entries */
>  } ATOM_Vega10_MM_Dependency_Table;
>
>  typedef struct _ATOM_Vega10_PCIE_Record {
> @@ -225,7 +225,7 @@ typedef struct _ATOM_Vega10_PCIE_Record {
>  typedef struct _ATOM_Vega10_PCIE_Table {
>         UCHAR  ucRevId;
>         UCHAR  ucNumEntries;                                        /* Nu=
mber of entries */
> -       ATOM_Vega10_PCIE_Record entries[1];                      /* Dynam=
ically allocate entries. */
> +       ATOM_Vega10_PCIE_Record entries[];                      /* Dynami=
cally allocate entries. */
>  } ATOM_Vega10_PCIE_Table;
>
>  typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
> @@ -235,7 +235,7 @@ typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
>  typedef struct _ATOM_Vega10_Voltage_Lookup_Table {
>         UCHAR ucRevId;
>         UCHAR ucNumEntries;                                          /* N=
umber of entries */
> -       ATOM_Vega10_Voltage_Lookup_Record entries[1];             /* Dyna=
mically allocate entries */
> +       ATOM_Vega10_Voltage_Lookup_Record entries[];             /* Dynam=
ically allocate entries */
>  } ATOM_Vega10_Voltage_Lookup_Table;
>
>  typedef struct _ATOM_Vega10_Fan_Table {
> @@ -327,7 +327,7 @@ typedef struct _ATOM_Vega10_VCE_State_Record {
>  typedef struct _ATOM_Vega10_VCE_State_Table {
>      UCHAR ucRevId;
>      UCHAR ucNumEntries;
> -    ATOM_Vega10_VCE_State_Record entries[1];
> +    ATOM_Vega10_VCE_State_Record entries[];
>  } ATOM_Vega10_VCE_State_Table;
>
>  typedef struct _ATOM_Vega10_PowerTune_Table {
> @@ -427,7 +427,7 @@ typedef struct _ATOM_Vega10_Hard_Limit_Record {
>  typedef struct _ATOM_Vega10_Hard_Limit_Table {
>      UCHAR ucRevId;
>      UCHAR ucNumEntries;
> -    ATOM_Vega10_Hard_Limit_Record entries[1];
> +    ATOM_Vega10_Hard_Limit_Record entries[];
>  } ATOM_Vega10_Hard_Limit_Table;
>
>  typedef struct _Vega10_PPTable_Generic_SubTable_Header {
> --
> 2.42.0
>
