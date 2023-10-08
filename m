Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44D47BCD16
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344530AbjJHHy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 03:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbjJHHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:54:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEEB9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 00:54:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-503056c8195so4553723e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696751692; x=1697356492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ybWsiM5qmAMlRSNxHIcO5FISDf2R/6M1HLZgzc2OyE=;
        b=jtQgP67JG1Vk/d6nHa4kJ2RKqOsR1AT2WHjx+x4jcTnulXnAgfwOVHbws5alfbQ/Mw
         3N2OgUUmDKe08pouSU5tBO0LKOjhHeCqbyUD+WNu99YK7wkOouehPfV6fSoqByt4i/N+
         kdaYXQbr6iCDFnNlYoR8Iwg17jnEOJR2ryKSU43pZiEzLXcVgCwAbqzH8EFtq0imv8FU
         jqBhzQCmowvkr5fMwG/QMfqxW2Bl4Ri1PYXtFqrcm4JHKEZmBsb+L2sb0kcYiYdQqGDl
         cCMJ1Fjfj+X1k0zlzeQFC9MRq7ecQrUIfeZEeEBFimWmOW/S4cywQ7Yk2/KNAf0uxjLD
         NngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696751692; x=1697356492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ybWsiM5qmAMlRSNxHIcO5FISDf2R/6M1HLZgzc2OyE=;
        b=X75iLjs6hTaGMYHLLnwq0r2hSv2zkGiwxJStfJZ2y09hrZCWaS0eZ6zhnatCDJdlku
         okxHZH63sSIkFSd3GAfgcUZG3VDGK+r0l/2u6j2qlpvFBpv6eZ+srVFJGoY1QpL/bwEm
         kE2U2K+6Im0UcMXe/syxkLnFuOGASV/lrtf3Tq6P7B6rmJ9Z1JdK9hmLpJyc+cjU3PGG
         Ceg+ze1vwEpYwHKjx6ZSSLU315yo5dO4WXMdbU08bdS6aYgj6T23vqp2aUt+6TLejdbA
         P7CzB0RxSILEoidjS/f9/s5/h6oljFSo7LMHrOft6LyiYPJbiQ9/U25l9NnNOm5v3OQT
         OdRQ==
X-Gm-Message-State: AOJu0Yxp8ZmBV4ZMKWiInWiQrXlA/WQlOMY/z7+QKSY7+aWoQd6uVz8Y
        R9PmW0shjpeOYzxpPa+MhbCyRkqi4kBFbKr4/K8=
X-Google-Smtp-Source: AGHT+IGNR8sIJlB9RCF0cke5x1PU3N5B7/RWqbeLc8Qyhvm94pVpvPikAAdUJKHkueru8PVKUROHwgMnJ500go+UHVM=
X-Received: by 2002:ac2:4f0f:0:b0:504:3c1f:cbd9 with SMTP id
 k15-20020ac24f0f000000b005043c1fcbd9mr11832829lfr.16.1696751691419; Sun, 08
 Oct 2023 00:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <1683782550-25799-1-git-send-email-zhaoyang.huang@unisoc.com> <20231006141750.5423083520f74bc0746fd249@linux-foundation.org>
In-Reply-To: <20231006141750.5423083520f74bc0746fd249@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sun, 8 Oct 2023 15:54:40 +0800
Message-ID: <CAGWkznHqQHMN1QXz7os7AQTYdzc3+LEq+z2bWOzLbiseV=560A@mail.gmail.com>
Subject: Re: [PATCHv5] mm: optimization on page allocation when CMA enabled
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
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

On Sat, Oct 7, 2023 at 5:17=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 11 May 2023 13:22:30 +0800 "zhaoyang.huang" <zhaoyang.huang@uniso=
c.com> wrote:
>
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Let us look at the timeline of scenarios below with WMARK_LOW=3D25MB WM=
ARK_MIN=3D5MB
> > (managed pages 1.9GB). We can find that CMA begin to be used until 'C' =
under the
> > method of 'fixed 2 times of free cma over free pages' which could have =
the
> > scenario 'A' and 'B' into a fault state, that is, free UNMOVABLE & RECL=
AIMABLE
> > pages is lower than corresponding watermark without reclaiming which sh=
ould be
> > deemed as against current memory policy. This commit try to solve this =
by
> > checking zone_watermark_ok again with removing CMA pages which could le=
ad to a
> > proper time point of CMA's utilization.
> >
> > -- Free_pages
> > |
> > |
> > -- WMARK_LOW
> > |
> > -- Free_CMA
> > |
> > |
> > --
> >
> > Free_CMA/Free_pages(MB)      A(12/30) -->  B(12/25) -->  C(12/20)
> > fixed 1/2 ratio                 N             N           Y
> > this commit                     Y             Y           Y
> >
>
> Roman previously asked
>
> : Also I'm a bit concerned about potential performance implications.
> : Would be great to provide some benchmarks or some data.  Probably it's
> : ok because of we have pcp caches on top, but I'm not 100% sure.
>
> Are you able to perform such testing and tell us the result?
I have applied this patch in a v5.4 based ANDROID system and got no
regression problem. Actually, this commit is aimed to have
alloc_pages(GFP_USER) use CMA instead of stealing U&R(could lead to
GFP_KERNEL fail) only when zone's free pages and free cma are around
WATERMARK_LOW/MIN which would NOT affect most scenarios.
>
> Thanks.
>
