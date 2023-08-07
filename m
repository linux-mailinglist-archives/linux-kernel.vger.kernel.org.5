Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36A2772B5B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjHGQpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjHGQpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:45:08 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B67A1736
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:45:07 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bff2d2c141so574891fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426706; x=1692031506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfoqLIba1AF87rihr9bsxZdVGLDPpuKR96GgIsmd5Nk=;
        b=JHhtdfhFof0tkps0WXOG0EXsn3N+0wVgSXX6ubKj37GfkElHT22/ZFOG7xZnjycKHT
         1PYFLR7mT5V5hEPOrYnrc7/nnqWH9TqwGnt492yGxNh70ex0hMSWqypgJ4403NgB4bxA
         QvVEm59JY2qkaj5sGfYqEThuAnxGWXhQocxbvtodaG6/CCe0kRoa67HTKcBoez+INPUj
         WdBoNiAZ/74Cy96ImF4dVM3Y/EajZjoamWKFQdIQNR7sVZKUCg+bi8/a9gsaKBAMA5+C
         APLArB3d4moYvoW3+W/0M6G0MN5klXILgQYek2w7IooSpZT/4/ecXtmX7deqyZnVcf1n
         wVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426706; x=1692031506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfoqLIba1AF87rihr9bsxZdVGLDPpuKR96GgIsmd5Nk=;
        b=DTcba+lUhif7KN7JC2LRMjQDUWBhGkaN9KEfmLxkB6+7TDqMWwmrPc633XukBDxnmF
         xBBnkxc4NKYHRgg3sUotvxWILxESkH3vL+GqPMf7/kMild8YSjvTRKzKt3Kz4Gugk2c6
         5BeKQQ3LCFQsqAsBcNjgY8ebMGcO4F0DtpeD4t8I/SF7YgtqUjhfcyh9detsdiZpvQBM
         ZtioWSQNJzg1fbEuTyJ6w5Cj83dw/8letejx3pM6B/OHJYLFV4KTj9oo6gw40p+YlQj+
         2zF9V9XLaXN7Tf/Mya0YZ95EtSOGdD1xTrilrnBCTe/5aq5kozk7Y+hdWynbar78k4Ho
         PcCw==
X-Gm-Message-State: AOJu0YzX6RQmoI1hNwYSOrsFe2Jpbsf3QpirKNre3zplT6kH4UCIknNA
        LHZ2F6DGgrrDquq1vhAPD69+S1hBXY/F8GgROR0=
X-Google-Smtp-Source: AGHT+IGumAWh6Kpn9QD3TQGrAhy4o0PVAVBatDxw6iAJ0kxQKsy00haaZblpIKVeZF5vbnMEIyKsxgdUgA6uZ4A1txQ=
X-Received: by 2002:a05:6870:1713:b0:1ba:64a5:d2d1 with SMTP id
 h19-20020a056870171300b001ba64a5d2d1mr10025458oae.20.1691426706344; Mon, 07
 Aug 2023 09:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230801093023.7584-1-sunran001@208suo.com>
In-Reply-To: <20230801093023.7584-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:44:55 -0400
Message-ID: <CADnq5_NppWn77SagusVruWd4rEw_1ik0Uq4qY9Cz33VQdnRQQg@mail.gmail.com>
Subject: Re: [PATCH] gpu: amd: Clean up errors in ppatomfwctrl.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 5:30=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> index 2fc1733bcdcf..e86e05c786d9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> @@ -147,8 +147,7 @@ struct pp_atomfwctrl_bios_boot_up_values {
>         uint8_t    ucCoolingID;
>  };
>
> -struct pp_atomfwctrl_smc_dpm_parameters
> -{
> +struct pp_atomfwctrl_smc_dpm_parameters {
>    uint8_t  liquid1_i2c_address;
>    uint8_t  liquid2_i2c_address;
>    uint8_t  vr_i2c_address;
> --
> 2.17.1
>
