Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08E7E49D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjKGUbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbjKGUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:30:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C68010D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:30:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so10346242a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699389054; x=1699993854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw7CS/F9NhUtUI8gorhN6ZH3SNhxyTq9HRKbQWVFK2s=;
        b=JPzMHTYKNlRlBSaW3zZcZMo0zD1RFv6Q8pGUFri7rSBnoSuR59HP/GkuPDC/4604M7
         f6x03HdmRekcTeQxlg4D6e5Z0lxH/BD8P/Mq+67sWIS4eD2/ZRqLA7djBmbFS9HCI2/F
         gp1td6+TG8jkhboGpoKkj7IBbWAepYAhCjUbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389054; x=1699993854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw7CS/F9NhUtUI8gorhN6ZH3SNhxyTq9HRKbQWVFK2s=;
        b=LBKt6ApZSVbHInk6OQhf+2FM/RHD9uVxrSaCvQK0MeokXIYNW8Pzg5hkZvKdlxU9Fj
         FQ3yQZfDVBbgu5zCYzHakiwf43WX/stWgkdkkToQUU1TWcrz6wNpqtvgRnlTAjYHRL9v
         3/8E51hB9zu5pKBzF4dd3GdtTyebUbzstDX2qSU5XDi6uEGBQBn+Om8XHBaVWnyfTLQZ
         OU0NdsHjpBDbNf+UNpXBPRcJnI0AH6Z4FYEQtDhxx8V7jR8glwUFtwtMpQKbpenfYogm
         7kBqyqQ56XAHzOVSjcPtswZwMjjAXflYnmp1tNv31M6sOALRXzV1y9oYO9boWEzhlgd4
         YhMg==
X-Gm-Message-State: AOJu0Yymt4KbLmcBLTKnNv3kfqZvleHONYrjTelkyhgUkP7yiO+ZroLi
        LedTkDNDeqoAtCe37G4fOvuXERiS9H6YOi8RWMNiGA==
X-Google-Smtp-Source: AGHT+IGqeRfo8g/GTdhi1iIImokcOWRX4Qrj5oal+JAXOFJaamOf2ifPQcEka49nonWq9fvX3FE/pw==
X-Received: by 2002:a17:906:7310:b0:9d2:44e9:7670 with SMTP id di16-20020a170906731000b009d244e97670mr19219141ejc.19.1699389054260;
        Tue, 07 Nov 2023 12:30:54 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090624c800b009aa292a2df2sm1432420ejb.217.2023.11.07.12.30.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 12:30:53 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso10359284a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:30:53 -0800 (PST)
X-Received: by 2002:a17:906:51ce:b0:9bd:a5a3:3328 with SMTP id
 v14-20020a17090651ce00b009bda5a33328mr15423134ejk.13.1699389053151; Tue, 07
 Nov 2023 12:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20231107142154.613991-1-agruenba@redhat.com>
In-Reply-To: <20231107142154.613991-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Nov 2023 12:30:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
Message-ID: <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 06:22, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> please consider pulling the following gfs2 fixes.

You are officially on my shit-list for

 (a) claiming it's fixes

 (b) apparently lying about that fact to make it appear that it's ok
that this wasn't in linux-next and was committed within the last few
days

about half of the commits in that pull request are very recent,
weren't in linux-next when the merge window started, and while a
couple of of them are fixes, most of them are just minor cleanups.

DON'T LIE ABOUT THINGS. It only annoys the hell out of me when I
notice that somebody was trying to pull wool over my eyes.

I've pulled this and I'll let it be (because I already merged other
stuff on top), but dammit, just be honest about what happened, don't
try to claim this is somehow "fixes" and thus ok to not have gone
through linux-next.

Or, better yet, get your ducks actually lined up before the merge window.

                        Linus
