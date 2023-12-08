Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895AC80A5CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574010AbjLHOj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573970AbjLHOj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:39:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FF2198C;
        Fri,  8 Dec 2023 06:39:33 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-286f22c52c7so1762077a91.2;
        Fri, 08 Dec 2023 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702046373; x=1702651173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViZC4QTDPrahb7XF3coKuOMimJ85Gvvvh6o9Zss5j2s=;
        b=Q4UXMvvRWKH0IZCv/FPpEx7QYTWpw9+ZHxaro/aewLphTuNqUXTc4wY9V24CBvZb03
         wGojPepp3G7ZtJupUMEr7wvHA8De1ObrPaQp/iaOTwbcis2oZoYUDThkKYkvQUxffS1I
         GS9o8bQ41tTICDECEMX+4Xfc9iK5qPilKYsgWFhEDPiztxbpJ8kf3iyiAALLsyRY+ZXg
         xLtrDtns9l7XMy8nhh4RezgT1OEWvtkr9XuTfluWtttNlgsudz7xZ/rEAGOt71yLxlWg
         5Q8AyyXM5vaIP6nxtb4U8GH+FMVQpLNovYgi1EkLbznObCRLXrktvGx6FqMVEfPgdsck
         kQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702046373; x=1702651173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViZC4QTDPrahb7XF3coKuOMimJ85Gvvvh6o9Zss5j2s=;
        b=e6NVn0+FKwVV70JsIoCZTkj0TpwIUhB5ExNClvamWvCnhGpDUYqGQoze1NVfRGzO3V
         PNDP/iTp/WVu6+hyLH+irU9ePfWgc1fUpJfYO33M8vsxPqvSLFGBM96B9m32dS3g+GHR
         oFL8JyvqTJGGPZZX7Ad/KogNp91SzuZAQjAdfE5uahCoqi8/UVdz3OKfJIfUIbDyKlKC
         32Y4QqYJhhOb6+w9nK8HNOrqWvOqTWGXXgmFu7PzI02q1GErI6ei+TSli5gvIOuatfPv
         w2+pkK+udvbZCtUlwqktA7cIYWGArgs5NeAxWqnPMwGc5qyIh5CDgYl9aOpbCaAO4tME
         RhWg==
X-Gm-Message-State: AOJu0Yy/Ml5fCJ1PveZMAeBMWj0bOrZ3Z0X8fg0vULGcWUFLIbcdCGUJ
        o5rwvIkSd3Su6X6CSawD0tS3807ov/AdITX1y6A=
X-Google-Smtp-Source: AGHT+IFSCLgH3J+Ka1G1KsHmV7EcG/hW42tgGHQjDPIuUt6JHyxR/E7hkEsu459OTAx6ZhM3+XY4zimrK3tblt/OSKo=
X-Received: by 2002:a17:90b:300d:b0:286:cac7:3b45 with SMTP id
 hg13-20020a17090b300d00b00286cac73b45mr153817pjb.60.1702046372586; Fri, 08
 Dec 2023 06:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20231126191840.110564-1-andreas@kemnade.info> <20231127135424.GO5169@atomide.com>
 <20231127215108.6e985819@aktux>
In-Reply-To: <20231127215108.6e985819@aktux>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Dec 2023 08:39:21 -0600
Message-ID: <CAHCN7x+veM=izOVGEOvKpTFca53C0VhrLkscJqdcBX1riOOWbA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] bluetooth/gnss: GNSS support for TiWi chips
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Tony Lindgren <tony@atomide.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, johan@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ideasonboard.com,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 2:51=E2=80=AFPM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:
>
> Hi,
>
> On Mon, 27 Nov 2023 15:54:24 +0200
> Tony Lindgren <tony@atomide.com> wrote:
>
> [...]
> > > - Output at /dev/gnssX:
> > >   AI2 vs. NMEA
> > >   The chip can be configured into sending AI2-encapsulated NMEA,
> > >   or proving data in a binary format.
> > >   Some research has to be done yet for the details.
> > >   A pile of logs is waiting for further analysis...
> > >
> > >   Arguments for/against NMEA:
> > >   + Userspace is prepared to handle it
> > >   + Power management can be easily done by the kernel
> > >   - Less functionality can be used.
> >
> > I'd go with NMEA format as the default setting :)
> >
> yes, that would also be my preference.
>
> > >   Arguments for/against AI2:
> > >   + Full functionality can be accessed from userspace (incl. A-GPS,
> > >     maybe raw satellite data)
> > >   - Userspace has to behave to have proper power management
> > >   - No freely (not even as in beer) tool available to fully use AI2,
> > >     so there will be only a real advantage after long "French Cafe"
> > >     sessions.
> >
> > Seems AI2 could be optionally enabled as needed with some writes
> > to /dev/gnss0 to change the mode?
>
> Hmm, we have
> /sys/class/gnss/gnss0/type to get the mode, maybe we add some file
> to change the mode? Or having it hidden behing a module parameter
> and implement something better accessible if any need arrives?
>
> If we want NMEA output, probably some init commands will be sent at
> open(), but userspace doing something with AI2 probably does not want
> the device touched, so it should probably be already be set before open()=
.

Is there another revision coming or should I try to test this one?  I
am not very familiar with the GNSS part of the module, but it sounds
like there was some consensus as to which direction we should go.  I
should have a little time this weekend.

thanks

adam
>
> Regards,
> Andreas
>
