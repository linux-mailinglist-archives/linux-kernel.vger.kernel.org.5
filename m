Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0767B7BEABD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378404AbjJITkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346683AbjJITkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:40:01 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523A894
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:40:00 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57b811a6ce8so2805024eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696880399; x=1697485199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ3ZfP4NZWf00Sp5FRs8A4GOic8A7MU965Tw6O82KGM=;
        b=k7hnlZ1i+LRb+ifysDdVQzZ/P8daRByx0NUijYkdIRFNUUpDSugAPTxGYuWz0y0d6Y
         N7+24o4QhAmCkKDQPyrH+WlkV5rcGT65iT0c9V59OcRqxp1uhGs9hZquGJ3oHmd8+iiI
         +xLTvTsji1VlxU+hhinLsKHTx93Uj6VUMN82+NLiOK9ObyAsD4R4PNqnLc5g1szQxQRo
         M1m04W9xEPwjgjwjFsTQciJnvcgWs7oZS28UdEf7Gw4wVY38iVlrJdJkaXGZwq70KtdO
         3BkJrNSLC/+JzWUb1VIC0NAk3bksJN5sKNStMywQvU9CEFR4SwkyoDGUdpS9v+hyxfOW
         /PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880399; x=1697485199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQ3ZfP4NZWf00Sp5FRs8A4GOic8A7MU965Tw6O82KGM=;
        b=KWv+3rTK9trrRValE9nPadi08bTOG/hjESrREvigmyy/dXo3x771QfIDGnP2OGrdMp
         pPT6+PP5VF11EjUKZcOugax5mzVsMeD0cl6R6+MVmoaOUosuu7MmJA7ezNW1l6WGwbVY
         dfr2nYJeGhZf5VpMnEvwge4FEmuehzyoTnqtdyPlqwOiN/sCYYlxDJ5hIAAmaf1hck0Y
         MOjAbPS4Ofz+YfsWO2d4RpdIz4sqIeCoHZJSEHnUU/xhJiBhH9iK5tSebVAG8EKFpi+t
         fH12BnLVLu+5oBzTYXi0MK+HLt2uV20Yp6IGZ1CLnXW26uD8/gGT6uMzn12SDiO+2lit
         jK3g==
X-Gm-Message-State: AOJu0Ywr7C+y6YQsyW7KZd5S34VX0pbK0JSIM35L4TMKhsrYg8LgFBvG
        sbdAB4PPBCQ/jPUhz3e+ALrevDHZLTq96OpWBAVdt9+kpH7M8g==
X-Google-Smtp-Source: AGHT+IFQ1z0iLfWVYTfPMKFRhmfh3lWF2cmkbzgQ0myasZOx1Pd1MA1sOEywCGMNDjh4BHTU7zOvZVAvfdrCcdKPidI=
X-Received: by 2002:a05:6358:591c:b0:143:7d73:6e63 with SMTP id
 g28-20020a056358591c00b001437d736e63mr18655566rwf.2.1696880399492; Mon, 09
 Oct 2023 12:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <CA+fCnZckOM0ycja3-=08=B3jwoWrYgn1w91eT=b6no9EN0UWLw@mail.gmail.com>
 <CANpmjNNoBuNCf5+ETLOgMbjjYFT0ssfb4yyYL21XRrOgMc_mfg@mail.gmail.com>
In-Reply-To: <CANpmjNNoBuNCf5+ETLOgMbjjYFT0ssfb4yyYL21XRrOgMc_mfg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 9 Oct 2023 21:39:47 +0200
Message-ID: <CA+fCnZd3HdXyx3dS0-3TQMDFbm1=qFQK7-2drHE1LE1ON=Ao8w@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] stackdepot: allow evicting stack traces
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
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

On Mon, Oct 9, 2023 at 2:35=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> > Hi Marco and Alex,
> >
> > Could you PTAL at the not-yet-reviewed patches in this series when you
> > get a chance?
>
> There'll be a v3 with a few smaller still-pending fixes, right? I
> think I looked at it a while back and the rest that I didn't comment
> on looked fine, just waiting for v3.
>
> Feel free to send a v3 by end of week. I'll try to have another look
> today/tomorrow just in case I missed something, but if there are no
> more comments please send v3 later in the week.

Yes, definitely, there will be v3. I just wanted to collect more
feedback before spamming the list again.

I will send v3 that addresses all the issues and new Alexander's
comments (thanks!) next week (travelling for a conference right now).

Thank you!
