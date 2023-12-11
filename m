Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E580D1BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbjLKQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbjLKQ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:29:16 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A9C10B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:29:20 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d3758fdd2eso44362587b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702312159; x=1702916959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSPGyUrN4GjfYDkEDWQ9RuHGcmWJXoW4tq+uyOT9lYQ=;
        b=Zu8UDPwJSapGPadQZucWc+ffyxSWsa7h/ZguD9XwSptExTOO/YDXdU7OEbIt2Vac67
         PyFvf7xWWa3zO6tQ5kZd3p1VP3J6SrV2MVSWmqh/LwQl3UmqGGj6JmxT0eub3tA/ERsu
         3kDQZ+6JH7po4/Wpy7WelgP/ds/a2Khy+NDRy2SDD2l3N/cZcvncPjpdyE0KAFVK4og2
         Wt+sYg1+cp0d5d7egzjzC54QbGyTOySMSlAuG9b99gBG4LLAtRUgvfimQfHdKbmuGKDI
         M3TH8fg9Ktzm9NEyKvfNq13gFzRqceUl/bPsAgrIflzc9FPFlPYPaqvK5whIIOmBBzr2
         ayCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312159; x=1702916959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSPGyUrN4GjfYDkEDWQ9RuHGcmWJXoW4tq+uyOT9lYQ=;
        b=Cw0qAscHmrtro+wBHS07OoydFJBV0Wat63q2RRbJhC6kq+qsHudCRYuUTHObT/YFMG
         bbzdOeOWYfQxPwJxl+evUyACx9p7unXqE2i+tPKYnv12DAUtAIT1/N1+dPvZcFTjaBw3
         AIHvNF3GTLc5CArLOug79MKsrCnmO69Q9p1vx4F3kH7TAXLlCIUSusqisNfs+D3enVJq
         krI7gJyIEI1mck7ZeQd3XlXM/WDM9BCLj1IZgaBscnqJu/LzDQ2uAESQmRFGQZ4Jk1MB
         uYAcR6rzpQ1Paf4+fFFpUu/aO8U2YYPTYCjEuZUYkCEiQCcYw6JbjQ2MoIPtrCv4483n
         xrGg==
X-Gm-Message-State: AOJu0Yzu1cfmvDTTnw01sCowwH9/9do6VIRF/4XHzw/SI1UuM685tb1V
        JAnT0GQoZq3DghWklrka4MAfjYCkwRTwEQ4Gz/Ffdw==
X-Google-Smtp-Source: AGHT+IEhILWoGMDAtGuNT9NWDVh05Lsk8AMNK0XY+S8xdfil2h/twfsZPK3dQs15HVmmLEysTUS2RYXmliuqhFPsf1k=
X-Received: by 2002:a81:4a84:0:b0:5d7:cfe5:a476 with SMTP id
 x126-20020a814a84000000b005d7cfe5a476mr3477164ywa.74.1702312159491; Mon, 11
 Dec 2023 08:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk> <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk> <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk> <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <9d06d7c1-24ae-4495-803d-5aec28058e68@sirena.org.uk>
In-Reply-To: <9d06d7c1-24ae-4495-803d-5aec28058e68@sirena.org.uk>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 11 Dec 2023 08:29:06 -0800
Message-ID: <CAJuCfpGEbGQh=VZbXtuOnvB6yyVJFjJ9bhwc7BaoL4wr1XLAfQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To:     Mark Brown <broonie@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 8:25=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Dec 11, 2023 at 08:15:11AM -0800, Suren Baghdasaryan wrote:
> > On Mon, Dec 11, 2023 at 4:24=E2=80=AFAM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > Oh, it's obviously the new headers not being installed.  The builds
> > > where I'm seeing the problem (my own and KernelCI's) are all fresh
> > > containers so there shouldn't be any stale headers lying around.
>
> > Ok, I was updating my headers and that's why I could not reproduce it.
> > David, should the test be modified to handle old linux headers
> > (disable the new tests #ifndef _UFFDIO_MOVE or some other way)?
>
> Are you sure we're not just missing an updated to the list of headers to
> copy (under include/uapi IIRC)?

Let me double check.

Just to rule out this possibility, linux-next was broken on Friday
(see https://lore.kernel.org/all/CAJuCfpFiEqRO4qkFZbUCmGZy-n_ucqgR5NeyvnwXq=
Yh+RU4C6w@mail.gmail.com/).
I just checked and it's fixed now. Could you confirm that with the
latest linux-next you still see the issue?
