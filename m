Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD037DDC3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347362AbjKAFSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjKAFSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:18:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0570ED;
        Tue, 31 Oct 2023 22:18:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991c786369cso1011489166b.1;
        Tue, 31 Oct 2023 22:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698815918; x=1699420718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8jpkMwCXqhfiGZN0qlr18CaGkiQXpOM96Yew3hJKrCw=;
        b=F74E3HomwoThAmdgtcmNNUrek0RIoVtBHMRRIhCZVj34w3/RClHkl9xn36/IThqq08
         fGa/eauwRhfEiX2b2EjB5WJMeyjp6dSKtWVbmIVEyEW5eP0h67yL/yexNTxNwD0mutpf
         vyyeYT6/Ep7Vm1mxKbda2LfmhKFT/2rZphHinOYh8c5yswgnMWYRnqplvBdbeKLtx+Ex
         co1p1ADyc9JEYcFzZggcjqmBVTVwzZQGqbxsSf7I57gwQEG3KCneBZQz0DhrsngBMzSb
         V08PLMULgTSMQh7uF/NPR4UtRkB8QUWNrpmSYN7GdYRnGO//6cJAYb6HJJ3BavU0XQGp
         W3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698815918; x=1699420718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jpkMwCXqhfiGZN0qlr18CaGkiQXpOM96Yew3hJKrCw=;
        b=JhgwurbcKodygqbGvXjubeFRSND4qjhRjUBr6uL/Rf6dWVPoCHn55dP2xcadPhKzm/
         pOB7YG1astqFWqMhEd/wWzt3kLJRNvk/qfhD7XOwFCzVaw56Y2pseDAAx8dpwkTul94Q
         c2prXi8bI8P5w7SJbM4FwdrM9U0ybu35hSygArqWd6G6b5hxzaWDskMOOYGoTJeiciCK
         78r3hK//HFwjrhMQCbJP8FouMBO6glFYaNysZSatwjQwoU/DlPvYF3J2dOMrXMz9ha9F
         orLLbAqe8Od+HP5mfrPZ5DEq1B+BnBaDnI/RnIiaDr7WOmsHmKC+8fwqxqN1l2yRY0RR
         jTsA==
X-Gm-Message-State: AOJu0YzpNcaQGX7dhYb28d/pUAC2ceU8ZSyIz1jPTznzj72TZdlox0IN
        g/4tdwIguwMU/LQKZmlU1ue3iBq4NBIJsvTaa9I=
X-Google-Smtp-Source: AGHT+IFOZm77gF15cdLthwaJNp3/RzBOfz1HO0z6blJPnT8d/NRXXF8t1UCwkQ6Bnw3iGduYX1BBMDC7hW/Hw126G/Y=
X-Received: by 2002:a17:907:9814:b0:9d5:9065:90aa with SMTP id
 ji20-20020a170907981400b009d5906590aamr920884ejc.76.1698815918029; Tue, 31
 Oct 2023 22:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <ZUF8bYTl5SBlbBBJ@debian> <20231031222455.mbhbhxiykq7dnuvl@moria.home.lan>
In-Reply-To: <20231031222455.mbhbhxiykq7dnuvl@moria.home.lan>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 1 Nov 2023 05:18:01 +0000
Message-ID: <CADVatmMc-ZjPj0oNEidG4JK+k6YZ7XXPmMCCuYe_fnJ83xV5pw@mail.gmail.com>
Subject: Re: mainline build failure due to 5cfd69775eb5 ("bcachefs: Array
 bounds fixes")
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 at 22:24, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Tue, Oct 31, 2023 at 10:15:09PM +0000, Sudip Mukherjee (Codethink) wrote:
> > Hi All,
> >
> > The latest mainline kernel branch fails to build arm64 allmodconfig
> > with a native build on an arm64 host with the error:
> >
> > In file included from fs/bcachefs/btree_io.c:11:
> > fs/bcachefs/btree_update_interior.h: In function 'want_new_bset':
> > fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0 is outside the bounds of an interior zero-length array 'struct bkey_packed[0]' [-Werror=zero-length-bounds]
> >   274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
> >       |                                    ^~~~~~~~~~~~~~~~~~~
> > In file included from fs/bcachefs/bcachefs.h:206,
> >                  from fs/bcachefs/btree_io.c:3:
> > fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing 'start'
> >  2344 |  struct bkey_packed start[0];
> >       |                     ^~~~~
> >
> > git bisect pointed to 5cfd69775eb5 ("bcachefs: Array bounds fixes").
> >
> > I will be happy to test any patch or provide any extra log if needed.
>
> Following patch should resolve everything:

Thanks, and I can confirm that fixes the build for me too on the arm hosts.

>
> -- >8 --
> From ad77f25f730ec9a0eb04be5adc591628654b85ae Mon Sep 17 00:00:00 2001
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Tue, 31 Oct 2023 18:05:22 -0400
> Subject: [PATCH] bcachefs: Fix build errors with gcc 10
>
> gcc 10 seems to complain about array bounds in situations where gcc 11
> does not - curious.
>
> This unfortunately requires adding some casts for now; we may
> investigate getting rid of our __u64 _data[] VLA in a future patch so
> that our start[0] members can be VLAs.
>
> Reported-by: John Stoffel <john@stoffel.org>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>


-- 
Regards
Sudip
