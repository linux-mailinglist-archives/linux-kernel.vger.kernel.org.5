Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571CA7664F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjG1HMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjG1HLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:11:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9D83A97
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:11:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso11967325ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690528290; x=1691133090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lo54+yWragSmeKgpkSpHJTgxsew/IgV3Y602/TVZ78w=;
        b=k4Am5amDswNYQdSrBmX38fi3E/LBdpEUnmnifueSu04X4h0nz8XXRLbZb77UCJqd0r
         +a+wcZAo86tWPhz4IasXX5i4Qj+iQH9F6LF556VKC3JV0jDEybZf2hMCbnC42Cw0j6tq
         vlmZXvyY3Kr0z71xL43tfhETybuvQEIiRBLZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690528290; x=1691133090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lo54+yWragSmeKgpkSpHJTgxsew/IgV3Y602/TVZ78w=;
        b=EI3IA+9wd52qcxQiof09YJTpW7lMFG/SNdqqTACIwttq7/KVkyiXC5agKsGmzKFfPm
         3Dh6F0qYDlM+twMmlHANMop/BSSwn6nP9QK91mG44UpmqgLIiKyxE133kXMmMK+UYmaO
         Qm4kACpwP3oyq2jdM58809Rnb6zwU+f1ta7yM4AYWva6QmK8LXH8ptE+7PNp+vXn9i6t
         kbF/8nB209ZGqVQNCHD1RkEKsWWI1P9jICVrEKEAzravJ+Mnoc/owj9/B1QINlDAWfAd
         FN1ArpaCT2GGCyXuU77eKy6Ni3yTytybuEZoep+Cl2PQL4sQu5Fxc5Zr6Z2BeI9mjIJi
         i4tA==
X-Gm-Message-State: ABy/qLb82YM9KSUbNzgTkkfnU5OG0QctVLZAE2eFbXRFrXKrQRLXt33O
        IooWXND4V8JqiotF3miU8bILTNt8PzZFgvbliyKktJuDq98=
X-Google-Smtp-Source: APBJJlGBqkH29VjFvQj4clzOe/i5adQvrBVcAHbgkTvxpo0eMZVrTzsGGmYswoVcGJOF7EGjOdM7DQ==
X-Received: by 2002:a17:902:e741:b0:1b0:307c:e6fe with SMTP id p1-20020a170902e74100b001b0307ce6femr702075plf.10.1690528289752;
        Fri, 28 Jul 2023 00:11:29 -0700 (PDT)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902ee4600b001b8a3a0c928sm2812646plo.181.2023.07.28.00.11.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:11:29 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6862842a028so1321281b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:11:29 -0700 (PDT)
X-Received: by 2002:a0c:e404:0:b0:63d:77d:be74 with SMTP id
 o4-20020a0ce404000000b0063d077dbe74mr1524669qvl.59.1690527845580; Fri, 28 Jul
 2023 00:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-5-benjamin.gaignard@collabora.com> <e7444263-0ce5-1575-8cca-1e51b1cfbe9a@synaptics.com>
 <5cb3f216-5041-a155-5d2c-059dc1f15024@collabora.com> <25b21252-0d3a-3e50-0012-57055f386fee@synaptics.com>
 <20230712104801.tgawhexpm53ocgd6@chromium.org> <2d239d33-b05d-1b51-2268-43b2839b64ea@synaptics.com>
 <CAAFQd5D7oNG8oZB66qEW720fR79paw_q0LGBg7X4jK-ZkgYD_g@mail.gmail.com> <f6a3e3e5-14be-6d5c-48d3-009424e1a49a@synaptics.com>
In-Reply-To: <f6a3e3e5-14be-6d5c-48d3-009424e1a49a@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 28 Jul 2023 16:03:54 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D3NUqvkJFYgystFVFRQvq-5S0ZNUOrv1LJqmCA_8+a_w@mail.gmail.com>
Message-ID: <CAAFQd5D3NUqvkJFYgystFVFRQvq-5S0ZNUOrv1LJqmCA_8+a_w@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] media: videobuf2: Stop define VB2_MAX_FRAME as global
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, linux-staging@lists.linux.dev,
        ming.qian@nxp.com, kernel@collabora.com,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 3:55=E2=80=AFPM Hsia-Jun Li <Randy.Li@synaptics.com=
> wrote:
>
>
>
> On 7/28/23 14:46, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > On Mon, Jul 17, 2023 at 4:44=E2=80=AFPM Hsia-Jun Li <Randy.Li@synaptics=
.com> wrote:
> >>
> >>
> >> On 7/12/23 18:48, Tomasz Figa wrote:
> >>> CAUTION: Email originated externally, do not click links or open atta=
chments unless you recognize the sender and know the content is safe.
> >>>
> >>>
> >>> On Mon, Jul 03, 2023 at 04:35:30PM +0800, Hsia-Jun Li wrote:
> >>>> On 7/3/23 16:09, Benjamin Gaignard wrote:
> >>>>> CAUTION: Email originated externally, do not click links or open
> >>>>> attachments unless you recognize the sender and know the content is
> >>>>> safe.
> >>>>>
> >>>>>
> >>>>> Le 30/06/2023 =C3=A0 11:51, Hsia-Jun Li a =C3=A9crit :
> >>>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
> >>>>>>> CAUTION: Email originated externally, do not click links or open
> >>>>>>> attachments unless you recognize the sender and know the content =
is
> >>>>>>> safe.
> >>>>>>>
> >>>>>>>
> >>>>>>> After changing bufs arrays to a dynamic allocated array
> >>>>>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
> >>>>>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI kerne=
l is
> >>>>>> more reasonable.
> >>>>>>
> >>>>>> It would be hard to iterate the whole array, it would go worse wit=
h a
> >>>>>> filter. Such iterate may need to go twice because you mix
> >>>>>> post-processing buffer and decoding buffer(with MV) in the same ar=
ray.
> >>>>> Here I don't want to change drivers behavior so I keep the same val=
ue.
> >>>>> If it happens that they need more buffers, like for dynamic resolut=
ion
> >>>>> change
> >>>>> feature for Verisilicon VP9 decoder, case by case patches will be n=
eeded.
> >>>>>
> >>>> I just don't like the idea that using a variant length array here.
> >>>>
> >>> "I don't like" is not an argument. We had a number of arguments for
> >>> using a generic helper (originally idr, but later decided to go with
> >>> XArray, because the former is now deprecated) that we pointed out in
> >>> our review comments for previous revisions. It wasn't really about th=
e
> >>> size being variable, but rather avoiding open coding things in vb2 an=
d
> >>> duplicating what's already implemented in generic code.
> >>
> >> I just want to say I don't think we need a variable length array to
> >> store the buffer here.
> >>
> >> And the below is the reason that such a case could be avoided in the
> >> first place.
> >>
> >>>
> >>>> And I could explain why you won't need so many buffers for the perfo=
rmance
> >>>> of decoding.
> >>>>
> >>>> VP9 could support 10 reference frames in dpb.
> >>>>
> >>>> Even for those frequent resolution changing test set, it would only =
happen
> >>>> to two resolutions,
> >>>>
> >>>> 32 would be enough for 20 buffers of two resolution plus golden fram=
es. It
> >>>> also leaves enough slots for re-order latency.
> >>>>
> >>>> If your case had more two resolutions, likes low->medium->high.
> >>>>
> >>>> I would suggest just skip the medium resolutions, just allocate the =
lower
> >>>> one first for fast playback then the highest for all the possible
> >>>>
> >>>> medium cases. Reallocation happens frequently would only cause memor=
y
> >>>> fragment, nothing benefits your performance.
> >>>>
> >>> We have mechanisms in the kernel to deal with memory fragmentation
> >>> (migration/compaction) and it would still only matters for the
> >>> pathologic cases of hardware that require physically contiguous memor=
y.
> >>> Modern hardware with proper DMA capabilities can either scatter-gathe=
r
> >>> or are equipped with an IOMMU, so the allocation always happens in pa=
ge
> >>> granularity and fragmentation is avoided.
> >>
> >> Unfortunately, there are more devices that didn't have a IOMMU attache=
d
> >> to it, supporting scatter gather is more odd.
> >>
> >> It would be more likely that IOMMU would be disabled for the performan=
ce
> >> reason.
> >
> > These days IOMMU is totally mandatory if you want to think about
> > having any level of security in your system. Sure, there could be some
> > systems that are completely isolated from any external environment,
> > like some offline industry automation machines, but then arguably
> > their running conditions would also be quite static and require very
> > little memory re-allocation.
> Vendor just decided not to included such hardware.
> That is why From ION to DMA-heap, people like to allocate from a cavout
> out memory.
> >
> > I also don't buy the performance reason. CPUs have been behind MMUs
> > for ages and nobody is running them with paging disabled for
> > performance reasons. Similarly, most of the modern consumer systems
> Page lookup would increase the delay. Besides a few upstream devices
> prove them only use a level 1 page table without TBL.

That's just an excuse for a bad hardware design/implementation. As I
said, there are good IOMMU implementations out there that don't suffer
from performance issues.

> > (mobile phones, PCs) run with IOMMUs enabled for pretty much anything
> > because of the security reason and they don't seem to be having any
> If the page is secure, you can't operate it in a insecure IOMMU or MMU.
> The most security way here, we should use a dedicated memory(or a zone
> in unified memory).

You still need something to enforce that the hardware is not accessing
memory that it's not supposed to access. How do you do that without an
IOMMU?

> I believe there are more users in mobile for DMA-heap than kernel's dma
> allocation API.

Yes, but that's completely separate from whether there is an IOMMU or
not. It's just a different allocation API.

> > performance issues. In fact, it can improve the performance, because
> > memory allocation is much easier and without contiguous careouts (as
> > we used to have long ago on Android devices) the extra memory can be
> > used for buffers and caches to improve system performance.
> >
> > Best regards,
> > Tomasz
> >
> >>
> >>>
> >>> Best regards,
> >>> Tomasz
> >>>
> >>>>>>> Remove it from the core definitions but keep it for drivers inter=
nal
> >>>>>>> needs.
> >>>>>>>
> >>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com=
>
> >>>>>>> ---
> >>>>>>>     drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
> >>>>>>>     drivers/media/platform/amphion/vdec.c | 1 +
> >>>>>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2=
 ++
> >>>>>>>     drivers/media/platform/qcom/venus/hfi.h | 2 ++
> >>>>>>>     drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
> >>>>>>>     drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
> >>>>>>>     include/media/videobuf2-core.h | 1 -
> >>>>>>>     include/media/videobuf2-v4l2.h | 4 ----
> >>>>>>>     8 files changed, 11 insertions(+), 5 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>>> index 86e1e926fa45..899783f67580 100644
> >>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>>>>> @@ -31,6 +31,8 @@
> >>>>>>>
> >>>>>>>     #include <trace/events/vb2.h>
> >>>>>>>
> >>>>>>> +#define VB2_MAX_FRAME  32
> >>>>>>> +
> >>>>>>>     static int debug;
> >>>>>>>     module_param(debug, int, 0644);
> >>>>>>>
> >>>>>>> diff --git a/drivers/media/platform/amphion/vdec.c
> >>>>>>> b/drivers/media/platform/amphion/vdec.c
> >>>>>>> index 3fa1a74a2e20..b3219f6d17fa 100644
> >>>>>>> --- a/drivers/media/platform/amphion/vdec.c
> >>>>>>> +++ b/drivers/media/platform/amphion/vdec.c
> >>>>>>> @@ -28,6 +28,7 @@
> >>>>>>>
> >>>>>>>     #define VDEC_MIN_BUFFER_CAP            8
> >>>>>>>     #define VDEC_MIN_BUFFER_OUT            8
> >>>>>>> +#define VB2_MAX_FRAME                  32
> >>>>>>>
> >>>>>>>     struct vdec_fs_info {
> >>>>>>>            char name[8];
> >>>>>>> diff --git
> >>>>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if=
.c
> >>>>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if=
.c
> >>>>>>> index 6532a69f1fa8..a1e0f24bb91c 100644
> >>>>>>> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_la=
t_if.c
> >>>>>>> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_la=
t_if.c
> >>>>>>> @@ -16,6 +16,8 @@
> >>>>>>>     #include "../vdec_drv_if.h"
> >>>>>>>     #include "../vdec_vpu_if.h"
> >>>>>>>
> >>>>>>> +#define VB2_MAX_FRAME  32
> >>>>>>> +
> >>>>>>>     /* reset_frame_context defined in VP9 spec */
> >>>>>>>     #define VP9_RESET_FRAME_CONTEXT_NONE0 0
> >>>>>>>     #define VP9_RESET_FRAME_CONTEXT_NONE1 1
> >>>>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
> >>>>>>> b/drivers/media/platform/qcom/venus/hfi.h
> >>>>>>> index f25d412d6553..bd5ca5a8b945 100644
> >>>>>>> --- a/drivers/media/platform/qcom/venus/hfi.h
> >>>>>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
> >>>>>>> @@ -10,6 +10,8 @@
> >>>>>>>
> >>>>>>>     #include "hfi_helper.h"
> >>>>>>>
> >>>>>>> +#define VB2_MAX_FRAME                          32
> >>>>>>> +
> >>>>>>>     #define VIDC_SESSION_TYPE_VPE                  0
> >>>>>>>     #define VIDC_SESSION_TYPE_ENC                  1
> >>>>>>>     #define VIDC_SESSION_TYPE_DEC                  2
> >>>>>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>>>> b/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>>>> index e83f0c523a30..9e8faf7ba6fb 100644
> >>>>>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> >>>>>>> @@ -15,6 +15,8 @@
> >>>>>>>     #include <media/v4l2-vp9.h>
> >>>>>>>     #include <media/videobuf2-core.h>
> >>>>>>>
> >>>>>>> +#define VB2_MAX_FRAME  32
> >>>>>>> +
> >>>>>>>     #define DEC_8190_ALIGN_MASK    0x07U
> >>>>>>>
> >>>>>>>     #define MB_DIM                 16
> >>>>>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>>>> index e530767e80a5..6627b5c2d4d6 100644
> >>>>>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> >>>>>>> @@ -10,6 +10,8 @@
> >>>>>>>     #include "ipu3.h"
> >>>>>>>     #include "ipu3-dmamap.h"
> >>>>>>>
> >>>>>>> +#define VB2_MAX_FRAME  32
> >>>>>>> +
> >>>>>>>     /******************** v4l2_subdev_ops ********************/
> >>>>>>>
> >>>>>>>     #define IPU3_RUNNING_MODE_VIDEO                0
> >>>>>>> diff --git a/include/media/videobuf2-core.h
> >>>>>>> b/include/media/videobuf2-core.h
> >>>>>>> index 77921cf894ef..080b783d608d 100644
> >>>>>>> --- a/include/media/videobuf2-core.h
> >>>>>>> +++ b/include/media/videobuf2-core.h
> >>>>>>> @@ -20,7 +20,6 @@
> >>>>>>>     #include <media/media-request.h>
> >>>>>>>     #include <media/frame_vector.h>
> >>>>>>>
> >>>>>>> -#define VB2_MAX_FRAME  (32)
> >>>>>>>     #define VB2_MAX_PLANES (8)
> >>>>>>>
> >>>>>>>     /**
> >>>>>>> diff --git a/include/media/videobuf2-v4l2.h
> >>>>>>> b/include/media/videobuf2-v4l2.h
> >>>>>>> index 5a845887850b..88a7a565170e 100644
> >>>>>>> --- a/include/media/videobuf2-v4l2.h
> >>>>>>> +++ b/include/media/videobuf2-v4l2.h
> >>>>>>> @@ -15,10 +15,6 @@
> >>>>>>>     #include <linux/videodev2.h>
> >>>>>>>     #include <media/videobuf2-core.h>
> >>>>>>>
> >>>>>>> -#if VB2_MAX_FRAME !=3D VIDEO_MAX_FRAME
> >>>>>>> -#error VB2_MAX_FRAME !=3D VIDEO_MAX_FRAME
> >>>>>>> -#endif
> >>>>>>> -
> >>>>>>>     #if VB2_MAX_PLANES !=3D VIDEO_MAX_PLANES
> >>>>>>>     #error VB2_MAX_PLANES !=3D VIDEO_MAX_PLANES
> >>>>>>>     #endif
> >>>>>>> --
> >>>>>>> 2.39.2
> >>>>>>>
> >>>> --
> >>>> Hsia-Jun(Randy) Li
> >>>>
> >> --
> >> Hsia-Jun(Randy) Li
> >>
>
> --
> Hsia-Jun(Randy) Li
