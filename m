Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49249803731
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbjLDOoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjLDOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:44:00 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E3C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:44:06 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4648719e89fso302065137.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701701045; x=1702305845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d4+JXVCVhdb1Zygd3rLX4nnbBbExNJhXr9mZGCCNqw=;
        b=uiwpBHzCczaIL2nIz9C289Zl+R0ix4qzpj0W4Xv0Z7lPqC3dPkbKRTYh6lTzZWr5TC
         nBUzfoorps7waIme0YSM3j0ReqkSoUKRzblPr/WhYDuSPzPoewRIfWYzHdJ/GGgJwGbF
         O0I03jo7PT68h6WU0ZpAdloRebiPBwwKwq+pE9iyE9KZFyNT/OoFQT3JgPU3EAxmrIyP
         CZM6TAmqOi0JO1yZoUlpv2GgPmeim2mqGNxcXhuub5FA5DkfjSgiNT6OVvlkl9ZvbMSX
         /cuK93SbHB2xVxA8LWBZ/yYfeypcDDj5ePgT9E2KtsVHzaJydf8mubA7unBaFe7sJhwv
         1uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701045; x=1702305845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6d4+JXVCVhdb1Zygd3rLX4nnbBbExNJhXr9mZGCCNqw=;
        b=HVEk1IAzNG8s5GFS1MLarXdgZy8SJMSiJ/x7VEIu2MW6AXnLYKrP3z3LAbmF5k1OTi
         dHuV1g9NzmL+jgruxlzm1vLG9+HDNrWEVhyGca8ceD62ulagVC99swXkP4vNhSf/FzbF
         GUgfjAS2SQ7nn+tBy1NvWf4+vpJMPy1RZ6ThPnWiXVYFQVvEb4kTUnp3BBStK2UG0jZ/
         9oYDJjb9/16ekD54uGq5cYmjdbp+jlg263ZVy/VVZ5ZL3b3PAtRrm1FWuX6HoXLbuUn2
         G0sOmGuZAcJzGLX2TNxHeS+ZzUNWwH2j5X3V2MljSBKAbicJHnSAFooT+3NgBKci4h9e
         7mPg==
X-Gm-Message-State: AOJu0YwARFWEWlWXpDokyw0l/Bwlch5CD0osyeb9ai5bCOStle2AUiH2
        J72CXp6BwPKToyuaMA/35XEvEG9i1TZ4MRCF7TmpQw==
X-Google-Smtp-Source: AGHT+IFwMAXry+y7YI/Fa6KO7ofpOINkTjnlQziOPpHManWP15EhWK8Z1xWaBW7eSRV+bGv9fDV8zeCvTuGd79rptkM=
X-Received: by 2002:a67:ce1a:0:b0:464:a0c6:43fe with SMTP id
 s26-20020a67ce1a000000b00464a0c643femr152986vsl.16.1701701045262; Mon, 04 Dec
 2023 06:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20231201172212.1813387-24-cmllamas@google.com>
 <20231204115727.42370-1-aliceryhl@google.com> <ZW3kjj6KC73zpnw4@google.com>
In-Reply-To: <ZW3kjj6KC73zpnw4@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 4 Dec 2023 15:43:54 +0100
Message-ID: <CAH5fLgjmN4xYHZc=ZVdwOMMTEk4PwXwnqvXWSJrE1J-2xaKL7g@mail.gmail.com>
Subject: Re: [PATCH v2 23/28] binder: document the final page calculation
To:     Carlos Llamas <cmllamas@google.com>
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 3:39=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Mon, Dec 04, 2023 at 11:57:27AM +0000, Alice Ryhl wrote:
> > > The code to determine the page range for binder_lru_freelist_del() is
> > > quite obscure. It leverages the buffer_size calculated before doing a=
n
> > > oversized buffer split. This is used to figure out if the last page i=
s
> > > being shared with another active buffer. If so, the page gets trimmed
> > > out of the range as it has been previously removed from the freelist.
> > >
> > > This would be equivalent to getting the start page of the next in-use
> > > buffer explicitly. However, the code for this is much larger as we ca=
n
> > > see in binder_free_buf_locked() routine. Instead, lets settle on
> > > documenting the tricky step and using better names for now.
> > >
> > > I believe an ideal solution would be to count the binder_page->users =
to
> > > determine when a page should be added or removed from the freelist.
> > > However, this is a much bigger change than what I'm willing to risk a=
t
> > > this time.
> > >
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> >
> > Yes, this does help somewhat.
> >
> > However, `curr_last_page` is actually not the last page. It's the last
> > page plus one, since `binder_lru_freelist_del` is exclusive on this
> > argument. Maybe rename it to `curr_after_last_page` or something like
> > that? Or maybe even just `curr_last_page_plus_one`.
>
> hmmm, I don't know. I think this could be more confusing, the plus-one
> is only because of the way that binder_lru_freelist_del() processes the
> final page. So you could interpret the name both ways. Do we _really_
> need the extra comments to make it clear?
>
> This solution is too complex anyway, it should really be replaced with a
> binder_page->nr_users to determine when to add/remove from the lru.

You could also just remove the `next_used_page` part entirely. This
means that you will sometimes call `binder_lru_freelist_del` on a page
that's in use, but that's just a no-op.

Alice
