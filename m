Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD076F3FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjHCUVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHCUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:21:40 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0623A4215
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:21:40 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4475af775c7so597900137.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691094099; x=1691698899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSaRAjLMTa67lFk5QZwB/CpwmOcN1LDlBkoWiiPNHX0=;
        b=S2LXdDKSgccv1prhAF8Z0oKo1xmicxyewP0ylBhuICK2rO/fsSjef3jFU/28NJ3Vh1
         WyXNOi2jAPT0ODKE80piyhpf+XC+KO14qoq4Zoq9pxkFvuS+D2a8yfb562h8HIX6AEVF
         ch5p1S7/7QdkjxqxTnXku3kQTsVPaQDaUh5EfbRUaCprqY2YJTNY+lFJ8hQOdhtnnyJ8
         QqTaODyCa/GBNPH6fxj5g2iNTLieOqvxoez8ocqemnPGBtsl+ns4zbS4tkGe113R9mG/
         EmWP7hTP8mPWwhpZzOshyk7rlRKtsUMGcRFGAd1dhHj6GV5xqfNRF4asRtTybLNxarB7
         Y1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691094099; x=1691698899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSaRAjLMTa67lFk5QZwB/CpwmOcN1LDlBkoWiiPNHX0=;
        b=aBRwLl9ouM+m0mUYSo5Inyyvh2wAZ/SGJkSoWnU0r+Rqc6NNQuh+QcDdlPGbhPpi26
         pHlKQ4wC3PKnI+cHr4VtOvz85G3wLaI9K8jawV62exyCm+pH2cQzVfGf98PhVseGth6p
         t8T2JYswvUoR3aaATyA0FXApXloAS+aZTIeJJguICf0JX/UB/uDM+i9vci4jOuYcjAO/
         Icvhi/lwQQKyHm8fSS4t1E0KMVOvLUxTEPScTXADhLaLe9LLMFWVw8W66j/sH6yf+DH1
         O3J4GByTlvGI8cNIW71atzfGvdqbhtXGqtpuU5238CNHLDzrIHgpxg/fl+aAS3HsYNXN
         t03w==
X-Gm-Message-State: ABy/qLaJLPNkIXcmsBHsiPKCXHgB/2SsKx64KodfrwdcEo4yzAiZGoPM
        +BI3NqpVxspiNG9EHYxqoCzKClls4pYtbD8o/UkzZJi4/b/Wkg==
X-Google-Smtp-Source: APBJJlG1CySCstG+XEKldbhygdyS13vjgjak8avQeTacOxbhbG8cLi/Juych8hTizx9FjNhgErCFMh1d0Escb3V3rHQ=
X-Received: by 2002:a67:bb04:0:b0:443:895d:1b53 with SMTP id
 m4-20020a67bb04000000b00443895d1b53mr8351230vsn.10.1691094099065; Thu, 03 Aug
 2023 13:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230801170255.163237-21-jim.cromie@gmail.com> <202308031432.fcb4197-oliver.sang@intel.com>
In-Reply-To: <202308031432.fcb4197-oliver.sang@intel.com>
From:   jim.cromie@gmail.com
Date:   Thu, 3 Aug 2023 14:21:13 -0600
Message-ID: <CAJfuBxzq_5skGRkcdK9kJBE_qL8X_waq88XsUO-FHyVQkQUb4w@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v5 19/22] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG
 un-BROKEN
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        daniel@ffwll.ch, jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        linux@rasmusvillemoes.dk, seanpaul@chromium.org, joe@perches.com
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

On Thu, Aug 3, 2023 at 1:14=E2=80=AFAM kernel test robot <oliver.sang@intel=
.com> wrote:
>
>
> hi, Jim Cromie,
>
> we send this report to you to consult that if there is any limitation to =
use
> this CONFIG_DRM_USE_DYNAMIC_DEBUG?
> attached config is a randconfig which has CONFIG_DRM_USE_DYNAMIC_DEBUG, t=
he
> kernel built with it failed to boot in our tests, but we also tested with=
 some
> other config then the issue cannot reproduce.
>

Theres no limitation I know of - particularly not CONFIG related

on an earlier version, I saw some odd transient / red-herring
linker-errors (collisions on __UNIQUE_ID constructs)
on s390, mips, older gcc (iirc - I could go find it in lkp-reports if
its meaningful)
that had me hacking at the fallback which uses __LINE__
But this seems different.
