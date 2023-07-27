Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F778765614
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjG0Oji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjG0Ojg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:39:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3088F2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:39:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso1774325e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690468774; x=1691073574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWogpP48VAKbZixYqHyKGdj9UJnQsYfWULQuSx+fR9M=;
        b=D91f7wsGFHfzZp28yTfC6cbBGSIy0tZxbq5YuDkBy89TvucBCcQwZOXZ4qSueWIM+q
         600JgTjqoFsRryoySOnd2qrt9yBHANGH7qqOvYdEOe6DhDFUZeSaOagJBxE1aiLHM2aN
         0pGKrN/BIoMv7Sa4Komax3LtgxkbnV/Y03755oHkMHLGSGxznhz+47XrhabjwSq32KIY
         YevQkajAmS2iSOVdXdYMNQlq9ZGm1R9W9+WQ3MZ3Abbx027Ix+GTYM6Fp4eOzaPP4n7X
         MATH5L2CkFU7wKpGRi5ipoYCFnZwZdvWRn9boESOz+VKHhv9d4P7ESCTMcO4MFB799SX
         Zdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690468774; x=1691073574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWogpP48VAKbZixYqHyKGdj9UJnQsYfWULQuSx+fR9M=;
        b=PNBplgVxMld6p9vHVwFZS4rgnPyLC5pCuFX+8MRE2t91i8/t5Q1F6Ev+tf5B6Gu0h5
         sDLjtmzEPf6cHHrWwPgnZPHKn2gX6aWLOZIObBQyCqmoDqbjDc+nxfAUz4+aQ1oTXvRp
         QIqRGUrRGy0wu9hmNnIosvqp+DUFPqJGWJuH76drK0n7xiOESk/66k3pDwi2BXvQZ0Lq
         Oif+jnXy+s+rwJ2oNxTIU8ml3gRHRsr2ErckhXmBedkcJu0giuX54w5oPSIwVOmBt3D9
         EtzffNOl9qWSjdKoTCptcKfVTrucFHA9QqW/lTJorjrpxZzfdHzpMaWq6Dbhtm1GbiSN
         QLMw==
X-Gm-Message-State: ABy/qLYHGSFnuUXTCROcS+XJ0w6w2PMEbQTDO8yAvozQtX7VefPQ5qS/
        SrSMTj6TDUdvMHrnBt00xiF50zAc+IdGQFGXo/zAKY/H+l4=
X-Google-Smtp-Source: APBJJlHh668a6d2D2aViLXMZVaf2JZCqffs1So06/NrZbeP1DEcA38cHH9cuboqEYcUWMG1fA4Ms7S54jow+J+E8cW4=
X-Received: by 2002:a05:6512:2210:b0:4fb:73d1:58e5 with SMTP id
 h16-20020a056512221000b004fb73d158e5mr2197695lfu.53.1690468773435; Thu, 27
 Jul 2023 07:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230727020207.36314-1-yury.norov@gmail.com> <20230727020207.36314-7-yury.norov@gmail.com>
 <ZMJBwAwTN0pTZMkf@smile.fi.intel.com>
In-Reply-To: <ZMJBwAwTN0pTZMkf@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 27 Jul 2023 07:39:22 -0700
Message-ID: <CAAH8bW87RcXR4ZkaXnGpyz6mMVh4mCOksYE8NMXuQVkHsbd7eg@mail.gmail.com>
Subject: Re: [PATCH 6/6] bitmap: move bitmap_*_region functions to bitmap.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 3:07=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 26, 2023 at 07:02:07PM -0700, Yury Norov wrote:
> > Now that bitmap_*_region() functions are implemented as thin wrappers
> > around others, it's worth to move them to the header, as it opens room
> > for compile-time optimizations.
>
> Don't forget to run
>
>         scripts/kernel-doc -v -none -Wall
>
> against this header.

OK, will do. Also, I seemingly created patched from the wrong branch,
so it's a wrong order of declarations in the header. Sorry that, I'll
send v2 after collecting some more comments.
