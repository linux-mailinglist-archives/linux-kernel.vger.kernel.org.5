Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C00772CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjHGR1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjHGR1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:27:05 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A941A3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:27:02 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56ca4d7079aso3255326eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429221; x=1692034021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FTYO6Q7g6DrRo+pdo61jCBivg9LaG2djlrLcvb9e1E=;
        b=Lv3vsBHqQXgDi8AZ6brBOesEnAW28735Nxa6vHlPpXItg2y1F6s8v27fDHA/c6rVLh
         FkQSoVWAsoCX4bUSoBlXJkp02yNUpyKRoPtPD6+A6HOn68sUggPZ4jihh+EAyu8hAVgC
         VH6MlYE6NxRoXu8BFIV81La9ZA2X69s38Se3EV1FgvxKbRfJ1FEG6LgevcJlqyvV1DGV
         PqKQsZw2ZKd4mlf3FXWkUc3t/Jy2T8FwTP0RptR6gvMgAz5ilC8szOarnrYISVz+jv12
         4Oz4c3FPLoMqfHS5a5LFP6sFqdGgxxTglFlaVcsGnZLMgeVKfcQeTKEscT8d5ub3OWO8
         L5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429221; x=1692034021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FTYO6Q7g6DrRo+pdo61jCBivg9LaG2djlrLcvb9e1E=;
        b=l4QhilxqA4hgEyLB2lnx+7mI5Q6IKLFR7rcbLMTOCb06IEBnkw7mrDASXeoUf1Qxsq
         Dlt4bu63pTN2QBHZlxQIjLyvhbjLImgLF6ocoiFCRUGrDrpIR4YQQpz7rP8DMjZ6O5gn
         U8sNauv+oK0Hmgf/6f918aeFIKbt2OUJfDZ0k3sAYCttWMQRVbOiQyoJFvTDh8pLvYld
         gAehvm7QO79060azvvdHQ0O+gee0KjlBFmQ2fYzR3BHvBzXPYzzhz47yl1MGlqGi0VpG
         zwheDoVg8SyBaWgPAzYgohCB1biyAZQjw3nfE8//AIz3iXQoA/C83unFSJ2VR5tCyN5H
         bODg==
X-Gm-Message-State: AOJu0Yx2TmOFprWYp0+PqI10cEuJbxNYcBkeUATSNrmvSOUVgUTrvghB
        n7dNTCEnnE9YWpkiIwBuoVGM+VSpWMtIw3mjJa8=
X-Google-Smtp-Source: AGHT+IGybLDWjyP9kyHcY8PqlPZLGDEdChaL92tTRvnj1kZ82Fq5Ds2QCKtTmB0fqMz7Xf1i6kP9Cb3kn83F8ZwuRKw=
X-Received: by 2002:a4a:3c5e:0:b0:56d:55b7:e99c with SMTP id
 p30-20020a4a3c5e000000b0056d55b7e99cmr9161465oof.1.1691429221611; Mon, 07 Aug
 2023 10:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230802072316.12985-1-sunran001@208suo.com>
In-Reply-To: <20230802072316.12985-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:26:50 -0400
Message-ID: <CADnq5_Pfo=LSvOU7T0NdDqDMk3k1LzmrT0t93OOOXvyxRAs2+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in amdgpu_atombios.h
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

On Wed, Aug 2, 2023 at 3:23=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.h
> index b639a80ee3fc..0811474e8fd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> @@ -89,8 +89,7 @@ struct atom_memory_info {
>
>  #define MAX_AC_TIMING_ENTRIES 16
>
> -struct atom_memory_clock_range_table
> -{
> +struct atom_memory_clock_range_table {
>         u8 num_entries;
>         u8 rsv[3];
>         u32 mclk[MAX_AC_TIMING_ENTRIES];
> @@ -118,14 +117,12 @@ struct atom_mc_reg_table {
>
>  #define MAX_VOLTAGE_ENTRIES 32
>
> -struct atom_voltage_table_entry
> -{
> +struct atom_voltage_table_entry {
>         u16 value;
>         u32 smio_low;
>  };
>
> -struct atom_voltage_table
> -{
> +struct atom_voltage_table {
>         u32 count;
>         u32 mask_low;
>         u32 phase_delay;
> --
> 2.17.1
>
