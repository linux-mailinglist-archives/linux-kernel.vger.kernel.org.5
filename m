Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6787F5457
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbjKVXNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKVXNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:13:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0286D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:13:11 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cf897c8de1so1738615ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700694791; x=1701299591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwznl9KTGkJM5XPuI3izDsWPQdxM5T7uw0a2p5x8c0w=;
        b=aNDnyVO3t/phxPKhbMBku1r2qL12Wy0WAs/hoUpijyIe9EkDu1WxNKLm4c+C9n77T3
         5ki4itmuucUnd5dfYVHTWbrnAfxmQ4Ay3RNvAjm3XK2q9PfMxS4UTxlnO/MjT6m7BAko
         7iDdugljrG4DT2FXjODOca3S0KY2EcG3mwsWgAs9IpjU0+oNjvngnTS5MzlgegIfk8QL
         p61YHvXtRe9qANdU6tebwDPYHEPYWzQ9vB6GyaUzAAR1ykuCjZbzly4ZxzeouTsH3tYc
         P+zjGQq++YynCWPKpLxc7BL4raq4QkmE2Xpc227l6S+bzJK0Oo9iAn+0w06UKKX2W6Q4
         5HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694791; x=1701299591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwznl9KTGkJM5XPuI3izDsWPQdxM5T7uw0a2p5x8c0w=;
        b=VvffK0RiIyyUQmAJ2TKOMGbUH2ZMztmt4MJstowxMpsesNwMt9Ep2D6T31IzAvsjdD
         Eplmj96c5Bwd/0oeGsnTewvfS5d37ZKZ4r6NsjYacN2+iUQDpZ84sOA4B0LaFpWZgm8m
         OfxLur41jpNYfvLBkh5k4gweqNTw6PJW3hnkQeQjmSip6Sw2eDCtl8Lm9Prc4szOBPxZ
         Wk18/0MdLRop8f5d92eGOea09ob99rjk9URPjpCPmQWRa9l5wVC64pNmij1b/dlD3Dsj
         fobDN9CUpCO2TVr/4BpHzfQJkOet3E4F/GESJD3VBcnCGpd9u/dQuPorvFxJNU5ACVxl
         fNOg==
X-Gm-Message-State: AOJu0YxnmDcnqcRrHSDzyKN0CoH9Ito+ZDjTIcT+jjR/vvLnnLH9tUbj
        TCRaSL7DqqKbtZANCHrDrcloXLi3ySZ3fD0Xn30=
X-Google-Smtp-Source: AGHT+IGf3oPjZ4tCuYxiXArRZtd2g18U/dtfgi++B1Sq34Lp4/qi0PCMxNrrUgr8ypZmQuCtBDN5QS5o0dpAX5oyISU=
X-Received: by 2002:a17:90b:38c8:b0:280:14ac:a6db with SMTP id
 nn8-20020a17090b38c800b0028014aca6dbmr4019309pjb.18.1700694790978; Wed, 22
 Nov 2023 15:13:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700502145.git.andreyknvl@google.com> <5cef104d9b842899489b4054fe8d1339a71acee0.1700502145.git.andreyknvl@google.com>
 <CAB=+i9Q95W+w=-KC5vexJuqVi60JJ1P8e-_chegiXOUjB7C3DA@mail.gmail.com>
In-Reply-To: <CAB=+i9Q95W+w=-KC5vexJuqVi60JJ1P8e-_chegiXOUjB7C3DA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 23 Nov 2023 00:13:00 +0100
Message-ID: <CA+fCnZcnL9w=iMgtOqw=bUYRhM2c0MbSbeQUfgzSffqghMutHg@mail.gmail.com>
Subject: Re: [BISECTED] Boot hangs when SLUB_DEBUG_ON=y
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 4:17=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> On Tue, Nov 21, 2023 at 1:08=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Evict alloc/free stack traces from the stack depot for Generic KASAN
> > once they are evicted from the quaratine.
> >
> > For auxiliary stack traces, evict the oldest stack trace once a new one
> > is saved (KASAN only keeps references to the last two).
> >
> > Also evict all saved stack traces on krealloc.
> >
> > To avoid double-evicting and mis-evicting stack traces (in case KASAN's
> > metadata was corrupted), reset KASAN's per-object metadata that stores
> > stack depot handles when the object is initialized and when it's evicte=
d
> > from the quarantine.
> >
> > Note that stack_depot_put is no-op if the handle is 0.
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> I observed boot hangs on a few SLUB configurations.
>
> Having other users of stackdepot might be the cause. After passing
> 'slub_debug=3D-' which disables SLUB debugging, it boots fine.

Hi Hyeonggon,

Just mailed a fix.

Thank you for the report!
