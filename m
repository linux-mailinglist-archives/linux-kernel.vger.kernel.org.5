Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2DD80EF95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376422AbjLLPFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjLLPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:05:20 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49234AA;
        Tue, 12 Dec 2023 07:05:26 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1feeea75fbfso3843514fac.3;
        Tue, 12 Dec 2023 07:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702393525; x=1702998325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZlcAkwpOLN8dI+Xyv/fIf9Doln7vlIRnH/1QEelY2c=;
        b=LAvliRiCrUaWjACDI2I6tFioP5VMh2RHqomdpsaX0HM8HZgbKmbe2cOwr3zSlpifc3
         t14NLEMXvUfEy/oF4U+Iiw+lxbiM4yYx9jXOuuDk/r175SFzxXOXxZ1wMCbBg0hW6E41
         q6pPziz8JCCRKbJ0Pjr/cR/XFpUzb6OhxAgGeeZOKLwYpYEd/b+m0svgDBOGVrpFwrGE
         GWwIR3DHyk8D5E668L9OzpsnddcHj440VUHlQpOgMVxxwlPX79k6ws6xZa6DWwmxhBjL
         XD0n9EvAHQaD9f9nZgTIKO47H7k6v76SyOp9LzA3nm305aRVo76J5M32xXyPX3lrfgpO
         Su5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393525; x=1702998325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZlcAkwpOLN8dI+Xyv/fIf9Doln7vlIRnH/1QEelY2c=;
        b=Gpv8Q6Z/txPijiId8fFLPw+iBIY+F/AC2YWGPHEs2OjtFAxgtsHrdW66e3x0JMqFDR
         TRpF0GfkZgY8m1PaMp/P8SEWxeUQz/ystUzo0Ajan/Ec0nfZuXZm3WffOmI4otYfM136
         4U3hxkTVcq+aNZWuhO3I1cGPaP3L/9dnu5OVw0InSjyiYec6KsijiD28U+4LMYQs7nvv
         qfC9it2iRfCw3gGiyp+GwId8afvY1vjBBPZ/Z0hpzrz/QjDKSwdJBZRsiLAhY4yNxXDa
         SHTo3xcDFSdaUrdL69bwYDbbn3KDOktPPr/5irbN/l0Ou4V6eIkI8t5m2DFNZmokPzn9
         nu0Q==
X-Gm-Message-State: AOJu0YxD8pKLM7mnwqUgFn3exABkAyrEnnZDdxxBx27VpO4uq4JJ57dW
        OndsafID4MLnyRnbZwJH/6IhSVIXLF7zwrHExpI=
X-Google-Smtp-Source: AGHT+IEvVnV0yK8+EB7ShGHex+/thdL3le4AIysKjBzLXZiLoBhD7nDJseZJrG+ivC8oDEwoUazhqbq1SFJsrdgOO9I=
X-Received: by 2002:a05:6870:a54d:b0:1fa:2d2c:9ca4 with SMTP id
 p13-20020a056870a54d00b001fa2d2c9ca4mr5797061oal.49.1702393525463; Tue, 12
 Dec 2023 07:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20231212110415.6f849fb4@canb.auug.org.au> <20231212140134.13ffafa8@canb.auug.org.au>
 <20231212090159.hshy6elwhgkkhuzb@mail.igalia.com>
In-Reply-To: <20231212090159.hshy6elwhgkkhuzb@mail.igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Dec 2023 10:05:14 -0500
Message-ID: <CADnq5_N3LH_tb8hOeD32Wd_T3ZB0CRpwbz=CULr=UJoF65-wDg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the amdgpu tree
To:     Melissa Wen <mwen@igalia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Tue, Dec 12, 2023 at 4:02=E2=80=AFAM Melissa Wen <mwen@igalia.com> wrote=
:
>
> On 12/12, Stephen Rothwell wrote:
> > Hi all,
> >
> > On Tue, 12 Dec 2023 11:04:15 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> > >
> > > After merging the amdgpu tree, today's linux-next build (arm
> > > multi_v7_defconfig) produced this warning:
> > >
> > > drivers/gpu/drm/drm_atomic_uapi.c:366:1: warning: 'drm_atomic_replace=
_property_blob_from_id' defined but not used [-Wunused-function]
> > >   366 | drm_atomic_replace_property_blob_from_id(struct drm_device *d=
ev,
> > >       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Introduced by commit
> > >
> > >   1d2b049e4582 ("drm/drm_property: make replace_property_blob_from_id=
 a DRM helper")
> >
> > This became a build failure in the i386 defconfig build, so I applied
> > the following patch for today.
>
> Yes, I also noticed it yesterday when building amd-staging-drm-next.
>
> Something went wrong when they applied this patch:
> https://lore.kernel.org/amd-gfx/20231116195812.906115-3-mwen@igalia.com/
> and your patch below is exactly the part of this patch ^ that is
> missing.

I'll ask the display guys what happened there, but in the meantime,
I'll fix that up.

>
> In addition, only the first four patches of the series were applied.

The rest were still going through CI when I pushed out my updates.

Alex

>
> Thanks,
>
> Melissa
>
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 12 Dec 2023 13:53:55 +1100
> > Subject: [PATCH] drm: remove unused function drm_atomic_replace_propert=
y_blob_from_id()
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/gpu/drm/drm_atomic_uapi.c | 42 -------------------------------
> >  1 file changed, 42 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_at=
omic_uapi.c
> > index 70ddbb93e466..29d4940188d4 100644
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -362,48 +362,6 @@ static s32 __user *get_out_fence_for_connector(str=
uct drm_atomic_state *state,
> >       return fence_ptr;
> >  }
> >
> > -static int
> > -drm_atomic_replace_property_blob_from_id(struct drm_device *dev,
> > -                                      struct drm_property_blob **blob,
> > -                                      uint64_t blob_id,
> > -                                      ssize_t expected_size,
> > -                                      ssize_t expected_elem_size,
> > -                                      bool *replaced)
> > -{
> > -     struct drm_property_blob *new_blob =3D NULL;
> > -
> > -     if (blob_id !=3D 0) {
> > -             new_blob =3D drm_property_lookup_blob(dev, blob_id);
> > -             if (new_blob =3D=3D NULL) {
> > -                     drm_dbg_atomic(dev,
> > -                                    "cannot find blob ID %llu\n", blob=
_id);
> > -                     return -EINVAL;
> > -             }
> > -
> > -             if (expected_size > 0 &&
> > -                 new_blob->length !=3D expected_size) {
> > -                     drm_dbg_atomic(dev,
> > -                                    "[BLOB:%d] length %zu different fr=
om expected %zu\n",
> > -                                    new_blob->base.id, new_blob->lengt=
h, expected_size);
> > -                     drm_property_blob_put(new_blob);
> > -                     return -EINVAL;
> > -             }
> > -             if (expected_elem_size > 0 &&
> > -                 new_blob->length % expected_elem_size !=3D 0) {
> > -                     drm_dbg_atomic(dev,
> > -                                    "[BLOB:%d] length %zu not divisibl=
e by element size %zu\n",
> > -                                    new_blob->base.id, new_blob->lengt=
h, expected_elem_size);
> > -                     drm_property_blob_put(new_blob);
> > -                     return -EINVAL;
> > -             }
> > -     }
> > -
> > -     *replaced |=3D drm_property_replace_blob(blob, new_blob);
> > -     drm_property_blob_put(new_blob);
> > -
> > -     return 0;
> > -}
> > -
> >  static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
> >               struct drm_crtc_state *state, struct drm_property *proper=
ty,
> >               uint64_t val)
> > --
> > 2.40.1
> >
> > --
> > Cheers,
> > Stephen Rothwell
>
>
