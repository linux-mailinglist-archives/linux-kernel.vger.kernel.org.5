Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36C7CDFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345752AbjJRO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbjJRO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:29:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5993C22
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:17:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53f34f2718cso12084a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697638633; x=1698243433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOE/HwXbjXBM8pvrHd8gpMB/9CB4hrW/MzpGagoB2q0=;
        b=0t0nAVvHIAmh1ekQB8kNEH/ekimf1bdP9TqJyMJMAzlrC/61akbCcHKl2FTG8Ggyt7
         2bRwZf31LtuYyaql30L3t1pXyfqqXdhMfNFLu5l0T7ERcNUin+BSJzGulJnr6s3G4hvS
         i6JQmCdj+DtnvG7ltbNybrfYyAy0A4T/rXWv7iJSaN93/S6EzTJU1KWyEDcaejjQ8kOJ
         vlK5vwPMGmkg/6IblukKn6PQRwP+D5WPfyTTCQ2F16NEAC5DDzD4il7/3bef/xlz9GmX
         iMbyD9o9Lp4dINnTAdl76MFT8FEs1aVv0oG0RlHq3uuA2F/Is56JzQk6pi8tFkGWQXRO
         GxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697638633; x=1698243433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOE/HwXbjXBM8pvrHd8gpMB/9CB4hrW/MzpGagoB2q0=;
        b=FUCa0TBrWr5uc6uS7KYSjqhIMWgakqYiIjZNm8oDJzzu7tqPteQuRAcmboCoVg5vfe
         +KyVplFu1qCD1IZXGgY8weRomq8c6mAsp3oTFbJrAXukTnDQlgsnXvRYCna6MAlIC8AI
         F0Aiz53pSqzAGQhGdxW9LcG6LJstnWp4+MKPE7t4WYHfjP//Mg0UkjgpNz5isOWgRPs6
         j7JNfW1W1ejA4bXXW5C0/3Y75xFuZxbY1eVfGO9apdI0cLVd9WihdLe8yBB9W7Ag6x65
         kxStHCiTWDbvTYq6YtkrHtxvRXl1mxEmkpGC9a04OuLeifuO+AH4bbTN4/hfFy6plEHX
         NXXA==
X-Gm-Message-State: AOJu0Yxhe9pcfFH7+1J+YqQSIU367sElJhXhMtW7ZMit0rDF9KCxxbAl
        W+NM3qUKVlF21YZtq4OGdafVjiv3GkdyFN4NOKsIpA==
X-Google-Smtp-Source: AGHT+IHmL8s7uMe74PQsFSvo3cbKUEO4eKQ6ofJYGQCkXl0yaoYhv0BaAcEdSxe3CnHa/wjM6y76eZdS/9Xom2hW1rY=
X-Received: by 2002:a50:9f03:0:b0:52e:f99a:b5f8 with SMTP id
 b3-20020a509f03000000b0052ef99ab5f8mr99470edf.7.1697638632991; Wed, 18 Oct
 2023 07:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231014104942.856152-1-vamshigajjela@google.com>
 <20231014104942.856152-3-vamshigajjela@google.com> <b0ec67b1-24a2-d67d-d7c1-9c3fdafdb570@linux.intel.com>
In-Reply-To: <b0ec67b1-24a2-d67d-d7c1-9c3fdafdb570@linux.intel.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Wed, 18 Oct 2023 19:46:59 +0530
Message-ID: <CAMTSyjpiz_LVtVAzaNpD-xThtp6sKNy-Uvkr+CaH9b10VRYD9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: core: Make local variable size to u64
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 5:09=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sat, 14 Oct 2023, Vamshi Gajjela wrote:
>
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> >
> > The variable size has been changed from u32 to u64 to accommodate a
> > larger range of values without the need for explicit typecasting.
>
> Don't use too broad/generic terminology in shortlog (on [PATCH] line in
> subject) or changelog but explicitly mention the variable names please.
name of the variable is "size", may be now I will rename the variable
to "frame_size" in v2
>
> > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 7bdc21d5e13b..fb4696d17a8b 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -410,10 +410,10 @@ void
> >  uart_update_timeout(struct uart_port *port, unsigned int cflag,
> >                   unsigned int baud)
> >  {
> > -     unsigned int size =3D tty_get_frame_size(cflag);
> > +     u64 size =3D tty_get_frame_size(cflag);
> >       u64 frame_time;
> >
> > -     frame_time =3D (u64)size * NSEC_PER_SEC;
> > +     frame_time =3D size * NSEC_PER_SEC;
> >       port->frame_time =3D DIV64_U64_ROUND_UP(frame_time, baud);
> >  }
> >  EXPORT_SYMBOL(uart_update_timeout);
>
> This is actually a good cleanup all by itself unrelated to the other
> change but you need to adapt the changelog to reflect why this is helpful
> instead wording it based on the other change.
I shall submit this as a separate patch. As mentioned in 1/3 patch
I will also add a cast u32 before assigning the value to port->frametime
along with variable name and size change.

>
> --
>  i.
>
