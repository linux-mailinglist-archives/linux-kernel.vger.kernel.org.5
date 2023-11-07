Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD84D7E4A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbjKGVHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjKGVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:07:44 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A211F;
        Tue,  7 Nov 2023 13:07:42 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so6391764276.0;
        Tue, 07 Nov 2023 13:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699391261; x=1699996061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aeXicRU4lHcbU3yR6buQ02C3rtZDXKLpVxEjoF0J04=;
        b=Hdazj6scuSKVJFr0hsDXNcWkK9eAZCiJl+M2ohu3IkmeJIIUlWzr0LklXjhHDVylU7
         sIyFHJJ43z0ycC4fExyejx6DYPBJFb0zDBBjQ5MarAfzCAsqLFoDrHVUe9JHqQfOQhEm
         WWKQHcYffK17k5ALqk3vBid0Od0Qg5IwsGOoBC/rfytHPl3oIyMlNWEKvdpaYmou85Ue
         P3EwZo9wMAIhUCH6UCBkrHfqu1Dp8zyTLPW3nZ6T/6T/5xpQdFg5UyCciqgfCVQp/eJg
         XbcsXgqbzc+S4t5lt6YaBxNaxkqOaOajo/Poi2INEvtch2WIF2zKtgzTTzdCP1jgSF2W
         cCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699391261; x=1699996061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aeXicRU4lHcbU3yR6buQ02C3rtZDXKLpVxEjoF0J04=;
        b=vzCxYqCVYTqDxHip4QkaeosJ0maDLAt8MQ9HLJCLQZ06ZPe//8jg+xrr5dWiIQgMI4
         ZVWz6jpt2QVfN09RjAjF3NJpc04XNLid9Fnb3/fcGMMVPndycTmxtD6XXmag680XHnAe
         Sqnx2N412m6MybmJWJYYCcAbbRdNiSC0+dFxlGVIzT65i65ytUm2qqgCy2YdskVMo0bF
         1HhYARNx0TV9z6W2AAv1EpZX3RbkogfUZazlUWTchRjKH8B1a7TxkFWRDAd0VR7c5zLM
         FKNpZJa+KjOiGGRiy+1P5K90vsUwXbGHZ9Y0GBEiL54tXm3DZsDspf6KIaVLwwGiBaoH
         TlxQ==
X-Gm-Message-State: AOJu0YyVpEUkMXczFQtJAFn4rhKY2yCPTiSlW7fdyvdMrYNNTZ7rWeLt
        8pCKsCItpaAFhXvow2oON6ne2pR+V5zjNPIkxfw=
X-Google-Smtp-Source: AGHT+IHBQNOhwgC6AxM8bJ1Gh1+f7qmlz8lu7XimL4LhQXXqoZ70t5a2uJdxqXFzjjss++G8Sfe494JrytOk+d+WafE=
X-Received: by 2002:a25:348b:0:b0:d9a:4f14:5bf9 with SMTP id
 b133-20020a25348b000000b00d9a4f145bf9mr615820yba.26.1699391261066; Tue, 07
 Nov 2023 13:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20231106065045.895874-1-amir73il@gmail.com> <CAHk-=whgCwcUGKvoZX0OSAFi9fTye3BOfOCY+wR=t7W8xS_oGQ@mail.gmail.com>
In-Reply-To: <CAHk-=whgCwcUGKvoZX0OSAFi9fTye3BOfOCY+wR=t7W8xS_oGQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Nov 2023 23:07:29 +0200
Message-ID: <CAOQ4uxhfanssN=GdxfC7ANG=it=VMJz549z0zZ5uEGULeGK6yA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 9:54=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 5 Nov 2023 at 22:50, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > - Overlayfs aio cleanups and fixes [1]
> >
> > - Overlayfs lock ordering changes [2]
> >
> > - Add support for nesting overlayfs private xattrs [3]
> >
> > - Add new mount options for appending lowerdirs [4]
> >
> > [1] https://lore.kernel.org/r/20230912173653.3317828-1-amir73il@gmail.c=
om/
> > [2] https://lore.kernel.org/r/20230816152334.924960-1-amir73il@gmail.co=
m/
> > [3] https://lore.kernel.org/r/cover.1694512044.git.alexl@redhat.com/
> > [4] https://lore.kernel.org/r/20231030120419.478228-1-amir73il@gmail.co=
m/
>
> *Please* don't make me have to follow links just to see basic details.
>

No problem.

> Merge messages should stand on their own, not just point to "look,
> here are the details in our lore archives". Yes, even when having
> internet access is much more common, there are situations where it's
> not there or is slow. Or maybe lore has issues. Or maybe people just
> don't want to switch to a browser to look up details that may or may
> not be relevant to them.
>
> I copied the relevant stuff into my merge, but please don't make me do
> this next time.

Thanks for adding this information - I certainly didn't intend for
you to do this extra work.

> Just give me a merge message with the details spelled
> out, not some link to a cover letter for a patch series.
>

OK.

To explain the reason why I add those links:

A while ago, I was helping out with backporting many xfs patches
to stable tree after a long period of neglection.

I found the need to point back from fix commits to patch series
because the cover letters often contained important information
relevant for backporting and testing.

So I hacked up a small b4 gadget to disassemble a PR
into lore links to patch series:
(*) you don't have to follow this link unless you are curious ;)
https://github.com/amir73il/b4/commit/f5966362a524182206d5c5e8a4f96fba5d4c9=
2ca

At the time, I had wished that the links to the patch series
composing the PR would have been in the PR email
(doesn't really matter if you take them into the merge commit).

This is why I included this "debug info" of the PR.
Next time, if I include the lore links, I will separate
them to a different section, so it is clear that I do not
require them to be in the merge commit.

Thanks,
Amir.
