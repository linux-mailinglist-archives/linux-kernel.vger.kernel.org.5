Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3077D7431
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjJYTXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYTXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:23:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063AA13A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:23:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdf4752c3cso213985ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698261784; x=1698866584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m31BwFRcj7ARX8+GTG5pwS7sZOyZiRPn3jP/pVTMYz0=;
        b=ahuPfTwqVORFjm/TB3m4v69p5BB83Y2ZeIJaTziuCKOsehESlAF/vvLE12r1ly2xEN
         nxQNEX6tde6GLWmwYtBYGc8bFzU6Hu1Vqlaf33ccrGj1wBQeTCyMayNQgkAYreBX1udh
         l4a+bmNwhieaE+XofASqbK/kBHMQMmz47l+PeEp+DftYKpwCM2o0pzvtGdJUAncFXPP3
         9ERw6EBbeJgvhioc6swNKiHz5riheXQGX41Dy0gVKsubLj07FIeZIIQOkqTPCAp6MXVV
         iNy4EThOKFHMeGGRbGNF/KZOymBEYUo3JUVHU/cC1dQ8jGH9bE9ivNT2uxMXi9npeqV+
         Hx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698261784; x=1698866584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m31BwFRcj7ARX8+GTG5pwS7sZOyZiRPn3jP/pVTMYz0=;
        b=Y4fjG1YmxRaFRXFbUGHiG0w0CB9hL+zBhF/69aadjvzW6F8cVYyYOX4SfByY1awQqJ
         snGbLa9gYH9MFY4lpm3XZKlBvHWkcGPTQrepoLI5D0mXwsZHo8/28NvrqOVaTQ2TJqRp
         XBPVdaKKp98onRzvN2gLL7R5J4gOxGCJW0Xl5xTNvMlIfGniWLD3+fApd0XjF6RlY44f
         1IM5Z8tcNlvqN9c+vHN7ICWJ5QmTvWm/ssSDgv9kqg4crNTnyyuQwnFsrps6+8mJp8bE
         0Wssjj1Io2lHn1GKCwWUGcjEDdBVJhMVDXGd3OuplRYmvIhzMMjav2hlsQHpFC9/f0jU
         2i+g==
X-Gm-Message-State: AOJu0YyasC+ndjdIB+XPI0GNs8ABXP0tqBQHNxqADV6RuEvTTFmuS66q
        I8a3Ll44d8DcLm/2l3OFv+ly2AyXwpwUBl8U7rE=
X-Google-Smtp-Source: AGHT+IEXkPuONFu7qOjHo6srCclNtmMeCXeOu/J8zGOvFhjtxKftxqmyNPajTQ0aexxNZJvaOT4TbzjJShoyZqEa0b0=
X-Received: by 2002:a17:90b:1b49:b0:27d:4513:9c99 with SMTP id
 nv9-20020a17090b1b4900b0027d45139c99mr14243752pjb.17.1698261784445; Wed, 25
 Oct 2023 12:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 25 Oct 2023 21:22:53 +0200
Message-ID: <CA+fCnZfn0RnnhifNxctrUaLEptE=z9L=e3BY_8tRH2UXZWAO6Q@mail.gmail.com>
Subject: Re: [RFC] mm/kasan: Add Allocation, Free, Error timestamps to KASAN report
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 9:40=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> The idea came from the bug I was fixing recently,
> 'KASAN: slab-use-after-free Read in tls_encrypt_done'.
>
> This bug is caused by subtle race condition, where the data structure
> is freed early on another CPU, resulting in use-after-free.
>
> Like this bug, some of the use-after-free bugs are caused by race
> condition, but it is not easy to quickly conclude that the cause of the
> use-after-free is race condition if only looking at the stack trace.
>
> I did not think this use-after-free was caused by race condition at the
> beginning, it took me some time to read the source code carefully and
> think about it to determine that it was caused by race condition.
>
> By adding timestamps for Allocation, Free, and Error to the KASAN
> report, it will be much easier to determine if use-after-free is
> caused by race condition.

An alternative would be to add the CPU number to the alloc/free stack
traces. Something like:

Allocated by task 42 on CPU 2:
(stack trace)

The bad access stack trace already prints the CPU number.
