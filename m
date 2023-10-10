Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4C7BF06A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379378AbjJJBmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379364AbjJJBmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:42:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5D99D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:42:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-504b84d59cbso6818262e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696902168; x=1697506968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r8xsqUE1WfCL4pE6OYo22lswirb6FPZBD4Cqt+Avvc=;
        b=CDF1Bh7ip6AuzL3cd67XupnqG3EiLJG//Vj+gYJ7ujTVVwHk9QqmMS2shD8kQ61cU0
         lCRPqKssiXzHvMp/HkgBH2wSutWs5YWO63nP0fcu8EVVlfaoE5WtOetlVUqTLqKdMYbI
         c2UQN+Q3H3RhZijk2zN02OFk61neepd9R35bXZ8nJUs50Ot+ZW1rrw3c49brvprm1WZx
         Cgo+SYhlhxad5/ctzzEBP/FN3sUUNMTJqQWVDO10q0b9A73c2ftZaYudiBkFwyo2VTln
         JumFVYwG8KsDFS4j45pZ3V2dco2fIGZ/D60yekOVAN+raFHGJPaYxV7lm3yECF7AxIMn
         IRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696902168; x=1697506968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r8xsqUE1WfCL4pE6OYo22lswirb6FPZBD4Cqt+Avvc=;
        b=SnRyjTVklaJuUPJhlNywQ+hEghRQNjesD2KONnIqRr+rfTiAD0JzmBlJRGP60A377y
         vICFIAKrfdXwYA1F9JHCRN09K2WZCQwsc9b9aqCpc8TgzWJTuHSdKBVG4XGJCj2wHOHp
         vvUUEIhmyJI0c4EKKPfic4a7Tg7XyIwULi2kasZxnCVM9fAWfSvVk214441H/oudKTxD
         b9YOy0DzZvOp1X+JojWBfB3wJJMAtOHpbXjfEaTYz/3bmV0KGwbyAnq8PisA/wH4TgzZ
         IsObfXEwLT+B2vcNVLr2awyBpTktRq1gJgYnwdJYPkrZ0wLi4vS8s1bjpy18slNoas3q
         v7GA==
X-Gm-Message-State: AOJu0YwBVnVvJACz9ylYCn9G6a9ElqZ9GmANJ/LMc+0viIc181D2D33Z
        0wIcd6X/qcxvLN1Es5jMf2/zwJoJN63kpw5a6WY=
X-Google-Smtp-Source: AGHT+IEPcd/ue90wff4n2u/SRx6h6zwqRB8fhsQ1HkkqaByi1Z9uVEyKoevP73q+nimJAh929A9LfXs8aPzzsK5Em44=
X-Received: by 2002:a05:6512:3e20:b0:502:9fce:b6cc with SMTP id
 i32-20020a0565123e2000b005029fceb6ccmr19062741lfv.11.1696902168001; Mon, 09
 Oct 2023 18:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <1683782550-25799-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20231006141750.5423083520f74bc0746fd249@linux-foundation.org>
 <CAGWkznHqQHMN1QXz7os7AQTYdzc3+LEq+z2bWOzLbiseV=560A@mail.gmail.com>
 <20231009171415.cfc26b45c2f9f4489afe16c2@linux-foundation.org> <ZSSpfw_VdFkus4F5@P9FQF9L96D>
In-Reply-To: <ZSSpfw_VdFkus4F5@P9FQF9L96D>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 10 Oct 2023 09:42:36 +0800
Message-ID: <CAGWkznG+-j8WqM6wSf5yaSi7qZzyb0SbkbOH1Cwq7WaQ1-6RGA@mail.gmail.com>
Subject: Re: [PATCHv5] mm: optimization on page allocation when CMA enabled
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
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

On Tue, Oct 10, 2023 at 9:31=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Mon, Oct 09, 2023 at 05:14:15PM -0700, Andrew Morton wrote:
> > On Sun, 8 Oct 2023 15:54:40 +0800 Zhaoyang Huang <huangzhaoyang@gmail.c=
om> wrote:
> >
> > > > Roman previously asked
> > > >
> > > > : Also I'm a bit concerned about potential performance implications=
.
> > > > : Would be great to provide some benchmarks or some data.  Probably=
 it's
> > > > : ok because of we have pcp caches on top, but I'm not 100% sure.
> > > >
> > > > Are you able to perform such testing and tell us the result?
> > > I have applied this patch in a v5.4 based ANDROID system and got no
> > > regression problem. Actually, this commit is aimed to have
> > > alloc_pages(GFP_USER) use CMA instead of stealing U&R(could lead to
> > > GFP_KERNEL fail) only when zone's free pages and free cma are around
> > > WATERMARK_LOW/MIN which would NOT affect most scenarios.
> >
> > OK, thanks.
> >
> > Could the appropriate people please take a look at this?  It has been
> > in mm-unstable since May.
>
> I have 2 concerns:
> 1) it's still hard to understand the commit message and comments, I can
>    only reverse-engineer it based on the code changes;
> 2) performance concerns I expressed earlier are not addressed. Idk what's
>    a good benchmark for the page allocator, probably something i/o or
>    networking heavy.
>
ok, I will update the commit message

> On the positive side I believe that the patch is solving a real problem.
