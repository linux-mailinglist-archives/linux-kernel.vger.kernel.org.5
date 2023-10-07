Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47F7BC553
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbjJGHCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbjJGHCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:02:01 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D8E9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 00:01:58 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7b07719089aso1854045241.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696662117; x=1697266917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MV3fajDywtr5Jk/wqj0ujD7RNZVpvrV8ESz+9hWBpd0=;
        b=I9n84xpWpBO0XndI8Z5RLDA5GxcpmDtpn2w31uRdWwEyADF8iHDc4CTY/JztTcTYo1
         h2/tfI0wFQR1F0j8ESBUxC+H94lSYM9Ht2Wy5XrZMnWKYDCV/XJpvzbsuIiVIcIEp9AJ
         /NWFX93vLeKGPBvXIy537ALEh31znUxDtk4LXf56tpx/QK9hV3eGl4/H/ps+cHjR0uaG
         RKNqLAkwuAoB2thnFrehVhAiSUuw/pD67AEobX7vDdNn/Pi/H7bF1XbrQpQxQq3EV0SV
         xyFnB09mXgYKZ7HyM8e+ssXTE+aqFEpqiLne8B07YASACkm+/Gk4LTu8q1nylpE1RJOP
         Mv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696662117; x=1697266917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MV3fajDywtr5Jk/wqj0ujD7RNZVpvrV8ESz+9hWBpd0=;
        b=d1pxl1yosMH6agcFk9MTlrOo17p3y8/6WJcSDx75Y9m29X2i1eN5bc7fvxmNpyXSZn
         T8eHCnzA//0ZvPHciSaR7wMZ1vpUpem+d3+hlef+ViicQqoYR3ePF7+qP6ox/VTMnb0N
         MwKYqnlhKR+2sU7Fnc8bedahWw/E7GJeQlR97tJu/t3OF0WJvOUDrEZBqOftCoiu3uHt
         rzL69WU5ryBf32UBzpXmXHGVbv/LIax0bdQr4i/3uyFpZbu0GTUIlnb0BMioeit8aDbS
         uHzTXNllloh7+aFaWxBOzanKENUqr+i5rlbd6s8xqMUdMKOaqL272lnvS9Jo6IKBtO2r
         6i0A==
X-Gm-Message-State: AOJu0YzdjeGQ25cthMM6CXxFN084FsRm4xv8CAmTGTLw+5iWFLW3nDTa
        9NWOIPiOFNlDUCVGZpRjHt7RuxTXEw++Upn07pDOHQ==
X-Google-Smtp-Source: AGHT+IFdohtRGFQRlUDkLz2okiPnrDtwhF5TIH53ApeAk1hNpPge1IoFBRrCXopD2OE2Wl7moP3v7EkCp1ZdUfX3vG4=
X-Received: by 2002:a1f:9889:0:b0:49d:2a13:58fc with SMTP id
 a131-20020a1f9889000000b0049d2a1358fcmr3336138vke.2.1696662117155; Sat, 07
 Oct 2023 00:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696605143.git.andreyknvl@google.com> <1c4eb354a3a7b8ab56bf0c2fc6157c22050793ca.1696605143.git.andreyknvl@google.com>
In-Reply-To: <1c4eb354a3a7b8ab56bf0c2fc6157c22050793ca.1696605143.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 7 Oct 2023 09:01:21 +0200
Message-ID: <CANpmjNM7rytkGRjyG3Pf5PakCdibtpvsm7o-K3am-U0kT-d2Rw@mail.gmail.com>
Subject: Re: [PATCH 5/5] Documentation: *san: drop "the" from article titles
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 at 17:18, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Drop "the" from the titles of documentation articles for KASAN, KCSAN,
> and KMSAN, as it is redundant.
>
> Also add SPDX-License-Identifier for kasan.rst.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  Documentation/dev-tools/kasan.rst | 7 +++++--
>  Documentation/dev-tools/kcsan.rst | 4 ++--
>  Documentation/dev-tools/kmsan.rst | 6 +++---

UBSan also has it: https://docs.kernel.org/dev-tools/ubsan.html

Reviewed-by: Marco Elver <elver@google.com>

>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 382818a7197a..858c77fe7dc4 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -1,5 +1,8 @@
> -The Kernel Address Sanitizer (KASAN)
> -====================================
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (C) 2023, Google LLC.
> +
> +Kernel Address Sanitizer (KASAN)
> +================================
>
>  Overview
>  --------
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index 3ae866dcc924..94b6802ab0ab 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  .. Copyright (C) 2019, Google LLC.
>
> -The Kernel Concurrency Sanitizer (KCSAN)
> -========================================
> +Kernel Concurrency Sanitizer (KCSAN)
> +====================================
>
>  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic race detector, which
>  relies on compile-time instrumentation, and uses a watchpoint-based sampling
> diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
> index 55fa82212eb2..323eedad53cd 100644
> --- a/Documentation/dev-tools/kmsan.rst
> +++ b/Documentation/dev-tools/kmsan.rst
> @@ -1,9 +1,9 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  .. Copyright (C) 2022, Google LLC.
>
> -===================================
> -The Kernel Memory Sanitizer (KMSAN)
> -===================================
> +===============================
> +Kernel Memory Sanitizer (KMSAN)
> +===============================
>
>  KMSAN is a dynamic error detector aimed at finding uses of uninitialized
>  values. It is based on compiler instrumentation, and is quite similar to the
> --
> 2.25.1
>
