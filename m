Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF067790B55
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 11:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbjICJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 05:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 05:17:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEA3130
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 02:17:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so8016345ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693732673; x=1694337473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQUXQ3h5Sa/sHt8ymdUUprVawGnEspmXBM4PbTZeVpU=;
        b=KALEd4F9XQA5qaZqQoSoMJq1lOzQy5cvD7l3j4i4Gs7euhUfKE3SvsfTUSH9Dq4Kry
         phZ3+p040rcMkb2+U8H1FleRl2G2IZ5j1zTg9GBgpSNOrq6BVScJnqG59Z34egH5CWYc
         dMnVqPC3e7x1LyG8PVR046bubHk3vGlbAZW5UZOoiywe0g9LBrkDfa5tEf0agIj1QrFF
         w0WBE/M8VDinpiN2T89Yexd/035bWo1pweNSpryPGUfHjen1YKiGcD1dO6lycdNiJyZu
         vurbqL0P9ZPYVLXkPkgjuodKvQijgHgNWn1aQ36wgdxLc9s1tV3C245ZTqzeAN8FFd6C
         iVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693732673; x=1694337473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQUXQ3h5Sa/sHt8ymdUUprVawGnEspmXBM4PbTZeVpU=;
        b=H5fELR4t1cvWv7N4UGnyBjzxgvuQhZAEzzdbkhmTW/+BoPS+PzfcvVSw/NP4hWu8J7
         +VQGSQVBwOtIEJ5enS3uUaIIQ8B868xnqtvNKWQWxYZiKHVv4FERZNL3KjpsbBUXM9kh
         9b72BmhOvsXzvoO7qipCGv2GwFQ612xSSDJFaxav0bQbRybVR258Lieyfqci9uNz40dS
         UOuEXovzD5EXp4oc6jIz5IEGrR+ghY35IiYlTLetwu8tYp9LUetDwphGBdxJ3gYEM1QY
         GwaTRaVcnokUKJQrILhmkDXm7w+xmrUad1IC5rQpEWiiWQtEW+yi81G9G8baXrBa2kxK
         cQhg==
X-Gm-Message-State: AOJu0YwMPkdFFhx9ihHoFvCIbeB/vTEwnJomObeQhxH3QGuobQR1xwQr
        VK2hGYv+XksmQNiIWNv7yvbXnC2GXN+4nlQijQ/svAxWDwn6bxlwRI5Lyg==
X-Google-Smtp-Source: AGHT+IHr97HqeJDbbeJBaCRZdNphpW12CA1QWdDGLg+Xrwn8cCE4FwH0+Kpetb40l5HjETRe3flvy/ISr+SzuHRmSEU=
X-Received: by 2002:a17:90b:1e4e:b0:26b:494f:ae5d with SMTP id
 pi14-20020a17090b1e4e00b0026b494fae5dmr9389281pjb.1.1693732672667; Sun, 03
 Sep 2023 02:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230903082253.562042-1-bergh.jonathan@gmail.com> <2023090324-recopy-unisexual-db41@gregkh>
In-Reply-To: <2023090324-recopy-unisexual-db41@gregkh>
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
Date:   Sun, 3 Sep 2023 11:17:41 +0200
Message-ID: <CA+MPq=VjvQSmY_coVxrmisXavgaZa78ram-SH2pHvOZ=AvaqRQ@mail.gmail.com>
Subject: Re: [PATCH] Staging: Fixed some formatting warnings in the vme_user driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

Hi Greg,
I hope you are well. I got this response from your bot!
I pretty much followed your FOSDEM instructions for *first kernel
patches* so i thought I was doing it right.

Based on the video of your talk, is more required in the SUBJECT and
BODY for such a (basic) change? It seemed the above was pretty much
inline with the terseness / examples you showed in your presentation.
Hopefully thats the case.

Anyway, best regards
Jonathan


On Sun, Sep 3, 2023 at 10:32=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Sep 03, 2023 at 10:22:53AM +0200, Jonathan Bergh wrote:
> > Fixed a few style warnings.
> >
> > Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme_fake.c   |   4 +-
> >  drivers/staging/vme_user/vme_tsi148.h | 140 +++++++++++++-------------
> >  2 files changed, 72 insertions(+), 72 deletions(-)
> >
> > diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_=
user/vme_fake.c
> > index 7c53a8a7b79b..90aaf650524d 100644
> > --- a/drivers/staging/vme_user/vme_fake.c
> > +++ b/drivers/staging/vme_user/vme_fake.c
> > @@ -1010,8 +1010,8 @@ static void fake_free_consistent(struct device *p=
arent, size_t size,
> >  {
> >       kfree(vaddr);
> >  /*
> > -     dma_free_coherent(parent, size, vaddr, dma);
> > -*/
> > + *   dma_free_coherent(parent, size, vaddr, dma);
> > + */
> >  }
> >
> >  /*
> > diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vm=
e_user/vme_tsi148.h
> > index 63f726e1811a..23969393b606 100644
> > --- a/drivers/staging/vme_user/vme_tsi148.h
> > +++ b/drivers/staging/vme_user/vme_tsi148.h
> > @@ -255,28 +255,28 @@ static const int TSI148_LCSR_VIACK[8] =3D { 0, TS=
I148_LCSR_VIACK1,
> >   */
> >  #define TSI148_LCSR_VMEFL    0x250
> >
> > -     /*
> > -      * VME exception.
> > -      * offset  260
> > +/*
> > + * VME exception.
> > + * offset  260
> >   */
> >  #define TSI148_LCSR_VEAU     0x260
> >  #define TSI148_LCSR_VEAL     0x264
> >  #define TSI148_LCSR_VEAT     0x268
> >
> > -     /*
> > -      * PCI error
> > -      * offset  270
> > -      */
> > +/*
> > + * PCI error
> > + * offset  270
> > + */
> >  #define TSI148_LCSR_EDPAU    0x270
> >  #define TSI148_LCSR_EDPAL    0x274
> >  #define TSI148_LCSR_EDPXA    0x278
> >  #define TSI148_LCSR_EDPXS    0x27C
> >  #define TSI148_LCSR_EDPAT    0x280
> >
> > -     /*
> > -      * Inbound Translations
> > -      * offset  300
> > -      */
> > +/*
> > + * Inbound Translations
> > + * offset  300
> > + */
> >  #define TSI148_LCSR_IT0_ITSAU                0x300
> >  #define TSI148_LCSR_IT0_ITSAL                0x304
> >  #define TSI148_LCSR_IT0_ITEAU                0x308
> > @@ -363,53 +363,53 @@ static const int TSI148_LCSR_IT[8] =3D { TSI148_L=
CSR_IT0, TSI148_LCSR_IT1,
> >  #define TSI148_LCSR_OFFSET_ITOFL     0x14
> >  #define TSI148_LCSR_OFFSET_ITAT              0x18
> >
> > -     /*
> > -      * Inbound Translation GCSR
> > -      * offset  400
> > -      */
> > +/*
> > + * Inbound Translation GCSR
> > + * offset  400
> > + */
> >  #define TSI148_LCSR_GBAU     0x400
> >  #define TSI148_LCSR_GBAL     0x404
> >  #define TSI148_LCSR_GCSRAT   0x408
> >
> > -     /*
> > -      * Inbound Translation CRG
> > -      * offset  40C
> > -      */
> > +/*
> > + * Inbound Translation CRG
> > + * offset  40C
> > + */
> >  #define TSI148_LCSR_CBAU     0x40C
> >  #define TSI148_LCSR_CBAL     0x410
> >  #define TSI148_LCSR_CSRAT    0x414
> >
> > -     /*
> > -      * Inbound Translation CR/CSR
> > -      *         CRG
> > -      * offset  418
> > -      */
> > +/*
> > + * Inbound Translation CR/CSR
> > + *         CRG
> > + * offset  418
> > + */
> >  #define TSI148_LCSR_CROU     0x418
> >  #define TSI148_LCSR_CROL     0x41C
> >  #define TSI148_LCSR_CRAT     0x420
> >
> > -     /*
> > -      * Inbound Translation Location Monitor
> > -      * offset  424
> > -      */
> > +/*
> > + * Inbound Translation Location Monitor
> > + * offset  424
> > + */
> >  #define TSI148_LCSR_LMBAU    0x424
> >  #define TSI148_LCSR_LMBAL    0x428
> >  #define TSI148_LCSR_LMAT     0x42C
> >
> > -     /*
> > -      * VMEbus Interrupt Control.
> > -      * offset  430
> > -      */
> > +/*
> > + * VMEbus Interrupt Control.
> > + * offset  430
> > + */
> >  #define TSI148_LCSR_BCU              0x430
> >  #define TSI148_LCSR_BCL              0x434
> >  #define TSI148_LCSR_BPGTR    0x438
> >  #define TSI148_LCSR_BPCTR    0x43C
> >  #define TSI148_LCSR_VICR     0x440
> >
> > -     /*
> > -      * Local Bus Interrupt Control.
> > -      * offset  448
> > -      */
> > +/*
> > + * Local Bus Interrupt Control.
> > + * offset  448
> > + */
> >  #define TSI148_LCSR_INTEN    0x448
> >  #define TSI148_LCSR_INTEO    0x44C
> >  #define TSI148_LCSR_INTS     0x450
> > @@ -417,10 +417,10 @@ static const int TSI148_LCSR_IT[8] =3D { TSI148_L=
CSR_IT0, TSI148_LCSR_IT1,
> >  #define TSI148_LCSR_INTM1    0x458
> >  #define TSI148_LCSR_INTM2    0x45C
> >
> > -     /*
> > -      * DMA Controllers
> > -      * offset 500
> > -      */
> > +/*
> > + * DMA Controllers
> > + * offset 500
> > + */
> >  #define TSI148_LCSR_DCTL0    0x500
> >  #define TSI148_LCSR_DSTA0    0x504
> >  #define TSI148_LCSR_DCSAU0   0x508
> > @@ -484,27 +484,27 @@ static const int TSI148_LCSR_DMA[TSI148_MAX_DMA] =
=3D { TSI148_LCSR_DMA0,
> >  #define TSI148_LCSR_OFFSET_DCNT              0x40
> >  #define TSI148_LCSR_OFFSET_DDBS              0x44
> >
> > -     /*
> > -      * GCSR Register Group
> > -      */
> > +/*
> > + * GCSR Register Group
> > + */
> >
> > -     /*
> > -      *         GCSR    CRG
> > -      * offset   00     600 - DEVI/VENI
> > -      * offset   04     604 - CTRL/GA/REVID
> > -      * offset   08     608 - Semaphore3/2/1/0
> > -      * offset   0C     60C - Seamphore7/6/5/4
> > -      */
> > +/*
> > + *         GCSR    CRG
> > + * offset   00     600 - DEVI/VENI
> > + * offset   04     604 - CTRL/GA/REVID
> > + * offset   08     608 - Semaphore3/2/1/0
> > + * offset   0C     60C - Seamphore7/6/5/4
> > + */
> >  #define TSI148_GCSR_ID               0x600
> >  #define TSI148_GCSR_CSR              0x604
> >  #define TSI148_GCSR_SEMA0    0x608
> >  #define TSI148_GCSR_SEMA1    0x60C
> >
> > -     /*
> > -      * Mail Box
> > -      *         GCSR    CRG
> > -      * offset   10     610 - Mailbox0
> > -      */
> > +/*
> > + * Mail Box
> > + *         GCSR    CRG
> > + * offset   10     610 - Mailbox0
> > + */
> >  #define TSI148_GCSR_MBOX0    0x610
> >  #define TSI148_GCSR_MBOX1    0x614
> >  #define TSI148_GCSR_MBOX2    0x618
> > @@ -515,27 +515,27 @@ static const int TSI148_GCSR_MBOX[4] =3D { TSI148=
_GCSR_MBOX0,
> >                                       TSI148_GCSR_MBOX2,
> >                                       TSI148_GCSR_MBOX3 };
> >
> > -     /*
> > -      * CR/CSR
> > -      */
> > +/*
> > + * CR/CSR
> > + */
> >
> > -     /*
> > -      *        CR/CSR   CRG
> > -      * offset  7FFF4   FF4 - CSRBCR
> > -      * offset  7FFF8   FF8 - CSRBSR
> > -      * offset  7FFFC   FFC - CBAR
> > -      */
> > +/*
> > + *        CR/CSR   CRG
> > + * offset  7FFF4   FF4 - CSRBCR
> > + * offset  7FFF8   FF8 - CSRBSR
> > + * offset  7FFFC   FFC - CBAR
> > + */
> >  #define TSI148_CSRBCR        0xFF4
> >  #define TSI148_CSRBSR        0xFF8
> >  #define TSI148_CBAR  0xFFC
> >
> > -     /*
> > -      *  TSI148 Register Bit Definitions
> > -      */
> > +/*
> > + *  TSI148 Register Bit Definitions
> > + */
> >
> > -     /*
> > -      *  PFCS Register Set
> > -      */
> > +/*
> > + *  PFCS Register Set
> > + */
> >  #define TSI148_PCFS_CMMD_SERR          BIT(8)        /* SERR_L out pin=
 ssys err */
> >  #define TSI148_PCFS_CMMD_PERR          BIT(6)        /* PERR_L out pin=
  parity */
> >  #define TSI148_PCFS_CMMD_MSTR          BIT(2)        /* PCI bus master=
 */
> > --
> > 2.34.1
> >
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - You did not specify a description of why the patch is needed, or
>   possibly, any description at all, in the email body.  Please read the
>   section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what is needed in
>   order to properly describe the change.
>
> - You did not write a descriptive Subject: for the patch, allowing Greg,
>   and everyone else, to know what this patch is all about.  Please read
>   the section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what a proper
>   Subject: line should look like.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot
