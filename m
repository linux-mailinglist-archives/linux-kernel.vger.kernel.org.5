Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3506780C85
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377134AbjHRN3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377161AbjHRN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:28:44 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC0835AC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:28:42 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1c4f4d67f5bso471695fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692365322; x=1692970122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3niGq6H8AJo9IW4o/nVMSYi4n92JBNuP1VAfWV0dVo4=;
        b=aRJ0hy1TD9BipgvTZaaiUwLrhPaftOcQPG27JbjAMIJhhyyTajRK8VXdb6/D4saWyh
         ynTiZ9tlGUOmsn2tQW7IL5wgWKM8EvKpWyP3Bb7Dun5pWrd/6yJxr5mv44JhiMTQEns3
         qHFQciWQsKwObJLbvSnk6W2VJqGP2Tld3XJWUURE/rMsm+hYufLBNerwFeyJW6yFYbaM
         5mzP1XKpIoFVgybsfhV1G3dv9pnL1q/VpA/3nu9Ddic6+VlyoRBu8k3mtp3iilYQ30Zm
         O8KDYE/xFtlFYjYA+6hN630KXW8pFzUUetgq4I1e3L1Xi9lJJU9rnc226aLafpQB5PXc
         gDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692365322; x=1692970122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3niGq6H8AJo9IW4o/nVMSYi4n92JBNuP1VAfWV0dVo4=;
        b=Y18rDdYxbYWlBKSB7zv4hmsBzmT5EnDyWTzD2OVqcuzKvKd08RpL2nHiIiDPutppIB
         dIATjqkvnKeSRdMahp/u9nuaAVrLGFfBtelfWjrBP2/SSF7nGw11a8853UYPj0SLkvSf
         2fJ35W8PuyXoYfM3ncvJh+Y1/wISa++uys/pS6vhN+/YDDKaZ4kI1gkDqaj0WyDwRZF8
         trurd5FbKNHC5ZSAgAX19x8LK9b+5EWVjzsncxLtTGjmPU6bl8PC1ct0yqTTkzXLt8II
         3o6/iOLNim0M/gaHGxy4+/nibw2udsSLI+XLP+6ZRxeE8cgik9bOubhjGzsBewpWiSmh
         NtOA==
X-Gm-Message-State: AOJu0YxFnJKydPrrw+sXXW2ajj320iUDlDM/T077xo9wSQQb8gSHx2Po
        B0BOxG5z0vuHaKat/qB7sO9E85+fO7vXSVtsLa5WuSWt3So=
X-Google-Smtp-Source: AGHT+IEVr16uL1Sq3eXXDiiAbsZ27vFlyigu9Sb+vdMlCXTrDuEZmhwcgVsPOM21VzqeflmkN5s0gW4p3iJezTaRtxE=
X-Received: by 2002:a05:6870:e314:b0:1ba:3a7f:50eb with SMTP id
 z20-20020a056870e31400b001ba3a7f50ebmr2818671oad.22.1692365321864; Fri, 18
 Aug 2023 06:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230818131742.88763-1-hamza.mahfooz@amd.com>
In-Reply-To: <20230818131742.88763-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 18 Aug 2023 09:28:30 -0400
Message-ID: <CADnq5_PjGmULp42JLcOZy1r-_S0t+FTz5H1MTz55GFcDgJQobA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix mode scaling (RMX_.*)
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Stylon Wang <stylon.wang@amd.com>,
        Alan Liu <haoping.liu@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Joshua Ashton <joshua@froggi.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 9:25=E2=80=AFAM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
>
> As made mention of in commit 4a2df0d1f28e ("drm/amd/display: Fixed
> non-native modes not lighting up"), we shouldn't call
> drm_mode_set_crtcinfo() once the crtc timings have been decided. Since,
> it can cause settings to be unintentionally overwritten. So, since
> dm_state is never NULL now, we can use old_stream to determine if we
> should call drm_mode_set_crtcinfo() because we only need to set the crtc
> timing parameters for entirely new streams.
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Fixes: 712237a4a1b4 ("drm/amd/display: Always set crtcinfo from create_st=
ream_for_sink")
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Does this fix:
https://gitlab.freedesktop.org/drm/amd/-/issues/2783
If so, add a link tag for that.

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3b27b7742854..e9aff5014e39 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6035,7 +6035,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *=
aconnector,
>
>         if (recalculate_timing)
>                 drm_mode_set_crtcinfo(&saved_mode, 0);
> -       else
> +       else if (!old_stream)
>                 drm_mode_set_crtcinfo(&mode, 0);
>
>         /*
> --
> 2.41.0
>
