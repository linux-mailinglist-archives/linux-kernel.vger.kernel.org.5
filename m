Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC397B33A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjI2NcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjI2NcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:32:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FA1A8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:32:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c6185cafb3so146805ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695994326; x=1696599126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JpAg8YM6jt9gQGG+DHvh+bx869pbDpnmhQOP9SC7Nw=;
        b=TUQGDGFfqWRdqjURtTlqua/uzeWTTSbzs5BzE8kC4qSAUwVjGWeVs0XmcVWsV8aMO4
         s8AuYC2HouZo8djiIwv1UKuwGnuT92XpMN9w03Hoo7hQdTWJCEu7zv32aYQ8kFP03tzX
         J4REkPtUNhBntnLeCWaBPX2VQ1xE7u72YhG90y3oUqpB8VZ27rMV9NFatp5twM2ri8So
         5nJfDYiZNo4Zbq/mFH3HxCP2JX2O+RNWKCn3l7B5ZjrqEMZvY13ZmStu4TrYaFh/FscC
         DQbXaf09MSOV/YbD4NwuBFID3CBh+1ZKiYQDh3ba6erCiaywJINP3eqxWAOkWjMGznlX
         29Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695994326; x=1696599126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JpAg8YM6jt9gQGG+DHvh+bx869pbDpnmhQOP9SC7Nw=;
        b=FVHXtCBKsPdqdhPQn1sSOJcM52+GDUsrQ1di8KL944dp83dAfbUr+BRb24ye+15Nar
         ub5b/8uFhyV1enY7E6A78/B5Ann1KKh7VmuoF6QGtsxHY3tX+c8HpT8HQ++LFwXJVqqG
         meNKtmkKa9AJmAspbhZTsa2DSBt+DENHOdQYTDuTGvEUUTYejRsAg4X6kAtF92PS7WRZ
         P8RKgxyyJLFO7lunWLEK5ceBAbiVWpAsCBqxOicM1HxxpYFH3eSBgVgNftzL+HVLtfMH
         cVC6PnWUNQEEz6IGyZkFtLahKfCAwb0cjgJsmc2AjiMmaRzmIpL+gDG/Fhw8n6PKiFEq
         hx/g==
X-Gm-Message-State: AOJu0YyfyIhQPJpn96aKwnrbic70EAk1O8rZnVy4ZjB1ia3VjfRzmA34
        iXNaGQQcwbgzPo9iqmepFxBHvpEAWy28KEsXNIZorg==
X-Google-Smtp-Source: AGHT+IEfhzvp05rZI2EgO+WsnPYuDpm0/VSkqYGTXKnIYq9egiHcW//IfFP64+pro82zETRfU1gyzt/v+EPtiP8TN/0=
X-Received: by 2002:a17:902:cec9:b0:1c5:dbc0:17e3 with SMTP id
 d9-20020a170902cec900b001c5dbc017e3mr988688plg.24.1695994326001; Fri, 29 Sep
 2023 06:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
 <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner> <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com> <20230929-kerzen-fachjargon-ca17177e9eeb@brauner>
In-Reply-To: <20230929-kerzen-fachjargon-ca17177e9eeb@brauner>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Sep 2023 15:31:29 +0200
Message-ID: <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:20=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> > But yes, that protection would be broken by SLAB_TYPESAFE_BY_RCU,
> > since then the "f_count is zero" is no longer a final thing.
>
> I've tried coming up with a patch that is simple enough so the pattern
> is easy to follow and then converting all places to rely on a pattern
> that combine lookup_fd_rcu() or similar with get_file_rcu(). The obvious
> thing is that we'll force a few places to now always acquire a reference
> when they don't really need one right now and that already may cause
> performance issues.

(Those places are probably used way less often than the hot
open/fget/close paths though.)

> We also can't fully get rid of plain get_file_rcu() uses itself because
> of users such as mm->exe_file. They don't go from one of the rcu fdtable
> lookup helpers to the struct file obviously. They rcu replace the file
> pointer in their struct ofc so we could change get_file_rcu() to take a
> struct file __rcu **f and then comparing that the passed in pointer
> hasn't changed before we managed to do atomic_long_inc_not_zero(). Which
> afaict should work for such cases.
>
> But overall we would introduce a fairly big and at the same time subtle
> semantic change. The idea is pretty neat and it was fun to do but I'm
> just not convinced we should do it given how ubiquitous struct file is
> used and now to make the semanics even more special by allowing
> refcounts.
>
> I've kept your original release_empty_file() proposal in vfs.misc which
> I think is a really nice change.
>
> Let me know if you all passionately disagree. ;)
