Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF827DF572
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjKBO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjKBO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:58:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED634199
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:58:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5ab53b230f1so744725a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698937136; x=1699541936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4u7No3WKyf2rx02w8WP9k4VSXCaz8LOG7ZTnqR2+ek=;
        b=OHHp3kAy8UYX+xqRVRUytgJFU646IvQeUQRZw6jf12UWISfC/CWNcDb/akytaeMOh5
         hWG5Ec1PVN8jpAfR6XOTycQ3QHqSf7XMsjBWylfDfBJGAyfZ5KrzJLaIkX2FeAPDVGOQ
         g4lbQtzQsmFrF8JVvkl26knMiWUjZb3nD+s2M+F2Z93TPF8Sb/odHPzvkwgYRydt9Zwx
         Uma7GxzFPS2rS5XtHwcr8I7Ih7YV3xdjNVlSAD+DwR2rb7i+Qu2jzI96Fyl87zrPRJj+
         fhHs0/NKFeXThIiASQYAmggbs8mJ4vMc8xPvIxyhyeObMDf62aNtshA54SKyqJOAoGCR
         YylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937136; x=1699541936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4u7No3WKyf2rx02w8WP9k4VSXCaz8LOG7ZTnqR2+ek=;
        b=iZRlth02gAX0lfh6nYvFx0s/VIJMz5yNYN7FNxAGkcAzANk+ohF/2t0BKs2R/bWe/+
         Tn2QjTd6Tom2D4I4bveHKPHfazr+lIIa6YIcGf+B7TGMbM9k7ZsC8V++Ru4i8tyw2THD
         3AnGIIdCmb+WLyxmEOJfjMwDb+hOAZJHskE61vS5jJtXeq3hfrt8qFj6gZNkhKRZSE/o
         QB4UByiYv92xeW2qICqzI7a/btbx+u4HBoHgYdC3n/IabWTNMSH9uUsbFObVbOVA4T78
         WQiK01NhCn+rgAOZ6+BiY8Ta1jupeNL6pwd1mprxccMBlNLul93hKQvRoHYsXkK4YirY
         VEnw==
X-Gm-Message-State: AOJu0Yz5sncZHKU911ECxzoP0Xhou6KM62dyC+6cEcs0ags5ekC/4fA9
        gzgH2EheLKYl8xqKaBuFUuzvatlMNDwWGJ7zrak=
X-Google-Smtp-Source: AGHT+IHdvPSy+RpNAcSrHdhaIDNs4asX/ZQ6VV/5u4vPmHrxV/dewik6XQ8cKyVnVlKlZ3jtll2O6CpvbNNzou36uSs=
X-Received: by 2002:a17:90a:ec03:b0:280:664d:cd9e with SMTP id
 l3-20020a17090aec0300b00280664dcd9emr10351944pjy.19.1698937136368; Thu, 02
 Nov 2023 07:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CA+fCnZfn0RnnhifNxctrUaLEptE=z9L=e3BY_8tRH2UXZWAO6Q@mail.gmail.com>
 <VI1P193MB07524EFBE97632D575A91EDB99A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+a+xfzXBgqVz3Gxv4Ri1CqHTV1m=i=h4j5KWxsmdP+t5A@mail.gmail.com>
 <VI1P193MB075221DDE87BE09A4E7CBB1A99A1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+bxMKEVUhu-RDvOMcbah=iYCWdXFZDU0JN3D7OP26Q_Dw@mail.gmail.com>
 <VI1P193MB0752753CB059C9A4420C875799A1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+ZS5cz9wZgxLVo2EsGtt-tkFXkFPA6CGAA8Gy7+sEyDUQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZS5cz9wZgxLVo2EsGtt-tkFXkFPA6CGAA8Gy7+sEyDUQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 2 Nov 2023 15:58:45 +0100
Message-ID: <CA+fCnZdRWs=P4EgzC9sSDLfO=Bxbs9FyeOcqAiY8pzvMLUX=Aw@mail.gmail.com>
Subject: Re: [RFC] mm/kasan: Add Allocation, Free, Error timestamps to KASAN report
To:     Dmitry Vyukov <dvyukov@google.com>,
        Juntong Deng <juntong.deng@outlook.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
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

On Tue, Oct 31, 2023 at 10:46=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
>
> > >>> There is also an aspect of memory consumption. KASAN headers increa=
se
> > >>> the size of every heap object. So we tried to keep them as compact =
as
> > >>> possible. At some point CPU numbers and timestamps (IIRC) were alre=
ady
> > >>> part of the header, but we removed them to shrink the header to 16
> > >>> bytes.

> > Do you think it is worth using the extra bytes to record more
> > information? If this is a user-configurable feature.
>
> If it's user-configurable, then it is OK.

FWIW, Generic KASAN already stores the auxiliary stack handles in the
redzone, so the size of the redzone header is 24 bytes. Perhaps, we
should hide them under a config as well.

However, the increase of the redzone header size will only affect
small kmalloc allocations (<=3D 16 bytes, as kmalloc allocations are
aligned to the size of the object and the redzone is thus as big as
the object anyway) and small non-kmalloc slab allocations (<=3D 64
bytes, for which optimal_redzone returns 16). So I don't think adding
new fields to the redzone will increase the memory usage by much. But
this needs to be tested to make sure.
