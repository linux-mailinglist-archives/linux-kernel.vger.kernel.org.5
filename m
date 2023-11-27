Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7F57FA227
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjK0OOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjK0OMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:12:07 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ABD1BFE;
        Mon, 27 Nov 2023 06:03:38 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5ccf64439bdso32090647b3.0;
        Mon, 27 Nov 2023 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701093817; x=1701698617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qq3XHggC/a3WTFnzVjobSSMgh8HRRAAcE/fjAZ01t0=;
        b=VC9i7dZPTSiHwvJspz+/BGZ3jsokO+JZGbkfSy8N8d1dpxrgH8xfFKRFg6+SgQEjaU
         jeYH976ym7kOc8DVL9WS4SCvjtwojJZIZJLeVxeLesfPniQZqGjO5USM9paGE4SEWXef
         xH8i1EEwKejio1+i02w+lG2uxgQbFbfKOaMfA3BIdJ/DXdBbvYuwbaqpqT4n/034h1Cl
         utxI1sdreJKzwmuZQOtipOMc0ROGRszHFYwAHwr6Vb69wDehg3pdxdVq2dXt1sLBlW0e
         AT/yS9EjPtUxq0rPT7yfVg6mgyEme2lD4hunGD7hWCLrxWZSRXi7UyHfi/4zW8ajrKwe
         waDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701093817; x=1701698617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Qq3XHggC/a3WTFnzVjobSSMgh8HRRAAcE/fjAZ01t0=;
        b=NKPYo/fi1jN8AZjykX0NvVTSv+BcVIwxUu/uW1AngEOhrn1j+hE+uYeOf97nnftVTV
         qPdrBs4nsXBnkTgQTQmOsX+racdJbNe9v4gu5RFScUAgwi8R5JKF502S6xJFh6ZhIJGP
         ztOznWuucLMLV73U6HhDFtbghO7JTM56kdCEA9gULkt4eaX+b2oEgFrJ9hzAZ+BUHogE
         12TIXriJ4wOVVG8mWxJCQaAL+9bZJIitj3fLknn4Rjzdqj+iwcrXC4Zi4z+INIOvQ3DB
         rphv/gVAGQwU7Cb+n0BMZATEEVSIx3gysebWYvAQxtTYEdIVC/mr+/BuFfyXKNqwcfap
         mJQw==
X-Gm-Message-State: AOJu0YwU9vI1v6e4CG/gRbkOdyuzUGq2FHpoR20ziysxlXdjSt4iEOVx
        vTtP6GzYt/0J6OAzYX9JMQ6rP/RqqttYD7pr91Y=
X-Google-Smtp-Source: AGHT+IEmHRYfXRedTzzihGNsfD/LFkVXBzlh6rcybI6dx782uFxPussnD/gDJbnTedNEPEvddo6RWd5woZk1MFg1ZjI=
X-Received: by 2002:a81:84d1:0:b0:5cc:61d9:21dd with SMTP id
 u200-20020a8184d1000000b005cc61d921ddmr10862420ywf.12.1701093816856; Mon, 27
 Nov 2023 06:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20231126191840.110564-1-andreas@kemnade.info>
In-Reply-To: <20231126191840.110564-1-andreas@kemnade.info>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 27 Nov 2023 08:03:24 -0600
Message-ID: <CAHCN7xL-HjK4WGVB7xHxWjAR0h7U6SLViLfWgur7Vc-bvf43+w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] bluetooth/gnss: GNSS support for TiWi chips
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        johan@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ideasonboard.com, Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        robh@kernel.org
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

On Sun, Nov 26, 2023 at 1:47=E2=80=AFPM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:
>
> Some of these chips have GNSS support. In some vendor kernels
> a driver on top of misc/ti-st can be found providing a /dev/tigps
> device which speaks the secretive Air Independent Interface (AI2) protoco=
l.
> Implement something comparable as a GNSS interface.
>
> With some userspace tools a proof-of-concept can be shown. A position
> can be successfully read out.  Basic properties of the protocol are
> understood.
>
> This was tested on the Epson Moverio BT-200.

Can you tell me which WiLink chip this uses?

I'd like to try it on the WL1283, but I want to understand which
WiLink chips you're targeting.

adam
>
> This is sent out as an early RFC to ensure I am going onto the right
> track:
>
> So the main questions I see:
> - is the approach right to abandon drivers/misc/ti-st?
>
> - Output at /dev/gnssX:
>   AI2 vs. NMEA
>   The chip can be configured into sending AI2-encapsulated NMEA,
>   or proving data in a binary format.
>   Some research has to be done yet for the details.
>   A pile of logs is waiting for further analysis...
>
>   Arguments for/against NMEA:
>   + Userspace is prepared to handle it
>   + Power management can be easily done by the kernel
>   - Less functionality can be used.
>
>   Arguments for/against AI2:
>   + Full functionality can be accessed from userspace (incl. A-GPS,
>     maybe raw satellite data)
>   - Userspace has to behave to have proper power management
>   - No freely (not even as in beer) tool available to fully use AI2,
>     so there will be only a real advantage after long "French Cafe"
>     sessions.
>
> More detailed tings:
>   - Some live cycle management is left out. Since it depends
>     on the decisions above, I have not put much thought into it.
>   - Should some pieces go into drivers/gnss?
>   - detection for GNSS availability: For now the node name is
>     used. But the device should be there if the chip supports it
>     and things are wired up properly.
>
> Andreas Kemnade (3):
>   gnss: Add AI2 protocol used by some TI combo chips.
>   bluetooth: ti-st: add GNSS support for TI Wilink chips
>   drivers: misc: ti-st: begin to deorbit
>
>  drivers/bluetooth/hci_ll.c | 154 ++++++++++++++++++++++++++++++++++++-
>  drivers/gnss/core.c        |   1 +
>  drivers/misc/ti-st/Kconfig |   2 +-
>  include/linux/gnss.h       |   1 +
>  4 files changed, 156 insertions(+), 2 deletions(-)
>
> --
> 2.39.2
>
>
