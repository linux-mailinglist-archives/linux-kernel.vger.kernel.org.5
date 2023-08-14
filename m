Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5642277B226
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjHNHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHNHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:13:45 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80885E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:13:44 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-79a31d66002so954583241.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691997223; x=1692602023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSIK9vN5r70ncmMdebOkMIKtWkePzDpm57uyC3G4UH8=;
        b=iaNG1cJrOV0dzhsepgxiEcxg4nIGEmzMvQWlyAMw+GvnJBZkqVE30Sui1FcKGawgdJ
         J6XrlLwi/GIA+x2ohuuNNRNoxixM0yjMyHdIQjP79xYEyEPhDhki9PmeT1O51anBhs7F
         YS0tz4o8t9TWtOqDzEyxlPv+D1paaJadb+uevRkBbbXs+jbTreY1Eqw0bQ7tMo1THDfC
         h7L1ks1s4YhgH3/xVYRisMyGV0cblz6J4UdrO3E0E+1tqaea+kS4rOxmSoQez3hnNe3W
         x/1WO4BeLM76QTMIzManhDLHTvh2jFyHdGRNFdTCIYJ3IgIzE4IwCWBgMhGKyQo1I9n2
         PTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691997223; x=1692602023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSIK9vN5r70ncmMdebOkMIKtWkePzDpm57uyC3G4UH8=;
        b=RFlHI6SbH89M1j/PBrZzEh+TnYmcIBQ+FhrytpgC2BPzb7gVpnZd9RqaVWnXTYaZhD
         BzogFN3CdtP6kfH1vtX8c/HLfCVYWvZZhCLXUs+nj/a8FkQgxmMX/p7Z8n6X9n3DDM1M
         KmOALeiCntllMTwr73mOrWOF6DSEk+8v9adWt5MYH1/rRER2sOiRUocdYiBpM7r09kDn
         CzBp48rxdUPIJJvPbQTNrtFTObsCZcT/1R2jH5YRoF6brsYkUJRrqjkGGa9VQJVOuOq8
         A2jB0JFivHrZgy3JPm2P8rmyOeWrRfyx8QJGWe8G+X3zVR2jKIyvLIbqOOi0UgKv79GX
         Vzxw==
X-Gm-Message-State: AOJu0YwqpvuV4vhuRxtkDYA4xytd8aJ0RUspcuoLm0XJ95YqgAylXBIe
        PPwfcInwktx+lEGYMUHoXK5IdenHuchZDcAC67TQVA==
X-Google-Smtp-Source: AGHT+IFkXkHNqkqt6aq7tslsKJBIm6XGqaxq7BjVjeT9wmj8RKndPrn/a8I+WF4tzv2E+MB9LhW+S1vEb+e86iTbpPE=
X-Received: by 2002:a67:e28d:0:b0:447:4665:b465 with SMTP id
 g13-20020a67e28d000000b004474665b465mr8850474vsf.19.1691997223159; Mon, 14
 Aug 2023 00:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230812194457.6432-1-brgl@bgdev.pl> <20230812194457.6432-4-brgl@bgdev.pl>
 <ZNl9Ok0JsI+S0Apx@yury-ThinkPad>
In-Reply-To: <ZNl9Ok0JsI+S0Apx@yury-ThinkPad>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 14 Aug 2023 09:13:32 +0200
Message-ID: <CAMRc=MeGXHj2bMsbqS=AK_R2V5EttPw016TO1ZU3HXhEV-tqXQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] bitmap: define a cleanup function for bitmaps
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 3:02=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Sat, Aug 12, 2023 at 09:44:56PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add support for autopointers for bitmaps allocated with bitmap_alloc()
> > et al.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  include/linux/bitmap.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index 03644237e1ef..6709807ebb59 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -6,6 +6,7 @@
> >
> >  #include <linux/align.h>
> >  #include <linux/bitops.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/find.h>
> >  #include <linux/limits.h>
> >  #include <linux/string.h>
> > @@ -125,6 +126,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits=
, gfp_t flags, int node);
> >  unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int=
 node);
> >  void bitmap_free(const unsigned long *bitmap);
> >
> > +DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
>
> bitmap_free() is a wrapper around kfree(), and kfree() checks against
> NULL, and returns immediately. Why this tests again?

I don't see any kernel docs making it a contract though. :)

It's a good question however. I carried it over from the kfree()'s
DEFINE_FREE() itself. I can't find any discussion about it in the
thread under Peter Zijlstra's patches.

May be worth revisiting it for free() functions that handle NULL.

Bart
