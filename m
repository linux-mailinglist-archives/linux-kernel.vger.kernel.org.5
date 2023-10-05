Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492A7BAE36
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjJEV5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:57:12 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8141295;
        Thu,  5 Oct 2023 14:57:11 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1e1b1b96746so924252fac.2;
        Thu, 05 Oct 2023 14:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696543031; x=1697147831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAYKChfRdgudPucMl+HqonIt/5AX5oN5CCdBSnTYy0c=;
        b=bjvf6wpq7yI0gGDm3xsQPU5ihcI64ca8P+cCefKl7l2C1eQ9bwadTkaCcUXZyLwriM
         F8zOh7onMzlhIQSVncOO/pAqnSn4Yg8uA10Txgud2GTdiMVrXlcN+lRYE5msk9BeNAHH
         lwCLArOJJGxOooO+J8d/jluLezoFvQJ37OgIKC/ryDDih7OkQsdq8ED7f3La4DiRXQT/
         ur0gl7kRr1Bxz3DfA297mW0LRtmLLIoiarOzHHx2yZbvLaive7nS3AN8nFtsZgKormWf
         MGBi1nHnaCGR5gYoRpkKajtZwHHcOMHbkPhDjcuzbFqoTrfUN08PXyyWUfVWhp/Pe25N
         HAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696543031; x=1697147831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAYKChfRdgudPucMl+HqonIt/5AX5oN5CCdBSnTYy0c=;
        b=thXIZyq8mEbhYh1WkD9K7heTex7ySuBGLetsl2FMeYcvF8OvLueXoxmCfBTLflS3qD
         45Adh7KiJ+RqC9Zv7OccYAdzIGwPiUflY2SRnKqL19Bu8lwA9LnWA93xqh+u9PTn9PfF
         QO1BRK1ZIUemmLXMIw8rOZn7o9HWJ/VMfbzGsQeUGuStQAClvM9M7GPu1uF3g/wFzrB2
         4saGccx87ee7C4JX6jiTD8q90I8vELmeOYPl0nI23/YLQbHqWZCuurbarR+iAyc9i139
         yPFpiUK2NeiAYLPy7TpWPLy1GJTdWjvpSDynXkIr+c42q6iHNN29bTvdcIozkosy8G+n
         lBDw==
X-Gm-Message-State: AOJu0YynAkhr+QPMWQ2ndRrVU6z2bhS/ntaHZKXLTv1Sr1yjMFpr2WR+
        25k60EB0qOF7F1cEvLq6pTgummwhdTU6OGZF6yM=
X-Google-Smtp-Source: AGHT+IE7Mh8ZxS9AEdUoRo8DfhqsdjKx0m14eBvMkDCkjbKr9ARO/M6kPfpebfea3wIhcrXCtgeKYHTEYOpyT1BJiWU=
X-Received: by 2002:a05:6870:888b:b0:1bb:8842:7b5c with SMTP id
 m11-20020a056870888b00b001bb88427b5cmr7517247oam.43.1696543030835; Thu, 05
 Oct 2023 14:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231003232952.work.158-kees@kernel.org> <ca2006f4-a038-460d-a9ca-d14dca8e4a8b@gmail.com>
In-Reply-To: <ca2006f4-a038-460d-a9ca-d14dca8e4a8b@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 5 Oct 2023 17:56:59 -0400
Message-ID: <CADnq5_MfkVQNU268wg1b6AStnELjvrpgU4Xrf_k-Qa2KsXGcmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Annotate struct amdgpu_bo_list with __counted_by
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Tom Rix <trix@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Oct 5, 2023 at 10:32=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 04.10.23 um 01:29 schrieb Kees Cook:
> > Prepare for the coming implementation by GCC and Clang of the __counted=
_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> > array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct amdgpu_bo_list=
.
> > Additionally, since the element count member must be set before accessi=
ng
> > the annotated flexible array member, move its initialization earlier.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-hardening@vger.kernel.org
> > Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/exampl=
es/counted_by.cocci [1]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_bo_list.c
> > index 6f5b641b631e..781e5c5ce04d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> > @@ -84,6 +84,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev,=
 struct drm_file *filp,
> >
> >       kref_init(&list->refcount);
> >
> > +     list->num_entries =3D num_entries;
> >       array =3D list->entries;
> >
> >       for (i =3D 0; i < num_entries; ++i) {
> > @@ -129,7 +130,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *ade=
v, struct drm_file *filp,
> >       }
> >
> >       list->first_userptr =3D first_userptr;
> > -     list->num_entries =3D num_entries;
> >       sort(array, last_entry, sizeof(struct amdgpu_bo_list_entry),
> >            amdgpu_bo_list_entry_cmp, NULL);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_bo_list.h
> > index 6a703be45d04..555cd6d877c3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> > @@ -56,7 +56,7 @@ struct amdgpu_bo_list {
> >        */
> >       struct mutex bo_list_mutex;
> >
> > -     struct amdgpu_bo_list_entry entries[];
> > +     struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
> >   };
> >
> >   int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
>
