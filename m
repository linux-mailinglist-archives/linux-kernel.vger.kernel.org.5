Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25D67BEACE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378454AbjJITo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378433AbjJIToy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:44:54 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B394
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:44:52 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5859b06509cso2992322a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696880692; x=1697485492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRsKl3JqqRRAbEyiv7681Tqjj5VSz9Ev6khWg1QXw4E=;
        b=He54bgVsqP5oejQJKEI2yXDr7hXTp7xt4lx+CXW2GCXcXZXiuKSQSZ6E6LgewHJqqn
         EVziVbnk0N+sVkselZGRDcB2VuVyUUluAvL1a2CDTFIJC2UuCF4gnGbqze6AgfsEa+uc
         qrg5t0b+FDEOAu6tjkuycrHZemwOKfmwqMV3E7PVDYocXQxMy3kAEm4dqhaFDT4X7sYi
         /qa8zbvB/t9/pldf7q6v8QJvGkMUzxuknvIzay28I1EwtJCNnVpKwtpr5F267hLOQL9t
         G/gq9X2q8AafUxDlc1RIet+U0ehyo/2YLx7yvZspyp504ipbMJKc9pOMJTwKUJh0dk3r
         DvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880692; x=1697485492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRsKl3JqqRRAbEyiv7681Tqjj5VSz9Ev6khWg1QXw4E=;
        b=dDGghK2sc3DOsiDbHJdKctN476QQUhalGwhL92wSfEQJmf5x787XZYd8VG4Dgxbnss
         VWH6JjPDIzYKLntqzcDySy78lSxDimNElMgk+gIkgtYwN00TCIWD4Srw44ujstPNePcO
         a+6wL08MAaFrpGctI31mzZrIM1Gab8B2BGaJTSmvf9YXFi+oV4+v8Prk0Lnt7rRj2sRj
         ABx6uzdUGx9TZCJuMM+dbi2G8R/QcI03yLuxkPqmo0jxFb6XnzFvLD6uD3iQjq8zBJLi
         +Yzs0GC2KU7DHCIGpCEyXtkHcauSCpPSnb8CCvJZuTG/D3B2urje/qmd45yUIo3C1FGd
         Lctg==
X-Gm-Message-State: AOJu0Yxh4qBicc11d9t+8FEtdT+jBrDJindMI450Ty2tCfw0rCCvgpUJ
        yR7/gvwTks/VLOdObl7xvmiJm/5fCUuzri87ytw=
X-Google-Smtp-Source: AGHT+IHl/NX9qBbfRWmE32BSXA1ZsoedFsSk1mwxVtK9d9aSIyFDl3ATnkGE1IpUfYgdTE7OmchkACFzGTjRAE/WGAA=
X-Received: by 2002:a17:90b:384c:b0:276:caee:db4d with SMTP id
 nl12-20020a17090b384c00b00276caeedb4dmr12491204pjb.10.1696880692336; Mon, 09
 Oct 2023 12:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696605143.git.andreyknvl@google.com> <1c4eb354a3a7b8ab56bf0c2fc6157c22050793ca.1696605143.git.andreyknvl@google.com>
 <CANpmjNM7rytkGRjyG3Pf5PakCdibtpvsm7o-K3am-U0kT-d2Rw@mail.gmail.com>
In-Reply-To: <CANpmjNM7rytkGRjyG3Pf5PakCdibtpvsm7o-K3am-U0kT-d2Rw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 9 Oct 2023 21:44:40 +0200
Message-ID: <CA+fCnZdkug_UEkj7de7YeYn7Ynre2mR9kgH_3CNQG7VC-WzCEg@mail.gmail.com>
Subject: Re: [PATCH 5/5] Documentation: *san: drop "the" from article titles
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Sat, Oct 7, 2023 at 9:01=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>
> On Fri, 6 Oct 2023 at 17:18, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Drop "the" from the titles of documentation articles for KASAN, KCSAN,
> > and KMSAN, as it is redundant.
> >
> > Also add SPDX-License-Identifier for kasan.rst.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  Documentation/dev-tools/kasan.rst | 7 +++++--
> >  Documentation/dev-tools/kcsan.rst | 4 ++--
> >  Documentation/dev-tools/kmsan.rst | 6 +++---
>
> UBSan also has it: https://docs.kernel.org/dev-tools/ubsan.html

Ah, right, forgot that one. I'll send a fix up next week.

(Once again I wonder if we should rename UBSAN to KUBSAN. :)

> Reviewed-by: Marco Elver <elver@google.com>

Thanks!
