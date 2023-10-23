Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2557D40CD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjJWUUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjJWUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:20:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E493D78;
        Mon, 23 Oct 2023 13:20:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so6009072a12.1;
        Mon, 23 Oct 2023 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698092439; x=1698697239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcJOgJNcS2p4NFz4YEARd6CEH2tDggIHToe8d/lsPVQ=;
        b=VxcrThUfo0W4eyXlBjiuKB5S5dcnIHtdInr/IatALOPVCuqnG6HclRAKwL+mGC8cT2
         S4VDN4PeIlnmEeNgcwTcHWCm2d/jQuuGnT0ggieiaUaimxzdGjZ+VMEIXiVykIqbF8lh
         iWfsaRfSkon6H9cl+a9aJiQL4XQVhze2r2LXR4pkO83YaupK+cksVGu3DYSPP9OCazXV
         PnCjnsGWoR0WOQlcpXXHqROl7ri6x5CT59kx0spvu3dI+38HJquiQY/QU/NKGURiv3LP
         aWGE0uTfN9TGR6gUq0qMzxIksiDAeXv+zTNCRysxMIKVOrgQhQJG0qwXoi96fka3xsDK
         /xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092439; x=1698697239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcJOgJNcS2p4NFz4YEARd6CEH2tDggIHToe8d/lsPVQ=;
        b=JADEkVGexGtqnYm/m22VSc5atGb+VTfuZsOvxR8Kiw1MX7yFiP9fb0+0tq7Bo4eMVK
         kA5ZRkAcJWSgA8ZxSdPdLZ3boYiS2/AiXy8UdNAOSbtzDU1/a3lhaTGqIT2+qxSlNqcc
         8eh1m53+MbBEqa0sKBKdzCfEEmQVkowTSRhIDLdbCH7VNPW0gpbAptGGsCto2dSm954P
         G7n7ddaFqx/U+cKIKe2F9h1Y0GG87UWtzrZbBxvgMB3XJ1JiwVkxWdC7uQpmUM1HE6uE
         3fdYGrcYl2IZvF0cOY9sQpb1mZL4dPXjwuUvxBLmjTBh5EuMf90o/JZgi5rJQ0A7DU8p
         Pghw==
X-Gm-Message-State: AOJu0YwWKG2OVT5FIKc4FSL5AmtxnbzHWLGE+Dpj7ebDO9UX+v2AWL2+
        iMpJFTsBwIeh6jThUsb6oM8SrgfoRjT1wc0mra8=
X-Google-Smtp-Source: AGHT+IF0i4FCIEXJ5r+guzxgVZMg1LSWXPnTpOmpFJCUd+vzCdlua9+QP4fW2ZNfi7FYylAMHYWi/IN+X3DEJykeEoI=
X-Received: by 2002:a50:d593:0:b0:53d:a0c9:dbd4 with SMTP id
 v19-20020a50d593000000b0053da0c9dbd4mr6379285edi.21.1698092439310; Mon, 23
 Oct 2023 13:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-topic-adreno_warn-v1-1-bb1ee9391aa2@linaro.org>
 <CAF6AEGuS3PhNbh9Gmu1g9YpUcr3LOh1gZK-XBE+urdb5jRjorg@mail.gmail.com> <6a0398d1-22f4-4eb7-ba43-c448055be323@linaro.org>
In-Reply-To: <6a0398d1-22f4-4eb7-ba43-c448055be323@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 23 Oct 2023 13:20:27 -0700
Message-ID: <CAF6AEGuqrm0pssjRDa9DK=NppU4Qq5cPZicbGfxKH2czJmjK2A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: Drop WARN_ON from patchid lookup for new GPUs
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
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

On Mon, Oct 23, 2023 at 12:56=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:
>
>
>
> On 10/23/23 21:42, Rob Clark wrote:
> > On Mon, Oct 23, 2023 at 7:29=E2=80=AFAM Konrad Dybcio <konrad.dybcio@li=
naro.org> wrote:
> >>
> >> New GPUs still use the lower 2 bytes of the chip id (in whatever form
> >> it comes) to signify silicon revision. Drop the warning that makes it
> >> sound as if that was unintended.
> >>
> >> Fixes: 90b593ce1c9e ("drm/msm/adreno: Switch to chip-id for identifyin=
g GPU")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>   drivers/gpu/drm/msm/adreno/adreno_gpu.h | 5 -----
> >>   1 file changed, 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm=
/msm/adreno/adreno_gpu.h
> >> index 80b3f6312116..9a1ec42155fd 100644
> >> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> >> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> >> @@ -203,11 +203,6 @@ struct adreno_platform_config {
> >>
> >>   static inline uint8_t adreno_patchid(const struct adreno_gpu *gpu)
> >>   {
> >> -       /* It is probably ok to assume legacy "adreno_rev" format
> >> -        * for all a6xx devices, but probably best to limit this
> >> -        * to older things.
> >> -        */
> >> -       WARN_ON_ONCE(gpu->info->family >=3D ADRENO_6XX_GEN1);
> >
> > Maybe just change it to ADRENO_6XX_GEN4?
> That also applies to 700

Then the warn is warning about what it is supposed to ;-)

I guess this is coming from a6xx_gmu_fw_start()?  I think we need a
different way to construct the gmu chipid, since the point of this was
to not depend on the low 8b having any particular meaning.  Perhaps we
should just get the gmu chipid from the device table.

BR,
-R
