Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8590E7F8955
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjKYIjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:39:09 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E5E6;
        Sat, 25 Nov 2023 00:39:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-285196556fcso2032064a91.0;
        Sat, 25 Nov 2023 00:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700901541; x=1701506341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3Bf/Yl9mKrvt0khOxHwark3QzJ6UQysXXp2xzavtBk=;
        b=cXVzSidyjDMYLiOlOoz9imjAm5p7wOEwJD2obsPwwOTeozfENBZAtw3LAcuOhox6Na
         wnpGNeZyfwKs61+4ZVuIkkBWDd1Bodw1v8NbKjwfOZc8oTYpzSAfWoSJpU2MSs+fOJv4
         Ebwx0keJivCl0qFZDkpqrB36mc2A1rfuq+AMXGIQAijv3WTqqh2jbbcdQvUniemDsHgb
         HgWwkY8jlvIqqRkk4BmvVSTLu9snmC/k7Uv10oFCUbEiCNyiz0S2zykLhlW5KToe6lW/
         fwf4HIOr+X/RDovMcTIFdbM2D+jNH6TgOwqv5wjO0WjHGgeZB4ILksDpQkSe2Puhh9tf
         faZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901541; x=1701506341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3Bf/Yl9mKrvt0khOxHwark3QzJ6UQysXXp2xzavtBk=;
        b=ZPOGzM3YLAcfSySQ3K6JgVMf6cGXfmYiaTJHVOdpPcfwAAYJNKHit8X4sxY9wk0OG3
         E9MG+MOoMdUhdzBx/7M79bsiL4BEhGoQqy0wYLY2RTgRfv2vpt5Jn6hTZS8fw928QKgb
         l9mvTj7PUfYibFDxLJAjxLrHbzvLGFpQrFjcL7BQALVempy2TUYGsCD5GwrtXs5oKu+Y
         /mS2tmGzlDmUwa5fg5sfuawcy3X7MSD0XAcdwvT0R/x/l51Ko87h57juQsGPMNszgV1/
         /c5uBmZlemFUyzEMCkGZbjpAc6VAZ8/C3wZdy5Den3iRuXwhh9BPV3uvlR1A5k+cRxDl
         ML5Q==
X-Gm-Message-State: AOJu0YzHetsQYWWSInPLNxN54Tl+g7/sJsdNQFX1mgQOgPeavILszJZ9
        Lgevynumo3FRftaHDO8CBOQFB9XhSPs8QV5BHXE=
X-Google-Smtp-Source: AGHT+IHgS1+vLNVv0PbZzEHH+jxGqxTkbV8A7WbpzlVQdFNHj8uftYyqF+QcWVS7dsCJBiOglO8+HHcs980EBN6qpng=
X-Received: by 2002:a17:90b:224b:b0:27d:880d:8645 with SMTP id
 hk11-20020a17090b224b00b0027d880d8645mr5626111pjb.49.1700901540728; Sat, 25
 Nov 2023 00:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20231125073738.649948-1-ghanshyam1898@gmail.com>
 <2023112554-bagginess-banker-089e@gregkh> <CAG-BmocpXo5GY7KSh-nnw7Z6ExkMGKxetoeSdbyNjrqFCGJLQA@mail.gmail.com>
 <2023112508-clothing-twirl-fe40@gregkh>
In-Reply-To: <2023112508-clothing-twirl-fe40@gregkh>
From:   Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date:   Sat, 25 Nov 2023 14:08:24 +0530
Message-ID: <CAG-Bmoesp5B+7G4in_OH7qH2g_N3A+7tfO=ximbPZMfoTaAJaA@mail.gmail.com>
Subject: Re: [PATCH V3] media: stk1160: Fixed high volume of stk1160_dbg messages
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Phillip Potter <phil@philpotter.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 1:58=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Nov 25, 2023 at 01:51:35PM +0530, Ghanshyam Agrawal wrote:
> > On Sat, Nov 25, 2023 at 1:18=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Sat, Nov 25, 2023 at 01:07:38PM +0530, Ghanshyam Agrawal wrote:
> > > > The function stk1160_dbg gets called too many times, which causes
> > > > the output to get flooded with messages. Since stk1160_dbg uses
> > > > printk, it is now replaced with printk_ratelimited directly.
> > > >
> > > > Suggested-by: Phillip Potter <phil@philpotter.co.uk>
> > > > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > > > ---
> > > > V3:
> > > > Fixed the issue with my patch needing previous versions being appli=
ed
> > > > first.
> > > >
> > > > Used printk_ratelimited instead of dev_warn_ratelimited because
> > > > of compiler error "incompatible pointer type".
> > > >
> > > > V2:
> > > > To add KERN_WARNING in printk_ratelimited, and later as per warning=
 by
> > > > the checkpatch script, replaced  printk_ratelimited with
> > > > dev_warn_ratelimited.
> > > >
> > > > V1:
> > > > The function stk1160_dbg gets called too many times, which causes
> > > > the output to get flooded with messages. Since stk1160_dbg uses
> > > > printk, it is now replaced with dev_warn_ratelimited.
> > > >
> > > >  drivers/media/usb/stk1160/stk1160-video.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/me=
dia/usb/stk1160/stk1160-video.c
> > > > index 4e966f6bf608..98417fa31d70 100644
> > > > --- a/drivers/media/usb/stk1160/stk1160-video.c
> > > > +++ b/drivers/media/usb/stk1160/stk1160-video.c
> > > > @@ -107,8 +107,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8=
 *src, int len)
> > > >
> > > >       /*
> > > >        * TODO: These stk1160_dbg are very spammy!
> > > > -      * We should 1) check why we are getting them
> > > > -      * and 2) add ratelimit.
> > > > +      * We should check why we are getting them.
> > > >        *
> > > >        * UPDATE: One of the reasons (the only one?) for getting the=
se
> > > >        * is incorrect standard (mismatch between expected and confi=
gured).
> > > > @@ -151,7 +150,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8=
 *src, int len)
> > > >
> > > >       /* Let the bug hunt begin! sanity checks! */
> > > >       if (lencopy < 0) {
> > > > -             stk1160_dbg("copy skipped: negative lencopy\n");
> > > > +             printk_ratelimited(KERN_WARNING "copy skipped: negati=
ve lencopy\n");
> > >
> > > You changed a debug message level to a KERN_WARNING level?  That feel=
s
> > > like a step backwards.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Hi Greg,
> >
> > Thanks for your response. The log level should indeed be DEBUG
> > as it was earlier.
> >
> > I only wanted to add a rate limit there because it was printing too
> > many log messages as mentioned in the todo. Shall I update the
> > log level  to DEBUG and resend the patch? Thank you very much
> > again.
>
> If it's spamming the logs, why print anything at all as obviously
> everyone is ignoring it?  But I do not really know, the final decision
> should be up to the developer and maintainer of this subsystem.
>
> thanks,
>
> greg k-h

Hi Greg,

Noted with thanks. Let me update the patch.

Regards,
Ghanshyam Agrawal
