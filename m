Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A097F1BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjKTSJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKTSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:09:54 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B6CB9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:09:50 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b512dd7d5bso3379445b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700503789; x=1701108589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1JrAippIOjd//vYzGyHU8g1IP/pfT07LStfr2qyMeA=;
        b=NF9IUYJNBGBtMu+FyIooXTaDXBKpBPYw47Q9tlbUKPr+PG7/+Q28p4TnBMtFY5c+OW
         e+m0TQDA526GbD2cN3ftYxFegkHj120gsvoAxAmMmukY1popq+RMRIVgIEs0qklGwKnk
         W6FmVXfinAVvkxyT1HjOxsw18HT50DMpWguvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700503789; x=1701108589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1JrAippIOjd//vYzGyHU8g1IP/pfT07LStfr2qyMeA=;
        b=KF7CotL9SOfBD8xUh9lj/yoYUgqtR4rRd1pyhZwFIYa3OUDnxFQlsMME2z09w6NMh5
         fsBXH2ZRHPFYykT25j/6sXqx2RZ0eDZ9GGqBlnd9HK/xeev/tXlRi0AJvQk6VD6m+zPz
         nkteQiaBHXxO+vyCZ5sBB3qx6rAGC03i0rSH/sNkj/40ZRAk8KGOKVS3osGIXBY/MHEu
         xvcvoIXUrWv0nzTnpX4HFIG5AO7ankDNo4bGdlKoLWZ6ha1/zYxtpSuWsaMdTz6cOpkJ
         Ad518BqdIYEp9TIgHOMxLtuAhMdURBtqzqI2x/KlZAry2+tHblSocDTIo2ZdtI7nCKqO
         hfBw==
X-Gm-Message-State: AOJu0YxM4+UKKCFH9azMzcoXDd6L8fU9JDesG1TmlnR0qiiZVVNdV6IP
        e2OLlihewVVzh0Nrd5H5kELyhfqXm8v+7Zol/bdsoA==
X-Google-Smtp-Source: AGHT+IE3Q9YiKdhHPw+dqEdWTa+pQ92eiDhjOS0WgdjcPjtkQ5goA6t+HxA002o60utb8wpT1n9dfexSqU/MoTh/ET4=
X-Received: by 2002:a05:6358:cc1a:b0:16d:e598:4f54 with SMTP id
 gx26-20020a056358cc1a00b0016de5984f54mr1411738rwb.29.1700503789423; Mon, 20
 Nov 2023 10:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20231004103720.3540436-1-hugues.fruchet@foss.st.com>
 <20231004103720.3540436-2-hugues.fruchet@foss.st.com> <CAC-pXoMMsvNG2PCzKbgmBNev6dmPhJb15hJi=W=fki4cSZcupg@mail.gmail.com>
 <300cd83a-eb15-44c8-a15f-acbbbe850fe8@collabora.com>
In-Reply-To: <300cd83a-eb15-44c8-a15f-acbbbe850fe8@collabora.com>
From:   Steve Cho <stevecho@chromium.org>
Date:   Mon, 20 Nov 2023 10:09:38 -0800
Message-ID: <CAC-pXoMERLQuOKNtM81PM2uJszgXCrR22EDjMKFEQ72u9t8++Q@mail.gmail.com>
Subject: Re: [RFC 1/6] media: uapi: Add VP8 stateless encoder controls
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Andrzej for the follow up!

On Mon, Nov 20, 2023 at 8:43=E2=80=AFAM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> Hi Steve,
>
> Thanks for looking into it,
>
> W dniu 14.11.2023 o 23:19, Steve Cho pisze:
> > Few comments.
> >
> >> +               if (p_vp8_encode_params->loop_filter_level > 63)
> >> +                       return -EINVAL;
> >> +
> >> +               if (p_vp8_encode_params->sharpness_level > 7)
> >> +                       return -EINVAL;
> >
> > Can we define these magic numbers 63, 7?
>
> ok
>
> >
> >
> >> +       case V4L2_CID_STATELESS_VP8_ENCODE_QP:                  return=
 "VP8 Encode QP";
> >
> > Can we add more details about this CID? Or let me know if I missed it
> > somewhere in the series.
>
> The documenation was missing indeed, which was mentioned in the cover let=
ter.
>
> >
> >
> >> +#define V4L2_CID_STATELESS_VP8_ENCODE_PARAMS   (V4L2_CID_CODEC_STATEL=
ESS_BASE + 601)
> >
> > Can we put 2 CIDs in the same place? I think it is more readable that
> > way. I also see that was the case for HEVC.
> > https://git.linuxtv.org/media_tree.git/tree/include/uapi/linux/v4l2-con=
trols.h?h=3Dmaster&id=3Dc91fd7b7a8ae17ab8be0b6e765e4a38783749330#n2062
>
> If there's "prior art" for that, I see no objections.
>
> >
> >
> >> + * @loop_filter_level: sets the strength of the applied loop filter.
> >> + *                    Set to a value from the rage 0..63.
> >
> > typo s/rage/range/
>
> Thanks for spotting it, this rage should be stopped ;)
>
> >
> >
> >> + * @copy_buffer_to_alternate: specifies the atlref frame refresh stra=
tegy.
> >> + *                           Set to one of V4L2_VP8_FRAME_FLAG_ALTREF=
_{}.
> >
> > nit: typo s/atlref/altref/
>
> Thanks!
>
> Regards,
>
> Andrzej
>
> >
> > On Wed, Oct 4, 2023 at 3:37=E2=80=AFAM Hugues Fruchet
> > <hugues.fruchet@foss.st.com> wrote:
> >>
> >> From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> >>
> >> Add uAPI for stateless VP8 encoders.
> >>
> >> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> >> ---
> >>   drivers/media/v4l2-core/v4l2-ctrls-core.c | 13 ++++
> >>   drivers/media/v4l2-core/v4l2-ctrls-defs.c |  5 ++
> >>   include/media/v4l2-ctrls.h                |  2 +
> >>   include/uapi/linux/v4l2-controls.h        | 91 +++++++++++++++++++++=
++
> >>   include/uapi/linux/videodev2.h            |  3 +
> >>   5 files changed, 114 insertions(+)
> >>
> >> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media=
/v4l2-core/v4l2-ctrls-core.c
> >> index a662fb60f73f..c7799ceb3d6d 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >> @@ -811,6 +811,7 @@ static int std_validate_compound(const struct v4l2=
_ctrl *ctrl, u32 idx,
> >>          struct v4l2_ctrl_hevc_pps *p_hevc_pps;
> >>          struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
> >>          struct v4l2_ctrl_hevc_decode_params *p_hevc_decode_params;
> >> +       struct v4l2_ctrl_vp8_encode_params *p_vp8_encode_params;
> >>          struct v4l2_area *area;
> >>          void *p =3D ptr.p + idx * ctrl->elem_size;
> >>          unsigned int i;
> >> @@ -1047,6 +1048,15 @@ static int std_validate_compound(const struct v=
4l2_ctrl *ctrl, u32 idx,
> >>                  zero_padding(p_vp8_frame->coder_state);
> >>                  break;
> >>
> >> +       case V4L2_CTRL_TYPE_VP8_ENCODE_PARAMS:
> >> +               p_vp8_encode_params =3D p;
> >> +               if (p_vp8_encode_params->loop_filter_level > 63)
> >> +                       return -EINVAL;
> >> +
> >> +               if (p_vp8_encode_params->sharpness_level > 7)
> >> +                       return -EINVAL;
> >> +               break;
> >> +
> >>          case V4L2_CTRL_TYPE_HEVC_SPS:
> >>                  p_hevc_sps =3D p;
> >>
> >> @@ -1868,6 +1878,9 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4=
l2_ctrl_handler *hdl,
> >>          case V4L2_CTRL_TYPE_AREA:
> >>                  elem_size =3D sizeof(struct v4l2_area);
> >>                  break;
> >> +       case V4L2_CTRL_TYPE_VP8_ENCODE_PARAMS:
> >> +               elem_size =3D sizeof(struct v4l2_ctrl_vp8_encode_param=
s);
> >> +               break;
> >>          default:
> >>                  if (type < V4L2_CTRL_COMPOUND_TYPES)
> >>                          elem_size =3D sizeof(s32);
> >> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media=
/v4l2-core/v4l2-ctrls-defs.c
> >> index 8696eb1cdd61..bd26f1d89bd5 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> @@ -1236,6 +1236,8 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>          case V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY:           retur=
n "AV1 Tile Group Entry";
> >>          case V4L2_CID_STATELESS_AV1_FRAME:                      retur=
n "AV1 Frame Parameters";
> >>          case V4L2_CID_STATELESS_AV1_FILM_GRAIN:                 retur=
n "AV1 Film Grain";
> >> +       case V4L2_CID_STATELESS_VP8_ENCODE_PARAMS:              return=
 "VP8 Encode Parameters";
> >> +       case V4L2_CID_STATELESS_VP8_ENCODE_QP:                  return=
 "VP8 Encode QP";
> >>
> >>          /* Colorimetry controls */
> >>          /* Keep the order of the 'case's the same as in v4l2-controls=
.h! */
> >> @@ -1592,6 +1594,9 @@ void v4l2_ctrl_fill(u32 id, const char **name, e=
num v4l2_ctrl_type *type,
> >>          case V4L2_CID_STATELESS_AV1_FILM_GRAIN:
> >>                  *type =3D V4L2_CTRL_TYPE_AV1_FILM_GRAIN;
> >>                  break;
> >> +       case V4L2_CID_STATELESS_VP8_ENCODE_PARAMS:
> >> +               *type =3D V4L2_CTRL_TYPE_VP8_ENCODE_PARAMS;
> >> +               break;
> >>          case V4L2_CID_UNIT_CELL_SIZE:
> >>                  *type =3D V4L2_CTRL_TYPE_AREA;
> >>                  *flags |=3D V4L2_CTRL_FLAG_READ_ONLY;
> >> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
> >> index 59679a42b3e7..a165719e1139 100644
> >> --- a/include/media/v4l2-ctrls.h
> >> +++ b/include/media/v4l2-ctrls.h
> >> @@ -56,6 +56,7 @@ struct video_device;
> >>    * @p_av1_tile_group_entry:    Pointer to an AV1 tile group entry st=
ructure.
> >>    * @p_av1_frame:               Pointer to an AV1 frame structure.
> >>    * @p_av1_film_grain:          Pointer to an AV1 film grain structur=
e.
> >> + * @p_vp8_encode_params:       Pointer to a VP8 encode parameter stru=
cture.
> >>    * @p:                         Pointer to a compound value.
> >>    * @p_const:                   Pointer to a constant compound value.
> >>    */
> >> @@ -89,6 +90,7 @@ union v4l2_ctrl_ptr {
> >>          struct v4l2_ctrl_av1_tile_group_entry *p_av1_tile_group_entry=
;
> >>          struct v4l2_ctrl_av1_frame *p_av1_frame;
> >>          struct v4l2_ctrl_av1_film_grain *p_av1_film_grain;
> >> +       struct v4l2_ctrl_vp8_encode_params *p_vp8_encode_params;
> >>          void *p;
> >>          const void *p_const;
> >>   };
> >> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v=
4l2-controls.h
> >> index c3604a0a3e30..fdec5764e09c 100644
> >> --- a/include/uapi/linux/v4l2-controls.h
> >> +++ b/include/uapi/linux/v4l2-controls.h
> >> @@ -3479,6 +3479,97 @@ struct v4l2_ctrl_av1_film_grain {
> >>          __u8 reserved[4];
> >>   };
> >>
> >> +#define V4L2_CID_STATELESS_VP8_ENCODE_PARAMS   (V4L2_CID_CODEC_STATEL=
ESS_BASE + 601)
> >> +
> >> +#define V4L2_VP8_FRAME_FLAG_SHOWFRAME                  0x1
> >> +#define V4L2_VP8_FRAME_FLAG_GOLDEN_REFRESH             0x2
> >> +#define V4L2_VP8_FRAME_FLAG_ALTREF_REFRESH             0x4
> >> +#define V4L2_VP8_FRAME_FLAG_SEGMENT_ENABLED            0x8
> >> +#define V4L2_VP8_FRAME_FLAG_LOOP_FILTER_ADJ_ENABLED    0x10
> >> +#define V4L2_VP8_FRAME_FLAG_REFRESH_ENTROPY_PROBS      0x20
> >> +
> >> +#define V4L2_VP8_FRAME_TYPE_KEYFRAME   0
> >> +#define V4L2_VP8_FRAME_TYPE_INTER      1
> >> +
> >> +#define V4L2_VP8_FRAME_COLOR_SPACE_YUV         0
> >> +#define V4L2_VP8_FRAME_COLOR_SPACE_RESERVED    1
> >> +
> >> +#define V4L2_VP8_FRAME_CLAMPING_REQUIRED       0
> >> +#define V4L2_VP8_FRAME_CLAMPING_NO             1
> >> +
> >> +#define V4L2_VP8_FRAME_FILTER_TYPE_NORMAL      0
> >> +#define V4L2_VP8_FRAME_FILTER_TYPE_SIMPLE      1
> >> +
> >> +#define V4L2_VP8_FRAME_NBR_DCT_PARTITIONS_1    0
> >> +#define V4L2_VP8_FRAME_NBR_DCT_PARTITIONS_2    1
> >> +#define V4L2_VP8_FRAME_NBR_DCT_PARTITIONS_4    2
> >> +#define V4L2_VP8_FRAME_NBR_DCT_PARTITIONS_8    3
> >> +
> >> +#define V4L2_VP8_FRAME_GOLDEN_KEEP             0
> >> +#define V4L2_VP8_FRAME_GOLDEN_LASTFRAME                1
> >> +#define V4L2_VP8_FRAME_GOLDEN_ALTREF           2
> >> +
> >> +#define V4L2_VP8_FRAME_ALTREF_KEEP             0
> >> +#define V4L2_VP8_FRAME_ALTREF_LASTFRAME                1
> >> +#define V4L2_VP8_FRAME_ALTREF_GOLDEN           2
> >> +
> >> +#define V4L2_VP8_FRAME_REF_LAST                0
> >> +#define V4L2_VP8_FRAME_REF_GOLDEN      1
> >> +#define V4L2_VP8_FRAME_REF_ALT         2
> >> +
> >> +/**
> >> + * struct v4l2_ctrl_vp8_encode_params - VP8 encode parameters
> >> + * @flags: combination of V4L2_VP8_FRAME_FLAG_{} flags.
> >> + * @frame_type: specifies the frame type (key or inter).
> >> + *             Set to one of V4L2_VP8_FRAME_TYPE_{}.
> >> + * @color_space: defines the YUV color space of the sequence.
> >> + *              V4L2_VP8_FRAME_TYPE_INTER frames shall set this field=
 to zero.
> >> + *              Set to one of V4L2_VP8_FRAME_COLOR_SPACE_{}.
> >> + * @clamping_type: defines pixel value clamping type.
> >> + *                V4L2_VP8_FRAME_TYPE_INTER frames shall set this fie=
ld to zero.
> >> + *                Set to one of V4L2_VP8_FRAME_CLAMPING_{}.
> >> + * @loop_filter_type: selects the type of loop filter applied.
> >> + *                   Set to one of V4L2_VP8_FRAME_FILTER_TYPE_{}.
> >> + * @loop_filter_level: sets the strength of the applied loop filter.
> >> + *                    Set to a value from the rage 0..63.
> >> + * @sharpness_level: sets the sharpness of the applied loop filter.
> >> + *                  Set to a value from the range 0..7.
> >> + * @log2_nbr_of_dct_partitions: determines the number of separate par=
titions
> >> + *                             containing the DCT coefficients of mac=
roblocks.
> >> + *                             Set to one of V4L2_VP8_FRAME_NBR_DCT_P=
ARTITIONS_{}.
> >> + * @prob_intra: indicates the probability of an intra macroblock.
> >> + *             Set to a value from the range 0..255.
> >> + * @prob_last: indicates the probability that the last reference fram=
e is used for inter-prediction.
> >> + *            Set to a value from the range 0..255.
> >> + * @prob_gf: indicates the probability that the golden reference fram=
e is used for inter-prediction.
> >> + *          Set to a value from the range 0..255.
> >> + * @copy_buffer_to_golden: specifies the golden frame refresh strateg=
y.
> >> + *                        Set to one of V4L2_VP8_FRAME_FLAG_GOLDEN_{}=
.
> >> + * @copy_buffer_to_alternate: specifies the atlref frame refresh stra=
tegy.
> >> + *                           Set to one of V4L2_VP8_FRAME_FLAG_ALTREF=
_{}.
> >> + * @reference_type: specifies what kind of reference to use for curre=
nt inter frame.
> >> + *                 V4L2_VP8_FRAME_TYPE_KEYFRAME shall set this field =
to zero.
> >> + *                 Set to one of V4L2_VP8_FRAME_REF_{}.
> >> + */
> >> +struct v4l2_ctrl_vp8_encode_params {
> >> +       __u32 flags;
> >> +       __u8 frame_type;
> >> +       __u8 color_space;
> >> +       __u8 clamping_type;
> >> +       __u8 loop_filter_type;
> >> +       __u8 loop_filter_level;
> >> +       __u8 sharpness_level;
> >> +       __u8 log2_nbr_of_dct_partitions;
> >> +       __u8 prob_intra;
> >> +       __u8 prob_last;
> >> +       __u8 prob_gf;
> >> +       __u8 copy_buffer_to_golden;
> >> +       __u8 copy_buffer_to_alternate;
> >> +       __u8 reference_type;
> >> +};
> >> +
> >> +#define V4L2_CID_STATELESS_VP8_ENCODE_QP       (V4L2_CID_CODEC_STATEL=
ESS_BASE + 602)
> >> +
> >>   /* MPEG-compression definitions kept for backwards compatibility */
> >>   #ifndef __KERNEL__
> >>   #define V4L2_CTRL_CLASS_MPEG            V4L2_CTRL_CLASS_CODEC
> >> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/video=
dev2.h
> >> index 78260e5d9985..b3cbdc60b82c 100644
> >> --- a/include/uapi/linux/videodev2.h
> >> +++ b/include/uapi/linux/videodev2.h
> >> @@ -1836,6 +1836,7 @@ struct v4l2_ext_control {
> >>                  struct v4l2_ctrl_av1_tile_group_entry __user *p_av1_t=
ile_group_entry;
> >>                  struct v4l2_ctrl_av1_frame __user *p_av1_frame;
> >>                  struct v4l2_ctrl_av1_film_grain __user *p_av1_film_gr=
ain;
> >> +               struct v4l2_ctrl_vp8_encode_params __user *p_vp8_encod=
e_params;
> >>                  void __user *ptr;
> >>          };
> >>   } __attribute__ ((packed));
> >> @@ -1914,6 +1915,8 @@ enum v4l2_ctrl_type {
> >>          V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY =3D 0x281,
> >>          V4L2_CTRL_TYPE_AV1_FRAME            =3D 0x282,
> >>          V4L2_CTRL_TYPE_AV1_FILM_GRAIN       =3D 0x283,
> >> +
> >> +       V4L2_CTRL_TYPE_VP8_ENCODE_PARAMS        =3D 0x0290,
> >>   };
> >>
> >>   /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
> >> --
> >> 2.25.1
> >>
>
