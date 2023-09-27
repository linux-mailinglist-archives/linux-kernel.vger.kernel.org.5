Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4667B0C42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjI0SyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0SyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:54:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE76F9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 11:54:15 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35137ab766dso25815ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695840855; x=1696445655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgknUwnq9gIV+tvRlScN3zfltL029CTlXmtn1qWfZ48=;
        b=CuOl5XrCYS06vtYmnr6IgA5Q5UvsyZdXDUmApZzoFhCeRol/q2H52nc9klsREksetB
         EDLOZo9AoJ2TZKweFC0F92mVh2z0R/l3rJz4sISCWu1rYTzAuTLXzozYwvzb6AX00TaG
         wdC6egT+yr/85KBs2x09A8x3iTzmpbjKTdS7ZJWY8/6zpPHnyJKsFf2IMz0IA1fYgprs
         vYtBViyMiZ7hjxv1A17ARNPCUt5sCOApaIjZk2tq08fz/y3VaQQzkOCM42g6JMwHu5S1
         Hj9D3qm2Bm9dhXgfoZmr1h4C7U2NiAfzShtpgjAEQNKW9oSORjM331F141wnGy9mYk+P
         4M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695840855; x=1696445655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgknUwnq9gIV+tvRlScN3zfltL029CTlXmtn1qWfZ48=;
        b=sFqN+IyTVKHroHz9jL9SKhhrzPdTT5Wl3bwIWxRVd5wJhjC7Z40Ih5SfzrclGjtKrp
         vnbMWr+oG+ymvOgGDkNySj552PwXY6ViakRntG8FCpXrQ5iMYOUSs7gplrq9OsyN52zr
         mFy/0Uw8XzpAr5aEDhuvqKT/VLTdnX0tIHHiDSnXw8ETcwnCO2+2FRq1kbvJQaRZ5k7d
         ARHbTQ2RZRRKk7ZESpCf67+UJKUymzTw696lYuyvSXi2QLV0TpA1uwtHg+oHa107IYaQ
         DQ0TE8OLBWWdne+BIuM6PYTpWZDAOfFW6GNrbuxJxkzm0xZ75Di5EI4Y3qxljcKXOdfA
         BfBQ==
X-Gm-Message-State: AOJu0YzdbOSjgFAZDl1dNrlSC3xYshlOLT8dqyyDd71tc4eRWrlWpOi3
        r9gzJPcZs264chwlFrHzaoQjavXHHQVYVZSDg5j8
X-Google-Smtp-Source: AGHT+IGFTNOeIjY0z4z1jsppqGQ/+DkN5LKNzVhtRpc1fe/Zjm0L6bfMROX9KjJp8peSFpnQgwJTEYqVV/8DUuyxQQM=
X-Received: by 2002:a92:c242:0:b0:34d:ff4c:5e3a with SMTP id
 k2-20020a92c242000000b0034dff4c5e3amr748810ilo.10.1695840854718; Wed, 27 Sep
 2023 11:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230911023038.30649-1-yong.wu@mediatek.com> <20230911023038.30649-6-yong.wu@mediatek.com>
 <d0373c02-9b22-661f-9930-ca720053c2a0@collabora.com> <a115a2a5d3ac218e6db65ccdb0a1876f9cfca02b.camel@mediatek.com>
 <d798b15b-6f35-96db-e3f7-5c0bcc5d46a2@collabora.com> <a4ecc2792f3a4d3159e34415be984ff7d5f5e263.camel@mediatek.com>
 <20230927134614.kp27moxdw72jiu4y@pop-os.localdomain>
In-Reply-To: <20230927134614.kp27moxdw72jiu4y@pop-os.localdomain>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 27 Sep 2023 11:54:03 -0700
Message-ID: <CA+ddPcNDOsd4+1a3W5ufA-FaCc801bKkA-OapNKOC8snXrntAw@mail.gmail.com>
Subject: Re: [PATCH 5/9] dma-buf: heaps: mtk_sec_heap: Initialise tee session
To:     Joakim Bech <joakim.bech@linaro.org>
Cc:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        =?UTF-8?B?S3VvaG9uZyBXYW5nICjnjovlnIvptLsp?= 
        <kuohong.wang@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 6:46=E2=80=AFAM Joakim Bech <joakim.bech@linaro.org=
> wrote:
>
> On Mon, Sep 25, 2023 at 12:49:50PM +0000, Yong Wu (=E5=90=B4=E5=8B=87) wr=
ote:
> > On Tue, 2023-09-12 at 11:32 +0200, AngeloGioacchino Del Regno wrote:
> > > Il 12/09/23 08:17, Yong Wu (=E5=90=B4=E5=8B=87) ha scritto:
> > > > On Mon, 2023-09-11 at 11:29 +0200, AngeloGioacchino Del Regno
> > > > wrote:
> > > > > Il 11/09/23 04:30, Yong Wu ha scritto:
> > > > > > The TEE probe later than dma-buf heap, and PROBE_DEDER doesn't
> > > > > > work
> > > > > > here since this is not a platform driver, therefore initialise
> > > > > > the
> > > > > > TEE
> > > > > > context/session while we allocate the first secure buffer.
> > > > > >
> > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > ---
> > > > > >    drivers/dma-buf/heaps/mtk_secure_heap.c | 61
> > > > > > +++++++++++++++++++++++++
> > > > > >    1 file changed, 61 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/dma-buf/heaps/mtk_secure_heap.c
> > > > > > b/drivers/dma-
> > > > > > buf/heaps/mtk_secure_heap.c
> > > > > > index bbf1c8dce23e..e3da33a3d083 100644
> > > > > > --- a/drivers/dma-buf/heaps/mtk_secure_heap.c
> > > > > > +++ b/drivers/dma-buf/heaps/mtk_secure_heap.c
> > > > > > @@ -10,6 +10,12 @@
> > > > > >    #include <linux/err.h>
> > > > > >    #include <linux/module.h>
> > > > > >    #include <linux/slab.h>
> > > > > > +#include <linux/tee_drv.h>
> > > > > > +#include <linux/uuid.h>
> > > > > > +
> > > > > > +#define TZ_TA_MEM_UUID               "4477588a-8476-11e2-ad15-
> > > > > > e41f1390d676"
> > > > > > +
> > > > >
> > > > > Is this UUID the same for all SoCs and all TZ versions?
> > > >
> > > > Yes. It is the same for all SoCs and all TZ versions currently.
> > > >
> > >
> > > That's good news!
> > >
> > > Is this UUID used in any userspace component? (example: Android
> > > HALs?)
> >
> > No. Userspace never use it. If userspace would like to allocate this
> > secure buffer, it can achieve through the existing dmabuf IOCTL via
> > /dev/dma_heap/mtk_svp node.
> >
> In general I think as mentioned elsewhere in comments, that there isn't
> that much here that seems to be unique for MediaTek in this patch
> series, so I think it worth to see whether this whole patch set can be
> made more generic. Having said that, the UUID is always unique for a
> certain Trusted Application. So, it's not entirely true saying that the
> UUID is the same for all SoCs and all TrustZone versions. It might be
> true for a family of MediaTek devices and the TEE in use, but not
> generically.
>
> So, if we need to differentiate between different TA implementations,
> then we need different UUIDs. If it would be possible to make this patch
> set generic, then it sounds like a single UUID would be sufficient, but
> that would imply that all TA's supporting such a generic UUID would be
> implemented the same from an API point of view. Which also means that
> for example Trusted Application function ID's needs to be the same etc.
> Not impossible to achieve, but still not easy (different TEE follows
> different specifications) and it's not typically something we've done in
> the past.
>
> Unfortunately there is no standardized database of TA's describing what
> they implement and support.
>
> As an alternative, we could implement a query call in the TEE answering,
> "What UUID does your TA have that implements secure unmapped heap?".
> I.e., something that reminds of a lookup table. Then we wouldn't have to
> carry this in UAPI, DT or anywhere else.
>

I think that's a good idea. If we add kernel APIs to the tee for
opening a session for secure memory allocation and for performing the
allocation, then the UUID, TA commands and TA parameters can all be
decided upon in the TEE specific driver and the code in dma-heap
becomes generic.

> --
> // Regards
> Joakim
>
> >
> > > If it is (and I somehow expect that it is), then this definition
> > > should go
> > > to a UAPI header, as suggested by Christian.
> > >
> > > Cheers!
> > >
> > > > >
> > > > > Thanks,
> > > > > Angelo
> > > > >
> > > > >
> > > > > > +#define MTK_TEE_PARAM_NUM            4
> > > > > >
> > > > > >    /*
> > > > > >     * MediaTek secure (chunk) memory type
> > > > > > @@ -28,17 +34,72 @@ struct mtk_secure_heap_buffer {
> > > > > >    struct mtk_secure_heap {
> > > > > >       const char              *name;
> > > > > >       const enum kree_mem_type mem_type;
> > > > > > +     u32                      mem_session;
> > > > > > +     struct tee_context      *tee_ctx;
> > > > > >    };
> > > > > >
> > > > > > +static int mtk_optee_ctx_match(struct tee_ioctl_version_data
> > > > > > *ver,
> > > > > > const void *data)
> > > > > > +{
> > > > > > +     return ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE;
> > > > > > +}
> > > > > > +
> > > > > > +static int mtk_kree_secure_session_init(struct mtk_secure_heap
> > > > > > *sec_heap)
> > > > > > +{
> > > > > > +     struct tee_param t_param[MTK_TEE_PARAM_NUM] =3D {0};
> > > > > > +     struct tee_ioctl_open_session_arg arg =3D {0};
> > > > > > +     uuid_t ta_mem_uuid;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     sec_heap->tee_ctx =3D tee_client_open_context(NULL,
> > > > > > mtk_optee_ctx_match,
> > > > > > +                                                 NULL,
> > > > > > NULL);
> > > > > > +     if (IS_ERR(sec_heap->tee_ctx)) {
> > > > > > +             pr_err("%s: open context failed, ret=3D%ld\n",
> > > > > > sec_heap-
> > > > > > > name,
> > > > > >
> > > > > > +                    PTR_ERR(sec_heap->tee_ctx));
> > > > > > +             return -ENODEV;
> > > > > > +     }
> > > > > > +
> > > > > > +     arg.num_params =3D MTK_TEE_PARAM_NUM;
> > > > > > +     arg.clnt_login =3D TEE_IOCTL_LOGIN_PUBLIC;
> > > > > > +     ret =3D uuid_parse(TZ_TA_MEM_UUID, &ta_mem_uuid);
> > > > > > +     if (ret)
> > > > > > +             goto close_context;
> > > > > > +     memcpy(&arg.uuid, &ta_mem_uuid.b, sizeof(ta_mem_uuid));
> > > > > > +
> > > > > > +     ret =3D tee_client_open_session(sec_heap->tee_ctx, &arg,
> > > > > > t_param);
> > > > > > +     if (ret < 0 || arg.ret) {
> > > > > > +             pr_err("%s: open session failed, ret=3D%d:%d\n",
> > > > > > +                    sec_heap->name, ret, arg.ret);
> > > > > > +             ret =3D -EINVAL;
> > > > > > +             goto close_context;
> > > > > > +     }
> > > > > > +     sec_heap->mem_session =3D arg.session;
> > > > > > +     return 0;
> > > > > > +
> > > > > > +close_context:
> > > > > > +     tee_client_close_context(sec_heap->tee_ctx);
> > > > > > +     return ret;
> > > > > > +}
> > > > > > +
> > > > > >    static struct dma_buf *
> > > > > >    mtk_sec_heap_allocate(struct dma_heap *heap, size_t size,
> > > > > >                     unsigned long fd_flags, unsigned long
> > > > > > heap_flags)
> > > > > >    {
> > > > > > +     struct mtk_secure_heap *sec_heap =3D
> > > > > > dma_heap_get_drvdata(heap);
> > > > > >       struct mtk_secure_heap_buffer *sec_buf;
> > > > > >       DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > > > > >       struct dma_buf *dmabuf;
> > > > > >       int ret;
> > > > > >
> > > > > > +     /*
> > > > > > +      * TEE probe may be late. Initialise the secure session
> > > > > > in the
> > > > > > first
> > > > > > +      * allocating secure buffer.
> > > > > > +      */
> > > > > > +     if (!sec_heap->mem_session) {
> > > > > > +             ret =3D mtk_kree_secure_session_init(sec_heap);
> > > > > > +             if (ret)
> > > > > > +                     return ERR_PTR(ret);
> > > > > > +     }
> > > > > > +
> > > > > >       sec_buf =3D kzalloc(sizeof(*sec_buf), GFP_KERNEL);
> > > > > >       if (!sec_buf)
> > > > > >               return ERR_PTR(-ENOMEM);
> > > > >
> > > > >
> > >
> > >
