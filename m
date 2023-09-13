Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2D79E7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjIMMMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjIMMMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:12:24 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B80F19A8;
        Wed, 13 Sep 2023 05:12:20 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59bdad64411so3015367b3.3;
        Wed, 13 Sep 2023 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694607139; x=1695211939; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VMfUWi7uEiikg8h+TQM4VgISRlAro9zeV1dQSMavJsQ=;
        b=Vl0Bi4i6H2xAU0Ry1Xsn8cTN2TgDD0Q2hJ4qFcSLKqEBZ0qiw0ium3Ks2QWIk03+vC
         pJWDS2v1FqjIJf03km6+EOM1KqHkN28KYl5B3o8avZx/6b3p06VITrEMZao64EqwREmu
         +Y/Xl4UlDMLDgjzG9wEAeTUmLBtT5gxzB/67mr1KEKfrm0gXTBsaDYzs05SJ015vvK4I
         sX4QkSDrIkhRGfWSDqNsUjF8cs5yggeTESmI3IrN2avKxOjHG2HvXwEd/1eAO5v4cDMm
         yu54oNCbkWDpv/g4/26oBBoWRnSPS25MrqR6MtcxuJpFtrhkLxJR/Eh/509tjV+oIaZH
         kk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607139; x=1695211939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMfUWi7uEiikg8h+TQM4VgISRlAro9zeV1dQSMavJsQ=;
        b=WRxgbo1LdJP8hV+42ZEf5T5WF+0qgxcBM4gRfWSOJD6ZNY9VYaonU8EumNqR33/z9a
         q9vgBmDNPQ6/Jr58c9HJgvUTBDKKdEXjQjYQ3oVz4aMJXIULj6sgKG+jTBvagTP7shKV
         IU8mr5ZY08dIgJD3D6spo67/CtUsbE/5P7i2xIPRBSg2lyjexkDAIilbfrreXC2YzXUp
         s1T6a2lEbRhEIyYOT4CxAh6gcFpxVzycpF6WEpvNJjI6uRFKu4zxLIVD/JON2qQHMu5B
         373BLFA/zcBjauLAG5b6A2Q5/eaXnVwhU7bd0Q7zU+IwdoVjGWALT3IuJU2V31u9sc4E
         VNTw==
X-Gm-Message-State: AOJu0YzH1qIYhVrp/a0G7Cx188rls9mnD9SSq+kHfjzUkqEdNHZ7pKhe
        WedGRZoLsTLR64+zydLDfA==
X-Google-Smtp-Source: AGHT+IGGq79qc4DvxFGR46q/Y+a7KFcQ0u7ESGCv/o288lPSFM8VvWWrL6gQHQNsUU70Vg4I1LgdOA==
X-Received: by 2002:a0d:d78b:0:b0:576:98e0:32a6 with SMTP id z133-20020a0dd78b000000b0057698e032a6mr2153641ywd.14.1694607139304;
        Wed, 13 Sep 2023 05:12:19 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id i123-20020a0df881000000b0059935151fa1sm3069110ywf.126.2023.09.13.05.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 05:12:18 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:be75:f593:c65b:4578])
        by serve.minyard.net (Postfix) with ESMTPSA id CD9621800E8;
        Wed, 13 Sep 2023 12:12:17 +0000 (UTC)
Date:   Wed, 13 Sep 2023 07:12:16 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ipmi: refactor deprecated strncpy
Message-ID: <ZQGnIHgYigD4K9jo@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230912-strncpy-drivers-char-ipmi-ipmi-v1-1-cc43e0d1cae6@google.com>
 <ZQEADYBl0uZ1nX60@mail.minyard.net>
 <CAFhGd8rst8gyJ1FVSsbOADt+h2ECwv7fqh_YNHmn6anV_zGC1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8rst8gyJ1FVSsbOADt+h2ECwv7fqh_YNHmn6anV_zGC1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:55:02PM -0700, Justin Stitt wrote:
> On Tue, Sep 12, 2023 at 5:19 PM Corey Minyard <minyard@acm.org> wrote:
> >
> > On Tue, Sep 12, 2023 at 11:43:05PM +0000, Justin Stitt wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > >
> > > In this case, strncpy is being used specifically for its NUL-padding
> > > behavior (and has been commented as such). We can use a more robust and
> > > less ambiguous interface in `strscpy_pad` which makes the code more
> > > readable and even eliminates the need for that comment.
> > >
> > > Let's also use `strnlen` instead of `strlen()` with an upper-bounds
> > > check as this is intrinsically a part of `strnlen`.
> > >
> > > Also included in this patch is a simple 1:1 change of `strncpy` to
> > > `strscpy` for ipmi_ssif.c. If NUL-padding is wanted here as well then we
> > > should opt again for `strscpy_pad`.
> > >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > >  drivers/char/ipmi/ipmi_msghandler.c | 11 +++--------
> > >  drivers/char/ipmi/ipmi_ssif.c       |  2 +-
> > >  2 files changed, 4 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > > index 186f1fee7534..04f7622cb703 100644
> > > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > > @@ -5377,20 +5377,15 @@ static void send_panic_events(struct ipmi_smi *intf, char *str)
> > >
> > >       j = 0;
> > >       while (*p) {
> > > -             int size = strlen(p);
> > > +             int size = strnlen(p, 11);
> > >
> > > -             if (size > 11)
> > > -                     size = 11;
> > >               data[0] = 0;
> > >               data[1] = 0;
> > >               data[2] = 0xf0; /* OEM event without timestamp. */
> > >               data[3] = intf->addrinfo[0].address;
> > >               data[4] = j++; /* sequence # */
> > > -             /*
> > > -              * Always give 11 bytes, so strncpy will fill
> > > -              * it with zeroes for me.
> > > -              */
> > > -             strncpy(data+5, p, 11);
> > > +
> > > +             strscpy_pad(data+5, p, 11);
> >
> > This is incorrect, the destination should *not* be nil terminated if the
> > destination is full.  strncpy does exactly what is needed here.
> 
> Could we use `memcpy_and_pad()` as this matches the behavior of
> strncpy in this case? I understand strncpy works here but I'm really
> keen on snuffing out all its uses -- treewide.

Sure, I think "memcpy_and_pad(data + 5, 11, p, size, 0);" should work.
And that's self-documenting.

-corey

> 
> >
> > A comment should be added here, this is not the first time this has been
> > brought up.
> >
> > >               p += size;
> > >
> > >               ipmi_panic_request_and_wait(intf, &addr, &msg);
> > > diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> > > index 3b921c78ba08..edcb83765dce 100644
> > > --- a/drivers/char/ipmi/ipmi_ssif.c
> > > +++ b/drivers/char/ipmi/ipmi_ssif.c
> > > @@ -1940,7 +1940,7 @@ static int new_ssif_client(int addr, char *adapter_name,
> > >               }
> > >       }
> > >
> > > -     strncpy(addr_info->binfo.type, DEVICE_NAME,
> > > +     strscpy(addr_info->binfo.type, DEVICE_NAME,
> > >               sizeof(addr_info->binfo.type));
> >
> > This one is good.
> >
> > -corey
> >
> > >       addr_info->binfo.addr = addr;
> > >       addr_info->binfo.platform_data = addr_info;
> > >
> > > ---
> > > base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> > > change-id: 20230912-strncpy-drivers-char-ipmi-ipmi-dda47b3773fd
> > >
> > > Best regards,
> > > --
> > > Justin Stitt <justinstitt@google.com>
> > >
