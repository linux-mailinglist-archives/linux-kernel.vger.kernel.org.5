Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2A7DCD37
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbjJaMqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344332AbjJaMqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:46:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7703AE4;
        Tue, 31 Oct 2023 05:46:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so8691793a12.3;
        Tue, 31 Oct 2023 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698756401; x=1699361201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKZa5dSJEe2OFosspYgbHn2/m1CBCfZ471gmM0Ox3Zg=;
        b=OOIkpkI4N2odesJOMYc8GQALS1g0BJRJTdJqhwR9KIB5l98JoSRzFw17n8WNh524Wp
         YF8r2VFcHaGG8cJOYoNsmPee7vhr5p0uvxqplboDTtCDuNYEx7ZtT145t1YMO5T+8pPX
         S45CQr9q3rxMSGOrWCooDaS1vHLvpIhZaxKMGx8AAJTEtYnWdvEAFDzOOw4F4Sza9uwh
         iluyv7cRGezh7+E7lOPvCXLRqD7tFvq4Iw1XWbl4eLtp+q1GVzZqjftKr6jfLbhe+Sc6
         IdfeVJyoLtu1tc+G5CXu/duperhVzBAwVHffSoXYg8O3xc8+ydCQRziSbGnD5YQZLTgT
         k1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698756401; x=1699361201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKZa5dSJEe2OFosspYgbHn2/m1CBCfZ471gmM0Ox3Zg=;
        b=gq/7JxhnFTg3tIy8xuV3D+GM1bgzDrbLenkRsB+x7bENH/Na19lNB9RZ9jZJjnpoV4
         fh1nzmFxUoQAKt/7PfAu3oTetUDl0+9mxOjMWo3P3luGswtQfUclTyW9RgLNzQdpSjnd
         SL6Pbb8BvNxqxIPwTUZmk+dIIcaRPigo4BXlBZKwOn/7xU0po+d6k49D/28y1lHOxtle
         U/9hicug+ZASddZtViuZJCdG2mxyPvgrz/9ugv2QLY8fcRZGjhJuIFog/gHiqdnbbvzy
         5jfqZzW8aa3SzowXkoXPxIyYxbCzXaQvxb8ZBy29HKnzjEDHcba2+xGH0w7uPaBy7U0B
         +JzA==
X-Gm-Message-State: AOJu0YyyvQLNJUr3QXKpCzA6cnaFo+38WyyoOwTBy5Y4qYroFRbcdNbb
        r/TLtO5PejCcGGMIqJiieHF7ZdGrzJyH9N42OxM=
X-Google-Smtp-Source: AGHT+IFgPFGHLLpf2/dBd95JgtG0UZj1klCPTGGWfafBuQ68PFpBgQ0Bbk2zw5laV2W44PGxbqXvObQrh8RUIMJRs9g=
X-Received: by 2002:aa7:d3c1:0:b0:53f:bd95:d963 with SMTP id
 o1-20020aa7d3c1000000b0053fbd95d963mr9235785edr.32.1698756400670; Tue, 31 Oct
 2023 05:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com> <20231031081931.GC11778@thinkpad>
In-Reply-To: <20231031081931.GC11778@thinkpad>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 31 Oct 2023 05:46:28 -0700
Message-ID: <CAF6AEGv4w=a8kpkM63OU8DJ_nND5acG6nNuz8r4qnAT8Acyw+g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8280xp catalog
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>
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

On Tue, Oct 31, 2023 at 1:19=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Oct 30, 2023 at 04:23:20PM -0700, Bjorn Andersson wrote:
> > During USB transfers on the SC8280XP __arm_smmu_tlb_sync() is seen to
> > typically take 1-2ms to complete. As expected this results in poor
> > performance, something that has been mitigated by proposing running the
> > iommu in non-strict mode (boot with iommu.strict=3D0).
> >
> > This turns out to be related to the SAFE logic, and programming the QOS
> > SAFE values in the DPU (per suggestion from Rob and Doug) reduces the
> > TLB sync time to below 10us, which means significant less time spent
> > with interrupts disabled and a significant boost in throughput.
> >
> > Fixes: 4a352c2fc15a ("drm/msm/dpu: Introduce SC8280XP")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Doug Anderson <dianders@chromium.org>
> > Suggested-by: Rob Clark <robdclark@chromium.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b=
/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> > index 1ccd1edd693c..4c0528794e7a 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> > @@ -406,6 +406,7 @@ static const struct dpu_perf_cfg sc8280xp_perf_data=
 =3D {
> >       .min_llcc_ib =3D 0,
> >       .min_dram_ib =3D 800000,
> >       .danger_lut_tbl =3D {0xf, 0xffff, 0x0},
> > +     .safe_lut_tbl =3D {0xfe00, 0xfe00, 0xffff},
>
> What does these values represent? And how SAFE is to override the default=
 QoS
> values?
>
> I'm not too familiar with the MSM DRM driver, so please excuse my ignoran=
ce.

for realtime dma (like scanout) there is a sort of "safe" signal from
the dma master to the smmu to indicate when it has enough data
buffered for it to be safe to do tlbinv without risking underflow.
When things aren't "safe" the smmu will stall tlbinv.  This is just
configuring the thresholds for the "safe" signal.

BR,
-R

> - Mani
>
> >       .qos_lut_tbl =3D {
> >               {.nentry =3D ARRAY_SIZE(sc8180x_qos_linear),
> >               .entries =3D sc8180x_qos_linear
> >
> > ---
> > base-commit: c503e3eec382ac708ee7adf874add37b77c5d312
> > change-id: 20231030-sc8280xp-dpu-safe-lut-9769027b8452
> >
> > Best regards,
> > --
> > Bjorn Andersson <quic_bjorande@quicinc.com>
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
