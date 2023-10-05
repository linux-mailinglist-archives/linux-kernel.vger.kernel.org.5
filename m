Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1FE7BA470
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbjJEQFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbjJEQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130881F75B;
        Thu,  5 Oct 2023 02:59:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5041335fb9cso995857e87.0;
        Thu, 05 Oct 2023 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696499988; x=1697104788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHh0oBhZAG630AHNboT2hexNbuam5K6tY+jffHRgTKc=;
        b=JPSGDjQGH2l66LDseXbmTXS/Et764PY2qiHLRq1ZNVN7LC+wLSmhkyLeh3Lwg3jDZy
         ZVD1qbStK658dMVnSWqhUgy3jpGcXQUFIYF6tGY0e/O9uohffOuOGTkZ5MA/JCcKFbIe
         nxCjJBBwjyx2fpBzN2tg4hC06U4sVuZul4BvgScO3Xih6uqj8P03tqBWp5bKTWTLviP7
         FQk5tHGLDI9mnHn6pFTn92d0EOa9KU8GWULd6DyiBP9aTpcnWN/Fq/VfdoDFzXfjLvVB
         +8WvIx5PdJQwqwAH4B6zKCEgQnJy15kL7GVhLR+a+IejpabECQrMJFKM2DSdhuirvdby
         fkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499988; x=1697104788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHh0oBhZAG630AHNboT2hexNbuam5K6tY+jffHRgTKc=;
        b=WX/wkPKEafeOgVy3+kc+3Te+gYmY+WmxQJ4zKlDmabF7Fj5fnRDwNU5oPa8LJ7v6cW
         iS2eG7z495Pby5aP8a+HTHqTAMZPiw2z6tUqG972RZOzUS1XfUaAxcoEJcZCVoTAEK5j
         RHqIMpKNEc9IqKljPo6t/A7x1Eh4as1ahQcN+BLbawCQ9MMf9+Aoqz4SLTO9HoSuAfNQ
         AZ6yGVhej0doPCfXvjiuSauVfDQRbboW0jZ+Qu2ar9k1b661j7euGEiId9DgbU5S18Yj
         YD5kFSHmgec3vpxtrN9OoelUz4aDaKgrlpXKFe6E5e/Srt+KoghAZfA0kkPearoM8uvC
         IPTQ==
X-Gm-Message-State: AOJu0Yzhxw7g5nGL6WTEEXvp1+i05Vd8WUTPInGLpNJ4M9LaWQYtq6F+
        TWLT2CGLuXcnBcLcVXAk2ZmXWWJGlin4n0adkeI+HQXD
X-Google-Smtp-Source: AGHT+IFPACz7sGrDxBezV8qEBr3BzG13f2a87qwimWoz1maBHX2sPJvKE9svxA7G7+G6Ym0GhIJpzXKiz5DHQo/FB0E=
X-Received: by 2002:a05:6512:3a83:b0:505:7360:6023 with SMTP id
 q3-20020a0565123a8300b0050573606023mr5442022lfu.39.1696499987978; Thu, 05 Oct
 2023 02:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
 <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
 <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com> <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
 <ZRN9MtBqYnT6oX60@vaarsuvius> <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
In-Reply-To: <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 5 Oct 2023 04:59:36 -0500
Message-ID: <CAH2r5msDEs5Wi1aGc7KSDXXJv6FT_a5XmzM9oH-AnAWg2jCvTg@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de>
Cc:     "tom@talpey.com" <tom@talpey.com>,
        "paul@darkrain42.org" <paul@darkrain42.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "pc@manguebit.com" <pc@manguebit.com>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "nspmangalore@gmail.com" <nspmangalore@gmail.com>,
        "brian.pardy@gmail.com" <brian.pardy@gmail.com>,
        "bharathsm@microsoft.com" <bharathsm@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

FYI - Paulo is looking at an additional patch to address this (and one
small patch was also just added)

On Thu, Oct 5, 2023 at 4:55=E2=80=AFAM Dr. Bernd Feige
<bernd.feige@uniklinik-freiburg.de> wrote:
>
> Am Dienstag, dem 26.09.2023 um 17:54 -0700 schrieb Paul Aurich:
> > Perhaps the laundromat thread should be using msleep_interruptible()?
> >
> > Using an interruptible sleep appears to prevent the thread from
> > contributing
> > to the load average, and has the happy side-effect of removing the
> > up-to-1s delay
> > when tearing down the tcon (since a7c01fa93ae, kthread_stop() will
> > return
> > early triggered by kthread_stop).
>
> Sorry for chiming in so late - I'm also on gentoo (kernel 6.5.5-
> gentoo), but as a client of Windows AD.
>
> Just want to emphasize that using uninterruptible sleep has not just
> unhappy but devastating side-effects.
>
> I have 8 processors and 16 cifsd-cfid-laundromat processes, so
> /proc/loadavg reports a load average of 16 on a totally idle system.
>
> This means that load-balancing software will never start additional
> tasks on this system - "make -l" but also any other load-dependent
> system. Just reducing the number of cifsd-cfid-laundromat processes
> does not fix this - even a single one makes loadavg report a wrong
> result for load balancing.
>
> So, if cifsd-cfid-laundromat must really be uninterruptible, the only
> solution would be to change the way loadavg is computed by the kernel
> to exclude uninterruptible but sleeping processes. But must it be
> uninterruptible?
>
> Thanks and best regards,
> Bernd



--=20
Thanks,

Steve
