Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1856772B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjHGQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjHGQih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:38:37 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6F8100
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:38:08 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1bb58b4c513so3506762fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426281; x=1692031081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtzkyKDB15+3Mt70/7SpzjEUZ2ea1IYU12fbFIu9dOM=;
        b=H7ynB/gPElacr7v8xHKXcLr1yAlNCZdxr5nU8mrd8AMeaV8YijEoQ117HBPKbJR2kz
         S7wLd51gynS2JAIY6OMoZuoRC7yVkIB0j0dDdzQ3U0CkRBnwCHAv7lxQcQ/BIjukvFkf
         SmHVyZHfpCInLwBwCRcGuPC0MLWBGXMvSqFq+/khGupKkMCwSX7VT69iEMAcwMVnZh93
         /xkuFbqgGaEvNkEpjr8GHQiADEvZTeOBfSA10oWNUJ8VZGzlO6R+ABN729bkPAk14/gj
         keYGGb4XNW6d6HoUj+IYFnTIOrR/h31l1veYQYJG3T8ExGtK4CKcGjC6ytcmlTwPYLP8
         xFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426281; x=1692031081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtzkyKDB15+3Mt70/7SpzjEUZ2ea1IYU12fbFIu9dOM=;
        b=NWp/IYXnPalyTzBChhBCf5G26qntzcIbSxvNYXXUr21g0vICTIQ6PHMS4OBIVPPfdr
         1Q2J+e4uTCESAF4m9QFqW0dtiZfG6c0Xivkfz0iwOn/s5ksfOjABUQTyMz54+qKGEhvV
         WXjck3irqdOibtNFCk2CTuXvBeYN3g09BtH1w2u8zRcwkzTQf+O/SZa6lz3VQ2FKti4r
         2NH4rMZDrndoj6v/PHIquZLuW3KawH3/mRjOY4odqBhderbalQizAoYDVUvkRW0vATV9
         oHdINDVGF7qWw1t0N9gGddo5JxPqyoUebqv+0qhOJxxPkt7L09Fctp8sKMTEfs4YzIFk
         hJRw==
X-Gm-Message-State: AOJu0Yyi+U/WK1W1mLofxUuXmtIIieqMbAhSmfZyJ5537pK1vjINXM+b
        2TEoysjYhStCueT88scZc9gRVAUGDWtVmu1DL1U=
X-Google-Smtp-Source: AGHT+IE8ONW21pbbjXSZYEQ4gzJQbgPMlPYnptto6HsDJxOhmFEM3i4JpJxz2crBEhwO2JR3T51qw1YZPj5lwnogFAw=
X-Received: by 2002:a05:6871:89e:b0:1b3:eec8:fa90 with SMTP id
 r30-20020a056871089e00b001b3eec8fa90mr12937916oaq.6.1691426281110; Mon, 07
 Aug 2023 09:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230801083710.6738-1-sunran001@208suo.com>
In-Reply-To: <20230801083710.6738-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:37:50 -0400
Message-ID: <CADnq5_M7j0McrtPf6Zj=f_sxMLUOXgfWUmc-12NOjQ-+gFs14A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in ppatomctrl.h
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

On Tue, Aug 1, 2023 at 4:37=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
> index b3103bd4be42..1f987e846628 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
> @@ -278,16 +278,14 @@ struct pp_atom_ctrl__avfs_parameters {
>         uint8_t  ucReserved;
>  };
>
> -struct _AtomCtrl_HiLoLeakageOffsetTable
> -{
> +struct _AtomCtrl_HiLoLeakageOffsetTable {
>      USHORT usHiLoLeakageThreshold;
>      USHORT usEdcDidtLoDpm7TableOffset;
>      USHORT usEdcDidtHiDpm7TableOffset;
>  };
>  typedef struct _AtomCtrl_HiLoLeakageOffsetTable AtomCtrl_HiLoLeakageOffs=
etTable;
>
> -struct _AtomCtrl_EDCLeakgeTable
> -{
> +struct _AtomCtrl_EDCLeakgeTable {
>      ULONG DIDT_REG[24];
>  };
>  typedef struct _AtomCtrl_EDCLeakgeTable AtomCtrl_EDCLeakgeTable;
> --
> 2.17.1
>
