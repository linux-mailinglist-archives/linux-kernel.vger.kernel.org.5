Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D47F3AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjKVA1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKVA1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:27:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40C91A2;
        Tue, 21 Nov 2023 16:27:45 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548ce28fd23so3493308a12.3;
        Tue, 21 Nov 2023 16:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700612864; x=1701217664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLXUXH+7qCuZ20fixxc7SEekg13SRZ5GDDOIEtjbwok=;
        b=PrKyW0y3eGFNDe8wBo1zvHl2gdsVEqMtw0LEpGWmbrj7jb59EVW6jH2M56BwptFvkp
         QwNSL84sgrD+ZTfFMVgCMq4cKRojtvz4x/aWb5HYWamETlxvWhBDP+Y6of699p1GeZn0
         r452el4qSz6VOBwm3aU6tG1V4V3G5bOas7JR9+/AOQvQ3H2eQIqW/5C0oeXzXDjpTMQY
         sCiwaQ8l5YfvowmQhDnzRyUJ5uANALy49r9eS+A+MDllHImP3taFI9ePfuf84YpQ0i/t
         jh5cO3g6/exYKDLDU22gLt81ELpwamgfIUhW7E5nvZ9o6z9+bvo+xEDRsc64YEzO5EKs
         ZYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700612864; x=1701217664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLXUXH+7qCuZ20fixxc7SEekg13SRZ5GDDOIEtjbwok=;
        b=eJGio5pux/6j56G+m1L53FYzRnOr0/KkIT/Gf/poYKIE6rGR1+QeewTiDYUqnt3gBq
         ILZv+ON/N6a6iUyoGkcU68qDB69Yif4bqOnGAHD10u+BJJZyPrHj0w4Clh1c0ClDCh6C
         TcswFjIGyXMnKxG186G6pbfcfrSezEV4zS9npbQ22ZOfiNtFGB2APBnSIEqR3tm5xp2S
         DW3gmVN7vt9J+TT1iXvE7MCSCReP5+0t4T0C50/f8AP2gtUM6YC06VbS8Q1Hm7PWrVPU
         yQ8GkArsYUc9Q1WS/7msf1BSIibeoffUZS9VTkHSDkDBzeu23KYsfpJKpsd17mCmF+4z
         1itg==
X-Gm-Message-State: AOJu0YytMzpkd6vFUH/e4M4QQyL3Cn2NMq8VoAcUh16of2mvgcv2IC6L
        8qW8EzlpS59O16eBiuXSh2qYBd/AQ+yzz3/rf+s=
X-Google-Smtp-Source: AGHT+IH4QlBz9vR7ImcSMQlSfNJ2oKhijJNtonLY5ZBhI3jEsyhkhVwADQ8VbSAyTP7E7KujPWjL7HMMSeVYGWAmS30=
X-Received: by 2002:aa7:c907:0:b0:543:cc90:cb8b with SMTP id
 b7-20020aa7c907000000b00543cc90cb8bmr593854edt.2.1700612864077; Tue, 21 Nov
 2023 16:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20231023221250.116500-1-robdclark@gmail.com> <CAA8EJpqVL5U7yaZsG5F=q7EFP1bsApySdjycywox6cZUd8JqdA@mail.gmail.com>
 <CAF6AEGvbKjHYU6qv4v3017DguEye23yMoYvTbEo=JZ+QW3=Atg@mail.gmail.com>
 <CAA8EJprRdezFBP=+aBinA-=tbTGWPcj-izOthA=cbehes0UYng@mail.gmail.com>
 <d003384d-3b4b-da05-f4b7-8497749fc843@quicinc.com> <dd928ef1-e329-37e0-d383-444a64ef2bc5@quicinc.com>
In-Reply-To: <dd928ef1-e329-37e0-d383-444a64ef2bc5@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 21 Nov 2023 17:27:30 -0700
Message-ID: <CAF6AEGuxoSaX67iYuhWiaoPQMwh_ggE0ZGbgmLZ-QhmS4FYxtg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Fix encoder CRC to account for CTM enablement
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        freedreno@lists.freedesktop.org,
        Jeykumar Sankaran <quic_jeykumar@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Arnaud Vrac <rawoul@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 4:41=E2=80=AFPM Abhinav Kumar <quic_abhinavk@quicin=
c.com> wrote:
>
>
>
> On 10/24/2023 12:01 PM, Abhinav Kumar wrote:
> >
> >
> > On 10/23/2023 4:03 PM, Dmitry Baryshkov wrote:
> >> On Tue, 24 Oct 2023 at 01:36, Rob Clark <robdclark@gmail.com> wrote:
> >>>
> >>> On Mon, Oct 23, 2023 at 3:30=E2=80=AFPM Dmitry Baryshkov
> >>> <dmitry.baryshkov@linaro.org> wrote:
> >>>>
> >>>> On Tue, 24 Oct 2023 at 01:12, Rob Clark <robdclark@gmail.com> wrote:
> >>>>>
> >>>>> From: Rob Clark <robdclark@chromium.org>
> >>>>>
> >>>>> Seems like we need to pick INPUT_SEL=3D1 when CTM is enabled.  But =
not
> >>>>> otherwise.
> >>>>>
> >>>>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>>>> ---
> >
> > I cannot find anything in the docs which suggest this solution is corre=
ct.
> >
> > Different blocks in the DPU pipeline have their own CRC (MISR) register=
s
> > like LM, intf etc.
> >
> > We dont need to change INPUT_SEL to tell DPU from which pipeline to tak=
e
> > the CRC from as each of them have their own registers.
> >
> > INPUT_SEL is controlling whether the CRC needs to be calculated over th=
e
> > entire display timings or only the active pixels. I am unable to tell a=
t
> > the moment why this is making a difference in this use-case.
> >
> > Since I am unable to find any documentation proving this solution is
> > correct so far, unfortunately I would hold this back till then.
> >
> > We will investigate this issue and report our findings on this thread o=
n
> > how to proceed.
> >
>
> Alright, we debugged and also found some more answers.
>
> The correct solution is indeed to set INPUT_SEL =3D 1 but let me explain
> why and what should be the correct way.
>
> INPUT_SEL was indeed telling whether to compute CRC over active pixels
> or active pixels + timings like I wrote before but this behavior changed
> since some chipsets.
>
> Now, INPUT_SEL =3D 0 means compute CRC *only* over timings and not the
> active area (and not display + timings like before) and like mentioned
> before this has nothing to do with what is the input to the CRC. Not
> covering the active area will not change the CRC at all as Rob reported
> but its not specific to CTM.
>
> Which means we should have been setting INPUT_SEL=3D1 whenever we use INT=
F
> CRC irrespective of whether CTM is used or not.
>
> What this also means is INTF CRC was not working correctly at all so far
> irrespecive of CTM or not because it was always computing CRC only on
> the timings (non-active area).
>
> This was not caught so far because it looks like IGT's
> kms_pipe_crc_basic test which was used to validate this only compares
> CRC between two frames of the same content to match if they were equal
> and not changing contents and comparing like kms_plane does. It will
> pass as CRC would not have changed.
>
> Now coming to the fix, the reset value of this register INTF_MISR_CTRL
> already sets the INPUT_SEL bit (or unsets it) correctly based on
> whichever DPU version is used so we should just change the
> dpu_hw_setup_misr() to a read on the register followed by ORing the
> required bits without touching INPUT_SEL and write.
>
> That will address this issue and also cover version control since the
> expected value of this bit has changed across DPU revisions.

Ok, thanks for following up on this.  Mind posting a patch to
supersede this one?

BR,
-R

> >>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 2 +-
> >>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 ++--
> >>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h | 3 ++-
> >>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 4 ++--
> >>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h | 2 +-
> >>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c   | 2 +-
> >>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 5 ++++-
> >>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h | 3 ++-
> >>>>>   8 files changed, 15 insertions(+), 10 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >>>>> index 2b83a13b3aa9..d93a92ffd5df 100644
> >>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> >>>>> @@ -134,7 +134,7 @@ static void dpu_crtc_setup_encoder_misr(struct
> >>>>> drm_crtc *crtc)
> >>>>>          struct drm_encoder *drm_enc;
> >>>>>
> >>>>>          drm_for_each_encoder_mask(drm_enc, crtc->dev,
> >>>>> crtc->state->encoder_mask)
> >>>>> -               dpu_encoder_setup_misr(drm_enc);
> >>>>> +               dpu_encoder_setup_misr(drm_enc, !!crtc->state->ctm)=
;
> >>>>>   }
> >>>>>
> >>>>>   static int dpu_crtc_set_crc_source(struct drm_crtc *crtc, const
> >>>>> char *src_name)
> >>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >>>>> index b0a7908418ed..12ee7acb5ea6 100644
> >>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >>>>> @@ -241,7 +241,7 @@ int dpu_encoder_get_crc_values_cnt(const struct
> >>>>> drm_encoder *drm_enc)
> >>>>>          return num_intf;
> >>>>>   }
> >>>>>
> >>>>> -void dpu_encoder_setup_misr(const struct drm_encoder *drm_enc)
> >>>>> +void dpu_encoder_setup_misr(const struct drm_encoder *drm_enc,
> >>>>> bool has_ctm)
> >>>>>   {
> >>>>>          struct dpu_encoder_virt *dpu_enc;
> >>>>>
> >>>>> @@ -255,7 +255,7 @@ void dpu_encoder_setup_misr(const struct
> >>>>> drm_encoder *drm_enc)
> >>>>>                  if (!phys->hw_intf || !phys->hw_intf->ops.setup_mi=
sr)
> >>>>>                          continue;
> >>>>>
> >>>>> -               phys->hw_intf->ops.setup_misr(phys->hw_intf, true, =
1);
> >>>>> +               phys->hw_intf->ops.setup_misr(phys->hw_intf, true,
> >>>>> 1, has_ctm);
> >>>>>          }
> >>>>>   }
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> >>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> >>>>> index 4c05fd5e9ed1..510783b2fb24 100644
> >>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> >>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> >>>>> @@ -169,8 +169,9 @@ int dpu_encoder_get_crc_values_cnt(const struct
> >>>>> drm_encoder *drm_enc);
> >>>>>   /**
> >>>>>    * dpu_encoder_setup_misr - enable misr calculations
> >>>>>    * @drm_enc:    Pointer to previously created drm encoder structu=
re
> >>>>> + * @has_ctm:    Is CTM enabled
> >>>>>    */
> >>>>> -void dpu_encoder_setup_misr(const struct drm_encoder *drm_encoder)=
;
> >>>>> +void dpu_encoder_setup_misr(const struct drm_encoder *drm_encoder,
> >>>>> bool has_ctm);
> >>>>>
> >>>>>   /**
> >>>>>    * dpu_encoder_get_crc - get the crc value from interface blocks
> >>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> >>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> >>>>> index e8b8908d3e12..cb06f80cc671 100644
> >>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> >>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> >>>>> @@ -318,9 +318,9 @@ static u32 dpu_hw_intf_get_line_count(struct
> >>>>> dpu_hw_intf *intf)
> >>>>>          return DPU_REG_READ(c, INTF_LINE_COUNT);
> >>>>>   }
> >>>>>
> >>>>> -static void dpu_hw_intf_setup_misr(struct dpu_hw_intf *intf, bool
> >>>>> enable, u32 frame_count)
> >>>>> +static void dpu_hw_intf_setup_misr(struct dpu_hw_intf *intf, bool
> >>>>> enable, u32 frame_count, bool has_ctm)
> >>>>>   {
> >>>>> -       dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL, enable,
> >>>>> frame_count);
> >>>>> +       dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL, enable,
> >>>>> frame_count, has_ctm);
> >>>>
> >>>> I'm not sure about the dpu_encoder and dpu_hw_intf interfaces. But
> >>>> dpu_hw_setup_misr definitely needs the `u8 input_sel` parameter
> >>>> instead of `bool has_ctm`.
> >>>
> >>> That seems a bit premature without knowing what the other values are.
> >>> (And I also question a bit the whole abstraction layer thing if it is
> >>> taking directly register bitfield enum's..)
> >>
> >> dpu_hw_intf and especially dpu_hw_util are not real abstractions. I
> >> always viewed them as useful low-level helpers.
> >>
> >> I think that has_ctm is valid at the dpu_encoder level, which selects
> >> which input to use. on the lower levels has_ctm doesn't make sense.
> >> IOW dpu_hw_setup_misr can be used to setup MISR for other blocks,
> >> where CTM doesn't exist.
> >>
> >>>
> >>> BR,
> >>> -R
> >>>
> >>>> Most likely, I'd use u8 for dpu_hw_intf operation too.
> >>>>
> >>>> Could you please adjust?
> >>>>
> >>>>>   }
> >>>>>
> >>>>>   static int dpu_hw_intf_collect_misr(struct dpu_hw_intf *intf, u32
> >>>>> *misr_value)
> >>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> >>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> >>>>> index c539025c418b..95aafc4cf58e 100644
> >>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> >>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> >>>>> @@ -95,7 +95,7 @@ struct dpu_hw_intf_ops {
> >>>>>
> >>>>>          void (*bind_pingpong_blk)(struct dpu_hw_intf *intf,
> >>>>>                          const enum dpu_pingpong pp);
> >>>>> -       void (*setup_misr)(struct dpu_hw_intf *intf, bool enable,
> >>>>> u32 frame_count);
> >>>>> +       void (*setup_misr)(struct dpu_hw_intf *intf, bool enable,
> >>>>> u32 frame_count, bool has_ctm);
> >>>>>          int (*collect_misr)(struct dpu_hw_intf *intf, u32
> >>>>> *misr_value);
> >>>>>
> >>>>>          // Tearcheck on INTF since DPU 5.0.0
> >>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> >>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> >>>>> index d1c3bd8379ea..2efe29396c6a 100644
> >>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> >>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> >>>>> @@ -83,7 +83,7 @@ static void dpu_hw_lm_setup_border_color(struct
> >>>>> dpu_hw_mixer *ctx,
> >>>>>
> >>>>>   static void dpu_hw_lm_setup_misr(struct dpu_hw_mixer *ctx, bool
> >>>>> enable, u32 frame_count)
> >>>>>   {
> >>>>> -       dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, enable,
> >>>>> frame_count);
> >>>>> +       dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, enable,
> >>>>> frame_count, false);
> >>>>>   }
> >>>>>
> >>>>>   static int dpu_hw_lm_collect_misr(struct dpu_hw_mixer *ctx, u32
> >>>>> *misr_value)
> >>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >>>>> index 9d2273fd2fed..528b8439209f 100644
> >>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >>>>> @@ -483,7 +483,7 @@ void _dpu_hw_setup_qos_lut(struct
> >>>>> dpu_hw_blk_reg_map *c, u32 offset,
> >>>>>
> >>>>>   void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
> >>>>>                  u32 misr_ctrl_offset,
> >>>>> -               bool enable, u32 frame_count)
> >>>>> +               bool enable, u32 frame_count, bool has_ctm)
> >>>>>   {
> >>>>>          u32 config =3D 0;
> >>>>>
> >>>>> @@ -496,6 +496,9 @@ void dpu_hw_setup_misr(struct
> >>>>> dpu_hw_blk_reg_map *c,
> >>>>>                  config =3D (frame_count & MISR_FRAME_COUNT_MASK) |
> >>>>>                          MISR_CTRL_ENABLE | MISR_CTRL_FREE_RUN_MASK=
;
> >>>>>
> >>>>> +               if (!has_ctm)
> >>>>> +                       config |=3D 1 << 24;
> >>>>
> >>>> Please define MISR_CTRL_INPUT_SEL instead.
> >>>>
> >>>>> +
> >>>>>                  DPU_REG_WRITE(c, misr_ctrl_offset, config);
> >>>>>          } else {
> >>>>>                  DPU_REG_WRITE(c, misr_ctrl_offset, 0);
> >>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >>>>> index 1f6079f47071..e42d9d00e40e 100644
> >>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >>>>> @@ -360,7 +360,8 @@ void _dpu_hw_setup_qos_lut(struct
> >>>>> dpu_hw_blk_reg_map *c, u32 offset,
> >>>>>   void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
> >>>>>                  u32 misr_ctrl_offset,
> >>>>>                  bool enable,
> >>>>> -               u32 frame_count);
> >>>>> +               u32 frame_count,
> >>>>> +               bool has_ctm);
> >>>>>
> >>>>>   int dpu_hw_collect_misr(struct dpu_hw_blk_reg_map *c,
> >>>>>                  u32 misr_ctrl_offset,
> >>>>> --
> >>>>> 2.41.0
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> With best wishes
> >>>> Dmitry
> >>
> >>
> >>
