Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C98A772B0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjHGQf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjHGQfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:35:54 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586031BCB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:35:33 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bca5d6dcedso4048811a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426131; x=1692030931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqtZMNFkHtE7NtetbFmM02AlfhGVT1s/OA7WGoZWJgw=;
        b=O1FdvLNo2u7VnDpYvsN6GXkWaNuvA32nyCOocicZIPzzPZRMOxyL277vOMBmL5x4Gl
         KhUfU93Yhb5e2he+cOSbqICKKNtdT6+oIq62WjFjw7v5wD4jS+JQ6m73KWbmT+JY1lAu
         GPaLtWWeG/1GW1PuhLgrTGR+ICKWqHmKUl5OYv3mI6+Tu+InSpweqGoe5XfwNbD3OW6o
         OtE7d5PWwTaIVSOiBPKSON4Yj8nbFH5wsEvrMLpKXdAl+jxSYJbhzA+QMf4rVLDjgwo9
         oE12Dorsx7+vIOscd4oEkB9OfA52u3Sv5VTqvj4kB655SjgQoieEfaO/QaOemmhqdQyE
         0QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426131; x=1692030931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqtZMNFkHtE7NtetbFmM02AlfhGVT1s/OA7WGoZWJgw=;
        b=N2OMjr2yeqXLVrWzaF9a7FvvH5MsoVoyjAfPQg+cDY4joYOpZofvNcKpRwLSWVnOQC
         npit7Jcf8/DEQk1tYvNjFn0lNrUODCEXysHz/Fzx0kjgm0m4P8qE8mabGAIdwBkhTvGN
         XHMIFEEqrtsOK7FN5kw8CpeqnA2MB7zpkLuOcWipvvZnZF44ea+clp9SThwO0rDGYsn+
         9h+lFCLJZLE128tFNzVpXZBIjgR2psYY3ObZ0OkxjG2tuKb7xaKXKuRnLJ+aff0sIWbr
         746Byk+YAJM4Scli9kliyHezs4cZ4wqMEgHYTKB4PrctwXr8Dic8h+yio7K+HVcTxVXW
         4QtA==
X-Gm-Message-State: AOJu0YzjHr1AihbC5jDv8WJygYQyUEX+16n8zfZmIOESbsDG4ZyVFGy8
        bnWCC7HtrlzfBGdjciJ9EzA/xfVWe3DmjE0VdLU=
X-Google-Smtp-Source: AGHT+IGhboSGrM8BwO6WHv6vc0JZfIHQ4hqv0io3t5Xhe8kg/xy7oZ3nOWEcRemjgOL8st18ke2YT0XkQwSfONDDXFc=
X-Received: by 2002:a05:6870:e74a:b0:1be:ccce:7991 with SMTP id
 t10-20020a056870e74a00b001beccce7991mr11787641oak.13.1691426130867; Mon, 07
 Aug 2023 09:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230801075507.6377-1-sunran001@208suo.com>
In-Reply-To: <20230801075507.6377-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:35:19 -0400
Message-ID: <CADnq5_Nzn41tiiYuA8mM2FuhUQ5xEeuGsO0WkAtUKNfKoFxYeA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in common_baco.c
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

On Tue, Aug 1, 2023 at 3:55=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: code indent should use tabs where possible
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c b/drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
> index 1c73776bd606..fd79337a3536 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
> @@ -42,7 +42,7 @@ static bool baco_wait_register(struct pp_hwmgr *hwmgr, =
u32 reg, u32 mask, u32 va
>  }
>
>  static bool baco_cmd_handler(struct pp_hwmgr *hwmgr, u32 command, u32 re=
g, u32 mask,
> -                               u32 shift, u32 value, u32 timeout)
> +                               u32 shift, u32 value, u32 timeout)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)(hwmgr->ad=
ev);
>         u32 data;
> --
> 2.17.1
>
