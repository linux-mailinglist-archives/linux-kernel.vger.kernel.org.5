Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0737C9812
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjJOFqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJOFqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:46:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C14A2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:46:00 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65b0e623189so20370646d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697348759; x=1697953559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrpXjYf1KtwIx0fcaHM1Uz17fO5dgwiCtUrqoUYE79s=;
        b=ZdfRF8S+8QQyOn5HqMGWjzVrDA1od+xGr5VIp/drkrVUkRXCzLIkHUM0NtfBppTDGw
         Z89H4DY7NqH9/cp6ZoBb/jr+mBxMaFGIW8DEtpnx7foaUgHisxLrQ0YmAmrI0sSjo31O
         ArNzezbr5zcW1wh8Yw/VBGPZDEPpeQCNE8GA8SoUc4A4wN/cALI0ZVSEbtXi95xu2NGS
         Tg85nIZ/dEmQRE4kSJeD9Lk5UAKn9kzPfs8eYoGv26YnwVrlAgrKxqm0yFeTUjPLzMWp
         DwxuKKGGMw3VbNGKyyXr3vzpreEAGVGYlW8cDele0QM9/sr045kInj41IsOY9EshqqX1
         c4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697348759; x=1697953559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrpXjYf1KtwIx0fcaHM1Uz17fO5dgwiCtUrqoUYE79s=;
        b=WmSgZGAWQytWFdoPEYqqjpFFSyl1/kuc8cNyhTo34j0Q0xNI/UZyGhidfwsnBg0sYn
         6EiEsDLtqU16EvnE4gCgEhQFOgKpXz9wdvwd3qCKXK9GtZolr8JDvkDpNSXCy9K53nWy
         sMJNRLRn7kfgKNurI+TVA5kJnDwwu4Jb1py06hM4uAScrCU2KoBeb/1iWkt6rGNCN3cs
         TosGCjWJsiiAcE/7+vox3E1ngQTWb2HcYNImkaqDRZZXBOlWoDePa9x4W8kVPY+9f3Nn
         Ni9Xcgymn/r+wpE/1qmSLLJcHewPjjv2Fd7w2LgG7EIo08fS2VPos3CxoKVyk+JqUzZc
         NiEg==
X-Gm-Message-State: AOJu0YwaIW94E+8nDX7jDWigXBCnd9c+TrP1MGLZwZwFDVPw+8/MU7ze
        o0T1Gh5kGoDQEyQqegXOj3DKgJ+23FywyjAjFXrRN/v/ap8=
X-Google-Smtp-Source: AGHT+IGoDf1iGLQZemmZyud8o0kEVhAVArroRUciBGw2Upg3EwlZ94cvGzBeXwCb3znSpFtIWuKl2b2CbB65xZyhFgs=
X-Received: by 2002:a0c:db85:0:b0:66d:33d:147d with SMTP id
 m5-20020a0cdb85000000b0066d033d147dmr12175851qvk.20.1697348758968; Sat, 14
 Oct 2023 22:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
 <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org> <ZSq3iuuGy7zSl4sz@casper.infradead.org>
 <721f24eb6532290c6c4ab4e6d5a50bf8637fcd94.camel@HansenPartnership.com>
In-Reply-To: <721f24eb6532290c6c4ab4e6d5a50bf8637fcd94.camel@HansenPartnership.com>
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Date:   Sun, 15 Oct 2023 10:45:48 +0500
Message-ID: <CAJHePoZVMMCcUNKbg5f9VrYo-x5E_rU1piQGHi67ZuY4Pyj4bg@mail.gmail.com>
Subject: Re: [PATCH] mm: Fixed multiple typos in multiple files
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

should I create the v2 or this patch is fine?

On Sat, Oct 14, 2023 at 9:27=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sat, 2023-10-14 at 16:45 +0100, Matthew Wilcox wrote:
> > On Sat, Oct 14, 2023 at 08:31:35AM -0700, Randy Dunlap wrote:
> > > >         /*
> > > > -        * The caller from rmap relay on disabled preemption
> > > > becase they never
> > > > +        * The caller from rmap relay on disabled preemption
> > > > because they never
> > > >          * update their counter from in-interrupt context. For
> > > > these two
> > >
> > > I don't know what that (partial) sentence is trying to say...
> > > Maybe someone else does.
> >
> > s/relay/rely/
>
> relies, surely, being the correct third person singular form of the
> verb to match the nominative noun "the caller".
>
> James
>
