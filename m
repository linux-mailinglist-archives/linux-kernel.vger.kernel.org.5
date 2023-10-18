Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5097CE2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjJRQjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:39:02 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E5BD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:39:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083f613272so5619345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697647138; x=1698251938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9SF8JJcd8ct9ipQtfiI/7at0EuX7KbDRsL4NAWMQ7k=;
        b=jzhCpoyHehpixSVFJHg9d2hR18aM9qSQT76uwjxqr2PFn4jVy+rTlhSVZiQdw0S31M
         NHDk45W8zosV8TBywiG30sdWtuAe9YTZxjJd0a69fLQyFWxfpIIMElDublwnK3NtItao
         4CA46TYtixRWETq/Soai80JWHJypQmXjVxPgY/5p5lAXmQ8WIB1w5/2bT+jOoOZgcth5
         qPagvfGuNNlwtOdnuv9tL9G2c0bg33FnyFrbWGHBjLxh0dvWgOElwKGrMZHN6VHdX2WO
         q2b4YoCX1xDoadOqImgcoZUPv3BPnAPx7O7vm0t+K4/PTFvQZa/SneiE7Xx85SualFSo
         0vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697647138; x=1698251938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9SF8JJcd8ct9ipQtfiI/7at0EuX7KbDRsL4NAWMQ7k=;
        b=Gvkb+yRVbtLH45C5kSYTJM9Y67BMk95yY/3VivD8KBjVxXFwlRgSsscU3tU8leKyRU
         BpBogtGFKS2lwY52COPiaQUygdV36NUu24gcr98hyMwPYF4FQDrRAp3NlsIbKXpZGRuh
         cgPjg3N80nsLTTcHnxci2OF5iwxmNyZC16LFWXjyEjaDncQ+8CJTnXsiHLeSHfQc2cQg
         n5Lp/pAHKPaaXZHo/XKfIoTADRUhjRsMFA5+LAiqY2d5s9lULZDx53pPfwmAgHQLFM3r
         IK/+Xx2YD2CpPPqyiwFhG05RkahNyNFH69/NTye/KtS2UGlOf/izoyP5nlL7S0BaUZ4l
         H1dg==
X-Gm-Message-State: AOJu0YxTvgeylw6WOgAdziN/yv4m0H+wA0h2Y5wwiZzkEL4lEu69+cr/
        kxTlF66Rh+09/zJ59xEv9nIxhywLFBvcRitQLHDbZWSKpfSXoT2Db0NOlg==
X-Google-Smtp-Source: AGHT+IEakwXt8NBnPKYnazuwZ478k495vdqLMc2ZTG6OjrZ/HclMdIwXVZ2e99aU9P5tfmuqpDkaw/ASeyEtGaCMveM=
X-Received: by 2002:a5d:4ec5:0:b0:32d:8cd1:52e4 with SMTP id
 s5-20020a5d4ec5000000b0032d8cd152e4mr4431912wrv.6.1697647138401; Wed, 18 Oct
 2023 09:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231018153147.167393-1-hamza.mahfooz@amd.com> <CANpmjNPZ0Eii3ZTrVqEL2Ez0Jv23y-emLBCLSZ==xmH--4E65g@mail.gmail.com>
In-Reply-To: <CANpmjNPZ0Eii3ZTrVqEL2Ez0Jv23y-emLBCLSZ==xmH--4E65g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 18 Oct 2023 09:38:43 -0700
Message-ID: <CAKwvOdkB8EDpbHjkL=u-5_ri6c+y6EMDx2sET+EEANXoSeDDSQ@mail.gmail.com>
Subject: Re: [PATCH] lib: Kconfig: disable dynamic sanitizers for test builds
To:     Marco Elver <elver@google.com>
Cc:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, kasan-dev@googlegroups.com,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 18, 2023 at 9:22=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> That being said, we're aware of KASAN having had more issues and there
> are some suboptions that have been disabled because of that (like
> KASAN_STACK). I'm not sure if Clang's KASAN instrumentation has had
> some recent improvements (we did investigate it, but I can't recall
> what the outcome was [1]) - maybe try a more recent compiler? However,
> KCSAN and KMSAN shouldn't have any issues (if KMSAN is enabled,
> FRAME_WARN is 0). And having build tests with them enabled isn't
> useless at all: we're making sure that these tools (even though only
> for debugging), still work. We _want_ them to work during random build
> testing!
>
> Please share the concrete problem you're having, because this change
> will make things worse for everyone in the long run.
>
> [1] https://github.com/llvm/llvm-project/issues/38157

Some recent issues I discovered in clang that exacerbate stack usage
in general, which is then amplified by KASAN:
1. https://github.com/llvm/llvm-project/issues/68746
2. https://github.com/llvm/llvm-project/issues/68747
Those are next up on my to fix list after what I'm working on now.  I
suspect that those aren't the last issues now that I've found a thread
to pull on.

--=20
Thanks,
~Nick Desaulniers
