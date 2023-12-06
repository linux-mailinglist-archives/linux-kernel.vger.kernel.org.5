Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8B8068E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377030AbjLFHpz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 02:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376953AbjLFHpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:45:41 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C78D59
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:45:46 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5cd81e76164so73157977b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 23:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848745; x=1702453545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Cle4fHqg4gCS8JBdXAO9v2hIfG4HtseTfjze5E2L0s=;
        b=kh3NKwjUw2So3Y3bpBE3LcrllyyauzO4bNsTU9GEvBv2nqQRto2U+3+1AN2C14qF7v
         Ht5xiAO+aNbqmSC8E2cnAiouOdkrYhaiKMNd7/fW6AGR6bzCbElSoyv1/PlX5SiVklRt
         H4bmBVkyO+392MAW5FgPyOWgdEYL61Khgtf6Pqqi1qcsunnp9sUZut65xzvKL9xqVhtH
         orbbsOE7qQL9qzty+TaG8VefqrOgcucgzr2lAKI4tawql4o64uNhD5vboiEVQqn2y8c4
         nit5B/RGaEalqe+nJWxjiWMAFZxK6PCcG4e2GfqHoQhomwoTWG+oZykcwXIaX8eHhBEu
         cT1w==
X-Gm-Message-State: AOJu0YxYETcAFpZeQ81d2nXNo8ZHFJKqrK1YcoPc5aFgpG7JbB1jtwlP
        RPxI0JXxH3BhNAHGEoLiDSTBR8Bqe2ZW+w==
X-Google-Smtp-Source: AGHT+IGTzH+L7vd9l5zp0i9Jrg42UTiwDaNgAInu2AiJKiwQdm5Hdpth2y/CcU90Onvx5TgrgOB/fw==
X-Received: by 2002:a81:d109:0:b0:5d7:1940:dd8d with SMTP id w9-20020a81d109000000b005d71940dd8dmr310198ywi.99.1701848745639;
        Tue, 05 Dec 2023 23:45:45 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id j128-20020a0de086000000b005cb1bf4d466sm4793700ywe.82.2023.12.05.23.45.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 23:45:43 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5cd81e76164so73157517b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 23:45:42 -0800 (PST)
X-Received: by 2002:a81:c80e:0:b0:5d7:486d:1472 with SMTP id
 n14-20020a81c80e000000b005d7486d1472mr306720ywi.19.1701848742512; Tue, 05 Dec
 2023 23:45:42 -0800 (PST)
MIME-Version: 1.0
References: <62f82b0308de05f5aab913392049af15d53c777d.1701804489.git.geert+renesas@glider.be>
 <7c353e1ba4025dfce4c4789033f5779c4371f048.camel@perches.com>
In-Reply-To: <7c353e1ba4025dfce4c4789033f5779c4371f048.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Dec 2023 08:45:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqASMMmLOjFerMncm2EjNn22GHr9_2oq=oPX91ar_sBA@mail.gmail.com>
Message-ID: <CAMuHMdUqASMMmLOjFerMncm2EjNn22GHr9_2oq=oPX91ar_sBA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Also accept commit ids with 13-40 chars of sha1
To:     Joe Perches <joe@perches.com>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Louis Peens <louis.peens@corigine.com>,
        Simon Horman <horms@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Dec 5, 2023 at 9:05 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2023-12-05 at 20:34 +0100, Geert Uytterhoeven wrote:
> > Documentation/dev-tools/checkpatch.rst says:
> >
> >   **GIT_COMMIT_ID**
> >     The proper way to reference a commit id is:
> >     commit <12+ chars of sha1> ("<title line>")
>
> It's not just checkpatch.
>
> Documentation/process/submitting-patches.rst:``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
>
>
> So that would need to be updated as well.

And:

Documentation/process/maintainer-tip.rst: - Fixes: 12char-SHA1
("sub/sys: Original subject line")

but the example uses 15:

Documentation/process/maintainer-tip.rst:     Fixes: abcdef012345678
("x86/xxx: Replace foo with bar")

Documentation/process/researcher-guidelines.rst:  Fixes:
aaaabbbbccccdddd ("Introduce support for FooBar")

16

Documentation/process/submitting-patches.rst:   Commit
e21d2170f36602ae2708 ("video: remove unnecessary

20

> And 12 still has quite some headroom.
>
> $ git rev-list --all --abbrev=0 --abbrev-commit | \
>   awk '{ a[length] += 1 } END { for (len in a) print len, a[len] }'
> 5 107
> 6 684276
> 7 505734
> 8 41769
> 9 2665
> 10 174
> 11 8

How many collisions do you need? These will be dereferenced years
from now.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
