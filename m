Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C707DF559
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjKBOxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKBOxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:53:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA912F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:53:26 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c6cb4a79deso11325411fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698936804; x=1699541604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpPyVtURK3O1993/XOuCJ+rtbqqAwYQxZ3FZRcfqNLE=;
        b=dcsuXAF8WQ/WQgnJlxp6mUTTx+tkLEHlwQC14+u0VWqWRXpz0ZInRrPJLniLztw4M8
         LdraLSjUJ1nIsnOe928PBjFRvI9E8j92RISrAOK3YjKvS89WRDGkL6H2ZmAXbhghHFm5
         BDn8ozX7Xc02+i6LvQmyIWF36qxEYrvyiokT1Ksx610H/syKEf6yN2pEZ8UHbZ3yVtNp
         TtV7G1thlZICvMvQZQDPWZT+U4a/IelaMb1or0bNbFdmhKlAWKqFaUDg/bVtbZWkXtCm
         UbDQG5HVzqOpdeLiDby/T6Eb2O9tDphJMPPL6hC+k3ZCO7e/25/WK8AC/Ih28Tqywn/3
         lVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936804; x=1699541604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpPyVtURK3O1993/XOuCJ+rtbqqAwYQxZ3FZRcfqNLE=;
        b=fUgWijoXzXadzGLpgb2nle9kH1x4Nq58W06btMvd5SXnm1JogzPccRAalcTXHaokI1
         xQQCdFOkcwTZ64hTVTrndiKwPRyaE1xP+H1wUKHmqp35i7t5bnuF/IE2RztUvQ3PFnYZ
         TyMfAwT0txn6eQ1UsOib1j+N1LLmaegyKabxyzC2dLGv+PVsLdX5VM+2qmIJKpGK3NHY
         sYpjnE4roJuJkqdDOZ+NFQJ62Jaf4I2N5psl9LzjQFjEf3Kp2ey+HxW+pAgxHCc67IYh
         RbUqPBf83kk/EqfKus9RzBGITl/lPDHdTI5OpiXCO39Jvrrn/ioBpfldgc2rAmIbrsz8
         tIhQ==
X-Gm-Message-State: AOJu0YzEGJd4C95cl4+UoKQLFBww45hpgcUdomF3DjDffib/DUQjaViJ
        we+Ddm8gWDbd0DXhq1ZOeKLH33ql/5UYGhdkuuUiVLGC35AdRxBtAKh9xQ==
X-Google-Smtp-Source: AGHT+IF+4kzPJza/2IUhZKr1xOdoJfGM7YL+7agh9GMsfaxBBtfJW0JigT3a/A8/z0p9Wkfv+y6XHzkoz2wBMSdK854=
X-Received: by 2002:a2e:9695:0:b0:2bd:a67:e8c with SMTP id q21-20020a2e9695000000b002bd0a670e8cmr21102lji.3.1698936804612;
 Thu, 02 Nov 2023 07:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231031210521.1661552-1-dlechner@baylibre.com> <3ea3d92db5c4c077a76b29dc5a89c4d491695752.camel@gmail.com>
In-Reply-To: <3ea3d92db5c4c077a76b29dc5a89c4d491695752.camel@gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 2 Nov 2023 09:53:13 -0500
Message-ID: <CAMknhBEDp1baTDPrAfAv_gZ5o6LxNSt8bgS8wcGUmXdaCHq_Jw@mail.gmail.com>
Subject: Re: [PATCH] iio: triggered-buffer: prevent possible freeing of wrong buffer
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 3:59=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Tue, 2023-10-31 at 16:05 -0500, David Lechner wrote:
> > Commit ee708e6baacd ("iio: buffer: introduce support for attaching more
> > IIO buffers") introduced support for multiple buffers per indio_dev but
> > left indio_dev->buffer for a few legacy use cases.
> >
> > In the case of the triggered buffer, iio_triggered_buffer_cleanup()
> > still assumes that indio_dev->buffer points to the buffer allocated by
> > iio_triggered_buffer_setup_ext(). However, since
> > iio_triggered_buffer_setup_ext() now calls iio_device_attach_buffer()
> > to attach the buffer, indio_dev->buffer will only point to the buffer
> > allocated by iio_device_attach_buffer() if it the first buffer attached=
.
> >
> > This adds a check to make sure that no other buffer has been attached
> > yet to ensure that indio_dev->buffer will be assigned when
> > iio_device_attach_buffer() is called.
> >
> > Fixes: ee708e6baacd ("iio: buffer: introduce support for attaching more=
 IIO
> > buffers")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/buffer/industrialio-triggered-buffer.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > index c7671b1f5ead..c06515987e7a 100644
> > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > @@ -46,6 +46,16 @@ int iio_triggered_buffer_setup_ext(struct iio_dev
> > *indio_dev,
> >       struct iio_buffer *buffer;
> >       int ret;
> >
> > +     /*
> > +      * iio_triggered_buffer_cleanup() assumes that the buffer allocat=
ed
> > here
> > +      * is assigned to indio_dev->buffer but this is only the case if =
this
> > +      * function is the first caller to iio_device_attach_buffer(). If
> > +      * indio_dev->buffer is already set then we can't proceed otherwi=
se
> > the
> > +      * cleanup function will try to free a buffer that was not alloca=
ted
> > here.
> > +      */
> > +     if (indio_dev->buffer)
> > +             return -EADDRINUSE;
> > +
>
> Hmmm, good catch! But I think this is just workarounding the real problem

Yes, I could have done a better job explaining my reason for this fix.
It seemed like the simplest fix that could be easily backported to
stable kernels. And then we can look at removing the legacy field
completely in the future.

> because like this, you can only have a triggered buffer by device. This s=
hould
> be fine as we don't really have any multi buffer user so far but ideally =
it
> should be possible.
>
> Long term we might want to think about moving 'pollfunc' to be a per buff=
er
> thing. Not sure how much trouble that would be given that a trigger is al=
so per
> device and I don't know if it would make sense to have a trigger per buff=
er?!
> Ideally, given the multi buffer concept, I would say it makes sense but i=
t might
> be difficult to accomplish. So better to think about it only if there's a=
 real
> usecase for it.
>
> On thing that I guess it could be done is to change the triggered API so =
it
> returns a buffer and so iio_triggered_buffer_cleanup() would also get a p=
ointer
> to the buffer it allocated (similar to what DMA buffer's are doing). But =
that's
> indeed also bigger change... Bahh, I'm likely over complicating things fo=
r now.

This sounds very much like the work I am doing on SPI Engine offload
support - having a trigger associated with a buffer. So maybe
something will come out of that. =C2=AF\_(=E3=83=84)_/=C2=AF

> Fell free to:
>
> Acked-by: Nuno Sa <nuno.sa@analog.com>
>
>
