Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594B07B5721
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbjJBPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbjJBPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:42:42 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17953A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:42:38 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1e141f543b2so1586996fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696261357; x=1696866157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58gyx6oEc50QSA+3gDO/VREfScg978m8wlhKnpLG5H4=;
        b=MEeJGuAN2iq7gj6pHSkDrzCPObKrGlqTN1kx3eR3Bn5pKWWfuYMgAnudD9ddAgrW4l
         dAV6Fdiyp6rqHAsBLz1akSlmORzyAExF3Bs66rCuoux3odTf6gNGV6X+GOYHFQ3Ri/Wv
         qVPpcGk1gVPERRLB2BmAirBBtCVe84qeWnSLIMFwYNgEy3+nHFMVso73GfLEXWwRRK8u
         Npd6mYU8q/n/TxFUFqJ6jzX140DnT0XOjlbJnuBpyB9jFE/VtbzqbbUqjj0MbvfF2+KL
         6Sn4VZJAJCJ5gfAZIw2qjgAbKJdI/dhLE+ZZu00jFNiOUW1+eP0wZxJKPbrcIdrZU/9x
         X+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696261357; x=1696866157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58gyx6oEc50QSA+3gDO/VREfScg978m8wlhKnpLG5H4=;
        b=xHifbcyFreYa3Lv0Qu+XLHr03oXyWlyF0tDORuOW03qpSjFjiqvDT6r3N9/YGn1tKp
         E9nrXPKyVuh+owe18W6VtbltaUKtSLpWG/1I2+cNfNCxF0GNehsNjiPDs34Tq02roiq2
         977cEYJaXouMc5o+nthwsg+bETmZRh0Y5LC0yMr+Lol+Oc77c5R2E7EWcq/VAC1NHxYt
         r5GtpRkZqXwb6Dgga8+nwK9vm5/1bhpLCAh7Jgq5FaXCIBxHa5jzMNaD103HqLeIZj76
         DgCo63fAEn23281lcTBaeS7rLTs6570sc4u2yQzBVs672ZOWuHV3gG+tlpzffLTkxSVO
         pcIQ==
X-Gm-Message-State: AOJu0YxvV5Q4UJEKJIZZPBUZlW7deOl70xPAPwcjUHUKoRxHE4UvwR5E
        pERrfgeExcmiUNCedtFvcNw4jA/Sw8SLe8ZDsrE=
X-Google-Smtp-Source: AGHT+IF1L56vI3YQQv53yGIQ1a46lmAD2KVRzqSjh+qVHKoefqWUH/aZXtXUupExWwKw2Ge/7vbvsl6V5Pa9JNRqgQs=
X-Received: by 2002:a05:6870:b612:b0:1dd:bd0:aa45 with SMTP id
 cm18-20020a056870b61200b001dd0bd0aa45mr6683398oab.18.1696261356863; Mon, 02
 Oct 2023 08:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231002010835.14798-1-rdunlap@infradead.org> <1d2ad4d8-49ff-17cd-ab2a-befcaf356dd9@gmail.com>
In-Reply-To: <1d2ad4d8-49ff-17cd-ab2a-befcaf356dd9@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Oct 2023 11:42:25 -0400
Message-ID: <CADnq5_PXf0uq07iPFFbtR-W4HMR6bmtU8PoemNY0P7vcUoU9Kg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: amdgpu_drm.h: fix comment typos
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
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

On Mon, Oct 2, 2023 at 6:32=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 02.10.23 um 03:08 schrieb Randy Dunlap:
> > Correct typos of "occurred".
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   include/uapi/drm/amdgpu_drm.h |    4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff -- a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -249,9 +249,9 @@ union drm_amdgpu_bo_list {
> >   /* unknown cause */
> >   #define AMDGPU_CTX_UNKNOWN_RESET    3
> >
> > -/* indicate gpu reset occured after ctx created */
> > +/* indicate gpu reset occurred after ctx created */
> >   #define AMDGPU_CTX_QUERY2_FLAGS_RESET    (1<<0)
> > -/* indicate vram lost occured after ctx created */
> > +/* indicate vram lost occurred after ctx created */
> >   #define AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST (1<<1)
> >   /* indicate some job from this context once cause gpu hang */
> >   #define AMDGPU_CTX_QUERY2_FLAGS_GUILTY   (1<<2)
>
