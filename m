Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791757A1352
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 03:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjIOBys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 21:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjIOByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:54:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF211449C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:51:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2749b3e682aso122924a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694742708; x=1695347508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqLoBm8H6ZiMRz1kerNsf8O/I1x2KB0Fau5qTkJBuRw=;
        b=m5w/4qnveZmS5IZO4IZnnmlhpD3AfLeZQyWl81dAoslfoHVPyE13zlKELRGOyfkGxA
         YM4x0wXWSTpDdHE1EH2y2ACx+bsDfxI6L7df/EE5FuhQoYVsJrqK17wNyp/Op5yKPpDd
         4So6PA/X+VO9NKibg/y5+NAIPGnQyPPBIjhgFnE0rGDB2bj/0KNXuApENvjzT08mM6nc
         5KEGCi1xplLjw/HsxxVC3sv1ryPWdYJu2J5n/p5n8XB7BZYOQ5x4e1Ec8cM+hvnhSRim
         6xD3v0BDNv0hU1HKASQxE23XiRVpVGIG6ENwMzV1bwxqcnmwLIDCpHLy4ruXTSzf5dne
         GYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694742708; x=1695347508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqLoBm8H6ZiMRz1kerNsf8O/I1x2KB0Fau5qTkJBuRw=;
        b=SFo7VYIIjEmSzdWwcoJgde/MOG/RrGjCxGTxxVS0+ms0kCNHfujA+GrXDZNTmVPwVo
         QFrLLbCS6Po59yfREu9Gqa/9cLknzEUh+zgqLbO0dJavm5pTFNa38fWQIhpxnL+Wyz7j
         MYPJyNrRdUIyZIK7lX/Gd3g7t68Y4W6DCLW1V4jiIdUFbJMlFuo8us7Yy00/AmK8Sae4
         ULwpolje0QbpiIo4MBgOqeEeKsZkhr3OlRsVsSkaaR4yAmEl8J+kVvvxh+ATWUPS/uyV
         /MRJ0ZD1437gH1KOdzF+JihkLbjnHZGEYQj7WT8D952ao8DbemqwKAj0MJDs08hIO9gt
         Zhfg==
X-Gm-Message-State: AOJu0Yw2cBU2gQn0O2vLshZ1qP/I+oV8Z1tTZBzi8oF+ZXlIhghb+Qbi
        B8vDy9VD1sC+JiYBmBc+Lm9zaoG4pKg9HmVxXTw=
X-Google-Smtp-Source: AGHT+IHypl50ozXbVNpyt6MCHdaoxCaRqBl2NAiMm+S4Y/6YOO7S8XoNh0lYeLcNgC9idrJZOsUI38MTb7wkV8Iedjg=
X-Received: by 2002:a17:90b:a49:b0:268:60d9:92cc with SMTP id
 gw9-20020a17090b0a4900b0026860d992ccmr210845pjb.43.1694742708242; Thu, 14 Sep
 2023 18:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230914080833.50026-1-haibo.li@mediatek.com> <20230914112915.81f55863c0450195b4ed604a@linux-foundation.org>
 <CA+fCnZemM-jJxX+=2W162NJkUC6aZXNJiVLa-=ia=L3CmE8ZTQ@mail.gmail.com> <CAG48ez0aenPmr=d35UGa4_BiCwYU1-JHhD_2ygThvjOEXEM7bQ@mail.gmail.com>
In-Reply-To: <CAG48ez0aenPmr=d35UGa4_BiCwYU1-JHhD_2ygThvjOEXEM7bQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 15 Sep 2023 03:51:37 +0200
Message-ID: <CA+fCnZePgv=V65t4FtJvcyKvhM6yA3amTbPnwc5Ft5YdzpeeRg@mail.gmail.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
To:     Jann Horn <jannh@google.com>, Haibo Li <haibo.li@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, xiaoming.yu@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:41=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
>
> > Accessing unmapped memory with KASAN always led to a crash when
> > checking shadow memory. This was reported/discussed before. To improve
> > crash reporting for this case, Jann added kasan_non_canonical_hook and
> > Mark integrated it into arm64. But AFAIU, for some reason, it stopped
> > working.
> >
> > Instead of this patch, we need to figure out why
> > kasan_non_canonical_hook stopped working and fix it.
> >
> > This approach taken by this patch won't work for shadow checks added
> > by compiler instrumentation. It only covers explicitly checked
> > accesses, such as via memcpy, etc.
>
> FWIW, AFAICS kasan_non_canonical_hook() currently only does anything
> under CONFIG_KASAN_INLINE;

Ah, right. I was thinking about the inline mode, but the patch refers
to the issue with the outline mode.

However, I just checked kasan_non_canonical_hook for SW_TAGS with the
inline mode: it does not work when accessing 0x42ffffb80aaaaaaa, the
addr < KASAN_SHADOW_OFFSET check fails. It appears there's something
unusual about how instrumentation calculates the shadow address. I
didn't investigate further yet.

> I think the idea when I added that was that
> it assumes that when KASAN checks an access in out-of-line
> instrumentation or a slowpath, it will do the required checks to avoid
> this kind of fault?

Ah, no, KASAN doesn't do it.

However, I suppose we could add what the original patch proposes for
the outline mode. For the inline mode, it seems to be pointless, as
most access checks happen though the compiler inserted code anyway.

I also wonder how much slowdown this patch will introduce.

Haibo, could you check how much slower the kernel becomes with your
patch? If possible, with all GENERIC/SW_TAGS and INLINE/OUTLINE
combinations.

If the slowdown is large, we can just make kasan_non_canonical_hook
work for both modes (and fix it for SW_TAGS).
