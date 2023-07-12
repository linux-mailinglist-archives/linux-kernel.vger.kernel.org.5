Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321327511C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjGLURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:17:04 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B011FE4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:17:03 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-579ef51428eso86225237b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689193023; x=1691785023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4/hT9iYswIxEKI2hIMtLu+Jf2pBiry/HIZV8WkntV0=;
        b=RHQdySqndNzPdRmHs0SUKtI1TapS/6Azjrb0IcVz0QBccbzM0vtanKeNtSJ9PSXVKc
         nQHG2NiSB6zomrkH6XBVhi0z5jQD6PUIWMaFxd6ryznWVnDbr10FQH3H0lBtyTkP7dGn
         SdDdgwcbH8cHIUg1DCUCBYz9fmtboLuoQaQdCXyofvFSsoiVcZEZxxbIwIupcrqHg10Q
         pqdLlt+qJ6Sl2+zM4+jxZYYtqXgNfB9tF41jq8nVcfOP3BgHZy18kZaP+hYbIWHLODgD
         CnxrQEJ9GTziSnBzxM71RSOJ3pOx7YQ3x6tU9x16tIlUby7ZZcg/AuiGMfV+quujaJ5G
         aHjg==
X-Gm-Message-State: ABy/qLZDBFNx1Hw+jwciKTAWR26sldehmWJ9Z1Jf0c5QmIf8Nzsh7fKk
        /mTi/bTntb2lrhVQT0BaOOks1Z/jGMA3lg==
X-Google-Smtp-Source: APBJJlGDmqt6baUYQtX49ckZsDtGZUq3ee5f+yBxl//q+syIBLG+FyfOUG3bYpB34dp8eEqI9Z7Pzg==
X-Received: by 2002:a0d:de45:0:b0:576:7f76:ee59 with SMTP id h66-20020a0dde45000000b005767f76ee59mr23889785ywe.23.1689193022889;
        Wed, 12 Jul 2023 13:17:02 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id l10-20020a81d54a000000b0056ffdec590csm1355285ywj.41.2023.07.12.13.17.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 13:17:01 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-579ef51428eso86224987b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:17:01 -0700 (PDT)
X-Received: by 2002:a81:6646:0:b0:56f:fa68:2e34 with SMTP id
 a67-20020a816646000000b0056ffa682e34mr21446531ywc.35.1689193021607; Wed, 12
 Jul 2023 13:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
 <ZK6zdsIbnQFUmK69@redhat.com> <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh> <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh> <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <20230712194202.GNZK8CCj4yacgFMgfB@fat_crate.local> <CAMw=ZnSa-NqfbEd9vchEwHwdUujNAXo=gb3dfd=HDw4W37RNjQ@mail.gmail.com>
 <20230712200108.GOZK8GhJTkpuIDI4Rg@fat_crate.local>
In-Reply-To: <20230712200108.GOZK8GhJTkpuIDI4Rg@fat_crate.local>
From:   Luca Boccassi <bluca@debian.org>
Date:   Wed, 12 Jul 2023 21:16:50 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSBv=R5A9Yn5n-N+_QMaaUipVGxEJA1JWv__S3z5MmHrA@mail.gmail.com>
Message-ID: <CAMw=ZnSBv=R5A9Yn5n-N+_QMaaUipVGxEJA1JWv__S3z5MmHrA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 21:01, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jul 12, 2023 at 08:56:36PM +0100, Luca Boccassi wrote:
> > Everything < 3 is revoked _and_ the generation id in the stable branch
> > is _not_ bumped, because it's still vulnerable and so that branch is
> > effectively dead and unbootable on any system with secure boot
> > enabled. This is a revocation mechanism, not a bug tracking mechanism.
> > There's no mix-and-matching.
>
> No, this is a mess waiting to happen.

That's not very convincing. You are aware that this mechanism exists
and is already used by other EFI components, yes?

> > Nah, it belongs in both places. Please read the documentation and
> > spend at least some time trying to understand the actual problem being
>
> You want to have this patch in the tree - the commit message should
> explain why it is needed and not point to some documentation somewhere.

Then why not just ask for that, instead of making convoluted
assumptions based on nothing of substance?

> > solved before commenting - or don't comment at all, that's fine too.
>
> Here's a comment for ya:
>
> Naked-by: Borislav Petkov (AMD) <bp@alien8.de>

So very mature. No wonder kernel maintainers and the LKML are
universally loved and praised.
