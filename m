Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243237E4021
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjKGNiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKGNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:38:20 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5555FA3;
        Tue,  7 Nov 2023 05:38:16 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ef9f1640a5so3299965fac.3;
        Tue, 07 Nov 2023 05:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699364295; x=1699969095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/JzXXKi9EWZmEKt0kuoOZHJPpAwEzdC1EaLt8yqMl0=;
        b=SvZwRFwNtsK0nRIEZ6lMg77JvtUpgkfCRvkRhtOHKX6VcpCDY/xIBDmlunRAekadn1
         4dxDDd/xihwhSRaIpQW4kmo3IoQKhqoq5EvwDuoXNhsBdM0yRrL/xfaT/o9tlx/6Eh6k
         yTbxelendmcpv8EOn2I1CG2hv35DfGbKjXOty0+CdebM2gvAwCbKSvxjqWW1MQ07HyKT
         O+bTUKLa3sBbKyTPGFJUwJaJMJJxv/sJymXmtP6LNpPMlVnL3ahzAequUDedqLiabqZT
         7mm6dsbCeqmOsb/kJJfcCWtuvbDX9hDCOWGOvzeZ3Iu1dsPqZU4U2O867vuLdzGZYxcP
         Sakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699364295; x=1699969095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/JzXXKi9EWZmEKt0kuoOZHJPpAwEzdC1EaLt8yqMl0=;
        b=kQD8z3ppxKg5IiyQe5rNuctgrfKRr3q82D9CtrjDJL5RSzL8zTszF3tHtaqRZ9qQJ1
         5+ppxVAt2SFfa6vwiyk/1J+lS2uPGK16DQp3s9a6rBKolfUDIOSAzy0TCpL+t6ojWJjq
         Qg06VWWnicWqntbdbwOwTwjHINq+Y7lRUYDlcc/NeG0xWOwuKyt52ZPgKtfyTTn5R0tm
         0VlwcTP7I5xIRAW02iJLGq8lVua3yHpjLj5LVR6IathXJnClAoalvTfAWita81Ljd4p3
         bUjw3hCGLo9MWbhbZjsiSEOW4FsBfLUi6PTdozAO8KhmZnJkYsWZuP6PbCost7c/Ijuq
         jHkQ==
X-Gm-Message-State: AOJu0Ywq4pwA/IJLmpOXxxVm8QWB3oMZvRibXVmGMhtHF43TPdDAdj6j
        fvaxJR2US1sRhJclJc3E7Jlqu5yri95ijqNe8AU=
X-Google-Smtp-Source: AGHT+IHNBTVDKA0fR0kDClpaT8pql9m1AEsUIvWGKaOkV7HGpxLEMW93vsgGqKhwvt+ff8/n4Uq7GyTt1WdlZHsmbo0=
X-Received: by 2002:a05:6871:af8c:b0:1e9:b9e6:98e1 with SMTP id
 zx12-20020a056871af8c00b001e9b9e698e1mr2251960oab.1.1699364295339; Tue, 07
 Nov 2023 05:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20231107121837.3759358-1-sashal@kernel.org> <20231107121837.3759358-21-sashal@kernel.org>
In-Reply-To: <20231107121837.3759358-21-sashal@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Nov 2023 08:38:03 -0500
Message-ID: <CADnq5_PzxAMvY7FKDuBT-7RwGhXusoKioF8zXwKR9oWvdp9foQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 21/40] drm/radeon: Fix UBSAN
 array-index-out-of-bounds for Radeon HD 5430
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Felix Held <felix.held@amd.com>,
        dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com
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

On Tue, Nov 7, 2023 at 7:20=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> [ Upstream commit c63079c61177ba1b17fa05c6875699a36924fe39 ]
>
> For pptable structs that use flexible array sizes, use flexible arrays.
>
> Suggested-by: Felix Held <felix.held@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2894
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

FWIW, I don't think any of these UBSAN variable sized array changes
are really stable material.  They are not really fixing an actual
issue just making UBSAN happy.

Alex


> ---
>  drivers/gpu/drm/radeon/pptable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pp=
table.h
> index 4c2eec49dadc9..94947229888ba 100644
> --- a/drivers/gpu/drm/radeon/pptable.h
> +++ b/drivers/gpu/drm/radeon/pptable.h
> @@ -74,7 +74,7 @@ typedef struct _ATOM_PPLIB_THERMALCONTROLLER
>  typedef struct _ATOM_PPLIB_STATE
>  {
>      UCHAR ucNonClockStateIndex;
> -    UCHAR ucClockStateIndices[1]; // variable-sized
> +    UCHAR ucClockStateIndices[]; // variable-sized
>  } ATOM_PPLIB_STATE;
>
>
> --
> 2.42.0
>
