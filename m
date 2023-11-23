Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220A57F5671
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjKWCbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344116AbjKWCbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:31:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B070DA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:31:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so382534a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700706661; x=1701311461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7iDnp8t+KdyeiUT7D88qTOqMxvRmmiP2r4q7q2VrCw=;
        b=m6oRr/ashOEGHxXSBYmK8cuDJfLqU1gwdiI4l++ERA9V/qRFW/RUUHRfnao1/iWRig
         0eSNo0H91+yAY3DyFGYbKh1tS3pCOyEzdR0h3D3KCiUfiqYmcD1aqgbwqKi8rookcZP1
         p4U5kwuM2He+Qh7YIxs03h+SkOS7I1gVUt5MqeJqJHrJ/S/LV8EtWsJmQlSAPksaNGTd
         bf8nF/hxEhg/ElUuwcFVxshvce5+YZx1G9UrRVrn5oxGWlLYMgNOA+rjKEyGzJj0Q/zg
         ZmnPhZoMS3LYDVHtNj3VYK+hhgzjln4LdnbA794xdBxPgp7UpacwhlhLHce0jD3JoSjL
         MOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700706661; x=1701311461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7iDnp8t+KdyeiUT7D88qTOqMxvRmmiP2r4q7q2VrCw=;
        b=KWRg6I2WO6DHok87GOllBY/nBTzu/22hBOwA0NrerVrUlpjeyJx6nmGH+EhIqX1/GG
         PpyvcjrMcjKWydSTYn256Y+gSTe1jSvZQTQYeo7RhguxbrKTG33T/fxkhEEZ0AZ0fS3S
         pTkgsUGwolNB7qo2Rqj0y1Xvj808+5AqCSjQdId5eK0DaRb+Q4VYk+G1CGhYM79fZStb
         JeL6rC1LsHtaSO/lHhyrKNulXn53e0qMrjoWN0bRZmO0W9umFkkqh6rcPixIpLCPgqSy
         D1dgHIAx/n+eY2L9+R40nKA82eM1ofwJ6XHfbyFxQEIXIyGKv+np2qTwrF+fgkHlFefx
         uPdg==
X-Gm-Message-State: AOJu0YyrfUK4KGMOQVqPY7BmhKSq8HSj9ctu3veNHKc0CeWdAs19X+um
        OPyTCDSz9hFrJtOBaB2nXknj4JgyCRPIg5aLA6o=
X-Google-Smtp-Source: AGHT+IGGFUweecO5epVQcB0JiJi7vITOIzmn9FsdMPNQTFuozzvhOm6PKx7gcT4Fo3Sa9N0+DlQ5wf+9MN5SXTQsCX8=
X-Received: by 2002:a17:90b:4d05:b0:280:c0:9d3f with SMTP id
 mw5-20020a17090b4d0500b0028000c09d3fmr4312829pjb.34.1700706661646; Wed, 22
 Nov 2023 18:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20231122231202.121277-1-andrey.konovalov@linux.dev> <CAB=+i9QFeQqSAhwY_BF-DZvZ9TL_rWz7nMOBhDWhXecamsn=dw@mail.gmail.com>
In-Reply-To: <CAB=+i9QFeQqSAhwY_BF-DZvZ9TL_rWz7nMOBhDWhXecamsn=dw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 23 Nov 2023 03:30:50 +0100
Message-ID: <CA+fCnZdp4+2u8a6mhj_SbdmfQ4dWsXBS8O2W3gygzkctekUivw@mail.gmail.com>
Subject: Re: [PATCH mm] slub, kasan: improve interaction of KASAN and
 slub_debug poisoning
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Thu, Nov 23, 2023 at 1:39=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> On Thu, Nov 23, 2023 at 8:12=E2=80=AFAM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > When both KASAN and slub_debug are enabled, when a free object is being
> > prepared in setup_object, slub_debug poisons the object data before KAS=
AN
> > initializes its per-object metadata.
> >
> > Right now, in setup_object, KASAN only initializes the alloc metadata,
> > which is always stored outside of the object. slub_debug is aware of
> > this and it skips poisoning and checking that memory area.
> >
> > However, with the following patch in this series, KASAN also starts
> > initializing its free medata in setup_object. As this metadata might be
> > stored within the object, this initialization might overwrite the
> > slub_debug poisoning. This leads to slub_debug reports.
> >
> > Thus, skip checking slub_debug poisoning of the object data area that
> > overlaps with the in-object KASAN free metadata.
> >
> > Also make slub_debug poisoning of tail kmalloc redzones more precise wh=
en
> > KASAN is enabled: slub_debug can still poison and check the tail kmallo=
c
> > allocation area that comes after the KASAN free metadata.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Thank you for looking at this quickly!
> Unfortunately the problem isn't fixed yet with the patch.
>
> I applied this on top of linux-next and built a kernel with the same conf=
ig,
> it is still stuck at boot.

Ah, this is caused by a buggy version of "kasan: improve free meta
storage in Generic KASAN", which made its way into linux-next.
Reverting that patch should fix the issue. My patch that you bisected
to exposes the buggy behavior.

Thanks!
