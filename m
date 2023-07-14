Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00C0754072
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjGNR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjGNR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:26:35 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77713593
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:26:34 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-48143577cfbso784561e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689355594; x=1691947594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mAgclljv5o/aMLISpskQlH5O1cIlPLCvHjF6I6Xhl0=;
        b=Sdi50qWxDVmpfpR9yAOwbvMJxkNACxSHIvPlQHn5QW/ydralkVzyW5PFYQc6Cw4/be
         ml9ZdsspIYAzUcQuuvxXXAAXsR9xd+6POVL61o7KP5W2gNnOkGIsR/ZFG3baDTX4itdA
         3bBxUi31Zeja1jKQetbHYEFl82edDdiIuo1+2kgx+6O30sxlQIHgKd2YDXrw5LwER8qD
         4vqerJ5kO/2LEwGbbQyXAfsYFdz5ZKS0J477V5LuUfz+ZrCcNG7Qj9wNYLrf6CG1v4Jl
         nCtCIe2j41HUkrdOciCP/aF1s5ex0Rd8h01ZRMYmohv9cvcwratBam6mijBSs2artuyF
         1HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355594; x=1691947594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mAgclljv5o/aMLISpskQlH5O1cIlPLCvHjF6I6Xhl0=;
        b=Z96FOTzal5XmvrHwOTCA2BrtalNyFKiIYItib0or+fVTNu0gktGhyRMvM/A4yLR39M
         vTeNrtBDBWSRLgJ1AKqUmRZ/M9d6/+KBp4uONUOHBzjFIW4dBudpthgnvXxVQcVoRsTl
         XFbXgmkwddCsGMT4XU3KZvKXaHLQ5z64FptZrtcSfpsFmbFhIduC21tKmh29XOC5AAY6
         AFpqy1+0CHWdo8D6TG+sK9RwL5sbWCFtjEyVYAE546IwuHHHFZjGI/Ix/OyOiWL1jnLJ
         n6shWWvadC9NAbUiJLSwZVlVrt+3RPxt3MLmNmmcbtAIuO+m5F3Dk8tISglgNbMZfPAL
         RcaQ==
X-Gm-Message-State: ABy/qLaIj8Iiiz44zcEn5fOsumKTXvRwQoBylVtgMgfG11zZQOFY8aGc
        k9QcdH7fGJNoiLFIKpsQu1b/BXY4FZTmuXXn3TU=
X-Google-Smtp-Source: APBJJlFHbcDnDvP4z879dm67J+CIsQU+E2UFFcItQwOdwy7jRkl60+B8Hlu1ITKA4UEn0reT1KdxVabKqwM1RP7+WBM=
X-Received: by 2002:a67:b901:0:b0:443:8898:2a50 with SMTP id
 q1-20020a67b901000000b0044388982a50mr2784041vsn.35.1689355593821; Fri, 14 Jul
 2023 10:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230713163626.31338-1-jim.cromie@gmail.com> <20230713163626.31338-21-jim.cromie@gmail.com>
 <07f0c6ac-f195-e598-4649-e88ad5e76005@infradead.org>
In-Reply-To: <07f0c6ac-f195-e598-4649-e88ad5e76005@infradead.org>
From:   jim.cromie@gmail.com
Date:   Fri, 14 Jul 2023 11:26:07 -0600
Message-ID: <CAJfuBxy7Z+=5b2rP0diRUYT0a8wsZvD9+vUh+cBOX2eeGG04ig@mail.gmail.com>
Subject: Re: [PATCH v4 20/21] config TEST_DYNAMIC_DEBUG default m
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, gregkh@linuxfoundation.org
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

On Thu, Jul 13, 2023 at 1:04=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi Jim,
>
> On 7/13/23 09:36, Jim Cromie wrote:
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  lib/Kconfig.debug | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d4fbbcc395d2..82d11ac63758 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2696,13 +2696,14 @@ config TEST_STATIC_KEYS
> >
> >  config TEST_DYNAMIC_DEBUG
> >       tristate "Build test-dynamic-debug module"
> > +     default m
>
> You need to justify such a change, and since it's not required
> for running the system, I don't think it should be 'm'.
>

meh, now I cant "justify" the bored/curious comment. ;-)
I'll drop this patch.

> >       depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
> >       help
> >         This module works/demo's the dyndbg's classmap API, by
> >         creating 2 classes: a DISJOINT classmap (like DRM.debug)
> >         and a LEVELS/VERBOSE classmap (where 2>1).
> >
> > -       If unsure, say N.
> > +       If unsure, say N.  If bored/curious, say M
> >
> >  config TEST_KMOD
> >       tristate "kmod stress tester"
>
> --
> ~Randy
