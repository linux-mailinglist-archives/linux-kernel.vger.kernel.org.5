Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71F77A6AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjISSwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjISSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:52:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2439E;
        Tue, 19 Sep 2023 11:51:52 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 738F4660319E;
        Tue, 19 Sep 2023 19:51:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695149511;
        bh=6sSokaLi5kz8NXRC7glGXclGGj1EWHSaLsJx5BXj7iI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HmvoDtpQxHjZJBXFZjMoeANnXvDA3z5NuTBwoa6uXuAOVgFYyCxzlJJlrby2ZvVEJ
         FGkl331g/2pp+FIJgGab+gh1KV8W34CNI0AOhSzGrws/+1MUFLuI8hA8QQlek40gN7
         gyFlyE9nWOYMR/x1zThMeufNcihGO2zjFpS8MJ2y9qHyQxyp6cwClHtU9kfMXsR+S7
         P3thniIPkASd9SHIHurb99JLd1L6CFy63pvs8a+W0CFpt3zZqrW4lR2rUCFkRfMIsk
         t1rdH8XgOIHmb3ABpAsQjy0E/NPu0/3a+MMqqooPmQWrvyP3GoseVECaTgXGOxrXj3
         LGxuYzeXtYADA==
Message-ID: <b7d661637eacbda3e83d192b1126fc3970c4f50d.camel@collabora.com>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to
 decoder driver
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jeffrey Kardatzke <jkardatzke@google.com>
Cc:     Yunfei Dong =?UTF-8?Q?=28=E8=91=A3=E4=BA=91=E9=A3=9E=29?= 
        <Yunfei.Dong@mediatek.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 19 Sep 2023 14:51:41 -0400
In-Reply-To: <ff7aa575-c820-4dfa-853f-77438b8b149a@xs4all.nl>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-13-yunfei.dong@mediatek.com>
         <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
         <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl>
         <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
         <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
         <CA+ddPcN6EaFERC60_Z_-ZmWzqyUEwxiDCZwt_U6Y-gpaAu76tA@mail.gmail.com>
         <ff7aa575-c820-4dfa-853f-77438b8b149a@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 19 septembre 2023 =C3=A0 10:53 +0200, Hans Verkuil a =C3=A9crit=C2=
=A0:
> On 18/09/2023 22:57, Jeffrey Kardatzke wrote:
> > On Fri, Sep 15, 2023 at 1:56=E2=80=AFAM Hans Verkuil <hverkuil-cisco@xs=
4all.nl> wrote:
> > >=20
> > > On 15/09/2023 10:25, Yunfei Dong (=E8=91=A3=E4=BA=91=E9=A3=9E) wrote:
> > > > Hi Hans & Nicolas,
> > > >=20
> > > > Thanks for your advice.
> > > >=20
> > > > On Tue, 2023-09-12 at 11:30 +0200, Hans Verkuil wrote:
> > > > >=20
> > > > > External email : Please do not click links or open attachments un=
til
> > > > > you have verified the sender or the content.
> > > > >  Hi,
> > > > >=20
> > > > > On 9/11/23 17:54, Nicolas Dufresne wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > Le lundi 11 septembre 2023 =C3=A0 20:59 +0800, Yunfei Dong a =
=C3=A9crit :
> > > > > > > Setting secure mode flag to kernel when trying to play secure
> > > > >=20
> > > > > video,
> > > > > > > then decoder driver will initialize tee related interface to
> > > > >=20
> > > > > support
> > > > > > > svp.
> > > > > >=20
> > > > > >=20
> > > > > > This is not what the patch is doing, please rework. This patch =
is
> > > > >=20
> > > > > an vendor API
> > > > > > addition introducing V4L2_CID_MPEG_MTK_SET_SECURE_MODE. I shoul=
d
> > > > >=20
> > > > > not have to
> > > > > > read your patch to understand this.
> > > > > >=20
> > > > > > >=20
> > > > > > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > > > > > ---
> > > > > > >  .../vcodec/decoder/mtk_vcodec_dec_stateless.c     | 15
> > > > >=20
> > > > > ++++++++++++++-
> > > > > > >  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
> > > > > > >  include/uapi/linux/v4l2-controls.h                |  1 +
> > > > > > >  3 files changed, 20 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git
> > > > >=20
> > > > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tate
> > > > > less.c
> > > > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tate
> > > > > less.c
> > > > > > > index d2b09ce9f1cf..a981178c25d9 100644
> > > > > > > ---
> > > > >=20
> > > > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tate
> > > > > less.c
> > > > > > > +++
> > > > >=20
> > > > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tate
> > > > > less.c
> > > > > > > @@ -535,6 +535,17 @@ static int mtk_vdec_s_ctrl(struct v4l2_c=
trl
> > > > >=20
> > > > > *ctrl)
> > > > > > >  ctrl->val =3D mtk_dma_contig_get_secure_handle(ctx, ctrl->va=
l);
> > > > > > >  mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d =3D> 0x%x",
> > > > >=20
> > > > > sec_fd, ctrl->val);
> > > > > > >  break;
> > > > > > > +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> > > > > >=20
> > > > > > Stepping back a little and focusing on the API, what makes your
> > > > >=20
> > > > > driver so
> > > > > > special that it should be the only one having a "secure mode" ?=
 We
> > > > >=20
> > > > > are touching
> > > > > > in gap in the media pipeline in Linux, and this should come wit=
h
> > > > >=20
> > > > > consideration
> > > > > > of the global API.
> > > > > >=20
> > > > > > Why is this API better then let's say Google Android one, were =
they
> > > > >=20
> > > > > expose 2
> > > > > > device nodes in their fork of the MFC driver (a secure and a no=
n
> > > > >=20
> > > > > secure one) ?
> > > > >=20
> > > > > Perhaps it is a good idea to first post an RFC with an uAPI propo=
sal
> > > > > on how to
> > > > > handle secure video. I suspect this isn't mediatek specific, othe=
r
> > > > > SoCs with
> > > > > tee support could use this as well.
> > > > >=20
> > > > > As Nicolas said, it's long known to be a gap in our media support=
, so
> > > > > it is
> > > > > really great that you started work on this, but you need to look =
at
> > > > > this from
> > > > > a more generic point-of-view, and not mediatek-specific.
> > > > >=20
> > > >=20
> > > > Whether your have any advice about how to do a more generic driver =
to
> > > > handle secure video playback?
> > > >=20
> > > > There are several kind of buffer: output queue buffer/capture queue
> > > > buffer/working buffer.
> > > >=20
> > > > output and capture queue buffer: user space will call tee related
> > > > interface to allocate secure handle. Will convert to secure handle =
with
> > > > v4l2 framework, then send secure handle to optee-os.
> > > >=20
> > > > working buffer: calling dma_heap and dma_buf to get secure memory
> > > > handle, then covert secure iova in optee-os.
> > > >=20
> > > > Using the same kernel driver for svp and non-svp playback, just the
> > > > buffer type are different. Normal is iova and secure is secure hand=
le.
> > > >=20
> > > > User driver will tell the kernel driver with CID control whether th=
e
> > > > current playback is svp or non-svp.
> > >=20
> > > My understanding is that when you switch to secure mode, the driver m=
akes
> > > some optee calls to set everything up. And userspace needs a way conv=
ert a
> > > dmabuf fd to a 'secure handle', which appears to be the DMA address o=
f the
> > > buffer. Who uses that handle?
> >=20
> > The only user space usage for getting the 'secure handle' from an fd
> > is when that memory is written to. This is done when the TEE decrypts
> > the video contents. User space sends the encrypted video + 'secure
> > handle' to the TEE, and the TEE decrypts the contents to the memory
> > associated with the 'secure handle'. Then the 'secure handle' is
> > passed into the TEE again with the v4l2 driver to use as the source
> > for video decoding (but w/ v4l2, user space is passing in fds).
>=20
> I think I need some more background. This series is to support a 'Secure =
Video
> Processor' (at least, that's what svp stands for I believe, something tha=
t
> is not mentioned anywhere in this series, BTW) which is used to decode an
> encrypted h264 stream.
>=20
> First question: how is that stream encrypted? Is that according to some s=
tandard?
> Nothing is mentioned about that.
>=20
> I gather that the encrypted stream is fed to the codec as usual (i.e. jus=
t put it
> in the output buffer and queue it to the codec), nothing special is neede=
d for that.
> Except, how does the hardware know it is encrypted? I guess that's where =
the
> control comes in, you have to turn on SVP mode first.

Decryption takes place before the decoder. I suspect there is no dedicated
driver for that, the TEE driver API is similar to smart card API and fits w=
ell
this task. So the decrytor consume normal memory that is encrypted and is o=
nly
allowed to decrypt into secure memory. All this is happening before the dec=
oder,
so is out of scope for this patchset.

Just a correction :-D.

>=20
> For the capture buffers you need to provide buffers from secure/trusted m=
emory.
> That's a dmabuf fd, but where does that come from?
>=20
> I saw this message:
>=20
> https://lore.kernel.org/linux-media/CAPj87rOHctwHJM-7HiQpt8Q0b09x0WWw_T4X=
sL0qT=3DdS+XzyZQ@mail.gmail.com/T/#u
>=20
> so I expect that's where it comes from. But I agree that getting this fro=
m dma-heaps
> seems more natural.
>=20
> I assume that those capture buffers are inaccessible from the CPU? (Hence=
 'secure')
>=20
> For actually displaying these secure buffers you would use drm, and I ass=
ume that
> the hardware would mix in the contents of the secure buffer into the vide=
o output
> pipeline? I.e., the actual contents remain inaccessible. And that the vid=
eo output
> (HDMI or DisplayPort) is using HDCP?
>=20
> >=20
> > >=20
> > > In any case, using a control to switch to secure mode and using a con=
trol
> > > to convert a dmabuf fd to a secure handle seems a poor choice to me.
> > >=20
> > > I was wondering if it wouldn't be better to create a new V4L2_MEMORY_=
 type,
> > > e.g. V4L2_MEMORY_DMABUF_SECURE (or perhaps _DMABUF_OPTEE). That ensur=
es that
> > > once you create buffers for the first time, the driver can switch int=
o secure
> > > mode, and until all buffers are released again you know that the driv=
er will
> > > stay in secure mode.
> >=20
> > Why do you think the control for setting secure mode is a poor choice?
> > There's various places in the driver code where functionality changes
> > based on being secure/non-secure mode, so this is very much a 'global'
> > setting for the driver. It could be inferred based off a new memory
> > type for the queues...which then sets that flag in the driver; but
> > that seems like it would be more fragile and would require checking
> > for incompatible output/capture memory types. I'm not against another
> > way of doing this; but didn't see why you think the proposed method is
> > a poor choice.
>=20
> I assume you are either decoding to secure memory all the time, or not
> at all. That's something you would want to select the moment you allocate
> the first buffer. Using the V4L2_MEMORY_ value would be the natural place
> for that. A control can typically be toggled at any time, and it makes
> no sense to do that for secure streaming.
>=20
> Related to that: if you pass a dmabuf fd you will need to check somewhere
> if the fd points to secure memory or not. You don't want to mix the two
> but you want to check that at VIDIOC_QBUF time.
>=20
> Note that the V4L2_MEMORY_ value is already checked in the v4l2 core,
> drivers do not need to do that.

Just to clarify a bit, and make sure I understand this too. You are proposi=
ng to
introduce something like:

   V4L2_MEMORY_SECURE_DMABUF

Which like V4L2_MEMORY_DMABUF is meant to import dmabuf, while telling the
driver that the memory is secure according to the definition of "secure" fo=
r the
platform its running on.

This drivers also allocate secure SHM (a standard tee concept) and have int=
ernal
allocation for reconstruction buffer and some hw specific reference metadat=
a. So
the idea would be that it would keep allocation using the dmabuf heap inter=
nal
APIs ? And decide which type of memory based on the memory type found in th=
e
queue?

Stepping back a little, why can't we have a way for drivers to detect that
dmabuf are secure ? I'm wondering if its actually useful to impose to all
userspace component to know that a dmabuf is secure ?

Also, regarding MTK, these are stateless decoders. I think it would be nice=
 to
show use example code that can properly parse the un-encrypted header, pass=
 the
data to the decryptor and decode. There is a bit of mechanic in there that =
lacks
clarification, a reference implementation would clearly help. Finally, does=
 this
platform offers some clearkey implementation (or other alternative) so we c=
an do
validation and regression testing? It would be very unfortunate to add feat=
ure
upstream that can only be tested by proprietary CDM software.

Nicolas

>=20
> >=20
> > >=20
> > > For converting the dmabuf fd into a secure handle: a new ioctl simila=
r to
> > > VIDIOC_EXPBUF might be more suited for that.
> >=20
> > I actually think the best way for converting the dmabuf fd into a
> > secure handle would be another ioctl in the dma-heap driver...since
> > that's where the memory is actually allocated from. But this really
> > depends on upstream maintainers and what they are comfortable with.
>=20
> That feels like a more natural place of doing this.
>=20
> Regards,
>=20
> 	Hans
>=20
> >=20
> > >=20
> > > Note that I am the first to admit that I have no experience with secu=
re
> > > video pipelines or optee-os, so I am looking at this purely from an u=
API
> > > perspective.
> > >=20
> > > Regards,
> > >=20
> > >         Hans
> > >=20
> > > >=20
> > > > Best Regards,
> > > > Yunfei Dong
> > > > > Regards,
> > > > >=20
> > > > > Hans
> > > > >=20
> > > > > >=20
> > > > > > regards,
> > > > > > Nicolas
> > > > > >=20
> > > > > > p.s. you forgot to document your control in the RST doc, please=
 do
> > > > >=20
> > > > > in following
> > > > > > release.
> > > > > >=20
> > > > > > > +ctx->is_svp_mode =3D ctrl->val;
> > > > > > > +
> > > > > > > +if (ctx->is_svp_mode) {
> > > > > > > +ret =3D mtk_vcodec_dec_optee_open(ctx->dev->optee_private);
> > > > > > > +if (ret)
> > > > > > > +mtk_v4l2_vdec_err(ctx, "open secure mode failed.");
> > > > > > > +else
> > > > > > > +mtk_v4l2_vdec_dbg(3, ctx, "decoder in secure mode: %d", ctrl=
-
> > > > > >=20
> > > > > > val);
> > > > > > > +}
> > > > > > > +break;
> > > > > > >  default:
> > > > > > >  mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id:
> > > > > > > 0x%x\n",
> > > > >=20
> > > > > hdr_ctrl->id);
> > > > > > >  return ret;
> > > > > > > @@ -573,7 +584,7 @@ static int mtk_vcodec_dec_ctrls_setup(str=
uct
> > > > >=20
> > > > > mtk_vcodec_dec_ctx *ctx)
> > > > > > >  unsigned int i;
> > > > > > >  struct v4l2_ctrl *ctrl;
> > > > > > >=20
> > > > > > > -v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
> > > > > > > +v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 2);
> > > > > > >  if (ctx->ctrl_hdl.error) {
> > > > > > >  mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n");
> > > > > > >  return ctx->ctrl_hdl.error;
> > > > > > > @@ -592,6 +603,8 @@ static int mtk_vcodec_dec_ctrls_setup(str=
uct
> > > > >=20
> > > > > mtk_vcodec_dec_ctx *ctx)
> > > > > > >=20
> > > > > > >  ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> > > > >=20
> > > > > &mtk_vcodec_dec_ctrl_ops,
> > > > > > >   V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0, 65535, 1, 0);
> > > > > > > +ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> > > > >=20
> > > > > &mtk_vcodec_dec_ctrl_ops,
> > > > > > > + V4L2_CID_MPEG_MTK_SET_SECURE_MODE, 0, 65535, 1, 0);
> > > > > > >=20
> > > > > > >  v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
> > > > > > >=20
> > > > > > > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > > >=20
> > > > > b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > > > > > index d8cf01f76aab..a507045a3f30 100644
> > > > > > > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > > > > > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > > > > > @@ -1042,6 +1042,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> > > > > > >  case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:return
> > > > > > > "Reference
> > > > >=20
> > > > > Frames for a P-Frame";
> > > > > > >  case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:return "Prepe=
nd
> > > > >=20
> > > > > SPS and PPS to IDR";
> > > > > > >  case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:return "MediaTek
> > > > > > > Decoder
> > > > >=20
> > > > > get secure handle";
> > > > > > > +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:return "MediaTek Deco=
der
> > > > >=20
> > > > > set secure mode";
> > > > > > >=20
> > > > > > >  /* AV1 controls */
> > > > > > >  case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:return "AV1 Profile";
> > > > > > > @@ -1442,6 +1443,10 @@ void v4l2_ctrl_fill(u32 id, const char
> > > > >=20
> > > > > **name, enum v4l2_ctrl_type *type,
> > > > > > >  *type =3D V4L2_CTRL_TYPE_INTEGER;
> > > > > > >  *flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> > > > > > >  break;
> > > > > > > +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> > > > > > > +*type =3D V4L2_CTRL_TYPE_INTEGER;
> > > > > > > +*flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> > > > > > > +break;
> > > > > > >  case V4L2_CID_USER_CLASS:
> > > > > > >  case V4L2_CID_CAMERA_CLASS:
> > > > > > >  case V4L2_CID_CODEC_CLASS:
> > > > > > > diff --git a/include/uapi/linux/v4l2-controls.h
> > > > >=20
> > > > > b/include/uapi/linux/v4l2-controls.h
> > > > > > > index 7b3694985366..88e90d943e38 100644
> > > > > > > --- a/include/uapi/linux/v4l2-controls.h
> > > > > > > +++ b/include/uapi/linux/v4l2-controls.h
> > > > > > > @@ -957,6 +957,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_ty=
pe {
> > > > > > >  /*  MPEG-class control IDs specific to the MediaTek Decoder
> > > > >=20
> > > > > driver as defined by V4L2 */
> > > > > > >  #define V4L2_CID_MPEG_MTK_BASE(V4L2_CTRL_CLASS_CODEC | 0x200=
0)
> > > > > > >  #define
> > > > >=20
> > > > > V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE(V4L2_CID_MPEG_MTK_BASE+8)
> > > > > > > +#define
> > > > >=20
> > > > > V4L2_CID_MPEG_MTK_SET_SECURE_MODE(V4L2_CID_MPEG_MTK_BASE+9)
> > > > > > >=20
> > > > > > >  /*  Camera class control IDs */
> > > > > > >=20
> > >=20
> > >=20
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

