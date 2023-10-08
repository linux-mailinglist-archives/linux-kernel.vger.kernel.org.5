Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B77BCE64
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344766AbjJHM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbjJHM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 08:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F554DB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 05:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696769756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0nF39BML0PfnEg8EYtnUaYzCy2YCCsILfREV9RebgY=;
        b=P1EEC6Vkid/7JdWEj+7ifmuR5Sn4lv9bLPZxS6ku/qEKNkHaVeEuAEDKA3EVz49WWpz2J+
        MZSVoiyoLvt3BezM53DRTO6NhDDNzVd2O/Utee5F+luqTUFY7pKBv+GFrg7i56OGn2qE1j
        0+x7H+FBA8TdbVD0t7uGBFMOTZRasGw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-dlTRDAOjMzK28K7-mhnmrA-1; Sun, 08 Oct 2023 08:55:54 -0400
X-MC-Unique: dlTRDAOjMzK28K7-mhnmrA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5334e22b2dbso390440a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 05:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696769753; x=1697374553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0nF39BML0PfnEg8EYtnUaYzCy2YCCsILfREV9RebgY=;
        b=Kkpubck7DT0CBPwPU5WRGg489U84RpcnxUUsKZhyizIotcJkrxjNtiAMwQxybHVPS1
         PT32SBHLhTbAVcvINFal18GeCdUobdBWEheTF3MU/cF/c5y5rdREaUEQ65swuCCTJELk
         oxHApmlwJiKKF/wPiAmT9Si0VvkSF3Swo9vMgY+ze/KkecytCAwnuNAz/4Rmb9K+lG8t
         MWAv1qQhf5zmS9mmhUj8PW6jN7IneSl491EULoNBD4HDBZoIbLtYpwh6XTKi+e7dKUFl
         hl8vwyNwI5RlbH+jhKMxtjxbQix2wQ2XyMpIlulDdQIU3qJU3bwTCXiFMv18ZqutXaf9
         3jbQ==
X-Gm-Message-State: AOJu0YybbBd1atukBunHF+u47cLEmRBVLN0IxSjJ+/qa/xDRxacCngUd
        zDTLOJti+/BC6wQK3z11Kr6BGxIXJso9sRHkY7jpLcJHyo5flEoJwrlJPSX9UtKzNtbvt2Bp3je
        E+ptFjKOxbsVepU42BfIQlI9ZOfomIXLZLgO+Aku7
X-Received: by 2002:a05:6402:1219:b0:530:77e6:849f with SMTP id c25-20020a056402121900b0053077e6849fmr11262461edw.27.1696769753716;
        Sun, 08 Oct 2023 05:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwuP5OldwI2lirgcFqdgqLuiwfXybdqWPqtq7WHhBAHTyaUl0LsDbO3SeDWNbNgLhU8D5uYo8GQPksNhx7/pw=
X-Received: by 2002:a05:6402:1219:b0:530:77e6:849f with SMTP id
 c25-20020a056402121900b0053077e6849fmr11262452edw.27.1696769753309; Sun, 08
 Oct 2023 05:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-4-lulu@redhat.com>
 <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
 <db93d5aa-64c4-42a4-73dc-ae25e9e3833e@redhat.com> <CACGkMEsNfLOQkmnWUH53iTptAmhELs_U8B4D-CfO49rs=+HfLw@mail.gmail.com>
In-Reply-To: <CACGkMEsNfLOQkmnWUH53iTptAmhELs_U8B4D-CfO49rs=+HfLw@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Sun, 8 Oct 2023 20:55:12 +0800
Message-ID: <CACLfguU5_8u-n5UopwzDKEEtFJ1GJ9NezEU7LGG=BY3BrZdhrg@mail.gmail.com>
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
To:     Jason Wang <jasowang@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com,
        xieyongji@bytedance.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 1:17=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, Sep 29, 2023 at 5:12=E2=80=AFPM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
> >
> >
> >
> > On 9/12/23 09:39, Jason Wang wrote:
> > > On Tue, Sep 12, 2023 at 11:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> w=
rote:
> > >>
> > >> In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
> > >> with reconnect info, After mapping the reconnect pages to userspace
> > >> The userspace App will update the reconnect_time in
> > >> struct vhost_reconnect_vring, If this is not 0 then it means this
> > >> vq is reconnected and will update the last_avail_idx
> > >>
> > >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >> ---
> > >>   drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
> > >>   include/uapi/linux/vduse.h         |  6 ++++++
> > >>   2 files changed, 19 insertions(+)
> > >>
> > >> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_=
user/vduse_dev.c
> > >> index 2c69f4004a6e..680b23dbdde2 100644
> > >> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > >> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > >> @@ -1221,6 +1221,8 @@ static long vduse_dev_ioctl(struct file *file,=
 unsigned int cmd,
> > >>                  struct vduse_vq_info vq_info;
> > >>                  struct vduse_virtqueue *vq;
> > >>                  u32 index;
> > >> +               struct vdpa_reconnect_info *area;
> > >> +               struct vhost_reconnect_vring *vq_reconnect;
> > >>
> > >>                  ret =3D -EFAULT;
> > >>                  if (copy_from_user(&vq_info, argp, sizeof(vq_info))=
)
> > >> @@ -1252,6 +1254,17 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >>
> > >>                  vq_info.ready =3D vq->ready;
> > >>
> > >> +               area =3D &vq->reconnect_info;
> > >> +
> > >> +               vq_reconnect =3D (struct vhost_reconnect_vring *)are=
a->vaddr;
> > >> +               /*check if the vq is reconnect, if yes then update t=
he last_avail_idx*/
> > >> +               if ((vq_reconnect->last_avail_idx !=3D
> > >> +                    vq_info.split.avail_index) &&
> > >> +                   (vq_reconnect->reconnect_time !=3D 0)) {
> > >> +                       vq_info.split.avail_index =3D
> > >> +                               vq_reconnect->last_avail_idx;
> > >> +               }
> > >> +
> > >>                  ret =3D -EFAULT;
> > >>                  if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
> > >>                          break;
> > >> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > >> index 11bd48c72c6c..d585425803fd 100644
> > >> --- a/include/uapi/linux/vduse.h
> > >> +++ b/include/uapi/linux/vduse.h
> > >> @@ -350,4 +350,10 @@ struct vduse_dev_response {
> > >>          };
> > >>   };
> > >>
> > >> +struct vhost_reconnect_vring {
> > >> +       __u16 reconnect_time;
> > >> +       __u16 last_avail_idx;
> > >> +       _Bool avail_wrap_counter;
> > >
> > > Please add a comment for each field.
> > >
> > > And I never saw _Bool is used in uapi before, maybe it's better to
> > > pack it with last_avail_idx into a __u32.
> >
> > Better as two distincts __u16 IMHO.
>
> Fine with me.
>
> Thanks
>

sure will fix  this
Thanks
Cindy
> >
> > Thanks,
> > Maxime
> >
> > >
> > > Btw, do we need to track inflight descriptors as well?
> > >
> > > Thanks
> > >
> > >> +};
> > >> +
> > >>   #endif /* _UAPI_VDUSE_H_ */
> > >> --
> > >> 2.34.3
> > >>
> > >
> >
>

