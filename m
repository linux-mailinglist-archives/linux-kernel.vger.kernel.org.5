Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F3776029
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjHINFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjHINFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:05:21 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7447D10C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:05:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a74d759be4so5066529b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691586319; x=1692191119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMffwnQubDmr3m89sLgQURQ081HebwaWlxgqzFDRRig=;
        b=BSzOFLXkMELYLuxEcRiQoewWXGwLzLIHYKjcxfz+eCBzoUFRwc5NgWfV97sNLzWznk
         KAwLhS783puSZhul7vTr6a+wgyqX9bR6jfxd7dOg1Nt0pMgRv01o7yOVsfj44wL40Red
         B7u998bo4nPOYIwzDQGf+jAN9MM4wwVsImU4Apis7XMdx6kLdx6Jwzv+IUOIR4JtDeks
         S12NJlFXyS3tJMPnk6p9mHM9rG6CE9xqHm3tJ4gLHGTFwH1OC2P5HPOHvtfvmcAI1/Tg
         9q6F5QVhVPvSJIjYEEZgehAqDOqA2fum1nULjAZ4LX4pK5BC3YmUSarrNv8S635dPZBi
         IY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586319; x=1692191119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMffwnQubDmr3m89sLgQURQ081HebwaWlxgqzFDRRig=;
        b=EYnfmr3JYZKsLGpyO7fiK+N4b2tPPMWhGpCVB7/YtixROyx8rHfBsBNmTtPc1eXVKd
         icCBGIKdNBIWqCynA8xDEuHSNUJAqw1lZX/+WtaciT/fRz65OXr18WkVgO0llNAH646i
         NY3Sw9gygUS0KV2fcVHbtLZYZLFSwXwHwtNSHDdO9/6xGLY087g7Nq52AkXCrfEIweNc
         U4O247ERc1xYFCoasH2JU9h208f0wPKc/qyuxYIevfB0ycztPa+PgH/DzCuWou+KVXmn
         AoSqjiMCaEZbLwb7BjO8v30jpN6I47uUXBjafnD1LIEnVr1AKISLc5cNc/v7+vs9Ha8O
         eTbw==
X-Gm-Message-State: AOJu0Yw7uF+OMx05JENZKovXbPAAMvmY37DgllQ+2JefZ2sbe+vq7zeG
        bfUuao0M2ZWv0npLtKIBU854NZZCvJ9Lnr27I0Q=
X-Google-Smtp-Source: AGHT+IHKQVBbOrtFJbejz/pPyZya/LqtwPBQP36d8ib/sTRMK8UfYl88mlYUOcq7BVBOX35lEXdB+RRrWdfJF4saP5U=
X-Received: by 2002:a54:460e:0:b0:3a4:8590:90f2 with SMTP id
 p14-20020a54460e000000b003a4859090f2mr2830780oip.47.1691586318709; Wed, 09
 Aug 2023 06:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230808232627.21168-1-rdunlap@infradead.org>
In-Reply-To: <20230808232627.21168-1-rdunlap@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 9 Aug 2023 09:05:06 -0400
Message-ID: <CADnq5_PkGDM0ig9-D3y1Z87EauYnAnteNqr=EewUjhVaCUFA7g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: dmub_replay: don't use kernel-doc markers
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        kernel test robot <lkp@intel.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Tue, Aug 8, 2023 at 7:26=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> These functions don't use kernel-doc notation for comments so
> don't begin each comment block with the "/**" kernel-doc marker.
>
> This prevents a bunch of kernel-doc warnings:
>
> dmub_replay.c:37: warning: This comment starts with '/**', but isn't a ke=
rnel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> dmub_replay.c:37: warning: missing initial short description on line:
>  * Get Replay state from firmware.
> dmub_replay.c:66: warning: This comment starts with '/**', but isn't a ke=
rnel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> dmub_replay.c:66: warning: missing initial short description on line:
>  * Enable/Disable Replay.
> dmub_replay.c:116: warning: This comment starts with '/**', but isn't a k=
ernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> dmub_replay.c:116: warning: missing initial short description on line:
>  * Set REPLAY power optimization flags.
> dmub_replay.c:134: warning: This comment starts with '/**', but isn't a k=
ernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> dmub_replay.c:134: warning: missing initial short description on line:
>  * Setup Replay by programming phy registers and sending replay hw contex=
t values to firmware.
> and 10 more similar warnings.
>
> Fixes: c7ddc0a800bc ("drm/amd/display: Add Functions to enable Freesync P=
anel Replay")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: lore.kernel.org/r/202308081459.US5rLYAY-lkp@intel.com
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c |   18 ++++++-------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff -- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/=
drm/amd/display/dc/dce/dmub_replay.c
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
> @@ -33,7 +33,7 @@
>
>  #define MAX_PIPES 6
>
> -/**
> +/*
>   * Get Replay state from firmware.
>   */
>  static void dmub_replay_get_state(struct dmub_replay *dmub, enum replay_=
state *state, uint8_t panel_inst)
> @@ -62,7 +62,7 @@ static void dmub_replay_get_state(struct
>         }
>  }
>
> -/**
> +/*
>   * Enable/Disable Replay.
>   */
>  static void dmub_replay_enable(struct dmub_replay *dmub, bool enable, bo=
ol wait, uint8_t panel_inst)
> @@ -112,7 +112,7 @@ static void dmub_replay_enable(struct dm
>
>  }
>
> -/**
> +/*
>   * Set REPLAY power optimization flags.
>   */
>  static void dmub_replay_set_power_opt(struct dmub_replay *dmub, unsigned=
 int power_opt, uint8_t panel_inst)
> @@ -130,7 +130,7 @@ static void dmub_replay_set_power_opt(st
>         dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
>  }
>
> -/**
> +/*
>   * Setup Replay by programming phy registers and sending replay hw conte=
xt values to firmware.
>   */
>  static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
> @@ -215,7 +215,7 @@ static bool dmub_replay_copy_settings(st
>         return true;
>  }
>
> -/**
> +/*
>   * Set coasting vtotal.
>   */
>  static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
> @@ -234,7 +234,7 @@ static void dmub_replay_set_coasting_vto
>         dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
>  }
>
> -/**
> +/*
>   * Get Replay residency from firmware.
>   */
>  static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t pane=
l_inst,
> @@ -267,7 +267,7 @@ static const struct dmub_replay_funcs re
>         .replay_residency               =3D dmub_replay_residency,
>  };
>
> -/**
> +/*
>   * Construct Replay object.
>   */
>  static void dmub_replay_construct(struct dmub_replay *replay, struct dc_=
context *ctx)
> @@ -276,7 +276,7 @@ static void dmub_replay_construct(struct
>         replay->funcs =3D &replay_funcs;
>  }
>
> -/**
> +/*
>   * Allocate and initialize Replay object.
>   */
>  struct dmub_replay *dmub_replay_create(struct dc_context *ctx)
> @@ -293,7 +293,7 @@ struct dmub_replay *dmub_replay_create(s
>         return replay;
>  }
>
> -/**
> +/*
>   * Deallocate Replay object.
>   */
>  void dmub_replay_destroy(struct dmub_replay **dmub)
