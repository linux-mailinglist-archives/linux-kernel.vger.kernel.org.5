Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A05576AF9E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjHAJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjHAJtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:49:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EB02694;
        Tue,  1 Aug 2023 02:47:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a5ad44dc5aso4111259b6e.3;
        Tue, 01 Aug 2023 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690883252; x=1691488052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2PXExnhnMBm/DKJgmNpNxhZzz+HIdc5sGSJfvuKta8=;
        b=mxejz2kVai/JyXQHjPrklgFecN3E5WB1AH8D3ncS6U70/aEmEvY+JObSL1bRJGcUKa
         1sFVAkDv8PpvPalL15CyrYLFj2AI2K/Wcoy2XjTqWDbF3yr996FT0vpUVkmGnmKGObn3
         mkyUASUuxAqS4tT8sg/w61PXHU5GR5apOYtD4y4CR4/MuJMg4e861bvDzkD63pEDU44J
         eokn3Z9No9xNhzfsSSbOkAODuR4ltTgV2p2x9JJvi8Mzaw/B2eiX4We50MlvN7iEEVhO
         PEWlD5k2VunBDMFvusTEhUOaHH9PACa0CxuaoWquXZ5jy8jvATPyErW6CQzUwjj7ntKC
         oIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690883252; x=1691488052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2PXExnhnMBm/DKJgmNpNxhZzz+HIdc5sGSJfvuKta8=;
        b=cu2s5JkStgh51kTFA5QZDUd6MPe7DXfe+F4rRTKB2NoMJmjRkEbxSKiMmsqxoCNXL5
         WK3fpyq49C+r2jPmrrvjpI3dBjXmqlfnV5zXgtlwNa6aCUjWuZC6LGX3Dj7s+h8sZlT3
         pPisiuCH/wPsuJ3Vay8LUXGFSAl2yEIy3YkkdzeiPy801NgrGzEmO378VMpzzJdJJgTY
         lCRkrUk5FkfJ5igTRRPBVxptJgMwD3VhNG3fBh8ng4A+5XDdgkhjQbgMbj9Y4Ss66gWJ
         cadefB0QXYoru9BevxLUvsbzZo7f8BeYpEhdAs21WYPfIilgJ39FWkiHGtOZmJmwXwMk
         EuyA==
X-Gm-Message-State: ABy/qLZO+qrUx+DPt1Lw9ESbCcH8VkDW9FeM8YQMLvTDFGybKvj9/npO
        DebGc9E2e4x6BD+wuuTTdRv0wk3egwts/2Ts/Q0=
X-Google-Smtp-Source: APBJJlHaPkX8JpouoovNa6Y4X64bsFgyEzS005qo2iaXeNwDo2WsXcRbYifS43S4dJcS427rMckWVGspYMQUX+QGE3U=
X-Received: by 2002:a05:6808:3bb:b0:3a1:dac8:9c1f with SMTP id
 n27-20020a05680803bb00b003a1dac89c1fmr11976609oie.29.1690883251643; Tue, 01
 Aug 2023 02:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <1690265540-25999-5-git-send-email-shengjiu.wang@nxp.com> <20230728075933.pdepqspznenazs5f@chromium.org>
In-Reply-To: <20230728075933.pdepqspznenazs5f@chromium.org>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 1 Aug 2023 17:47:20 +0800
Message-ID: <CAA+D8APU-F93JH539cUYDJ83PeMQwyfNV1kF7iGSmZrsdSeiUg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/7] media: v4l2: Add audio capture and output support
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
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

On Fri, Jul 28, 2023 at 3:59=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> wr=
ote:
>
> Hi Shengjiu,
>
> On Tue, Jul 25, 2023 at 02:12:17PM +0800, Shengjiu Wang wrote:
> > Audio signal processing has the requirement for memory to
> > memory similar as Video.
> >
> > This patch is to add this support in v4l2 framework, defined
> > new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
> > V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
> > for audio case usage.
> >
> > The created audio device is named "/dev/audioX".
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../media/common/videobuf2/videobuf2-v4l2.c   |  4 ++
> >  drivers/media/v4l2-core/v4l2-dev.c            | 17 ++++++
> >  drivers/media/v4l2-core/v4l2-ioctl.c          | 52 +++++++++++++++++++
> >  include/media/v4l2-dev.h                      |  2 +
> >  include/media/v4l2-ioctl.h                    | 34 ++++++++++++
> >  include/uapi/linux/videodev2.h                | 19 +++++++
> >  6 files changed, 128 insertions(+)
> >
>
> Thanks for the patch! Please check my comments inline.

Thanks for reviewing.

Sorry for sending again for using the plain text mode.

>
> > diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/=
media/common/videobuf2/videobuf2-v4l2.c
> > index c7a54d82a55e..12f2be2773a2 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > @@ -785,6 +785,10 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4=
l2_create_buffers *create)
> >       case V4L2_BUF_TYPE_META_OUTPUT:
> >               requested_sizes[0] =3D f->fmt.meta.buffersize;
> >               break;
> > +     case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> > +     case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> > +             requested_sizes[0] =3D f->fmt.audio.buffersize;
> > +             break;
> >       default:
> >               return -EINVAL;
> >       }
> > diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-co=
re/v4l2-dev.c
> > index f81279492682..67484f4c6eaf 100644
> > --- a/drivers/media/v4l2-core/v4l2-dev.c
> > +++ b/drivers/media/v4l2-core/v4l2-dev.c
> > @@ -553,6 +553,7 @@ static void determine_valid_ioctls(struct video_dev=
ice *vdev)
> >       bool is_tch =3D vdev->vfl_type =3D=3D VFL_TYPE_TOUCH;
> >       bool is_meta =3D vdev->vfl_type =3D=3D VFL_TYPE_VIDEO &&
> >                      (vdev->device_caps & meta_caps);
> > +     bool is_audio =3D vdev->vfl_type =3D=3D VFL_TYPE_AUDIO;
> >       bool is_rx =3D vdev->vfl_dir !=3D VFL_DIR_TX;
> >       bool is_tx =3D vdev->vfl_dir !=3D VFL_DIR_RX;
> >       bool is_io_mc =3D vdev->device_caps & V4L2_CAP_IO_MC;
> > @@ -664,6 +665,19 @@ static void determine_valid_ioctls(struct video_de=
vice *vdev)
> >               SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_meta_out)=
;
> >               SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_meta_=
out);
> >       }
> > +     if (is_audio && is_rx) {
> > +             /* audio capture specific ioctls */
> > +             SET_VALID_IOCTL(ops, VIDIOC_ENUM_FMT, vidioc_enum_fmt_aud=
io_cap);
> > +             SET_VALID_IOCTL(ops, VIDIOC_G_FMT, vidioc_g_fmt_audio_cap=
);
> > +             SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_audio_cap=
);
> > +             SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_audio=
_cap);
> > +     } else if (is_audio && is_tx) {
> > +             /* audio output specific ioctls */
> > +             SET_VALID_IOCTL(ops, VIDIOC_ENUM_FMT, vidioc_enum_fmt_aud=
io_out);
> > +             SET_VALID_IOCTL(ops, VIDIOC_G_FMT, vidioc_g_fmt_audio_out=
);
> > +             SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_audio_out=
);
> > +             SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_audio=
_out);
> > +     }
> >       if (is_vbi) {
> >               /* vbi specific ioctls */
> >               if ((is_rx && (ops->vidioc_g_fmt_vbi_cap ||
> > @@ -927,6 +941,9 @@ int __video_register_device(struct video_device *vd=
ev,
> >       case VFL_TYPE_TOUCH:
> >               name_base =3D "v4l-touch";
> >               break;
> > +     case VFL_TYPE_AUDIO:
> > +             name_base =3D "audio";
>
> I think it was mentioned before that "audio" could be confusing. Wasn't
> there actually some other kind of /dev/audio device long ago?
>
> Seems like for touch, "v4l-touch" was introduced. Maybe it would also
> make sense to call it "v4l-audio" for audio?

Ok,  will change to use "v4l-audio".

>
> > +             break;
> >       default:
> >               pr_err("%s called with unknown type: %d\n",
> >                      __func__, type);
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index 01ba27f2ef87..aa9d872bba8d 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -188,6 +188,8 @@ const char *v4l2_type_names[] =3D {
> >       [V4L2_BUF_TYPE_SDR_OUTPUT]         =3D "sdr-out",
> >       [V4L2_BUF_TYPE_META_CAPTURE]       =3D "meta-cap",
> >       [V4L2_BUF_TYPE_META_OUTPUT]        =3D "meta-out",
> > +     [V4L2_BUF_TYPE_AUDIO_CAPTURE]      =3D "audio-cap",
> > +     [V4L2_BUF_TYPE_AUDIO_OUTPUT]       =3D "audio-out",
> >  };
> >  EXPORT_SYMBOL(v4l2_type_names);
> >
> > @@ -276,6 +278,7 @@ static void v4l_print_format(const void *arg, bool =
write_only)
> >       const struct v4l2_sliced_vbi_format *sliced;
> >       const struct v4l2_window *win;
> >       const struct v4l2_meta_format *meta;
> > +     const struct v4l2_audio_format *audio;
> >       u32 pixelformat;
> >       u32 planes;
> >       unsigned i;
> > @@ -346,6 +349,12 @@ static void v4l_print_format(const void *arg, bool=
 write_only)
> >               pr_cont(", dataformat=3D%p4cc, buffersize=3D%u\n",
> >                       &pixelformat, meta->buffersize);
> >               break;
> > +     case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> > +     case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> > +             audio =3D &p->fmt.audio;
> > +             pr_cont(", rate=3D%u, format=3D%u, channels=3D%u, buffers=
ize=3D%u\n",
> > +                     audio->rate, audio->format, audio->channels, audi=
o->buffersize);
> > +             break;
> >       }
> >  }
> >
> > @@ -927,6 +936,7 @@ static int check_fmt(struct file *file, enum v4l2_b=
uf_type type)
> >       bool is_tch =3D vfd->vfl_type =3D=3D VFL_TYPE_TOUCH;
> >       bool is_meta =3D vfd->vfl_type =3D=3D VFL_TYPE_VIDEO &&
> >                      (vfd->device_caps & meta_caps);
> > +     bool is_audio =3D vfd->vfl_type =3D=3D VFL_TYPE_AUDIO;
> >       bool is_rx =3D vfd->vfl_dir !=3D VFL_DIR_TX;
> >       bool is_tx =3D vfd->vfl_dir !=3D VFL_DIR_RX;
> >
> > @@ -992,6 +1002,14 @@ static int check_fmt(struct file *file, enum v4l2=
_buf_type type)
> >               if (is_meta && is_tx && ops->vidioc_g_fmt_meta_out)
> >                       return 0;
> >               break;
> > +     case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> > +             if (is_audio && is_rx && ops->vidioc_g_fmt_audio_cap)
> > +                     return 0;
> > +             break;
> > +     case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> > +             if (is_audio && is_tx && ops->vidioc_g_fmt_audio_out)
> > +                     return 0;
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -1594,6 +1612,16 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_=
ops *ops,
> >                       break;
> >               ret =3D ops->vidioc_enum_fmt_meta_out(file, fh, arg);
> >               break;
> > +     case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> > +             if (unlikely(!ops->vidioc_enum_fmt_audio_cap))
> > +                     break;
> > +             ret =3D ops->vidioc_enum_fmt_audio_cap(file, fh, arg);
> > +             break;
> > +     case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> > +             if (unlikely(!ops->vidioc_enum_fmt_audio_out))
> > +                     break;
> > +             ret =3D ops->vidioc_enum_fmt_audio_out(file, fh, arg);
> > +             break;
> >       }
> >       if (ret =3D=3D 0)
> >               v4l_fill_fmtdesc(p);
> > @@ -1670,6 +1698,10 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops=
 *ops,
> >               return ops->vidioc_g_fmt_meta_cap(file, fh, arg);
> >       case V4L2_BUF_TYPE_META_OUTPUT:
> >               return ops->vidioc_g_fmt_meta_out(file, fh, arg);
> > +     case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> > +             return ops->vidioc_g_fmt_audio_cap(file, fh, arg);
> > +     case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> > +             return ops->vidioc_g_fmt_audio_out(file, fh, arg);
> >       }
> >       return -EINVAL;
> >  }
> > @@ -1781,6 +1813,16 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops=
 *ops,
> >                       break;
> >               memset_after(p, 0, fmt.meta);
> >               return ops->vidioc_s_fmt_meta_out(file, fh, arg);
> > +     case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> > +             if (unlikely(!ops->vidioc_s_fmt_audio_cap))
> > +                     break;
> > +             memset_after(p, 0, fmt.audio);
> > +             return ops->vidioc_s_fmt_audio_cap(file, fh, arg);
> > +     case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> > +             if (unlikely(!ops->vidioc_s_fmt_audio_out))
> > +                     break;
> > +             memset_after(p, 0, fmt.audio);
> > +             return ops->vidioc_s_fmt_audio_out(file, fh, arg);
> >       }
> >       return -EINVAL;
> >  }
> > @@ -1889,6 +1931,16 @@ static int v4l_try_fmt(const struct v4l2_ioctl_o=
ps *ops,
> >                       break;
> >               memset_after(p, 0, fmt.meta);
> >               return ops->vidioc_try_fmt_meta_out(file, fh, arg);
> > +     case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> > +             if (unlikely(!ops->vidioc_try_fmt_audio_cap))
> > +                     break;
> > +             memset_after(p, 0, fmt.audio);
> > +             return ops->vidioc_try_fmt_audio_cap(file, fh, arg);
> > +     case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> > +             if (unlikely(!ops->vidioc_try_fmt_audio_out))
> > +                     break;
> > +             memset_after(p, 0, fmt.audio);
> > +             return ops->vidioc_try_fmt_audio_out(file, fh, arg);
> >       }
> >       return -EINVAL;
> >  }
> > diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
> > index e0a13505f88d..0924e6d1dab1 100644
> > --- a/include/media/v4l2-dev.h
> > +++ b/include/media/v4l2-dev.h
> > @@ -30,6 +30,7 @@
> >   * @VFL_TYPE_SUBDEV: for V4L2 subdevices
> >   * @VFL_TYPE_SDR:    for Software Defined Radio tuners
> >   * @VFL_TYPE_TOUCH:  for touch sensors
> > + * @VFL_TYPE_AUDIO:  for audio input/output devices
> >   * @VFL_TYPE_MAX:    number of VFL types, must always be last in the e=
num
> >   */
> >  enum vfl_devnode_type {
> > @@ -39,6 +40,7 @@ enum vfl_devnode_type {
> >       VFL_TYPE_SUBDEV,
> >       VFL_TYPE_SDR,
> >       VFL_TYPE_TOUCH,
> > +     VFL_TYPE_AUDIO,
> >       VFL_TYPE_MAX /* Shall be the last one */
> >  };
> >
> > diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
> > index edb733f21604..f840cf740ce1 100644
> > --- a/include/media/v4l2-ioctl.h
> > +++ b/include/media/v4l2-ioctl.h
> > @@ -45,6 +45,12 @@ struct v4l2_fh;
> >   * @vidioc_enum_fmt_meta_out: pointer to the function that implements
> >   *   :ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
> >   *   for metadata output
> > + * @vidioc_enum_fmt_audio_cap: pointer to the function that implements
> > + *   :ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
> > + *   for audio capture
> > + * @vidioc_enum_fmt_audio_out: pointer to the function that implements
> > + *   :ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
> > + *   for audio output
> >   * @vidioc_g_fmt_vid_cap: pointer to the function that implements
> >   *   :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video capture
> >   *   in single plane mode
> > @@ -79,6 +85,10 @@ struct v4l2_fh;
> >   *   :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for metadata captu=
re
> >   * @vidioc_g_fmt_meta_out: pointer to the function that implements
> >   *   :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for metadata outpu=
t
> > + * @vidioc_g_fmt_audio_cap: pointer to the function that implements
> > + *   :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for audio capture
> > + * @vidioc_g_fmt_audio_out: pointer to the function that implements
> > + *   :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for audio output
> >   * @vidioc_s_fmt_vid_cap: pointer to the function that implements
> >   *   :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video capture
> >   *   in single plane mode
> > @@ -113,6 +123,10 @@ struct v4l2_fh;
> >   *   :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for metadata captu=
re
> >   * @vidioc_s_fmt_meta_out: pointer to the function that implements
> >   *   :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for metadata outpu=
t
> > + * @vidioc_s_fmt_audio_cap: pointer to the function that implements
> > + *   :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for audio capture
> > + * @vidioc_s_fmt_audio_out: pointer to the function that implements
> > + *   :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for audio output
> >   * @vidioc_try_fmt_vid_cap: pointer to the function that implements
> >   *   :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video captur=
e
> >   *   in single plane mode
> > @@ -149,6 +163,10 @@ struct v4l2_fh;
> >   *   :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for metadata cap=
ture
> >   * @vidioc_try_fmt_meta_out: pointer to the function that implements
> >   *   :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for metadata out=
put
> > + * @vidioc_try_fmt_audio_cap: pointer to the function that implements
> > + *   :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for audio captur=
e
> > + * @vidioc_try_fmt_audio_out: pointer to the function that implements
> > + *   :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for audio output
> >   * @vidioc_reqbufs: pointer to the function that implements
> >   *   :ref:`VIDIOC_REQBUFS <vidioc_reqbufs>` ioctl
> >   * @vidioc_querybuf: pointer to the function that implements
> > @@ -315,6 +333,10 @@ struct v4l2_ioctl_ops {
> >                                       struct v4l2_fmtdesc *f);
> >       int (*vidioc_enum_fmt_meta_out)(struct file *file, void *fh,
> >                                       struct v4l2_fmtdesc *f);
> > +     int (*vidioc_enum_fmt_audio_cap)(struct file *file, void *fh,
> > +                                      struct v4l2_fmtdesc *f);
> > +     int (*vidioc_enum_fmt_audio_out)(struct file *file, void *fh,
> > +                                      struct v4l2_fmtdesc *f);
> >
> >       /* VIDIOC_G_FMT handlers */
> >       int (*vidioc_g_fmt_vid_cap)(struct file *file, void *fh,
> > @@ -345,6 +367,10 @@ struct v4l2_ioctl_ops {
> >                                    struct v4l2_format *f);
> >       int (*vidioc_g_fmt_meta_out)(struct file *file, void *fh,
> >                                    struct v4l2_format *f);
> > +     int (*vidioc_g_fmt_audio_cap)(struct file *file, void *fh,
> > +                                   struct v4l2_format *f);
> > +     int (*vidioc_g_fmt_audio_out)(struct file *file, void *fh,
> > +                                   struct v4l2_format *f);
> >
> >       /* VIDIOC_S_FMT handlers */
> >       int (*vidioc_s_fmt_vid_cap)(struct file *file, void *fh,
> > @@ -375,6 +401,10 @@ struct v4l2_ioctl_ops {
> >                                    struct v4l2_format *f);
> >       int (*vidioc_s_fmt_meta_out)(struct file *file, void *fh,
> >                                    struct v4l2_format *f);
> > +     int (*vidioc_s_fmt_audio_cap)(struct file *file, void *fh,
> > +                                   struct v4l2_format *f);
> > +     int (*vidioc_s_fmt_audio_out)(struct file *file, void *fh,
> > +                                   struct v4l2_format *f);
> >
> >       /* VIDIOC_TRY_FMT handlers */
> >       int (*vidioc_try_fmt_vid_cap)(struct file *file, void *fh,
> > @@ -405,6 +435,10 @@ struct v4l2_ioctl_ops {
> >                                      struct v4l2_format *f);
> >       int (*vidioc_try_fmt_meta_out)(struct file *file, void *fh,
> >                                      struct v4l2_format *f);
> > +     int (*vidioc_try_fmt_audio_cap)(struct file *file, void *fh,
> > +                                     struct v4l2_format *f);
> > +     int (*vidioc_try_fmt_audio_out)(struct file *file, void *fh,
> > +                                     struct v4l2_format *f);
> >
> >       /* Buffer handlers */
> >       int (*vidioc_reqbufs)(struct file *file, void *fh,
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 3af6a82d0cad..e5051410928a 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -153,6 +153,8 @@ enum v4l2_buf_type {
> >       V4L2_BUF_TYPE_SDR_OUTPUT           =3D 12,
> >       V4L2_BUF_TYPE_META_CAPTURE         =3D 13,
> >       V4L2_BUF_TYPE_META_OUTPUT          =3D 14,
> > +     V4L2_BUF_TYPE_AUDIO_CAPTURE        =3D 15,
> > +     V4L2_BUF_TYPE_AUDIO_OUTPUT         =3D 16,
> >       /* Deprecated, do not use */
> >       V4L2_BUF_TYPE_PRIVATE              =3D 0x80,
> >  };
> > @@ -169,6 +171,7 @@ enum v4l2_buf_type {
> >        || (type) =3D=3D V4L2_BUF_TYPE_VBI_OUTPUT                  \
> >        || (type) =3D=3D V4L2_BUF_TYPE_SLICED_VBI_OUTPUT           \
> >        || (type) =3D=3D V4L2_BUF_TYPE_SDR_OUTPUT                  \
> > +      || (type) =3D=3D V4L2_BUF_TYPE_AUDIO_OUTPUT                \
> >        || (type) =3D=3D V4L2_BUF_TYPE_META_OUTPUT)
> >
> >  #define V4L2_TYPE_IS_CAPTURE(type) (!V4L2_TYPE_IS_OUTPUT(type))
> > @@ -2415,6 +2418,20 @@ struct v4l2_meta_format {
> >       __u32                           buffersize;
> >  } __attribute__ ((packed));
> >
> > +/**
> > + * struct v4l2_audio_format - audio data format definition
> > + * @rate:            sample rate
> > + * @format:          sample format
> > + * @channels:                channel numbers
> > + * @buffersize:              maximum size in bytes required for data
> > + */
> > +struct v4l2_audio_format {
> > +     __u32                           rate;
> > +     __u32                           format;
>
> What are the values for the rate and format fields? Since they are part
> of the UAPI, they need to be defined.
>

The range for sample rate is [5512, 768000].
The format is defined in include/uapi/sound/asound.h,  they are
SNDRV_PCM_FORMAT_S8, SNDRV_PCM_FORMAT_U8, ...

Where should I put these info?

Best regards
Wang shengjiu

> Best regards,
> Tomasz
>
> > +     __u32                           channels;
> > +     __u32                           buffersize;
> > +} __attribute__ ((packed));
> > +
> >  /**
> >   * struct v4l2_format - stream data format
> >   * @type:    enum v4l2_buf_type; type of the data stream
> > @@ -2423,6 +2440,7 @@ struct v4l2_meta_format {
> >   * @win:     definition of an overlaid image
> >   * @vbi:     raw VBI capture or output parameters
> >   * @sliced:  sliced VBI capture or output parameters
> > + * @audio:   definition of an audio format
> >   * @raw_data:        placeholder for future extensions and custom form=
ats
> >   * @fmt:     union of @pix, @pix_mp, @win, @vbi, @sliced, @sdr, @meta
> >   *           and @raw_data
> > @@ -2437,6 +2455,7 @@ struct v4l2_format {
> >               struct v4l2_sliced_vbi_format   sliced;  /* V4L2_BUF_TYPE=
_SLICED_VBI_CAPTURE */
> >               struct v4l2_sdr_format          sdr;     /* V4L2_BUF_TYPE=
_SDR_CAPTURE */
> >               struct v4l2_meta_format         meta;    /* V4L2_BUF_TYPE=
_META_CAPTURE */
> > +             struct v4l2_audio_format        audio;   /* V4L2_BUF_TYPE=
_AUDIO_CAPTURE */
> >               __u8    raw_data[200];                   /* user-defined =
*/
> >       } fmt;
> >  };
> > --
> > 2.34.1
> >
