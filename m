Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0E75118C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjGLT4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGLT4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:56:51 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2B81FDB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:56:49 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5701810884aso77871567b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689191809; x=1691783809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwqNcY338V9nHktVTi28zn400a3uIFcG1sGwe2sZX8g=;
        b=gvHhdU1ef1fAD4YhHFqtElhbo7WxEQNhEL7lpruEKhmqi91qoOVGzyTAP5jxXfTRpI
         WlogzCrfbExydg4kgS8C9vnUpW5X+QdtF4qx8zgCmMYQuNNHmMrOPnjJgdpS7v2PdoH1
         jVFOeLTNkFuBSwcSY584xLccVyqnu5BVNh/WCL5R6zl6LnO6a5n9PpVoP0+OylPZwrlI
         LrWLei/ZKD42z09FFhdLeeNmczMaCzzDnZEb+HINulTq+8dYG3vpCXNgprESuZARvFNl
         0pQWmgzAT1aFXk4QdxHff9UHrMWtThYQjPL4pwwa6kMgWuzg1tQULsium1c9LlWkwfvq
         Wd/g==
X-Gm-Message-State: ABy/qLZSr4vNX2gsiWfL8z4oGn/oQSmgHbhStuWtWbQVIv4RgOpATV4M
        CTyZZtFqi1vCMpiy4iVCaX4ggENwkfVjLQ==
X-Google-Smtp-Source: APBJJlGo0TBVHGKjp8KRQBHibf1qgpWPjroIZ19P+e/MQO3J1fwyPADaz44ZuwSeeJ1b4VW0QT3Mdg==
X-Received: by 2002:a81:5a8b:0:b0:56f:fbc6:3b0 with SMTP id o133-20020a815a8b000000b0056ffbc603b0mr22301815ywb.14.1689191808948;
        Wed, 12 Jul 2023 12:56:48 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id s126-20020a0dd084000000b0057a918d6644sm1340706ywd.128.2023.07.12.12.56.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 12:56:48 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so6838063276.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:56:48 -0700 (PDT)
X-Received: by 2002:a0d:d5c7:0:b0:579:ecfd:bb90 with SMTP id
 x190-20020a0dd5c7000000b00579ecfdbb90mr19465127ywd.1.1689191807709; Wed, 12
 Jul 2023 12:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230712120002.GIZK6Vwga6DlJqdjEh@fat_crate.local>
 <ZK6hLZcuAH9jXKuL@redhat.com> <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
 <ZK6zdsIbnQFUmK69@redhat.com> <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh> <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh> <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <20230712194202.GNZK8CCj4yacgFMgfB@fat_crate.local>
In-Reply-To: <20230712194202.GNZK8CCj4yacgFMgfB@fat_crate.local>
From:   Luca Boccassi <bluca@debian.org>
Date:   Wed, 12 Jul 2023 20:56:36 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSa-NqfbEd9vchEwHwdUujNAXo=gb3dfd=HDw4W37RNjQ@mail.gmail.com>
Message-ID: <CAMw=ZnSa-NqfbEd9vchEwHwdUujNAXo=gb3dfd=HDw4W37RNjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 20:42, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jul 12, 2023 at 08:35:14PM +0100, Luca Boccassi wrote:
> > No, all will not be fine, because stable branches exist, so it would
> > not be _one_ kernel version but N, with monotonically increasing
> > values of N. That doesn't work, and the reason for that are explained
> > in the protocol documentation that was linked in the initial mail.
>
> Lemme give Peter's example from earlier today:
>
> Bugfix A -> number 2
> Bugfix B -> number 3
>
> Tree backports only Bugfix B. Which number do you use?
>
> And so on and so on.

Everything < 3 is revoked _and_ the generation id in the stable branch
is _not_ bumped, because it's still vulnerable and so that branch is
effectively dead and unbootable on any system with secure boot
enabled. This is a revocation mechanism, not a bug tracking mechanism.
There's no mix-and-matching.

> Patch your own trees - this doesn't belong upstream.

Nah, it belongs in both places. Please read the documentation and
spend at least some time trying to understand the actual problem being
solved before commenting - or don't comment at all, that's fine too.
