Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680977E2C10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjKFScw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjKFScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:32:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076EB1705
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:32:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso8056394a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699295542; x=1699900342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soe8+lEThbuxrauS3i3IgwpF8YYQwLOsQWEzb/VsikE=;
        b=oAs4IjEFRF95ingHHSaA9Uf96HNWtATpQJ+CVJjEtVqCLnvh8hvVaxR5bOEUVgwkyb
         Uap4+3726rES8bomRI4pEbjg1etNdHa+YjXLlOze62fUCyb/LUs78FlTAIDwwaqqZQQN
         cs5RBRm0mr6SXdqwbqKO98EWN8vp4MB+mhiJ6jLH+p6CLIYj9DxCRXxIcm1gErE86z6T
         XhhVq2qRSmVYSCzUvb8E2xWmSO838sVjZlSmiUumc/J0819FmX16QlWk64y7xxymOV4g
         Zx2FWXonlVEv9K88jgp4Rrv/BC8bCaqWq3dr+QdAKtZdjfG80c7e+tbQ/CoY15Ioo7Vc
         ifeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295542; x=1699900342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soe8+lEThbuxrauS3i3IgwpF8YYQwLOsQWEzb/VsikE=;
        b=hg4FExjj6ZAjnJy4/EVfRrJ0z0LKDkBLNZNqUVLxDMFQB8CkboV94akXhvxp8iwC+h
         VA8ReusBpaZw2RJWnSxiOwfhg9ZMzRrOz0gHuxYlt9h/RG6sDBfykM+wRItPSHTAVJHA
         8vA1/6xTVwtoO2GoV4nzw2P6IwAdWAPK+GeghGvAEVsdVHJUXXAWJHLmuo3DTgFwprcZ
         K9jGClL4LiwmZcXFOL2iFi3Bd2pSUkMlN5e3V3w+LJyzDDKaezHtVGBoo8l+VfRSWpGi
         1nt61i5pDxd0J49kpKmwP2fDtIDF8Jg3QNXW2ybex80GWVSPg6LA028bjERpsrjxTvO7
         vrtw==
X-Gm-Message-State: AOJu0Yyu7l6fMFUuFl8RmPhbYSOdDZrOLw1v0MV9qse4YxlgaJhYwFjj
        YZtU+YOC4kcv7ySMEPSGpNQxDBG3h0tZn+s1kY8Uhg==
X-Google-Smtp-Source: AGHT+IE3COqO7suPYWfkaoTj6yDKUl996sDTArem8FR8xxzofLxH2XDlLxKp5WUB3vgbmOm3yFfyau3xkkh6Cxyv/u0=
X-Received: by 2002:a17:907:9413:b0:9b2:b691:9b5f with SMTP id
 dk19-20020a170907941300b009b2b6919b5fmr14911910ejc.41.1699295542171; Mon, 06
 Nov 2023 10:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20231104134708.69432-1-hunter.chasens18@ncf.edu>
 <ZUhvj2uj_PvaDxIM@debian.me> <8734xj18ck.fsf@intel.com>
In-Reply-To: <8734xj18ck.fsf@intel.com>
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
Date:   Mon, 6 Nov 2023 13:32:11 -0500
Message-ID: <CAFJe6O1oJnQvLVSJZP6MMXULGrX=a3SEO1X5b4xff06WhqLw_g@mail.gmail.com>
Subject: Re: [PATCH v1] docs: gpu: rfc: i915_scheduler.rst remove unused
 directives for namespacing
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, corbet@lwn.net,
        Luca Coelho <luciano.coelho@intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running `make htmldocs` the following warnings are given.

```
Documentation/gpu/rfc/i915_scheduler.rst:138: WARNING:
Unknown directive type "c:namespace-push".

.. c:namespace-push:: rfc
Documentation/gpu/rfc/i915_scheduler.rst:143: WARNING:
Unknown directive type "c:namespace-pop".

.. c:namespace-pop::
```

The kernel test robot also reported it here.
Link: https://lore.kernel.org/all/202311061623.86pTQrie-lkp@intel.com/

Last year Maryam Tahhan <mtahhan@redhat.com> from Redhat noticed something
similar. "The missing support of c:namespace-push:: and c:namespace-pop::
directives by helper scripts for kernel documentation prevents using the
``c:function::`` directive with proper namespacing." From the context, it
sounds like this was brought about from a Sphinx update.

Link: https://lore.kernel.org/all/20221123092321.88558-3-mtahhan@redhat.com=
/

When compiled the `.. kernel-doc::` literal gives it the same formatting wi=
th
or without the namespace directives present. Due to the above information I
think it safe to remove these, as they don't seem to do anything but
throw warnings.

On Mon, Nov 6, 2023 at 5:31=E2=80=AFAM Jani Nikula <jani.nikula@intel.com> =
wrote:
>
> On Mon, 06 Nov 2023, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > On Sat, Nov 04, 2023 at 09:47:08AM -0400, Hunter Chasens wrote:
> >> diff --git a/Documentation/gpu/rfc/i915_scheduler.rst b/Documentation/=
gpu/rfc/i915_scheduler.rst
> >> index c237ebc024cd..23ba7006929b 100644
> >> --- a/Documentation/gpu/rfc/i915_scheduler.rst
> >> +++ b/Documentation/gpu/rfc/i915_scheduler.rst
> >> @@ -135,13 +135,9 @@ Add I915_CONTEXT_ENGINES_EXT_PARALLEL_SUBMIT and
> >>  drm_i915_context_engines_parallel_submit to the uAPI to implement thi=
s
> >>  extension.
> >>
> >> -.. c:namespace-push:: rfc
> >> -
> >>  .. kernel-doc:: include/uapi/drm/i915_drm.h
> >>          :functions: i915_context_engines_parallel_submit
> >>
> >> -.. c:namespace-pop::
> >> -
>
> What makes the namespacing unnecessary?
>
> $ git grep '.. kernel-doc:: include/uapi/drm/i915_drm.h'
> Documentation/gpu/driver-uapi.rst:.. kernel-doc:: include/uapi/drm/i915_d=
rm.h
> Documentation/gpu/rfc/i915_scheduler.rst:.. kernel-doc:: include/uapi/drm=
/i915_drm.h
>
> And you get [1] and [2].
>
> >>  Extend execbuf2 IOCTL to support submitting N BBs in a single IOCTL
> >>  -------------------------------------------------------------------
> >>  Contexts that have been configured with the 'set_parallel' extension =
can only
> >
> > The warnings go away, thanks!
>
> What warnings go away?
>
> BR,
> Jani.
>
>
> [1] https://docs.kernel.org/gpu/driver-uapi.html#c.i915_context_engines_p=
arallel_submit
> [2] https://docs.kernel.org/gpu/rfc/i915_scheduler.html#c.rfc.i915_contex=
t_engines_parallel_submit
>
> >
> > Fixes: f6757dfcfde7 ("drm/doc: fix duplicate declaration warning")
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> --
> Jani Nikula, Intel
