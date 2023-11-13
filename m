Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC27EA284
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjKMSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMSEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:04:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838C510EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:04:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc30de471dso8675ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699898652; x=1700503452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANsBnkxIEizgy+Rx0aSYLP0EtZ8VynwdjpRWu4uknns=;
        b=qO1JFdIEn4Nvh666UXvPHmpz+qydWVvt55AcYooiAMrHZeUoTEmI8D+xCDQva1cqBh
         0sUl6x1SUm859jcNbNGhFFkfUTNnlqmXVuNluts3VAlhHMAJPjAX5w4tBJl3G4HgTt4V
         Mw/oZjLfs2YvTTCqo0cCgX1MgIbIyMuPO+qvwc0z4Ci8EW2MzvPntmK11QmYMw0ecGMl
         pkl8utneiyxRJXJq8PUHxtZGpDTgjuAwE2P13Dc869L1SX0VXRKwgwyokXM9NIVrng4M
         rGdGsDc0mueDs8xFCuUb22cj0DfnkhHnmEN8/6iLjozS2tCMUl4gOP9VtDmgZN/xkBWC
         3cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699898652; x=1700503452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANsBnkxIEizgy+Rx0aSYLP0EtZ8VynwdjpRWu4uknns=;
        b=SXPU4B1qUmAzwfB1miIBf0lJUVrbpr8WsGdmWSCYYTQdIrtv8DSqzMI3iTA6Zi+8AV
         to4A5GHoeoE6FfQQoBV69M/L9gZEir77XGsEBoN8d0PyMR8XldWH8fLHGK9PNHmVIW7I
         VSPJks/ofIZKT18E2vjVGR9dum9gw3Bf3wfNi2psMUkOwQZQjKEYhJQWYWsJef5fpDTz
         KAO4ZrOIdVjVP5+gQkfcrFNC8EmBKzvGlPyfHmpwLBgyETojlkjvr1+zd39IPvaYlp8g
         Fop8Sa7joP1ZBnuhmpEoIvzEyEZjH3Egh73XB1QmbchgJ6kHzLtHqWWzvhBUxeWG2N9f
         eFow==
X-Gm-Message-State: AOJu0YzgKOCZq5S2XvsMk5nwmIxrXQFYlUUXp8ieNrwBa2fQgf5iHQYT
        fCZkl/xWZ+aNmseo9knjwQPZYsSVgkbIIdKt8+4y
X-Google-Smtp-Source: AGHT+IHb03F7T2KTb6TSXiR1tmUr6UGViGF0nZ4nr88w91aDnu2AAQ+8uxUpsoeNCFN6pRoOfEgnDys2xBb/WNxE3dc=
X-Received: by 2002:a17:902:d491:b0:1bc:29c3:5895 with SMTP id
 c17-20020a170902d49100b001bc29c35895mr19363plg.0.1699898651665; Mon, 13 Nov
 2023 10:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20231106120423.23364-1-yunfei.dong@mediatek.com>
 <20231106120423.23364-5-yunfei.dong@mediatek.com> <ZU/D3iDxIW6Q8bOq@duo.ucw.cz>
In-Reply-To: <ZU/D3iDxIW6Q8bOq@duo.ucw.cz>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Mon, 13 Nov 2023 10:04:00 -0800
Message-ID: <CA+ddPcNtZ5XRNZOOm4+C+SBpo0jLWpMZ1xOPrR-Dj_CQpT9s5Q@mail.gmail.com>
Subject: Re: [PATCH v2,04/21] v4l: add documentation for secure memory flag
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        John Stultz <jstultz@google.com>,
        Yong Wu <yong.wu@mediatek.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek,

What happened to the RFC cover letter that explained more overall for
what this is for?  That should be included in the 0th patch for each
of the series.

Pavel,
This is for secure video playback where the memory is 'secure'
(TrustZone in this case) and is only accessible in the TEE and
specific HW blocks. Userspace has FDs that reference the memory, but
kernel/userspace can't actually map/access that memory.  And yes, this
is for supporting DRM (Digital Rights Management) playback.

Cheers,
Jeff


On Sat, Nov 11, 2023 at 11:06=E2=80=AFAM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > From: Jeffrey Kardatzke <jkardatzke@google.com>
> >
> > Adds documentation for V4L2_MEMORY_FLAG_SECURE.
>
> > --- a/Documentation/userspace-api/media/v4l/buffer.rst
> > +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> > @@ -696,7 +696,7 @@ enum v4l2_memory
> >
> >  .. _memory-flags:
> >
> > -Memory Consistency Flags
> > +Memory Flags
> >  ------------------------
> >
> >  .. raw:: latex
> > @@ -728,6 +728,12 @@ Memory Consistency Flags
> >       only if the buffer is used for :ref:`memory mapping <mmap>` I/O a=
nd the
> >       queue reports the :ref:`V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS
> >       <V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS>` capability.
> > +    * .. _`V4L2-MEMORY-FLAG-SECURE`:
> > +
> > +      - ``V4L2_MEMORY_FLAG_SECURE``
> > +      - 0x00000002
> > +      - DMA bufs passed into the queue will be validated to ensure the=
y were
> > +     allocated from a secure dma-heap.
>
> Could we get some more information somewhere? Why would userspace want
> to work with "secure" DMA heaps? How exactly are they different from
> others? What attacks are these secure against? What is goal of all
> this? DRM?
>
> BR,
>                                                                 Pavel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.
