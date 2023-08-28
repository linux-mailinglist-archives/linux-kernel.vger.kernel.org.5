Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E5A78B581
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjH1Qmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjH1QmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:42:08 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D412F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:42:05 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-79dc53034a8so1067431241.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693240924; x=1693845724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gA6YgxNWy5uRYOQN4TtQSLMyAxYieksPe9778u218A=;
        b=HEfl3OgG6aXAOtDXEpKNEy6DWPGtiNxkWBwICsIXxddFHyB9sK802V0hQv4eSqzoHK
         /dRNqs+KEIgzLK48fafHPPtBA0W1QHaM/lCyLqxAF5d+gn0i+uHI/CcP9bK35JV/oIUE
         H7/LXy3x5SKq9TXzLLczpEEND8HYc8kIU2TCrwideLfJeA1EtdxBuiRRBzX6gbJh09tt
         A4Zoi3Y6rTck1YZQ2spOgOye9H6RjUuGV+FSgl/PTYBq/qV2pB5Vg6ut4B+ofVQN5+eX
         WBsIrx8WP4gRYvF7jOJF8kQdpjZ7iLKsyoc5IpvcBR/TxkWhDmT2kioX/tHkrjbGrvPV
         rLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693240924; x=1693845724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gA6YgxNWy5uRYOQN4TtQSLMyAxYieksPe9778u218A=;
        b=iH42qdRP8VzN0DS2nO/7Rux6m/NkUCETHTYUgeJDqiLBD94yjo0Wol7DJPfKNTt9lq
         Gwa8Wp/ccIeBxroWE1MpvMulqL7MkuyABj7hyLjMomgqExLxs1L7tYGNcYOltM6lgfdN
         qOXtXDGWZyfrAi0Co5PySTCLeBFt6xB/T90r5tnBH2Q1yKG6ko50FanyXBGSkWjSw48u
         bofkcUDa8241hCRSZJlhQGlARvHuyZPoMEkEI7m1DLLQFLwWwlLDIplsMKNOgfL0Rby/
         edrX3oHpEoRR/jXjNpyyVsxVWZJwjicjFJIZczfOcNmEpQCfV1H8mmrgQwWlGUmg8MC+
         +DJQ==
X-Gm-Message-State: AOJu0Yy8IBdJV50dKGrR1bwd1EA3JIP7jHnpDTK0T0CHpKeLT7fyvLe/
        lMdTyxV8mfC3IG8Zjw7q74Tij0S3c7RiXR6RDIoBdd4m0bD1NA==
X-Google-Smtp-Source: AGHT+IEwm5sl1qZx9okPaSBJa20L4UCW0eWE6xkuS90QsGmIawfrN8WS1W+0Ge4LQLrJFP5ZVmuNDylFvn0WkPYYNMQ=
X-Received: by 2002:a67:f8d5:0:b0:44e:9a71:27a1 with SMTP id
 c21-20020a67f8d5000000b0044e9a7127a1mr7476559vsp.17.1693240924528; Mon, 28
 Aug 2023 09:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
 <ZOy3+8qKfQxyrWez@duo.ucw.cz>
In-Reply-To: <ZOy3+8qKfQxyrWez@duo.ucw.cz>
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Mon, 28 Aug 2023 09:41:53 -0700
Message-ID: <CA+jjjYSrvbU-5Pkvmxi+e6_4q4MMRWAQHUf-U37PO24oeO-3VA@mail.gmail.com>
Subject: Re: System Call trashing registers
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Aug 28, 2023 at 8:06=E2=80=AFAM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > 1) A lot of my old 32-bit programs don't work on x64 linux anymore
> > because int 80h now trashes ecx and edx. This hasn't been a serious
> > problem for me.
> >
>
> I guess you should cc x86 maintainers?
>
> I guess this is a regression? When did it start?
>
> BR,
>                                                                 Pavel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.

It started when the openat() syscall was added. It got fixed a few times.
I suspect it stayed fixed on an actual x86 kernel but the x86_64 kernel
still exhibits it being broken. But I don't run an x86 kernel anymore for
the obvious reason.

Source code can be found here. The project effectively died with
floppy disks so last release in 2006 is about right.

https://asm.sourceforge.net/asmutils.html

But if I try the couple of tools that still have real value, they just
segfault.

Remaining useful tools: tr, httpd, chmod, mv, ln
