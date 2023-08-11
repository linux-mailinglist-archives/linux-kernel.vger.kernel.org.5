Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA377871D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHKFxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHKFxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:53:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABBD2706
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:53:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so226451166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691733225; x=1692338025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQWnzoDoyL9OA8op4B0emQIgXeKGA2NcTlOBONbgTOU=;
        b=DDEmtnAPDxZ92AY3RY6Yzena3BfhXP3IMBsHW9TRi8M8eBqVr5YqgDRAzmBOhBq+wI
         0mQABjRHXqiZcAaPMk4CbOxQ9yIAycK5VgQEqhvqu0LrtyU29LA372NvLGzvdjuKJ7Da
         oppfCVBGZ4TiWhWmmntGHPghvbE74O+PRPN9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691733225; x=1692338025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQWnzoDoyL9OA8op4B0emQIgXeKGA2NcTlOBONbgTOU=;
        b=F2vrGKc+NTxA4IsPcRNUtrTNQl38IkFDv9p1lpKT8PERq9pFkXqbd0gqQWaBClipkd
         fbsSAjzgulUfkEAqNQpw4BKQ9XA187PXjhDGrCcrLDx4+ToiWRW006C5EikDgBKmvi53
         zh4T1oI/dRbJ3YD2yKyQRK7Gn8KktNTUbCQipeq3ZVNogr1+ijT/rhmbbWCt8XxaZupa
         Ti9KGGsDxqJE2w214pIgQTbvroGosDfeqHNCwnZixLcgFaiqHSsoJ4aBOx8gH5e/YRds
         365bvk+G476943Hm68qx9+6eHa3Qz9Imd5Q7wcl2HVyRLUIPpzxvwvmcIpyUg8Q9fPGc
         +Tgw==
X-Gm-Message-State: AOJu0YwBS6RosPU+/FYSKT9xwLcHHceUpO9JhYaDlBbHNhk5694ACs2R
        z7A2LhDGSSz7QNLdyaom8xY7YE3wttb8Yd4V1+e0H4O9
X-Google-Smtp-Source: AGHT+IH25adpMEsjo2pFryyzJYdzWD1f6lft33VIImwUGRei2RcUmY9cFYlmQuxhPYpy8ycUD0OpAg==
X-Received: by 2002:a17:906:8457:b0:992:4250:545b with SMTP id e23-20020a170906845700b009924250545bmr808006ejy.47.1691733225151;
        Thu, 10 Aug 2023 22:53:45 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id f20-20020a1709064dd400b0099b6becb107sm1812831ejw.95.2023.08.10.22.53.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 22:53:45 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so1955874a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:53:44 -0700 (PDT)
X-Received: by 2002:a05:6402:395:b0:51d:87c6:bf28 with SMTP id
 o21-20020a056402039500b0051d87c6bf28mr810373edv.3.1691733224570; Thu, 10 Aug
 2023 22:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan> <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan> <20230810223942.GG11336@frogsfrogsfrogs>
 <CAHk-=wj8RuUosugVZk+iqCAq7x6rs=7C-9sUXcO2heu4dCuOVw@mail.gmail.com>
 <20230811040310.c3q6nml6ukwtw3j5@moria.home.lan> <CAHk-=whDuBPONoTMRQn2aX64uYTG5E3QaZ4abJStYRHFMMToyw@mail.gmail.com>
 <20230811052922.h74x6m5xinil6kxa@moria.home.lan>
In-Reply-To: <20230811052922.h74x6m5xinil6kxa@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 22:53:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ0xo2_aqVCoJHnO_AYP=cy1E8Pk5Vxb13+nFastAFEQ@mail.gmail.com>
Message-ID: <CAHk-=wiJ0xo2_aqVCoJHnO_AYP=cy1E8Pk5Vxb13+nFastAFEQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 22:29, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Thu, Aug 10, 2023 at 10:20:22PM -0700, Linus Torvalds wrote:
> > If it's purely "umount doesnt' succeed because the filesystem is still
> > busy with cleanups", then things are much better.
>
> That's exactly it. We have various tests that kill -9 fio and then
> umount, and umount spuriously fails.

Well, it sounds like Jens already has some handle on at least one
io_uring shutdown case that didn't wait for completion.

At the same time, a random -EBUSY is kind of an expected failure in
real life, since outside of strictly controlled environments you could
easily have just some entirely unrelated thing that just happens to
have looked at the filesystem when you tried to unmount it.

So any real-life use tends to use umount in a (limited) loop. It might
just make sense for the fsstress test scripts to do the same
regardless.

There's no actual good reason to think that -EBUSY is a hard error. It
very much can be transient.

In fact, I have this horrible flash-back memory to some auto-expiry
scripts that used to do the equivalent of "umount -a -t autofs" every
minute or so as a horrible model for expiring things, happy and secure
in the knowledge that if the filesystem was still in active use, it
would just fail.

So may I suggest that even if the immediate issue ends up being sorted
out, just from a robustness standpoint the "consider EBUSY a hard
error" seems to be a mistake.

Transient failures are pretty much expected, and not all of them are
necessarily kernel-related (ie think "concurrent updatedb run" or any
number of other possibilities).

          Linus
