Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F797FD9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjK2Oiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjK2Oir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:38:47 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2391729
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:38:47 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db4422fff15so5794777276.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701268727; x=1701873527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VitFHUDO7lpbwwEpDiSX9K6mtclW0i9+NRl7WDJQuXM=;
        b=tv9+mf4hYoDk2xZVeAIJdYreaEHWjLUGLhDOAO/tn2VtPl6lwH9TdhaWK5+dWBHTU4
         Plp9EcaGrWtxPw54QBz0jC2vfcArJEWLQzq7Q3WRpwE5oJqfhrveKQC3fZl/Zam3RH+p
         eEcgM6MfrA5GQdmWd/0Yjm3fF0Y3GZmJVJLGK+v9ToKXjFM3h5XB77bIAbFSoUNgFsk/
         h756/FEFdU26kTXFBRKjbRhSf1awhRuxTIwOQ/aiYHa1c2OIE9QExxyVqcm1eBjdhHL0
         edgecgfP2kut6lfEGYrXfNlmPUOitk2bY2MjtDwD589wjrkIGSiz7i1mNGgMA9CMG0So
         P+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268727; x=1701873527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VitFHUDO7lpbwwEpDiSX9K6mtclW0i9+NRl7WDJQuXM=;
        b=meesrdJOxDttJhIVTlXXkYwY+PIZ33ibwfFg7K/fQkCc+EBmuTiHeU/i/YHceFxdTK
         puT64poAkCmXBRm31It0rO5SEiOV+xQGeSf0hLYK+jy35ghV/F3+KoFCx2XkohOyZ2AF
         lxO6ZPZzgxcV65GByLJFH7929Rr2MSMuG5kCTMuJVYiuw0Fr08FOFQ2sGrIi0wOxhpOK
         zF4TiS4BA4+rvKPM7rioI/0X+PavOlClVl30MCZII+l9B9z6tScAe0W1dkJq0fHu2h16
         +oYtmsVmBrgIImMU/5Bj+khQnCMtcGZsLIDOfXyVTASBayBPUzVqUnnj+BnlGR51BGZk
         wcfA==
X-Gm-Message-State: AOJu0YwjoGLejdcqxVqm6tP+aDp7yNsZ46Zaj7fqg3D8jiSlpJwQikfx
        Fl7To4+yuxVXZ7Q91bFK3DVW7eIc/aOONVWu+Vw4Rg==
X-Google-Smtp-Source: AGHT+IFn9m5/2pvXGrsuZL1JkkJ7wo07TKiyWdKmwMqkGOMa7/9+521wEHRtk/MN9ZsmYdiUXcwuztNOZ8LxPBTuDFQ=
X-Received: by 2002:a25:fb0b:0:b0:d86:5a8d:6e34 with SMTP id
 j11-20020a25fb0b000000b00d865a8d6e34mr17592236ybe.29.1701268726832; Wed, 29
 Nov 2023 06:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20231127051414.3783108-1-victor.liu@nxp.com> <CACRpkdZAtxh5muhbPKvmUQGtQogs3UhGxNZqnSGWoWQNUL7=9g@mail.gmail.com>
 <k65hxlckssjd46nsrlly6vjrr5nnkrakouzw5pmxgbf6ui3mdl@5ny7j7blkwyj>
 <CACRpkdbKwycpjuhMfnriqMUcbmwCTb3vJzgzCF7+ARax54q7WQ@mail.gmail.com> <d33ovl3ox2u74jbik2bcraeqiqplqoc57p4quapdyydqlyzrf5@vlhszortxfio>
In-Reply-To: <d33ovl3ox2u74jbik2bcraeqiqplqoc57p4quapdyydqlyzrf5@vlhszortxfio>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Nov 2023 15:38:35 +0100
Message-ID: <CACRpkdb1DmH2NJ2nBRtGaB+9Tmbn1tzXafDSpZVxjCFnexz=3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: panel: Check device dependency before
 managing device link
To:     Maxime Ripard <mripard@kernel.org>
Cc:     daniel@ffwll.ch, Liu Ying <victor.liu@nxp.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, angelogioacchino.delregno@collabora.com,
        ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 1:32=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
[Me]
> > It is a bigger evil to leave the tree broken than to enforce formal pro=
cess,
> > and it is pretty self-evident. If any of them get annoyed about it we c=
an
> > revert the patch, or both.
>
> Yeah, I definitely understand why you did it, but I don't think it's
> something we would encourage in drm-misc.

Hm OK I guess, it can be debated but no point in debating it either.

> We've discussed it with Sima yesterday, and I think we would even need
> the extra check in dim to make sure that a committer shouldn't do that
> without dim complaining.
(...)
> Sima played a bit with it, and it should be doable to get something
> fairly reliable if you use get_maintainers.pl to retrieve the git tree
> (through scripts/get_maintainer.pl --no-email --no-l --scm) and figuring
> out if only drm.git, drm-intel.git or drm-misc.git is involved.
>
> If it isn't, then we should check that there's the ack of one of the
> maintainers.

So check for any code that is hitting namespaces outside drivers/gpu/*
Documentation/gpu/* or include/[uapi/]drm/* that it is ACKed by the respect=
ive
maintainer for that area of the kernel?

> Could you write a patch to do so?

Patch dim? Well my bash skills are a bit so-so. But I guess I could
learn it. But did you say there is already a prototype?

Yours,
Linus Walleij
