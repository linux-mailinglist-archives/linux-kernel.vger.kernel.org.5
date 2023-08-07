Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747E7772AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHGQdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHGQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:33:20 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90FA1BE1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:33:04 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bc9d16c317so3712723a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425982; x=1692030782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyv2Ai8G6V59y/N5vBsqZfF6gA3n7Ds45WJJHRAYVC8=;
        b=NQX76BCOk/+2efqOSj8cNKLVHOsCRIJbntEvlmB9b3zrcky5wgMTIUcaw4wQEJSAr6
         qJ6/EElIlKUr4ztPrd++6fJ6AyAFE0j8CMyuLZKbXiJpQu3jzBOjtGWsvRFNxYFx6yxD
         4WGHGe3DbsX4B1dJtrr19XyXtind4830Qb1N8CrNdp7BDSZd4IFfw+kXugYlFFls7ADW
         RK3SnyyshNV1AwxMSjYuA1Vap77n9x2ogpHMOdAu+AI5Mm1KvB3SCUj1VqkMckKi40om
         ba1wZ/bQp6IBo/SkdGh1Ex+8KT5mXVBxFyy7xAopNTs3em6aZCcpV6h66QIKPr/nmvnK
         Ggcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425982; x=1692030782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xyv2Ai8G6V59y/N5vBsqZfF6gA3n7Ds45WJJHRAYVC8=;
        b=f2UDFeP7HFa4YyjaFGLACXfIU1ILVgLroK3bfOz6QnaCrbpXXrcy9dHdB47m1+VK3D
         CAMLjzjeli7d+tSwasBZ+wFZRaIThxqvbIBOEhCQrl9VKx12O0HTthEzIYEw5/2Cq8RM
         UmCcY6a8zyrzEfZxqQmrT4Haq5LT5808YLZkC5u5ekN3hs4I3W7aKeSl1QHx1bqKomNm
         UmQHYJnFPOSMIRkX14tpAJk2sQminSBwwuRGk3iv0BCs/yYAoQxNMVmeTUGjnLF3NJey
         tSWcL7NkUSGrNTUpCIoBJ1hgSZbCt9ZQcRJIayZhGPoDzcoDFtu4DPDH8aFBceU/vUC+
         0WwA==
X-Gm-Message-State: AOJu0YyL8eD2nMRMDVlNFNzdITuHg/DAcLCh6uOCEP93bZOvLs0jPTte
        u4KrEFGGWF4lYaJh7T7TAHCIwWPVgeNxuNhcZVw=
X-Google-Smtp-Source: AGHT+IEv0wSPqpzLjRH4T7IC9t0Cqdza37V3DEkz92T/k1+NQ5jEsfTCnO6IqACa6NIHr+9PGfuSxtBa+FwOnLb0sdo=
X-Received: by 2002:a05:6870:5494:b0:1be:cf5d:6f7b with SMTP id
 f20-20020a056870549400b001becf5d6f7bmr11550277oan.17.1691425981935; Mon, 07
 Aug 2023 09:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230801060443.6090-1-sunran001@208suo.com>
In-Reply-To: <20230801060443.6090-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:32:51 -0400
Message-ID: <CADnq5_OEG9hHxR7wgse7x3ibzH9q=bL66wCAhS2fDyTmRjeKqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega12_pptable.h
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

On Tue, Aug 1, 2023 at 2:04=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: space prohibited before open square bracket '['
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h   | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
> index bf4f5095b80d..9b8435a4d306 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
> @@ -72,8 +72,7 @@ enum ATOM_VEGA12_PPCLOCK_ID {
>  typedef enum ATOM_VEGA12_PPCLOCK_ID ATOM_VEGA12_PPCLOCK_ID;
>
>
> -typedef struct _ATOM_VEGA12_POWERPLAYTABLE
> -{
> +typedef struct _ATOM_VEGA12_POWERPLAYTABLE {
>        struct atom_common_table_header sHeader;
>        UCHAR  ucTableRevision;
>        USHORT usTableSize;
> @@ -92,11 +91,11 @@ typedef struct _ATOM_VEGA12_POWERPLAYTABLE
>        USHORT usODPowerSavePowerLimit;
>        USHORT usSoftwareShutdownTemp;
>
> -      ULONG PowerSavingClockMax  [ATOM_VEGA12_PPCLOCK_COUNT];
> -      ULONG PowerSavingClockMin  [ATOM_VEGA12_PPCLOCK_COUNT];
> +      ULONG PowerSavingClockMax[ATOM_VEGA12_PPCLOCK_COUNT];
> +      ULONG PowerSavingClockMin[ATOM_VEGA12_PPCLOCK_COUNT];
>
> -      ULONG ODSettingsMax [ATOM_VEGA12_ODSETTING_COUNT];
> -      ULONG ODSettingsMin [ATOM_VEGA12_ODSETTING_COUNT];
> +      ULONG ODSettingsMax[ATOM_VEGA12_ODSETTING_COUNT];
> +      ULONG ODSettingsMin[ATOM_VEGA12_ODSETTING_COUNT];
>
>        USHORT usReserve[5];
>
> --
> 2.17.1
>
