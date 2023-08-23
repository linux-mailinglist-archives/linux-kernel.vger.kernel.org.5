Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506527861C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjHWUvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjHWUvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:51:45 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8039410C8;
        Wed, 23 Aug 2023 13:51:43 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bcac140aaaso4625559a34.2;
        Wed, 23 Aug 2023 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692823903; x=1693428703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMgBXJyz4j+4W1iINiCAeqRriHTkzDpdbP8epuCcQ+c=;
        b=eozVk7W5leBAIZAjir3gI8REAZD8JCcPkc/M3KQhYESTaDkMUhGQDiSxOEPEK8UM6S
         QBVLEjB8cFtzrlG3JpOzs9WHPI0EvMf0WIahjkoZSTWCyL2GUEH/6Mezg90NtJhGIrvQ
         eBPKe8aveZvFRN15TGEaVA1rgkLsnveNweUtsnML5Ia5IEm2bQX1GROzmYft1v91mIPG
         D6tlS5DTv1Yn6jV/Hyt4NPH/leowXHZCgoGIqgoqFC6uvzqlN+i1Zhm78AVUDpt0B69X
         zarKS/XGC8q15mK6yGP+XRMWe3L1Ah7X5yAQEbWraTrTvFLQdbuiTVRiWmOVovKWwAUU
         QsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692823903; x=1693428703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMgBXJyz4j+4W1iINiCAeqRriHTkzDpdbP8epuCcQ+c=;
        b=kyGEaVP0yI6F/EBlpuwi3uUj+Rr5/9+ouPhK0rvBwGJFOImC8i9A6BjLjSFv0PA0e+
         mH7xRUZ+ds3Nuk3me2AJc7fcBOd5d+sx96/ZkRl7qzMX+0neV4bRpF++mJhNCNRPApDn
         F1ykusoZIMarLtrj4ykGi3fmsZURa2X1Vc0uLr2FWyiFNhiYfnFRI8xjd8o9BtMvrIpb
         At/qzk+X245PUJSuqeFAx9YNI6bjDvozx8S+rcF7zMjq5wx/19kUzuitLwobXOr/h+v9
         qnndPcZb6vAK05bWaUHapoxjsnQ0w1Ul77yo3jdGyG6TQPK4q6UqXYaHCORXhstc4DBF
         Hkyw==
X-Gm-Message-State: AOJu0Yy6hksvAlW+GOO1N9fpBjYl2m0r4U2bN0pbe37HiD3mi7ejRKQR
        bfQHuIMiD/OJbYoZx8sZvbWWlw+7bul83ng8C/0irgtC
X-Google-Smtp-Source: AGHT+IHgdmrbaLNqEUvEuYL9VRV0cTrFvNWgv5pxAYyjKRmaS85alJv6VNGoQ4yzx1Q6YlEJslEijFtTWsqHFGbHGcI=
X-Received: by 2002:a05:6870:700e:b0:1bf:dc25:a5aa with SMTP id
 u14-20020a056870700e00b001bfdc25a5aamr16861010oae.39.1692823902696; Wed, 23
 Aug 2023 13:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230815172700.255596-1-hamza.mahfooz@amd.com>
 <d1831afd-9e02-fbc9-69f7-e8f044f35ee0@gmail.com> <855aeab8-13e1-4dc4-841e-24d298c9c072@amd.com>
 <9855fa7a-dd9d-27b8-171e-b662d417b902@amd.com>
In-Reply-To: <9855fa7a-dd9d-27b8-171e-b662d417b902@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 23 Aug 2023 16:51:31 -0400
Message-ID: <CADnq5_OZiTtWLMS-hh56c8KZj1eEHQGVKh6pah-qct74e4Nabw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: register a dirty framebuffer callback for fbcon
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Mahfooz, Hamza
 can you respin with the NULL check?

Alex

On Wed, Aug 16, 2023 at 10:25=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.08.23 um 15:41 schrieb Hamza Mahfooz:
> >
> > On 8/16/23 01:55, Christian K=C3=B6nig wrote:
> >>
> >>
> >> Am 15.08.23 um 19:26 schrieb Hamza Mahfooz:
> >>> fbcon requires that we implement &drm_framebuffer_funcs.dirty.
> >>> Otherwise, the framebuffer might take a while to flush (which would
> >>> manifest as noticeable lag). However, we can't enable this callback f=
or
> >>> non-fbcon cases since it might cause too many atomic commits to be ma=
de
> >>> at once. So, implement amdgpu_dirtyfb() and only enable it for fbcon
> >>> framebuffers on devices that support atomic KMS.
> >>>
> >>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >>> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >>> Cc: stable@vger.kernel.org # 6.1+
> >>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2519
> >>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> >>> ---
> >>> v2: update variable names
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 26
> >>> ++++++++++++++++++++-
> >>>   1 file changed, 25 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> >>> index d20dd3f852fc..d3b59f99cb7c 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> >>> @@ -38,6 +38,8 @@
> >>>   #include <linux/pci.h>
> >>>   #include <linux/pm_runtime.h>
> >>>   #include <drm/drm_crtc_helper.h>
> >>> +#include <drm/drm_damage_helper.h>
> >>> +#include <drm/drm_drv.h>
> >>>   #include <drm/drm_edid.h>
> >>>   #include <drm/drm_fb_helper.h>
> >>>   #include <drm/drm_gem_framebuffer_helper.h>
> >>> @@ -532,11 +534,29 @@ bool amdgpu_display_ddc_probe(struct
> >>> amdgpu_connector *amdgpu_connector,
> >>>       return true;
> >>>   }
> >>> +static int amdgpu_dirtyfb(struct drm_framebuffer *fb, struct
> >>> drm_file *file,
> >>> +              unsigned int flags, unsigned int color,
> >>> +              struct drm_clip_rect *clips, unsigned int num_clips)
> >>> +{
> >>> +
> >>> +    if (strcmp(fb->comm, "[fbcon]"))
> >>> +        return -ENOSYS;
> >>
> >> Once more to the v2 of this patch: Tests like those are a pretty big
> >> NO-GO for upstreaming.
> >
> > On closer inspection it is actually sufficient to check if `file` is
> > NULL here (since it means that the request isn't from userspace). So, d=
o
> > you think that would be palatable for upstream?
>
> That's certainly better than doing a string compare, but I'm not sure if
> that's sufficient.
>
> In general drivers shouldn't have any special handling for fdcon.
>
> You should probably have Thomas Zimmermann <tzimmermann@suse.de> take a
> look at this.
>
> Regards,
> Christian.
>
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>> +
> >>> +    return drm_atomic_helper_dirtyfb(fb, file, flags, color, clips,
> >>> +                     num_clips);
> >>> +}
> >>> +
> >>>   static const struct drm_framebuffer_funcs amdgpu_fb_funcs =3D {
> >>>       .destroy =3D drm_gem_fb_destroy,
> >>>       .create_handle =3D drm_gem_fb_create_handle,
> >>>   };
> >>> +static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic =3D=
 {
> >>> +    .destroy =3D drm_gem_fb_destroy,
> >>> +    .create_handle =3D drm_gem_fb_create_handle,
> >>> +    .dirty =3D amdgpu_dirtyfb
> >>> +};
> >>> +
> >>>   uint32_t amdgpu_display_supported_domains(struct amdgpu_device *ade=
v,
> >>>                         uint64_t bo_flags)
> >>>   {
> >>> @@ -1139,7 +1159,11 @@ static int
> >>> amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
> >>>       if (ret)
> >>>           goto err;
> >>> -    ret =3D drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> >>> +    if (drm_drv_uses_atomic_modeset(dev))
> >>> +        ret =3D drm_framebuffer_init(dev, &rfb->base,
> >>> +                       &amdgpu_fb_funcs_atomic);
> >>> +    else
> >>> +        ret =3D drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_fun=
cs);
> >>>       if (ret)
> >>>           goto err;
> >>
>
