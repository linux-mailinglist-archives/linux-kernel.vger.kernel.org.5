Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783FB7D82A6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbjJZM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJZM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:29:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09831B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:28:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so9936a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698323338; x=1698928138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IBEv/O80HNkfZFTysz0lNdRsT33RzTkskLkw3trITY=;
        b=Dmi+v8z4x3YyTvUumRpW0CQnjft4HCgqEST7xUOIlcEzPuF5yQEXh0pg6HLUNweT3l
         Z0wwTsCUn7tZ0GPGJ2PL6gxLDP75fwUKBo/D0x6z6DJf6q0ebeCcXfm8lyKmPSBpH+FD
         v+uEBD7OmfdoXJq7697xpjSWwbwAk9/Yteq8Exw7ANxVwyqhikIoIgAspd4B2MyYA6r2
         +eVbv+dYhPMyc43r3CF6i+UBRVsq1scOnYYzmnp5U06Qf+hV8M5aVp2dRaG2GCEPPJYZ
         vqqlG79VswQqbEUTTubrKfedif1rYOvTO2mAJqBFQB65BjBecXAw7PZzlGk4sC6lI43H
         h9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323338; x=1698928138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IBEv/O80HNkfZFTysz0lNdRsT33RzTkskLkw3trITY=;
        b=m3yDc0c1KzG+iNhetOV0SCQT5yyACOaiRUvdVX05F+iw3aKE8mT267rJaAART/Nujk
         zElillbTPRpV1PXDJrIAA/ZnDHduKZcQ/ihYGPMpvtKoQPMvMhbUCMS/062yFc+vhcXO
         e/WTfidIye5YXBcue4C02ebRiZTcBK/mbv0IAdTYfHZDMmqPItl2CPknfV9d7HQjNeK5
         XbV8hlgNXR52dBatVcyM4oPuWtb+1MSG0kHVq/FrCplhKm7vG0PaMJQKKa85mhGDCygu
         nu2VHVXhT/0jlw5qPRCjPFkPGBN0AvtUucxMmgjG1+bLHU0NSzY9vR7nIbbdaA4lewl0
         QyKg==
X-Gm-Message-State: AOJu0Yx5ppkQEM/ohR4atRR5eN5sXn8klsiPEM4EJNGIuMMIHfJGXfXW
        1pLc4LCBZhYaUPd8n+kIG38JqFAlvxwfEeWperGArg==
X-Google-Smtp-Source: AGHT+IFJ/mJwORUULNzqI1O78KtuFscIiTydX36EK7ODBHhhC7oI/6KeDSqOKnCRVH9nPY69cw5BvsugfEssb70IpB4=
X-Received: by 2002:aa7:da95:0:b0:540:e46d:1ee8 with SMTP id
 q21-20020aa7da95000000b00540e46d1ee8mr264669eds.4.1698323337997; Thu, 26 Oct
 2023 05:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231025142609.2869769-1-vamshigajjela@google.com>
 <7e7eb495-8e54-49f3-bab7-0de72b2cf7b6@kernel.org> <b86df0e0-ba54-232-1854-bf3d1cbbe479@linux.intel.com>
In-Reply-To: <b86df0e0-ba54-232-1854-bf3d1cbbe479@linux.intel.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Thu, 26 Oct 2023 17:58:45 +0530
Message-ID: <CAMTSyjq38Sj__rQiO2SKMubpFEtRc_3CvSAdPJTVFQZqTMhf2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 2:54=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 26 Oct 2023, Jiri Slaby wrote:
>
> > On 25. 10. 23, 16:26, Vamshi Gajjela wrote:
> > > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> > >
> > > The function uart_fifo_timeout() returns an unsigned long value, whic=
h is
> > > the number of jiffies. Therefore, the function uart_poll_timeout() ha=
s been
> > > modified to use an unsigned long type for timeout values instead of a=
n int
> > > and to avoid truncation.
> >
> > Hi,
> >
> > there is no truncation possible, right?
>
> That's very likely true (I didn't run the calculations), thus it's correc=
t
> to not have Fixes tag. It's more about having consistent typing since
> we're talking about jiffies, so unsigned long as usual.
>
> > > The return type of the function uart_poll_timeout() has also been cha=
nged
> > > from int to unsigned long to be consistent with the type of timeout v=
alues.
>
> Don't write changes you make in the patch in the past tense. Just say:
>
> Change the return type of uart_poll_timeout() from ...
>
> The comment also applies to the other sentence above this one.
Sure, will update commit message.
>
> --
>  i.
>
> > > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > > ---
> > > v2:
> > > - unsigned long instead of unsigned int
> > > - added () after function name in short log
> > > - updated description
> > >   include/linux/serial_core.h | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.=
h
> > > index bb6f073bc159..6916a1d7e477 100644
> > > --- a/include/linux/serial_core.h
> > > +++ b/include/linux/serial_core.h
> > > @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(str=
uct
> > > uart_port *port)
> > >   }
> > >     /* Base timer interval for polling */
> > > -static inline int uart_poll_timeout(struct uart_port *port)
> > > +static inline unsigned long uart_poll_timeout(struct uart_port *port=
)
> > >   {
> > > -   int timeout =3D uart_fifo_timeout(port);
> > > +   unsigned long timeout =3D uart_fifo_timeout(port);
> > >             return timeout > 6 ? (timeout / 2 - 2) : 1;
> > >   }
> >
> >
